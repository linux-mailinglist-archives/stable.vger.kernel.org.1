Return-Path: <stable+bounces-225686-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gF3eKs9buGl0cgEAu9opvQ
	(envelope-from <stable+bounces-225686-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 20:36:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 567C429FD62
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 20:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B0CA6302A9DD
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 19:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D883E717E;
	Mon, 16 Mar 2026 19:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WoZ42LTq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBAE3254A9
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 19:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773689803; cv=none; b=iVnTTpYwXEl36cV4PRL2ybT2GCuULxGXrOvpH1x2dIBzsOmhaqVFW9tirCU9/A6zsVIjCVFhn8OjzJZWX6u5hgYSa10sRWXvQDF7FfO+3s+qeEtjA14qLkHUg7sNZuM6waTXK/TJ0xQuVauXPuufw8cXCa8qRJS5XwBdxUXMAas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773689803; c=relaxed/simple;
	bh=ZxFduGVBFj9we3SvY+IL8UlvXbjmSOI6nUedaleYUas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R70sBZu3mnLo+IvO5BFN+D6oWZyU2Hy0IoEN7yHGQ59sltdD4hblbD9brcs2Xky/KiyXWqFyqg6GafaDT53Ez/DyeJMgrDPs5+M+RXoSZzu1h4f1eosMEqyLLVKuDhu9sB7hO1LpHqEI8dRKMJ/fhJVCHeRIVVdLNC9uRKwHycM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WoZ42LTq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93EAC2BC9E;
	Mon, 16 Mar 2026 19:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773689803;
	bh=ZxFduGVBFj9we3SvY+IL8UlvXbjmSOI6nUedaleYUas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WoZ42LTqQtG8EwZp2emQHalOEJRihuUm031kpgxozwxLnqtimL6MKtn5EJvJPAXXa
	 XSzZ4xwGqz/srzSXWdnpLdToN4+CAaVIhFogyBlQ/fAWZ+n2hv4Q4qurnqApINuxH6
	 1TubXG8OFzPorcuaXM82oR5Wfx9d0U5eK2mL4A94r0eMXTsPN/OHXNcI3Qsm5+F5Ik
	 BIpG+p5IP2sstf0f/MWwoXAu5B7NZEjX4MDorErusc5s3sMs1wLuJmEVKfhXO4B5J6
	 Y1cnP5b/DaC061kPP9MIk+D/ahxrTjw2G9+CAd2HQOxaCOhLdevAsCcRW1Z6Sl5qsy
	 x17+WY+OUO3Mw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	syzbot+f6a46b038fc243ac0175@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19.y 2/2] KVM: arm64: Eagerly init vgic dist/redist on vgic creation
Date: Mon, 16 Mar 2026 15:36:40 -0400
Message-ID: <20260316193640.1358554-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260316193640.1358554-1-sashal@kernel.org>
References: <2026031607-maimed-erasable-eac8@gregkh>
 <20260316193640.1358554-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225686-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,f6a46b038fc243ac0175];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,appspotmail.com:email]
X-Rspamd-Queue-Id: 567C429FD62
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
index 86c149537493f..6ed01c7faa91d 100644
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


