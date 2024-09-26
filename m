Return-Path: <stable+bounces-77814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EB698781F
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 19:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BE951C21D1C
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 17:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED69156864;
	Thu, 26 Sep 2024 17:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="scpKj0YS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VB9UDbw5"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47192837F;
	Thu, 26 Sep 2024 17:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727370410; cv=none; b=E1XJH2JmwXQpnEVtULnh7qkuNX2Hgu36u1hPb9SB5PxZwBv4etRrpqW6tIxRfLPQdpKEXZQKsROUdHCCJ/4eL0pUnsKKov0mkFk99ROei5b9tuxkhtakumVycOGBaG8iuiVUnaII5UDivAuzafdScy9P3XAYyKpgZ+GszHEw2Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727370410; c=relaxed/simple;
	bh=S6gwfa0nJ28dU+fH2n+ZwioN+TOwzSjwkOlo7Be0TYs=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=OeCAW980+IlHnk6EKanrpdLQQUyVYEAriCBghoi3np9Bn0XbRXIoPyd94pgHKHW0PNjF408yXo9/WgIyNQnoCf3VYz4XyX0HHA5JbDeYtLnTu3nM0xbn4Zd5xbKnOZVbUFJlOCIFpEqUjqbO/Jz7NkYIihodg0S8OAGGNF4FaMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=scpKj0YS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VB9UDbw5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 26 Sep 2024 17:06:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727370406;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=V6wq91clFMoxGKcuuRfOMaTBgzRsJjzuYYbe0XBMQJc=;
	b=scpKj0YSoPUTE4plfKW+qjtw4Joli2QakKs7Y1fvKKp7tN5RhSJVR8mOfdv5ICbqBgCmk+
	MYwYEf8OA8+YtLB7CcWRwvr2iwPkdvhgI4H1SoYo2nlPQoiv1yTg/uMlR2wEsPyKlhWD+C
	EAGVZa3ulaIJvxdeNgcnSjg1Llk6KeSPqrBu8LpPxzUXHrJS72/6o0xaPEIifrnxGLSoYz
	vPZqSzMmyYuN1nLCh1M1JBs6/iHlmNUTjX+XfiG4rsSABw8i/b6SGI2eSHoL2Gr2A04vRt
	DGiozp8TL33YREYBjqIhRD7hzCceHhsTig4rU6WxOaSX8DtBFlBvPfGgUbS+Aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727370406;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=V6wq91clFMoxGKcuuRfOMaTBgzRsJjzuYYbe0XBMQJc=;
	b=VB9UDbw5kB+EABzipXBuv3j418nuB2d+D9dIkTh2foi4HiJ9FfIglopsGROh/GAKzDEubl
	2b26RfzvAMA68uDA==
From: "tip-bot2 for Alexey Gladkov (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/tdx: Fix "in-kernel MMIO" check
Cc: "Alexey Gladkov (Intel)" <legion@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172737040576.2215.15419153772474435232.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d4fc4d01471528da8a9797a065982e05090e1d81
Gitweb:        https://git.kernel.org/tip/d4fc4d01471528da8a9797a065982e05090e1d81
Author:        Alexey Gladkov (Intel) <legion@kernel.org>
AuthorDate:    Fri, 13 Sep 2024 19:05:56 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 26 Sep 2024 09:45:04 -07:00

x86/tdx: Fix "in-kernel MMIO" check

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
---
 arch/x86/coco/tdx/tdx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index da8b66d..327c45c 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -16,6 +16,7 @@
 #include <asm/insn-eval.h>
 #include <asm/pgtable.h>
 #include <asm/set_memory.h>
+#include <asm/traps.h>
 
 /* MMIO direction */
 #define EPT_READ	0
@@ -433,6 +434,11 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
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

