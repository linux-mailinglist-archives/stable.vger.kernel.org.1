Return-Path: <stable+bounces-241544-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MG3RDqGO8Gl4UwEAu9opvQ
	(envelope-from <stable+bounces-241544-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 12:40:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AE5482C98
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 12:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D86303043892
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 10:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED4F3EF0DC;
	Tue, 28 Apr 2026 10:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e6IRx0+U"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D4E2E8B9B
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 10:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777372216; cv=none; b=LMrfZwTglXzByl8LCZrKGNKMxkvuCSq62lqyCvfAjde4pbVjE0yZNPZ2xOA77xL/Lwy+yGyAXJa5hJOd0YxeqDjiEw7agoqBYXTHKIKA7PWF5EXeevxDtsIjkK/f1VODe56Kqcfdnb4RujZAVtdBvDaHiOjKHwfqqINq3KVpRYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777372216; c=relaxed/simple;
	bh=dwxEJdIz8vYk/ufo4vzAXxS0t3GaEBIy02K4bnRRtU8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=adRw6VPi9hxKhl1QnrN6zREtLQbj/JjvUwlqhiXll3H/Inu6Qv8OBPhQ1OObh8N49gky3dSvQKo/9Uv943g31Lsa1QQNzD8pYFYDFk+W8Hy/hvfqVqm53XSLHRhn9B3CkNL4F8TCrn/CW3A1fxRM+c/wypBPSOAcwbohYEP+h9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e6IRx0+U; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-ba84b4c7130so774052466b.0
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 03:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777372212; x=1777977012; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xE/iPxwYzw+NNX7wEA81VsFDw/XB5o3T+Ctb9g0a1xk=;
        b=e6IRx0+U4D1sM2MtUx43QYhfzNuFJFSaIPGqxpEiLx7giEXt7+O8vaShHN4rZcxsau
         ReFayr3cJ2UuWvWKTJtT0dqvvXzIPBLEJ4GOl4noxXXosWZhdlXBrqLNsrJSM5ZrMIfq
         2kooGIWtX9TS2+FBF/g2UMHD9hleNfQyyYME8jAaQ12h3KlxF2HPpOd3uSFT4ETk7OUR
         sgHNRJWvj5xoNDlJR/IRf6fK9oP2+FuMtV+6cbV5zwyIA+hxJ9FujqyGTYHreTF4gBUW
         Kuof96OccqkJMzviokszYI2LO05hu0Tqjz2J+AvqQyTxovBKD7TekCVFnR/fV4OVN5VI
         Beaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777372212; x=1777977012;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xE/iPxwYzw+NNX7wEA81VsFDw/XB5o3T+Ctb9g0a1xk=;
        b=Ot7DhKFluvTHxhK885b9+AU4nB0xrbgE8wKTnZAHNxsaTgB2TUumEQklOOFTeReb6d
         7isHHDJg0FH9TSEMV4M00+Gq25DnJf8Ubc+dZnt6JDXEI/a4urKKQ8tn/LPS97tBxr/7
         v1onJy4rMHi+zTBzRaQvuC8t5tgQp8TN1Cr3D1Q87tE1xurRNwiYeYqfUfrl6cghY2Xt
         aZFZUb56ADKK+crXgUQrD+aF53fA+PzFBEoOMU8zABwtKh7xRCl4hRrjHL/wvllIFxR8
         aYiAGMzKt3Dj7g9ka9aNuAtgmaAVGkm0wafdE/Badu3Ap6MBY1mDneIaCj3MSOhnMIsZ
         hFSA==
X-Forwarded-Encrypted: i=1; AFNElJ8CUSjhjPMNk5qstv/NO8Qk0w7pmXn/zbU4uKnbox45jy9AnQfWtQVKUMp6lGGQkrO05sMPOdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBA7rU+TMtZPOWNV5BVdayHQ3j9SynhmKeAX9HP6hCHhfrWYGN
	IW2moZ07Ow04jrSpha+kPwdJSV6l88ZiPdjC5pCQX/JFUNRw1bibvqGBnVua+u0iXwM0kjPdW6a
	Whw==
X-Received: from ejchp42.prod.google.com ([2002:a17:907:3e2a:b0:b9e:2534:71c9])
 (user=tabba job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:5194:20b0:bae:656b:2953
 with SMTP id a640c23a62f3a-bb8022c28ebmr102260866b.11.1777372211619; Tue, 28
 Apr 2026 03:30:11 -0700 (PDT)
Date: Tue, 28 Apr 2026 11:30:02 +0100
In-Reply-To: <20260428103008.696141-1-tabba@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428103008.696141-1-tabba@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428103008.696141-3-tabba@google.com>
Subject: [PATCH 2/8] KVM: arm64: Synchronise HCR_EL2 writes on the guest exit path
From: Fuad Tabba <tabba@google.com>
To: maz@kernel.org, oliver.upton@linux.dev
Cc: james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	qperret@google.com, vdonnefort@google.com, tabba@google.com, 
	catalin.marinas@arm.com, will@kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 35AE5482C98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-241544-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tabba@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[14];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

MSR HCR_EL2 is not self-synchronising. Per ARM DDI 0487 M.b K1.2.4
(p.K1-16823) and B2.6.1 (p.B2-297), a Context Synchronisation Event
is required between an HCR_EL2 write and any subsequent direct
register access at the same EL that depends on the new value being
in effect.

On the entry path, the HCR_EL2 write in __activate_traps is followed
by further EL2 sysreg work (MDCR_EL2, CPTR_EL2, VBAR_EL2, and on the
speculative-AT errata path SCTLR_EL1/TCR_EL1) before ERET into the
guest. None of those intervening accesses depend on the new HCR_EL2
value, and ERET is a CSE per ARM DDI 0487 M.b D1.4.4.1 rule RBWCFK
(p. D1-7209) conditional on SCTLR_EL2.EOS=1, which is set
unconditionally by INIT_SCTLR_EL2_MMU_ON (see the prerequisite patch
in this series). The requirement is therefore satisfied implicitly
on the activate path.

The deactivate path is different: after write_sysreg_hcr() in
__deactivate_traps() further EL2 sysreg work runs before any natural
CSE - on nVHE, __deactivate_cptr_traps and the VBAR_EL2 write; on
VHE, the timer context save which reads CNTP_CVAL_EL0 under the new
TGE/E2H, and the EL1 sysreg restore. Add an explicit isb() at each
of the two deactivate sites.

The practical impact today is bounded: HCR_EL2.E2H does not toggle
in either path, and the trap bits being changed primarily affect
EL1&0 behaviour. But the architectural rule should be honoured.
Note that write_sysreg_hcr() itself already issues isb() on the
Ampere errata path (sysreg.h), confirming the architectural
expectation; the fast path optimises that away.

The fix is at the call sites rather than inside write_sysreg_hcr()
because the macro has many users (e.g. the activate path, at.c,
hardirq.h, ptrauth alternatives) where the immediately-following
code either reaches ERET or has another CSE; making the macro emit
an unconditional ISB would impose unnecessary cost on those
well-formed users.

Fixes: 9404673293b0 ("KVM: arm64: timers: Correctly handle TGE flip with CNTPOFF_EL2")
Signed-off-by: Fuad Tabba <tabba@google.com>
---
 arch/arm64/kvm/hyp/nvhe/switch.c | 11 +++++++++++
 arch/arm64/kvm/hyp/vhe/switch.c  | 11 +++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 8d1df3d33595..9d7ead5a5503 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -105,6 +105,17 @@ static void __deactivate_traps(struct kvm_vcpu *vcpu)
 	__deactivate_traps_common(vcpu);
 
 	write_sysreg_hcr(this_cpu_ptr(&kvm_init_params)->hcr_el2);
+	/*
+	 * MSR HCR_EL2 is not self-synchronising. Per ARM ARM K1.2.4 p.K1-16823
+	 * and B2.6.1 p.B2-297, a Context Synchronisation Event is required
+	 * between an HCR_EL2 write and any subsequent direct register access at
+	 * the same EL that depends on the new value being in effect.
+	 * The activate_traps path falls through to ERET (a CSE), but the
+	 * deactivate path still executes further EL2 sysreg work (CPTR/VBAR
+	 * writes below) before any natural CSE, so make the synchronisation
+	 * explicit.
+	 */
+	isb();
 
 	__deactivate_cptr_traps(vcpu);
 	write_sysreg(__kvm_hyp_host_vector, vbar_el2);
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index 9db3f11a4754..140d3bcb5651 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -149,6 +149,17 @@ static void __deactivate_traps(struct kvm_vcpu *vcpu)
 	___deactivate_traps(vcpu);
 
 	write_sysreg_hcr(HCR_HOST_VHE_FLAGS);
+	/*
+	 * MSR HCR_EL2 is not self-synchronising. Per ARM ARM K1.2.4 p.K1-16823
+	 * and B2.6.1 p.B2-297, a Context Synchronisation Event is required
+	 * between an HCR_EL2 write and any subsequent direct register access at
+	 * the same EL that depends on the new value being in effect.
+	 * The activate_traps path falls through to ERET (a CSE), but the
+	 * deactivate path still executes further EL2 sysreg work (CPTR/VBAR
+	 * writes below) before any natural CSE, so make the synchronisation
+	 * explicit.
+	 */
+	isb();
 
 	if (has_cntpoff()) {
 		struct timer_map map;
-- 
2.54.0.545.g6539524ca2-goog


