Return-Path: <stable+bounces-194859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B34C610E6
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 07:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 275182908A
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 06:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2ADA26159E;
	Sun, 16 Nov 2025 06:40:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABC17083C
	for <stable@vger.kernel.org>; Sun, 16 Nov 2025 06:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763275254; cv=none; b=GLyCjystMgMDs3qg95Juv6xgf/tGsnbTXp9jFAgCNLv3yJRQxfmtHlxRNAOyT4/kjxQ5OA/fDqcTf3OvXLQrsy4PlJsHCU/rBZ7TNO9qIWciN1ZH+RNJchuSbCRL3NdGMCXG7P9XIFqGOvW+Gj3qDEF5Z4PFVEq9CaAZEXdlYDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763275254; c=relaxed/simple;
	bh=muIWQccO36YRMVeS5U/f/4/TLToyy8blzhH60i2svbE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rLFa/AvM7MUur9PtG39s03FWF1bm5I5S0qYUmXupVH8oKWReur8GavzU1vB7Jyx3C9wac9sG0JI6tNzVapICDT8tyDoE7wDCU9xzyaXRsxRtetO2zp+Vd0LCz8zj/MAYd6gDHbbl/dTtEp+Xoc/lalR16EIZQ9r/doH++vJ9/FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vasilevsky.ca; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vasilevsky.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4eddfb8c7f5so33575211cf.1
        for <stable@vger.kernel.org>; Sat, 15 Nov 2025 22:40:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763275251; x=1763880051;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/TBs7BuWibkRX4L1Mxki9I3H1/n/J1InK7hm63Zqwc=;
        b=Dwld1UQSwclZ6K/d1FUMl5q8r1aDLBnW9f3HFqwih6D4I1h5RhNr7KZDpKJSZWYErv
         lquwyZqek7VzAJfudPYVL5wdVB8Q0sahPF4EtNLpY0n+wuSJ0/zYHVl4Nl0nfLs2YUsX
         FBH0X2gabXqjGHxpS/F01sK6roM45mnyMFtixgz4QEGfzwqaVhU+w+n9oBYF5Y8TbBAM
         wyb1iRtqNJxgstxvPGEUkoz3u8xzm4OSq8hL/dC6N/pQt7x+lG7mVeEvLYb70AJBKssO
         ulVF1baHVBZQsFEXZclUHRqjeZQdCTKm3ZJxsc9Py92WsEbaNBoQaiHrRqtALTnhMcLj
         1vZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYxOulfiJeLdcIKmuu5edOj3RUUtuB0cFyi0/EeoWqKAHrYt7fQfePYZbJFPKKovfharnCmsk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw15KGkCWi9Wfi7gUHZ5vWhkE4XG5v0MTqD4TIHS/KT0KRe8CrR
	A9Tcn0k7CNh6OzPFnsejztZ5w5ufRK+boJxmMN1XwdM4t6AYri1cbTtt
X-Gm-Gg: ASbGncsxNZaSWyQ7X14R/upc5MC6DzTojyiJsV0z8dEBH2rrEd7aEYDj+GmiusTgY4d
	6LE8FW3D04jvbHK9h2lScqpK4SJjOMksEYj0mDUfDy5/1sRcvS1s30ZIJCF1MWXOd2U81OlBkFm
	OUZgFUf6ZwHPkz3T+X9mBVBFk2r/ss9e9ZzzxP55tmicGbJTLDsmlAd0gbMAYyS2pIa6wf+LF/n
	8CINcItCnHYp6hgkAyMtbqgPSoX62yB4NELlaNEiFL7SJltzTwc1kNPHkyqdwDagHBEZdrJCyl3
	pFtZ1KtMKf+0rMGMJEWeVpeCihNNOeTNfVrPgE7HHxeg3DS3D9vNP5g1rVf9Szu2XoI2pRy0OJi
	x9UR1hp8PX5us1cdH8Wi7BjDteQN5VgakORhKtf43BbU4DtxP7hKoYgva3cZeaAm2I14ghfhhQ2
	RpxVV1dIjtyixFJ9sfk812XvmckLSBXcL6DfCOrgkWKMK+UfNtafGl6o8Pg9xsxtocuC2J9YVKC
	w==
X-Google-Smtp-Source: AGHT+IG+qzsrR+dRWKF4NmoVX7b6CUaR8vMmbs3TLbWswTg9TED3bCbWhUIV58kjiV3MwgK5w6g1yA==
X-Received: by 2002:a05:622a:1107:b0:4ec:f7de:f5eb with SMTP id d75a77b69052e-4edf20a2ebbmr113268941cf.33.1763275250934;
        Sat, 15 Nov 2025 22:40:50 -0800 (PST)
Received: from [192.168.2.45] (bras-base-mtrlpq3141w-grc-10-65-95-13-196.dsl.bell.ca. [65.95.13.196])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ede87e6fecsm61188021cf.18.2025.11.15.22.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 22:40:50 -0800 (PST)
From: Dave Vasilevsky <dave@vasilevsky.ca>
Date: Sun, 16 Nov 2025 01:40:46 -0500
Subject: [PATCH v3] powerpc, mm: Fix mprotect on book3s 32-bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251116-vasi-mprotect-g3-v3-1-59a9bd33ba00@vasilevsky.ca>
X-B4-Tracking: v=1; b=H4sIAO1xGWkC/33NwQ6CMAwG4FchPTuzli0MT76H8TDHBosKZCOLh
 PDuDi4mxtjb3/z9ukC0wdsIp2KBYJOPfuhzKA8FmE73rWW+yRmIk0ROFUs6evYcwzBZM7G2ZE4
 5SZVqBAoO+WwM1vnXTl6uOXc+TkOY9w8Jt+0fLCFDVhqJquJKulqft8rDpnifj0bDBib6IHl+I
 JQRpdDUQrubEfSNrOv6BpGaqhz5AAAA
