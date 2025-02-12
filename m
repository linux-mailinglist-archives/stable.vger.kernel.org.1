Return-Path: <stable+bounces-115006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C3AA31F37
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 07:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1070D3A3C4C
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 06:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AB71FCF68;
	Wed, 12 Feb 2025 06:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OVOPgWnY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8668B1FC114
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 06:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739342517; cv=none; b=RfErD0wgrN2lKXVyQ31zxqw6tjE4mPDrfyBfPNa4Ij9dev69Ekrp0pSpH4F1gpF+WFatJmvy2/QQ3BDc158GmsyW8FFa4s1DpGK5RdLuuTOi40RzqL+6tNMFfHG1nZmhtdDW3cHRaUV5MEBIoQ0TgSJrnsGHlVvbFSJNaBTzUsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739342517; c=relaxed/simple;
	bh=DOAg170WN40PYi22pDX7qZrwRoVgHfM+yAgBXLiZgzo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TGEtdzTfrDqZQaNq3yEajnICh0ito8bZzwE+58QCHBk0aS2W7xn8pbmwVzJ/JjlYywVVg9FyVuDS3zfagz0DXMBuU9VWpqeimyuOn8yp9zEdeDj92ALJG3f7zRaZ4mRvCeNtUDAA3VL83xcrAbN3YuQteGSRwAXs2g8vj+KVroQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OVOPgWnY; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21f62cc4088so78102875ad.3
        for <stable@vger.kernel.org>; Tue, 11 Feb 2025 22:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1739342514; x=1739947314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wBYRdWhtA3egwicLkCU/PTXlbgsejMuWm2eNpqSb/0=;
        b=OVOPgWnY0xQavTPOUs7dQSM2vbu9gh60eCkZNw4eBlBdOrbp3n+AtFQtvOK26T8HFH
         hy1a2g1q9ICWnHLBtDPdcHnid4jT4W/1zk7WrsrbgHZaEqu0evdIqkVLfrE7dsRXd4dn
         xfvfD+b4/d7cBQhavBKSFXD0lBpkGQxpy2koTdCHbDHD3cu+kJw75BGCYgS5R0EM/w1I
         cIdFZGUMBGqL1RWDUgzSVO09vvpqVssLcG9GM4ElP9sghAyHuy9SieiCs4lhzhWGpHwh
         EL3bYh9CBJzBD0t1bOANqGHuh5csuKdTvX6+bCPaFA85czmyA/idYnWJE/gAQe2KgN9v
         Fk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739342514; x=1739947314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wBYRdWhtA3egwicLkCU/PTXlbgsejMuWm2eNpqSb/0=;
        b=XmyyuMYiX7DxQgMK1734/CcraPlDrIl1j6TQ+ORrMRxc+3qRSPgMJc++qv+zEcEjEh
         Jl1+ZbX8MmdjQYoGRaKBLEH1UfWcX7jIz72ByikQhi3axHw25jr+j2zXwP/d8HzZ6Wd9
         JEVJ14CYZHp7jgP+QbZTZxCmykYMuF2wSNXgXVX31h8hIs1M/uTw4wufIXwmzKWKxRRw
         3eg+hlT2+lJxmBux2K1f8QiYJK+WjPvC0at/6FWcel+KnuGuqF+F+NU1wEMD2zeQK3e4
         IAZNdUWFSKLyJDicQdN+HB4XktR7hRZI2GrLcE1EWdY5eVwZPaWzOmUJwdohPesSdxhz
         qMwA==
X-Forwarded-Encrypted: i=1; AJvYcCUy/N7El4w7flmlHt9DV3S12rfpF1a/KDc2j7lOBsaeXbbhKn9Qxh3AeCm9xYh63a2djDdKjlc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu9027yCnpB88ksKKq8hniK1j3lRF+kCphQlGQtjl9XMuDVsqS
	65mudqsCgGNG1hdOLFw7A300HWHsMlgwiu07K7Bx4tMqoAcJJJnUDjXoonbkygI=
