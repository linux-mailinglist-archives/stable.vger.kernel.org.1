Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DFE7DD4FE
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376360AbjJaRqS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376338AbjJaRqL (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:46:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6C8103
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:46:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F10FC433C7;
        Tue, 31 Oct 2023 17:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774368;
        bh=vPKO9Ao0UaJG7g6vRMs/1uwFkg81kUvNA9C0OtD4AIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B88WSca8FFP+Wxph3+GrDEnKZ34Ialkr0ZUvD5UkNOpC8zf2lsMrYy2Szn+XT2v1y
         GezSKnlOOxxR846a6otTlh2pSm/8gwX++NLOrV86af3Vc43QnJTcF6thomLH28Velc
         DTsv8BCxkIgWXHzfhZFMQ7ASjrmlYNXJVO1l0c/8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 004/112] smb3: allow controlling maximum number of cached directories
Date:   Tue, 31 Oct 2023 18:00:05 +0100
Message-ID: <20231031165901.451692983@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
References: <20231031165901.318222981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steve French <stfrench@microsoft.com>

[ Upstream commit 6a50d71d0ffff6791737eb502b27f74fb87d0cae ]

Allow adjusting the maximum number of cached directories per share
(defaults to 16) via mount parm "max_cached_dirs"

Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cached_dir.c |  7 ++++---
 fs/smb/client/cached_dir.h |  2 +-
 fs/smb/client/cifsfs.c     |  2 ++
 fs/smb/client/cifsglob.h   |  1 +
 fs/smb/client/connect.c    |  1 +
 fs/smb/client/fs_context.c | 11 ++++++++++-
 fs/smb/client/fs_context.h |  4 +++-
 7 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/fs/smb/client/cached_dir.c b/fs/smb/client/cached_dir.c
