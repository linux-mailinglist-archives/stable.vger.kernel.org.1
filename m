Return-Path: <stable+bounces-43573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3888C32C7
	for <lists+stable@lfdr.de>; Sat, 11 May 2024 19:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D4121F21BE9
	for <lists+stable@lfdr.de>; Sat, 11 May 2024 17:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B040857308;
	Sat, 11 May 2024 17:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="eUCAN7j8"
X-Original-To: stable@vger.kernel.org
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3D01CD20
	for <stable@vger.kernel.org>; Sat, 11 May 2024 17:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715447707; cv=none; b=ml/+8EaRE8aGGYFyHHdmq4G81M3b8+ZHGusiQxn4z+C6PXjrPEjaizI0TsFBIr3B5kMG8EDS9BUko3J6OwhUBo9dqy9N3HH3nObV3dHYKijwmgf/3YOfKgLpf9GDAFWQdoVTosGw+ELcvSzzgBbqai9oJSqJhnrWTybeavlVdQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715447707; c=relaxed/simple;
	bh=TSFlfFFKghB8eHp9D3n3uLja5CEBEmaChN7Prcn4c0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=frAqml4+do+BHwm8WeYUuPCPNOAdOSMvbv3OwabWjbexP4TElF03v1/AbC4TVXsONr1BgyStBCD+1jv1Zz18O0E5oXXJOKPtxGf/zAcdp0HSDP8U1iR1pg5rBxupuhzT2nyHoVeNoc0INP2b/uEny+3jN3m2z41agSH/LVuPtyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=eUCAN7j8; arc=none smtp.client-ip=84.16.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VcC6m2wbKzdgn;
	Sat, 11 May 2024 19:14:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1715447696;
	bh=8JJOgijbuR5/kAVTe97EDz4QytUjmeXuS/y3d7NXyAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eUCAN7j8zU+baxpUtsZ9Q4G2ra4m/n3AHR2hCh0KeQCQl4ZHGubztDQyn9fI4xXht
	 C6VHcgoGoK/D3wpAsITlrrQE6qd+QU1OLxlcMfA8IeAsNqB86kD/iM0D1MxdObrqIl
	 ncFFk1DsAjh75AowKnBRpg1E7NN9Wuh029Bhq0Us=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VcC6l5GvVzRh3;
	Sat, 11 May 2024 19:14:55 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Shengyu Li <shengyu.li.evgeny@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Ron Economos <re@w6rz.net>,
	Ronald Warsow <rwarsow@gmx.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Will Drewry <wad@chromium.org>,
	kernel test robot <oliver.sang@intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v7 04/10] selftests/harness: Fix interleaved scheduling leading to race conditions
Date: Sat, 11 May 2024 19:14:39 +0200
Message-ID: <20240511171445.904356-5-mic@digikod.net>
In-Reply-To: <20240511171445.904356-1-mic@digikod.net>
References: <20240511171445.904356-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Fix a race condition when running several FIXTURE_TEARDOWN() managing
the same resource.  This fixes a race condition in the Landlock file
system tests when creating or unmounting the same directory.

Using clone3() with CLONE_VFORK guarantees that the child and grandchild
test processes are sequentially scheduled.  This is implemented with a
new clone3_vfork() helper replacing the fork() call.

This avoids triggering this error in __wait_for_test():
  Test ended in some other way [127]

Cc: Christian Brauner <brauner@kernel.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Günther Noack <gnoack@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Will Drewry <wad@chromium.org>
Fixes: 41cca0542d7c ("selftests/harness: Fix TEST_F()'s vfork handling")
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240511171445.904356-5-mic@digikod.net
---

Changes since v2:
* Replace __attribute__((__unused__)) with inline for clone3_vfork()
  (suggested by Kees and Jakub)
---
 tools/testing/selftests/kselftest_harness.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 55699a762c45..9d7178a71c2c 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -66,6 +66,8 @@
 #include <sys/wait.h>
 #include <unistd.h>
 #include <setjmp.h>
+#include <syscall.h>
+#include <linux/sched.h>
 
 #include "kselftest.h"
 
@@ -80,6 +82,17 @@
 #  define TH_LOG_ENABLED 1
 #endif
 
+/* Wait for the child process to end but without sharing memory mapping. */
+static inline pid_t clone3_vfork(void)
+{
+	struct clone_args args = {
+		.flags = CLONE_VFORK,
+		.exit_signal = SIGCHLD,
+	};
+
+	return syscall(__NR_clone3, &args, sizeof(args));
+}
+
 /**
  * TH_LOG()
  *
@@ -1183,7 +1196,7 @@ void __run_test(struct __fixture_metadata *f,
 	fflush(stdout);
 	fflush(stderr);
 
-	t->pid = fork();
+	t->pid = clone3_vfork();
 	if (t->pid < 0) {
 		ksft_print_msg("ERROR SPAWNING TEST CHILD\n");
 		t->exit_code = KSFT_FAIL;
-- 
2.45.0


