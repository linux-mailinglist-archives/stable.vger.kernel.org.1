Return-Path: <stable+bounces-242820-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEZqE2Gt92lwkwIAu9opvQ
	(envelope-from <stable+bounces-242820-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 22:17:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4D74B741B
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 22:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89D8F3011C5F
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 20:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7C0375AB1;
	Sun,  3 May 2026 20:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PuysZIsg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KRu8udzO"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43EB377018
	for <stable@vger.kernel.org>; Sun,  3 May 2026 20:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777839436; cv=none; b=c6QgIpJGnAv+5YLLTKlU9LSmExGZt8K7BRHvcKDRL9W7lTPsaZKQnVtLddKfXAphZrgoLdKyYBfw9vtC4ACVUdHzLu0etpfheq3YfS/YHW9jP0jlvQe7vrrALc1rtE9ExHPIJndazZmYdpD8+jRs8maGH8Jh8RwdZYlD36bXONw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777839436; c=relaxed/simple;
	bh=giOp6gfjXieT1/b6xUERpdXrEm1QCvEoZYYLScyzdfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSDRHSElvmUlQBaTrmhTrdqrH1GY/fvKoCE76kLGLx2curHkSFcZU+i7w1apqKLPedhLMwf8sNtnxHJhqjujGx+PzNBmiX0Pp3gxjrunM8RLmX10rmVC5dR5FLFx329y5YdFv88oW1zk2JK3wnFAItRo15e31ibWyc9uZaMiLVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PuysZIsg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KRu8udzO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777839432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I+gTtkSHsc/58H8jQY/bg4el9R2aQOy+A7eA/4Fm6GM=;
	b=PuysZIsg26ihr0lBA4zeFawqhBeL5NiSd4lS6Lo91Y+60ITxMmZXPNg2bEz45TcbKACBjC
	6WQ6mBdJZLzc8Ixb/R168smPmyTTK39Blr3ggWuQapvYaXn5oXonid1z3KyM4XA1fPuPPl
	lmeziXJgZ/qtl0ouEIAjpF5VEf1R8Fo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-JL3jrGzVPZ2UQClID1IFnQ-1; Sun, 03 May 2026 16:17:09 -0400
X-MC-Unique: JL3jrGzVPZ2UQClID1IFnQ-1
X-Mimecast-MFC-AGG-ID: JL3jrGzVPZ2UQClID1IFnQ_1777839428
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48a5adc141cso16639145e9.0
        for <stable@vger.kernel.org>; Sun, 03 May 2026 13:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777839428; x=1778444228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+gTtkSHsc/58H8jQY/bg4el9R2aQOy+A7eA/4Fm6GM=;
        b=KRu8udzODktaKGvUl+tthBmiysiyCM4ngAw5phIGnOoGcBNJbnawf5h+u4e2yVAOcd
         ct4+LThSibl0aaqG8Gvc2znLy/s/jUgDOW6NFth+BugpD0NV3Rhajtq2IhTvJUXyszai
         yOiImZ7x+A9xzCO3/X5hbcwWyiJvYx38j9ekdWbPIoEObYC0LN98RKyHNkxhB01D3LPx
         EO35Y+n3RjRJse9uPn3iTzvlYyB2cDZuRWZTeUonjEb8GmxJy3vvuKNFb5VwLS+t6FF+
         Nv3s605jXdUIyZgANTNo90fxqakj4iLmY05hGJOD0WZR2VdHnYsLuIoXH/GjEBDa+twO
         r2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777839428; x=1778444228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I+gTtkSHsc/58H8jQY/bg4el9R2aQOy+A7eA/4Fm6GM=;
        b=FaAy4C+tv5F7xe4YDiXIyJ/vGQQNv30wJ+sgLropRV0FtB/N22dXw/bONNZ0QoAIMB
         Dw/uCSMqeS670atifcvKyhcsx4KXtUNob7B4VYBtPhVu3UQyFGiDSVKBoDUDA2uN81G9
         Ybq53vyZSXpUEvHfORImxl2ngtlQ828Tn9NpjDUukKc2mO8PQ6RmurfLjWdpjigWup+N
         KWIEmSrtzLMgbJvEyrchRYGMKWcpwlDwAP8IeFg9Od9BYSCO6oHKcynpjBZR4hYlZ9nc
         84b0jAaI77ST7WEvzs+mVoDqgF7OJvVFS5lvrW1eBrpmjqgvbsAc3lh98Qwmck0Ajpyw
         HUpw==
X-Forwarded-Encrypted: i=1; AFNElJ+2PMRr5NfQYHPyLq/0VRrxt0+/66DWuhV8qhIQ6p7kSPVM0Zh6xeXPYDFsVHUUq1Iq2MiNzsE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Ro/WcbB94CYl1S6YuYjwAJ9CAKI8ls5FKSSt+7d98L6NNikT
	uDSBkI+QQ5IpN7GUpDMuhh+s+RPTKDNXSZ0EIxNGfWK3OEYIywlWkzYfwRZDjytpJ9DFqEENbvW
	A/Ee4AENPm1J6ACMceehKNFemQ0EGbIxsDjT3xZx51a7p1DyjJIn/SzaJ6w==
X-Gm-Gg: AeBDievgrNLTjVD5+WoLUcQDSBInKw0bSkBIBH7RlqGpQsnwnBmrdktRFKHR8fWrIqi
	UZPWVbYfoBIGUC5ahQ3KTu1xRAMvNaPAXszCJvsa0M7OXFmiDkfzBWAgXGVKu/5olv0up2dMbES
	aiiIeckEMSeKzpJZiwu/cxc3oidZUQSq3D7T4toS9+0KFgbpUKuRgCG32nzIBB/cp26JsUghRWa
	sSSb+fy1eOAM99WiGsMKG3a8qwDF7ww0Ijg0qC6DFV1er8G4hHeW+6oFNZCZfkTU5JO4qEdGyk4
	kBd7CNOs0c0Uad1x6q1yaU9Xt+eIQIBAIorjU8NsB83lUbi/Ptq81aDdybcARc/jpy9065OuGwS
	AllJC+Pqv08CDmFEHm/qnn0lYTPGvqUd2N9elWI5gicJlg5C1zcr6PwgA3v2jozIj00xKhAXRZZ
	RZ9Ht52JA8dXXx/f+Xov275ZjTeoATsuwAKzY=
X-Received: by 2002:a05:600c:4f13:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-48a970fda7bmr122451315e9.12.1777839427969;
        Sun, 03 May 2026 13:17:07 -0700 (PDT)
X-Received: by 2002:a05:600c:4f13:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-48a970fda7bmr122451145e9.12.1777839427631;
        Sun, 03 May 2026 13:17:07 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a9879ef45sm21476274f8f.32.2026.05.03.13.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 13:17:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: chenyi.qiang@intel.com,
	Farrah Chen <farrah.chen@intel.com>,
	stable@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 1/2] KVM: x86: Do IRR scan in __kvm_apic_update_irr even if PIR is empty
