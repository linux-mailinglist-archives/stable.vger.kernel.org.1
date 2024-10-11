Return-Path: <stable+bounces-83494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3621499AD62
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 22:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E03DF1F2326E
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 20:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD491D0F49;
	Fri, 11 Oct 2024 20:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sOH42nxD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+9yrveOF"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984721D0E31;
	Fri, 11 Oct 2024 20:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728677218; cv=none; b=BzTqqQlgTKiwWtD/3B4EgJbo2osiqmRor8pedYig16EvWZKfhOfdKHearoOFzJqbT5In/tVRTfvvEv0ZnjJeZxBw8guQSULSPIWa5BZw+HpCJlcydoqSFEhhlpq3/Tu0GRytGFbm5T2Zl/yyK+Hv87KibHK4CywDDWNM5FO1qzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728677218; c=relaxed/simple;
	bh=K4NFDaVMqSvhO5UPG0njKAADKAdH4s4eTbh470068pU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lRwclnw6xQ06tApzfWJNJpj8x9pD+jtIYifz0xYhT9qd3DSH3eSIofcp8dSavDT0SYqX3hKHRuUzGECPgfZA9fgdyRPwl9I38BXToZApJpEYdeqfaajVC1A9DWHfHPzaefa08LU2Ga5Kt3j3TMFwpZTyZjeAYKp71P6cRFzjRuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sOH42nxD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+9yrveOF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Oct 2024 20:06:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728677214;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O6YoijyObT8ReADpfMLx+GfJd1671L6ikf5LVxtZnsA=;
	b=sOH42nxDr8jiYZ9xN4VIESqy4kkLv4BNpIgX1tSoNfzMPTtxXDqmw5IklzyHNVoXbdzyHU
	00TeICh/phEPFOtpUXJzeurteo6jptKmY93s2WaHVJYrVNIy3qHlODlhX2/bFcgm1nD/3Q
	nMgodxmZtcXMWrwZ5mMI6iw4KSvGSFK2bYculGMWKG/CJS0emYN1VILrJzpAVbgE3ZXc5U
	xesC9YBSOTNlfWmgomSIqSnz6L7e9O29a+SSf/gTIPCOh+GwE4Nn40r/rwnUJmK2eQYnrb
	zBlXdSYu+mCb5yrTj1g3sKFLI6YVucWDPfHBmRPlZXTbkW8R4XBHLArGFVAwTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728677214;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O6YoijyObT8ReADpfMLx+GfJd1671L6ikf5LVxtZnsA=;
	b=+9yrveOFJSAez7CL9Sk0giV7ZUR6qyhaYoN9Yne+Mz+EjNYGXPMgdCqgNFcdjUnIfbqhmM
	5vQlOrCxWcJMsfAw==
From: "tip-bot2 for John Allen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/CPU/AMD: Only apply Zenbleed fix for Zen2
 during late microcode load
Cc: John Allen <john.allen@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
  <stable@vger.kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240923164404.27227-1-john.allen@amd.com>
References: <20240923164404.27227-1-john.allen@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172867720706.1442.1034024383169751360.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     ee4d4e8d2c3bec6ee652599ab31991055a72c322
Gitweb:        https://git.kernel.org/tip/ee4d4e8d2c3bec6ee652599ab31991055a72c322
Author:        John Allen <john.allen@amd.com>
AuthorDate:    Mon, 23 Sep 2024 16:44:04 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 11 Oct 2024 21:26:45 +02:00

x86/CPU/AMD: Only apply Zenbleed fix for Zen2 during late microcode load

Commit

  f69759be251d ("x86/CPU/AMD: Move Zenbleed check to the Zen2 init function")

causes a bit in the DE_CFG MSR to get set erroneously after a microcode late
load.

The microcode late load path calls into amd_check_microcode() and subsequently
zen2_zenbleed_check(). Since the above commit removes the cpu_has_amd_erratum()
call from zen2_zenbleed_check(), this will cause all non-Zen2 CPUs to go
through the function and set the bit in the DE_CFG MSR.

Call into the Zenbleed fix path on Zen2 CPUs only.

  [ bp: Massage commit message, use cpu_feature_enabled(). ]

Fixes: f69759be251d ("x86/CPU/AMD: Move Zenbleed check to the Zen2 init function")
Signed-off-by: John Allen <john.allen@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20240923164404.27227-1-john.allen@amd.com
---
 arch/x86/kernel/cpu/amd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 015971a..fab5cae 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1202,5 +1202,6 @@ void amd_check_microcode(void)
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
 		return;
 
-	on_each_cpu(zenbleed_check_cpu, NULL, 1);
+	if (cpu_feature_enabled(X86_FEATURE_ZEN2))
+		on_each_cpu(zenbleed_check_cpu, NULL, 1);
 }

