Return-Path: <stable+bounces-1773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4DE7F814C
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DCF7B203AF
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B4A364A6;
	Fri, 24 Nov 2023 18:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rRovOfzj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7788D33CFD;
	Fri, 24 Nov 2023 18:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056B9C433C8;
	Fri, 24 Nov 2023 18:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852239;
	bh=vVQ/BZyWMULkaz4DE3Pkm6XNceiz3fzHKhzyd9Vemj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rRovOfzjIZ7egBT+gQmOsIXSvwkuqeFPk0zOE3QwZ3WKsk0e2ZUc1mAM5qjx0Rna2
	 yLmCwb6uUNM8kQJiR/wO0m3y7OsAAo1/zTAQU2EjOccIzSIWP7Ry2Nhz/0LPs+n4JC
	 Ea5SpHPGbGNJbpibRgKd4qCGp/J3p5i2a6pamfMk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 6.1 251/372] s390/cmma: fix initial kernel address space page table walk
Date: Fri, 24 Nov 2023 17:50:38 +0000
Message-ID: <20231124172018.892694412@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiko Carstens <hca@linux.ibm.com>

commit 16ba44826a04834d3eeeda4b731c2ea3481062b7 upstream.

If the cmma no-dat feature is available the kernel page tables are walked
to identify and mark all pages which are used for address translation (all
region, segment, and page tables). In a subsequent loop all other pages are
marked as "no-dat" pages with the ESSA instruction.

This information is visible to the hypervisor, so that the hypervisor can
optimize purging of guest TLB entries. The initial loop however does not
cover the complete kernel address space. This can result in pages being
marked as not being used for dynamic address translation, even though they
are. In turn guest TLB entries incorrectly may not be purged.

Fix this by adjusting the end address of the kernel address range being
walked.

Cc: <stable@vger.kernel.org>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/mm/page-states.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

--- a/arch/s390/mm/page-states.c
+++ b/arch/s390/mm/page-states.c
@@ -162,15 +162,22 @@ static void mark_kernel_p4d(pgd_t *pgd,
 
 static void mark_kernel_pgd(void)
 {
-	unsigned long addr, next;
+	unsigned long addr, next, max_addr;
 	struct page *page;
 	pgd_t *pgd;
 	int i;
 
 	addr = 0;
+	/*
+	 * Figure out maximum virtual address accessible with the
+	 * kernel ASCE. This is required to keep the page table walker
+	 * from accessing non-existent entries.
+	 */
+	max_addr = (S390_lowcore.kernel_asce.val & _ASCE_TYPE_MASK) >> 2;
+	max_addr = 1UL << (max_addr * 11 + 31);
 	pgd = pgd_offset_k(addr);
 	do {
-		next = pgd_addr_end(addr, MODULES_END);
+		next = pgd_addr_end(addr, max_addr);
 		if (pgd_none(*pgd))
 			continue;
 		if (!pgd_folded(*pgd)) {
@@ -179,7 +186,7 @@ static void mark_kernel_pgd(void)
 				set_bit(PG_arch_1, &page[i].flags);
 		}
 		mark_kernel_p4d(pgd, addr, next);
-	} while (pgd++, addr = next, addr != MODULES_END);
+	} while (pgd++, addr = next, addr != max_addr);
 }
 
 void __init cmma_init_nodat(void)



