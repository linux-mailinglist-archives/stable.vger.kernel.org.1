Return-Path: <stable+bounces-243991-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0RgHJfuV+Wlg+AIAu9opvQ
	(envelope-from <stable+bounces-243991-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 09:02:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C8B4C768D
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 09:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DE0EF30260ED
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 07:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7947A3D522F;
	Tue,  5 May 2026 07:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gZrFztV5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SblfkwJW"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406B23D1706
	for <stable@vger.kernel.org>; Tue,  5 May 2026 07:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777964414; cv=none; b=ArzTP1GX+NwQ7UjTiETa7kx6v2OfwuGlszpYvUJLz68gHf/qU2OxrZdAMViv1loMFohioLn/p7wb/SydvSYOr/INYrE4YYFXTmQNwuyUPkATQ4f5N68VXLoa+XVF/ek6lnDGhIiTt9xHmeQatfuA6pBDfy06/9RCjPFNIxQNaEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777964414; c=relaxed/simple;
	bh=4C1O+8Yb28gsJ7ML7nEymKcrBpr/Esj8D8nSpfVwuLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LcDBtIWt5/iJ8oxHXGdHaseRAf73wpgTVGlRPNWxeILmHqipdNDzOVXFdO6keBaiSSy7LU6BMxp3hn6yLBP3gbm6yAMb6hCsl6zUHnYyBk8QE7x7P9YFhw//8DDNmKtuZOEVqw4ejFL6aIY7pRsJp1lrA32SWX8o5POzXUSurwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gZrFztV5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SblfkwJW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777964402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x2E3eylXZgkiQ5B17tOE4z6voBdoulQpJBVyOORx3Bk=;
	b=gZrFztV56/TazIH0SLiUt4w4wHRXL8mbCWLyi14LnQ0w70kuOwwmUQZ9mGUutVOjg5QW3G
	3etbkZdhVHzBOJAffnTWnTkIh14qRejbp24/prZPUQQNx+bzeqTJm8CAPkc3jlW81sDIVj
	mpJnqndyUwFJre5hhKSKG397MV23hMc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-qsZeOyvrOyaJ-iTNTwoQNQ-1; Tue, 05 May 2026 03:00:00 -0400
X-MC-Unique: qsZeOyvrOyaJ-iTNTwoQNQ-1
X-Mimecast-MFC-AGG-ID: qsZeOyvrOyaJ-iTNTwoQNQ_1777964400
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-44d9ace59efso1507759f8f.1
        for <stable@vger.kernel.org>; Tue, 05 May 2026 00:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777964399; x=1778569199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x2E3eylXZgkiQ5B17tOE4z6voBdoulQpJBVyOORx3Bk=;
        b=SblfkwJWSZNAg6DHpBf/Q5w9WyE8NRnBNqN2ofgWgbLVpPg8XXLCa+IIzUo3HJuUF4
         gZLjHA3kpfGMy0rbLWYetQ37MCC1r44fvVbvnHk1+olBWktXGeofm7YHwiQ8pVjXf4e2
         88tMRzSn0ebbhPyYT9lk9J9Mwke23S1+U/xwQPQ8e5RtxRP5an4ym8Eb9UOBCCj9bFho
         NHtGKmpDI8FpxhwyRS6yidMwJldj0TenSuQYIYn0aTphWarI54aIMqFtbOwsqkw9ZK0R
         1/hlL+InP6W0p0earCJ2ngRGlCUihFHy5a4LauWRUHyqEU1sGEoYEZ6wowAt5pOoypLV
         u6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777964399; x=1778569199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2E3eylXZgkiQ5B17tOE4z6voBdoulQpJBVyOORx3Bk=;
        b=H5BWjBq6C24vHXBePfOvRDsGUsMuOTL9KaOC16fMrYR/jYGh72A6upK5qCuz6j+0d8
         B9tAGQgGOnbiB6fPt023CEdUVbObYlepRks+lZYg1ESnTqHcjEZrzH0VQkVvsJyI3en5
         2G/9OjvUj+fHmEF2VBSFCcZQzKWvvCnKDbKP5dBPeZvaE3upfxckBCwrL1o6MgWF9IZ1
         IuHC8ZWdW/GMh9f3Ynh2JgOitWn5rKYurMkgbDPwmnneXckf3bfOZX9P83OkKSwV8GvY
         O35c7eulZ+0JDejC3cGem+4JWSJsQGZ68SdZrY9WwIDBmRcgI60romnMCOaJDMRs732L
         hxMQ==
X-Forwarded-Encrypted: i=1; AFNElJ+EQGs0qsVJ5upgmlRzVEG6cWh6o4T16t9M8mm5Bp6Agjy/c8FD9jx2FJgjpCcEILkNTTCrv6w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn/Ad0/kq7NpbVrMOGRT2t54WxrL3SKBWfgZE4MCs0tc5mMB+C
	HzWJwI1wSIinOw27jK9Ed+9kED/QBMDrm0aCGd61G16eIMVdqgxeOH9oJIrB3IZOM9WRxiSHIZY
	AdcqzNDtuOOJjfVAmBYwOS6WDe30eV+1MHf4w4p8HIR5ruTxj3ZJXbLKcZQ==
X-Gm-Gg: AeBDievviAU7kM4XrqbScAThNvYIXcbTgHCH8o3Tw1w4oPoNqrIJ5vRX5P9OUz8NLKw
	XTcnuV0mGvRSxtUAAt7lvUNFgvzO2Xlq8RmHRQs2VkYBmh//ur/XHG5qgf+O1HSY5XLxiKGdg8Y
	iBqDlJgCPpjo8p121r5JeED5lkikjFvM+7trrs5ktSm/ByM8vocYUlzm7wYLXuZCcp02hCTaFLX
	cAx7Ndlw0BV4oLsCpMk6WOIhNphdjB8+3Dlj8qYrhujOuEO6dsCZ77CzqjJRt7EYVGmg7kcRnQZ
	oIYXqG84kb658gZAka4zUu/qmKw1zuTIa6VfLOX1XVPK6fwarbmH6NrbZOHKAwpVb1UBhkH5kpz
	jM+noBBfMJeVI8VFNzYsANZmRFXkK5n8k/i6/z8Ctr0Dg/KMBMWr1m+VpE7Jn6nKmZyonaSmQWF
	3WJnaolxfK1law1QHh2MlnqwW9DgAmOSOw1fyb1jw=
X-Received: by 2002:a05:6000:24c9:b0:43d:21a:9a3e with SMTP id ffacd0b85a97d-44bb65dfc18mr19767204f8f.32.1777964398943;
        Mon, 04 May 2026 23:59:58 -0700 (PDT)
X-Received: by 2002:a05:6000:24c9:b0:43d:21a:9a3e with SMTP id ffacd0b85a97d-44bb65dfc18mr19767108f8f.32.1777964398115;
        Mon, 04 May 2026 23:59:58 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4505238e6e0sm2069200f8f.6.2026.05.04.23.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 23:59:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	stable@vger.kernel.org
Subject: [PATCH 6.12.y] KVM: x86: Fix shadow paging use-after-free due to unexpected GFN
Date: Tue,  5 May 2026 08:59:56 +0200
Message-ID: <20260505065956.194882-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 31C8B4C768D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243991-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amazon.co.uk:email,msgid.link:url]

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
index 2c11819bd216..d288c60ae200 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -182,6 +182,8 @@ struct kmem_cache *mmu_page_header_cache;
 static struct percpu_counter kvm_total_used_mmu_pages;
 
 static void mmu_spte_set(u64 *sptep, u64 spte);
+static int mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp,
+			    u64 *spte, struct list_head *invalid_list);
 
 struct kvm_mmu_role_regs {
 	const unsigned long cr0;
@@ -1187,19 +1189,6 @@ static void drop_spte(struct kvm *kvm, u64 *sptep)
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
@@ -2342,7 +2331,8 @@ static struct kvm_mmu_page *kvm_mmu_get_child_sp(struct kvm_vcpu *vcpu,
 {
 	union kvm_mmu_page_role role;
 
-	if (is_shadow_present_pte(*sptep) && !is_large_pte(*sptep))
+	if (is_shadow_present_pte(*sptep) && !is_large_pte(*sptep) &&
+	    spte_to_child_sp(*sptep) && spte_to_child_sp(*sptep)->gfn == gfn)
 		return ERR_PTR(-EEXIST);
 
 	role = kvm_mmu_child_role(sptep, direct, access);
@@ -2420,13 +2410,16 @@ static void __link_shadow_page(struct kvm *kvm,
 
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


