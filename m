Return-Path: <stable+bounces-194539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DCBC4FE60
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 22:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 945013B6762
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 21:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE7A15E8B;
	Tue, 11 Nov 2025 21:42:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1829E33D6C8
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 21:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762897370; cv=none; b=tZx5E5X2IuKvl3eaQ/t4PjCi1k5iQFLPwYpiCv2ltJQRteFmsWY4wUutQpRPpQY/4H1YxMDjVVRZG6JeJEonGUYWvrOFPCAtRX9qhoNtS1CXUkb/IWeTwMbvuXXOeoEbpRzusEHWR2Jn5SqN8glAcYg3QvTqnBNsYWWCTy/0LAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762897370; c=relaxed/simple;
	bh=Zit10IcjEQgZrlYn+H0pI2muI6sNj2U/B2zs6yrH+H8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Udz4u+raHdOedUBgkC1HGSKr+vbLnNYcA0iVfVxQF/2kXzTf7YX3kSbPlJcFdPj5fLf/DxVuA0PQxtWlpz15Efl8Ehpb+RNYsjzaBOpR3Cx55jAinM/lIui4lVplG152xGyUTjy3i5/5U0Eo6B6AmCw2ko1ZmqcOHBUAAEtWNOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vasilevsky.ca; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vasilevsky.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8a3eac7ca30so13527985a.2
        for <stable@vger.kernel.org>; Tue, 11 Nov 2025 13:42:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762897366; x=1763502166;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37+7hBkhzuE7kcjBfybqxVC8HAYgIXzyLEuWgJ3dqEM=;
        b=VwJ81oVH1oAcSceyacMGXsk6oJuJrAqMwBOBFPME6jxxZy5lxLdBpaV3vzuineIkUz
         6bhAyeauwHRQk7awr8e0vE+ZXFy80FytqenlZ9bULA5EFhYrToofQhDJlfduxhAn9R21
         XZJLttI80dEx5rfMq5qym5TpFFbpT3ZM2Nwa3CvNWFeqCkZ/ae/ofRh/7z9Q0d09NQ1t
         wuPgMDz3n8aBikeB8cf6755LWRnpYbDfA7rTd/VpjBPXkOJlINMHcJ6+ufTnDEKCrFw3
         h3bqKSLIQM1aNnK3/O/TxLy2Qk54fNC2qZfx6p7aULnEi9UN37GrWUv+1gf9JKiQGb1K
         LNaA==
X-Forwarded-Encrypted: i=1; AJvYcCXqaHINN0VEqGIUeUO7YRuGI/qneeIBFo+r7QXL8uHecMfpX69V3x3VEa9N3QOlMyQvu5AtfoA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3rYRgX7PXClP8IlH8EjaQ3OVQlWUKa2wAPUMxfZ4WXv9oWdvV
	5UXsm0knZyQvlUrc99SnrKX4KmlRav4Qe376AA8a8toAEalUIxzEO3ae
X-Gm-Gg: ASbGnctGY9Edz2jS1bIj3ScDmGICRBzQRKJ34F96xLHbR2f4WBlffxdZmt7pXr7w3JO
	KcIKj87vQWiAaOL6dwDFTLpHzQzvgKtER2xiaJ428O06HNXtDn7h4ITTNbXHmATna9Gj6Q4cR8h
	I+qWQ96FBjByZC9BTps/MJ/6w7nad0HuNxUW67kiCWNRhwxt3/zEu0roHOyPhkxAaHi2t+D8kkB
	AIsuWQYqz4NYWDE3sYhwxNBkZnSXKJ+GHe/auS6aBmNBMu0Szlo3VHvTwv/ABZSflN90OYYZvlP
	tNT45lIULDzcdWwst/iFFH1Nf7+KQiOt1N3osSNwqTGSoOGILaPLRBrvHZcP7eoTRRh9b4rNinE
	+PM2tgqxsYzlCMfoFsKR8vYRPWAItqXP5g5lsyhSfsnrK8tVw/jKv/F6lNlgXtu7lszbqHb2+u7
	YElGmv+2YFp+eGTxFciMV5ZHyWgN5N1Buf5ghNy/vNk0jRLW2z1puE20Fm6Tkkulc=
