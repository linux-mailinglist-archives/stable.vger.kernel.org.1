Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7007CACA3
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbjJPO5b (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbjJPO5a (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:57:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557C7AB
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:57:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0B1C433C8;
        Mon, 16 Oct 2023 14:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697468248;
        bh=EbxisrqAS1DQfaupAPxR2Q/2phS9bMCuWwOEeQE4dZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W5xDZe/i9eEaAeOuIv5YmlepRsvoEe6Pxc5eQrLgOgY8ssmGJPIiPQgcNZOonEPTz
         u2MBKIm6V0b+Cz7Zuxz26WqiUyAQftljJMUCehbfhzaPE3kQzO+1BWhlo5wsFI7Wka
         09sCi6jXEQZW6lKTlQFbOSrh7tLh6A/6qBHpYmkU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Amir Goldstein <amir73il@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 190/191] ovl: fix regression in showing lowerdir mount option
Date:   Mon, 16 Oct 2023 10:42:55 +0200
Message-ID: <20231016084019.804530029@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit 32db510708507f6133f496ff385cbd841d8f9098 ]

Before commit b36a5780cb44 ("ovl: modify layer parameter parsing"),
spaces and commas in lowerdir mount option value used to be escaped using
seq_show_option().

In current upstream, when lowerdir value has a space, it is not escaped
in /proc/mounts, e.g.:

  none /mnt overlay rw,relatime,lowerdir=l l,upperdir=u,workdir=w 0 0

which results in broken output of the mount utility:

  none on /mnt type overlay (rw,relatime,lowerdir=l)

Store the original lowerdir mount options before unescaping and show
them using the same escaping used for seq_show_option() in addition to
escaping the colon separator character.

Fixes: b36a5780cb44 ("ovl: modify layer parameter parsing")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/filesystems/overlayfs.rst | 12 ++++++++
 fs/overlayfs/params.c                   | 38 +++++++++++++++----------
 2 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/filesystems/overlayfs.rst
index eb7d2c88ddece..8e1b27288afd4 100644
--- a/Documentation/filesystems/overlayfs.rst
+++ b/Documentation/filesystems/overlayfs.rst
@@ -339,6 +339,18 @@ The specified lower directories will be stacked beginning from the
 rightmost one and going left.  In the above example lower1 will be the
 top, lower2 the middle and lower3 the bottom layer.
 
+Note: directory names containing colons can be provided as lower layer by
+escaping the colons with a single backslash.  For example:
+
+  mount -t overlay overlay -olowerdir=/a\:lower\:\:dir /merged
+
+Since kernel version v6.5, directory names containing colons can also
+be provided as lower layer using the fsconfig syscall from new mount api:
+
+  fsconfig(fs_fd, FSCONFIG_SET_STRING, "lowerdir", "/a:lower::dir", 0);
+
+In the latter case, colons in lower layer directory names will be escaped
+as an octal characters (\072) when displayed in /proc/self/mountinfo.
 
 Metadata only copy up
 ---------------------
diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index e6edad7542e88..644badb13fe01 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -155,7 +155,8 @@ static ssize_t ovl_parse_param_split_lowerdirs(char *str)
 
 	for (s = d = str;; s++, d++) {
 		if (*s == '\\') {
-			s++;
+			/* keep esc chars in split lowerdir */
+			*d++ = *s++;
 		} else if (*s == ':') {
 			bool next_colon = (*(s + 1) == ':');
 
@@ -230,7 +231,7 @@ static void ovl_unescape(char *s)
 	}
 }
 
-static int ovl_mount_dir(const char *name, struct path *path)
+static int ovl_mount_dir(const char *name, struct path *path, bool upper)
 {
 	int err = -ENOMEM;
 	char *tmp = kstrdup(name, GFP_KERNEL);
@@ -239,7 +240,7 @@ static int ovl_mount_dir(const char *name, struct path *path)
 		ovl_unescape(tmp);
 		err = ovl_mount_dir_noesc(tmp, path);
 
-		if (!err && path->dentry->d_flags & DCACHE_OP_REAL) {
+		if (!err && upper && path->dentry->d_flags & DCACHE_OP_REAL) {
 			pr_err("filesystem on '%s' not supported as upperdir\n",
 			       tmp);
 			path_put_init(path);
@@ -260,7 +261,7 @@ static int ovl_parse_param_upperdir(const char *name, struct fs_context *fc,
 	struct path path;
 	char *dup;
 
-	err = ovl_mount_dir(name, &path);
+	err = ovl_mount_dir(name, &path, true);
 	if (err)
 		return err;
 
@@ -417,7 +418,7 @@ static int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc)
 		l = &ctx->lower[nr];
 		memset(l, 0, sizeof(*l));
 
-		err = ovl_mount_dir_noesc(dup_iter, &l->path);
+		err = ovl_mount_dir(dup_iter, &l->path, false);
 		if (err)
 			goto out_put;
 
@@ -858,16 +859,23 @@ int ovl_show_options(struct seq_file *m, struct dentry *dentry)
 	struct super_block *sb = dentry->d_sb;
 	struct ovl_fs *ofs = sb->s_fs_info;
 	size_t nr, nr_merged_lower = ofs->numlayer - ofs->numdatalayer;
-	char **lowerdatadirs = &ofs->config.lowerdirs[nr_merged_lower];
-
-	/* lowerdirs[] starts from offset 1 */
-	seq_printf(m, ",lowerdir=%s", ofs->config.lowerdirs[1]);
-	/* dump regular lower layers */
-	for (nr = 2; nr < nr_merged_lower; nr++)
-		seq_printf(m, ":%s", ofs->config.lowerdirs[nr]);
-	/* dump data lower layers */
-	for (nr = 0; nr < ofs->numdatalayer; nr++)
-		seq_printf(m, "::%s", lowerdatadirs[nr]);
+
+	/*
+	 * lowerdirs[] starts from offset 1, then
+	 * >= 0 regular lower layers prefixed with : and
+	 * >= 0 data-only lower layers prefixed with ::
+	 *
+	 * we need to escase comma and space like seq_show_option() does and
+	 * we also need to escape the colon separator from lowerdir paths.
+	 */
+	seq_puts(m, ",lowerdir=");
+	for (nr = 1; nr < ofs->numlayer; nr++) {
+		if (nr > 1)
+			seq_putc(m, ':');
+		if (nr >= nr_merged_lower)
+			seq_putc(m, ':');
+		seq_escape(m, ofs->config.lowerdirs[nr], ":, \t\n\\");
+	}
 	if (ofs->config.upperdir) {
 		seq_show_option(m, "upperdir", ofs->config.upperdir);
 		seq_show_option(m, "workdir", ofs->config.workdir);
-- 
2.40.1



