Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F007014F8
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 09:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjEMHh6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 03:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjEMHh5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 03:37:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F86E35B5
        for <stable@vger.kernel.org>; Sat, 13 May 2023 00:37:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF54060E00
        for <stable@vger.kernel.org>; Sat, 13 May 2023 07:37:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740E1C433EF;
        Sat, 13 May 2023 07:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683963475;
        bh=ictJhpijQD1hgbLJgjrrt+zel3ShHnAlVPIN8tJzfAQ=;
        h=Subject:To:Cc:From:Date:From;
        b=1dik4zxdwkMaTIJfFeRwMWTgW8BxkeHh0pSCpAPagVc3peV3qIsvMABsbgkfC+3fj
         pHAO5nm7Vt+/UDkpUCwmLSA37seKIAnI0k/EbsDR0edAtL8ekREU/FEqMl67jk8xys
         1f8yqUW0b7PZXzVmOvQV8sLxTNfW4OLRFWZo8Zd0=
Subject: FAILED: patch "[PATCH] drm/amdgpu: Don't resume IOMMU after incomplete init" failed to apply to 6.3-stable tree
To:     Felix.Kuehling@amd.com, alexander.deucher@amd.com,
        matt.fagnani@bell.net, regressions@leemhuis.info,
        vasant.hegde@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 13 May 2023 16:19:38 +0900
Message-ID: <2023051338-vocally-gander-2c08@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.3.y
git checkout FETCH_HEAD
git cherry-pick -x 7ee938ac006096fe9c3f1075f56b9263587c150f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023051338-vocally-gander-2c08@gregkh' --subject-prefix 'PATCH 6.3.y' HEAD^..

Possible dependencies:

7ee938ac0060 ("drm/amdgpu: Don't resume IOMMU after incomplete init")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7ee938ac006096fe9c3f1075f56b9263587c150f Mon Sep 17 00:00:00 2001
From: Felix Kuehling <Felix.Kuehling@amd.com>
Date: Mon, 13 Mar 2023 20:03:08 -0400
Subject: [PATCH] drm/amdgpu: Don't resume IOMMU after incomplete init

Check kfd->init_complete in kgd2kfd_iommu_resume, consistent with other
kgd2kfd calls. This should fix IOMMU errors on resume from suspend when
KFD IOMMU initialization failed.

Reported-by: Matt Fagnani <matt.fagnani@bell.net>
Link: https://lore.kernel.org/r/4a3b225c-2ffd-e758-4de1-447375e34cad@bell.net/
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217170
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2454
Cc: Vasant Hegde <vasant.hegde@amd.com>
Cc: Linux regression tracking (Thorsten Leemhuis) <regressions@leemhuis.info>
Cc: stable@vger.kernel.org
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Tested-by: Matt Fagnani <matt.fagnani@bell.net>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 3de7f616a001..ec70a1658dc3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -59,6 +59,7 @@ static int kfd_gtt_sa_init(struct kfd_dev *kfd, unsigned int buf_size,
 				unsigned int chunk_size);
 static void kfd_gtt_sa_fini(struct kfd_dev *kfd);
 
+static int kfd_resume_iommu(struct kfd_dev *kfd);
 static int kfd_resume(struct kfd_dev *kfd);
 
 static void kfd_device_info_set_sdma_info(struct kfd_dev *kfd)
@@ -624,7 +625,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 
 	svm_migrate_init(kfd->adev);
 
-	if (kgd2kfd_resume_iommu(kfd))
+	if (kfd_resume_iommu(kfd))
 		goto device_iommu_error;
 
 	if (kfd_resume(kfd))
@@ -772,6 +773,14 @@ int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
 }
 
 int kgd2kfd_resume_iommu(struct kfd_dev *kfd)
+{
+	if (!kfd->init_complete)
+		return 0;
+
+	return kfd_resume_iommu(kfd);
+}
+
+static int kfd_resume_iommu(struct kfd_dev *kfd)
 {
 	int err = 0;
 

