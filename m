Return-Path: <stable+bounces-243989-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dBJvMdWU+Wkh+AIAu9opvQ
	(envelope-from <stable+bounces-243989-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 08:57:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C194C75FB
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 08:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5471301C3F3
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 06:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567673CF02B;
	Tue,  5 May 2026 06:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y2fFKEOS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bc6geNmL"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9473257824
	for <stable@vger.kernel.org>; Tue,  5 May 2026 06:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777964243; cv=none; b=rQKGXbg7PPuExbL0ZeYaX2IfquFiLfeTXQA5PmhCHA7vk/HpPQB7QZI0iLZ9G3a2MNkgNstbI8xXFD4r6weE4GByWajPX/jcpV3my5W68u4iLztGW2Rs210F28WOECLwpcisICXAYDl7P5Wo4TCwQ7WXmnQxhq8B83dRrlQUlao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777964243; c=relaxed/simple;
	bh=PjL095tSFIg8q7WA/4EM2scDZC3+SKVeiuJZVPPDZiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nCcI6TW5n8PjkorXfUkqxQjYzOF0rljVW7k4PBenE5j1KfZV0Fifh+PjQCFUyjgmU9QbvGMpBP1YqOCwFa8KTj/0p1IrWZHIS/J/whBXGApmzZ7nr4SGUpnk5vz6nq0pXBBdKkS6QDjBDvwvUgdIfIn2T7S+d1CIejHxkvU/LAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y2fFKEOS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bc6geNmL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777964240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OkvB2g9TIRVT/EYnBf5Sqf4mqtiJXj4gtABaXOHNaLI=;
	b=Y2fFKEOSlUh5h/alvPvR2qF6EEojr7fqqOyzhd8fp8xq1RCKf8cnRnM0lOVyHAjNRYk6T/
	7f7Ir2CKTjymYN+g/fQX2xoB7N2Sd+oawDwiA5Nt7JocInqM/QaHCFhu5ePX5mZcv3Ia3Y
	icLOnLN5F3jskN510bmomkDAGR+O43I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-ebZpv2IuOLykj36XTrPxiQ-1; Tue, 05 May 2026 02:57:19 -0400
X-MC-Unique: ebZpv2IuOLykj36XTrPxiQ-1
X-Mimecast-MFC-AGG-ID: ebZpv2IuOLykj36XTrPxiQ_1777964238
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43d7730e9e3so3014972f8f.2
        for <stable@vger.kernel.org>; Mon, 04 May 2026 23:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777964238; x=1778569038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OkvB2g9TIRVT/EYnBf5Sqf4mqtiJXj4gtABaXOHNaLI=;
        b=bc6geNmLwjV9s5ZP9lribt3sbcPwQ0yp39XfqO7yZSe0Iv0LFG3AQmhtW60DD2fQQs
         bHzFrfnRWasf8ka3DoEgM3fI1ODwybDPHq9XKhseN40k8cKh+cywn7XjofqqVu+8vJWl
         BKRc4qcttBAnSg0vZf0NzMgGBn2rHBQLRlJCDUw7EhHHYAIjx2MJyxndzaZ/LY6Jc6rv
         gtHMFpWTcX2GA5hUdJjhg5WBXJXZ+fSJpKSAUVs++e+aqH46yx2mqNQiFGZsrxwWNFQe
         1W3zWr09MSjkJrL1Ah/iycViEbefaXhyNUmy8B9UTKBwOhxWNsRsq0DW+zSpvmYk+kUE
         Q+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777964238; x=1778569038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkvB2g9TIRVT/EYnBf5Sqf4mqtiJXj4gtABaXOHNaLI=;
        b=SQH46kOkjNZPWy64Jx9Dof5r+IAbXV255oqMo2Fe22RRnzmMpTyQ4o0qOX9JmD+O9I
         V9Ie4CFdKmKcn99Zi8nTlVtqb1wMJ+WldcY1IjIw5heyD2jj0UqQXYw0zdv7GD+KyLqa
         To/OQ20XvwSuBkcTdLbVL4djipDDU8b8GIhZLQDedakjH8MlXWUabrPfoN/4PxCSbkmw
         WUfLAOyXgs7FwuDhU0Zkmn7Db17mtQPRD1LDJiWdUDpiQZI/nwEQhyovDRNVwGnRsQ5s
         yFJVpTEkoHxOJ3epcheWLlIkO7ejiU5ydwGlJ5jWsprqM30fTVX5JIJwjfMb0xMrKqfT
         lJyw==
X-Forwarded-Encrypted: i=1; AFNElJ836pWiIuc6uBR9uCLM5WME1sLrANcDIqCswTvELfJVjhWVXiU6LNWO6V2nva1yS+f+qt3vTUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YykwPciGQ+eIimB/LMtV/I5aR/AfJi3xP0Y06TbzdOe5+yy+sYb
	e+wwV1wYw6HbV0ESzzHRgn5TeVDeTyOJ2wImXSXKnksrTIh5TIixCWeAH3JZCLF9L5nAdULZuid
	+FImRUno3TPzda699cyeVrjZUCvlvnSONcRkJlmlpVwuPWo0iQZB8vzGCxg==
X-Gm-Gg: AeBDietnU7B6wMaHzmwobk3ceUH7kxDOxpj7dsdQqB1GN8z3en7P7dGlFA51+/G++h9
	HCo+vvlOOxPyaSL5IH+y/RcNYDprhGN0gy8Ylm+86vILe3XtkU55AlCT5HZkXCMj6TA22O+IWqT
	7XFxS8f2478y7HWhdG1KyuJmjhxQzqeFicMy1il/gf2ONFtvSdmz90lEpnWRpVX9nYtyvTgGqHM
	ooeA3LKMqON3ULMHP0RLt2rgRwjtgzo9RhpR/SKniIIV6UsTPdi6myxRddLwr3Gfqr2M0vJLBxd
	x8pEevRznej1nQeRkR8M8SqJROHXrSwfKX8BEDhTJHu2oFjLrNSM6QzSmQ2E/NnQ7ackMrjt/Jh
	gq5YmGGqmg/Y+0ZaO/Hn69o2X3nOpr/Yt+CKV42r5eFy9BnLHahAPssK47bYcRv0xXEbQnFHRhy
	CJt3VuJ34eJYToMIBOG5B5MDr2siKv2giRYNL+J/Y=
X-Received: by 2002:a05:6000:3110:b0:44d:4898:7ed9 with SMTP id ffacd0b85a97d-45005c805fbmr3177320f8f.23.1777964238173;
        Mon, 04 May 2026 23:57:18 -0700 (PDT)
X-Received: by 2002:a05:6000:3110:b0:44d:4898:7ed9 with SMTP id ffacd0b85a97d-45005c805fbmr3177268f8f.23.1777964237757;
        Mon, 04 May 2026 23:57:17 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45054b03e04sm2375596f8f.21.2026.05.04.23.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 23:57:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	stable@vger.kernel.org
Subject: [PATCH 7.0.y] KVM: x86: Fix shadow paging use-after-free due to unexpected GFN
Date: Tue,  5 May 2026 08:57:15 +0200
Message-ID: <20260505065715.186759-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 17C194C75FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243989-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
 arch/x86/kvm/mmu/mmu.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index dd06453d5b72..729240bc00a2 100644
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


