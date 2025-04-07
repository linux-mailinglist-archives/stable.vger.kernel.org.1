Return-Path: <stable+bounces-128692-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73466A7EAD7
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8FA0442000
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924AA254877;
	Mon,  7 Apr 2025 18:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epzHMDnn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C1A2673AD;
	Mon,  7 Apr 2025 18:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049682; cv=none; b=fbUyQq51W2TFtYyWfWNo8mhrR1yAYtyGmLn1D3v8wdE2o+T10ztKljbfrNFkLk9bYLkeE+1u0lmZf7aS/oIuCQgQ1z72xC6Ui1t8d7bQjRHLhLc7yHn7GTc0caW4VPo+/62caeIj1/x+2UKCUQB/44oI6qfUnLQyeAFqugDP5R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049682; c=relaxed/simple;
	bh=9Ac0KUBMyaxHwyoSZUPb8pD8KizNBg2oelAxFm8j2kk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KHmCh2rUapTD6Q8Oix9u2Dox6D6nHRxxm/2hwAABUnBAr5DxOXPzH+7YygS4BBVs9WQ6MJujqTUZZXnY0T80GamiWgjY2WilI8HAympBfAMvcnloEdvfv7jR1pgMgkUPldrVmgCo3FaAsohfHvSRzGFqgt5pxVZm526tqasGcpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epzHMDnn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EDBBC4CEDD;
	Mon,  7 Apr 2025 18:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049681;
	bh=9Ac0KUBMyaxHwyoSZUPb8pD8KizNBg2oelAxFm8j2kk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=epzHMDnnVP/HKvi4g1wk1JR7dHzij7myGT4YFr/ZKWpbC19zQt+Ms2dG3L35strTx
	 Z8ere7vkhUA7pWzvRrLUu2xJbTPqfOjw5OlyaqR7aSHs+vinPW79PwtmdeaGUNw+pq
	 F7pTtqLfLyANmqWMv5RyrEN0iIevMU+VqY281U0b0lSU5gW6bnt8OqeKsRJnOwRgWG
	 4ITxnMfTaIQdzBjEplzjWcqeR3PTRSDynkks+nm+NUeRPNKmfgfHXbojMQNj9vZCZi
	 TufX0hiZcvKA3zAZv9U9V4bjJBdHB94tb6SklrVBi4Gr+iHGyeFlFYR3HmTTiM5Te6
	 I2x3+HiVjevng==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	peterz@infradead.org,
	pmladek@suse.com,
	jani.nikula@intel.com,
	john.ogness@linutronix.de,
	gregkh@linuxfoundation.org,
	joel.granados@kernel.org,
	jfalempe@redhat.com,
	takakura@valinux.co.jp
Subject: [PATCH AUTOSEL 6.6 12/15] objtool, panic: Disable SMAP in __stack_chk_fail()
Date: Mon,  7 Apr 2025 14:14:12 -0400
Message-Id: <20250407181417.3183475-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181417.3183475-1-sashal@kernel.org>
References: <20250407181417.3183475-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.86
Content-Transfer-Encoding: 8bit

From: Josh Poimboeuf <jpoimboe@kernel.org>

[ Upstream commit 72c774aa9d1e16bfd247096935e7dae194d84929 ]

__stack_chk_fail() can be called from uaccess-enabled code.  Make sure
uaccess gets disabled before calling panic().

Fixes the following warning:

  kernel/trace/trace_branch.o: error: objtool: ftrace_likely_update+0x1ea: call to __stack_chk_fail() with UACCESS enabled

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/a3e97e0119e1b04c725a8aa05f7bc83d98e657eb.1742852847.git.jpoimboe@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/panic.c        | 6 ++++++
 tools/objtool/check.c | 5 ++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index ef9f9a4e928de..d7973e9754748 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -763,9 +763,15 @@ device_initcall(register_warn_debugfs);
  */
 __visible noinstr void __stack_chk_fail(void)
 {
+	unsigned long flags;
+
 	instrumentation_begin();
+	flags = user_access_save();
+
 	panic("stack-protector: Kernel stack is corrupted in: %pB",
 		__builtin_return_address(0));
+
+	user_access_restore(flags);
 	instrumentation_end();
 }
 EXPORT_SYMBOL(__stack_chk_fail);
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 665dccdd6b0af..46638e5a8576a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1225,12 +1225,15 @@ static const char *uaccess_safe_builtin[] = {
 	"__ubsan_handle_load_invalid_value",
 	/* STACKLEAK */
 	"stackleak_track_stack",
+	/* TRACE_BRANCH_PROFILING */
+	"ftrace_likely_update",
+	/* STACKPROTECTOR */
+	"__stack_chk_fail",
 	/* misc */
 	"csum_partial_copy_generic",
 	"copy_mc_fragile",
 	"copy_mc_fragile_handle_tail",
 	"copy_mc_enhanced_fast_string",
-	"ftrace_likely_update", /* CONFIG_TRACE_BRANCH_PROFILING */
 	"rep_stos_alternative",
 	"rep_movs_alternative",
 	"__copy_user_nocache",
-- 
2.39.5


