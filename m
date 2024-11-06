Return-Path: <stable+bounces-90863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5563C9BEB63
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D680DB25E8A
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AEA1F76B6;
	Wed,  6 Nov 2024 12:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E+7de2fs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36321EABB4;
	Wed,  6 Nov 2024 12:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730897039; cv=none; b=p8QN/QHTVl1UX/Vn9BZ1PZW+YJ0W9XHEJo8Lw46kwr2hwCy19dUPIi43RR3XRClsdbM9gZAbfGUnQKapit93sj88eDgFzFUAEDCiV6k3ywe6SHHspVVYAiSDZhf6UWnO5Rcp05fYhe/IDwpzmLBoDbZxY3fasEa/i49C9qm7IOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730897039; c=relaxed/simple;
	bh=FlHciFbl1I1pKNJNHGpf10elFhrQ9oiu+FZWVrP9wB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjtykiMpaENKCTWqSEVabWnq4ZpW7lbO9S8DO138eEIOX4JsRSDvKa+pfqr3XdJIGk9eoo9RsvEsYDeCA9HvduTnv/wk8X0dpG4wc78Dm+ukJH31Kn5UtPTab1G48pceAqNBGUbQiC/8pYdlVspJ78A0ffy3gZaQmj64f3nbDDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E+7de2fs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDFB7C4CECD;
	Wed,  6 Nov 2024 12:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730897038;
	bh=FlHciFbl1I1pKNJNHGpf10elFhrQ9oiu+FZWVrP9wB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E+7de2fseZ5J/ChLJvrujg8y+Liv184vPMgZsfQ1NoOcknR/nYBPc2GI2dNZc+IT6
	 /t4a+aKRDSwD/l4XlDWqURroFLC8NIWaZEWfq+m9+ioVPxhRarSUHOG9Kj67PdzyrP
	 XvllDSCQvpMbZZ6mZ6R74gnM49xTz3VopfQoCvCM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Li <ashimida@linux.alibaba.com>,
	Kees Cook <keescook@chromium.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Marco Elver <elver@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 046/126] compiler-gcc: remove attribute support check for `__no_sanitize_address__`
Date: Wed,  6 Nov 2024 13:04:07 +0100
Message-ID: <20241106120307.350423796@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120306.038154857@linuxfoundation.org>
References: <20241106120306.038154857@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miguel Ojeda <ojeda@kernel.org>

[ Upstream commit ae37a9a2c2d0960d643d782b426ea1aa9c05727a ]

The attribute was added in GCC 4.8, while the minimum GCC version
supported by the kernel is GCC 5.1.

Therefore, remove the check.

Link: https://godbolt.org/z/84v56vcn8
Link: https://lkml.kernel.org/r/20221021115956.9947-2-ojeda@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Dan Li <ashimida@linux.alibaba.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Marco Elver <elver@google.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 894b00a3350c ("kasan: Fix Software Tag-Based KASAN with GCC")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/compiler-gcc.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index e6474899250d5..b6050483ba421 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -102,11 +102,7 @@
 #define __noscs __attribute__((__no_sanitize__("shadow-call-stack")))
 #endif
 
-#if __has_attribute(__no_sanitize_address__)
 #define __no_sanitize_address __attribute__((__no_sanitize_address__))
-#else
-#define __no_sanitize_address
-#endif
 
 #if defined(__SANITIZE_THREAD__) && __has_attribute(__no_sanitize_thread__)
 #define __no_sanitize_thread __attribute__((__no_sanitize_thread__))
-- 
2.43.0




