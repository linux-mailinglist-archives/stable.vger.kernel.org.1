Return-Path: <stable+bounces-98894-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF429E62FD
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 02:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D513E281322
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 01:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8EB28689;
	Fri,  6 Dec 2024 01:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hf95oTxv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAD91758B;
	Fri,  6 Dec 2024 01:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733447088; cv=none; b=lOYyKhWshDQCpkpHQQIWW/24AAcdIFPtDOnBjzEgGDYZyBMAYDGzoyGtGZ1ofr6vEbOEPbRJOvXHBV80nBWVI4R8NeQQ8IvCss9R2Ix5Ql00NGCFANx/ah+ZdOajUfBo32t0c1vLqakuQxBiFwIqIU4rh89UHyjb6GPTJQzjF4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733447088; c=relaxed/simple;
	bh=05uFWAjHcwwLiHrpfDIOqocotMV0baNHpZQifp1iKrc=;
	h=Date:To:From:Subject:Message-Id; b=MZOarxnVJObMnVETPy+n6BWsr7zMPVHcCxjOIiXMALGLK7YuzBAcbw+dcI2UPcVTEBKnchmyfUv/d1Xg8tvA3Zgt98H17kxGDzxZpiNcAjHWsZAOL5A0DZgYuBJd8/QaDXtqRCaMALL88f5I3gFYibGWp1YXYquRIqQ6X7U1lQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hf95oTxv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909FBC4CED1;
	Fri,  6 Dec 2024 01:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1733447087;
	bh=05uFWAjHcwwLiHrpfDIOqocotMV0baNHpZQifp1iKrc=;
	h=Date:To:From:Subject:From;
	b=hf95oTxvRVB6sMafYYWOM+nN0YSVTatSwQPEihXm4OnDm8bOSU9cajipZv1luQ0Tu
	 zL+sOCpWuFO/vACzzRw2gDyUul2h8b/wpgarLP1jJUxuuiBSR9xYvsEsbVkcENwx6l
	 bXegGGOo2hUa5AIXQ8CmzkyhaDESHCK7gpqr8RIs=
Date: Thu, 05 Dec 2024 17:04:47 -0800
To: mm-commits@vger.kernel.org,surenb@google.com,stable@vger.kernel.org,kaleshsingh@google.com,jeffxu@google.com,isaacmanjarres@google.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + selftests-memfd-run-sysctl-tests-when-pid-namespace-support-is-enabled.patch added to mm-hotfixes-unstable branch
Message-Id: <20241206010447.909FBC4CED1@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: selftests/memfd: run sysctl tests when PID namespace support is enabled
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     selftests-memfd-run-sysctl-tests-when-pid-namespace-support-is-enabled.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/selftests-memfd-run-sysctl-tests-when-pid-namespace-support-is-enabled.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: "Isaac J. Manjarres" <isaacmanjarres@google.com>
Subject: selftests/memfd: run sysctl tests when PID namespace support is enabled
Date: Thu, 5 Dec 2024 11:29:41 -0800

The sysctl tests for vm.memfd_noexec rely on the kernel to support PID
namespaces (i.e.  the kernel is built with CONFIG_PID_NS=y).  If the
kernel the test runs on does not support PID namespaces, the first sysctl
test will fail when attempting to spawn a new thread in a new PID
namespace, abort the test, preventing the remaining tests from being run.

This is not desirable, as not all kernels need PID namespaces, but can
still use the other features provided by memfd.  Therefore, only run the
sysctl tests if the kernel supports PID namespaces.  Otherwise, skip those
tests and emit an informative message to let the user know why the sysctl
tests are not being run.

Link: https://lkml.kernel.org/r/20241205192943.3228757-1-isaacmanjarres@google.com
Fixes: 11f75a01448f ("selftests/memfd: add tests for MFD_NOEXEC_SEAL MFD_EXEC")
Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
Reviewed-by: Jeff Xu <jeffxu@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Kalesh Singh <kaleshsingh@google.com>
Cc: <stable@vger.kernel.org>	[6.6+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 tools/testing/selftests/memfd/memfd_test.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/tools/testing/selftests/memfd/memfd_test.c~selftests-memfd-run-sysctl-tests-when-pid-namespace-support-is-enabled
+++ a/tools/testing/selftests/memfd/memfd_test.c
@@ -9,6 +9,7 @@
 #include <fcntl.h>
 #include <linux/memfd.h>
 #include <sched.h>
+#include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <signal.h>
@@ -1599,6 +1600,11 @@ static void test_share_fork(char *banner
 	close(fd);
 }
 
+static bool pid_ns_supported(void)
+{
+	return access("/proc/self/ns/pid", F_OK) == 0;
+}
+
 int main(int argc, char **argv)
 {
 	pid_t pid;
@@ -1634,8 +1640,12 @@ int main(int argc, char **argv)
 	test_seal_grow();
 	test_seal_resize();
 
-	test_sysctl_simple();
-	test_sysctl_nested();
+	if (pid_ns_supported()) {
+		test_sysctl_simple();
+		test_sysctl_nested();
+	} else {
+		printf("PID namespaces are not supported; skipping sysctl tests\n");
+	}
 
 	test_share_dup("SHARE-DUP", "");
 	test_share_mmap("SHARE-MMAP", "");
_

Patches currently in -mm which might be from isaacmanjarres@google.com are

selftests-memfd-run-sysctl-tests-when-pid-namespace-support-is-enabled.patch