X-Gm-Gg: ASbGncsrmZ7WU4hTdb86MZiDh60H0XVn0iudw77ORiy58qs84oS04bofvhsLYDk5s+O
	+CZYsjvPRCtu4V8zmNLnVKSuHUqG3u6fy079RByH7oxWCpZkGcjOpjxIQXw7UTd9cOKVK3GfO0k
	a4NA05exT+7sV9VgJdZGdg3y+7tavzdQr87wYXj8+39H+9ndiMwNsVxZM3SXlej85JpL5403U5p
	l5V7m7w8HV1Mkw3qlgSlYw7QIG+dqTG0CIXsFYJb11vLrmfc38GzzdwNcQRCEZcacVQY9wNzFUY
	3Se5DoO8Sjm8/d9JXDpnpPJf+CfEEngcrl9QVJQzRCq5H5GM1GGLcGE9
X-Google-Smtp-Source: AGHT+IH74x3a61arrF/gqeUXfZpntwfiArJQu0CFKJ9o5bTtZZmrBTsZbUPqFZNfhNpXHrSNNu3gxw==
X-Received: by 2002:a17:902:e811:b0:21f:45d:21fb with SMTP id d9443c01a7336-220bbac3250mr30288095ad.3.1739342513657;
        Tue, 11 Feb 2025 22:41:53 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.153])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf9ab0233sm683131a91.44.2025.02.11.22.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 22:41:53 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: linux@armlinux.org.uk,
	ezra@easyb.ch,
	david@redhat.com,
	hughd@google.com,
	ryan.roberts@arm.com,
	akpm@linux-foundation.org,
	muchun.song@linux.dev
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH] arm: pgtable: fix NULL pointer dereference issue
Date: Wed, 12 Feb 2025 14:40:02 +0800
Message-Id: <20250212064002.55598-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <be323425-2465-423a-a6f4-affbaa1efe09@bytedance.com>
References: <be323425-2465-423a-a6f4-affbaa1efe09@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When update_mmu_cache_range() is called by update_mmu_cache(), the vmf
parameter is NULL, which will cause a NULL pointer dereference issue in
adjust_pte():

Unable to handle kernel NULL pointer dereference at virtual address 00000030 when read
Hardware name: Atmel AT91SAM9
PC is at update_mmu_cache_range+0x1e0/0x278
LR is at pte_offset_map_rw_nolock+0x18/0x2c
Call trace:
 update_mmu_cache_range from remove_migration_pte+0x29c/0x2ec
 remove_migration_pte from rmap_walk_file+0xcc/0x130
 rmap_walk_file from remove_migration_ptes+0x90/0xa4
 remove_migration_ptes from migrate_pages_batch+0x6d4/0x858
 migrate_pages_batch from migrate_pages+0x188/0x488
 migrate_pages from compact_zone+0x56c/0x954
 compact_zone from compact_node+0x90/0xf0
 compact_node from kcompactd+0x1d4/0x204
 kcompactd from kthread+0x120/0x12c
 kthread from ret_from_fork+0x14/0x38
Exception stack(0xc0d8bfb0 to 0xc0d8bff8)

To fix it, do not rely on whether 'ptl' is equal to decide whether to hold
the pte lock, but decide it by whether CONFIG_SPLIT_PTE_PTLOCKS is
enabled. In addition, if two vmas map to the same PTE page, there is no
need to hold the pte lock again, otherwise a deadlock will occur. Just add
the need_lock parameter to let adjust_pte() know this information.

