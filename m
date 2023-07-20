Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34C775B605
	for <lists+stable@lfdr.de>; Thu, 20 Jul 2023 20:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjGTSAF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 20 Jul 2023 14:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjGTSAE (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 20 Jul 2023 14:00:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE08270A
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 11:00:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCCDE61BAD
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 18:00:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA723C433C8;
        Thu, 20 Jul 2023 18:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689876002;
        bh=9eXlFbhG7IMI59pm82S1u47AlwwAlva3pzfaLIOX5vw=;
        h=Subject:To:Cc:From:Date:From;
        b=QV1+iITO96FzhIvituxCBpHFApx7X494ooGO9cRJ17rignx3PXJf/qyc0LBE75dSp
         taWxSSPxZozYDfTp+AguEuUCjYCnNhARjjZn4mYkbAh2roybKbRT7HEBO8FG2WhAv0
         IXxfbaDZb1kGG6pl14S2con4ryC/k6GR+gfghM3Q=
Subject: FAILED: patch "[PATCH] smb: client: fix parsing of source mount option" failed to apply to 6.1-stable tree
To:     pc@manguebit.com, stfrench@microsoft.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Thu, 20 Jul 2023 19:59:59 +0200
Message-ID: <2023072059-spinout-subway-2ec1@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 49024ec8795ed2bd7217c249ef50a70c4e25d662
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072059-spinout-subway-2ec1@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

49024ec8795e ("smb: client: fix parsing of source mount option")
38c8a9a52082 ("smb: move client and server files to common directory fs/smb")
d5a863a153e9 ("cifs: avoid dup prefix path in dfs_get_automount_devname()")
d19342c6609b ("cifs: sanitize paths in cifs_update_super_prepath.")
7e0e76d99079 ("smb3: lower default deferred close timeout to address perf regression")
7ad54b98fc1f ("cifs: use origin fullpath for automounts")
a1c0d00572fc ("cifs: share dfs connections and supers")
a73a26d97eca ("cifs: split out ses and tcon retrieval from mount_get_conns()")
2301bc103ac4 ("cifs: remove unused smb3_fs_context::mount_options")
abdb1742a312 ("cifs: get rid of mount options string parsing")
9fd29a5bae6e ("cifs: use fs_context for automounts")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 49024ec8795ed2bd7217c249ef50a70c4e25d662 Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.com>
Date: Tue, 27 Jun 2023 21:24:47 -0300
Subject: [PATCH] smb: client: fix parsing of source mount option

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

diff --git a/fs/smb/client/cifs_dfs_ref.c b/fs/smb/client/cifs_dfs_ref.c
index 0329a907bdfe..b1c2499b1c3b 100644
--- a/fs/smb/client/cifs_dfs_ref.c
+++ b/fs/smb/client/cifs_dfs_ref.c
@@ -118,12 +118,12 @@ cifs_build_devname(char *nodename, const char *prepath)
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
@@ -171,10 +171,9 @@ static struct vfsmount *cifs_dfs_do_automount(struct path *path)
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
@@ -185,13 +184,22 @@ static struct vfsmount *cifs_dfs_do_automount(struct path *path)
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
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index d127aded2f28..293c54867d94 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -85,6 +85,8 @@ extern void release_mid(struct mid_q_entry *mid);
 extern void cifs_wake_up_task(struct mid_q_entry *mid);
 extern int cifs_handle_standard(struct TCP_Server_Info *server,
 				struct mid_q_entry *mid);
+extern char *smb3_fs_context_fullpath(const struct smb3_fs_context *ctx,
+				      char dirsep);
 extern int smb3_parse_devname(const char *devname, struct smb3_fs_context *ctx);
 extern int smb3_parse_opt(const char *options, const char *key, char **val);
 extern int cifs_ipaddr_cmp(struct sockaddr *srcaddr, struct sockaddr *rhs);
diff --git a/fs/smb/client/dfs.c b/fs/smb/client/dfs.c
index 2390b2fedd6a..d741f396c527 100644
--- a/fs/smb/client/dfs.c
+++ b/fs/smb/client/dfs.c
@@ -54,39 +54,6 @@ int dfs_parse_target_referral(const char *full_path, const struct dfs_info3_para
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
@@ -179,6 +146,7 @@ static int __dfs_mount_share(struct cifs_mount_ctx *mnt_ctx)
 	struct TCP_Server_Info *server;
 	struct cifs_tcon *tcon;
 	char *origin_fullpath = NULL;
+	char sep = CIFS_DIR_SEP(cifs_sb);
 	int num_links = 0;
 	int rc;
 
@@ -186,7 +154,7 @@ static int __dfs_mount_share(struct cifs_mount_ctx *mnt_ctx)
 	if (IS_ERR(ref_path))
 		return PTR_ERR(ref_path);
 
-	full_path = build_unc_path_to_root(ctx, cifs_sb, true);
+	full_path = smb3_fs_context_fullpath(ctx, sep);
 	if (IS_ERR(full_path)) {
 		rc = PTR_ERR(full_path);
 		full_path = NULL;
@@ -228,7 +196,7 @@ static int __dfs_mount_share(struct cifs_mount_ctx *mnt_ctx)
 				kfree(full_path);
 				ref_path = full_path = NULL;
 
-				full_path = build_unc_path_to_root(ctx, cifs_sb, true);
+				full_path = smb3_fs_context_fullpath(ctx, sep);
 				if (IS_ERR(full_path)) {
 					rc = PTR_ERR(full_path);
 					full_path = NULL;
diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
index 1bda75609b64..4946a0c59600 100644
--- a/fs/smb/client/fs_context.c
+++ b/fs/smb/client/fs_context.c
@@ -441,14 +441,17 @@ int smb3_parse_opt(const char *options, const char *key, char **val)
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
@@ -469,8 +472,39 @@ char *cifs_sanitize_prepath(char *prepath, gfp_t gfp)
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
@@ -484,6 +518,7 @@ smb3_parse_devname(const char *devname, struct smb3_fs_context *ctx)
 	char *pos;
 	const char *delims = "/\\";
 	size_t len;
+	int rc;
 
 	if (unlikely(!devname || !*devname)) {
 		cifs_dbg(VFS, "Device name not specified\n");
@@ -511,6 +546,8 @@ smb3_parse_devname(const char *devname, struct smb3_fs_context *ctx)
 
 	/* now go until next delimiter or end of string */
 	len = strcspn(pos, delims);
+	if (!len)
+		return -EINVAL;
 
 	/* move "pos" up to delimiter or NULL */
 	pos += len;
@@ -533,8 +570,11 @@ smb3_parse_devname(const char *devname, struct smb3_fs_context *ctx)
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
@@ -1146,12 +1186,13 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
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
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index cd914be905b2..609d0c0d9eca 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -1198,16 +1198,21 @@ int match_target_ip(struct TCP_Server_Info *server,
 
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

