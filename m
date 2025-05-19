Return-Path: <stable+bounces-144841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3194ABBED1
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 15:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D6437A1EE0
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 13:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D966B1F4717;
	Mon, 19 May 2025 13:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y1IGZKiA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A018A55
	for <stable@vger.kernel.org>; Mon, 19 May 2025 13:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747660408; cv=none; b=WzAl2p75kgB4gISVTpxvwYkxwXozuZtGURFviImDG+wCRMDt0ktZjQLkTtfIUfcNIVyhlFusrfp+eScjoG96YYvryvu4rIYZB5YrP4gOLbvSMaNB9K1EXT0QrQQXh1Q435ptjdnD0Okr5y7p0PhyV4dI9SCLmT1G7Rbd1nyWAzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747660408; c=relaxed/simple;
	bh=0K+M8phmKCnu/9term+O+oOWK/IBJo1dvpGEMsRTtsA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VZwAhmtnduMIJxubAT8+FiIZOApw/+GvEX4emwdcalr18RjGMn7vhrYJ4V7HSNcjhNtmxAWrDkpsplE6OG/7kBhtNh0gthdf3QyZuOyZ5ixK8xqTShOAjgLIGCfUN3xWrKOJxRciJgTioK1XmHI/0ZTY/bfn7RvUA1fu/cpTH6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y1IGZKiA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24DAC4CEE4;
	Mon, 19 May 2025 13:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747660408;
	bh=0K+M8phmKCnu/9term+O+oOWK/IBJo1dvpGEMsRTtsA=;
	h=Subject:To:Cc:From:Date:From;
	b=Y1IGZKiAXmpcBYcE4DO8UTilNYo7+VUw0zQDMqecJDSqcAEoPn8huSX3PdjYiTGXo
	 vaJlsmBNtUFu3Dy6nIISgBm2RlveTyTSoFDoYtJgO2e4CvJAkrjFrbHGfq7NpqulQw
	 A711jKgvIPANhQrbOzRlE+oY6K1zQdz/cK/ZnI3c=
Subject: FAILED: patch "[PATCH] nvmet: pci-epf: clear completion queue IRQ flag on delete" failed to apply to 6.14-stable tree
To: dlemoal@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 May 2025 15:13:14 +0200
Message-ID: <2025051914-expulsion-cinema-9689@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.14.y
git checkout FETCH_HEAD
git cherry-pick -x 85adf2094abb9084770dc4ab302aaa9c5d26dd2d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051914-expulsion-cinema-9689@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 85adf2094abb9084770dc4ab302aaa9c5d26dd2d Mon Sep 17 00:00:00 2001
From: Damien Le Moal <dlemoal@kernel.org>
Date: Fri, 9 May 2025 08:25:00 +0900
Subject: [PATCH] nvmet: pci-epf: clear completion queue IRQ flag on delete

The function nvmet_pci_epf_delete_cq() unconditionally calls
nvmet_pci_epf_remove_irq_vector() even for completion queues that do not
have interrupts enabled. Furthermore, for completion queues that do
have IRQ enabled, deleting and re-creating the completion queue leaves
the flag NVMET_PCI_EPF_Q_IRQ_ENABLED set, even if the completion queue
is being re-created with IRQ disabled.

Fix these issues by calling nvmet_pci_epf_remove_irq_vector() only if
NVMET_PCI_EPF_Q_IRQ_ENABLED is set and make sure to always clear that
flag.

Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 7fab7f3d79b7..d5442991f2fb 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -1344,7 +1344,8 @@ static u16 nvmet_pci_epf_delete_cq(struct nvmet_ctrl *tctrl, u16 cqid)
 
 	cancel_delayed_work_sync(&cq->work);
 	nvmet_pci_epf_drain_queue(cq);
-	nvmet_pci_epf_remove_irq_vector(ctrl, cq->vector);
+	if (test_and_clear_bit(NVMET_PCI_EPF_Q_IRQ_ENABLED, &cq->flags))
+		nvmet_pci_epf_remove_irq_vector(ctrl, cq->vector);
 	nvmet_pci_epf_mem_unmap(ctrl->nvme_epf, &cq->pci_map);
 
 	return NVME_SC_SUCCESS;