Date: Sun,  3 May 2026 22:17:02 +0200
Message-ID: <20260503201703.108231-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260503201703.108231-1-pbonzini@redhat.com>
References: <20260503201703.108231-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9E4D74B741B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242820-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pbonzini@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]

Fall back to apic_find_highest_vector() when PID.ON is set but PIR
turns out to be empty, to correctly report the highest pending interrupt
from the existing IRR.

In a nested VM stress test, the following WARNING fires in
vmx_check_nested_events() when kvm_cpu_has_interrupt() reports a pending
interrupt but the subsequent kvm_apic_has_interrupt() (which invokes
vmx_sync_pir_to_irr() again) returns -1:

  WARNING: CPU: 99 PID: 57767 at arch/x86/kvm/vmx/nested.c:4449 vmx_check_nested_events+0x6bf/0x6e0 [kvm_intel]
  Call Trace:
   kvm_check_and_inject_events
   vcpu_enter_guest.constprop.0
   vcpu_run
   kvm_arch_vcpu_ioctl_run
   kvm_vcpu_ioctl
   __x64_sys_ioctl
   do_syscall_64
   entry_SYSCALL_64_after_hwframe

The root cause is a race between vmx_sync_pir_to_irr() on the target vCPU
and __vmx_deliver_posted_interrupt() on a sender vCPU.  The sender
performs two individually-atomic operations that are not a single
transaction:

  1. pi_test_and_set_pir(vector)  -- sets the PIR bit
  2. pi_test_and_set_on()         -- sets PID.ON

The following interleaving triggers the bug:

  Sender vCPU (IPI):              Target vCPU (1st sync_pir_to_irr):
  B1: set PIR[vector]
                                  A1: pi_clear_on()
                                  A2: pi_harvest_pir() -> sees B1 bit
                                  A3: xchg() -> consumes bit, PIR=0
                                      (1st sync returns correct max_irr)
  B2: set PID.ON = 1

                                  Target vCPU (2nd sync_pir_to_irr):
                                  C1: pi_test_on() -> TRUE (from B2)
                                  C2: pi_clear_on() -> ON=0
                                  C3: pi_harvest_pir() -> PIR empty
                                  C4: *max_irr = -1, early return
                                      IRR NOT SCANNED

The interrupt is not lost (it resides in the IRR from the first sync and
is recovered on the next vcpu_enter_guest() iteration), but the incorrect
max_irr causes a spurious WARNING and a wasted L2 VM-Enter/VM-Exit cycle.

Fixes: b41f8638b9d3 ("KVM: VMX: Isolate pure loads from atomic XCHG when processing PIR")
Reported-by: Farrah Chen <farrah.chen@intel.com>
Analyzed-by: Chenyi Qiang <chenyi.qiang@intel.com>
Cc: stable@vger.kernel.org
Reviewed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/lapic.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index e3ec4d8607c1..5ee14d6bc288 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -669,12 +669,14 @@ bool __kvm_apic_update_irr(unsigned long *pir, void *regs, int *max_irr)
 	u32 irr_val, prev_irr_val;
 	int max_updated_irr;
 
+	if (!pi_harvest_pir(pir, pir_vals)) {
+		*max_irr = apic_find_highest_vector(regs + APIC_IRR);
+		return false;
+	}
+
 	max_updated_irr = -1;
 	*max_irr = -1;
 
-	if (!pi_harvest_pir(pir, pir_vals))
-		return false;
-
 	for (i = vec = 0; i <= 7; i++, vec += 32) {
 		u32 *p_irr = (u32 *)(regs + APIC_IRR + i * 0x10);
 
-- 
2.54.0


