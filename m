Return-Path: <stable+bounces-107613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADE7A02CB0
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D57F1887A36
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81ABF145A03;
	Mon,  6 Jan 2025 15:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GGibbpoP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7B681728;
	Mon,  6 Jan 2025 15:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736178998; cv=none; b=ryGOs+A/q0NqoXJz3WSNxZj29qoI/ex4AagvEH1t6i1yE/M/ItUTo/j6TR4JOczXpSmhEpi/vpWRK2xNrJ/JNPoKHB+/GmbYsN7EPO6M6wUN27ZY92YUHKTWmvqphOyKPHZyYeirgxBz7+wYvmzikdKJRF2we7bYd1kzXraOuxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736178998; c=relaxed/simple;
	bh=2/dl4Ar1HxAKyb3HBcrfbmftJaY2OaNGKZAIoPb8zr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oUbDVKnmIW9Yyb8d/xUIwsabHxf+Dxx8j5XpWDmAwk/GuctcSMwCYGUlpmlwtN5+pp45wfbF02taImDtGh5ax2TLwpLObLNJ6Q5u4eM0AKYCGtfGZ9H3Sv7cP+y2D2eCemEb5/gG5z7X6hx2gSunlOFqWz1GIX7XS+V5Ty8WUeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GGibbpoP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98AEC4CED2;
	Mon,  6 Jan 2025 15:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736178998;
	bh=2/dl4Ar1HxAKyb3HBcrfbmftJaY2OaNGKZAIoPb8zr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GGibbpoPCPddImMdBbcN4bzG9YAQ1acAqU+WakEEEv/bP+0pC80rbX8hcJjR15sRb
	 LN7s7+6Kx+mzE4LfXSVDW5C0Sy5QwocJv7UfryohXHkPMD+rWTpDTWzfxMvkJBK+pt
	 r13adtDK1jNtYae2+l+/TVker9mVzu1FCucTWdBk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Marco Elver <elver@google.com>,
	Aleksandr Nogikh <nogikh@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15 161/168] kcov: mark in_softirq_really() as __always_inline
Date: Mon,  6 Jan 2025 16:17:49 +0100
Message-ID: <20250106151144.510620539@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151138.451846855@linuxfoundation.org>
References: <20250106151138.451846855@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit cb0ca08b326aa03f87fe94bb91872ce8d2ef1ed8 upstream.

If gcc decides not to inline in_softirq_really(), objtool warns about a
function call with UACCESS enabled:

kernel/kcov.o: warning: objtool: __sanitizer_cov_trace_pc+0x1e: call to in_softirq_really() with UACCESS enabled
kernel/kcov.o: warning: objtool: check_kcov_mode+0x11: call to in_softirq_really() with UACCESS enabled

Mark this as __always_inline to avoid the problem.

Link: https://lkml.kernel.org/r/20241217071814.2261620-1-arnd@kernel.org
Fixes: 7d4df2dad312 ("kcov: properly check for softirq context")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Marco Elver <elver@google.com>
Cc: Aleksandr Nogikh <nogikh@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/kcov.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -155,7 +155,7 @@ static void kcov_remote_area_put(struct
  * Unlike in_serving_softirq(), this function returns false when called during
  * a hardirq or an NMI that happened in the softirq context.
  */
-static inline bool in_softirq_really(void)
+static __always_inline bool in_softirq_really(void)
 {
 	return in_serving_softirq() && !in_hardirq() && !in_nmi();
 }



