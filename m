Return-Path: <stable+bounces-87644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5169A9327
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 00:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6ACA1F23029
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 22:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E037D1FF031;
	Mon, 21 Oct 2024 22:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cSx5KWTL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c0wDeuB8"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46CF1FEFD2;
	Mon, 21 Oct 2024 22:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729548975; cv=none; b=RSjq+pxpc5EsRC86hIPbV6+jSldcxzYPAm19SO27saSc/FLr35CWGJ1d0wDoHUzyJt/AOgVKSfA8h9rItNaVbQZ30B+wonMg7TOIxfUYG5ZDBW3YTl6mckk23y8ARQAWQWi8e/iH3JS7MxQKhwmvQ4A+49PLGc/Jz1FmKwBkuZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729548975; c=relaxed/simple;
	bh=o/21IDi3z+3r/CfWZohnh+gwI8lcHwVWkH/yH95StvA=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=VOOf8tb0jgyKDQeod5TvzmWs0DZ6idZDO1xtJIIHqRQRBRO928D0zrrmVPbfIkr/33Z5tMfnZKHf6TxX1QQpI2uJ5rWIaxQJCV7TlA+ao7lIyFB+rhhYm8eQ5M56rXbFscDEHYEWHqsYZklcN0DgqDCd/ObS5tHKjgRe2M++rkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cSx5KWTL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c0wDeuB8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 21 Oct 2024 22:16:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729548970;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=F/VQH6ij6E//+e6oHqxact1RCWdlNziDjscxF7SHn/A=;
	b=cSx5KWTLQfVlVsanarHTdIPWf0b2r7oSvQGO8goTivqT115Hvof/Xo/jnfWgO1HDZhTxPY
	YalStZhRT2tYj63JDs+KOhWrwuLVX2Rz8h8ZionNCS/PldjTtDSwyfVbEXrh4XD24x5S2y
	ti5k2FeAeNIuASee2ZeAIADX9q2irKfg2XAdKP1a393Bm/aozcBKoVrTP2MsPZ/gTKIlYM
	5tkUkyuc9OFaCejjhyFGfP2ROkGLpgK6QWhUKOfJpHNlzq4l01dU2hQqMkNp7HyJYayqoV
	uEozhMY7ukCVrWrQYYIZA3DdeuXw7gNK/jR9f5Vh2bO7JGjX4ARULELTRkQM9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729548970;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=F/VQH6ij6E//+e6oHqxact1RCWdlNziDjscxF7SHn/A=;
	b=c0wDeuB8QM+B/AbKR/7i28++aq2WdmwkDQW5LAOVemEEL7dJyOOldKtA3pd0erhV5WbJZm
	WGc4Hzxbfui4cXDQ==
From: "tip-bot2 for Pawan Gupta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/lam: Disable ADDRESS_MASKING in most cases
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Sohil Mehta <sohil.mehta@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172954896978.1442.12851270945186118443.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     3267cb6d3a174ff83d6287dcd5b0047bbd912452
Gitweb:        https://git.kernel.org/tip/3267cb6d3a174ff83d6287dcd5b0047bbd912452
Author:        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
AuthorDate:    Tue, 23 Jan 2024 19:55:21 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 21 Oct 2024 15:05:43 -07:00

x86/lam: Disable ADDRESS_MASKING in most cases

Linear Address Masking (LAM) has a weakness related to transient
execution as described in the SLAM paper[1]. Unless Linear Address
Space Separation (LASS) is enabled this weakness may be exploitable.

Until kernel adds support for LASS[2], only allow LAM for COMPILE_TEST,
or when speculation mitigations have been disabled at compile time,
otherwise keep LAM disabled.

There are no processors in market that support LAM yet, so currently
nobody is affected by this issue.

[1] SLAM: https://download.vusec.net/papers/slam_sp24.pdf
[2] LASS: https://lore.kernel.org/lkml/20230609183632.48706-1-alexander.shishkin@linux.intel.com/

[ dhansen: update SPECULATION_MITIGATIONS -> CPU_MITIGATIONS ]

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc:stable@vger.kernel.org
Link: https://lore.kernel.org/all/5373262886f2783f054256babdf5a98545dc986b.1706068222.git.pawan.kumar.gupta%40linux.intel.com
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2852fcd..16354df 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2257,6 +2257,7 @@ config RANDOMIZE_MEMORY_PHYSICAL_PADDING
 config ADDRESS_MASKING
 	bool "Linear Address Masking support"
 	depends on X86_64
+	depends on COMPILE_TEST || !CPU_MITIGATIONS # wait for LASS
 	help
 	  Linear Address Masking (LAM) modifies the checking that is applied
 	  to 64-bit linear addresses, allowing software to use of the

