Return-Path: <stable+bounces-23662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFAF8671A1
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 11:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77D261F2BF4C
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 10:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24681CD06;
	Mon, 26 Feb 2024 10:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SD7p+PZ1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BBB1D52B
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 10:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708943617; cv=none; b=PBVftfufVR1OMwjdv328tESAW1/9bJ5iF2UCzWc+W2pb2BShKgMqkhO0/7VyKI/YJA/0T9HcMefkk2ujzlDn3NSbTqbrJF4QP/rR3/gy2mM8oZHiFUcbZZf4rMcw25jCCMdzr/d66bFe3kH86Z1e538TZ5wGOgFq4cYIFgGpaEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708943617; c=relaxed/simple;
	bh=ec0IJV20UMnm/+d1CFIsiVyHPEXE+iitGdeHyEPVNAM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BiyvAL/4yjcScvvLb5SHv7OugZAxaVwwrvClCvxEcCbYlc7IjNPRgsQRldDoeoL6Er+b+To2iO9syWlR49FkbcM+H64idWvmjjaKImi/CLNPGYhvBgjBfKVaiNKZrepDr7JpOMrd23rBHMQCXPEjAtphZMPRBJXBc4JWeuMXABw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SD7p+PZ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB19C433C7;
	Mon, 26 Feb 2024 10:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708943617;
	bh=ec0IJV20UMnm/+d1CFIsiVyHPEXE+iitGdeHyEPVNAM=;
	h=Subject:To:Cc:From:Date:From;
	b=SD7p+PZ1/AVLy/xSEp00EOGgNwTz2prakT+/+tONDq9iVDceAWPT1mQNhXtYy8AhM
	 XPr0+R3ECr+FYxirt34Jt4lWznf04bbKbl6se7j+wUq23iOIJWn8/cVJ6ZR3W31iCr
	 Rn+a1h16S5y3aZDEljWg8vLwouoBRvad28fE7Yq8=
Subject: FAILED: patch "[PATCH] KVM: arm64: vgic-its: Test for valid IRQ in" failed to apply to 5.4-stable tree
To: oliver.upton@linux.dev,maz@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Feb 2024 11:33:34 +0100
Message-ID: <2024022634-rut-premises-24cc@gregkh>
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
git cherry-pick -x 8d3a7dfb801d157ac423261d7cd62c33e95375f8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024022634-rut-premises-24cc@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

8d3a7dfb801d ("KVM: arm64: vgic-its: Test for valid IRQ in its_sync_lpi_pending_table()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8d3a7dfb801d157ac423261d7cd62c33e95375f8 Mon Sep 17 00:00:00 2001
From: Oliver Upton <oliver.upton@linux.dev>
Date: Wed, 21 Feb 2024 09:27:31 +0000
Subject: [PATCH] KVM: arm64: vgic-its: Test for valid IRQ in
 its_sync_lpi_pending_table()

vgic_get_irq() may not return a valid descriptor if there is no ITS that
holds a valid translation for the specified INTID. If that is the case,
it is safe to silently ignore it and continue processing the LPI pending
table.

Cc: stable@vger.kernel.org
Fixes: 33d3bc9556a7 ("KVM: arm64: vgic-its: Read initial LPI pending table")
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
Link: https://lore.kernel.org/r/20240221092732.4126848-2-oliver.upton@linux.dev
Signed-off-by: Marc Zyngier <maz@kernel.org>

diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index e2764d0ffa9f..082448de27ed 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -468,6 +468,9 @@ static int its_sync_lpi_pending_table(struct kvm_vcpu *vcpu)
 		}
 
 		irq = vgic_get_irq(vcpu->kvm, NULL, intids[i]);
+		if (!irq)
+			continue;
+
 		raw_spin_lock_irqsave(&irq->irq_lock, flags);
 		irq->pending_latch = pendmask & (1U << bit_nr);
 		vgic_queue_irq_unlock(vcpu->kvm, irq, flags);


