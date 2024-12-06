Return-Path: <stable+bounces-98992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6AF9E6BA5
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 11:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02C0F287BA0
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 10:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692861FCD06;
	Fri,  6 Dec 2024 10:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rv4JViAP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E361FCD01
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 10:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480168; cv=none; b=YVyF5xkiObQE/uRw0iKsi+xxx/qe+PZo8k82rLxJel6+ycs8ZB9n9OcwcgkHiCbWgn79kBQySs43/HvmHjHdwbqPCD8xuorJ6mx9TMgbdrqYTCw//38UFeyp+5BiFlzk64ajz9OghWG/eMqKVg/SeGsRlph4leizz1qa2FyUOSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480168; c=relaxed/simple;
	bh=5YCWPjU+z1qHv9AFWkKZKf9CwkJ7858T7TGAaoqacGg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=O8dohQ3nr9v6axgxeXoB5ye9xJIV+nWjwhjliqrsbtwbAQg0UQJFfzdDLQUq0olFmjVouf1p+NTHkinsPBfBeObnRryoGDYPW8ALyJ70o5XAnXeaeoRxFOGdwySt/s0rmJ8MF3MqCyb1447Ss9206E0JESgWPZm2A51mkoXGYio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rv4JViAP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E061C4CED1;
	Fri,  6 Dec 2024 10:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733480166;
	bh=5YCWPjU+z1qHv9AFWkKZKf9CwkJ7858T7TGAaoqacGg=;
	h=Subject:To:Cc:From:Date:From;
	b=rv4JViAPC/FSEl6AAKQnyH30rRHH240ziTrJMOTYFCQbBMalNvXit6HIvpS7gywoC
	 abd5FTUy5Y+BejzA3y432vESH9/vvogkok8p2pLmC4Sdj/KrOckkRWt5xxWAnoCYNx
	 oitSBFI6AQ6NtrcoVCm2ObfENQ8R3IPGyPKdZdJU=
Subject: FAILED: patch "[PATCH] iommu/arm-smmu: Defer probe of clients after smmu device" failed to apply to 5.4-stable tree
To: quic_pbrahma@quicinc.com,quic_guptap@quicinc.com,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 06 Dec 2024 11:15:51 +0100
Message-ID: <2024120651-ruse-sturdily-f7c5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 229e6ee43d2a160a1592b83aad620d6027084aad
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120651-ruse-sturdily-f7c5@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 229e6ee43d2a160a1592b83aad620d6027084aad Mon Sep 17 00:00:00 2001
From: Pratyush Brahma <quic_pbrahma@quicinc.com>
Date: Fri, 4 Oct 2024 14:34:28 +0530
Subject: [PATCH] iommu/arm-smmu: Defer probe of clients after smmu device
 bound

Null pointer dereference occurs due to a race between smmu
driver probe and client driver probe, when of_dma_configure()
for client is called after the iommu_device_register() for smmu driver
probe has executed but before the driver_bound() for smmu driver
has been called.

Following is how the race occurs:

T1:Smmu device probe		T2: Client device probe

really_probe()
arm_smmu_device_probe()
iommu_device_register()
					really_probe()
					platform_dma_configure()
					of_dma_configure()
					of_dma_configure_id()
					of_iommu_configure()
					iommu_probe_device()
					iommu_init_device()
					arm_smmu_probe_device()
					arm_smmu_get_by_fwnode()
						driver_find_device_by_fwnode()
						driver_find_device()
						next_device()
						klist_next()
						    /* null ptr
						       assigned to smmu */
					/* null ptr dereference
					   while smmu->streamid_mask */
driver_bound()
	klist_add_tail()

When this null smmu pointer is dereferenced later in
arm_smmu_probe_device, the device crashes.

Fix this by deferring the probe of the client device
until the smmu device has bound to the arm smmu driver.

Fixes: 021bb8420d44 ("iommu/arm-smmu: Wire up generic configuration support")
Cc: stable@vger.kernel.org
Co-developed-by: Prakash Gupta <quic_guptap@quicinc.com>
Signed-off-by: Prakash Gupta <quic_guptap@quicinc.com>
Signed-off-by: Pratyush Brahma <quic_pbrahma@quicinc.com>
Link: https://lore.kernel.org/r/20241004090428.2035-1-quic_pbrahma@quicinc.com
[will: Add comment]
Signed-off-by: Will Deacon <will@kernel.org>

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 8321962b3714..14618772a3d6 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1437,6 +1437,17 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 			goto out_free;
 	} else {
 		smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
+
+		/*
+		 * Defer probe if the relevant SMMU instance hasn't finished
+		 * probing yet. This is a fragile hack and we'd ideally
+		 * avoid this race in the core code. Until that's ironed
+		 * out, however, this is the most pragmatic option on the
+		 * table.
+		 */
+		if (!smmu)
+			return ERR_PTR(dev_err_probe(dev, -EPROBE_DEFER,
+						"smmu dev has not bound yet\n"));
 	}
 
 	ret = -EINVAL;