X-Google-Smtp-Source: AGHT+IG3pd8H8cinV9KY2sxGF9Lqdw5K5u9F1WzBYcrYijYiG5sk7Zas84UeYzEmg+TDrSyPXJndow==
X-Received: by 2002:a05:620a:40c1:b0:8b1:ac18:acc9 with SMTP id af79cd13be357-8b29b77ad4bmr110215985a.32.1762897366312;
        Tue, 11 Nov 2025 13:42:46 -0800 (PST)
Received: from [192.168.2.45] (bras-base-mtrlpq3141w-grc-10-65-95-13-196.dsl.bell.ca. [65.95.13.196])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29a9e6e6asm59918585a.35.2025.11.11.13.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 13:42:45 -0800 (PST)
From: Dave Vasilevsky <dave@vasilevsky.ca>
Date: Tue, 11 Nov 2025 16:42:41 -0500
Subject: [PATCH v2] powerpc, mm: Fix mprotect on book3s 32-bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-vasi-mprotect-g3-v2-1-881c94afbc42@vasilevsky.ca>
X-B4-Tracking: v=1; b=H4sIANCtE2kC/32NQQ6DIBBFr2Jm3WkAJdKueo/GBcFBJ23VACE1x
 rsXPUCX7+f/9zeIFJgi3KsNAmWOPE8F1KUCN9ppIOS+MCihtBSqxWwj42cJcyKXcKjRG69Va/p
 GNgLKbAnk+Xsqn13hkWOaw3o+ZHmkf2RZosTaaWlaYbS/2cdReVOOr/XqLHT7vv8A7zcQxrQAA
 AA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762897365; l=3254;
 i=dave@vasilevsky.ca; s=20251027; h=from:subject:message-id;
 bh=Zit10IcjEQgZrlYn+H0pI2muI6sNj2U/B2zs6yrH+H8=;
 b=dn4omO7A8DZD+V7wNR4W4X80lGIpHjLAHsjIoZ421FOXmVeJST9kiGMlzTgaFTHCkeKQGUtcc
 o99hIiot/c+D1dhxLbSDf+lTXlQ2Eq/JmuM7PJ3WbD/2uIodH6yvTEe
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
Signed-off-by: Dave Vasilevsky <dave@vasilevsky.ca>
Cc: stable@vger.kernel.org
---
Changes in v2:
- Flush entire TLB if full mm is requested.
- Link to v1: https://lore.kernel.org/r/20251027-vasi-mprotect-g3-v1-1-3c5187085f9a@vasilevsky.ca
---
 arch/powerpc/include/asm/book3s/32/tlbflush.h | 8 ++++++--
 arch/powerpc/mm/book3s32/tlb.c                | 9 +++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/tlbflush.h b/arch/powerpc/include/asm/book3s/32/tlbflush.h
index e43534da5207aa3b0cb3c07b78e29b833c141f3f..b8c587ad2ea954f179246a57d6e86e45e91dcfdc 100644
--- a/arch/powerpc/include/asm/book3s/32/tlbflush.h
+++ b/arch/powerpc/include/asm/book3s/32/tlbflush.h
@@ -11,6 +11,7 @@
 void hash__flush_tlb_mm(struct mm_struct *mm);
 void hash__flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
 void hash__flush_range(struct mm_struct *mm, unsigned long start, unsigned long end);
+void hash__flush_gather(struct mmu_gather *tlb);
 
 #ifdef CONFIG_SMP
 void _tlbie(unsigned long address);
@@ -28,9 +29,12 @@ void _tlbia(void);
  */
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
-	/* 603 needs to flush the whole TLB here since it doesn't use a hash table. */
-	if (!mmu_has_feature(MMU_FTR_HPTE_TABLE))
+	if (mmu_has_feature(MMU_FTR_HPTE_TABLE)) {
+		hash__flush_gather(tlb);
+	} else {
+		/* 603 needs to flush the whole TLB here since it doesn't use a hash table. */
 		_tlbia();
+	}
 }
 
 static inline void flush_range(struct mm_struct *mm, unsigned long start, unsigned long end)
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


