Return-Path: <stable+bounces-50-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6F47F5EA0
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 13:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEDDD1C20FC7
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 12:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E3E2377F;
	Thu, 23 Nov 2023 12:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OeCq3Ded"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB606241ED
	for <stable@vger.kernel.org>; Thu, 23 Nov 2023 12:01:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE606C433C7;
	Thu, 23 Nov 2023 12:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700740887;
	bh=PwGuXjmUPezntUinRnpErkpHp0Wx7ZWpTAryaQ7PdNg=;
	h=Subject:To:Cc:From:Date:From;
	b=OeCq3DedPAYH2EKA65mJN08xLPsR46lWJS0iUQOcliiCBvKqAgOcjEk4t1+R54vKu
	 fkJZ7rEWY5RfJg1lvj8Ypbt6QPT6ia9E3ozH1dXdDSi4/DQmUheZeiE5EV1y58iL8O
	 ol26Mk/VVUcnCIJd7q0F9kjjPSD4Y3oRaANYmelM=
Subject: FAILED: patch "[PATCH] powerpc/pseries/iommu: enable_ddw incorrectly returns direct" failed to apply to 5.15-stable tree
To: gbatra@linux.vnet.ibm.com,mpe@ellerman.id.au
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 23 Nov 2023 12:01:21 +0000
Message-ID: <2023112321-tightrope-reimburse-f004@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 3bf983e4e93ce8e6d69e9d63f52a66ec0856672e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112321-tightrope-reimburse-f004@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

3bf983e4e93c ("powerpc/pseries/iommu: enable_ddw incorrectly returns direct mapping for SR-IOV device")
fb4ee2b30cd0 ("powerpc/pseries/ddw: simplify enable_ddw()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3bf983e4e93ce8e6d69e9d63f52a66ec0856672e Mon Sep 17 00:00:00 2001
From: Gaurav Batra <gbatra@linux.vnet.ibm.com>
Date: Mon, 2 Oct 2023 22:08:02 -0500
Subject: [PATCH] powerpc/pseries/iommu: enable_ddw incorrectly returns direct
 mapping for SR-IOV device

When a device is initialized, the driver invokes dma_supported() twice -
first for streaming mappings followed by coherent mappings. For an
SR-IOV device, default window is deleted and DDW created. With vPMEM
enabled, TCE mappings are dynamically created for both vPMEM and SR-IOV
device.  There are no direct mappings.

First time when dma_supported() is called with 64 bit mask, DDW is created
and marked as dynamic window. The second time dma_supported() is called,
enable_ddw() finds existing window for the device and incorrectly returns
it as "direct mapping".

This only happens when size of DDW is big enough to map max LPAR memory.

This results in streaming TCEs to not get dynamically mapped, since code
incorrently assumes these are already pre-mapped. The adapter initially
comes up but goes down due to EEH.

Fixes: 381ceda88c4c ("powerpc/pseries/iommu: Make use of DDW for indirect mapping")
Cc: stable@vger.kernel.org # v5.15+
Signed-off-by: Gaurav Batra <gbatra@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20231003030802.47914-1-gbatra@linux.vnet.ibm.com

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 16d93b580f61..496e16c588aa 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -914,7 +914,8 @@ static int remove_ddw(struct device_node *np, bool remove_prop, const char *win_
 	return 0;
 }
 
-static bool find_existing_ddw(struct device_node *pdn, u64 *dma_addr, int *window_shift)
+static bool find_existing_ddw(struct device_node *pdn, u64 *dma_addr, int *window_shift,
+			      bool *direct_mapping)
 {
 	struct dma_win *window;
 	const struct dynamic_dma_window_prop *dma64;
@@ -927,6 +928,7 @@ static bool find_existing_ddw(struct device_node *pdn, u64 *dma_addr, int *windo
 			dma64 = window->prop;
 			*dma_addr = be64_to_cpu(dma64->dma_base);
 			*window_shift = be32_to_cpu(dma64->window_shift);
+			*direct_mapping = window->direct;
 			found = true;
 			break;
 		}
@@ -1270,10 +1272,8 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 
 	mutex_lock(&dma_win_init_mutex);
 
-	if (find_existing_ddw(pdn, &dev->dev.archdata.dma_offset, &len)) {
-		direct_mapping = (len >= max_ram_len);
+	if (find_existing_ddw(pdn, &dev->dev.archdata.dma_offset, &len, &direct_mapping))
 		goto out_unlock;
-	}
 
 	/*
 	 * If we already went through this for a previous function of


