Return-Path: <stable+bounces-118227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 576E2A3BA95
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C157A3A0463
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1CD1DE2B5;
	Wed, 19 Feb 2025 09:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P5ojeMAC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B68176ADE;
	Wed, 19 Feb 2025 09:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739957601; cv=none; b=MzZw/Sh0wW3TkTAtPhq8YUG2Jqiqg741YRXN6wJHxVsSgpQPRiYfY0AdMcNXXlw7wnys4a6MZHPwob/stsmkNtygR6FG8JqatoLYrYnp0ExWYcazRBDjGyhtw/GsNjl5u9bpHg5VwibqQiagSW3j0P3Pm+UJellJUr9G6bfMjMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739957601; c=relaxed/simple;
	bh=U40BqF3dEngerdxdc9j+fOl0ywBB0BKqvGj6bjk3VFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WELWTpNuzdDITSRFWlBVJsUzbaG/+2Js+7zSmzxLlP3zcEzBf9BTsLD5HSnrOTKT6tofKTdz3EOgP8LYuuHsl9Aeei/s1azF8COhQ45praInHE6lc3IbycvFrWVJlI1U4d00HRdoCl7Z28vbUMWSsrXWfXk1Io+klW762xDgCL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P5ojeMAC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5390EC4CED1;
	Wed, 19 Feb 2025 09:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739957600;
	bh=U40BqF3dEngerdxdc9j+fOl0ywBB0BKqvGj6bjk3VFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P5ojeMACVTp74GpV5IZ/B+EkIUf0TBF5pkdSrhUL2jFgQj/dXNPxsXIr2oOWAw5ry
	 yos4w2zoXYmh8cXNg3qR0RAVltWtGQJzPDDgSY/i5rU+5UccHAdS3KY360VNjBIeDM
	 XX/nb3XXdFyicESlbNN1Qr9K0gXCdsiM2GsR1peU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Zenla <alex@edera.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Juergen Gross <jgross@suse.com>
Subject: [PATCH 6.1 560/578] x86/static-call: Remove early_boot_irqs_disabled check to fix Xen PVH dom0
Date: Wed, 19 Feb 2025 09:29:24 +0100
Message-ID: <20250219082714.988819007@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082652.891560343@linuxfoundation.org>
References: <20250219082652.891560343@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Cooper <andrew.cooper3@citrix.com>

commit 5cc2db37124bb33914996d6fdbb2ddb3811f2945 upstream.

__static_call_update_early() has a check for early_boot_irqs_disabled, but
is used before early_boot_irqs_disabled is set up in start_kernel().

Xen PV has always special cased early_boot_irqs_disabled, but Xen PVH does
not and falls over the BUG when booting as dom0.

It is very suspect that early_boot_irqs_disabled starts as 0, becomes 1 for
a time, then becomes 0 again, but as this needs backporting to fix a
breakage in a security fix, dropping the BUG_ON() is the far safer option.

Fixes: 0ef8047b737d ("x86/static-call: provide a way to do very early static-call updates")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219620
Reported-by: Alex Zenla <alex@edera.dev>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Juergen Gross <jgross@suse.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Alex Zenla <alex@edera.dev>
Link: https://lore.kernel.org/r/20241221211046.6475-1-andrew.cooper3@citrix.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/static_call.c |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -173,7 +173,6 @@ EXPORT_SYMBOL_GPL(arch_static_call_trans
 noinstr void __static_call_update_early(void *tramp, void *func)
 {
 	BUG_ON(system_state != SYSTEM_BOOTING);
-	BUG_ON(!early_boot_irqs_disabled);
 	BUG_ON(static_call_initialized);
 	__text_gen_insn(tramp, JMP32_INSN_OPCODE, tramp, func, JMP32_INSN_SIZE);
 	sync_core();



