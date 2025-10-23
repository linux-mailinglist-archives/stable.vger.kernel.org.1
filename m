Return-Path: <stable+bounces-189049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DBBBFEDED
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 03:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3821A18C6A2D
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 01:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B021A073F;
	Thu, 23 Oct 2025 01:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X4jImpxd"
X-Original-To: stable@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E5F3AC1C
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 01:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761184070; cv=none; b=TiU1oiazE0TccSjf17p8L382xqvttwhwZOp3yKU3NSjXEj37VEiw7rNDCLPH1J8QC9eiZ00Hdq7WFv2hhj+KPXFG5GQGuhZS89gH89SqMI5i3ydD8PluhYAdTRFg/YekT+KOba+Du/4Alp3WJ9P8eHBWVgnEl2ny0kqSrrLsfAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761184070; c=relaxed/simple;
	bh=yl7ozpiKizLFtYd5EiA7Rh/uHMgVMv4GyscwVnwRkCA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fuZi7n+ivdolslUZk6UfWdatlE/XjEuWonTltG1T3GeDQsmgHVAnv6HlzpOqcqJAkHJ4GhrDlyrQjJegZOQ5GwQSaMPY+eIm2Fk4sRW27hKwL4dMvyyTl+bqTOHCByonkQJ1Tp85iGvOG6qmFLaWvpOUKsrAgCgDryscwJ2b1Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X4jImpxd; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761184065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jPBHSIhisQYB9BOAqxE6p2j3YHbxjnfcV2vPoexza38=;
	b=X4jImpxdfP/eaQ4Vt75iKwYNUOphmJJbwKZUq/CsVqk0mC6J0eOj/pMI6m6uC95+qqIiO5
	G6NsT5+LdFGxSXv6W1AQkZCOkBhuQEmxirpnQ95l+4Xkn3I9LX3y9IuevZzzvbXZLEnvLC
	rJGGWYtiCctl98tlz5TCW8mT0+neias=
From: Leon Hwang <leon.hwang@linux.dev>
To: stable@vger.kernel.org,
	greg@kroah.com
Cc: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	lance.yang@linux.dev,
	shuah@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH 6.1.y v2] Revert "selftests: mm: fix map_hugetlb failure on 64K page size systems"
Date: Thu, 23 Oct 2025 09:47:32 +0800
Message-ID: <20251023014732.73721-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This reverts commit a584c7734a4dd050451fcdd65c66317e15660e81 to avoid
the build error:

map_hugetlb.c: In function 'main':
map_hugetlb.c:79:25: warning: implicit declaration of function 'default_huge_page_size' [-Wimplicit-function-declaration]
79 |         hugepage_size = default_huge_page_size();

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
v1 -> v2:
  - Revert the commit instead of fixing the build error.
  - https://lore.kernel.org/linux-mm/20251022055138.375042-1-leon.hwang@linux.dev/

 tools/testing/selftests/vm/map_hugetlb.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/tools/testing/selftests/vm/map_hugetlb.c b/tools/testing/selftests/vm/map_hugetlb.c
index c65c55b7a789..312889edb84a 100644
--- a/tools/testing/selftests/vm/map_hugetlb.c
+++ b/tools/testing/selftests/vm/map_hugetlb.c
@@ -15,7 +15,6 @@
 #include <unistd.h>
 #include <sys/mman.h>
 #include <fcntl.h>
-#include "vm_util.h"

 #define LENGTH (256UL*1024*1024)
 #define PROTECTION (PROT_READ | PROT_WRITE)
@@ -71,16 +70,10 @@ int main(int argc, char **argv)
 {
 	void *addr;
 	int ret;
-	size_t hugepage_size;
 	size_t length = LENGTH;
 	int flags = FLAGS;
 	int shift = 0;

-	hugepage_size = default_huge_page_size();
-	/* munmap with fail if the length is not page aligned */
-	if (hugepage_size > length)
-		length = hugepage_size;
-
 	if (argc > 1)
 		length = atol(argv[1]) << 20;
 	if (argc > 2) {
--
2.51.0

