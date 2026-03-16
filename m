Return-Path: <stable+bounces-225665-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IB8oDBhWuGmKcAEAu9opvQ
	(envelope-from <stable+bounces-225665-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 20:12:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E47929F955
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 20:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE19D301DCD5
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 19:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2B226FD9A;
	Mon, 16 Mar 2026 19:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjDnSpwh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D598340DFAD
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 19:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773688339; cv=none; b=pEEH+TZj3QDRxdogFNe80jP6LszB6C1ZE/icLeLG3f+wkqSx539mJdseoGtl0eaGbdiT0q2eYGXCt9h3tYEYb50/axCF4ZFkY9Gqlqkq8N07Froses4IZrafE2earxiNlhKrxD7vCavUBtQuVL7bTz08V96xu0d4l2up8sj/xeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773688339; c=relaxed/simple;
	bh=KfZMhekcEbt1Z6XTGtqJ4ZmJyKhKYZINrpwi9eI2/Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C+9N88VXa331nZ15RblLee3AQksbzO/tsh0EpJRrMdK8BIv8JLya+s2ulO/LIPHBKyJn4opKRYHui8AJZdpeFYQpS86Z0k4qDQauzlI2939ZpcoAyIdl6aQc4VxkundM9lYgtoELM6BhYpjD/f8vm09Zupp10fyqNDmwMaK9x9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjDnSpwh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDDEFC19421;
	Mon, 16 Mar 2026 19:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773688339;
	bh=KfZMhekcEbt1Z6XTGtqJ4ZmJyKhKYZINrpwi9eI2/Ts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PjDnSpwhX3F6FqPJTrG+sdFuAJPEcxI4OXjdJ46XXH989SsAu8e1CA++48ln5KVEE
	 PxOV11K0lbxYRZg3Nu2VO+V1tWzVmvoRX6XSGxOluze7XkxfRgYY80QD+3LdtT/3tG
	 9T/6xEsRokiKQDOKTO39ow/TJI3kZC7n29jYw7m5Hh6d7Zdjhn5ORM5zuUN1fAuL1R
	 OjmZC/4uNYH9KUT8x/KRpHR0aDXxLEYdNsWgFLw5i+Dy91WSIxgnQqKVJXNHFe7jux
	 U8J2ZV4WpTYoLQJwg1hBdysfAS8yUcWudt+w4sk9vfR7HqpElM0DxW5nuP0xBOc38p
	 B+Z9/DZb13LAQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	"Naveen N Rao (AMD)" <naveen@kernel.org>,
	Jim Mattson <jmattson@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] KVM: SVM: Initialize AVIC VMCB fields if AVIC is enabled with in-kernel APIC
Date: Mon, 16 Mar 2026 15:12:16 -0400
Message-ID: <20260316191216.1332463-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031622-prolonged-john-01eb@gregkh>
References: <2026031622-prolonged-john-01eb@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225665-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 7E47929F955
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 3989a6d036c8ec82c0de3614bed23a1dacd45de5 ]

Initialize all per-vCPU AVIC control fields in the VMCB if AVIC is enabled
in KVM and the VM has an in-kernel local APIC, i.e. if it's _possible_ the
vCPU could activate AVIC at any point in its lifecycle.  Configuring the
VMCB if and only if AVIC is active "works" purely because of optimizations
in kvm_create_lapic() to speculatively set apicv_active if AVIC is enabled
*and* to defer updates until the first KVM_RUN.  In quotes because KVM
likely won't do the right thing if kvm_apicv_activated() is false, i.e. if
a vCPU is created while APICv is inhibited at the VM level for whatever
reason.  E.g. if the inhibit is *removed* before KVM_REQ_APICV_UPDATE is
handled in KVM_RUN, then __kvm_vcpu_update_apicv() will elide calls to
vendor code due to seeing "apicv_active == activate".

Cleaning up the initialization code will also allow fixing a bug where KVM
incorrectly leaves CR8 interception enabled when AVIC is activated without
creating a mess with respect to whether AVIC is activated or not.

Cc: stable@vger.kernel.org
Fixes: 67034bb9dd5e ("KVM: SVM: Add irqchip_split() checks before enabling AVIC")
Fixes: 6c3e4422dd20 ("svm: Add support for dynamic APICv")
Reviewed-by: Naveen N Rao (AMD) <naveen@kernel.org>
Reviewed-by: Jim Mattson <jmattson@google.com>
Link: https://patch.msgid.link/20260203190711.458413-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[ Context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/avic.c | 2 +-
 arch/x86/kvm/svm/svm.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 63dbf67d107b7..a5c5eb3fea22e 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -203,7 +203,7 @@ void avic_init_vmcb(struct vcpu_svm *svm)
 	vmcb->control.avic_logical_id = lpa & AVIC_HPA_MASK;
 	vmcb->control.avic_physical_id = ppa & AVIC_HPA_MASK;
 	vmcb->control.avic_physical_id |= AVIC_MAX_PHYSICAL_ID_COUNT;
-	if (kvm_apicv_activated(svm->vcpu.kvm))
+	if (kvm_vcpu_apicv_active(&svm->vcpu))
 		vmcb->control.int_ctl |= AVIC_ENABLE_MASK;
 	else
 		vmcb->control.int_ctl &= ~AVIC_ENABLE_MASK;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 0ca511389227f..97783bf50a3f3 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1230,7 +1230,7 @@ static void init_vmcb(struct vcpu_svm *svm)
 
 	svm_check_invpcid(svm);
 
-	if (kvm_vcpu_apicv_active(&svm->vcpu))
+	if (avic && irqchip_in_kernel(svm->vcpu.kvm))
 		avic_init_vmcb(svm);
 
 	/*
-- 
2.51.0


