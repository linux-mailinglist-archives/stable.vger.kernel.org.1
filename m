Return-Path: <stable+bounces-162968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8931AB06037
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 16:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21ABD7A35B1
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 14:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD922EA467;
	Tue, 15 Jul 2025 13:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vu5D85j8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099972EA176;
	Tue, 15 Jul 2025 13:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587950; cv=none; b=hJ/zY6Bi3Z5I9G4uzWDWTYTl9TK9mNy5l1w2xD6UrT484QUp5XMt4HgLkZPuqf47futg/a91TbGohqT78SdDOWdXu9XITgQ4/8/hOXOTyEiRvXcClmeYRgG7NVmZlrWVY2JrmstLj4DIRAp9lf0KYGNavXMljkfm37AFHyCuji0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587950; c=relaxed/simple;
	bh=cDPUPZZY7D6gk99u48rLjo2M7v0MS1eovc847IceTfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/uuCmbCgS8LHc2KFDySkSxfnVX55N5Nh5nNiGMcZS/kfImtWrorZiXiVHu8Sm2ilhMP4zwk6UFo0qIYHzz7qzA3S+vGHZWEnewntYOvzE8VN92hkCrJESzES7lsPbLFwJugBHLuvNPCI8hJSJH3MnAd4EfGkLs99aEo7WlSznM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vu5D85j8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E908C4CEE3;
	Tue, 15 Jul 2025 13:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752587949;
	bh=cDPUPZZY7D6gk99u48rLjo2M7v0MS1eovc847IceTfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vu5D85j8ohfnMtQG0o/BkZ4x4P1Wb6bfIK80rQirjE0hmNGweX3k6JxIQMrsSTbCT
	 5j8K3ZFLauark219QQ2j2KQycNy7PuEgVblzGfjQvEcEUqng5ptSZzFe0yDlyWG49K
	 gzJRQJV7yo8grqZKy4vo5uKfi0yWT2DHDT6RS/kM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: [PATCH 5.10 162/208] x86/alternatives: Remove faulty optimization
Date: Tue, 15 Jul 2025 15:14:31 +0200
Message-ID: <20250715130817.469187974@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130810.830580412@linuxfoundation.org>
References: <20250715130810.830580412@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
@@ -793,14 +793,6 @@ void __init_or_module noinline apply_ret
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



