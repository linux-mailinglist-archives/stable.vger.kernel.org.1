Return-Path: <stable+bounces-177834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14173B45C80
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 17:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0943516D066
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 15:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3082F7ADB;
	Fri,  5 Sep 2025 15:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="r3gubX1N"
X-Original-To: stable@vger.kernel.org
Received: from mxout5.mail.janestreet.com (mxout5.mail.janestreet.com [64.215.233.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7FD221F32
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 15:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.215.233.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757085822; cv=none; b=o1EPXzxE2+dsxlTl082stig5k2dwaqO2qWzBD3EndNKmRAiw0F+eCK15c7pUFpr84FjZW8xNHE+xrXL4B1qAXy8kR1JFzGcqyB6cqhQosjhmygOsU0OT2fgfuBGv51e/OD1kVsLJu3H2RxaYyzp4Qc3JQuLdNTqw6PqqyBO12gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757085822; c=relaxed/simple;
	bh=S/ML7WZ1uTpSMmbmHDUhBmDT8Vs7Wg0IF2zur/NJRnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aJQ9PBn1I1eF0y7BTHFB5mb+Jk8yME/M1kJdPkIpuPEQ2ggR33yITwCPwgogosHJJzoIm2z05OT3b16t44Z3EYXJaR+fHnWxoAt6WWqpVrtY0U340UAN+pvbgU/KVon6298YPFVntCoYK9THGcgd2dtSY9taqoXdU4USzZTtDGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com; spf=pass smtp.mailfrom=janestreet.com; dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=r3gubX1N; arc=none smtp.client-ip=64.215.233.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=janestreet.com
From: Eric Hagberg <ehagberg@janestreet.com>
To: linux-kernel@vger.kernel.org
Cc: Eric Hagberg <ehagberg@janestreet.com>,
 	stable@vger.kernel.org
Subject: [PATCH] x86/boot/compressed/64: clear high flags from pgd entry in configure_5level_paging
Date: Fri,  5 Sep 2025 11:14:31 -0400
Message-ID: <20250905151431.2825114-1-ehagberg@janestreet.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janestreet.com;
  s=waixah; t=1757085454;
  bh=sQWCESy/4YoQ7ON6d1VtuvMNA3SUhWe2COWsmV3LXhc=;
  h=From:To:Cc:Subject:Date;
  b=r3gubX1NVHSXJIAd4gu88nrKdKp+J15IjXbBY4/Vyw+438ZgKItMXIHfa3h6In8kf
  4w6gVWk0nIpRZz9xqCj9VysQbWfqY9USV/VoGwlr6QicuqMfJro6Bqc35LfVxRaC0D
  WCIGFexF0IIaz5ZzV/PXNN8FoNic5061ea8bFosBWHwtE771GzC8lZeu5IZb9o0pY6
  5wEuRoURRc8YOGpfp+QHhjBmNe4MaARt1ZcBMpsMCHZ9zjwnzQh55I6UoEp8mrezYu
  K7M7Kq/1bkIDjyKr+nhjVwwhnZHrGGHWOwDRMTW4kAbFFPPc1CSH7wiVf6rZMJVgmF
  963nQ3nbSHA7Q==

In commit d0ceea662d45 ("x86/mm: Add _PAGE_NOPTISHADOW bit to avoid
updating userspace page tables") we started setting _PAGE_NOPTISHADOW (bit
58) in identity map PTEs created by kernel_ident_mapping_init. In
configure_5level_paging when transiting from 5-level paging to 4-level
paging we copy the first p4d to become our new (4-level) pgd by
dereferencing the first entry in the current pgd, but we only mask off the
low 12 bits in the pgd entry.

When kexecing, the previous kernel sets up an identity map using
kernel_ident_mapping_init before transiting to the new kernel, which means
the new kernel gets a pgd with entries with bit 58 set. Then we mask off
only the low 12 bits, resulting in a non-canonical address, and try to
copy from it, and fault.

Fixes: d0ceea662d45 ("x86/mm: Add _PAGE_NOPTISHADOW bit to avoid updating userspace page tables")
Signed-off-by: Eric Hagberg <ehagberg@janestreet.com>
Cc: stable@vger.kernel.org
---
 arch/x86/boot/compressed/pgtable_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index bdd26050dff7..c785c5d54a11 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -180,7 +180,7 @@ asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
 		 * We cannot just point to the page table from trampoline as it
 		 * may be above 4G.
 		 */
-		src = *(unsigned long *)__native_read_cr3() & PAGE_MASK;
+		src = *(unsigned long *)__native_read_cr3() & PTE_PFN_MASK;
 		memcpy(trampoline_32bit, (void *)src, PAGE_SIZE);
 	}
 
-- 
2.43.7


