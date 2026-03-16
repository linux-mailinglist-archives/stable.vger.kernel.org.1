Return-Path: <stable+bounces-225693-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEALKFJluGlOdQEAu9opvQ
	(envelope-from <stable+bounces-225693-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 21:17:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2610E2A01DB
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 21:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E6733045206
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 20:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3985366043;
	Mon, 16 Mar 2026 20:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrPNJ+l6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772BA2C0F78
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 20:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773692239; cv=none; b=a06I0vEO4Nh2/AXI+Nj92G9D0B81gaNkwsVrRPDUgV+SwIviHqIncMFW7GfcUo/ezRAv6wgw/+aRRGPkGpfwjOvnUyGweIjEZbvYWT4/3/rAkgBvN1Ka1Jgw2z4M2oXC1fY9y7B/lamYc6BKcDkyNudTGoT6bNusANgs/kZUDXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773692239; c=relaxed/simple;
	bh=N9+JFwtOdLdvGPDv36ZRmN5eoODGs0E0lm3OxFBmIPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YRgxNMqnZ/yJVf2+tS9bZooID1cTG/1QnF7VaQcjWe6p4GX+UW6bVva6Owj7cBqTIv8A5Wympkqo0x5sJPqO6w1vViLqnmKHBQYu2efFpNbylMto3G0VARu5mb6AyW9aG+iFkzzfXVAEg//8WB9d9vVfcTnpC5cIb0BHo7G1kkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrPNJ+l6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D426C19421;
	Mon, 16 Mar 2026 20:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773692239;
	bh=N9+JFwtOdLdvGPDv36ZRmN5eoODGs0E0lm3OxFBmIPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LrPNJ+l6YYM9smtg7sxfFlH4qgHUuRfwOHCsuAA1BxVplPS3sPyjMcG4IGjxfQe1E
	 7NB8z/lbvAa9ABxsQaw96yanCIe3HcD57N1FzahWjY+Xf8h31T0U3eKtH98rOb4aNp
	 EddbTFdJdRzBwDYaKw2lomZ1fOSjkWqMDkJWPVPuW3laXqjfOp2w8748g/Ht3jbsOP
	 qCX4/M6Ph8AH6pGX53rEw9yUd21sZKZPAymSpRWjur9pHgntWtKoZCY8dkpz1b0bUC
	 8xeSgV1aea+Tg9mxwuO/aTmgjA5bjABpOHgrqtKGiQKzKl0izTbX5p5ndWfm+CGFTR
	 eKz46T//KcXXw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sascha Bischoff <Sascha.Bischoff@arm.com>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Marc Zyngier <maz@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] KVM: arm64: gic: Set vgic_model before initing private IRQs
Date: Mon, 16 Mar 2026 16:17:15 -0400
Message-ID: <20260316201716.1375450-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031608-gathering-rethink-9d83@gregkh>
References: <2026031608-gathering-rethink-9d83@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225693-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2610E2A01DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sascha Bischoff <Sascha.Bischoff@arm.com>

[ Upstream commit 9435c1e1431003e23aa34ef8e46c30d09c3dbcb5 ]

Different GIC types require the private IRQs to be initialised
differently. GICv5 is the culprit as it supports both a different
number of private IRQs, and all of these are PPIs (there are no
SGIs). Moreover, as GICv5 uses the top bits of the interrupt ID to
encode the type, the intid also needs to computed differently.

Up until now, the GIC model has been set after initialising the
private IRQs for a VCPU. Move this earlier to ensure that the GIC
model is available when configuring the private IRQs. While we're at
it, also move the setting of the in_kernel flag and implementation
revision to keep them grouped together as before.

Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Link: https://patch.msgid.link/20260128175919.3828384-7-sascha.bischoff@arm.com
Signed-off-by: Marc Zyngier <maz@kernel.org>
Stable-dep-of: ac6769c8f948 ("KVM: arm64: Eagerly init vgic dist/redist on vgic creation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/vgic/vgic-init.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-init.c b/arch/arm64/kvm/vgic/vgic-init.c
index da62edbc1205a..3ebd336f3af4d 100644
--- a/arch/arm64/kvm/vgic/vgic-init.c
+++ b/arch/arm64/kvm/vgic/vgic-init.c
@@ -140,6 +140,10 @@ int kvm_vgic_create(struct kvm *kvm, u32 type)
 		goto out_unlock;
 	}
 
+	kvm->arch.vgic.in_kernel = true;
+	kvm->arch.vgic.vgic_model = type;
+	kvm->arch.vgic.implementation_rev = KVM_VGIC_IMP_REV_LATEST;
+
 	kvm_for_each_vcpu(i, vcpu, kvm) {
 		ret = vgic_allocate_private_irqs_locked(vcpu, type);
 		if (ret)
@@ -156,10 +160,6 @@ int kvm_vgic_create(struct kvm *kvm, u32 type)
 		goto out_unlock;
 	}
 
-	kvm->arch.vgic.in_kernel = true;
-	kvm->arch.vgic.vgic_model = type;
-	kvm->arch.vgic.implementation_rev = KVM_VGIC_IMP_REV_LATEST;
-
 	kvm->arch.vgic.vgic_dist_base = VGIC_ADDR_UNDEF;
 
 	aa64pfr0 = kvm_read_vm_id_reg(kvm, SYS_ID_AA64PFR0_EL1) & ~ID_AA64PFR0_EL1_GIC;
-- 
2.51.0


