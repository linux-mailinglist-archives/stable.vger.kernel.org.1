Return-Path: <stable+bounces-14354-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8DD8380AE
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80F65B2B724
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B177A12FF77;
	Tue, 23 Jan 2024 01:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XZQsZY1Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F45D657B3;
	Tue, 23 Jan 2024 01:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971794; cv=none; b=hwQMtJf9XalvOIOnZE6Xe3jmzl1pvt4qbrzhX+c2+w2LUxx87ylaf2cNbwNmSxGQY0WHpIBnshcqKSG86cTf5AAdl9t5AC4AsuREKPgqV3e04O8X6X0+ggcFVc6e4lMxhAuO7askRViJUhqe3VIWdpHeEHY6ENb7eBL8mmKVoSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971794; c=relaxed/simple;
	bh=r1pcOx0OUp3TiixMlTQhhPcdwLWu6L+U15OMzLDMfIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZIdTheUK+7oVWiW4J4JE6F+gFO8NotJ4uDa8P6gasYc4f/mOjp6PCPLCbnaHv60DSGYNskeyWhmvv52Z5w81qXwN4wGvn0hrKYhpnrY234d4Ryj8hcCxmv0pWwgF6pf8DIQBwkxRXb9myyb93MxC7Qa+6xQPPCouRAjmlVzgmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XZQsZY1Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6D0C433F1;
	Tue, 23 Jan 2024 01:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705971794;
	bh=r1pcOx0OUp3TiixMlTQhhPcdwLWu6L+U15OMzLDMfIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XZQsZY1ZHfSmtbhPIRGmGXu/1ps5GdCBuujZvaDbZsJqG1Z+xo4s/UnNVeCbpZvSu
	 O7fG0PLL/YrqArTytzmIwhVrf3gVlBxCOWbgU2H3M6Gpb3Dz0FVYYMg67fnawk0aYf
	 t371AapNLUcv3k94fHm0tV5v8dPfXLBXprhyUGV4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kunkun Jiang <jiangkunkun@huawei.com>,
	Marc Zyngier <maz@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH 5.10 232/286] KVM: arm64: vgic-v4: Restore pending state on host userspace write
Date: Mon, 22 Jan 2024 15:58:58 -0800
Message-ID: <20240122235741.004487123@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235732.009174833@linuxfoundation.org>
References: <20240122235732.009174833@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <maz@kernel.org>

commit 7b95382f965133ef61ce44aaabc518c16eb46909 upstream.

When the VMM writes to ISPENDR0 to set the state pending state of
an SGI, we fail to convey this to the HW if this SGI is already
backed by a GICv4.1 vSGI.

This is a bit of a corner case, as this would only occur if the
vgic state is changed on an already running VM, but this can
apparently happen across a guest reset driven by the VMM.

Fix this by always writing out the pending_latch value to the
HW, and reseting it to false.

Reported-by: Kunkun Jiang <jiangkunkun@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Cc: stable@vger.kernel.org # 5.10+
Link: https://lore.kernel.org/r/7e7f2c0c-448b-10a9-8929-4b8f4f6e2a32@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kvm/vgic/vgic-mmio-v3.c |   27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -356,19 +356,26 @@ static int vgic_v3_uaccess_write_pending
 		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, intid + i);
 
 		raw_spin_lock_irqsave(&irq->irq_lock, flags);
-		if (test_bit(i, &val)) {
-			/*
-			 * pending_latch is set irrespective of irq type
-			 * (level or edge) to avoid dependency that VM should
-			 * restore irq config before pending info.
-			 */
-			irq->pending_latch = true;
-			vgic_queue_irq_unlock(vcpu->kvm, irq, flags);
-		} else {
+
+		/*
+		 * pending_latch is set irrespective of irq type
+		 * (level or edge) to avoid dependency that VM should
+		 * restore irq config before pending info.
+		 */
+		irq->pending_latch = test_bit(i, &val);
+
+		if (irq->hw && vgic_irq_is_sgi(irq->intid)) {
+			irq_set_irqchip_state(irq->host_irq,
+					      IRQCHIP_STATE_PENDING,
+					      irq->pending_latch);
 			irq->pending_latch = false;
-			raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
 		}
 
+		if (irq->pending_latch)
+			vgic_queue_irq_unlock(vcpu->kvm, irq, flags);
+		else
+			raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
+
 		vgic_put_irq(vcpu->kvm, irq);
 	}
 



