Return-Path: <stable+bounces-267442-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zfWZMNSnNWrq2QYAu9opvQ
	(envelope-from <stable+bounces-267442-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 22:34:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2182D6A7A6F
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 22:34:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=UQFqgbJi;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267442-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267442-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FEBB30CA6A2
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 20:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7663E3C583B;
	Fri, 19 Jun 2026 20:32:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EE23BFAEE
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 20:31:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781901123; cv=none; b=A2RvABkOx+knLkvylVcxeaOF4cbpzOyUtVb+V7s+pHRRXYfbE0Ap8v9zpK3jZpUMrrJtPmWHMKFbnY33oI+71k8ECrHdX7G1CBzibLh620yYtqb+l2PMfhTEwRzIMylx1DnFl/QNDy6HP8syuoDE5BozOCVCc3N8O1sA0Oa6+88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781901123; c=relaxed/simple;
	bh=lqeXZvwKd2+gKyapbikEC8uszALCZyZ/DkHgKCMSiHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aYWPh5oVUFHF/iaieY9ZBkPv+3cuef1y/PD+YN3zKlCkoEJSmBxD6/uDSP5uZv50Ijpkg+alnaMhsu6nyLwzden4C7plnmuUIozmhXSH2KnyY+zj8Uq6tyJMAy312qFihtKjyLyQ7+E94jLL6Iq7XHJK/fhrL1yJmOjlMZNGIoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQFqgbJi; arc=none smtp.client-ip=209.85.222.170
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-9159f631656so328047785a.1
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 13:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781901116; x=1782505916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Rfwd7WJck9jEb6I6f8Juo4t1Gf+3WTqdnf32I0mINY=;
        b=UQFqgbJiqXW1j9nL3ahEAjmuNLPbFqp+JOMUClMofdKwv2rb2DF363xEt3VQC/2yt8
         53YwOJcfGjjGtZWY9/BcssSWG53PLW1sZZIQ7FkmYpN+YPkSMf/YTvO33H5QXDfRRU5N
         h+rPQ8SpqmcREFaWuQN5rQLyS6Z2SoEvboEs0NIIN4lzSEqjbZDkpjxT4nnRdk9PyyOb
         69SXB1z2SLDgsPTahyogy4hX2k67dbEfiXczVMXhhK7DR1mgjTFlS0BY5+X9Ko42ycyX
         KGf2OOqSv6bpWyxaIm2HwBPf2c89fIHo8dB0dJjTryRnIJBKjKOs2uwO2AaXBsW4T0tC
         lKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781901116; x=1782505916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/Rfwd7WJck9jEb6I6f8Juo4t1Gf+3WTqdnf32I0mINY=;
        b=mQbnk/hR3CMFp52qScluC1uDJ0doigMcDnL0SOvcd/xycdZFpyAX02PIbbdweqv+0X
         7HnFu7q5wuK3U83YEu30hO7U2flovH8+Sb0YiOKvhxC1i6AJqId/VVgKRi8upA8nPP95
         I3JqVKtKc5VNMEShx3LDvLNOS7ooDTSRb0ek7qvDWOObiaPh7lNG9gedD/52AtrZy8yj
         Jdv7umzORegZyxPiASlhdNNeQ8Mn+XODBkQIuZ2lArILKvmmbJYtsNmBIl/maFYoVo+T
         yHvkl2R+yV+7ADS/QmtCFZ9q5S9G7chirzQ1bViQg4uWQQ/cjkqecns/hDhpFtEXscXA
         A+cg==
X-Gm-Message-State: AOJu0YwOcS7DZL0AYQjqFl+aS89LoxvkLpYAVIg9mJyy07EhQlp9vjFz
	hVrruUsnNej8WS14m5dD3Fqy06mgerWYAbX8ZH4GswjtReFPrwaApn68tWfKHDGifjo=
X-Gm-Gg: AfdE7clrZUyWQ2qIzRk4jhrRuMLsoan7VENo7GkRi5DI8LH/1g1q3ynvoMtMT8sBvqx
	v7vRSLoAlRGWnsqdTWQnV+iKL6d1Lzv1qAmPqtY+FKRnbZs9zs4BOmtQ7lafxHG24gVPhh/yc2E
	8ZvG1BAy7nmew+c+qszSboNBQJdqgVs6ujqQkK2PPYTwfRFBZIyChEQCMb+8/22yVJdgk7KTsEg
	cFFEeefwFqPagI6gFaQUcyAVI7HKNFuAi47DG0O/lGDBWj+jCA5eDDqvKssNVlCyJ4wdaVPyiB7
	gGFhgBxJ8vNei90YHA7AliASCPSnJEhZQPJXR9Zvz7Q7qQhIgOfLyuf/ym1tuthwAAdvamnXdix
	u7urJa7bXLsRelm5F383GI7Jn67DF/nutG0mAUU+Kz+YThhzJ5llwIB1TDYbcqJ4PFjqeCKnRrk
	JlFTD9YoI+d9aspC0=
X-Received: by 2002:a05:620a:2949:b0:915:9da9:b541 with SMTP id af79cd13be357-9208a8c738cmr623400585a.10.1781901116228;
        Fri, 19 Jun 2026 13:31:56 -0700 (PDT)
Received: from TurinLinux.. ([37.19.212.13])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f015805sm11106986d6.1.2026.06.19.13.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 13:31:55 -0700 (PDT)
From: Nicholas Dudar <main.kalliope@gmail.com>
To: stable@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	gregkh@linuxfoundation.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	0wn@theori.io,
	mlevitsk@redhat.com,
	jmattson@google.com,
	Nicholas Dudar <main.kalliope@gmail.com>
Subject: [PATCH v2 6.1.y 2/3] KVM: nVMX: Check for pending posted interrupts when looking for nested events
Date: Fri, 19 Jun 2026 16:31:06 -0400
Message-Id: <20260619203107.2752678-3-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619203107.2752678-1-main.kalliope@gmail.com>
References: <20260619203107.2752678-1-main.kalliope@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[google.com,redhat.com,linuxfoundation.org,vger.kernel.org,theori.io,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-267442-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:seanjc@google.com,m:pbonzini@redhat.com,m:gregkh@linuxfoundation.org,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:0wn@theori.io,m:mlevitsk@redhat.com,m:jmattson@google.com,m:main.kalliope@gmail.com,m:mainkalliope@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mainkalliope@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mainkalliope@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2182D6A7A6F

From: Sean Christopherson <seanjc@google.com>

commit 27c4fa42b11af780d49ce704f7fa67b3c2544df4 upstream.

Check for pending (and notified!) posted interrupts when checking if L2
has a pending wake event, as fully posted/notified virtual interrupt is a
valid wake event for HLT.

Note that KVM must check vmx->nested.pi_pending to avoid prematurely
waking L2, e.g. even if KVM sees a non-zero PID.PIR and PID.0N=1, the
virtual interrupt won't actually be recognized until a notification IRQ is
received by the vCPU or the vCPU does (nested) VM-Enter.

Fixes: 26844fee6ade ("KVM: x86: never write to memory from kvm_vcpu_check_block()")
Cc: stable@vger.kernel.org
Cc: Maxim Levitsky <mlevitsk@redhat.com>
Reported-by: Jim Mattson <jmattson@google.com>
Closes: https://lore.kernel.org/all/20231207010302.2240506-1-jmattson@google.com
Link: https://lore.kernel.org/r/20240607172609.3205077-5-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
[ Nicholas Dudar: backport to 6.1.y. Prerequisite for the next patch, which
  folds its check into the vmx_has_nested_events() body this patch builds.
  Applies cleanly. The for_injection path still returns preemption_timer ||
  mtf, as the previous 6.1.y body did. ]
Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
---
 arch/x86/kvm/vmx/nested.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 7d8e18dbe..ad07e83d2 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3953,8 +3953,40 @@ static bool nested_vmx_preemption_timer_pending(struct kvm_vcpu *vcpu)
 
 static bool vmx_has_nested_events(struct kvm_vcpu *vcpu, bool for_injection)
 {
-	return nested_vmx_preemption_timer_pending(vcpu) ||
-	       to_vmx(vcpu)->nested.mtf_pending;
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	void *vapic = vmx->nested.virtual_apic_map.hva;
+	int max_irr, vppr;
+
+	if (nested_vmx_preemption_timer_pending(vcpu) ||
+	    vmx->nested.mtf_pending)
+		return true;
+
+	/*
+	 * Virtual Interrupt Delivery doesn't require manual injection.  Either
+	 * the interrupt is already in GUEST_RVI and will be recognized by CPU
+	 * at VM-Entry, or there is a KVM_REQ_EVENT pending and KVM will move
+	 * the interrupt from the PIR to RVI prior to entering the guest.
+	 */
+	if (for_injection)
+		return false;
+
+	if (!nested_cpu_has_vid(get_vmcs12(vcpu)) ||
+	    __vmx_interrupt_blocked(vcpu))
+		return false;
+
+	if (!vapic)
+		return false;
+
+	vppr = *((u32 *)(vapic + APIC_PROCPRI));
+
+	if (vmx->nested.pi_pending && vmx->nested.pi_desc &&
+	    pi_test_on(vmx->nested.pi_desc)) {
+		max_irr = pi_find_highest_vector(vmx->nested.pi_desc);
+		if (max_irr > 0 && (max_irr & 0xf0) > (vppr & 0xf0))
+			return true;
+	}
+
+	return false;
 }
 
 /*
-- 
2.34.1


