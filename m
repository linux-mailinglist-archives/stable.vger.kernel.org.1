Return-Path: <stable+bounces-128677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C4EA7EA95
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4DBA422EC6
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582B226463F;
	Mon,  7 Apr 2025 18:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPxoT6AE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16571253F15;
	Mon,  7 Apr 2025 18:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049650; cv=none; b=Q3EHdsPQ9XnVyKrc4UfAUES5UfGyuk6mIANbrb5k4dR+k9yCmbZdg1OMTUTyCR2n/zNs9ZlFcpyYkDtINJUFCiR1O52/rfA5UOaa+OVzROCPZigKpEeONvFJhHK7YYFw5QBKuQ8O7p4QaoD3yLfptnXAfEIyteA4OZw6mnDp3U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049650; c=relaxed/simple;
	bh=DVHW7vlqmzgP46J9boBk5jqWaxyAJ1XfwJNWhtWqV6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lkpm02CL7Zj7phgT+MDY4el/T9qsCvLh33pSIFdnDcskcUXCgn/urbHH0/3SMfu2VdFo7XIjk9cG+2DEt9hLDs4I0PFXvA4rMhncQYtbHD89qHKt7niuo0bMvATvXCTRNifrIqB5UQEo6KL9d8wwivv8yaro4QyGXvTxeJt98mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPxoT6AE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BEB3C4CEE7;
	Mon,  7 Apr 2025 18:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049650;
	bh=DVHW7vlqmzgP46J9boBk5jqWaxyAJ1XfwJNWhtWqV6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EPxoT6AEmmbZQsU6QiDqZ9cZN0CoeiKynng8QC+214yTKuW54K9l/rVgLynuuNOwl
	 ujLIZcnxuz4+ueMurM0V4DhMS8Me4M5pj3k73GktAHvNV3TzKdan44oFCutF4HNc7c
	 wVIFHGnx/l+jCvHsJjqBR5FvVbVCF7fmJtHUestocYNHw9bWfKxlfiX8O7NoxmOkvA
	 Qwhvf3KlgJyKs1TbFkQLoplZkAdCElVDzn0HtxQNgO5bSqKgmiv19t751w0Wc2saMZ
	 XPv9uCyD8+Kp/P3mvcagjDOol+vQKjjI/VfuyEeOJcP6ZcerGbEfjtTcpQCSGhIrYg
	 o0WmG+orPHzvw==
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
	gregkh@linuxfoundation.org,
	john.ogness@linutronix.de,
	joel.granados@kernel.org,
	jgg@ziepe.ca,
	takakura@valinux.co.jp
Subject: [PATCH AUTOSEL 6.12 19/22] objtool, panic: Disable SMAP in __stack_chk_fail()
Date: Mon,  7 Apr 2025 14:13:29 -0400
Message-Id: <20250407181333.3182622-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181333.3182622-1-sashal@kernel.org>
References: <20250407181333.3182622-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.22
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
index fbc59b3b64d0b..ddad0578355bb 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -832,9 +832,15 @@ device_initcall(register_warn_debugfs);
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
index 6eabc3d3bcb2f..0ac258a3d1944 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1242,12 +1242,15 @@ static const char *uaccess_safe_builtin[] = {
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


