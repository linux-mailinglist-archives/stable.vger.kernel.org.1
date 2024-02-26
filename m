Return-Path: <stable+bounces-23663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6978671A2
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 11:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6D4B292CF4
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 10:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81DF1D545;
	Mon, 26 Feb 2024 10:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P4op/pIM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DFA1D532
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 10:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708943626; cv=none; b=LlUn9EfpVkTisqppgkKX47xPpoCjpFEeiZQpzMOw1/h0/YAZBHGbPM7Pr+cWW5lhScjZHBT/2XsI0MX+aD986gRP/f/oWtZ7fJvP56NnoofWhFgJqmaxYjT/drxp2GyPX03Fs73sCx+ilyWuUsITNHnj7rfDlu/6O3aErLQ110s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708943626; c=relaxed/simple;
	bh=lHaxNs/9kLEwv+KjZzfyk97VR+W5q8a8ig18qmfCEkA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WjvE9fCROTDRbwDSSXpNlSfcezmslcr44N2M5gYy0i824WDjHw4bc7Ap4obMYHRweM3573YhVOZ6emO0SsotAdnPwCLWrRP4SllEQA9uw+Fe/gLyFSk+1ChixXtnun9A+q3hYS+MOARUJoMQ2VgYJ0kNX4k7ukAjpKq3qiZBFsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P4op/pIM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8F9C433C7;
	Mon, 26 Feb 2024 10:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708943626;
	bh=lHaxNs/9kLEwv+KjZzfyk97VR+W5q8a8ig18qmfCEkA=;
	h=Subject:To:Cc:From:Date:From;
	b=P4op/pIM3gTtsy19XAGcj59Qnk+2PXFXCyiHypB8TlBsICft0355N90t6QKEcIAmD
	 1r0pn/+lzifsQh5+2qxh5n1Ot0uaNnpZruFyWouGfCgxr3H9+2OXkdxTziV/WCG/yI
	 FuRDytWThh/avdRSGfZkpXRjffTZuQBpcBHX1a7E=
Subject: FAILED: patch "[PATCH] KVM: arm64: vgic-its: Test for valid IRQ in" failed to apply to 4.19-stable tree
To: oliver.upton@linux.dev,maz@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Feb 2024 11:33:35 +0100
Message-ID: <2024022635-thinner-disinfect-f761@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 8d3a7dfb801d157ac423261d7cd62c33e95375f8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024022635-thinner-disinfect-f761@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

8d3a7dfb801d ("KVM: arm64: vgic-its: Test for valid IRQ in its_sync_lpi_pending_table()")
9ed24f4b712b ("KVM: arm64: Move virt/kvm/arm to arch/arm64")
3b50142d8528 ("MAINTAINERS: sort field names for all entries")
4400b7d68f6e ("MAINTAINERS: sort entries by entry name")
b032227c6293 ("Merge tag 'nios2-v5.7-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/lftan/nios2")

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