index 9d84c4a7bd0ce..b17f067e4ada0 100644
--- a/fs/smb/client/cached_dir.c
+++ b/fs/smb/client/cached_dir.c
@@ -18,7 +18,8 @@ static void smb2_close_cached_fid(struct kref *ref);
 
 static struct cached_fid *find_or_create_cached_dir(struct cached_fids *cfids,
 						    const char *path,
-						    bool lookup_only)
+						    bool lookup_only,
+						    __u32 max_cached_dirs)
 {
 	struct cached_fid *cfid;
 
@@ -43,7 +44,7 @@ static struct cached_fid *find_or_create_cached_dir(struct cached_fids *cfids,
 		spin_unlock(&cfids->cfid_list_lock);
 		return NULL;
 	}
-	if (cfids->num_entries >= MAX_CACHED_FIDS) {
+	if (cfids->num_entries >= max_cached_dirs) {
 		spin_unlock(&cfids->cfid_list_lock);
 		return NULL;
 	}
@@ -162,7 +163,7 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 	if (!utf16_path)
 		return -ENOMEM;
 
-	cfid = find_or_create_cached_dir(cfids, path, lookup_only);
+	cfid = find_or_create_cached_dir(cfids, path, lookup_only, tcon->max_cached_dirs);
 	if (cfid == NULL) {
 		kfree(utf16_path);
 		return -ENOENT;
diff --git a/fs/smb/client/cached_dir.h b/fs/smb/client/cached_dir.h
index facc9b154d009..a82ff2cea789c 100644
--- a/fs/smb/client/cached_dir.h
+++ b/fs/smb/client/cached_dir.h
@@ -49,7 +49,7 @@ struct cached_fid {
 	struct cached_dirents dirents;
 };
 
-#define MAX_CACHED_FIDS 16
+/* default MAX_CACHED_FIDS is 16 */
 struct cached_fids {
 	/* Must be held when:
 	 * - accessing the cfids->entries list
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 9a6d7e66408d1..e19df244ea7ea 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -699,6 +699,8 @@ cifs_show_options(struct seq_file *s, struct dentry *root)
 		seq_printf(s, ",snapshot=%llu", tcon->snapshot_time);
 	if (tcon->handle_timeout)
 		seq_printf(s, ",handletimeout=%u", tcon->handle_timeout);
+	if (tcon->max_cached_dirs != MAX_CACHED_FIDS)
+		seq_printf(s, ",max_cached_dirs=%u", tcon->max_cached_dirs);
 
 	/*
 	 * Display file and directory attribute timeout in seconds.
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index f8eb787ecffab..b4c1c4742f08a 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1192,6 +1192,7 @@ struct cifs_tcon {
 	__u32 max_chunks;
 	__u32 max_bytes_chunk;
 	__u32 max_bytes_copy;
+	__u32 max_cached_dirs;
 #ifdef CONFIG_CIFS_FSCACHE
 	u64 resource_id;		/* server resource id */
 	struct fscache_volume *fscache;	/* cookie for share */
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 352e251c41132..f00d02608ee46 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -2657,6 +2657,7 @@ cifs_get_tcon(struct cifs_ses *ses, struct smb3_fs_context *ctx)
 	tcon->retry = ctx->retry;
 	tcon->nocase = ctx->nocase;
 	tcon->broken_sparse_sup = ctx->no_sparse;
+	tcon->max_cached_dirs = ctx->max_cached_dirs;
 	if (ses->server->capabilities & SMB2_GLOBAL_CAP_DIRECTORY_LEASING)
 		tcon->nohandlecache = ctx->nohandlecache;
 	else
diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
index f12203c49b802..a3493da12ad1e 100644
--- a/fs/smb/client/fs_context.c
+++ b/fs/smb/client/fs_context.c
@@ -150,6 +150,7 @@ const struct fs_parameter_spec smb3_fs_parameters[] = {
 	fsparam_u32("closetimeo", Opt_closetimeo),
 	fsparam_u32("echo_interval", Opt_echo_interval),
 	fsparam_u32("max_credits", Opt_max_credits),
+	fsparam_u32("max_cached_dirs", Opt_max_cached_dirs),
 	fsparam_u32("handletimeout", Opt_handletimeout),
 	fsparam_u64("snapshot", Opt_snapshot),
 	fsparam_u32("max_channels", Opt_max_channels),
@@ -1165,6 +1166,14 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 		if (result.uint_32 > 1)
 			ctx->multichannel = true;
 		break;
+	case Opt_max_cached_dirs:
+		if (result.uint_32 < 1) {
+			cifs_errorf(fc, "%s: Invalid max_cached_dirs, needs to be 1 or more\n",
+				    __func__);
+			goto cifs_parse_mount_err;
+		}
+		ctx->max_cached_dirs = result.uint_32;
+		break;
 	case Opt_handletimeout:
 		ctx->handle_timeout = result.uint_32;
 		if (ctx->handle_timeout > SMB3_MAX_HANDLE_TIMEOUT) {
@@ -1593,7 +1602,7 @@ int smb3_init_fs_context(struct fs_context *fc)
 	ctx->acregmax = CIFS_DEF_ACTIMEO;
 	ctx->acdirmax = CIFS_DEF_ACTIMEO;
 	ctx->closetimeo = SMB3_DEF_DCLOSETIMEO;
-
+	ctx->max_cached_dirs = MAX_CACHED_FIDS;
 	/* Most clients set timeout to 0, allows server to use its default */
 	ctx->handle_timeout = 0; /* See MS-SMB2 spec section 2.2.14.2.12 */
 
diff --git a/fs/smb/client/fs_context.h b/fs/smb/client/fs_context.h
index f4eaf85589022..9d8d34af02114 100644
--- a/fs/smb/client/fs_context.h
+++ b/fs/smb/client/fs_context.h
@@ -128,6 +128,7 @@ enum cifs_param {
 	Opt_closetimeo,
 	Opt_echo_interval,
 	Opt_max_credits,
+	Opt_max_cached_dirs,
 	Opt_snapshot,
 	Opt_max_channels,
 	Opt_handletimeout,
@@ -261,6 +262,7 @@ struct smb3_fs_context {
 	__u32 handle_timeout; /* persistent and durable handle timeout in ms */
 	unsigned int max_credits; /* smb3 max_credits 10 < credits < 60000 */
 	unsigned int max_channels;
+	unsigned int max_cached_dirs;
 	__u16 compression; /* compression algorithm 0xFFFF default 0=disabled */
 	bool rootfs:1; /* if it's a SMB root file system */
 	bool witness:1; /* use witness protocol */
@@ -287,7 +289,7 @@ extern void smb3_update_mnt_flags(struct cifs_sb_info *cifs_sb);
  */
 #define SMB3_MAX_DCLOSETIMEO (1 << 30)
 #define SMB3_DEF_DCLOSETIMEO (1 * HZ) /* even 1 sec enough to help eg open/write/close/open/read */
-
+#define MAX_CACHED_FIDS 16
 extern char *cifs_sanitize_prepath(char *prepath, gfp_t gfp);
 
 #endif
-- 
2.42.0



