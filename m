Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C657746293
	for <lists+stable@lfdr.de>; Mon,  3 Jul 2023 20:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjGCSgw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 3 Jul 2023 14:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjGCSgv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 3 Jul 2023 14:36:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31041A2
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 11:36:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 906886100C
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 18:36:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40EEC433C7;
        Mon,  3 Jul 2023 18:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688409410;
        bh=/6HniWeVIVzB5V4YOgXzHU5Y7wIIMMY7aMKfi5Rk6GM=;
        h=Subject:To:Cc:From:Date:From;
        b=jm2m7hgj4bhROleKEk3gPzYX65/f70IyqIfEiPnxb3rIaRhcWocRMEa4k99LD2fbf
         7sIWac2wwQbx8cmf9zlmo+926O+txLqZU0BFnoeOo+UB1f2vkxAlzuzzievsl7XJtJ
         JaV0dCpc7tHnrkUe37HgplhRLm9HiHTplfSllz7k=
Subject: FAILED: patch "[PATCH] dm ioctl: Avoid double-fetch of version" failed to apply to 5.4-stable tree
To:     demi@invisiblethingslab.com, snitzer@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 03 Jul 2023 20:36:42 +0200
Message-ID: <2023070342-blah-levitate-41a6@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 249bed821b4db6d95a99160f7d6d236ea5fe6362
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023070342-blah-levitate-41a6@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 249bed821b4db6d95a99160f7d6d236ea5fe6362 Mon Sep 17 00:00:00 2001
From: Demi Marie Obenour <demi@invisiblethingslab.com>
Date: Sat, 3 Jun 2023 10:52:42 -0400
Subject: [PATCH] dm ioctl: Avoid double-fetch of version

The version is fetched once in check_version(), which then does some
validation and then overwrites the version in userspace with the API
version supported by the kernel.  copy_params() then fetches the version
from userspace *again*, and this time no validation is done.  The result
is that the kernel's version number is completely controllable by
userspace, provided that userspace can win a race condition.

Fix this flaw by not copying the version back to the kernel the second
time.  This is not exploitable as the version is not further used in the
kernel.  However, it could become a problem if future patches start
relying on the version field.

Cc: stable@vger.kernel.org
Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index a92abbe90981..bfaebc02833a 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1872,30 +1872,36 @@ static ioctl_fn lookup_ioctl(unsigned int cmd, int *ioctl_flags)
  * As well as checking the version compatibility this always
  * copies the kernel interface version out.
  */
-static int check_version(unsigned int cmd, struct dm_ioctl __user *user)
+static int check_version(unsigned int cmd, struct dm_ioctl __user *user,
+			 struct dm_ioctl *kernel_params)
 {
-	uint32_t version[3];
 	int r = 0;
 
-	if (copy_from_user(version, user->version, sizeof(version)))
+	/* Make certain version is first member of dm_ioctl struct */
+	BUILD_BUG_ON(offsetof(struct dm_ioctl, version) != 0);
+
+	if (copy_from_user(kernel_params->version, user->version, sizeof(kernel_params->version)))
 		return -EFAULT;
 
-	if ((version[0] != DM_VERSION_MAJOR) ||
-	    (version[1] > DM_VERSION_MINOR)) {
+	if ((kernel_params->version[0] != DM_VERSION_MAJOR) ||
+	    (kernel_params->version[1] > DM_VERSION_MINOR)) {
 		DMERR("ioctl interface mismatch: kernel(%u.%u.%u), user(%u.%u.%u), cmd(%d)",
 		      DM_VERSION_MAJOR, DM_VERSION_MINOR,
 		      DM_VERSION_PATCHLEVEL,
-		      version[0], version[1], version[2], cmd);
+		      kernel_params->version[0],
+		      kernel_params->version[1],
+		      kernel_params->version[2],
+		      cmd);
 		r = -EINVAL;
 	}
 
 	/*
 	 * Fill in the kernel version.
 	 */
-	version[0] = DM_VERSION_MAJOR;
-	version[1] = DM_VERSION_MINOR;
-	version[2] = DM_VERSION_PATCHLEVEL;
-	if (copy_to_user(user->version, version, sizeof(version)))
+	kernel_params->version[0] = DM_VERSION_MAJOR;
+	kernel_params->version[1] = DM_VERSION_MINOR;
+	kernel_params->version[2] = DM_VERSION_PATCHLEVEL;
+	if (copy_to_user(user->version, kernel_params->version, sizeof(kernel_params->version)))
 		return -EFAULT;
 
 	return r;
@@ -1921,7 +1927,10 @@ static int copy_params(struct dm_ioctl __user *user, struct dm_ioctl *param_kern
 	const size_t minimum_data_size = offsetof(struct dm_ioctl, data);
 	unsigned int noio_flag;
 
-	if (copy_from_user(param_kernel, user, minimum_data_size))
+	/* check_version() already copied version from userspace, avoid TOCTOU */
+	if (copy_from_user((char *)param_kernel + sizeof(param_kernel->version),
+			   (char __user *)user + sizeof(param_kernel->version),
+			   minimum_data_size - sizeof(param_kernel->version)))
 		return -EFAULT;
 
 	if (param_kernel->data_size < minimum_data_size) {
@@ -2033,7 +2042,7 @@ static int ctl_ioctl(struct file *file, uint command, struct dm_ioctl __user *us
 	 * Check the interface version passed in.  This also
 	 * writes out the kernel's interface version.
 	 */
-	r = check_version(cmd, user);
+	r = check_version(cmd, user, &param_kernel);
 	if (r)
 		return r;
 

