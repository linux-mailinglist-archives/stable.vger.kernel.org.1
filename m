Return-Path: <stable+bounces-132941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3B0A9188F
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 12:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EACC5A11FA
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 10:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A4922618F;
	Thu, 17 Apr 2025 10:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yBPW65l5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2666D1C84AD
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 10:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744884059; cv=none; b=tgNibPbpYSfbOZ1K4MM+uh3Z6GPh0qHKr/8LfD99Z4AQ/cbEdkfMTaO+JZAkS897odiY/X59EVLLeOoCmmYbsIYIsX0SE5zvQVImR8TphmZSxSa0QSzqBLhdVdwanIh1GWLWrlfqvGfwvGW8xs7UD60OMiyANi2HrG+29kmSsWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744884059; c=relaxed/simple;
	bh=yhdf3ijt0HUuz/E7ZDHlflgNmToaShc2fnEdxWWWm1w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=k4ZQeQeJJtmP8sdOGjTUI/VUVPWhre2wqk8V7Toj2zs4fJ9YtxZzPaDCE53MLJ1xp1qHDH1z8QMVAO5Omi6jmkLVGwnoUix7S/CSQtD7ueWvJgyO9C5RhL/zW+xqRslDmT0eFR4Q0yro9zUBta+fXHnTJFnYtAB1gU3EOB3agQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yBPW65l5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28302C4CEE4;
	Thu, 17 Apr 2025 10:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744884058;
	bh=yhdf3ijt0HUuz/E7ZDHlflgNmToaShc2fnEdxWWWm1w=;
	h=Subject:To:Cc:From:Date:From;
	b=yBPW65l58QhlM/QkwVshO1yPR4en5+YNVufovWQ6PFfh17T28qVHmDl2aYMJknz7U
	 XdcrJRvS/aodto7jaLaGODw23+gC0hTS5mPu1Sifa5x1VrK4mMLs2sM5w7MaWwG2eZ
	 UYG5pEIuIPb3/Y3K3/VsilYL7K8vp2wjxmvzvGxI=
Subject: FAILED: patch "[PATCH] KVM: arm64: PMU: Set raw values from user to" failed to apply to 6.12-stable tree
To: akihiko.odaki@daynix.com,maz@kernel.org,oliver.upton@linux.dev
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 12:00:50 +0200
Message-ID: <2025041750-handbook-landowner-fbdc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x f2aeb7bbd5745fbcf7f0769e29a184e24924b9a9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041750-handbook-landowner-fbdc@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f2aeb7bbd5745fbcf7f0769e29a184e24924b9a9 Mon Sep 17 00:00:00 2001
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 15 Mar 2025 18:12:10 +0900
Subject: [PATCH] KVM: arm64: PMU: Set raw values from user to
 PM{C,I}NTEN{SET,CLR}, PMOVS{SET,CLR}

Commit a45f41d754e0 ("KVM: arm64: Add {get,set}_user for
PM{C,I}NTEN{SET,CLR}, PMOVS{SET,CLR}") changed KVM_SET_ONE_REG to update
the mentioned registers in a way matching with the behavior of guest
register writes. This is a breaking change of a UAPI though the new
semantics looks cleaner and VMMs are not prepared for this.

Firecracker, QEMU, and crosvm perform migration by listing registers
with KVM_GET_REG_LIST, getting their values with KVM_GET_ONE_REG and
setting them with KVM_SET_ONE_REG. This algorithm assumes
KVM_SET_ONE_REG restores the values retrieved with KVM_GET_ONE_REG
without any alteration. However, bit operations added by the earlier
commit do not preserve the values retried with KVM_GET_ONE_REG and
potentially break migration.

Remove the bit operations that alter the values retrieved with
KVM_GET_ONE_REG.

Cc: stable@vger.kernel.org
Fixes: a45f41d754e0 ("KVM: arm64: Add {get,set}_user for PM{C,I}NTEN{SET,CLR}, PMOVS{SET,CLR}")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20250315-pmc-v5-1-ecee87dab216@daynix.com
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 82430c1e1dd0..ffee72fd1273 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1051,26 +1051,9 @@ static bool access_pmu_evtyper(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 
 static int set_pmreg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r, u64 val)
 {
-	bool set;
-
-	val &= kvm_pmu_accessible_counter_mask(vcpu);
-
-	switch (r->reg) {
-	case PMOVSSET_EL0:
-		/* CRm[1] being set indicates a SET register, and CLR otherwise */
-		set = r->CRm & 2;
-		break;
-	default:
-		/* Op2[0] being set indicates a SET register, and CLR otherwise */
-		set = r->Op2 & 1;
-		break;
-	}
-
-	if (set)
-		__vcpu_sys_reg(vcpu, r->reg) |= val;
-	else
-		__vcpu_sys_reg(vcpu, r->reg) &= ~val;
+	u64 mask = kvm_pmu_accessible_counter_mask(vcpu);
 
+	__vcpu_sys_reg(vcpu, r->reg) = val & mask;
 	return 0;
 }
 


