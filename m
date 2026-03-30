Return-Path: <stable+bounces-231028-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kK9cO/4rymmQ5wUAu9opvQ
	(envelope-from <stable+bounces-231028-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:53:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47445356B3E
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93352306B2E2
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 07:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADE629D281;
	Mon, 30 Mar 2026 07:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cNn9gKTa";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="V6DhZv7H"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF95B3A7589
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 07:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774856957; cv=none; b=b7TaKr2siUWv16158cUgVGK0bb844CVj+/fqan2kl9dlRC0fVQGfBzdd/B64elWfQIwiX/tPGPt1hdJufOaWT3YlPI4Hq3edoe1u3W8PL2RIxXLlBBLEYYL8bP5bhlXzXUmEi1I5qR6lh+UTcIPV78wD6qiwbRZtYH3PH1hiZ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774856957; c=relaxed/simple;
	bh=trMSWKJiFjetMp3AqPFcz4zqskMkgPRMGKygU1o7Dn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dh1bvQrIcnbfcOCGsRz+c/NHVoOM7CNTcg/rMdIsDCiA72ziaVg3FkDKNntjS0am7AVTMQwgnLlQi5CxaJ2bDtZG6q+vTIiaE2vGe1SS6ZyGS+n+IeSbthwQuZmAd2EfDwwGTbuRaEmbIAmcrY0TmmhcYakbqUgZNGpdE/Wvu2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cNn9gKTa; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=V6DhZv7H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774856954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HdWbI73l5k5XBqdSB8dPfIfDNyc/SaWv7SXcZeEOjhQ=;
	b=cNn9gKTapzlr+hbDQNiN2HCXtUSy6YzZvS7aP5g/dHf//btTUvxRdRz919qGMgomQilH8p
	O9HfxPceSQaPEe9TJX6pPIbbOIc4VJ17bLO4WWRSngRtcmW/kROYZqrRQou+M6TE+RJ5PF
	59hm6037WTGGNyIkWYOPRQ9iE93hhDM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-OAfp-QAjO2i7r_b_6YLixQ-1; Mon, 30 Mar 2026 03:49:13 -0400
X-MC-Unique: OAfp-QAjO2i7r_b_6YLixQ-1
X-Mimecast-MFC-AGG-ID: OAfp-QAjO2i7r_b_6YLixQ_1774856952
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48535f4d5e1so47933985e9.0
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 00:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774856952; x=1775461752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HdWbI73l5k5XBqdSB8dPfIfDNyc/SaWv7SXcZeEOjhQ=;
        b=V6DhZv7Hr/hMxKzSI90Wpz7uKKRUc+r2/XAXgKt10HuV9D02/bsfLxruD8G6P7IGT8
         hEnGH3UwRO+5b/SIWJ0nleJwwtF/Yu6tQlG0c+LnQ1euu591CfhGBadqfoCqVOhJj016
         /R/zr4Ls+boSrzTkZ9PyXGi8eY0o+NTOTnbMD27/qSbPg9dwn49MbxorMFmEyljsQrZ2
         kxzHrRS0Dq4TEPdufroYggq/rPKb6zQQo2ZUoKKVo7SxvOV8d8X9vbdAcNGuyc+r/+ka
         Xz05PS58V+uFB9Bssw72ViRraBFdfwVhOxVSCBe+rydXJ9WfvN6nNRPCjs76JfDKx6VU
         OTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774856952; x=1775461752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HdWbI73l5k5XBqdSB8dPfIfDNyc/SaWv7SXcZeEOjhQ=;
        b=aMQRLFGTdmc3+IU7ySwPFgWGjVom/fg1TZHTEqshhOco/4F7evoIRRPE/i7W3CNQl8
         jowFXxCIS15PDwOz4y7GbS6BuugxluIyQ68xZmlfZk7lEkMkD31bqMtyXIvn0WD/y369
         wMyJGxjb9wU6D6Q9OL5+GJzV75tSKXJ5ohPxlghoh/I3/678IicPCLTG8W7SZSPqqqYS
         EWDVcd00w54Qc4mjRY4wOCaK1Pypncu6dAYv2rdP4yrUS7mteqPGXPOXfQjleg6S8dSU
         GHKablMsVXis2kpcmW+4bYbgpRBngn0Y12kzxcNnfk0UzKzB/Oqc4wqskpsLR2G/H+2o
         zWKA==
X-Forwarded-Encrypted: i=1; AJvYcCW8s4aeLxjQfQ/NbcSL6SvAfxIu94+mmlsr9yB8jfE2Q9WPwLpY0ULUjUod8zWeTj8RTFZ+yHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLdmx83ZRuV2kwofHlvgj5kK5ZGAQTekz1xAhj73AKRBllkI/9
	W5UZmQN2c5Rr0T9d0y0IdCEvrqMQuXORpnBdRz8Jsse3eNh4kxnaHhNaVB/dxCEqSpTdkti+PUU
	cPIz1BZiutEYowsAhB/g3FyZvrVsCwVHP6mrIjDeJoqSkH7DS+8hJbZZ+Lw==
X-Gm-Gg: ATEYQzwOxZuw4iHPRjRVAS4+k8y2D30RVn8ajAPZ1/8VdtoWZqWhEjo8+BvCvwzgLlH
	MxJ2bOL70gLWsAl9m3CugX6u09jCGYOjlpW/8jB+1nTxs2aGJzy0Dlw0Fht/ufTyG77JcU67/OE
	dz0CvM2N7Du/Jz1bIWvNe1HgTDiF9QHZ7i8AlUPEOZEjtALa4zk1KlUxJauDx2sZBmIyXlsdd6L
	BiAOb5I1+iBbHo5QXg6DZSVUvIvYN2qVjkse6K8CgT5IaPxBHXL57kwOs6R9R7Qcd7tA6l2xXFR
	m2rDGPPjRX4BSAFoivWid/NTyQ3Uk/cFZfX2Q6gerAH8Yb9g5T2gb1uP74zwbHDc+XnhUwn6IvS
	kuMg0NETVVYbr9jdaFlng53UK/6II0m65xN7mNrl380xSYGr3v1lESYXWaGF2FUSDVZAODO9YU1
	13O10tUmknQpen7Yzvfa0e+SZT
X-Received: by 2002:a05:600c:a00a:b0:486:fcc7:d6a with SMTP id 5b1f17b1804b1-48727ea275emr178546295e9.13.1774856952116;
        Mon, 30 Mar 2026 00:49:12 -0700 (PDT)
X-Received: by 2002:a05:600c:a00a:b0:486:fcc7:d6a with SMTP id 5b1f17b1804b1-48727ea275emr178545905e9.13.1774856951674;
        Mon, 30 Mar 2026 00:49:11 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48727bfc5ecsm173139175e9.1.2026.03.30.00.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 00:49:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	stable@vger.kernel.org
Subject: [PATCH for-6.18] KVM: x86/mmu: Drop/zap existing present SPTE even when creating an MMIO SPTE
Date: Mon, 30 Mar 2026 09:49:08 +0200
Message-ID: <20260330074909.140480-1-pbonzini@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231028-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazon.co.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 47445356B3E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sean Christopherson <seanjc@google.com>

commit aad885e774966e97b675dfe928da164214a71605 upstream.

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
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 667d66cf76d5..a8fe777ba274 100644
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


