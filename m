Return-Path: <stable+bounces-225694-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFf9F1JluGlOdQEAu9opvQ
	(envelope-from <stable+bounces-225694-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 21:17:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB512A01DA
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 21:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA7CD3026881
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 20:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DAC3DB64F;
	Mon, 16 Mar 2026 20:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRIwUCZN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24321391824
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 20:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773692240; cv=none; b=ZinkkNW/uHuwWWMeALMSyss0DuzdfLGglgnXqPQnS4KyI1ylSb9ig4xLZ75v2WFmSAioFFy5BMuLjeyvsbOc3N3x4laC9g10Yp8tTfSnReeRpub9U7V/A3p+u0oefVwfOzJVL01+OOpj+dkMpT4CheNkM77jVJQEe3XvbNJD29Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773692240; c=relaxed/simple;
	bh=0nwNcPujMqhIj9owQRaw5kSxiZ8Hp8QKQUKT2uEasxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=auciDv+GHg0cLOcoVKBvAITC4kO2YZbdroaZwfWXinluFcfYsbY42HdiMpsESXyVVktApTR231tfNNlpNBgDwsykMDjQfw32TnHkiFRlsU1wb7BsxBUN6dt2qvMaw6JTA3OiotM9vvMI7qTlZXPEw0VqaHpDuifdrnJTBqLSPfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRIwUCZN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606A7C2BCAF;
	Mon, 16 Mar 2026 20:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773692239;
	bh=0nwNcPujMqhIj9owQRaw5kSxiZ8Hp8QKQUKT2uEasxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BRIwUCZNBho26ycPnyc9NWp/LyLUQxaqjyL1wZ2BRixyo7s5838i6dk17mUDZoLYX
	 kuwLfCQRJ1wPhsgqA3iPVyhp1JQ1WUNbAZdZkTIm99ROmeSX2F33L9yLzrUVlm6nHa
	 OgS0zOkLfUZPbuMJlc3TzzYlgZcVD8m13sev41Q51tMalqO6VK2bBBEUslhPpHU73X
	 /AtrZ3AW6cl6alI+Pu942t6wjhwjHnZYld5WuYduUM32N3hbVBvcHY2u7qceLbBYsl
	 +Xn3cnmaG8YvNpUuApoIZXNYunqint4xAJDuGnJMvI3ldqPQfMzz8WPbhfJ6EoX9zh
	 vrbOPWaZ4xXAg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	syzbot+f6a46b038fc243ac0175@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] KVM: arm64: Eagerly init vgic dist/redist on vgic creation
Date: Mon, 16 Mar 2026 16:17:16 -0400
Message-ID: <20260316201716.1375450-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260316201716.1375450-1-sashal@kernel.org>
References: <2026031608-gathering-rethink-9d83@gregkh>
 <20260316201716.1375450-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-225694-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,f6a46b038fc243ac0175];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CEB512A01DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Marc Zyngier <maz@kernel.org>

[ Upstream commit ac6769c8f948dff33265c50e524aebf9aa6f1be0 ]

If vgic_allocate_private_irqs_locked() fails for any odd reason,
we exit kvm_vgic_create() early, leaving dist->rd_regions uninitialised.

kvm_vgic_dist_destroy() then comes along and walks into the weeds
trying to free the RDs. Got to love this stuff.

Solve it by moving all the static initialisation early, and make
sure that if we fail halfway, we're in a reasonable shape to
perform the rest of the teardown. While at it, reset the vgic model
on failure, just in case...