X-Change-ID: 20251027-vasi-mprotect-g3-f8f5278d4140
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Nadav Amit <nadav.amit@gmail.com>, 
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Ritesh Harjani <ritesh.list@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, linux-mm@kvack.org, 
 Dave Vasilevsky <dave@vasilevsky.ca>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763275249; l=3309;
 i=dave@vasilevsky.ca; s=20251027; h=from:subject:message-id;
 bh=muIWQccO36YRMVeS5U/f/4/TLToyy8blzhH60i2svbE=;
 b=BqibHhRBraGtc5DC4MXisv7cfh+xdLpFWAQQaxC9fzFoJvdvVanpK8QruKXcOddOsTtRvfNgH
 YlQotamK+KoD0aCejzMYbW1umsa7tkoXkMduqh2O3DDT0rZZS39zLZd
X-Developer-Key: i=dave@vasilevsky.ca; a=ed25519;
 pk=Jsd1btZeqqg6x6y73Dx0YrleQb3A3pCBnUeE0qmoKq4=

On 32-bit book3s with hash-MMUs, tlb_flush() was a no-op. This was
unnoticed because all uses until recently were for unmaps, and thus
handled by __tlb_remove_tlb_entry().

After commit 4a18419f71cd ("mm/mprotect: use mmu_gather") in kernel 5.19,
tlb_gather_mmu() started being used for mprotect as well. This caused
mprotect to simply not work on these machines:

  int *ptr = mmap(NULL, 4096, PROT_READ|PROT_WRITE,
                  MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
  *ptr = 1; // force HPTE to be created
  mprotect(ptr, 4096, PROT_READ);
  *ptr = 2; // should segfault, but succeeds

Fixed by making tlb_flush() actually flush TLB pages. This finally
agrees with the behaviour of boot3s64's tlb_flush().

Fixes: 4a18419f71cd ("mm/mprotect: use mmu_gather")
Cc: stable@vger.kernel.org
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Dave Vasilevsky <dave@vasilevsky.ca>
---
Changes in v3:
- Fix formatting
- Link to v2: https://lore.kernel.org/r/20251111-vasi-mprotect-g3-v2-1-881c94afbc42@vasilevsky.ca

Changes in v2:
- Flush entire TLB if full mm is requested.
- Link to v1: https://lore.kernel.org/r/20251027-vasi-mprotect-g3-v1-1-3c5187085f9a@vasilevsky.ca
---
 arch/powerpc/include/asm/book3s/32/tlbflush.h | 5 ++++-
 arch/powerpc/mm/book3s32/tlb.c                | 9 +++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/32/tlbflush.h b/arch/powerpc/include/asm/book3s/32/tlbflush.h
index e43534da5207aa3b0cb3c07b78e29b833c141f3f..4be2200a3c7e1e8307f5ce1f1d5d28047429c106 100644
--- a/arch/powerpc/include/asm/book3s/32/tlbflush.h
+++ b/arch/powerpc/include/asm/book3s/32/tlbflush.h
@@ -11,6 +11,7 @@
 void hash__flush_tlb_mm(struct mm_struct *mm);
 void hash__flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
 void hash__flush_range(struct mm_struct *mm, unsigned long start, unsigned long end);
+void hash__flush_gather(struct mmu_gather *tlb);
 
 #ifdef CONFIG_SMP
 void _tlbie(unsigned long address);
@@ -29,7 +30,9 @@ void _tlbia(void);
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
 	/* 603 needs to flush the whole TLB here since it doesn't use a hash table. */
-	if (!mmu_has_feature(MMU_FTR_HPTE_TABLE))
+	if (mmu_has_feature(MMU_FTR_HPTE_TABLE))
+		hash__flush_gather(tlb);
+	else
 		_tlbia();
 }
 
diff --git a/arch/powerpc/mm/book3s32/tlb.c b/arch/powerpc/mm/book3s32/tlb.c
index 9ad6b56bfec96e989b96f027d075ad5812500854..e54a7b0112322e5818d80facd2e3c7722e6dd520 100644
--- a/arch/powerpc/mm/book3s32/tlb.c
+++ b/arch/powerpc/mm/book3s32/tlb.c
@@ -105,3 +105,12 @@ void hash__flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
 		flush_hash_pages(mm->context.id, vmaddr, pmd_val(*pmd), 1);
 }
 EXPORT_SYMBOL(hash__flush_tlb_page);
+
+void hash__flush_gather(struct mmu_gather *tlb)
+{
+	if (tlb->fullmm || tlb->need_flush_all)
+		hash__flush_tlb_mm(tlb->mm);
+	else
+		hash__flush_range(tlb->mm, tlb->start, tlb->end);
+}
+EXPORT_SYMBOL(hash__flush_gather);

---
base-commit: 24172e0d79900908cf5ebf366600616d29c9b417
change-id: 20251027-vasi-mprotect-g3-f8f5278d4140

Best regards,
-- 
Dave Vasilevsky <dave@vasilevsky.ca>


