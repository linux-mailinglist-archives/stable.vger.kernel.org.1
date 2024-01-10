Return-Path: <stable+bounces-10145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEA88272A7
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 396E728323A
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2F04BAB1;
	Mon,  8 Jan 2024 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LI6xVKV3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18AA6D6DC;
	Mon,  8 Jan 2024 15:15:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0740EC433CA;
	Mon,  8 Jan 2024 15:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704726901;
	bh=v7ubSPi9R4OZqAg6VItz+ZrcV1yhyhhJjoQj+Dvc858=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LI6xVKV3oV5gaBX7dsXJc70/oKZK22Luqu48Jj89cDHySjnjOI3oiva4PJ+7b3h+D
	 6fOvQFahcprzOafCsvsV0p8z46ps1tpTU6fgMxpc2n4geXC1RM8+i5ZOTJO2DJ0UI0
	 iooIBaGTONaTUgpDrNov030lt9272/Iu9/Thl07M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiajun Xie <jiajun.xie.sh@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6 113/124] mm: fix unmap_mapping_range high bits shift bug
Date: Mon,  8 Jan 2024 16:08:59 +0100
Message-ID: <20240108150608.166873803@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108150602.976232871@linuxfoundation.org>
References: <20240108150602.976232871@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiajun Xie <jiajun.xie.sh@gmail.com>

commit 9eab0421fa94a3dde0d1f7e36ab3294fc306c99d upstream.

The bug happens when highest bit of holebegin is 1, suppose holebegin is
0x8000000111111000, after shift, hba would be 0xfff8000000111111, then
vma_interval_tree_foreach would look it up fail or leads to the wrong
result.

error call seq e.g.:
- mmap(..., offset=0x8000000111111000)
  |- syscall(mmap, ... unsigned long, off):
     |- ksys_mmap_pgoff( ... , off >> PAGE_SHIFT);

  here pgoff is correctly shifted to 0x8000000111111,
  but pass 0x8000000111111000 as holebegin to unmap
  would then cause terrible result, as shown below:

- unmap_mapping_range(..., loff_t const holebegin)
  |- pgoff_t hba = holebegin >> PAGE_SHIFT;
          /* hba = 0xfff8000000111111 unexpectedly */

The issue happens in Heterogeneous computing, where the device(e.g.
gpu) and host share the same virtual address space.

A simple workflow pattern which hit the issue is:
        /* host */
    1. userspace first mmap a file backed VA range with specified offset.
                        e.g. (offset=0x800..., mmap return: va_a)
    2. write some data to the corresponding sys page
                         e.g. (va_a = 0xAABB)
        /* device */
    3. gpu workload touches VA, triggers gpu fault and notify the host.
        /* host */
    4. reviced gpu fault notification, then it will:
            4.1 unmap host pages and also takes care of cpu tlb
                  (use unmap_mapping_range with offset=0x800...)
            4.2 migrate sys page to device
            4.3 setup device page table and resolve device fault.
        /* device */
    5. gpu workload continued, it accessed va_a and got 0xAABB.
    6. gpu workload continued, it wrote 0xBBCC to va_a.
        /* host */
    7. userspace access va_a, as expected, it will:
            7.1 trigger cpu vm fault.
            7.2 driver handling fault to migrate gpu local page to host.
    8. userspace then could correctly get 0xBBCC from va_a
    9. done

But in step 4.1, if we hit the bug this patch mentioned, then userspace
would never trigger cpu fault, and still get the old value: 0xAABB.

Making holebegin unsigned first fixes the bug.

Link: https://lkml.kernel.org/r/20231220052839.26970-1-jiajun.xie.sh@gmail.com
Signed-off-by: Jiajun Xie <jiajun.xie.sh@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/memory.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3565,8 +3565,8 @@ EXPORT_SYMBOL_GPL(unmap_mapping_pages);
 void unmap_mapping_range(struct address_space *mapping,
 		loff_t const holebegin, loff_t const holelen, int even_cows)
 {
-	pgoff_t hba = holebegin >> PAGE_SHIFT;
-	pgoff_t hlen = (holelen + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	pgoff_t hba = (pgoff_t)(holebegin) >> PAGE_SHIFT;
+	pgoff_t hlen = ((pgoff_t)(holelen) + PAGE_SIZE - 1) >> PAGE_SHIFT;
 
 	/* Check for overflow. */
 	if (sizeof(holelen) > sizeof(hlen)) {



