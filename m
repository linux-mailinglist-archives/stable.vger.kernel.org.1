Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B567C9ACF
	for <lists+stable@lfdr.de>; Sun, 15 Oct 2023 20:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjJOSgt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 15 Oct 2023 14:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJOSgs (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 15 Oct 2023 14:36:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD5DAB
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 11:36:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93A2C433C8;
        Sun, 15 Oct 2023 18:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697395006;
        bh=69BsjIOX5R8jyogLLfgeDp3WVOd068v/B5Izg2Pr6zk=;
        h=Subject:To:Cc:From:Date:From;
        b=FYx/WTgJ9YlR4PlGNJLh6rUIJLwHjywHwJEJycCCzGuCaX6jH/zR/3DDZQZTIhd39
         DqVWWbD6NuUhCFgdrQqmiL3frIfkM7l5b6pCzumrIBmhaCAgMBb4FnGGwmOpQDgvUL
         ROZTjaXv7dAADR0JJsZHKWt5/Ubx30yo3px9BQ1I=
Subject: FAILED: patch "[PATCH] ovl: fix regression in parsing of mount options with escaped" failed to apply to 6.5-stable tree
To:     amir73il@gmail.com, ryan.hendrickson@alum.mit.edu
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 15 Oct 2023 20:36:43 +0200
Message-ID: <2023101542-semisweet-rogue-1c44@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
git cherry-pick -x c34706acf40b43dd31f67c92c5a95d39666a1eb3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023101542-semisweet-rogue-1c44@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c34706acf40b43dd31f67c92c5a95d39666a1eb3 Mon Sep 17 00:00:00 2001
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 12 Oct 2023 16:08:28 +0300
Subject: [PATCH] ovl: fix regression in parsing of mount options with escaped
 comma

Ever since commit 91c77947133f ("ovl: allow filenames with comma"), the
following example was legit overlayfs mount options:

  mount -t overlay overlay -o 'lowerdir=/tmp/a\,b/lower' /mnt

The conversion to new mount api moved to using the common helper
generic_parse_monolithic() and discarded the specialized ovl_next_opt()
option separator.

Bring back ovl_next_opt() and use vfs_parse_monolithic_sep() to fix the
regression.

Reported-by: Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
Closes: https://lore.kernel.org/r/8da307fb-9318-cf78-8a27-ba5c5a0aef6d@alum.mit.edu/
Fixes: 1784fbc2ed9c ("ovl: port to new mount api")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>

diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index 95b751507ac8..17c74ef4f089 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -157,6 +157,34 @@ const struct fs_parameter_spec ovl_parameter_spec[] = {
 	{}
 };
 
+static char *ovl_next_opt(char **s)
+{
+	char *sbegin = *s;
+	char *p;
+
+	if (sbegin == NULL)
+		return NULL;
+
+	for (p = sbegin; *p; p++) {
+		if (*p == '\\') {
+			p++;
+			if (!*p)
+				break;
+		} else if (*p == ',') {
+			*p = '\0';
+			*s = p + 1;
+			return sbegin;
+		}
+	}
+	*s = NULL;
+	return sbegin;
+}
+
+static int ovl_parse_monolithic(struct fs_context *fc, void *data)
+{
+	return vfs_parse_monolithic_sep(fc, data, ovl_next_opt);
+}
+
 static ssize_t ovl_parse_param_split_lowerdirs(char *str)
 {
 	ssize_t nr_layers = 1, nr_colons = 0;
@@ -682,6 +710,7 @@ static int ovl_reconfigure(struct fs_context *fc)
 }
 
 static const struct fs_context_operations ovl_context_ops = {
+	.parse_monolithic = ovl_parse_monolithic,
 	.parse_param = ovl_parse_param,
 	.get_tree    = ovl_get_tree,
 	.reconfigure = ovl_reconfigure,

