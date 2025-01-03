Return-Path: <stable+bounces-106732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EB0A00DB1
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 19:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C8C81884AF7
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 18:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFF61FBEA6;
	Fri,  3 Jan 2025 18:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QiAEGKNS"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8441FA14B
	for <stable@vger.kernel.org>; Fri,  3 Jan 2025 18:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735929598; cv=none; b=Nm9AHiRo9NehQJ3nUqB5bcxUhhVnraMFxTF9mQOWeM/AYiXtxOgzv3RnooGaIwB/ZoDepOXploViV2eVJPuq/jvE/4ZDeMf8WbkZ2C+O36OIPYWrbLvmICt0Fe5KTWLehLhv+iojqMIqFkvP5SAYazos7hVIOheIT6zO26Avpf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735929598; c=relaxed/simple;
	bh=97CIyszQag73oA70YGJTbMbEDm/CPO+p2kR3J9o83lo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sNhI+F5PdCZLQL/16r2S1DBUZKhGkntwvSV2bMqUrjxPliAedvF113Bx+V8jMvztKbKF6PhhrbL294N3ktpx1D6rrVeqI6snDfv9hHmzltAVs8Sf6g1X9MfreZS4WtR8Y+LIdUZI70NA4eeZ6HOPiZjlXXXEGVifF++dhxIIzzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QiAEGKNS; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4361d5730caso1075e9.1
        for <stable@vger.kernel.org>; Fri, 03 Jan 2025 10:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735929595; x=1736534395; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTB+rEpkKE5yruA5DUop/88GQtExvYxyFAxV7mbTMv4=;
        b=QiAEGKNSk3gVzEmXGqPeR57LAl7X36kQ8TegbpWkBQfk9RCKr7i3dxOO7Oegwg+i5K
         aVzXP4H24yoeUaDRehmLdRwRkUM/7LCsWOonOj7axljlnXr4lJPbYGSBKwnCPQLqYEDL
         9E75SkZrC/PnO06u+JjMmIInhs3jda+YA8UCqya8BENYeOrbvvDZSNQMRSTvS0DhL7aQ
         mMmLS13nbjBZzv8AoK6q4rhNRRf3d8+dWuNI1JSChemq/zm7SiMPkv6MXae1aPbihg8r
         TlTSOGvoIsR+/ogoABzM809MQojDBR8SVny3bHAahhdiE0by50kX1+SdPRLJv3bbvVf4
         KfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735929595; x=1736534395;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZTB+rEpkKE5yruA5DUop/88GQtExvYxyFAxV7mbTMv4=;
        b=HdUrn76Ynmld77joWQaH/NP0xuonKynV1IgGmXRFckGthAhgoVJ80jbx5BHySv/lph
         gjL4CZsWwcjdI6Zjzmf6XLCp+tO1Sr/HHyL+ezqS6cw7wjvX0su9jVcG7f9iH+G2AUpo
         XmftHL4NSrfqw40+YiGUfsWH2QSkztUqWfbG0KsPCKGZBtfYjmR0KNx0sjVqXv2KYwJL
         KwZ4Tyb38Ho4dit9clXcGbUy3EoVWRqBC6VpWBqSrw7CPVp4jknb1hCjFjtkQ2pOxwYs
         /HU/xBvDjkkCI2LDEMtJa+ss1+0Cr0QEPHg//FEaTcFeE0BhYfR+MuL68dIT3pi7MMrO
         KvAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbC9JjfP5T+SvkDDPaltyCc9DB4TVII8XzbQgUvppwoZD0X/a2PWdZLVCtYJHG+R1YUFARs90=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJfTl9Ei3ZcJnbmcfuRJWIzJY37Cbrsvcer7zNGk9KzGCN61mw
	k1V8kJAxFF0+ZNplxH0wRN8Ad+ZXnIZMfzah2zY6G2ZjJj1BEE/uuz1I7HvfYg==
X-Gm-Gg: ASbGncumUpCT/7IfLPXvsTpv7n9jCuONxyNgkTjOwhH/oVs57C4UlEkVMoy/dGk88pr
	9foRkxTmA0YFk40auWxA0wqyDvxu4bDnR+qd4q53Pvesh6LZEu5W9+2WBrbp+6LEA/NG54WdpfD
	+DTMcwMv5kFfLm8EC4gXUQoN6OwwLzF/392FZ1UIOGx20tJkblPiMoRiPvyMnl4Dm5NVmrZuKtX
	PefpOxheiktE8gXEHAhMQrJEvorJZsrxdkgQkoUV3Ygbg==
