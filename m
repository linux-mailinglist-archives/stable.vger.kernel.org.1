Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DD875CDC4
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjGUQOl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjGUQO0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:14:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166313A93
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:13:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A700D61D14
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:13:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E0FC433C8;
        Fri, 21 Jul 2023 16:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956033;
        bh=ewfIobcUYs4//WfZGPH7fDRGHuMKLOIAehwZ/QtgijM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uXfg5uJV2OHCfOgG5YdVRP4hQNQWiTKiCO0aGUI1bxJhikecukPj7IF9gS8L6wTq7
         9ixjjw/7T2N61KitJRWq5cMz/yx/+6coF+kRyk6QysPxYg5rY2cJZgOZrvPFMK9+NU
         7jJIbApA7ChU2duLQkcsJgo14nJsuBW8AZQ16KXk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Paulo Alcantara (SUSE)" <pc@manguebit.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.4 110/292] smb: client: fix parsing of source mount option
Date:   Fri, 21 Jul 2023 18:03:39 +0200
Message-ID: <20230721160533.540363311@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Paulo Alcantara <pc@manguebit.com>

commit 49024ec8795ed2bd7217c249ef50a70c4e25d662 upstream.

Handle trailing and leading separators when parsing UNC and prefix
paths in smb3_parse_devname().  Then, store the sanitised paths in
smb3_fs_context::source.

This fixes the following cases

$ mount //srv/share// /mnt/1 -o ...
$ cat /mnt/1/d0/f0
cat: /mnt/1/d0/f0: Invalid argument

The -EINVAL was returned because the client sent SMB2_CREATE "\\d0\f0"
rather than SMB2_CREATE "\d0\f0".

$ mount //srv//share /mnt/1 -o ...
mount: Invalid argument

The -EINVAL was returned correctly although the client only realised
it after sending a couple of bad requests rather than bailing out
earlier when parsing mount options.

Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Cc: stable@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/cifs_dfs_ref.c |   20 ++++++++++----
 fs/smb/client/cifsproto.h    |    2 +
 fs/smb/client/dfs.c          |   38 ++-------------------------
 fs/smb/client/fs_context.c   |   59 ++++++++++++++++++++++++++++++++++++-------
 fs/smb/client/misc.c         |   17 ++++++++----
 5 files changed, 80 insertions(+), 56 deletions(-)

--- a/fs/smb/client/cifs_dfs_ref.c
+++ b/fs/smb/client/cifs_dfs_ref.c
@@ -118,12 +118,12 @@ cifs_build_devname(char *nodename, const
 	return dev;
 }
 
-static int set_dest_addr(struct smb3_fs_context *ctx, const char *full_path)
+static int set_dest_addr(struct smb3_fs_context *ctx)
 {
 	struct sockaddr *addr = (struct sockaddr *)&ctx->dstaddr;
 	int rc;
 
-	rc = dns_resolve_server_name_to_ip(full_path, addr, NULL);
+	rc = dns_resolve_server_name_to_ip(ctx->source, addr, NULL);
 	if (!rc)
 		cifs_set_port(addr, ctx->port);
 	return rc;
@@ -171,10 +171,9 @@ static struct vfsmount *cifs_dfs_do_auto
 		mnt = ERR_CAST(full_path);
 		goto out;
 	}
-	cifs_dbg(FYI, "%s: full_path: %s\n", __func__, full_path);
 
 	tmp = *cur_ctx;
-	tmp.source = full_path;
+	tmp.source = NULL;
 	tmp.leaf_fullpath = NULL;
 	tmp.UNC = tmp.prepath = NULL;
 	tmp.dfs_root_ses = NULL;
@@ -185,13 +184,22 @@ static struct vfsmount *cifs_dfs_do_auto
 		goto out;
 	}
 
-	rc = set_dest_addr(ctx, full_path);
+	rc = smb3_parse_devname(full_path, ctx);
 	if (rc) {
 		mnt = ERR_PTR(rc);
 		goto out;
 	}
 
