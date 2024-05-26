Return-Path: <stable+bounces-46201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BBD8CF34E
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 11:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 914AA28120E
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 09:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002612BAE6;
	Sun, 26 May 2024 09:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMMzgPDG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E642B9C5;
	Sun, 26 May 2024 09:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716716533; cv=none; b=tE/+41o9sTwvbvt6rDNgCqN4xYgxEPBR3ym2tg7i6lMRVNeDIEk7/BhPYbdGNyGtDcxj3NOXEV16u30sKBOm0JoHZ0HvNsP7ptqNjFperpE8AKymVdBRM5Puxf0Z3Uqu8QfGmu9E/xbzxvXj1UsPi0FDgVl2dKQy9ape49Hsbow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716716533; c=relaxed/simple;
	bh=Pn2wC7Qjgmx1WJ5h/NAhgXkp/LKfK1z1n1o1iNJNFAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MwcSVQeNDOlwj2fmxePBAYVkisVugy8A0urFYqsAHtFEokJOKxbfobNKJRXxC78MGN6enTa2ElLpcISgD1bT0a21yoyqs+CfKqLwrHXHHWMt+f69bUFq7c4ahZnHRWeGYCiu2gm0RkJh0gJWPeq1wHZV8GaRW7Dx0mF3w2SOch0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMMzgPDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C7CC4AF08;
	Sun, 26 May 2024 09:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716716533;
	bh=Pn2wC7Qjgmx1WJ5h/NAhgXkp/LKfK1z1n1o1iNJNFAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FMMzgPDGEnT5yIxmjV4IECZru5Hz3SODKsp8IL6VaAbwV1dc814QtbvZl1O10YZni
	 vMcrGjWtTOT/QzcYYfmlouMFkYS565dwlx8T8XVPqjRaolZzLQcS9EZBF/75cvlQs/
	 oWkFGx90X4tMeFRf8WlbZKM2VydCeINDIaPdoEVGaB30oJ9R/SE9+w+h0E1DQnR8Iy
	 Wf+3mjV7mw9XXvmrTqU1uJre5jvRukSNBF90so6PqDPN2RBxrCMV/eKyTDTbevWHx/
	 9cHSr39svICBlwP7Tweo1HFeSHad5JErqiLbT30oTC81WLaI0wisCxqHE8zW1S48p8
	 V2L+aSfTYj78Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Erhard Furtner <erhard_f@mailbox.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Sasha Levin <sashal@kernel.org>,
	kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.9 13/15] ubsan: Avoid i386 UBSAN handler crashes with Clang
Date: Sun, 26 May 2024 05:41:45 -0400
Message-ID: <20240526094152.3412316-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240526094152.3412316-1-sashal@kernel.org>
References: <20240526094152.3412316-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.1
Content-Transfer-Encoding: 8bit

From: Kees Cook <keescook@chromium.org>

[ Upstream commit 2e431b23a13ce4459cf484c8f0b3218c7048b515 ]

When generating Runtime Calls, Clang doesn't respect the -mregparm=3
option used on i386. Hopefully this will be fixed correctly in Clang 19:
https://github.com/llvm/llvm-project/pull/89707
but we need to fix this for earlier Clang versions today. Force the
calling convention to use non-register arguments.

Reported-by: Erhard Furtner <erhard_f@mailbox.org>
Closes: https://github.com/KSPP/linux/issues/350
Link: https://lore.kernel.org/r/20240424224026.it.216-kees@kernel.org
Acked-by: Nathan Chancellor <nathan@kernel.org>
Acked-by: Justin Stitt <justinstitt@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/ubsan.h | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/lib/ubsan.h b/lib/ubsan.h
index 0abbbac8700d1..0982578fbd98f 100644
--- a/lib/ubsan.h
+++ b/lib/ubsan.h
@@ -124,19 +124,32 @@ typedef s64 s_max;
 typedef u64 u_max;
 #endif
 
-void __ubsan_handle_add_overflow(void *data, void *lhs, void *rhs);
-void __ubsan_handle_sub_overflow(void *data, void *lhs, void *rhs);
-void __ubsan_handle_mul_overflow(void *data, void *lhs, void *rhs);
-void __ubsan_handle_negate_overflow(void *_data, void *old_val);
-void __ubsan_handle_divrem_overflow(void *_data, void *lhs, void *rhs);
-void __ubsan_handle_type_mismatch(struct type_mismatch_data *data, void *ptr);
-void __ubsan_handle_type_mismatch_v1(void *_data, void *ptr);
-void __ubsan_handle_out_of_bounds(void *_data, void *index);
-void __ubsan_handle_shift_out_of_bounds(void *_data, void *lhs, void *rhs);
-void __ubsan_handle_builtin_unreachable(void *_data);
-void __ubsan_handle_load_invalid_value(void *_data, void *val);
-void __ubsan_handle_alignment_assumption(void *_data, unsigned long ptr,
-					 unsigned long align,
-					 unsigned long offset);
+/*
+ * When generating Runtime Calls, Clang doesn't respect the -mregparm=3
+ * option used on i386: https://github.com/llvm/llvm-project/issues/89670
+ * Fix this for earlier Clang versions by forcing the calling convention
+ * to use non-register arguments.
+ */
+#if defined(CONFIG_X86_32) && \
+    defined(CONFIG_CC_IS_CLANG) && CONFIG_CLANG_VERSION < 190000
+# define ubsan_linkage asmlinkage
+#else
+# define ubsan_linkage
+#endif
+
+void ubsan_linkage __ubsan_handle_add_overflow(void *data, void *lhs, void *rhs);
+void ubsan_linkage __ubsan_handle_sub_overflow(void *data, void *lhs, void *rhs);
+void ubsan_linkage __ubsan_handle_mul_overflow(void *data, void *lhs, void *rhs);
+void ubsan_linkage __ubsan_handle_negate_overflow(void *_data, void *old_val);
+void ubsan_linkage __ubsan_handle_divrem_overflow(void *_data, void *lhs, void *rhs);
+void ubsan_linkage __ubsan_handle_type_mismatch(struct type_mismatch_data *data, void *ptr);
+void ubsan_linkage __ubsan_handle_type_mismatch_v1(void *_data, void *ptr);
+void ubsan_linkage __ubsan_handle_out_of_bounds(void *_data, void *index);
+void ubsan_linkage __ubsan_handle_shift_out_of_bounds(void *_data, void *lhs, void *rhs);
+void ubsan_linkage __ubsan_handle_builtin_unreachable(void *_data);
+void ubsan_linkage __ubsan_handle_load_invalid_value(void *_data, void *val);
+void ubsan_linkage __ubsan_handle_alignment_assumption(void *_data, unsigned long ptr,
+						       unsigned long align,
+						       unsigned long offset);
 
 #endif
-- 
2.43.0


