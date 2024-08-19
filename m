Return-Path: <stable+bounces-69515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE4E95678C
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 11:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9F12822DC
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 09:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8773015B986;
	Mon, 19 Aug 2024 09:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F1ZZmrWM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B3113B592
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 09:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724061175; cv=none; b=STK3Q68+OXzzP1cj02x7adFvf4FhmxWVOm8uo+iiV0B6o1gNq1lU7agLLi3y3FdRsVEeXlp0EN//qPjNSp43VUxsdP2Ki5m176GDozxHuVMLS0fPpPmp83xkCoXOZLbb8fftob9+9HEl+RUlCZQ+x28G8sr8poQVk3KcikWuWqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724061175; c=relaxed/simple;
	bh=qGylRa7hRVVPry+G3vEuxMRPIhjvgeWWYCrAeGr2DBI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mM9g8So61hp0dS5hgA+WpjNUHNhdU8TZsCcD68c+JSxrAjxOQ+2+OTHnAE6ihEEG6zNgkuqnR8T3nDN9JWC3XxsU2ydgHEUvwFPok50Jj7S9/pU69NzqAs0OB18PDL6rQlu7MXTqS9xKel6mUAmOqYe2Jv7N42phnX0W7QUkUA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F1ZZmrWM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3D6C4AF0C;
	Mon, 19 Aug 2024 09:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724061174;
	bh=qGylRa7hRVVPry+G3vEuxMRPIhjvgeWWYCrAeGr2DBI=;
	h=Subject:To:Cc:From:Date:From;
	b=F1ZZmrWMU+onDcgjt3l0Z4313k7bVen+iJ0n+9rTvicFBCANXu1NHOZCNSvASMkKC
	 2btjAdj8vkkfEZe3qS797O6YqX0V1fMfoRZBysW7eDDY3GuLIj4muH+dnJinEgQMzU
	 rexOH+0pWTZZZXduHGFyodZ09aRn8mSztAicz26Y=
Subject: FAILED: patch "[PATCH] selftests: memfd_secret: don't build memfd_secret test on" failed to apply to 5.15-stable tree
To: usama.anjum@collabora.com,James.Bottomley@HansenPartnership.com,akpm@linux-foundation.org,aou@eecs.berkeley.edu,palmer@dabbelt.com,paul.walmsley@sifive.com,rppt@kernel.org,skhan@linuxfoundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Aug 2024 11:52:42 +0200
Message-ID: <2024081942-rippling-relieving-c8d1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 7c5e8d212d7d81991a580e7de3904ea213d9a852
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081942-rippling-relieving-c8d1@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

7c5e8d212d7d ("selftests: memfd_secret: don't build memfd_secret test on unsupported arches")
a3c5cc5129ef ("selftests/mm: log run_vmtests.sh results in TAP format")
2ffc27b15b11 ("tools/testing/selftests/mm/run_vmtests.sh: lower the ptrace permissions")
05f1edac8009 ("selftests/mm: run all tests from run_vmtests.sh")
000303329752 ("selftests/mm: make migration test robust to failure")
f6dd4e223d87 ("selftests/mm: skip soft-dirty tests on arm64")
ba91e7e5d15a ("selftests/mm: add tests for HWPOISON hugetlbfs read")
2bc481362245 ("selftests/mm: add -a to run_vmtests.sh")
63773d2b593d ("Merge mm-hotfixes-stable into mm-stable to pick up depended-upon changes.")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7c5e8d212d7d81991a580e7de3904ea213d9a852 Mon Sep 17 00:00:00 2001
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
Date: Fri, 9 Aug 2024 12:56:42 +0500
Subject: [PATCH] selftests: memfd_secret: don't build memfd_secret test on
 unsupported arches

[1] mentions that memfd_secret is only supported on arm64, riscv, x86 and
x86_64 for now.  It doesn't support other architectures.  I found the
build error on arm and decided to send the fix as it was creating noise on
KernelCI:

memfd_secret.c: In function 'memfd_secret':
memfd_secret.c:42:24: error: '__NR_memfd_secret' undeclared (first use in this function);
did you mean 'memfd_secret'?
   42 |         return syscall(__NR_memfd_secret, flags);
      |                        ^~~~~~~~~~~~~~~~~
      |                        memfd_secret

Hence I'm adding condition that memfd_secret should only be compiled on
supported architectures.

Also check in run_vmtests script if memfd_secret binary is present before
executing it.

Link: https://lkml.kernel.org/r/20240812061522.1933054-1-usama.anjum@collabora.com
Link: https://lore.kernel.org/all/20210518072034.31572-7-rppt@kernel.org/ [1]
Link: https://lkml.kernel.org/r/20240809075642.403247-1-usama.anjum@collabora.com
Fixes: 76fe17ef588a ("secretmem: test: add basic selftest for memfd_secret(2)")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Mike Rapoport (Microsoft) <rppt@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 7b8a5def54a1..cfad627e8d94 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -53,7 +53,9 @@ TEST_GEN_FILES += madv_populate
 TEST_GEN_FILES += map_fixed_noreplace
 TEST_GEN_FILES += map_hugetlb
 TEST_GEN_FILES += map_populate
+ifneq (,$(filter $(ARCH),arm64 riscv riscv64 x86 x86_64))
 TEST_GEN_FILES += memfd_secret
+endif
 TEST_GEN_FILES += migration
 TEST_GEN_FILES += mkdirty
 TEST_GEN_FILES += mlock-random-test
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 03ac4f2e1cce..36045edb10de 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -374,8 +374,11 @@ CATEGORY="hmm" run_test bash ./test_hmm.sh smoke
 # MADV_POPULATE_READ and MADV_POPULATE_WRITE tests
 CATEGORY="madv_populate" run_test ./madv_populate
 
+if [ -x ./memfd_secret ]
+then
 (echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope 2>&1) | tap_prefix
 CATEGORY="memfd_secret" run_test ./memfd_secret
+fi
 
 # KSM KSM_MERGE_TIME_HUGE_PAGES test with size of 100
 CATEGORY="ksm" run_test ./ksm_tests -H -s 100


