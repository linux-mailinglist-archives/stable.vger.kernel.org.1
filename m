Return-Path: <stable+bounces-231032-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AFDMd4tymkA6AUAu9opvQ
	(envelope-from <stable+bounces-231032-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 10:01:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD3C356D08
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 10:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0ED013041389
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 07:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6803A8753;
	Mon, 30 Mar 2026 07:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F17/r0EY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="s+YBoMjc"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9831EB5C2
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 07:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774857318; cv=none; b=liJT65vCtajUFWREIl9Ny8PAYR+5aVVJbHgyUJuF/Ttpao3zycB/mtDst8k4g86n1x0ibxJ9rrnEeosM5BkzKH4G98ofV+ye+mHMXdKh9qEHNGvWOojF8wCxSTkfmBMGxOc45uQ1iwpmDdRcnV//TRkgNimxMlam1/DxEJGAmb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774857318; c=relaxed/simple;
	bh=T+HmSjUn6z8OZZRxZT/JFBxpd0V4CB7xIFG8EfORfvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CV3YIbzXBxHb3gfP6NjtB52dId9tZ7IutUXQ6+9F+0T3L9Va4BTie3VbK8KEsqvCvBvTtgBia3oVdox2s3GuDDFDEhuwuQwSvkjr3I3vbuz1TvpgT5wXXTYsfpUWlXyNksxkT19YFwGznWNNNK7bMEgIGFZMvEiKy291o7v0u8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F17/r0EY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=s+YBoMjc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774857315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KOkZ7WrFrzNMDpXbyrtubTWNgppCw3HrcM7a5zUN2j8=;
	b=F17/r0EYO1GC+84mh829MDiyeLuCV4Fsl9YdjGCNRea/5PrSUN0foFRsXqYxDTtH+Q43mf
	uaxGcVXBOjB+nRlkaBDWxIluMo6+Z7fW1NVYW+/t5M2JDXEbqOws59ix2L5ja1DR5pUw3o
	qYulfX5yGFTyQfNHm9S4/zptU/Uixvs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-hl-QTtVHPvuDwEYuP785hA-1; Mon, 30 Mar 2026 03:55:13 -0400
X-MC-Unique: hl-QTtVHPvuDwEYuP785hA-1
X-Mimecast-MFC-AGG-ID: hl-QTtVHPvuDwEYuP785hA_1774857313
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4837b6f6b93so37732335e9.3
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 00:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774857312; x=1775462112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KOkZ7WrFrzNMDpXbyrtubTWNgppCw3HrcM7a5zUN2j8=;
        b=s+YBoMjcxKzbtp9EDhyA7HM8FvLfS3ghUHEI9CFrx32j8BtBjT1QbRBYeU74wT5igC
         9V11p1oFkOv3X9Faf1ghm6kqq3dCfGGRavpHtetaTEppmPj+QscFICt792V2kq/F2L2l
         SgQpDXSfX4PwZxr1E4+MFsP84374EsFpWnXVo7sZ+Ftxdxj8vL9iago+ObzDeFefa5jo
         h0WfAlN1Ba3hoSyOYBnDq6IX/pHABa5ZyhmhcPMpqgynMvTncilOAgEC6Sda+P9j03FB
         TBz0JCSkPdibwdt3sut4xT1Icxmv7SuOAciU3veTzkNv9bFRBcVbNZp1zpA16po1CedQ
         kQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774857312; x=1775462112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOkZ7WrFrzNMDpXbyrtubTWNgppCw3HrcM7a5zUN2j8=;
        b=Y8DzOpVGaLiVN2nqBSB5dc+d6w8mGIY66aNCf9D0no/qqGRV72zQYXmm1j5+D1GIvU
         iPK1cS7CqS3ZfBBI4I4fy7+9MUQrIrWmKRgSQlfuHm3gsbg/5tdcOLF5WhxZbRHgPCph
         4FTBwMOPt2GpYPbOcDPCmG7RbJaC46wJUngcx4E2utWE9pLro9EEqXcBRrA5cjRwWBu4
         tXTgBPH2TBtVpl3D7+yEeQk7S4MRfo9b5vJJI/RrmkscC8b9Ym92X5qVItY2ZJ2tz4ZZ
         3pR++b26PwxQWXrOZX9bOisYt9rwiHN19Bd2+0FEBvaI/NbqsLIC/zkItuI4UiwzHsXh
         aHkw==
X-Forwarded-Encrypted: i=1; AJvYcCUVh9SDOQz5/BHjErPsGHfjRRO4wagBNKvTaRWKw1pEIiTY6P/bpTrCPR11EanpYyemoTvE4hg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0wP1aBr6jZsFfzIR58rdNV9EsSg67LtY5IHdYQ+E4xo9SoJKt
	/DNd+tpI9jdMPmGwOKM0wV+CD7wCsLFB4qgPqGyvD95vWOs8A9b0pcnRp6W4eBaXqyo9BV9UC7f
	GFPh1Owm4s1/wEkS+UWz9fvMbpdYEVq3v/yiA/6nlQWYKGgC/kmgrnjD0wg==
X-Gm-Gg: ATEYQzxpt1E644ad3iLAB0DsX3l8F7SYg/FciucBpeJqec9Ou81FtWu5g0Vk6r9x+2/
	elRhxOyXElT7Nil/+jdZ+mnTzPU8ndlyy/sSzlqwSFfivXF6Nto/0b/XRH4JnULbYCMmLkFGkPb
	vgvwMmTN1Nso3u4TKbziR+Iuk8ACWVFu4jGFbVt1Yvl+wpCSozvT5AGOWotU7IYhwgW9vWStu1x
	++O56kq10AtZgk/4qOHmAzJmCxUlWUZOr9XScJHIbtxBcpjjoJMi28E0vybiGyt9fYGpatyoPPH
	4zkSDsZsR9p9diHXFWyEGnFB4/grPNyQj2zTs1s+GF8mMCcinq8/WHvtBSvr6OED1obw2R6s++9
	IrtSO2bJg+bYw/wm4HMAcSO6mzzgTHHu4l6ZJz2/EcU1KHeIfAphRjCowrXHl0RUO+E9J4lwXGc
	16lz5/WTzi7I3OJI81M1dARD/n
X-Received: by 2002:a05:600c:3d87:b0:487:2092:b2e0 with SMTP id 5b1f17b1804b1-48727d5a246mr189674085e9.1.1774857312344;
        Mon, 30 Mar 2026 00:55:12 -0700 (PDT)
X-Received: by 2002:a05:600c:3d87:b0:487:2092:b2e0 with SMTP id 5b1f17b1804b1-48727d5a246mr189673785e9.1.1774857311868;
        Mon, 30 Mar 2026 00:55:11 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48727bfc5ecsm173559295e9.1.2026.03.30.00.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 00:55:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	stable@vger.kernel.org
Subject: [PATCH for-6.6] KVM: x86/mmu: Drop/zap existing present SPTE even when creating an MMIO SPTE
Date: Mon, 30 Mar 2026 09:55:10 +0200
Message-ID: <20260330075510.147430-1-pbonzini@redhat.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231032-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pbonzini@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[bkov.amazon.com:query timed out,stable.vger.kernel.org:query timed out,fgriffo.amazon.co.uk:query timed out];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amazon.co.uk:email]
X-Rspamd-Queue-Id: 6BD3C356D08
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
index 04b9b919235e..0dc804149b0f 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2914,12 +2914,6 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, struct kvm_memory_slot *slot,
 	bool prefetch = !fault || fault->prefetch;
 	bool write_fault = fault && fault->write;
 
-	if (unlikely(is_noslot_pfn(pfn))) {
-		vcpu->stat.pf_mmio_spte_created++;
-		mark_mmio_spte(vcpu, sptep, gfn, pte_access);
-		return RET_PF_EMULATE;
-	}
-
 	if (is_shadow_present_pte(*sptep)) {
 		/*
 		 * If we overwrite a PTE page pointer with a 2MB PMD, unlink
@@ -2939,6 +2933,14 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, struct kvm_memory_slot *slot,
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
 			   true, host_writable, &spte);
 
-- 
2.53.0


