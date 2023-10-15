Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225D47C9A7E
	for <lists+stable@lfdr.de>; Sun, 15 Oct 2023 19:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjJOR54 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 15 Oct 2023 13:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJOR5y (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 15 Oct 2023 13:57:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647B7AB
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 10:57:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B05C433C8;
        Sun, 15 Oct 2023 17:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697392673;
        bh=jJSy9KPyMsjuhdvctlFEKRV7xhiY30NEP3YyVNyf7sk=;
        h=Subject:To:Cc:From:Date:From;
        b=chFCeZ/gBkKtFbdsu8XdlkCB4XT52axbqbRomlDqwlKD6rzfQg2JO6he9zW3sEgVq
         /IT/ziigvoh/gAtWKjNaTF2MhFptVJHBy7jcslTIt+3nzCMeezWpK83XbJdS0mlKlu
         EfOzE+RYE1useEKwzmuJvMbHfpDHmWGi8dXvUMJM=
Subject: FAILED: patch "[PATCH] ovl: fix regression in showing lowerdir mount option" failed to apply to 6.5-stable tree
To:     amir73il@gmail.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 15 Oct 2023 19:57:44 +0200
Message-ID: <2023101544-ensnare-grain-3f88@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.5-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
git checkout FETCH_HEAD
git cherry-pick -x 32db510708507f6133f496ff385cbd841d8f9098
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023101544-ensnare-grain-3f88@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 32db510708507f6133f496ff385cbd841d8f9098 Mon Sep 17 00:00:00 2001
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 11 Oct 2023 17:07:03 +0300
Subject: [PATCH] ovl: fix regression in showing lowerdir mount option

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

diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/filesystems/overlayfs.rst
index cdefbe73d85c..5b93268e400f 100644
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
index 17c74ef4f089..8b6bae320e8a 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -192,7 +192,8 @@ static ssize_t ovl_parse_param_split_lowerdirs(char *str)
 
 	for (s = d = str;; s++, d++) {
 		if (*s == '\\') {
-			s++;
+			/* keep esc chars in split lowerdir */
+			*d++ = *s++;
 		} else if (*s == ':') {
 			bool next_colon = (*(s + 1) == ':');
 
@@ -267,7 +268,7 @@ static void ovl_unescape(char *s)
 	}
 }
 
-static int ovl_mount_dir(const char *name, struct path *path)
+static int ovl_mount_dir(const char *name, struct path *path, bool upper)
 {
 	int err = -ENOMEM;
 	char *tmp = kstrdup(name, GFP_KERNEL);
@@ -276,7 +277,7 @@ static int ovl_mount_dir(const char *name, struct path *path)
 		ovl_unescape(tmp);
 		err = ovl_mount_dir_noesc(tmp, path);
 
-		if (!err && path->dentry->d_flags & DCACHE_OP_REAL) {
+		if (!err && upper && path->dentry->d_flags & DCACHE_OP_REAL) {
 			pr_err("filesystem on '%s' not supported as upperdir\n",
 			       tmp);
 			path_put_init(path);
@@ -297,7 +298,7 @@ static int ovl_parse_param_upperdir(const char *name, struct fs_context *fc,
 	struct path path;
 	char *dup;
 
-	err = ovl_mount_dir(name, &path);
+	err = ovl_mount_dir(name, &path, true);
 	if (err)
 		return err;
 
@@ -500,7 +501,7 @@ static int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc)
 		l = &ctx->lower[nr];
 		memset(l, 0, sizeof(*l));
 
-		err = ovl_mount_dir_noesc(dup_iter, &l->path);
+		err = ovl_mount_dir(dup_iter, &l->path, false);
 		if (err)
 			goto out_put;
 
@@ -979,16 +980,23 @@ int ovl_show_options(struct seq_file *m, struct dentry *dentry)
 	struct super_block *sb = dentry->d_sb;
 	struct ovl_fs *ofs = OVL_FS(sb);
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

