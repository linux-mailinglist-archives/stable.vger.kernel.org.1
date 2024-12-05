Return-Path: <stable+bounces-98840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE11E9E596A
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 16:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B26F163AAF
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 15:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7A021A44B;
	Thu,  5 Dec 2024 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MV2fnW5D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pAtQudwC"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D023621CA04;
	Thu,  5 Dec 2024 15:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733411489; cv=none; b=bwrIwymI/r6ixjovWt5sES3GISknnNqB3V9UT5N6e1N0CBBn483MuxeATeexDdRDR8kPpSMErcB8kDOLzdEbcEYea+p8Q9AlqOu4pmNQoWK4AYf0jiPfih5RNZ47bUT9OvjcuPj53i8MZKnZHbNGajiQjLvkf3lzFHjqHdznRuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733411489; c=relaxed/simple;
	bh=Sq6jRYQTtJtq4a9v2dcu2qQJEFwp4eTd++QkX8FU3IE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=k+Ek3v4yts5KTvHRWZ3DtF//C7TBAg3t7v89YEPwB+e5zOfyyKrKWRV8g6k5h+V94hFdJORPpq/18AocxlBmcvdQjgxwVU5CVj2IhGYxUCMsW0SkKd7k9lQXPJIrriclnnztOHEIOYLNLbnmG1M8jmCfnQ63qh+0tc2R20lUWao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MV2fnW5D; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pAtQudwC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 05 Dec 2024 15:11:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733411484;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/3evmt/wwu0x5ILAWnGy2Pr/MQdVOlutDLmcONA2AOM=;
	b=MV2fnW5DwL7imnkBguMzvO7K8vuwv+FIAlRBnvCHBAgoPSq8s2qi4z+3olHmiBqbN7unML
	un+Dze+R+H29EN50TkP2Mio2q+sLLJf/pB/J193C2SeSK7nnaPdYnc9+n2nc7NLkWsFMsw
	CoFOo9sP1RFLkTctPzhb13T3MTl5H7cHWtvmLA0ACPjLMiXHu4rlif8Gp1NeIGLxs3rwU9
	mP3LSQt8UPiK6dStRuUNqNTxRJzF7B+uocU6JA3We6BXJwKvWppu1nOnhfiBLuysYQkwqa
	USV9xM4S2XlSh+NTQvBKxwULSO+6cRPRZpfMIbFcIb5VVBobs3+oHnBPLEeW1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733411484;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/3evmt/wwu0x5ILAWnGy2Pr/MQdVOlutDLmcONA2AOM=;
	b=pAtQudwCvYYC9w52rseldAlwBwZ1m+ZGI5VS6o9kwTMNYTkOTf3FwyShTMbpYLwIiokyme
	Fmw9bXgiBukt8zCg==
From: "tip-bot2 for Fernando Fernandez Mancera" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu/topology: Remove limit of CPUs due to
 disabled IO/APIC
Cc: Fernando Fernandez Mancera <ffmancera@riseup.net>,
 Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241202145905.1482-1-ffmancera@riseup.net>
References: <20241202145905.1482-1-ffmancera@riseup.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173341148312.412.2519390948477165074.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     73da582a476ea6e3512f89f8ed57dfed945829a2
Gitweb:        https://git.kernel.org/tip/73da582a476ea6e3512f89f8ed57dfed945829a2
Author:        Fernando Fernandez Mancera <ffmancera@riseup.net>
AuthorDate:    Mon, 02 Dec 2024 14:58:45 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 05 Dec 2024 14:43:32 +01:00

x86/cpu/topology: Remove limit of CPUs due to disabled IO/APIC

The rework of possible CPUs management erroneously disabled SMP when the
IO/APIC is disabled either by the 'noapic' command line parameter or during
IO/APIC setup. SMP is possible without IO/APIC.

Remove the ioapic_is_disabled conditions from the relevant possible CPU
management code paths to restore the orgininal behaviour.

Fixes: 7c0edad3643f ("x86/cpu/topology: Rework possible CPU management")
Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20241202145905.1482-1-ffmancera@riseup.net
---
 arch/x86/kernel/cpu/topology.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 621a151..b2e313e 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -428,8 +428,8 @@ void __init topology_apply_cmdline_limits_early(void)
 {
 	unsigned int possible = nr_cpu_ids;
 
-	/* 'maxcpus=0' 'nosmp' 'nolapic' 'disableapic' 'noapic' */
-	if (!setup_max_cpus || ioapic_is_disabled || apic_is_disabled)
+	/* 'maxcpus=0' 'nosmp' 'nolapic' 'disableapic' */
+	if (!setup_max_cpus || apic_is_disabled)
 		possible = 1;
 
 	/* 'possible_cpus=N' */
@@ -443,7 +443,7 @@ void __init topology_apply_cmdline_limits_early(void)
 
 static __init bool restrict_to_up(void)
 {
-	if (!smp_found_config || ioapic_is_disabled)
+	if (!smp_found_config)
 		return true;
 	/*
 	 * XEN PV is special as it does not advertise the local APIC

