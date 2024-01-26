Return-Path: <stable+bounces-15956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0B483E568
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 175A2282B50
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 22:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EADF250F9;
	Fri, 26 Jan 2024 22:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RMtPsTGv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D328524B22
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 22:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308110; cv=none; b=lL86Lc1gV/x3rdlxf5lKp7vduw4wzyz5cCLVMyeCbjVVw9nNEc/odQ4GgCENtjM5Nh1fHYKm4MRVOXzXbX/3abOidq4dv5sL85gcPLudfn6gvQaPo51rgFDgA3VsbwdhYm7awJdd47/b/Pfss/GEuaDrJ5kh/uWf57C+ka8W8Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308110; c=relaxed/simple;
	bh=ik8KTheJQtjUGEL6pHEHuJhDA7sRSutI7C5pADvlkq8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=opOGQFQW2Lo0izmPP1nHDt1kJiuhOQwgj/Pcl00cDMyK0SLxoI0bd/+BJEsSanVHJ8FLk+NvF/cPoz1eHYW69WcpekaZShp6emOTbtK+YzaWWpOecJ4COBWrRhMzhu8JEvlmEezJpw1L0fr+wsQUCa2RS66TkKycEdE+FSs6wjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RMtPsTGv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FB4C433F1;
	Fri, 26 Jan 2024 22:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706308110;
	bh=ik8KTheJQtjUGEL6pHEHuJhDA7sRSutI7C5pADvlkq8=;
	h=Subject:To:Cc:From:Date:From;
	b=RMtPsTGvIJHCj28LIjmSECrtQPfPthPFlU/BIgHhXE1qETCCKci/I50qZY9YJl8MR
	 qdy+CRL1zF/kI+eOQlPdGWoL6V+oDfvwxkqzt5jCgliT8Stebvfa9Jgb4xtBt0hpF7
	 A7beVZBrU9w4d5YTc6PZ2QNiN4sWp0LKuHr9GpnQ=
Subject: FAILED: patch "[PATCH] bus: mhi: host: Add alignment check for event ring read" failed to apply to 5.10-stable tree
To: quic_krichai@quicinc.com,manivannan.sadhasivam@linaro.org,quic_jhugo@quicinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 14:28:29 -0800
Message-ID: <2024012629-motto-fidgeting-3df6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x eff9704f5332a13b08fbdbe0f84059c9e7051d5f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012629-motto-fidgeting-3df6@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

eff9704f5332 ("bus: mhi: host: Add alignment check for event ring read pointer")
a0f5a630668c ("bus: mhi: Move host MHI code to "host" directory")
ec32332df764 ("bus: mhi: core: Sanity check values from remote device before use")
855a70c12021 ("bus: mhi: Add MHI PCI support for WWAN modems")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From eff9704f5332a13b08fbdbe0f84059c9e7051d5f Mon Sep 17 00:00:00 2001
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Tue, 31 Oct 2023 15:21:05 +0530
Subject: [PATCH] bus: mhi: host: Add alignment check for event ring read
 pointer

Though we do check the event ring read pointer by "is_valid_ring_ptr"
to make sure it is in the buffer range, but there is another risk the
pointer may be not aligned.  Since we are expecting event ring elements
are 128 bits(struct mhi_ring_element) aligned, an unaligned read pointer
could lead to multiple issues like DoS or ring buffer memory corruption.

So add a alignment check for event ring read pointer.

Fixes: ec32332df764 ("bus: mhi: core: Sanity check values from remote device before use")
cc: stable@vger.kernel.org
Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/20231031-alignment_check-v2-1-1441db7c5efd@quicinc.com
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index 6cf11457380b..d80975f4bba8 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -269,7 +269,8 @@ static void mhi_del_ring_element(struct mhi_controller *mhi_cntrl,
 
 static bool is_valid_ring_ptr(struct mhi_ring *ring, dma_addr_t addr)
 {
-	return addr >= ring->iommu_base && addr < ring->iommu_base + ring->len;
+	return addr >= ring->iommu_base && addr < ring->iommu_base + ring->len &&
+			!(addr & (sizeof(struct mhi_ring_element) - 1));
 }
 
 int mhi_destroy_device(struct device *dev, void *data)


