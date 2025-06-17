Return-Path: <stable+bounces-154589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4235EADDF1F
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 00:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01CF23B97DD
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 22:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FDE5383;
	Tue, 17 Jun 2025 22:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0jwcHq4L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="erEhegrm"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CA82F530A;
	Tue, 17 Jun 2025 22:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750200528; cv=none; b=KkRqnV/GxV2E6QUHPtlrnNg1lE4xQo6mUbUxMqZOmljOmE/QBfD+mDgD6RzL9I2dWCls+39NIitFEXsAj2Ko7R3hTLF7ju/jMBCxozf/HkmaxhjYv8BeCIh4X9SXiG3o3Gi8BnmmFn6/OQLOEQyCIJuiYlHHVpY3Ruhr12Z6jZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750200528; c=relaxed/simple;
	bh=WLGLQTVIgqKfMvH7cZE22O60ZqhkZeSYQX+e6y8Vul0=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=d7YCGHoM/UE7Xf9iVkjarI6aXXUuNhAzQ/CTy78HC8lP+CToo/q0LHZcbM7EKul2wm8wiyNjCDf4oA6VrouNL23waKtStG97ujo7hAxOqea4BHTS/M0nvbwIfaDBvZqoMNKI+pwy3MNmYqK+lRfGr8qou9lVE2OfsjTwD3OkjRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0jwcHq4L; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=erEhegrm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 17 Jun 2025 22:48:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750200519;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=8Jt4d++J7WmkVtX5Jd5uM8C/YcS02a+aJ7x6o3FCPk8=;
	b=0jwcHq4LvXVcQP82Elvm32OFBTr1NPFQTu2z5/SvsrGQPj6IsfdpBESc2VZo9PRm//FBbg
	aT+d7yk6bLHOi4SDs59JJcIAuaH+Fr7Jdj1IGs2nlvIT/0v9dV/xQYzKWhQ2mSGjy44t+F
	eSqEAWmkJORJ8vFcmJz2wW3U4vGXk7fcXJ+duzTRz1x9nY1pVNqkkY2031svLQ1EVzWVJf
	8POvlr9UkAHyzNQySvEOF6weantuJM1l0Ni+TVsXSSEnPwQeQ1Viw+AEb6RAgHLby0rEuq
	7zn4u1aE9eV505BjaYrnFyDxvE0HWrAwjZIUKrC2R2oqe+p+2TfHCfJAnf4xiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750200519;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=8Jt4d++J7WmkVtX5Jd5uM8C/YcS02a+aJ7x6o3FCPk8=;
	b=erEhegrm3LDd59mrq2W1J9JuWZIXJY6JZhiAHPjQg4x6qvokSz35wHKDGq7TRVmxHjiSFS
	NMH3VErB6whCnbDQ==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mm: Disable INVLPGB when PTI is enabled
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Rik van Riel <riel@surriel.com>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175020051852.406.9118520090678116143.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     94a17f2dc90bc7eae36c0f478515d4bd1c23e877
Gitweb:        https://git.kernel.org/tip/94a17f2dc90bc7eae36c0f478515d4bd1c23e877
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Tue, 10 Jun 2025 15:24:20 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 17 Jun 2025 15:36:57 -07:00

x86/mm: Disable INVLPGB when PTI is enabled

PTI uses separate ASIDs (aka. PCIDs) for kernel and user address
spaces. When the kernel needs to flush the user address space, it
just sets a bit in a bitmap and then flushes the entire PCID on
the next switch to userspace.

This bitmap is a single 'unsigned long' which is plenty for all 6
dynamic ASIDs. But, unfortunately, the INVLPGB support brings along a
bunch more user ASIDs, as many as ~2k more. The bitmap can't address
that many.

Fortunately, the bitmap is only needed for PTI and all the CPUs
with INVLPGB are AMD CPUs that aren't vulnerable to Meltdown and
don't need PTI. The only way someone can run into an issue in
practice is by booting with pti=on on a newer AMD CPU.

Disable INVLPGB if PTI is enabled. Avoid overrunning the small
bitmap.

Note: this will be fixed up properly by making the bitmap bigger.
For now, just avoid the mostly theoretical bug.

Fixes: 4afeb0ed1753 ("x86/mm: Enable broadcast TLB invalidation for multi-threaded processes")
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Rik van Riel <riel@surriel.com>
Cc:stable@vger.kernel.org
Link: https://lore.kernel.org/all/20250610222420.E8CBF472%40davehans-spike.ostc.intel.com
---
 arch/x86/mm/pti.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 1902998..c0c40b6 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -98,6 +98,11 @@ void __init pti_check_boottime_disable(void)
 		return;
 
 	setup_force_cpu_cap(X86_FEATURE_PTI);
+
+	if (cpu_feature_enabled(X86_FEATURE_INVLPGB)) {
+		pr_debug("PTI enabled, disabling INVLPGB\n");
+		setup_clear_cpu_cap(X86_FEATURE_INVLPGB);
+	}
 }
 
 static int __init pti_parse_cmdline(char *arg)