X-Google-Smtp-Source: AGHT+IFD+qdlBvT4m+bB+dQfGAXCL9/oC0y2KEyf0p0e6iw0viHGlpNCT35HEwo5ybEDchapT4NykQ==
X-Received: by 2002:a05:600c:2e51:b0:435:921b:3535 with SMTP id 5b1f17b1804b1-436ccb38391mr1048875e9.3.1735929594584;
        Fri, 03 Jan 2025 10:39:54 -0800 (PST)
Received: from localhost ([2a00:79e0:9d:4:7c21:a713:369e:c925])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b3b207sm522376935e9.32.2025.01.03.10.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 10:39:53 -0800 (PST)
From: Jann Horn <jannh@google.com>
Date: Fri, 03 Jan 2025 19:39:38 +0100
Subject: [PATCH] x86/mm: Fix flush_tlb_range() when used for zapping normal
 PMDs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-x86-collapse-flush-fix-v1-1-3c521856cfa6@google.com>
X-B4-Tracking: v=1; b=H4sIAOoueGcC/x2MQQqAIBAAvxJ7bsFKS/pKdBBba0EqXAoh+nvSc
 QZmHhBKTAJj9UCim4WPvUBTV+A3t6+EvBSGVrVGNarDbHv0R4zuFMIQL9kwcMbg7OC8XoztNJT
 4TFT0P57m9/0AWvZML2gAAAA=
X-Change-ID: 20250103-x86-collapse-flush-fix-fa87ac4d5834
To: Dave Hansen <dave.hansen@linux.intel.com>, 
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735929590; l=2120;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=97CIyszQag73oA70YGJTbMbEDm/CPO+p2kR3J9o83lo=;
 b=AsMblhvWSFbPVWf7u4wvkWWLNo3Z1+4wo6Te885+A1ZZOVCluzXDn+PfRA4rPi6jxVEh+Fq2e
 s2Odi8xML5OA20hDEPetOXyvHVa06FGQAwufMnDaBdAiwWDOUsSlXPB
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

On the following path, flush_tlb_range() can be used for zapping normal
PMD entries (PMD entries that point to page tables) together with the PTE
entries in the pointed-to page table:

    collapse_pte_mapped_thp
      pmdp_collapse_flush
        flush_tlb_range

The arm64 version of flush_tlb_range() has a comment describing that it can
be used for page table removal, and does not use any last-level
invalidation optimizations. Fix the X86 version by making it behave the
same way.

Currently, X86 only uses this information for the following two purposes,
which I think means the issue doesn't have much impact:

 - In native_flush_tlb_multi() for checking if lazy TLB CPUs need to be
   IPI'd to avoid issues with speculative page table walks.
 - In Hyper-V TLB paravirtualization, again for lazy TLB stuff.

The patch "x86/mm: only invalidate final translations with INVLPGB" which
is currently under review (see
<https://lore.kernel.org/all/20241230175550.4046587-13-riel@surriel.com/>)
would probably be making the impact of this a lot worse.

Cc: stable@vger.kernel.org
Fixes: 016c4d92cd16 ("x86/mm/tlb: Add freed_tables argument to flush_tlb_mm_range")
Signed-off-by: Jann Horn <jannh@google.com>
---
 arch/x86/include/asm/tlbflush.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 02fc2aa06e9e0ecdba3fe948cafe5892b72e86c0..3da645139748538daac70166618d8ad95116eb74 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -242,7 +242,7 @@ void flush_tlb_multi(const struct cpumask *cpumask,
 	flush_tlb_mm_range((vma)->vm_mm, start, end,			\
 			   ((vma)->vm_flags & VM_HUGETLB)		\
 				? huge_page_shift(hstate_vma(vma))	\
-				: PAGE_SHIFT, false)
+				: PAGE_SHIFT, true)
 
 extern void flush_tlb_all(void);
 extern void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,

---
base-commit: aa135d1d0902c49ed45bec98c61c1b4022652b7e
change-id: 20250103-x86-collapse-flush-fix-fa87ac4d5834

-- 
Jann Horn <jannh@google.com>