-	rc = smb3_parse_devname(full_path, ctx);
+	ctx->source = smb3_fs_context_fullpath(ctx, '/');
+	if (IS_ERR(ctx->source)) {
+		mnt = ERR_CAST(ctx->source);
+		ctx->source = NULL;
+		goto out;
+	}
+	cifs_dbg(FYI, "%s: ctx: source=%s UNC=%s prepath=%s dstaddr=%pISpc\n",
+		 __func__, ctx->source, ctx->UNC, ctx->prepath, &ctx->dstaddr);
+
+	rc = set_dest_addr(ctx);
 	if (!rc)
 		mnt = fc_mount(fc);
 	else
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -85,6 +85,8 @@ extern void release_mid(struct mid_q_ent
 extern void cifs_wake_up_task(struct mid_q_entry *mid);
 extern int cifs_handle_standard(struct TCP_Server_Info *server,
 				struct mid_q_entry *mid);
+extern char *smb3_fs_context_fullpath(const struct smb3_fs_context *ctx,
+				      char dirsep);
 extern int smb3_parse_devname(const char *devname, struct smb3_fs_context *ctx);
 extern int smb3_parse_opt(const char *options, const char *key, char **val);
 extern int cifs_ipaddr_cmp(struct sockaddr *srcaddr, struct sockaddr *rhs);
--- a/fs/smb/client/dfs.c
+++ b/fs/smb/client/dfs.c
@@ -54,39 +54,6 @@ out:
 	return rc;
 }
 
