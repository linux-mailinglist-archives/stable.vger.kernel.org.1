Return-Path: <stable+bounces-230960-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPQKKqtSyWnrxQUAu9opvQ
	(envelope-from <stable+bounces-230960-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 18:26:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5168F352E46
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 18:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFA6A30459FC
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 16:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0ED37FF5E;
	Sun, 29 Mar 2026 16:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FUzJKqjl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NfzDQYUi"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE692571A0
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 16:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774801386; cv=none; b=sAEKEs2ncavYwczIx3XbuygkUFLvNUT5l7W363Y+pcoxSGETrIPS55SOutsxxI2+3ruDhlalkifLZ3HK0DEBdH4cPIXrVCkvJq6tQkOMYzfE+oQk3SEe/G06XqxYF8AI/JsZkS/6xSaqnwjNg/tKQwj1eLCevheOj3XO2xWWrY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774801386; c=relaxed/simple;
	bh=4ATS/w5ilyTZCGdNEt11O3ZPqSdhk07QwetqwZRQn/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=upugibShxW3vC3B/47YYwu3C1SH8vLzkgtW8oNJSBT8CCRGtYi6QMcn7F7h8XBz/uY5TP4azDpd1QOXlnUPv+1WbC8HZgR49+YfLa4NP6OafpuvO/jqW6D+hdrFJQ45ek3OfD8zPKn7e+g9RE9G/wUWOo4G0qNAK3Y50nP4hcgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FUzJKqjl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NfzDQYUi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774801383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7CkbaMckWtOu+BAt2/YNvYUDOoVNDTgPUoFz2iLggDQ=;
	b=FUzJKqjlDokIkxrkySNMTeKYmPngac8blWMtG2zFX4he/pQ+Kzfi6CB/6QFV/TQZFsfuHa
	AnLM8aWVLMA2OkYeNtoecxexPStwerS6h2NmUocVfuY983niao0ju3N70xqioThiRhTSzz
	QMC4/U+KdV4frreJpncJW+2VDFDgDDg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-T7_sR6e1MEehg8J5aFRj2g-1; Sun, 29 Mar 2026 12:23:02 -0400
X-MC-Unique: T7_sR6e1MEehg8J5aFRj2g-1
X-Mimecast-MFC-AGG-ID: T7_sR6e1MEehg8J5aFRj2g_1774801381
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-486fb142205so44204745e9.1
        for <stable@vger.kernel.org>; Sun, 29 Mar 2026 09:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774801381; x=1775406181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7CkbaMckWtOu+BAt2/YNvYUDOoVNDTgPUoFz2iLggDQ=;
        b=NfzDQYUi+50qt2whROP24nNZ7e/ath/9LckgM+BGTMPKuXoMLtHyJ5m0elQzWZq2oi
         RZFpULq7rGBjYR3eVBGT2Re+/7RQbftym7M+trLtBr9Kaga2ib+Awq37LXQPgtvjMeTT
         qeFjTBqBGNSf7o2/lc6XJGY7NDTk303OzWSlqeCSPDir7qG+O8jM4iRSIKoXyKhqZrHx
         LeyPT9LbNJenFeEwoaum3wloMoBIkSb0t6Mh3elGm1jQjcZFRGHgi0jEs4i4/iqwiGJB
         KcHdF49a2+A5Hg0WqaaDBlPKWsKWV/2JtuqtfWzBYhHS8jPKez4tRy6Z84QfdXZYgjj+
         3zNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774801381; x=1775406181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CkbaMckWtOu+BAt2/YNvYUDOoVNDTgPUoFz2iLggDQ=;
        b=A2g5Tal5rBZ+hgxbKk/WvN0yRp18/snZACfSRTOuYpqp8gbZu87vLirn9uFIioetI3
         VxzXXCy8SOcpywa9u8HPvremzkOk6FxZu+ZOd51DEJ5ljuYCxPIvJPLj5kjAMPRyJY6r
         yOrXtP89z5he8I82FXX7ajsG8Fo5pmnrhD72Oii+6cYz5GJDS83bdWp9TwrsUExcvn+t
         TP13EzaLVa23rru2fQD5gXd7AUeOso9/y5iJPOkfN6a3t9KbpBlKJUols0yXzB4fOP47
         OIZhom8+JKWb/IhS38cnqTVCJujnV6FEZIWCsCf3NemmW6slnsNakKocZ5sk1R8hQbEp
         b1SA==
X-Forwarded-Encrypted: i=1; AJvYcCVd8qomYZ4x6p0mFfPHVEBe04cdKTY6v2ZChDqv7JS3oqcdCLML8C9V3TIDdFxZvzsrmptpnIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRD8G2wKZe1ooz1gF4EnATqLr/xswkLtASFW61WurZR5KKd7WA
	XwYw7RVe6WXR1R6cVFnqcFXi3XfyR3k8aF79qn9WYrxYj4u7i5SMoA9ntjachQnSn9vFPK6c3yU
	VGh6ajRgW5rEs/WDx+mu2yNzeaVQy4c8EANhz4Zs12KvNiNgiXZsyfPpymA==
X-Gm-Gg: ATEYQzwpCwgNR3q2EOB0JatGvue4OLdPlPEwAr1YJ9RWrOpFwp8z56xaRH/7VB7Xshe
	hZuqj6OFn1V4sPQ3j5LPlwJk3k1jvW7E56Scf9gAjz7Dq1ezT/T1HgkK/mG2uzLy0zsL8Se8KJI
	yY/58LOTedKiCoPtAPXUiOlrinUWP6aIi+UH810OqD6cEEv3Y8FhSmKN4sz3Xtu/TJfJ6/AyJbQ
	PNX5PerDXrZANj4WF+SQI91CNPVH1Q0YWS9OwpQqcJYedCETLfpmIHzIgTMggVZXII6ARbxjiQt
	91EkQr/1jj8R79opWsuEqoxrT+W2unR+GZmbgnV0yH8DEK6aePw1ncfDN9b58VRCENmboAU1igu
	9uEGUbrpio+71pQ15geQI70x0OVDYm4BAiOCoWkjrAMww9mRUmcqguqJ5Mq5SU7DFrZhDtfjuMr
	/4IkoeiKFen/q5m5YNQA7m1ZbznYxu0EkqTyk8UPYg9a8haMXlEKuPfiTk
X-Received: by 2002:a05:600c:64c8:b0:483:8062:b43 with SMTP id 5b1f17b1804b1-48727eb7f4dmr158844445e9.19.1774801380565;
        Sun, 29 Mar 2026 09:23:00 -0700 (PDT)
X-Received: by 2002:a05:600c:64c8:b0:483:8062:b43 with SMTP id 5b1f17b1804b1-48727eb7f4dmr158844125e9.19.1774801380099;
        Sun, 29 Mar 2026 09:23:00 -0700 (PDT)
Received: from [10.242.181.123] (93-44-53-42.ip95.fastwebnet.it. [93.44.53.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48730628efasm198566045e9.5.2026.03.29.09.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 09:22:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	stable@vger.kernel.org
Subject: [PATCH] KVM: x86/mmu: Drop/zap existing present SPTE even when creating an MMIO SPTE
Date: Sun, 29 Mar 2026 18:22:56 +0200
Message-ID: <20260329162258.106549-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230960-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5168F352E46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sean Christopherson <seanjc@google.com>

When installing an emulated MMIO SPTE, do so *after* dropping/zapping the
existing SPTE (if it's shadow-present).  While commit a54aa15c6bda3 was
right about it being impossible to convert a shadow-present SPTE to an
MMIO SPTE due to a _guest_ write, it failed to account for writes to guest
memory that are outside the scope of KVM.

E.g. if host userspace modifies a shadowed gPTE to switch from a memslot
to emulted MMIO and then the guest hits a relevant page fault, KVM will
install the MMIO SPTE without first zapping the shadow-present SPTE.

  ------------[ cut here ]------------
  is_shadow_present_pte(*sptep)
  WARNING: arch/x86/kvm/mmu/mmu.c:484 at mark_mmio_spte+0xb2/0xc0 [kvm], CPU#0: vmx_ept_stale_r/4292
  Modules linked in: kvm_intel kvm irqbypass
  CPU: 0 UID: 1000 PID: 4292 Comm: vmx_ept_stale_r Not tainted 7.0.0-rc2-eafebd2d2ab0-sink-vm #319 PREEMPT
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  RIP: 0010:mark_mmio_spte+0xb2/0xc0 [kvm]
  Call Trace:
   <TASK>
   mmu_set_spte+0x237/0x440 [kvm]
   ept_page_fault+0x535/0x7f0 [kvm]
   kvm_mmu_do_page_fault+0xee/0x1f0 [kvm]
   kvm_mmu_page_fault+0x8d/0x620 [kvm]
   vmx_handle_exit+0x18c/0x5a0 [kvm_intel]
   kvm_arch_vcpu_ioctl_run+0xc55/0x1c20 [kvm]
   kvm_vcpu_ioctl+0x2d5/0x980 [kvm]
   __x64_sys_ioctl+0x8a/0xd0
   do_syscall_64+0xb5/0x730
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
  RIP: 0033:0x47fa3f
   </TASK>
  ---[ end trace 0000000000000000 ]---

Reported-by: Alexander Bulekov <bkov@amazon.com>
Debugged-by: Alexander Bulekov <bkov@amazon.com>
Suggested-by: Fred Griffoul <fgriffo@amazon.co.uk>
Fixes: a54aa15c6bda3 ("KVM: x86/mmu: Handle MMIO SPTEs directly in mmu_set_spte()")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index b922a8b00057..98406d6aa2d6 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3044,12 +3044,6 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, struct kvm_memory_slot *slot,
 	bool prefetch = !fault || fault->prefetch;
 	bool write_fault = fault && fault->write;
 
-	if (unlikely(is_noslot_pfn(pfn))) {
-		vcpu->stat.pf_mmio_spte_created++;
-		mark_mmio_spte(vcpu, sptep, gfn, pte_access);
-		return RET_PF_EMULATE;
-	}
-
 	if (is_shadow_present_pte(*sptep)) {
 		if (prefetch && is_last_spte(*sptep, level) &&
 		    pfn == spte_to_pfn(*sptep))
@@ -3073,6 +3067,14 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, struct kvm_memory_slot *slot,
 			was_rmapped = 1;
 	}
 
+	if (unlikely(is_noslot_pfn(pfn))) {
+		vcpu->stat.pf_mmio_spte_created++;
+		mark_mmio_spte(vcpu, sptep, gfn, pte_access);
+		if (flush)
+			kvm_flush_remote_tlbs_gfn(vcpu->kvm, gfn, level);
+		return RET_PF_EMULATE;
+	}
+
 	wrprot = make_spte(vcpu, sp, slot, pte_access, gfn, pfn, *sptep, prefetch,
 			   false, host_writable, &spte);
 
-- 
2.53.0


