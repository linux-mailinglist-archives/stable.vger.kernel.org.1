Return-Path: <stable+bounces-270072-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4f8pA5tVRGpItAoAu9opvQ
	(envelope-from <stable+bounces-270072-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 01:47:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F28856E8B43
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 01:47:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=leNAfvFH;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270072-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270072-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0BA743010C8C
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 23:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8254A33D6FD;
	Tue, 30 Jun 2026 23:47:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597472405E1;
	Tue, 30 Jun 2026 23:47:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782863243; cv=none; b=oM8dO3acQaF8ND5LkOTXHcy4InSKEs2i6BNn81cupJu2Eq35w8+2psZXSDsO99WtQky15YfdMJsmYwliVFivYDjjFgZ024N7Km8/5vPO45lz/BU2Fk98Gof0O24G66h3kqAUp7NBDypMAu8dp4sYjSMkI4QQl7939uU6CP7wHL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782863243; c=relaxed/simple;
	bh=CVyTP7zm6ASkp+fjbYE+ecq6M0SfjzGaQ2CVSdusMwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gKBgCz/FFO6i27Sqaebv511sY2gT5aXfe4a3zGn6Wv4ivnSXQLlGa5COiOyn2DYNK3UYksn4/HRxCTE7sC/kHOWynwVXM7R70XXC4+QVxFPiXX2RednwkzwpmnOOCk8zn9CGYnYbx18TGTDpt2jt4Tzc/ZtrtfhM97FWYKlUC2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leNAfvFH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082231F00A3D;
	Tue, 30 Jun 2026 23:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782863242;
	bh=U5ldOW9ifgcKwIN1X3AjwZELUVzkc0skATFdb1bxG2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=leNAfvFHMhBs8D5tvJIoPQ33i7ijBKYg+QoqEmYRniioa6lRK3AU7R74QyGtXPR/e
	 7L+ukrb5+NGS0VwqIScSbbBcuGKFbAvp+z6S7SoSiwgV5n89OcOfWT02JwqcP7xg6Z
	 Z4wUGpY4rmlsTinvBDxvvQealO+foeIZVjjOMmxFVDj0d/NiO3/Vxji+y19psQ8B4k
	 sz3Y8ESGv2zyhxTqte0H66JH7zx3DjSZoGsB9mCJvK+xi/3rx0psqkMYz1u9s2+8HN
	 3drpymJJo2cr1vfFNhXrFGiGUs3E+LLxz2bwkrD8L+ENZeLgvRm+FPkGHso0EPD2FZ
	 IuMj5YQCJ62Gg==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/7] KVM: x86: Check EFER validity on KVM_SET_SREGS*
Date: Tue, 30 Jun 2026 23:47:09 +0000
Message-ID: <20260630234716.3039031-2-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260630234716.3039031-1-yosry@kernel.org>
References: <20260630234716.3039031-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270072-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:seanjc@google.com,m:pbonzini@redhat.com,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yosry@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[yosry@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F28856E8B43

When handling userspace SREGS writes, check the validity of EFER (i.e.
allowed bits) before writing the new value of EFER through the
per-vendor set_efer callbacks. This prevents userspace from writing
bogus values (e.g. EFER.SVME=1 with nested=0).

Note: on KVM_SET_MSRS, KVM only checks EFER validity in terms of KVM
caps, not guest caps, so it is possible to set EFER bits that are
supported by KVM but not by the guest CPUID. Potentially allowing
userspace to set msrs before CPUID.

However, for KVM_SET_SREGS*, check the validity of the set bits against
both KVM and guest caps. This is consistent with other validity checks
(e.g. for CR4) that check validity against guest caps, which already
imposes the need to set CPUID before SREGS.

Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/regs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/regs.c b/arch/x86/kvm/regs.c
index d2caf5a67dba4..94c4e4e41868f 100644
--- a/arch/x86/kvm/regs.c
+++ b/arch/x86/kvm/regs.c
@@ -563,7 +563,8 @@ static bool kvm_is_valid_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 	}
 
 	return kvm_is_valid_cr4(vcpu, sregs->cr4) &&
-	       kvm_is_valid_cr0(vcpu, sregs->cr0);
+	       kvm_is_valid_cr0(vcpu, sregs->cr0) &&
+	       kvm_valid_efer(vcpu, sregs->efer);
 }
 
 static int __set_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs,
-- 
2.55.0.rc0.799.gd6f94ed593-goog


