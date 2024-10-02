Return-Path: <stable+bounces-78652-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BEE98D368
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7661F2809B0
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 12:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D47C1CFEAD;
	Wed,  2 Oct 2024 12:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRliCxfS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D325C1D52B
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727872615; cv=none; b=ahtaRi5trMkOa1Mi6ZCNl9H/X2iRtv+46HV9gS8M+aB7zjMCE20GAmKI9aeAbDQeDaq41xRWP1isrwLeaO52Fyzl3HnB/xmcjmOyVWND68u+974Auth5TDUnYGH4QZClWfsDsp4jfq6ftL3oB+pAec2U+wpXErMZ1iB7F/CYZp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727872615; c=relaxed/simple;
	bh=wGee77k5PCtNg6xcb+kNjTEA9ZbDYE/Af4As144H8+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=il71FCFN8axHgqbVZFF3fcUSTRTwnSWRs+AyA5VhaRGMAbmFbkoSFTDMw9h2RqxjgH3phpWhtPLn0kAwp8OZk+BXpTILZgAU2dxrFeDvkhBPeiPAoYFAyRlr3VJWfxAd7HzEURThWZIcrkhyoKW3uPHs+nmfqIdV21dD1EIGJrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vRliCxfS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55455C4CEC5;
	Wed,  2 Oct 2024 12:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727872615;
	bh=wGee77k5PCtNg6xcb+kNjTEA9ZbDYE/Af4As144H8+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vRliCxfS5id/G09K505QJZsjUWtx1gT2nUCjFvBZjytrAJifryxX5aCFRFitgxWnX
	 9o5ELSXTWl7gFxpmUag7Xs/lA0gZ8+t0BZHUP45B/z8Kt+OeBXzjixPYf3FMLhGfXl
	 1eZLcYmmevhmrZigzHJr41dROH7URS575bB92TyiB47SAcU69tR8uIhIipEHylLEz6
	 iDK/hSi234pcAHy6v9Yl3T3sG8MRO5876u80U3X9ireI0VixjDnH1Nso7zcamaEVH5
	 0s9xNDZcfBaIS8gP98cazt2k5Aco+BaW6JQBgOJeiS10rUBRO0n2t2+HBGIVjp3x5Z
	 m+a3JiJYbqxhw==
From: "Alexey Gladkov (Intel)" <legion@kernel.org>
To: stable@vger.kernel.org
Cc: "Alexey Gladkov (Intel)" <legion@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 6.1.y] x86/tdx: Fix "in-kernel MMIO" check
Date: Wed,  2 Oct 2024 14:36:27 +0200
Message-ID: <20241002123627.158020-1-legion@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <2024100104-everybody-retrace-89ed@gregkh>
References: <2024100104-everybody-retrace-89ed@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TDX only supports kernel-initiated MMIO operations. The handle_mmio()
function checks if the #VE exception occurred in the kernel and rejects
the operation if it did not.

However, userspace can deceive the kernel into performing MMIO on its
behalf. For example, if userspace can point a syscall to an MMIO address,
syscall does get_user() or put_user() on it, triggering MMIO #VE. The
kernel will treat the #VE as in-kernel MMIO.

Ensure that the target MMIO address is within the kernel before decoding
instruction.

Fixes: 31d58c4e557d ("x86/tdx: Handle in-kernel MMIO")
Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc:stable@vger.kernel.org
Link: https://lore.kernel.org/all/565a804b80387970460a4ebc67c88d1380f61ad1.1726237595.git.legion%40kernel.org
(cherry picked from commit d4fc4d01471528da8a9797a065982e05090e1d81)
Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>
---
 arch/x86/coco/tdx/tdx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index b9da467bd222..9032fea50219 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -12,6 +12,7 @@
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
 #include <asm/pgtable.h>
+#include <asm/traps.h>
 
 /* TDX module Call Leaf IDs */
 #define TDX_GET_INFO			1
@@ -371,6 +372,11 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 			return -EINVAL;
 	}
 
+	if (!fault_in_kernel_space(ve->gla)) {
+		WARN_ONCE(1, "Access to userspace address is not supported");
+		return -EINVAL;
+	}
+
 	/*
 	 * Reject EPT violation #VEs that split pages.
 	 *
-- 
2.46.2


