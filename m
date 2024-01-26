Return-Path: <stable+bounces-15868-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B628B83D56B
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 10:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E97351C25D17
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 09:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F970629E8;
	Fri, 26 Jan 2024 07:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YB2Obz+O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2CF6FA8;
	Fri, 26 Jan 2024 07:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706255734; cv=none; b=IqF4BV9FRkoZkW4rCd9iyl9lW5aHaV3GBgHNq7fIGQ4m/dkMFOz7XhSMZMwUP7Dvu+0qyDDU43hb7jcwJDivuMNUmXTG17Wq3PAbBhe39nJgOtz46zKFaIY3ZWggS83mIf1jZhtj+SRYr7L7sGW6I1eRINaKBM6ejRPCuXvadXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706255734; c=relaxed/simple;
	bh=feS80eLe97iHODmNfpPhyl+lgvX9ivAYfndKLeyU/T4=;
	h=Date:To:From:Subject:Message-Id; b=nQ/gWjpfhaQp/fA9v4onoZn0AgvxLnmlFOzJml1LfBsH9GYAyQF6ps6DzfgdKzZBYCzj2FvDdPNo9DFf7tp6ISBqU941wwgGaHwUtkKC6eAJST+DhIKvOL/5c9VylQcliIcpC2gjNbwrHu4T7Jwr0Z2ROXWz9GiKG7Sw0QPRPwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YB2Obz+O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62EDBC433F1;
	Fri, 26 Jan 2024 07:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1706255733;
	bh=feS80eLe97iHODmNfpPhyl+lgvX9ivAYfndKLeyU/T4=;
	h=Date:To:From:Subject:From;
	b=YB2Obz+Oq+JoKCrLGW3C8UY7yhZ7xIWEPuCItWTtbGeVNVwJBJVFttV9ID44LqyhW
	 GRL4wI7sIz2ddTFM8yXHeYf4Y4G+yNMwNkPbnW/O+15uhTBNIiPUpYvNK/l76m4hwO
	 qiMbRh4hqdvz0flGvkLRBzK+xGzsVR8MTULNrhSM=
Date: Thu, 25 Jan 2024 23:55:30 -0800
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,shuah@kernel.org,mpe@ellerman.id.au,donettom@linux.vnet.ibm.com,christophe.leroy@c-s.fr,npache@redhat.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-stable] selftests-mm-fix-map_hugetlb-failure-on-64k-page-size-systems.patch removed from -mm tree
Message-Id: <20240126075533.62EDBC433F1@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: selftests: mm: fix map_hugetlb failure on 64K page size systems
has been removed from the -mm tree.  Its filename was
     selftests-mm-fix-map_hugetlb-failure-on-64k-page-size-systems.patch

This patch was dropped because it was merged into the mm-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Nico Pache <npache@redhat.com>
Subject: selftests: mm: fix map_hugetlb failure on 64K page size systems
Date: Fri, 19 Jan 2024 06:14:29 -0700

On systems with 64k page size and 512M huge page sizes, the allocation and
test succeeds but errors out at the munmap.  As the comment states, munmap
will failure if its not HUGEPAGE aligned.  This is due to the length of
the mapping being 1/2 the size of the hugepage causing the munmap to not
be hugepage aligned.  Fix this by making the mapping length the full
hugepage if the hugepage is larger than the length of the mapping.

Link: https://lkml.kernel.org/r/20240119131429.172448-1-npache@redhat.com
Signed-off-by: Nico Pache <npache@redhat.com>
Cc: Donet Tom <donettom@linux.vnet.ibm.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 tools/testing/selftests/mm/map_hugetlb.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/tools/testing/selftests/mm/map_hugetlb.c~selftests-mm-fix-map_hugetlb-failure-on-64k-page-size-systems
+++ a/tools/testing/selftests/mm/map_hugetlb.c
@@ -15,6 +15,7 @@
 #include <unistd.h>
 #include <sys/mman.h>
 #include <fcntl.h>
+#include "vm_util.h"
 
 #define LENGTH (256UL*1024*1024)
 #define PROTECTION (PROT_READ | PROT_WRITE)
@@ -58,10 +59,16 @@ int main(int argc, char **argv)
 {
 	void *addr;
 	int ret;
+	size_t hugepage_size;
 	size_t length = LENGTH;
 	int flags = FLAGS;
 	int shift = 0;
 
+	hugepage_size = default_huge_page_size();
+	/* munmap with fail if the length is not page aligned */
+	if (hugepage_size > length)
+		length = hugepage_size;
+
 	if (argc > 1)
 		length = atol(argv[1]) << 20;
 	if (argc > 2) {
_

Patches currently in -mm which might be from npache@redhat.com are

selftests-mm-perform-some-system-cleanup-before-using-hugepages.patch


