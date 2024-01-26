Return-Path: <stable+bounces-16010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC4783E725
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 00:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9102C1C27F4E
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66C758AD6;
	Fri, 26 Jan 2024 23:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1IUboEmP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6101B5D8FE
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 23:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706312357; cv=none; b=blSi94hQ4X2TIY5HMDJqMQDnznWDpetpHPfMO3qDd1+OoBZ5Fh5ALqHhZT0PNUOAdxKYZny9OCjFT7GwJ9lYHXOhJiW8b++wJ10acLXrLnxck8Dfr82LTZpWkMLkIppzca4wbtCy6fOJ4wm5S71U+CjzGd/jBT0Jp6cnUV8WX34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706312357; c=relaxed/simple;
	bh=i1xIANJrr7nJTc4pOB0k9l4UYo3VlFx6J8FCUwqRwTw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=a4gFAP6HBzsZh4PyltAebivxCQRdLBs0RedxAaDWWkXe1uk/2NsgS6OpRj7m0fK+OjsJZawhIxxecW8YpnvqCZUhRcuhi7d8WrbpSsN0Ev4bkj8T4J2F2mroRYuXSIv9ga/ECtfDDpAtgcmaQpqEd3o2MTYYnhYJQio14KZFF5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1IUboEmP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A161C433C7;
	Fri, 26 Jan 2024 23:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706312357;
	bh=i1xIANJrr7nJTc4pOB0k9l4UYo3VlFx6J8FCUwqRwTw=;
	h=Subject:To:Cc:From:Date:From;
	b=1IUboEmPFcQbwbY+YxUb7xg89mTRRm5wfh8VImNvuoOnqwbAaIn4/CfVEEw2QH+mq
	 JhczG5PBrnkOTTJtg0rHEMd8ND/PZUU9i58cPluCvEVoWzfPtAqg7DGrqpP9+P3lfw
	 0ygIS41JRKCQmNSIxS+SDJLCwkdFRTVp0geDWjJM=
Subject: FAILED: patch "[PATCH] selftests: mm: hugepage-vmemmap fails on 64K page size" failed to apply to 6.1-stable tree
To: donettom@linux.vnet.ibm.com,akpm@linux-foundation.org,geetika@linux.ibm.com,muchun.song@linux.dev,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 15:39:16 -0800
Message-ID: <2024012616-armrest-racoon-14ea@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 00bcfcd47a52f50f07a2e88d730d7931384cb073
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012616-armrest-racoon-14ea@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

00bcfcd47a52 ("selftests: mm: hugepage-vmemmap fails on 64K page size systems")
0183d777c29a ("selftests: mm: remove duplicate unneeded defines")
af605d26a8f2 ("selftests/mm: merge util.h into vm_util.h")
baa489fabd01 ("selftests/vm: rename selftests/vm to selftests/mm")
799fb82aa132 ("tools/vm: rename tools/vm to tools/mm")
93fb70aa5904 ("selftests/vm: add KSM unmerge tests")
7aca5ca15493 ("selftests/vm: anon_cow: prepare for non-anonymous COW tests")
65f199b2b40d ("vmalloc: add reviewers for vmalloc code")
e487ebbd1298 ("selftests/vm: anon_cow: add liburing test cases")
f4b5fd6946e2 ("selftests/vm: anon_cow: THP tests")
a905e82ae44b ("selftests/vm: factor out pagemap_is_populated() into vm_util")
69c66add5663 ("selftests/vm: anon_cow: test COW handling of anonymous memory")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 00bcfcd47a52f50f07a2e88d730d7931384cb073 Mon Sep 17 00:00:00 2001
From: Donet Tom <donettom@linux.vnet.ibm.com>
Date: Wed, 10 Jan 2024 14:03:35 +0530
Subject: [PATCH] selftests: mm: hugepage-vmemmap fails on 64K page size
 systems

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

diff --git a/tools/testing/selftests/mm/hugepage-vmemmap.c b/tools/testing/selftests/mm/hugepage-vmemmap.c
index 5b354c209e93..894d28c3dd47 100644
--- a/tools/testing/selftests/mm/hugepage-vmemmap.c
+++ b/tools/testing/selftests/mm/hugepage-vmemmap.c
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
@@ -56,7 +56,7 @@ static unsigned long virt_to_pfn(void *addr)
 	if (fd < 0)
 		return -1UL;
 
-	lseek(fd, (unsigned long)addr / PAGE_SIZE * sizeof(pagemap), SEEK_SET);
+	lseek(fd, (unsigned long)addr / pagesize * sizeof(pagemap), SEEK_SET);
 	read(fd, &pagemap, sizeof(pagemap));
 	close(fd);
 
@@ -86,7 +86,7 @@ static int check_page_flags(unsigned long pfn)
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


