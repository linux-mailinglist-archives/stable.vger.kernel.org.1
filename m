Return-Path: <stable+bounces-184934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F835BD4B74
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 18:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4DF1A5023AD
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E2430F7E0;
	Mon, 13 Oct 2025 15:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uG0V4zMO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32353271473;
	Mon, 13 Oct 2025 15:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368858; cv=none; b=ioJMNuuiBoRV8BK5YbaUEr8e7JkhCKYBrYuBXgYIdXbs786jIoM6U+tpy9jT7PrUxa1/btF/6j57GfvPXfc4BlDjKEqbW3A54re9JQGugYCgx7MfbnkRfdGQXHwNjdyNOjBkGGtFgh+zDEKodDROumtdDictHtTne7s5Q3PdbaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368858; c=relaxed/simple;
	bh=hwY54i3RCqc+ATS+4xc65xsXbEGLSC7z2ZUWLLdVxB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pe60op4UebWe4qkSFcffRqyNv71Pf6Mrk00YLekqQXCJgEvEF0vWq0mrIGzfLf+x7wRgkzh1RizD17QgemHQRRpd0sCVxTMo2TbeYh6JYQ/5IOB0CYguQErXAltQWcToyAGDYfZOHDa553KpSIkclk0FYD+Fi1FpKF9TnacpDP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uG0V4zMO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC09C4CEE7;
	Mon, 13 Oct 2025 15:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760368858;
	bh=hwY54i3RCqc+ATS+4xc65xsXbEGLSC7z2ZUWLLdVxB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uG0V4zMOVWDBYUemtzRozMeR8AJFoymdwlD6FxpRcd+fKaq+7TEk20tpTRw/gFL9N
	 qaxdmd+NRKVaMEg6tAwG5F0m4bV9WudmDtdYBJUP/NVDW0QdtR3SN9f+gOulAYqQ2x
	 B+qxq+2qrwkvWI/6ykpN/TX88dEc/KHSDNdmuvy4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yonghong Song <yonghong.song@linux.dev>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 043/563] bpf: Tidy verifier bug message
Date: Mon, 13 Oct 2025 16:38:24 +0200
Message-ID: <20251013144412.851822991@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144411.274874080@linuxfoundation.org>
References: <20251013144411.274874080@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Chaignon <paul.chaignon@gmail.com>

[ Upstream commit c93c59baa5ab57e94b874000cec56e26611b7a23 ]

Yonghong noticed that error messages for potential verifier bugs often
have a '(1)' at the end. This is happening because verifier_bug_if(cond,
env, fmt, args...) prints "(" #cond ")\n" as part of the message and
verifier_bug() is defined as:

  #define verifier_bug(env, fmt, args...) verifier_bug_if(1, env, fmt, ##args)

Hence, verifier_bug() always ends up displaying '(1)'. This small patch
fixes it by having verifier_bug_if conditionally call verifier_bug
instead of the other way around.

Fixes: 1cb0f56d9618 ("bpf: WARN_ONCE on verifier bugs")
Reported-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Tested-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Link: https://lore.kernel.org/bpf/aJo9THBrzo8jFXsh@mail.gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bpf_verifier.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 94defa405c85e..fe9a841fdf0cf 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -875,13 +875,15 @@ __printf(3, 4) void verbose_linfo(struct bpf_verifier_env *env,
 #define verifier_bug_if(cond, env, fmt, args...)						\
 	({											\
 		bool __cond = (cond);								\
-		if (unlikely(__cond)) {								\
-			BPF_WARN_ONCE(1, "verifier bug: " fmt "(" #cond ")\n", ##args);		\
-			bpf_log(&env->log, "verifier bug: " fmt "(" #cond ")\n", ##args);	\
-		}										\
+		if (unlikely(__cond))								\
+			verifier_bug(env, fmt " (" #cond ")", ##args);				\
 		(__cond);									\
 	})
-#define verifier_bug(env, fmt, args...) verifier_bug_if(1, env, fmt, ##args)
+#define verifier_bug(env, fmt, args...)								\
+	({											\
+		BPF_WARN_ONCE(1, "verifier bug: " fmt "\n", ##args);				\
+		bpf_log(&env->log, "verifier bug: " fmt "\n", ##args);				\
+	})
 
 static inline struct bpf_func_state *cur_func(struct bpf_verifier_env *env)
 {
-- 
2.51.0




