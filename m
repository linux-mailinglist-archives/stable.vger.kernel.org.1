Return-Path: <stable+bounces-145109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A044EABDA06
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 15:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208DD3B27B4
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 13:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6E824337B;
	Tue, 20 May 2025 13:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dka/a5sc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14AD242D93;
	Tue, 20 May 2025 13:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747749187; cv=none; b=ku1BQlR5iiohKm4cC3w+fClU0rrusmkcSUAqgQlbvsOiBNgQZ4nQHRR/P0m+r5ipCl00ZweoTgjOtkvnLfpRmOcx+ShmmSj1fWo/JA4T2bz/mXVAaA4ZdKbBmC2ojxgDV1HLTz9baC8xOHBNn1UEsidrLjIi+cv1TN9OTFDu1E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747749187; c=relaxed/simple;
	bh=I83P+QnqpJo4fyNY0Plkj6kEBa5g+yLCLeQ11YCOsA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cblja/JuZ/h5Ut26m04KFhnzsXEnI50IjC37VkhqsoqaaAF95Q5ByEShP7+Z1j11s/FhSVYpNUDNkUajK7HkzXAmXHkNE37at6oqWBOxvFD0Kh4EEWnPU7n8jt7hQUAfZfdyL6d+2SZsHnzH75/JjOJtjT5AN8R4OymZeTaHVCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dka/a5sc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8DFC4CEE9;
	Tue, 20 May 2025 13:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747749185;
	bh=I83P+QnqpJo4fyNY0Plkj6kEBa5g+yLCLeQ11YCOsA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dka/a5scSDshIdqe50u1MtS2Hju9ktKmu/7M7lZdKRS8SLmzC3la7/TteKIpXJZcX
	 ZpBNBXQRp6e9ryRUnOMtjGG2cqpPYH8lTMVh0wvAfxgzvF3gspP0rcIuy+v/FKubd0
	 h9MuQ7Tci8/It/tu9ncvrwIYovwdC6/jQ+zr72fo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: [PATCH 5.15 22/59] x86/alternatives: Remove faulty optimization
Date: Tue, 20 May 2025 15:50:13 +0200
Message-ID: <20250520125754.736331021@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520125753.836407405@linuxfoundation.org>
References: <20250520125753.836407405@linuxfoundation.org>
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

From: Josh Poimboeuf <jpoimboe@kernel.org>

commit 4ba89dd6ddeca2a733bdaed7c9a5cbe4e19d9124 upstream.

The following commit

  095b8303f383 ("x86/alternative: Make custom return thunk unconditional")

made '__x86_return_thunk' a placeholder value.  All code setting
X86_FEATURE_RETHUNK also changes the value of 'x86_return_thunk'.  So
the optimization at the beginning of apply_returns() is dead code.

Also, before the above-mentioned commit, the optimization actually had a
bug It bypassed __static_call_fixup(), causing some raw returns to
remain unpatched in static call trampolines.  Thus the 'Fixes' tag.

Fixes: d2408e043e72 ("x86/alternative: Optimize returns patching")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/16d19d2249d4485d8380fb215ffaae81e6b8119e.1693889988.git.jpoimboe@kernel.org
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/alternative.c |    8 --------
 1 file changed, 8 deletions(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -638,14 +638,6 @@ void __init_or_module noinline apply_ret
 {
 	s32 *s;
 
-	/*
-	 * Do not patch out the default return thunks if those needed are the
-	 * ones generated by the compiler.
-	 */
-	if (cpu_feature_enabled(X86_FEATURE_RETHUNK) &&
-	    (x86_return_thunk == __x86_return_thunk))
-		return;
-
 	for (s = start; s < end; s++) {
 		void *dest = NULL, *addr = (void *)s + *s;
 		struct insn insn;



