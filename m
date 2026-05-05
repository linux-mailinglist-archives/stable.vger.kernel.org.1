Return-Path: <stable+bounces-243996-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IXWDmiX+WmB+AIAu9opvQ
	(envelope-from <stable+bounces-243996-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 09:08:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DAD4C783A
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 09:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A5F9301CFB1
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 07:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AF43CFF48;
	Tue,  5 May 2026 07:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O/52p5k0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="f1uSc6Ap"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F77133F36D
	for <stable@vger.kernel.org>; Tue,  5 May 2026 07:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777964900; cv=none; b=hXl7anQUCykcSgtO/lqzbMALV0i6T71ypCFGFP0AWO3oaLWAqmStrj7OOw/B0+z5ND0z6jtADPzkT6KJkZ8k51SFTNcbhGaGuvF6iiHjML6G5j9vxZWPCdwKVZwtstz5Ya9pUxcu+/kYiVdyHwBOZuR/YTeFbcsJv59kR4W1HVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777964900; c=relaxed/simple;
	bh=rhuOD+E0HK6vTZxQh0nNo79jGVBrQZSoJ92HTBng/ng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PDvYuPLG98a++lykwnLGLOpkEvY1z0HeEO4XrQYCtCdsukcYczBxGi/dTsX+nLCLVJ4P0O8hsEfyqnova2q/f2mwOCjpGXACjijGLGJH9DrYkbjwkY9EYebwICMHtLSZEZz14qNqJN7qd3JQ3aKcupwHn7WSRCKpZ3/2nIvoszY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O/52p5k0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=f1uSc6Ap; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777964897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yeVY9MkCXy7pdk8snaK66JA60FQ3IkREAluPMekcUpg=;
	b=O/52p5k0Vtlxs7VD9tAM7H+LQw2f1O7+dlkjhLrgtehbqgAony9ymSodirfzh+oPfJFnfo
	TebGzOHpGpj8WKRZeUlf2o8M3IEMr7M8Y54nF8HMaTzUGj16iNW9YyrMZ1sV5vSQ5GozYS
	uUojiEdVMcqFk6HysnChFTpm3udvqRc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-cLSDdhasNVOFkgTO1THysg-1; Tue, 05 May 2026 03:08:16 -0400
X-MC-Unique: cLSDdhasNVOFkgTO1THysg-1
X-Mimecast-MFC-AGG-ID: cLSDdhasNVOFkgTO1THysg_1777964895
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48a55ecc32cso45387365e9.1
        for <stable@vger.kernel.org>; Tue, 05 May 2026 00:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777964895; x=1778569695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yeVY9MkCXy7pdk8snaK66JA60FQ3IkREAluPMekcUpg=;
        b=f1uSc6ApYTfTS2N8kd5yktmAYgc2JO4rp5zErfxh50Rw586pcVVMsjlCsjayMsM89X
         I6sKRs5dljWNnNIuZOmgaRhqNyThTazdfqilnnG9ghZBr3lzvyZ3v3B22oSvK/x3GNzz
         D86pUeKYnqUB3+HI8mk4hAhAQG5OKxg6Bqvi/aIlA+ofXjT3aUDAU1OmqpFZZ+l1WOej
         +qjae1WyMyCw13iiKHO//iJwEEA0WiT5J2wpA6d9VKVCRS748cIfPoQMsR9Uw7SHuJvs
         3Ogg2nOYjKJ8rwXAlCaFPqOJdyOjmuZu0SXCcGikE79/jLRskRfM7KSITy2ROv8vL86m
         9psw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777964895; x=1778569695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yeVY9MkCXy7pdk8snaK66JA60FQ3IkREAluPMekcUpg=;
        b=Dyr5k8r5iMRVMq8Sc0NKX+4Ty2Kb1bnEvdZZHf/o4Y9E1mP3rjWGkb1hnX6GwmINEy
         PJsK7KdImERtIgAza/kmbVKPE9mKpEJYe7AwnqkbKr/jgL2Ep9zxlrlegkGP8b8mPX16
         gpQUfI6WZ9MP3Z8Tcq2sePkiIAHB/V8q4YwUJJAQFQxedytV31/ifQ5U8HJlNvSK1o+J
         nkeEs/o1kAAn3PfBkCv1EmO7hOobp1rPp5Jsrvy/1eX2zrJR4BZC2Okeipu5JiIBD37n
         S1B8qKgWdWOfXEL7i62XkLR3Rgpts36RO4UgmS4Jv6yaVzWOutJYnEOARyQQBi2YTj97
         sm9w==
X-Forwarded-Encrypted: i=1; AFNElJ9bNOkAlFjc0dckhePCprxDy1Wf4UIbafwfJZu25N1ffiFpssfMU6qzUMAduZfdexJzaED+Ql0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+2OzrclsogQBqD+TyP8LctRSftITZCCLFipLMlzRZQe0G+MQr
	MeoEjXi1Y4V+/Mpx0LkcyienTE1dQzvRC9T95of1vSMiFH2wHsymiiNXSwVswLVmVDwzHlzFDFn
	ZLOxzc0bp9wjYSpjQQKToBrHUDaPqU2ZpMQDeqJzPu8n11CbK/Q7iMD23Rw==
X-Gm-Gg: AeBDiet3f495naNeOZZ4Aex2GYRW8gFlG5iyCHgqEmhLjc8jD659XzrQr+Y39CTVAoA
	Zt7+j9ScS60KQaY1qD/HYJ7GNxRCp/MR63R3w95lFZmTTS1sxlpN051IWhXRmUq8D4NEFKwr9J+
	wts0fXZBzvXlXNrP13d2OcYAKlxN2JnR2XkryOWffJ+pdPq7LVmWk7DjsQ94OGjwlWBV6NEAbFd
	3/ai3lYOvLm2ctiNwW49WG8jrxpajQz0PSTTLzPzjaSxmjSUniJL3thYvOHQVRNdf6Yv6WkVdbB
	9wzqiaW6YfZe3qyJ13eUmf4By1jXWgDdtB9GN5BfgDs6/Vo91cYwZUsIi542E4Va3AHGTJIhNKd
	zG3COH/bIvFrH/TiasZd6c/OI+9C7DSBiexHPveUJXmGSJU8yTPQREga1YoMq66V7HExRz+Bthw
	7bFB2r6X+7bWe1ZU8pwLVKnaJPUsGmS+8UJEOZ5mQ=
X-Received: by 2002:a05:600c:c174:b0:48d:1a94:56c with SMTP id 5b1f17b1804b1-48d1a94087dmr23654295e9.18.1777964894840;
        Tue, 05 May 2026 00:08:14 -0700 (PDT)
X-Received: by 2002:a05:600c:c174:b0:48d:1a94:56c with SMTP id 5b1f17b1804b1-48d1a94087dmr23653635e9.18.1777964894335;
        Tue, 05 May 2026 00:08:14 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055e2d3d0sm2136470f8f.34.2026.05.05.00.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:08:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	stable@vger.kernel.org
Subject: [PATCH 6.1.y] KVM: x86: Fix shadow paging use-after-free due to unexpected GFN
Date: Tue,  5 May 2026 09:08:12 +0200
Message-ID: <20260505070812.221568-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 84DAD4C783A
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
	TAGGED_FROM(0.00)[bounces-243996-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pbonzini@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amazon.co.uk:email,msgid.link:url]

From: Sean Christopherson <seanjc@google.com>

commit 0cb2af2ea66ad8ff195c156ea690f11216285bdf upstream.

The shadow MMU computes GFNs for direct shadow pages using sp->gfn plus
the SPTE index. This assumption breaks for shadow paging if the guest
page tables are modified between VM entries (similar to commit
aad885e77496, "KVM: x86/mmu: Drop/zap existing present SPTE even
when creating an MMIO SPTE", 2026-03-27).  The flow is as follows:

- a PDE is installed for a 2MB mapping, and a page in that area is
  accessed.  KVM creates a kvm_mmu_page consisting of 512 4KB pages;
  the kvm_mmu_page is marked by FNAME(fetch) as direct-mapped because
  the guest's mapping is a huge page (and thus contiguous).

- the PDE mapping is changed from outside the guest.

- the guest accesses another page in the same 2MB area.  KVM installs
  a new leaf SPTE and rmap entry; the SPTE uses the "correct" GFN
  (i.e. based on the new mapping, as changed in the previous step) but
  that GFN is outside of the [sp->gfn, sp->gfn + 511] range; therefore
  the rmap entry cannot be found and removed when the kvm_mmu_page
  is zapped.

- the memslot that covers the first 2MB mapping is deleted, and the
  kvm_mmu_page for the now-invalid GPA is zapped.  However, rmap_remove()
  only looks at the [sp->gfn, sp->gfn + 511] range established in step 1,
  and fails to find the rmap entry that was recorded by step 3.

- any operation that causes an rmap walk for the same page accessed
  by step 3 then walks a stale rmap and dereferences a freed kvm_mmu_page.
  This includes dirty logging or MMU notifier invalidations (e.g., from
  MADV_DONTNEED).

The underlying issue is that KVM's walking of shadow PTEs assumes that
if a SPTE is present when KVM wants to install a non-leaf SPTE, then the
existing kvm_mmu_page must be for the correct gfn.  Because the only way
for the gfn to be wrong is if KVM messed up and failed to zap a SPTE...
which shouldn't happen, but *actually* only happens in response to a
guest write.

That bug dates back literally forever, as even the first version of KVM
assumes that the GFN matches and walks into the "wrong" shadow page.
However, that was only an imprecision until 2032a93d66fa ("KVM: MMU:
Don't allocate gfns page for direct mmu pages") came along.

Fix it by checking for a target gfn mismatch and zapping the existing
SPTE.  That way the old SP and rmap entries are gone, KVM installs
the rmap in the right location, and everyone is happy.

Fixes: 2032a93d66fa ("KVM: MMU: Don't allocate gfns page for direct mmu pages")
Fixes: 6aa8b732ca01 ("kvm: userspace interface")
Reported-by: Alexander Bulekov <bkov@amazon.com>
Reported-by: Fred Griffoul <fgriffo@amazon.co.uk>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Link: https://patch.msgid.link/20260503201029.106481-1-pbonzini@redhat.com/
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c  | 36 ++++++++++++++----------------------
 arch/x86/kvm/mmu/spte.h |  5 +++++
 2 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index ed5ba38bec86..58d67e5ab2c5 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -163,6 +163,8 @@ struct kmem_cache *mmu_page_header_cache;
 static struct percpu_counter kvm_total_used_mmu_pages;
 
 static void mmu_spte_set(u64 *sptep, u64 spte);
+static int mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp,
+			    u64 *spte, struct list_head *invalid_list);
 
 struct kvm_mmu_role_regs {
 	const unsigned long cr0;
@@ -1156,20 +1158,6 @@ static void drop_spte(struct kvm *kvm, u64 *sptep)
 		rmap_remove(kvm, sptep);
 }
 
-static void drop_large_spte(struct kvm *kvm, u64 *sptep, bool flush)
-{
-	struct kvm_mmu_page *sp;
-
-	sp = sptep_to_sp(sptep);
-	WARN_ON(sp->role.level == PG_LEVEL_4K);
-
-	drop_spte(kvm, sptep);
-
-	if (flush)
-		kvm_flush_remote_tlbs_with_address(kvm, sp->gfn,
-			KVM_PAGES_PER_HPAGE(sp->role.level));
-}
-
 /*
  * Write-protect on the specified @sptep, @pt_protect indicates whether
  * spte write-protection is caused by protecting shadow page table.
@@ -2253,7 +2241,8 @@ static struct kvm_mmu_page *kvm_mmu_get_child_sp(struct kvm_vcpu *vcpu,
 {
 	union kvm_mmu_page_role role;
 
-	if (is_shadow_present_pte(*sptep) && !is_large_pte(*sptep))
+	if (is_shadow_present_pte(*sptep) && !is_large_pte(*sptep) &&
+	    spte_to_child_sp(*sptep) && spte_to_child_sp(*sptep)->gfn == gfn)
 		return ERR_PTR(-EEXIST);
 
 	role = kvm_mmu_child_role(sptep, direct, access);
@@ -2331,13 +2320,16 @@ static void __link_shadow_page(struct kvm *kvm,
 
 	BUILD_BUG_ON(VMX_EPT_WRITABLE_MASK != PT_WRITABLE_MASK);
 
-	/*
-	 * If an SPTE is present already, it must be a leaf and therefore
-	 * a large one.  Drop it, and flush the TLB if needed, before
-	 * installing sp.
-	 */
-	if (is_shadow_present_pte(*sptep))
-		drop_large_spte(kvm, sptep, flush);
+	if (is_shadow_present_pte(*sptep)) {
+		struct kvm_mmu_page *parent_sp;
+		LIST_HEAD(invalid_list);
+
+		parent_sp = sptep_to_sp(sptep);
+		WARN_ON_ONCE(parent_sp->role.level == PG_LEVEL_4K);
+
+		mmu_page_zap_pte(kvm, parent_sp, sptep, &invalid_list);
+		kvm_mmu_remote_flush_or_zap(kvm, &invalid_list, true);
+	}
 
 	spte = make_nonleaf_spte(sp->spt, sp_ad_disabled(sp));
 
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 7670c13ce251..0ed97eb1c2e6 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -295,6 +295,11 @@ static inline bool is_executable_pte(u64 spte)
 	return (spte & (shadow_x_mask | shadow_nx_mask)) == shadow_x_mask;
 }
 
+static inline struct kvm_mmu_page *spte_to_child_sp(u64 spte)
+{
+	return to_shadow_page(spte & SPTE_BASE_ADDR_MASK);
+}
+
 static inline kvm_pfn_t spte_to_pfn(u64 pte)
 {
 	return (pte & SPTE_BASE_ADDR_MASK) >> PAGE_SHIFT;
-- 
2.54.0


