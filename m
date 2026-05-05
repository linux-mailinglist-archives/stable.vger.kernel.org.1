Return-Path: <stable+bounces-243994-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EISJqaW+Wl9+AIAu9opvQ
	(envelope-from <stable+bounces-243994-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 09:05:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F764C775D
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 09:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AEC023010BCC
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 07:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02F93D6478;
	Tue,  5 May 2026 07:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d9+mw5rO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AtNiF9Ko"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EAD3D565E
	for <stable@vger.kernel.org>; Tue,  5 May 2026 07:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777964467; cv=none; b=NiXGnb5Jrv4gfLKB6c79NkeAXnbAHNVvX2Z35eknPMX6LYesEGpWzB/xDDI9N9ovikHaJOb1EjnWRTNJH5r/ziRq9BUeRcn+sNt60uWFrrr52a5Vr2eGzuxbmxlgNxbChpj0a63ilUBg9natOHiPNGRs+8xnGx9tICwO6R6Jo7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777964467; c=relaxed/simple;
	bh=3LvJ5/xV1RQZaGHxF6pNpvvDu+FnGFMU5F1qw0qXnjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DsQUx5XVoGBorhJHUk4Hgw+bTRkxTL1JjmmCBihHceO5F3VbKphX69Y4DGHiUGFFQVt2ke0iDntmralN5C3bx3NIVpUQ8czl0tilTVZJdGMgW15OgdBLc5AzOcukgGiM7NRifaBISdeLxjMmYkhlfbYQhYZkzpvz0Uzbo8OGhS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d9+mw5rO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AtNiF9Ko; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777964464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nmU0xMG7ra+orDcAl7Q5QIsymSvh/y1zuyvrvlpHwIA=;
	b=d9+mw5rOvvJ6URvKpHJrYyA5zmq9R53rppQ0sGhwK5ENoANMbOAeyTP5XYDO1kJUtNGziB
	Yal9lV/juEKfhFhT/XyL7WWZE9G0pmNeBJbQTTz4tFG1+IX12OtdK5MgI97Nv8/EFO0fdF
	Mge6x809fVKHRvgwfOCfEWziN/ywoPg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-X-eZvOt6N4uWdNRCWgQ9IA-1; Tue, 05 May 2026 03:01:02 -0400
X-MC-Unique: X-eZvOt6N4uWdNRCWgQ9IA-1
X-Mimecast-MFC-AGG-ID: X-eZvOt6N4uWdNRCWgQ9IA_1777964462
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-44ffa15dc8cso291671f8f.1
        for <stable@vger.kernel.org>; Tue, 05 May 2026 00:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777964461; x=1778569261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nmU0xMG7ra+orDcAl7Q5QIsymSvh/y1zuyvrvlpHwIA=;
        b=AtNiF9KolNQgaQ8giHNIOWxzmazjZhvMx8S0AR7Gm9IB2vLlHPlBIsZZ9dSd2bidgI
         B3lU7/sAFJl3ZBV34kPAeswIWKRn2tIsRKdTRy9+WJJ1vhPAnQ8ssrNrcTf9G3T8P2lZ
         ysClWME/Q/BpnzXjuTNA4+FEiEImxdaHp7Vxe9lXgHo/MvbirTzxW80RMTBS4UossJDw
         GlV0Vv3gcxhaDZRcC5sEK4YkiEHOs7DLl9/FWN9JwJHD0+RM6oyxk4Y/SOFl+BcLe9sI
         Dg5HvZHZwtVXvOnrHzyP5hh8ZucS/l7oM6vdB8ApmKE82CxQBTV7SjeSeMLj5//ON39U
         e4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777964461; x=1778569261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmU0xMG7ra+orDcAl7Q5QIsymSvh/y1zuyvrvlpHwIA=;
        b=oAXKc41grrLLdy1k46OJHCfTmQjTlxpbdCe7WF8Ut8s/Lq6W6BRUkYXv5sXeKaTSVx
         9sumQ1nmzv82bxnZ+BA0wGcztgyV0AdQLWeGAYV+Y/Lb+cfq9aMeSMoG5gPyasi920GN
         6JWEz9Pkvpr13M18rUXnYb1VSbX4nAPq0UGV4MIwN1tH+rKPzE7NiBuE+KVmwAJa/QBd
         kdT2qS++2gZWowGbO9pZrW1a2bDkQ8kYTEl/twKxP4czd0SNenkoyXdnnPTkD0bgRP/a
         gm0sFVH7yx8lShPnIpb3qNZBimOcITwAcBgkwDqmPdII5vXhM9DF8NQfD3gLQ7R4Uw1Z
         wkPw==
X-Forwarded-Encrypted: i=1; AFNElJ/n4QG9486/MzVkmDlAhnuG3fnmgJkiB+xfCIDeElGI9HnVBTie382RRviIR1iPYUrr5NbpSLs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt12dP8xDFW6c3hxt3QH/3PF0YIKuenPp4e3QEZi3LvvunmKA2
	v3S25msTx0FOJX+da3cq3diKDU/hoqd34j8EBGqwSl2u/c5IinYW2tCFFn3+uRcObrhMPznbMNx
	zsv419GI2O0qeJPg0mQbzkmDEjeaRH9dr9AA2ZlCzcJrxOfdf3HuS+6IhzLiVU57pnA==
X-Gm-Gg: AeBDievkxd6kRC3n1yL0YE6WPWVCa46erlmm425WkkQA7mnA4BacVGDJzwNkmmzZhGE
	0pBrwsKeX5+9ZLJ3jUbrSQMUd+UCIgFcbknOFraxgQQf/WOAv9hPC3caFZaZrx1zsZrDW3Q/tk3
	FlwJjvtm3ne+xEexsB6852OWOUciWBEckwAmaoEB2/paNbbCGimjurVTgcaqpZC/24dLaNkNHLF
	h1dLLO0WnFRoGE9vs2p6il0UPGV5Wsi83UCPoyO+RrEObriUf5SogWFiFQXpiLihqjXBTbwyWEM
	kpZAfzjw8XNhjoiKunwy+t7T6oDt8fH7LrixH592tVUHL1+G8hJ1zoJfr6LKvLNW/pzYWXYptaZ
	1VTBy1v1K0bTqYhJgkus+KDNA8vRjliQEtwpgRNf6n53mZ9SksMB4NP5tLsAYNrMwVzYoyoz3ua
	czoKjjqDkrfUvaC1QX+G1mUfh2N2Fji8uoUicfI0s=
X-Received: by 2002:a05:6000:24ca:b0:43d:7508:c9c9 with SMTP id ffacd0b85a97d-45005c81614mr3326417f8f.27.1777964460016;
        Tue, 05 May 2026 00:01:00 -0700 (PDT)
X-Received: by 2002:a05:6000:24ca:b0:43d:7508:c9c9 with SMTP id ffacd0b85a97d-45005c81614mr3326348f8f.27.1777964459369;
        Tue, 05 May 2026 00:00:59 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-450524833e1sm2243371f8f.2.2026.05.05.00.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:00:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	stable@vger.kernel.org
Subject: [PATCH 6.6.y] KVM: x86: Fix shadow paging use-after-free due to unexpected GFN
Date: Tue,  5 May 2026 09:00:57 +0200
Message-ID: <20260505070057.198705-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 34F764C775D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243994-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazon.co.uk:email,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

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
index 0dc804149b0f..774bc26b8235 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -182,6 +182,8 @@ struct kmem_cache *mmu_page_header_cache;
 static struct percpu_counter kvm_total_used_mmu_pages;
 
 static void mmu_spte_set(u64 *sptep, u64 spte);
+static int mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp,
+			    u64 *spte, struct list_head *invalid_list);
 
 struct kvm_mmu_role_regs {
 	const unsigned long cr0;
@@ -1194,19 +1196,6 @@ static void drop_spte(struct kvm *kvm, u64 *sptep)
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
@@ -2350,7 +2339,8 @@ static struct kvm_mmu_page *kvm_mmu_get_child_sp(struct kvm_vcpu *vcpu,
 {
 	union kvm_mmu_page_role role;
 
-	if (is_shadow_present_pte(*sptep) && !is_large_pte(*sptep))
+	if (is_shadow_present_pte(*sptep) && !is_large_pte(*sptep) &&
+	    spte_to_child_sp(*sptep) && spte_to_child_sp(*sptep)->gfn == gfn)
 		return ERR_PTR(-EEXIST);
 
 	role = kvm_mmu_child_role(sptep, direct, access);
@@ -2428,13 +2418,16 @@ static void __link_shadow_page(struct kvm *kvm,
 
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


