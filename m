Return-Path: <stable+bounces-1352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF987F7F3B
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AC08282482
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139142D787;
	Fri, 24 Nov 2023 18:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vKVaEW+i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CC933CCA;
	Fri, 24 Nov 2023 18:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538ACC433C7;
	Fri, 24 Nov 2023 18:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851186;
	bh=lSjgilWe5E14n4gJtcvbdIjQftUJ0mldVDEWyuCYEJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vKVaEW+iByrbcx/AbaNpwkDpWl79On6IVmTc8EtedFHXVE6+9pUklpLRE3aUuoYov
	 O86Xw+C5DU5GC9STJeZr293YYxpOcVQIvmQW3tIKvB+dtuKaRj0uaXtHk4I5ldCZ0h
	 PPvcUlN1+YRc+9UoPSpJorsxpyxOMnddPuk0vfU0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 6.5 347/491] s390/mm: add missing arch_set_page_dat() call to vmem_crst_alloc()
Date: Fri, 24 Nov 2023 17:49:43 +0000
Message-ID: <20231124172034.992847317@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiko Carstens <hca@linux.ibm.com>

commit 09cda0a400519b1541591c506e54c9c48e3101bf upstream.

If the cmma no-dat feature is available all pages that are not used for
dynamic address translation are marked as "no-dat" with the ESSA
instruction. This information is visible to the hypervisor, so that the
hypervisor can optimize purging of guest TLB entries. This also means that
pages which are used for dynamic address translation must not be marked as
"no-dat", since the hypervisor may then incorrectly not purge guest TLB
entries.

Region and segment tables allocated via vmem_crst_alloc() are incorrectly
marked as "no-dat", as soon as slab_is_available() returns true.

Such tables are allocated e.g. when kernel page tables are split, memory is
hotplugged, or a DCSS segment is loaded.

Fix this by adding the missing arch_set_page_dat() call.

Cc: <stable@vger.kernel.org>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/mm/vmem.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -13,6 +13,7 @@
 #include <linux/hugetlb.h>
 #include <linux/slab.h>
 #include <linux/sort.h>
+#include <asm/page-states.h>
 #include <asm/cacheflush.h>
 #include <asm/nospec-branch.h>
 #include <asm/pgalloc.h>
@@ -46,8 +47,11 @@ void *vmem_crst_alloc(unsigned long val)
 	unsigned long *table;
 
 	table = vmem_alloc_pages(CRST_ALLOC_ORDER);
-	if (table)
-		crst_table_init(table, val);
+	if (!table)
+		return NULL;
+	crst_table_init(table, val);
+	if (slab_is_available())
+		arch_set_page_dat(virt_to_page(table), CRST_ALLOC_ORDER);
 	return table;
 }
 



