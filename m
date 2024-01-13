Return-Path: <stable+bounces-10609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1690E82C7EC
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 00:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB4BCB236FC
	for <lists+stable@lfdr.de>; Fri, 12 Jan 2024 23:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D82199D9;
	Fri, 12 Jan 2024 23:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WA1XZmto"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4002319451;
	Fri, 12 Jan 2024 23:21:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD174C43394;
	Fri, 12 Jan 2024 23:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1705101705;
	bh=byWArrWY89eQGqq6MExRZnI58hPNPsuMybHOebVbi/I=;
	h=Date:To:From:Subject:From;
	b=WA1XZmtoeu0gd4cfPMxdM1cx7hFePFufcXg2bXopwBlEkyFbXmAJxAXPbP7ERSj43
	 a2eNSGzvqqNoY012POhjHM3n63IRJ9pBAUYkWF9WyAFiNTv1xjo51xkBXi352YC4ps
	 s0TTPU8QQbrAdZUADNU+yX/UeimoW6TOGTN4buGE=
Date: Fri, 12 Jan 2024 15:21:45 -0800
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,muchun.song@linux.dev,geetika@linux.ibm.com,donettom@linux.vnet.ibm.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] selftests-mm-hugepage-vmemmap-fails-on-64k-page-size-systems.patch removed from -mm tree
Message-Id: <20240112232145.AD174C43394@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: selftests: mm: hugepage-vmemmap fails on 64K page size systems
has been removed from the -mm tree.  Its filename was
     selftests-mm-hugepage-vmemmap-fails-on-64k-page-size-systems.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Donet Tom <donettom@linux.vnet.ibm.com>
Subject: selftests: mm: hugepage-vmemmap fails on 64K page size systems
Date: Wed, 10 Jan 2024 14:03:35 +0530

The kernel sefltest mm/hugepage-vmemmap fails on architectures which has
different page size other than 4K.  In hugepage-vmemmap page size used is
4k so the pfn calculation will go wrong on systems which has different
page size .The length of MAP_HUGETLB memory must be hugepage aligned but
in hugepage-vmemmap map length is 2M so this will not get aligned if the
system has differnet hugepage size.

Added  psize() to get the page size and default_huge_page_size() to
get the default hugepage size at run time, hugepage-vmemmap test pass
on powerpc with 64K page size and x86 with 4K page size.

Result on powerpc without patch (page size 64K)
*# ./hugepage-vmemmap
Returned address is 0x7effff000000 whose pfn is 0
Head page flags (100000000) is invalid
check_page_flags: Invalid argument
*#

Result on powerpc with patch (page size 64K)
*# ./hugepage-vmemmap
Returned address is 0x7effff000000 whose pfn is 600
*#

Result on x86 with patch (page size 4K)
*# ./hugepage-vmemmap
Returned address is 0x7fc7c2c00000 whose pfn is 1dac00
*#

Link: https://lkml.kernel.org/r/3b3a3ae37ba21218481c482a872bbf7526031600.1704865754.git.donettom@linux.vnet.ibm.com
Fixes: b147c89cd429 ("selftests: vm: add a hugetlb test case")
Signed-off-by: Donet Tom <donettom@linux.vnet.ibm.com>
Reported-by: Geetika Moolchandani <geetika@linux.ibm.com>
Tested-by: Geetika Moolchandani <geetika@linux.ibm.com>
Acked-by: Muchun Song <muchun.song@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 tools/testing/selftests/mm/hugepage-vmemmap.c |   29 +++++++++-------
 1 file changed, 18 insertions(+), 11 deletions(-)

--- a/tools/testing/selftests/mm/hugepage-vmemmap.c~selftests-mm-hugepage-vmemmap-fails-on-64k-page-size-systems
+++ a/tools/testing/selftests/mm/hugepage-vmemmap.c
@@ -10,10 +10,7 @@
 #include <unistd.h>
 #include <sys/mman.h>
 #include <fcntl.h>
-
-#define MAP_LENGTH		(2UL * 1024 * 1024)
-
-#define PAGE_SIZE		4096
+#include "vm_util.h"
 
 #define PAGE_COMPOUND_HEAD	(1UL << 15)
 #define PAGE_COMPOUND_TAIL	(1UL << 16)
@@ -39,6 +36,9 @@
 #define MAP_FLAGS		(MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB)
 #endif
 
+static size_t pagesize;
+static size_t maplength;
+
 static void write_bytes(char *addr, size_t length)
 {
 	unsigned long i;
@@ -56,7 +56,7 @@ static unsigned long virt_to_pfn(void *a
 	if (fd < 0)
 		return -1UL;
 
-	lseek(fd, (unsigned long)addr / PAGE_SIZE * sizeof(pagemap), SEEK_SET);
+	lseek(fd, (unsigned long)addr / pagesize * sizeof(pagemap), SEEK_SET);
 	read(fd, &pagemap, sizeof(pagemap));
 	close(fd);
 
@@ -86,7 +86,7 @@ static int check_page_flags(unsigned lon
 	 * this also verifies kernel has correctly set the fake page_head to tail
 	 * while hugetlb_free_vmemmap is enabled.
 	 */
-	for (i = 1; i < MAP_LENGTH / PAGE_SIZE; i++) {
+	for (i = 1; i < maplength / pagesize; i++) {
 		read(fd, &pageflags, sizeof(pageflags));
 		if ((pageflags & TAIL_PAGE_FLAGS) != TAIL_PAGE_FLAGS ||
 		    (pageflags & HEAD_PAGE_FLAGS) == HEAD_PAGE_FLAGS) {
@@ -106,18 +106,25 @@ int main(int argc, char **argv)
 	void *addr;
 	unsigned long pfn;
 
-	addr = mmap(MAP_ADDR, MAP_LENGTH, PROT_READ | PROT_WRITE, MAP_FLAGS, -1, 0);
+	pagesize  = psize();
+	maplength = default_huge_page_size();
+	if (!maplength) {
+		printf("Unable to determine huge page size\n");
+		exit(1);
+	}
+
+	addr = mmap(MAP_ADDR, maplength, PROT_READ | PROT_WRITE, MAP_FLAGS, -1, 0);
 	if (addr == MAP_FAILED) {
 		perror("mmap");
 		exit(1);
 	}
 
 	/* Trigger allocation of HugeTLB page. */
-	write_bytes(addr, MAP_LENGTH);
+	write_bytes(addr, maplength);
 
 	pfn = virt_to_pfn(addr);
 	if (pfn == -1UL) {
-		munmap(addr, MAP_LENGTH);
+		munmap(addr, maplength);
 		perror("virt_to_pfn");
 		exit(1);
 	}
@@ -125,13 +132,13 @@ int main(int argc, char **argv)
 	printf("Returned address is %p whose pfn is %lx\n", addr, pfn);
 
 	if (check_page_flags(pfn) < 0) {
-		munmap(addr, MAP_LENGTH);
+		munmap(addr, maplength);
 		perror("check_page_flags");
 		exit(1);
 	}
 
 	/* munmap() length of MAP_HUGETLB memory must be hugepage aligned */
-	if (munmap(addr, MAP_LENGTH)) {
+	if (munmap(addr, maplength)) {
 		perror("munmap");
 		exit(1);
 	}
_

Patches currently in -mm which might be from donettom@linux.vnet.ibm.com are



