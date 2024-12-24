Return-Path: <stable+bounces-106062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A57209FBB8C
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 10:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D5041887AA7
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 09:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49431D6DA3;
	Tue, 24 Dec 2024 09:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bGn2SmAZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KbuXRj7Q"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51651B4F1E;
	Tue, 24 Dec 2024 09:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735033654; cv=none; b=ZBjUanRpsMPLvgl7eJrlAiqr7Cd7IzHCssjeD31VXU5bAKxgC1KKTZ2brxt60Mgqeo0EtY1ghvEwjdpBq2ik8F1+FtssJ2/1LucNTx2fv8nwYWeEXTIK/xjbDPrglOtFluiQpHmxgblqTdis7UpAO519AvD9TXHcqp41Hqk+UUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735033654; c=relaxed/simple;
	bh=/Ym5OsdlmtJHTJFEl2HFMeYmEB0z2MzIRMrdowttpCY=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=hKQBhgC6hBeIxO7VUU8RJdcYXj5xjX7UF1R7rOYcQtQ+SDnH5y/ncrli+BEW3FnjRTHp5nrEQZGwANUx9vQx72UAnHWKPD+F+In/9OXi8YM0CSD34kUVKdmEk2vUtRSeCBMTVbagLeLXv46o15N3t/uPvk8Y+W8WzWnFLJmEtLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bGn2SmAZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KbuXRj7Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Dec 2024 09:47:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735033651;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=8ABSVMN0mHmJFsqS369Z/NJtBs9QT7y0JQxwU7KzqYM=;
	b=bGn2SmAZJteLCF35ZPhfKI/xNhD6VAXHQd1b1jBB2kSz1PMuwgwSAY7mhVGBL++UKwkvb9
	I2Ks2xEbuXD6I6+rr5XeO+rWVidMjbu2ObGly9S7U+kUkTWGHQlchAn961ag1Qsr6nLwf/
	AhsYcLwPXrB28svIkkegBngsuETEjszyyskkkMSpyUBqGi/7UoMYkfP0PEANFWG01sW8bS
	XSyVbYM05CGL30eIyLGbw0EdC9ql5SUQBvgEA6a3ORvEsY9uvpcWWtlAQZ99LE4e/a4tH8
	rmFA8zUDpsZyjW2p7CyvQiNr+tLj/UXLzV+KJRF1bMaJOXrPteC5YwYD43ANEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735033651;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=8ABSVMN0mHmJFsqS369Z/NJtBs9QT7y0JQxwU7KzqYM=;
	b=KbuXRj7Qrrw3xYW9CNxPRJJIK1Vxex6x8ysz3sp35mWct9mdHg+zqd1AUWAjD9b9NMlmCI
	4FYvY02lqho1OoDw==
From: "tip-bot2 for Li RongQing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] virt: tdx-guest: Just leak decrypted memory on
 unrecoverable errors
Cc: Li RongQing <lirongqing@baidu.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173503365084.399.4200780690438676943.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     10331a93486ffb7b85ceea9da48a37da8cc16bdf
Gitweb:        https://git.kernel.org/tip/10331a93486ffb7b85ceea9da48a37da8cc16bdf
Author:        Li RongQing <lirongqing@baidu.com>
AuthorDate:    Wed, 19 Jun 2024 19:18:01 +08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 18 Dec 2024 06:07:55 -08:00

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