Reported-by: Ezra Buehler <ezra@easyb.ch>
Closes: https://lore.kernel.org/lkml/CAM1KZSmZ2T_riHvay+7cKEFxoPgeVpHkVFTzVVEQ1BO0cLkHEQ@mail.gmail.com/
Fixes: fc9c45b71f43 ("arm: adjust_pte() use pte_offset_map_rw_nolock()")
Cc: stable@vger.kernel.org
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 arch/arm/mm/fault-armv.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
index 2bec87c3327d2..3627bf0957c75 100644
--- a/arch/arm/mm/fault-armv.c
+++ b/arch/arm/mm/fault-armv.c
@@ -62,7 +62,7 @@ static int do_adjust_pte(struct vm_area_struct *vma, unsigned long address,
 }
 
 static int adjust_pte(struct vm_area_struct *vma, unsigned long address,
-		      unsigned long pfn, struct vm_fault *vmf)
+		      unsigned long pfn, bool need_lock)
 {
 	spinlock_t *ptl;
 	pgd_t *pgd;
@@ -99,12 +99,11 @@ static int adjust_pte(struct vm_area_struct *vma, unsigned long address,
 	if (!pte)
 		return 0;
 
-	/*
-	 * If we are using split PTE locks, then we need to take the page
-	 * lock here.  Otherwise we are using shared mm->page_table_lock
-	 * which is already locked, thus cannot take it.
-	 */
-	if (ptl != vmf->ptl) {
+	if (need_lock) {
+		/*
+		 * Use nested version here to indicate that we are already
+		 * holding one similar spinlock.
+		 */
 		spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
 		if (unlikely(!pmd_same(pmdval, pmdp_get_lockless(pmd)))) {
 			pte_unmap_unlock(pte, ptl);
@@ -114,7 +113,7 @@ static int adjust_pte(struct vm_area_struct *vma, unsigned long address,
 
 	ret = do_adjust_pte(vma, address, pfn, pte);
 
-	if (ptl != vmf->ptl)
+	if (need_lock)
 		spin_unlock(ptl);
 	pte_unmap(pte);
 
@@ -123,16 +122,17 @@ static int adjust_pte(struct vm_area_struct *vma, unsigned long address,
 
 static void
 make_coherent(struct address_space *mapping, struct vm_area_struct *vma,
-	      unsigned long addr, pte_t *ptep, unsigned long pfn,
-	      struct vm_fault *vmf)
+	      unsigned long addr, pte_t *ptep, unsigned long pfn)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	struct vm_area_struct *mpnt;
 	unsigned long offset;
+	unsigned long start;
 	pgoff_t pgoff;
 	int aliases = 0;
 
 	pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
+	start = ALIGN_DOWN(addr, PMD_SIZE);
 
 	/*
 	 * If we have any shared mappings that are in the same mm
@@ -141,6 +141,14 @@ make_coherent(struct address_space *mapping, struct vm_area_struct *vma,
 	 */
 	flush_dcache_mmap_lock(mapping);
 	vma_interval_tree_foreach(mpnt, &mapping->i_mmap, pgoff, pgoff) {
+		unsigned long mpnt_addr;
+		/*
+		 * If we are using split PTE locks, then we need to take the pte
+		 * lock. Otherwise we are using shared mm->page_table_lock which
+		 * is already locked, thus cannot take it.
+		 */
+		bool need_lock = IS_ENABLED(CONFIG_SPLIT_PTE_PTLOCKS);
+
 		/*
 		 * If this VMA is not in our MM, we can ignore it.
 		 * Note that we intentionally mask out the VMA
@@ -151,7 +159,15 @@ make_coherent(struct address_space *mapping, struct vm_area_struct *vma,
 		if (!(mpnt->vm_flags & VM_MAYSHARE))
 			continue;
 		offset = (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
-		aliases += adjust_pte(mpnt, mpnt->vm_start + offset, pfn, vmf);
+		mpnt_addr = mpnt->vm_start + offset;
+		/*
+		 * If mpnt_addr and addr are mapped to the same PTE page, there
+		 * is no need to hold the pte lock again, otherwise a deadlock
+		 * will occur.
+		 */
+		if (mpnt_addr >= start && mpnt_addr - start < PMD_SIZE)
+			need_lock = false;
+		aliases += adjust_pte(mpnt, mpnt_addr, pfn, need_lock);
 	}
 	flush_dcache_mmap_unlock(mapping);
 	if (aliases)
@@ -194,7 +210,7 @@ void update_mmu_cache_range(struct vm_fault *vmf, struct vm_area_struct *vma,
 		__flush_dcache_folio(mapping, folio);
 	if (mapping) {
 		if (cache_is_vivt())
-			make_coherent(mapping, vma, addr, ptep, pfn, vmf);
+			make_coherent(mapping, vma, addr, ptep, pfn);
 		else if (vma->vm_flags & VM_EXEC)
 			__flush_icache_all();
 	}
-- 
2.20.1


