Return-Path: <stable+bounces-224477-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAFkKiwEsGlAegIAu9opvQ
	(envelope-from <stable+bounces-224477-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:44:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B69EA24B77A
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C3519309C15B
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93D844E044;
	Tue, 10 Mar 2026 11:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyltkM62"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2B044D6AC;
	Tue, 10 Mar 2026 11:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142208; cv=none; b=J5Xq2MAXX/F7E3D2WB7FFIIsYdt66hSnYnOtJVT4gnYcpdhgQgbJAHc/MNTV4kFnWNVESKvwuhoOlL/3D9UyvaIkcyaQMAFDsWSCGx0BYqGFUUHukDBVajSzCh3vC/986zizopWZ+2YM4shUjBPedRpR83yFMNLb2eUuOST56RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142208; c=relaxed/simple;
	bh=V7P+zk/pkRz/jekaaN4PwoCztfbDfJlJNKBcuRUhraM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOZzpDuIMwHFSv5HMrFn49NHf2Jq88bcPsDTUXH2TahpCjQAuwtun2O2cGgeRX3pOPkP+J+duwCYyilfYm17Kp/E2lJxEsK8idvc7ZANBH7ikvxsBhmqs2vtWd9DrO4bOoe7dXRablbOzFbLXAZoiyhl4be25uWIver0RUYkEUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyltkM62; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B4DC19423;
	Tue, 10 Mar 2026 11:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142208;
	bh=V7P+zk/pkRz/jekaaN4PwoCztfbDfJlJNKBcuRUhraM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OyltkM62RoKSc5G5jvWWkUFbp18IqBMhijIRfzZ3PtEeFs4kCnYiM4aV3Pb/bq/xr
	 +kJJKTBvn76WbjELta5+a0S2xw8Xg8z+kMIIp1w7fYER4GjtvZtJLva3OYeS/Isx94
	 1CcJ/Ghxby5DvH6v/RLfyX5KtgtjAdUScV8wVNkesktySRMFPiuyIDT/K6GdUMaro0
	 hsuslbGOn4kCG9syKa0KnTwD57PQ3aIAXEeXb2jVK7qmOkiVYZihH8dTRYuOPubfkn
	 p+FK4DbPR69Wj98baiCOo1XW/7W9afM0m+1DLRrgpERBuufVxQ6pMTj5JZAwTG9Og2
	 qkkM+3/VlEDJA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Wake Liu <wakel@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 298/314] kselftest/harness: Use helper to avoid zero-size memset warning
Date: Tue, 10 Mar 2026 07:19:17 -0400
Message-ID: <5426593e9dfc43d68daea685639c2d51157fff41.1773141556.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B69EA24B77A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224477-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:email,googlesource.com:url]
X-Rspamd-Action: no action

From: Wake Liu <wakel@google.com>

[ Upstream commit 19b8a76cd99bde6d299e60490f3e62b8d3df3997 ]

When building kselftests with a toolchain that enables source
fortification (e.g., Android's build environment, which uses
-D_FORTIFY_SOURCE=3), a build failure occurs in tests that use an
empty FIXTURE().

The root cause is that an empty fixture struct results in
`sizeof(self_private)` evaluating to 0. The compiler's fortification
checks then detect the `memset()` call with a compile-time constant size
of 0, issuing a `-Wuser-defined-warnings` which is promoted to an error
by `-Werror`.

An initial attempt to guard the call with `if (sizeof(self_private) > 0)`
was insufficient. The compiler's static analysis is aggressive enough
to flag the `memset(..., 0)` pattern before evaluating the conditional,
thus still triggering the error.

To resolve this robustly, this change introduces a `static inline`
helper function, `__kselftest_memset_safe()`. This function wraps the
size check and the `memset()` call. By replacing the direct `memset()`
in the `__TEST_F_IMPL` macro with a call to this helper, we create an
abstraction boundary. This prevents the compiler's static analyzer from
"seeing" the problematic pattern at the macro expansion site, resolving
the build failure.

Build Context:
Compiler: Android (14488419, +pgo, +bolt, +lto, +mlgo, based on r584948) clang version 22.0.0 (https://android.googlesource.com/toolchain/llvm-project 2d65e4108033380e6fe8e08b1f1826cd2bfb0c99)
Relevant Options: -O2 -Wall -Werror -D_FORTIFY_SOURCE=3 -target i686-linux-android10000

Test: m kselftest_futex_futex_requeue_pi

Removed Gerrit Change-Id
Shuah Khan <skhan@linuxfoundation.org>

Link: https://lore.kernel.org/r/20251224084120.249417-1-wakel@google.com
Signed-off-by: Wake Liu <wakel@google.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Stable-dep-of: 6be268151426 ("selftests/harness: order TEST_F and XFAIL_ADD constructors")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/kselftest_harness.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 3f66e862e83eb..159cd6729af33 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -70,6 +70,12 @@
 
 #include "kselftest.h"
 
+static inline void __kselftest_memset_safe(void *s, int c, size_t n)
+{
+	if (n > 0)
+		memset(s, c, n);
+}
+
 #define TEST_TIMEOUT_DEFAULT 30
 
 /* Utilities exposed to the test definitions */
@@ -416,7 +422,7 @@
 				self = mmap(NULL, sizeof(*self), PROT_READ | PROT_WRITE, \
 					MAP_SHARED | MAP_ANONYMOUS, -1, 0); \
 			} else { \
-				memset(&self_private, 0, sizeof(self_private)); \
+				__kselftest_memset_safe(&self_private, 0, sizeof(self_private)); \
 				self = &self_private; \
 			} \
 		} \
-- 
2.51.0


