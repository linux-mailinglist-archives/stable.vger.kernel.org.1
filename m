Return-Path: <stable+bounces-46096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD7F8CEA16
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 20:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7746E283628
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 18:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837C744376;
	Fri, 24 May 2024 18:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RrsWu20D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4121D40858;
	Fri, 24 May 2024 18:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716576950; cv=none; b=kpqIi1xWejtYZWaBKdtRM6P0KBCu6g8x05TeRAyNpFfIKV/6gSZNyALXf+6TPuz/WyczsOTYDGINt7Bgdy9YkyBZa6gNDR3H9vmjPMLF8V8uXJsVmC3BNtl481i+2PsleVMWFF7y+iAHUFXNoWm/L8y98nlfpOT4TihCdEtLxrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716576950; c=relaxed/simple;
	bh=U1g4RX4Y4t6js6hI4psVrX5JkQ5ewPkttvfeIHkQiGU=;
	h=Date:To:From:Subject:Message-Id; b=CLhacazml++HX/W3S5LuNGjXImJ6h59A5rkcUZsE2p3w7Z3tDD3AV9zeWruZdX+dtPxv9cXQP9xqQC4//+PKZq/p8rhnEpkTQDPpQeinsMowjkS97v0x/sRsXIeIg9k44rJZ8+6HtPSeIfjife/r2YRv/kgYUyg5ZFaRffxuIFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RrsWu20D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA78C2BBFC;
	Fri, 24 May 2024 18:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1716576949;
	bh=U1g4RX4Y4t6js6hI4psVrX5JkQ5ewPkttvfeIHkQiGU=;
	h=Date:To:From:Subject:From;
	b=RrsWu20DGXIniQEJxhWEiqZZMPd2QcYTznbjt/N23r/p94RjHFS+r/DiBf2dyvPf6
	 gcKWso7Y277Fc+4Kwp7gDJCqUADpzBFgUJO6ZvQ0pjPXuvfcWRLE+a4tgCBJJI3qEz
	 Ubsqs1rANzU0WohSZA7vNJiuTOnZ8F9gdoz9XOeQ=
Date: Fri, 24 May 2024 11:55:49 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,sjayaram@akamai.com,shuah@kernel.org,anshuman.khandual@arm.com,dev.jain@arm.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] selftests-mm-compaction_test-fix-incorrect-write-of-zero-to-nr_hugepages.patch removed from -mm tree
Message-Id: <20240524185549.CFA78C2BBFC@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: selftests/mm: compaction_test: fix incorrect write of zero to nr_hugepages
has been removed from the -mm tree.  Its filename was
     selftests-mm-compaction_test-fix-incorrect-write-of-zero-to-nr_hugepages.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Dev Jain <dev.jain@arm.com>
Subject: selftests/mm: compaction_test: fix incorrect write of zero to nr_hugepages
Date: Tue, 21 May 2024 13:13:57 +0530

Currently, the test tries to set nr_hugepages to zero, but that is not
actually done because the file offset is not reset after read().  Fix that
using lseek().

Link: https://lkml.kernel.org/r/20240521074358.675031-3-dev.jain@arm.com
Fixes: bd67d5c15cc1 ("Test compaction of mlocked memory")
Signed-off-by: Dev Jain <dev.jain@arm.com>
Cc: <stable@vger.kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Sri Jayaramappa <sjayaram@akamai.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 tools/testing/selftests/mm/compaction_test.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/tools/testing/selftests/mm/compaction_test.c~selftests-mm-compaction_test-fix-incorrect-write-of-zero-to-nr_hugepages
+++ a/tools/testing/selftests/mm/compaction_test.c
@@ -108,6 +108,8 @@ int check_compaction(unsigned long mem_f
 		goto close_fd;
 	}
 
+	lseek(fd, 0, SEEK_SET);
+
 	/* Start with the initial condition of 0 huge pages*/
 	if (write(fd, "0", sizeof(char)) != sizeof(char)) {
 		ksft_print_msg("Failed to write 0 to /proc/sys/vm/nr_hugepages: %s\n",
_

Patches currently in -mm which might be from dev.jain@arm.com are

selftests-mm-va_high_addr_switch-reduce-test-noise.patch
selftests-mm-va_high_addr_switch-dynamically-initialize-testcases-to-enable-lpa2-testing.patch


