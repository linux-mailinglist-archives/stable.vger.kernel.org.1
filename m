Return-Path: <stable+bounces-243990-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOCtJEWV+Wkh+AIAu9opvQ
	(envelope-from <stable+bounces-243990-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 08:59:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 170934C7614
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 08:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D95C33025D08
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 06:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EFA3CFF48;
	Tue,  5 May 2026 06:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="acmq5Rfy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZbB8mqiQ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9529F3A1A5D
	for <stable@vger.kernel.org>; Tue,  5 May 2026 06:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777964345; cv=none; b=Gi0MyzrAmUmapHoHI9ITR4QM1WUzXNmcKBX9Yp4l/tqIuGIsL/ikJ/yx2XXKoRvUfKKHNtLuqav5lLjyNN0W2BywWXQ/p+a/UWlFemR9CIs7g//VH0RfAASTxXWVgL/O+zC1uE4nmNbpg3wO9fnuK131g1B5ce9LqR18Or66jFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777964345; c=relaxed/simple;
	bh=XWPfFYfLhTLa5UB2Be1O7e4jiG88hQHB1AvjGlRbkLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bjy8uQXJqFvyGh/taSwDcUpNNKdyhufBxPYBqq7MlIk97r78YBK6e7v3evP8FSfMP41EugPPaIl71lsJrM7y1vudUHSLtkoFU7GboCMZIj7w8ed3CxvobqoMlA45KlemxYXjIqKfjb7now9D8fIeQB9k3kxDhNOVigXYhLTabb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=acmq5Rfy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZbB8mqiQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777964342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Dzf0pfUjAeoFIT+o1UyKLxzb+hMySmis8LYkbCCF47M=;
	b=acmq5RfyK92IzIjDoNiI/rxjxi5TKeFMgJzFrUIR3mS/V4CEKFCpfeHCOr/fAAkgrXPHgx
	zy2HhUp6YYLMflX5CQTHhEuyVFHhxnPTxzdXcPwFCBBVDrGMYQnzQDUNOzwlCzUemQHifV
	kKHQcqNLM1m63PwnUyqQerss9VkuEWg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-E9LrA_y-O2iHZEhOYM3Jzg-1; Tue, 05 May 2026 02:59:01 -0400
X-MC-Unique: E9LrA_y-O2iHZEhOYM3Jzg-1
X-Mimecast-MFC-AGG-ID: E9LrA_y-O2iHZEhOYM3Jzg_1777964340
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48a55de6fb0so39960085e9.3
        for <stable@vger.kernel.org>; Mon, 04 May 2026 23:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777964340; x=1778569140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dzf0pfUjAeoFIT+o1UyKLxzb+hMySmis8LYkbCCF47M=;
        b=ZbB8mqiQ8iJxv6fkf8ZQZj0dljC1X5iYZeWVjFN1FqjPsEZEucprUyh3YV1eq9D8H3
         7c/PesDVkgmvYCJDAdcM1qmpQeTKuiOqXvHL8cewOK8UZLazXCfZzUP0RtVKWOzg98zZ
         WCJ+SKI8/9y/XuehL4nqi72mAen0cm6WmYe3Jw8+pjfPfe94+K8pjXKU9T5d/pubGuaI
         lMA4PQkedgR4Qb65Fip5Pb7QHblsBZ2LRRcdg/XC4hTdiiD1PtbX+47D54YTVEXmKbil
         TXMX/dcAWhVlL0wLRiBYli8ne1+4w5UTpcKjNDOqRm7U54BHOKtA5r6tY05hqfQmaDpk
         ZCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777964340; x=1778569140;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dzf0pfUjAeoFIT+o1UyKLxzb+hMySmis8LYkbCCF47M=;
        b=RDOrqF3SsPCzOWBQnkGMYnhmODSCkWM4KPoKM+6TWPN6H/htvmKqL9y9ul1x9OiL5M
         3YZDsQaX3RFLiVKB/i+TyWYxNURhi++U8vOhC/nbxAwl87/xfQkkvohV98v+na73mDGi
         p3sOnhUZUzd0eQ/NF2eovgT2QE0w3kS4NhXhcdplyxhkGhmWEOUqgkA6pWgawYVwJ57w
         RN0eBQeEWYoSVWEKC9lY+rUANKhW/oS/zLfFQYMb8dyf2cTiqHr8NFbZRiOmM8o+gcxQ
         Y8k7UQqEBgv7mFhER38S3UAc+N/FN+9nt+uxnu3/2sfNDFA4RSt1F3V5z59EcgI8VWzR
         OICA==
X-Forwarded-Encrypted: i=1; AFNElJ8X9MEgvMP2c4Kbvss7t/unjGz3aAbK/lak0juD8/JS50wMZQDd7B6J2CAxSaCDwRDOpurHEpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvAwK3WjwttJXDBVq7XsPf8O1H1osnmxL7cNfrnjXkAF9f/jPk
	cUAHpcU+ohclNgwISa3TY2b5R4DNLb+aGROPwa4PDkH5YWrSXMG6NvvfKp3yYHyYegYGndwYExP
	c/gYc64XCGyeCTAEgq/AD8Ouvom2oR3YKpclQCuMK0bTaXlv1TaKRB5byYA==
X-Gm-Gg: AeBDievfOxhCVBDUELLRbfZ9GRb978p0dvlWC6xmI4i98zw9XlaQMkTlFTR4PhKcU1c
	MIPZGy6AZNJVGV0M+N3UB/mW5faJRz+VIT0fLSLb2T+Gp18XxCHkY83YofJP10BowTZJnwMhXfP
	JB+RDPi+a6OrYpCDnfVSQvPcPui249YNtLeXWiylnsB3sJPVKbzy558Js61z/gC0h/+VLerl17j
	IW8INIIUqQgoVWtermfsCdDCbEr4x62Tv6cjEaw+yPM99/fNhz+HQdBbT4FJ7JWrAJ+clNKggto
	9j7PfrtiInLHCk/JIaFyzVAUFHZNTZWAjugDAVtuuniAMKNYQGlNIPNZc54Y53QLYLupMW4uVs9
	TPNcdfJumNaKsf69a361Vse3QrMfg5XU+GfjA1CPGAK65qAGM5ZKGoLAqa2Hukzsc1UZWczJbY4
	zWh3FhTxwk5SRsV4D6qXOcqDy6WUTldd61Hh2so7U=
X-Received: by 2002:a05:600c:1386:b0:488:9439:881a with SMTP id 5b1f17b1804b1-48a9852f471mr202492705e9.2.1777964340155;
        Mon, 04 May 2026 23:59:00 -0700 (PDT)
X-Received: by 2002:a05:600c:1386:b0:488:9439:881a with SMTP id 5b1f17b1804b1-48a9852f471mr202492365e9.2.1777964339720;
        Mon, 04 May 2026 23:58:59 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48af0d5a613sm130595745e9.2.2026.05.04.23.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 23:58:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	stable@vger.kernel.org
Subject: [PATCH 6.18.y] KVM: x86: Fix shadow paging use-after-free due to unexpected GFN
Date: Tue,  5 May 2026 08:58:57 +0200
Message-ID: <20260505065857.190809-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 170934C7614
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
	TAGGED_FROM(0.00)[bounces-243990-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,amazon.co.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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
 arch/x86/kvm/mmu/mmu.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index dad7abb1112b..0bd0cb8992c9 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -182,6 +182,8 @@ static struct kmem_cache *pte_list_desc_cache;
 struct kmem_cache *mmu_page_header_cache;
 
 static void mmu_spte_set(u64 *sptep, u64 spte);
+static int mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp,
+			    u64 *spte, struct list_head *invalid_list);
 
 struct kvm_mmu_role_regs {
 	const unsigned long cr0;
@@ -1287,19 +1289,6 @@ static void drop_spte(struct kvm *kvm, u64 *sptep)
 		rmap_remove(kvm, sptep);
 }
 
-static void drop_large_spte(struct kvm *kvm, u64 *sptep, bool flush)
-{
-	struct kvm_mmu_page *sp;
-
-	sp = sptep_to_sp(sptep);
-	WARN_ON_ONCE(sp->role.level == PG_LEVEL_4K);
-
-	drop_spte(kvm, sptep);
-
-	if (flush)
-		kvm_flush_remote_tlbs_sptep(kvm, sptep);
-}
-
 /*
  * Write-protect on the specified @sptep, @pt_protect indicates whether
  * spte write-protection is caused by protecting shadow page table.
@@ -2466,7 +2455,8 @@ static struct kvm_mmu_page *kvm_mmu_get_child_sp(struct kvm_vcpu *vcpu,
 {
 	union kvm_mmu_page_role role;
 
-	if (is_shadow_present_pte(*sptep) && !is_large_pte(*sptep))
+	if (is_shadow_present_pte(*sptep) && !is_large_pte(*sptep) &&
+	    spte_to_child_sp(*sptep) && spte_to_child_sp(*sptep)->gfn == gfn)
 		return ERR_PTR(-EEXIST);
 
 	role = kvm_mmu_child_role(sptep, direct, access);
@@ -2544,13 +2534,16 @@ static void __link_shadow_page(struct kvm *kvm,
 
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
 
-- 
2.54.0


