Return-Path: <stable+bounces-23661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 634AB8671A0
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 11:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D2C51C27F89
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 10:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9212C1CFA9;
	Mon, 26 Feb 2024 10:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K92Exyx9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F751EEEA
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 10:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708943610; cv=none; b=qN1oblzSIjBKcefSENJtQktzL9D5MLEndA6Z6+Y1LMG6RO6rrUBnVaOVoguVVZ5SLUC56F7dJCGp4wWEGadvXblKdAu6UaNRHNqHSClloK6nKjAoJF6xuE43EMulxDHNVepBjOrPkVnhnESazNpOP3V5PM+9SCbgL66v8fHKfLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708943610; c=relaxed/simple;
	bh=eXXNt78zw9qzrnZPz41a2Fbn2AuKvQzMO8t6Jx1fg5E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HhFdzo4BMhL4fpWwFQZa5+tPxsc73XR6I5qWHCrduADdP0q3FNco5ao1hE8RZq5bqIuRoLbHkpKBrIkYCVfQ/E6AP2uLHleeop1m0uUYh4B/wOQYWpP3WjgaGmsH+PCft6m+W+LS/oVafMfEWi0ggYT3BsI815mzqfdwD0Bolw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K92Exyx9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0AEC433F1;
	Mon, 26 Feb 2024 10:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708943609;
	bh=eXXNt78zw9qzrnZPz41a2Fbn2AuKvQzMO8t6Jx1fg5E=;
	h=Subject:To:Cc:From:Date:From;
	b=K92Exyx9z0VbXkmzt+5jkAaD3YJM23VMAADklpq1NkpL8tVODeSiDtQosxloonN02
	 2uuj2By5B4HajAdlhUTDcWbKCzUgfQWj3CQBEykpqTscNAR8FivufV3eG+kNOM/7yN
	 Bz66VpKOBTE+udRmux4wXaS6ZScLu08bSHnb10Gw=
Subject: FAILED: patch "[PATCH] KVM: arm64: vgic-its: Test for valid IRQ in MOVALL handler" failed to apply to 4.19-stable tree
To: oliver.upton@linux.dev,maz@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Feb 2024 11:33:19 +0100
Message-ID: <2024022619-opulently-accustom-dbe1@gregkh>
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
git cherry-pick -x 85a71ee9a0700f6c18862ef3b0011ed9dad99aca
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024022619-opulently-accustom-dbe1@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

85a71ee9a070 ("KVM: arm64: vgic-its: Test for valid IRQ in MOVALL handler")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 85a71ee9a0700f6c18862ef3b0011ed9dad99aca Mon Sep 17 00:00:00 2001
From: Oliver Upton <oliver.upton@linux.dev>
Date: Wed, 21 Feb 2024 09:27:32 +0000
Subject: [PATCH] KVM: arm64: vgic-its: Test for valid IRQ in MOVALL handler

It is possible that an LPI mapped in a different ITS gets unmapped while
handling the MOVALL command. If that is the case, there is no state that
can be migrated to the destination. Silently ignore it and continue
migrating other LPIs.

Cc: stable@vger.kernel.org
Fixes: ff9c114394aa ("KVM: arm/arm64: GICv4: Handle MOVALL applied to a vPE")
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
Link: https://lore.kernel.org/r/20240221092732.4126848-3-oliver.upton@linux.dev
Signed-off-by: Marc Zyngier <maz@kernel.org>

diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index 082448de27ed..28a93074eca1 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -1435,6 +1435,8 @@ static int vgic_its_cmd_handle_movall(struct kvm *kvm, struct vgic_its *its,
 
 	for (i = 0; i < irq_count; i++) {
 		irq = vgic_get_irq(kvm, NULL, intids[i]);
+		if (!irq)
+			continue;
 
 		update_affinity(irq, vcpu2);
 


