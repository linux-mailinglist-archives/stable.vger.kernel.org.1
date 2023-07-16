Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245037556E4
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbjGPUzE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbjGPUzB (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:55:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8C4E57
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:55:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B235B60EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:54:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C073CC433C8;
        Sun, 16 Jul 2023 20:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540899;
        bh=7h3ps/8rf6pSCI5kAYkeV4m0IwPiEw8qoVMslOdfBfg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PqXC0s/8EMM3IOd0G6zthDjMqsj+vZt8cRJDWO+CXbNUAkANDhLxI6TfH8tuWuz0O
         4f0ZcjJH4vNmboXvC2qP+04O35MS188+3akJeyzBlyfP2/4CRTaxoB0T0lhOGVbap0
         OeH+lp71gf9oxVzRvfKgYrJxkhKvNnMYJ+gpFbE0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Demi Marie Obenour <demi@invisiblethingslab.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 520/591] dm ioctl: Avoid double-fetch of version
Date:   Sun, 16 Jul 2023 21:50:59 +0200
Message-ID: <20230716194937.328964223@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Demi Marie Obenour <demi@invisiblethingslab.com>

[ Upstream commit 249bed821b4db6d95a99160f7d6d236ea5fe6362 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-ioctl.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 6aeae095086d7..2afd2d2a0f407 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1811,30 +1811,36 @@ static ioctl_fn lookup_ioctl(unsigned int cmd, int *ioctl_flags)
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
@@ -1860,7 +1866,10 @@ static int copy_params(struct dm_ioctl __user *user, struct dm_ioctl *param_kern
 	const size_t minimum_data_size = offsetof(struct dm_ioctl, data);
 	unsigned int noio_flag;
 
-	if (copy_from_user(param_kernel, user, minimum_data_size))
+	/* check_version() already copied version from userspace, avoid TOCTOU */
+	if (copy_from_user((char *)param_kernel + sizeof(param_kernel->version),
+			   (char __user *)user + sizeof(param_kernel->version),
+			   minimum_data_size - sizeof(param_kernel->version)))
 		return -EFAULT;
 
 	if (param_kernel->data_size < minimum_data_size) {
@@ -1972,7 +1981,7 @@ static int ctl_ioctl(struct file *file, uint command, struct dm_ioctl __user *us
 	 * Check the interface version passed in.  This also
 	 * writes out the kernel's interface version.
 	 */
-	r = check_version(cmd, user);
+	r = check_version(cmd, user, &param_kernel);
 	if (r)
 		return r;
 
-- 
2.39.2