Reported-by: syzbot+f6a46b038fc243ac0175@syzkaller.appspotmail.com
Tested-by: syzbot+f6a46b038fc243ac0175@syzkaller.appspotmail.com
Fixes: b3aa9283c0c50 ("KVM: arm64: vgic: Hoist SGI/PPI alloc from vgic_init() to kvm_create_vgic()")
Link: https://lore.kernel.org/r/69a2d58c.050a0220.3a55be.003b.GAE@google.com
Link: https://patch.msgid.link/20260228164559.936268-1-maz@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/vgic/vgic-init.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-init.c b/arch/arm64/kvm/vgic/vgic-init.c
index 3ebd336f3af4d..30fa88e49be49 100644
--- a/arch/arm64/kvm/vgic/vgic-init.c
+++ b/arch/arm64/kvm/vgic/vgic-init.c
@@ -143,6 +143,21 @@ int kvm_vgic_create(struct kvm *kvm, u32 type)
 	kvm->arch.vgic.in_kernel = true;
 	kvm->arch.vgic.vgic_model = type;
 	kvm->arch.vgic.implementation_rev = KVM_VGIC_IMP_REV_LATEST;
+	kvm->arch.vgic.vgic_dist_base = VGIC_ADDR_UNDEF;
+
+	aa64pfr0 = kvm_read_vm_id_reg(kvm, SYS_ID_AA64PFR0_EL1) & ~ID_AA64PFR0_EL1_GIC;
+	pfr1 = kvm_read_vm_id_reg(kvm, SYS_ID_PFR1_EL1) & ~ID_PFR1_EL1_GIC;
+
+	if (type == KVM_DEV_TYPE_ARM_VGIC_V2) {
+		kvm->arch.vgic.vgic_cpu_base = VGIC_ADDR_UNDEF;
+	} else {
+		INIT_LIST_HEAD(&kvm->arch.vgic.rd_regions);
+		aa64pfr0 |= SYS_FIELD_PREP_ENUM(ID_AA64PFR0_EL1, GIC, IMP);
+		pfr1 |= SYS_FIELD_PREP_ENUM(ID_PFR1_EL1, GIC, GICv3);
+	}
+
+	kvm_set_vm_id_reg(kvm, SYS_ID_AA64PFR0_EL1, aa64pfr0);
+	kvm_set_vm_id_reg(kvm, SYS_ID_PFR1_EL1, pfr1);
 
 	kvm_for_each_vcpu(i, vcpu, kvm) {
 		ret = vgic_allocate_private_irqs_locked(vcpu, type);
@@ -157,25 +172,10 @@ int kvm_vgic_create(struct kvm *kvm, u32 type)
 			vgic_cpu->private_irqs = NULL;
 		}
 
+		kvm->arch.vgic.vgic_model = 0;
 		goto out_unlock;
 	}
 
-	kvm->arch.vgic.vgic_dist_base = VGIC_ADDR_UNDEF;
-
-	aa64pfr0 = kvm_read_vm_id_reg(kvm, SYS_ID_AA64PFR0_EL1) & ~ID_AA64PFR0_EL1_GIC;
-	pfr1 = kvm_read_vm_id_reg(kvm, SYS_ID_PFR1_EL1) & ~ID_PFR1_EL1_GIC;
-
-	if (type == KVM_DEV_TYPE_ARM_VGIC_V2) {
-		kvm->arch.vgic.vgic_cpu_base = VGIC_ADDR_UNDEF;
-	} else {
-		INIT_LIST_HEAD(&kvm->arch.vgic.rd_regions);
-		aa64pfr0 |= SYS_FIELD_PREP_ENUM(ID_AA64PFR0_EL1, GIC, IMP);
-		pfr1 |= SYS_FIELD_PREP_ENUM(ID_PFR1_EL1, GIC, GICv3);
-	}
-
-	kvm_set_vm_id_reg(kvm, SYS_ID_AA64PFR0_EL1, aa64pfr0);
-	kvm_set_vm_id_reg(kvm, SYS_ID_PFR1_EL1, pfr1);
-
 	if (type == KVM_DEV_TYPE_ARM_VGIC_V3)
 		kvm->arch.vgic.nassgicap = system_supports_direct_sgis();
 
-- 
2.51.0