-/*
- * cifs_build_path_to_root returns full path to root when we do not have an
- * existing connection (tcon)
- */
-static char *build_unc_path_to_root(const struct smb3_fs_context *ctx,
-				    const struct cifs_sb_info *cifs_sb, bool useppath)
-{
-	char *full_path, *pos;
-	unsigned int pplen = useppath && ctx->prepath ? strlen(ctx->prepath) + 1 : 0;
-	unsigned int unc_len = strnlen(ctx->UNC, MAX_TREE_SIZE + 1);
-
-	if (unc_len > MAX_TREE_SIZE)
-		return ERR_PTR(-EINVAL);
-
-	full_path = kmalloc(unc_len + pplen + 1, GFP_KERNEL);
-	if (full_path == NULL)
-		return ERR_PTR(-ENOMEM);
-
-	memcpy(full_path, ctx->UNC, unc_len);
-	pos = full_path + unc_len;
-
-	if (pplen) {
-		*pos = CIFS_DIR_SEP(cifs_sb);
-		memcpy(pos + 1, ctx->prepath, pplen);
-		pos += pplen;
-	}
-
-	*pos = '\0'; /* add trailing null */
-	convert_delimiter(full_path, CIFS_DIR_SEP(cifs_sb));
-	cifs_dbg(FYI, "%s: full_path=%s\n", __func__, full_path);
-	return full_path;
-}
-
 static int get_session(struct cifs_mount_ctx *mnt_ctx, const char *full_path)
 {
 	struct smb3_fs_context *ctx = mnt_ctx->fs_ctx;
@@ -179,6 +146,7 @@ static int __dfs_mount_share(struct cifs
 	struct TCP_Server_Info *server;
 	struct cifs_tcon *tcon;
 	char *origin_fullpath = NULL;
+	char sep = CIFS_DIR_SEP(cifs_sb);
 	int num_links = 0;
 	int rc;
 
@@ -186,7 +154,7 @@ static int __dfs_mount_share(struct cifs
 	if (IS_ERR(ref_path))
 		return PTR_ERR(ref_path);
 
-	full_path = build_unc_path_to_root(ctx, cifs_sb, true);
+	full_path = smb3_fs_context_fullpath(ctx, sep);
 	if (IS_ERR(full_path)) {
 		rc = PTR_ERR(full_path);
 		full_path = NULL;
@@ -228,7 +196,7 @@ static int __dfs_mount_share(struct cifs
 				kfree(full_path);
 				ref_path = full_path = NULL;
 
-				full_path = build_unc_path_to_root(ctx, cifs_sb, true);
+				full_path = smb3_fs_context_fullpath(ctx, sep);
 				if (IS_ERR(full_path)) {
 					rc = PTR_ERR(full_path);
 					full_path = NULL;
--- a/fs/smb/client/fs_context.c
+++ b/fs/smb/client/fs_context.c
@@ -441,14 +441,17 @@ out:
  * but there are some bugs that prevent rename from working if there are
  * multiple delimiters.
  *
- * Returns a sanitized duplicate of @path. @gfp indicates the GFP_* flags
- * for kstrdup.
+ * Return a sanitized duplicate of @path or NULL for empty prefix paths.
+ * Otherwise, return ERR_PTR.
+ *
+ * @gfp indicates the GFP_* flags for kstrdup.
  * The caller is responsible for freeing the original.
  */
 #define IS_DELIM(c) ((c) == '/' || (c) == '\\')
 char *cifs_sanitize_prepath(char *prepath, gfp_t gfp)
 {
 	char *cursor1 = prepath, *cursor2 = prepath;
+	char *s;
 
 	/* skip all prepended delimiters */
 	while (IS_DELIM(*cursor1))
@@ -469,8 +472,39 @@ char *cifs_sanitize_prepath(char *prepat
 	if (IS_DELIM(*(cursor2 - 1)))
 		cursor2--;
 
-	*(cursor2) = '\0';
-	return kstrdup(prepath, gfp);
+	*cursor2 = '\0';
+	if (!*prepath)
+		return NULL;
+	s = kstrdup(prepath, gfp);
+	if (!s)
+		return ERR_PTR(-ENOMEM);
+	return s;
+}
+
+/*
+ * Return full path based on the values of @ctx->{UNC,prepath}.
+ *
+ * It is assumed that both values were already parsed by smb3_parse_devname().
+ */
+char *smb3_fs_context_fullpath(const struct smb3_fs_context *ctx, char dirsep)
+{
+	size_t ulen, plen;
+	char *s;
+
+	ulen = strlen(ctx->UNC);
+	plen = ctx->prepath ? strlen(ctx->prepath) + 1 : 0;
+
+	s = kmalloc(ulen + plen + 1, GFP_KERNEL);
+	if (!s)
+		return ERR_PTR(-ENOMEM);
+	memcpy(s, ctx->UNC, ulen);
+	if (plen) {
+		s[ulen] = dirsep;
+		memcpy(s + ulen + 1, ctx->prepath, plen);
+	}
+	s[ulen + plen] = '\0';
+	convert_delimiter(s, dirsep);
+	return s;
 }
 
 /*
@@ -484,6 +518,7 @@ smb3_parse_devname(const char *devname,
 	char *pos;
 	const char *delims = "/\\";
 	size_t len;
+	int rc;
 
 	if (unlikely(!devname || !*devname)) {
 		cifs_dbg(VFS, "Device name not specified\n");
@@ -511,6 +546,8 @@ smb3_parse_devname(const char *devname,
 
 	/* now go until next delimiter or end of string */
 	len = strcspn(pos, delims);
+	if (!len)
+		return -EINVAL;
 
 	/* move "pos" up to delimiter or NULL */
 	pos += len;
@@ -533,8 +570,11 @@ smb3_parse_devname(const char *devname,
 		return 0;
 
 	ctx->prepath = cifs_sanitize_prepath(pos, GFP_KERNEL);
-	if (!ctx->prepath)
-		return -ENOMEM;
+	if (IS_ERR(ctx->prepath)) {
+		rc = PTR_ERR(ctx->prepath);
+		ctx->prepath = NULL;
+		return rc;
+	}
 
 	return 0;
 }
@@ -1146,12 +1186,13 @@ static int smb3_fs_context_parse_param(s
 			cifs_errorf(fc, "Unknown error parsing devname\n");
 			goto cifs_parse_mount_err;
 		}
-		ctx->source = kstrdup(param->string, GFP_KERNEL);
-		if (ctx->source == NULL) {
+		ctx->source = smb3_fs_context_fullpath(ctx, '/');
+		if (IS_ERR(ctx->source)) {
+			ctx->source = NULL;
 			cifs_errorf(fc, "OOM when copying UNC string\n");
 			goto cifs_parse_mount_err;
 		}
-		fc->source = kstrdup(param->string, GFP_KERNEL);
+		fc->source = kstrdup(ctx->source, GFP_KERNEL);
 		if (fc->source == NULL) {
 			cifs_errorf(fc, "OOM when copying UNC string\n");
 			goto cifs_parse_mount_err;
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -1211,16 +1211,21 @@ int match_target_ip(struct TCP_Server_In
 
 int cifs_update_super_prepath(struct cifs_sb_info *cifs_sb, char *prefix)
 {
+	int rc;
+
 	kfree(cifs_sb->prepath);
+	cifs_sb->prepath = NULL;
 
 	if (prefix && *prefix) {
 		cifs_sb->prepath = cifs_sanitize_prepath(prefix, GFP_ATOMIC);
-		if (!cifs_sb->prepath)
-			return -ENOMEM;
-
-		convert_delimiter(cifs_sb->prepath, CIFS_DIR_SEP(cifs_sb));
-	} else
-		cifs_sb->prepath = NULL;
+		if (IS_ERR(cifs_sb->prepath)) {
+			rc = PTR_ERR(cifs_sb->prepath);
+			cifs_sb->prepath = NULL;
+			return rc;
+		}
+		if (cifs_sb->prepath)
+			convert_delimiter(cifs_sb->prepath, CIFS_DIR_SEP(cifs_sb));
+	}
 
 	cifs_sb->mnt_cifs_flags |= CIFS_MOUNT_USE_PREFIX_PATH;
 	return 0;


