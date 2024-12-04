Return-Path: <stable+bounces-98559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E1C9E4614
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 21:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98874B2EF35
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 20:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6129418E025;
	Wed,  4 Dec 2024 20:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4tf4BXTQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zqgnsyej"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEF018DF73;
	Wed,  4 Dec 2024 20:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733344783; cv=none; b=r+R+6jveGFYZRdY36YvU3da7HwBlKoTVcSCNaORs/lU4Wmb0eupVsEtD8Ps2lOUXUZDBsew0YGbsek4NtGvHXdlzDAkrz0z7w+2dAcMFCK6jAE5Hx9z8fMTss4vonTQPcVPJCFWdN8LdmcpsrMcAMg2SWmm/ngmvyUSMWVnjNok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733344783; c=relaxed/simple;
	bh=pDdiHbg7YMuFBhEeFOZq5ZIOiaHXKRONzeydujOerIA=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=oK4gI+5PdMaHI3P+FO86ehnMfEqFtSf7XY+1ilrQwMEw3IUZyP/NaWbTXudKYEj21+fzcJycFycbODlG/lLOUzoohAFcB7Zfl/b9jDPu+FQEBhEERJ99wjteJ/AQcDtelkjH+UzN7qvRyawcSsoPIfujsfIs/aIXW3uiUbsz1i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4tf4BXTQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zqgnsyej; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 04 Dec 2024 20:39:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733344778;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=viqr1gJdUvq+kXsW3fBrILOLRWZvrsguOYnVoxewpKw=;
	b=4tf4BXTQyl5ddbUCS0QiCrvbUtEIEgtv1Rf4qCbSwgZxg8I9Y9MwtIpnF8a3EePSL+4y1R
	VgHALKgiFbM73ceS8/17Da0ctPsCJjMrLmXEKievyst23EpzU2MvN06c9nRL1mKS6fNrmu
	7R7jcGiIB0IA1P3GrvYGqSEG5G2Cyp9Q9CsdO/tD9iE3HjdHMJCT3hbOvmEJOm//zpGcNy
	6M46azSded5rOK+ZWkXCqHOaoxnwHb/YrOI17DWJaGhltWAfqRM9qiboA8dmn9MAJA1zgR
	mk62BhLKePuw8yXzSoGZhCeUmip1eK6jg0jxaUx/xCU36rM2s3g+DECOxmNYrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733344778;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=viqr1gJdUvq+kXsW3fBrILOLRWZvrsguOYnVoxewpKw=;
	b=Zqgnsyej0B8adR6DIzZL92Q1zikcmdqc421IxYv/ovW2dn2dP3H8FgwFRxaPoXFQZSNOln
	LDCrK8RL26g6jFAA==
From: "tip-bot2 for Len Brown" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu: Add Lunar Lake to list of CPUs with a
 broken MONITOR implementation
Cc: Len Brown <len.brown@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173334477712.412.14806732426864874461.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     c9a4b55431e5220347881e148725bed69c84e037
Gitweb:        https://git.kernel.org/tip/c9a4b55431e5220347881e148725bed69c84e037
Author:        Len Brown <len.brown@intel.com>
AuthorDate:    Tue, 12 Nov 2024 21:07:00 -05:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 04 Dec 2024 12:30:14 -08:00

x86/cpu: Add Lunar Lake to list of CPUs with a broken MONITOR implementation

Under some conditions, MONITOR wakeups on Lunar Lake processors
can be lost, resulting in significant user-visible delays.

Add Lunar Lake to X86_BUG_MONITOR so that wake_up_idle_cpu()
always sends an IPI, avoiding this potential delay.

Reported originally here:

	https://bugzilla.kernel.org/show_bug.cgi?id=219364

[ dhansen: tweak subject ]

Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc:stable@vger.kernel.org
Link: https://lore.kernel.org/all/a4aa8842a3c3bfdb7fe9807710eef159cbf0e705.1731463305.git.len.brown%40intel.com
---
 arch/x86/kernel/cpu/intel.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index d1de300..8ded9f8 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -555,7 +555,9 @@ static void init_intel(struct cpuinfo_x86 *c)
 	     c->x86_vfm == INTEL_WESTMERE_EX))
 		set_cpu_bug(c, X86_BUG_CLFLUSH_MONITOR);
 
-	if (boot_cpu_has(X86_FEATURE_MWAIT) && c->x86_vfm == INTEL_ATOM_GOLDMONT)
+	if (boot_cpu_has(X86_FEATURE_MWAIT) &&
+	    (c->x86_vfm == INTEL_ATOM_GOLDMONT ||
+	     c->x86_vfm == INTEL_LUNARLAKE_M))
 		set_cpu_bug(c, X86_BUG_MONITOR);
 
 #ifdef CONFIG_X86_64

