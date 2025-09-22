Return-Path: <stable+bounces-180974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E97B91D9A
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 17:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 188282A2B9D
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 15:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA1C2D8365;
	Mon, 22 Sep 2025 15:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e2pmWWJH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NomrlLZ0"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDC02472A5;
	Mon, 22 Sep 2025 15:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758553719; cv=none; b=V2CPdoTqfTPze7crkCBkB+UwroZh7tfCeajbYRr27XTBPIN87iLkoSTAnuOeH91BsM+ztuwV3JCYTUjK3+qfiIvYC9MaVys4l4PWh6fvayfUBVyMCUWPQRJLNEO15I7A1PHAZMC30FwGmXtgAsEyo4djp3dgI0TlUaevJ/q3snA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758553719; c=relaxed/simple;
	bh=LnaYjDNVDDpRfnQ+0cx0wyO+3y5HGPz+Eo2XZYOsIwE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eX23W8GbAXemJdgpjfqZpoypH19J/zZiCCWTgRdvd3JCcWfpJfif6DgzHExZ5ambi0jT+/VyLE5/pboTP8GvpbehqscjJrbMUEd7vAKKfYLJdjNZBFbPy8cCqv3WKqLb6qNQeAV64Do3bNSAU/Fc9Y/wt+aCJ523zrfrQykwBNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e2pmWWJH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NomrlLZ0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 22 Sep 2025 15:08:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758553714;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uqHx+FCqfW/ilWKgNBamj/Qr2VHNuXNAIDaLW+7mwcs=;
	b=e2pmWWJH8ayqh10B6L+YlCcdXrUXbSI9egovU72VgF2akzfNV9XCcC7mysqku/nmT57JDS
	tqVrov2FH15sIW2mnmRmfppLepRpPCZi6BaQAzYynwau6dUdn8JDwIfKVb/Pm6fxQy7/vN
	53z5TrWTLcvkvuK8T61mPbqJbMNwlepmQMh+X3ksHNd8YozfwCrS9cedTH5IeivczgEDLd
	YheknEKsBAT+dVdRZm0fdU/1fq24ZKAOH/8GSWM5yvVKbmaUAf8mjja/gY5/uCPbzldxGs
	U94WLL2hsj76HV75aJA8/EDHUTr2vxpwtUyblO6ADpiBhgvp6o2agzpWAZsRfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758553714;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uqHx+FCqfW/ilWKgNBamj/Qr2VHNuXNAIDaLW+7mwcs=;
	b=NomrlLZ0xFnGr84vqheRUSavDwqr6TL4XtEuV3Tyh38r/v8RBlSvzMkYKhUaCJHZEHZheP
	81iaetAQ1xgZjgCQ==
From: "tip-bot2 for Alexander Popov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/Kconfig: Reenable PTDUMP on i386
Cc: Alexander Popov <alex.popov@linux.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250921205819.332773-1-alex.popov@linux.com>
References: <20250921205819.332773-1-alex.popov@linux.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175855371001.709179.12697961090213182246.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     4f115596133fa168bac06bb34c6efd8f4d84c22e
Gitweb:        https://git.kernel.org/tip/4f115596133fa168bac06bb34c6efd8f4d8=
4c22e
Author:        Alexander Popov <alex.popov@linux.com>
AuthorDate:    Sun, 21 Sep 2025 23:58:15 +03:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 22 Sep 2025 14:40:17 +02:00

x86/Kconfig: Reenable PTDUMP on i386

The commit

  f9aad622006bd64c ("mm: rename GENERIC_PTDUMP and PTDUMP_CORE")

has broken PTDUMP and the Kconfig options that use it on ARCH=3Di386, includi=
ng
CONFIG_DEBUG_WX.

CONFIG_GENERIC_PTDUMP was renamed into CONFIG_ARCH_HAS_PTDUMP, but it was
mistakenly moved from "config X86" to "config X86_64". That made PTDUMP
unavailable for i386.

Move CONFIG_ARCH_HAS_PTDUMP back to "config X86" to fix it.

  [ bp: Massage commit message. ]

Fixes: f9aad622006bd64c ("mm: rename GENERIC_PTDUMP and PTDUMP_CORE")
Signed-off-by: Alexander Popov <alex.popov@linux.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 52c8910..0588030 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -26,7 +26,6 @@ config X86_64
 	depends on 64BIT
 	# Options that are inherently 64-bit kernel only:
 	select ARCH_HAS_GIGANTIC_PAGE
-	select ARCH_HAS_PTDUMP
 	select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
 	select ARCH_SUPPORTS_PER_VMA_LOCK
@@ -99,6 +98,7 @@ config X86
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PMEM_API		if X86_64
 	select ARCH_HAS_PREEMPT_LAZY
+	select ARCH_HAS_PTDUMP
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_HW_PTE_YOUNG
 	select ARCH_HAS_NONLEAF_PMD_YOUNG	if PGTABLE_LEVELS > 2

