Return-Path: <stable+bounces-106236-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 557F09FDE37
	for <lists+stable@lfdr.de>; Sun, 29 Dec 2024 10:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF7181881F1A
	for <lists+stable@lfdr.de>; Sun, 29 Dec 2024 09:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B027083A;
	Sun, 29 Dec 2024 09:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="le1IeGx5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7y5p4X6U"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB75B33993;
	Sun, 29 Dec 2024 09:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735464488; cv=none; b=AtYDUtbnjuBz2OjGfMFVSDwFwUzjS4R0QgVsblWPZeDJMxMIMFY74SnMu+8XPpcK+0ez1eyTbT64pUimdwPcEqGGA0csF309Vrr3ueVprTrbVa+vxy3dOcVJTH5lj5n7ANRcrNbFhL+p/VhAOMSZ6CIQD/ghS8X07eX6MisfCCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735464488; c=relaxed/simple;
	bh=Nd8oXdRqgXx2laEJNMFEaUTrDxIl7E8+dYd1wum3ELg=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=q+nU2wPT+WhjoVQxRSAjxAtiPd7GlKflX80wVFpyGnwpbVpNYKarB7M+/hoUJKhGfvXemI8hLnVd/BHUiaPcGkj0EhWFHO4fcPTERbq8hUSVSf2RZcIRuQ+wjkCKcOBO8cVCrR145zPGr5lAYFzApnljglG4KyiiVoCLf2T+7C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=le1IeGx5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7y5p4X6U; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 29 Dec 2024 09:28:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735464485;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=RW2IvpfoXsPG/v0gcwjjErnlDTLHaciCcMVs2AbXPF4=;
	b=le1IeGx5Vrp+5lGZkjnH8CFcvcGUlMoIzFDZUSo91xoWOrNLtW0fb+Zncy7XRYDu4RRjnZ
	YhwgofxkAtKxi4piFUo0Cnn/X9+0uewXM6mGNp2o3hkIPmudsVpk/AQ3MTD4jtfBJlMz1D
	L4nJzoM4JNsIuwOQVAGWFNXt/CX8viFEtHj+/0icL9+T8tw7cMRjuS/G/ybSlDRdF5iBQS
	t32AFlb8/ea1tVU23XQ/aExxM5yEoVaO/ra91KtM7F/tECSjuxmNFJnhCCeIu/utmxroBE
	40ysRMm7C+uC+i/67TgT5h1OMHjSc/lXqa0f3SY5amPk+/nRN8RAliH066w+pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735464485;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=RW2IvpfoXsPG/v0gcwjjErnlDTLHaciCcMVs2AbXPF4=;
	b=7y5p4X6Uc/PPehXQI6Y0ilTPOlS32iaJv9RkAATVVhV7DhM2vueatKo+oHrzYQYx+XOrRB
	vu7DPVHnRlOdGwDA==
From: "tip-bot2 for Li RongQing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] virt: tdx-guest: Just leak decrypted memory on
 unrecoverable errors
Cc: Li RongQing <lirongqing@baidu.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173546448435.399.8616425027879023490.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     27834971f616c5e154423c578fa95e0444444ce1
Gitweb:        https://git.kernel.org/tip/27834971f616c5e154423c578fa95e0444444ce1
Author:        Li RongQing <lirongqing@baidu.com>
AuthorDate:    Wed, 19 Jun 2024 19:18:01 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 29 Dec 2024 10:18:44 +01:00

virt: tdx-guest: Just leak decrypted memory on unrecoverable errors

In CoCo VMs it is possible for the untrusted host to cause
set_memory_decrypted() to fail such that an error is returned
and the resulting memory is shared. Callers need to take care
to handle these errors to avoid returning decrypted (shared)
memory to the page allocator, which could lead to functional
or security issues.

Leak the decrypted memory when set_memory_decrypted() fails,
and don't need to print an error since set_memory_decrypted()
will call WARN_ONCE().

Fixes: f4738f56d1dc ("virt: tdx-guest: Add Quote generation support using TSM_REPORTS")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20240619111801.25630-1-lirongqing%40baidu.com
---
 drivers/virt/coco/tdx-guest/tdx-guest.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index d7db6c8..224e7dd 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -124,10 +124,8 @@ static void *alloc_quote_buf(void)
 	if (!addr)
 		return NULL;
 
-	if (set_memory_decrypted((unsigned long)addr, count)) {
-		free_pages_exact(addr, len);
+	if (set_memory_decrypted((unsigned long)addr, count))
 		return NULL;
-	}
 
 	return addr;
 }

