Return-Path: <stable+bounces-242819-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGLvMr6r92mUkgIAu9opvQ
	(envelope-from <stable+bounces-242819-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 22:10:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 440C04B73B1
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 22:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3662C30048EA
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 20:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9080C387378;
	Sun,  3 May 2026 20:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QSTYUUM0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bIij9EJS"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF06234F48E
	for <stable@vger.kernel.org>; Sun,  3 May 2026 20:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777839036; cv=none; b=PGpVilkcnMgzyC+jDYP12L6x8hnzL9kF0cdVhOljEq1Z56yQuva63LmTkqIazVmRXvSIlUToCiV4fmmF95yAbBragDjdxDJ5sQUe32xBW5GcHoBOUfHLZ/eJu/xLWJSWJ4V1+j5ukTKnZ1lio5fJhqYSw5xkHuP2aUyu8Ak47+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777839036; c=relaxed/simple;
	bh=FJJu0Q8b2ueh6dZR5A0YmhAFs1n+6AjOWyzmtKhTK3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XcDQl7fie8L/UWvU2BfWi+mtrKgti1/ldeTHbHOWiqpxFOv55GWEQNOpoKWJcxf8GfolN5vfoEAhyw9uT/ByeZg0t3UT4G/zRmLKrvDOtpQV/l+XeICrMpBhBZZ8Wl+XuPmf9tQfPGT2+wm3QWyVDHsN7xqffM1DsVX81OlpzkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QSTYUUM0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bIij9EJS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777839034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3wj86k5SwQWzT11yN3H7FC66hHNrBnlKpIWYcQSBC50=;
	b=QSTYUUM0GAHvsW1k+aPe5JAWaCX0Xb7tfvN0dRJJL7DpJ3/fwnIpp+lUPKLS7L15W0ciXY
	7dh0fV0hC2bJUcnpgOV1SzzBuhXp2E1fqiAblBsEcjpC+8g8yZDzqH0Fs9qMQDbhGruUBm
	CbDFqTfAotuh9FJMcnjhRaZ6IHfHmG0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-YZY1hUvtOMyj4LDT_iIbAw-1; Sun, 03 May 2026 16:10:32 -0400
X-MC-Unique: YZY1hUvtOMyj4LDT_iIbAw-1
X-Mimecast-MFC-AGG-ID: YZY1hUvtOMyj4LDT_iIbAw_1777839032
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4362197d1easo2872053f8f.2
        for <stable@vger.kernel.org>; Sun, 03 May 2026 13:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777839031; x=1778443831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3wj86k5SwQWzT11yN3H7FC66hHNrBnlKpIWYcQSBC50=;
        b=bIij9EJSsxKLFtd80mQtAY3FI2Bl72ODb3p7mMK+PcVGUjP3/kyccBJLLkgyzEcjNp
         B2pXUhzcqN5pUzefSrRjj58GM9PuFXTvBHzKUbrq6U32XfAM2KEMBRJkDbuNLsAICOCH
         ZhruRyZf9v804im8FXSCLnlvkwwjvi2fsXR617rZQf2Hy1bQnKQrom4WoKBXRS8pMbXg
         kgXNRUwWyBU4T1XWJXKYx75Djwn3fBbaCStEDghpfg2NOnCwcfi2ZKhyRV2JhHkXj1bX
         UDfnEK7VxCk+2mp9Rn793TAinvt9ktCvYqXnLA5t9UkPg9Y6J80IuRXbXnd8TyOrLR9o
         C7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777839031; x=1778443831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wj86k5SwQWzT11yN3H7FC66hHNrBnlKpIWYcQSBC50=;
        b=MuBS7rAUQZbaIBSTD/GR8M3+RkafJyaOYYR1VtTSb+z5jSoFsfxzztxoiHteY/ME/L
         1ZyQ5tMmS1T2vc16+CiG9OyJCJQ+/m4ElvOLkyW6i19xAQwBq0xRnf4zdja+PTSaj7C3
         QTKaGNr0VVPcUKh/2RSp003dVzKfxYyX8E8cR3MinW+SeSIGiKxTcU4I4o/KutBFl51B
         B3VY3i8OxdANLbcaToPvFWEC32FoklCBebGbZJDkHP/LuzT7MrThJW6qGlixKp/pxsCr
         RnUMLC94g9QVoTF/aBzGP0JHT1ChieyL7Bo4SNQWkglnfKtVBR8jFST/rUNowA9Y3PLW
         /a7w==
X-Forwarded-Encrypted: i=1; AFNElJ+cLsL3OCIzBp3muhBgCU+nRuIRAARKu90+eR3ezZzmMf3nfH5Cosnd0WVKNk5MqtDzWN9la4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrvJJ5ZzH0iYszAnPUnYImkJKadb2z7UQTolPaZpcmV7QyJUke
	3WogYi6YOyB7PRya9rbR1dlz5xXpngbvJ1+U/B6Mnx13iLBGocLp5iOasY0FhaWsw/MoVXfyZ99
	9bnDUFfBBvGaK1jQijmh8LyEAR81nOP7GhCiaY9/HhsBEFaIWjoBzKiin7g==
X-Gm-Gg: AeBDievPdJlyGLQE7cVuQZuRJ3CDPpIp+iCfPiTvCDvjX44+1HTsjc57GfswKD4Hfuj
	kVaCgxmY9PkvI/++h7uaFco6RivrNByhIFbYkbJI2a8svVGk78m5OKavkqnWRxXqn90iLjFd6xQ
	pam7u6HdNUvQ1Es88cQhjvomcfIUSH9o99+Z17NjHafKFLH8PDg36CHsAuUssYBwZmB9A0xfuP7
	vaakvcfjdyvwzpyvxKvyBSJE9nb+CRPzTC04pDUNrq7f8ewS2p40QEqD3BB9Xdfp0XElD9YsKHL
	S4Q431BrDoR5/Irz3f6ht/wpcqTrT1yMWC/3vgc7BhxBojp+u1dPPaG509pPZn5/ip/9T5OvgXO
	WOlCaehAux0vfjcq5DIqK6JWAKZ8UMnUBbcg3vaplWhZFFWeVvvKbu3dy/JdQTjAP6yeCjU4n2B
	uDOdyvCmu7HYJQAjDuvMpGg8sjRHgdhg/s4Zs=
X-Received: by 2002:a05:600c:468f:b0:48a:9540:1a3a with SMTP id 5b1f17b1804b1-48a98635f9emr114898895e9.8.1777839031574;
        Sun, 03 May 2026 13:10:31 -0700 (PDT)
X-Received: by 2002:a05:600c:468f:b0:48a:9540:1a3a with SMTP id 5b1f17b1804b1-48a98635f9emr114898535e9.8.1777839031135;
        Sun, 03 May 2026 13:10:31 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a820c8556sm271007775e9.4.2026.05.03.13.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 13:10:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	stable@vger.kernel.org
Subject: [PATCH] KVM: x86: Fix shadow paging use-after-free due to unexpected GFN
Date: Sun,  3 May 2026 22:10:29 +0200
Message-ID: <20260503201029.106481-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 440C04B73B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242819-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amazon.co.uk:email]

From: Sean Christopherson <seanjc@google.com>

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
  by step 3 then walks a stale rmap and dereferences a freed kvm_mmu_age.
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
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 24fbc9ea502a..892246204435 100644
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


