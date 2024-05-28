Return-Path: <stable+bounces-47590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F8A8D25B3
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 22:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7F9A1C23448
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 20:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BD5179201;
	Tue, 28 May 2024 20:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1KK6qtsy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="onkV9rr1"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9446C1327E5;
	Tue, 28 May 2024 20:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716927695; cv=none; b=TvCje1adDESTwDIkKrmDbJcFTrsqxg+gEomgTKd76UPHUYr5Fmqsk1WLa6nItW2bk2AvWo7xCY5vFP8nJFiLCO3PaiB6jH/mTbzyMKnCccpVgplMgIcuHy69e/D8WhNVJXMX5Xb2vbKV2RhTOEUf4ICb8TkMRFw76gl9uoON/sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716927695; c=relaxed/simple;
	bh=4FCBurm5/GQckynXeIquujhqJWTZpUak7MuyxMQJ6j0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nXqTbew9u39yaMUAJk1TBUlur8CIQbarOx8xMV3lvunbxdk24jXIMTU/3wnTvmnGHM/EkahlphV4BsiInkfRwArCTQbgct72nHnQeEgUQMzt4SnQoBk0EacbVr4cgU4hr6FSC2f0Dp4RhJpLjuPwijheVC7BOLZjqJrHYpwm0yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1KK6qtsy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=onkV9rr1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716927692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mPuiTTglKo245MRT1O0rauosEqwWPFYkeow/Wj3djDI=;
	b=1KK6qtsycWyZWGYpIomFB0szOY8nGoEB5Ho2mCbA55fKgFaSs7RGX7qObRS4Vr34H2NNL4
	dTwHaRTjwRAbT0K+qmfcYYSQZpB+bqLPieRrry5oZF/ioD/3tCkzpqeJ5bdd8LKSNmQYcJ
	lVUTg785uzh3QYihRvdMb4wCcU1ZRclkHfXho+rO7iTqZhoygmvPpQwfSzAI4ge6eQtbB3
	6ijCTEommEj3xsH0wYBjzH6OBeQA/IY314vhiUTDsTdEkoE0cY3XdFPrr9XWMmjtqHRCSM
	KYrcPKFN0IN/79Gc1nT/L6YiSu818F1V7SGe8bdc6jNyGjNwUd0R8YhHMtbyqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716927692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mPuiTTglKo245MRT1O0rauosEqwWPFYkeow/Wj3djDI=;
	b=onkV9rr1RYQxxpwZ1a6f5K/ty3kcZzvXUY/KzPXc+FfHSSIyW8BLZEm05H8keZCjPhNA5Z
	RSv5pSbMZXKyOYBg==
To: Tim Teichmann <teichmanntim@outlook.de>
Cc: Christian Heusel <christian@heusel.eu>, regressions@lists.linux.dev,
 x86@kernel.org, stable@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>
Subject: [PATCH Resend] x86/topology/amd: Evaluate SMT in CPUID leaf 0x8000001e
 only on family 0x17 and greater
In-Reply-To: <87bk4pbve8.ffs@tglx>
References: <7skhx6mwe4hxiul64v6azhlxnokheorksqsdbp7qw6g2jduf6c@7b5pvomauugk>
 <87r0dqdf0r.ffs@tglx>
 <gtgsklvltu5pzeiqn7fwaktdsywk2re75unapgbcarlmqkya5a@mt7pi4j2f7b3>
 <87h6ejd0wt.ffs@tglx>
 <PR3PR02MB6012CB03006F1EEE8E8B5D69B3F02@PR3PR02MB6012.eurprd02.prod.outlook.com>
 <874jajcn9r.ffs@tglx>
 <PR3PR02MB6012EDF7EBA8045FBB03C434B3F02@PR3PR02MB6012.eurprd02.prod.outlook.com>
 <87msobb2dp.ffs@tglx>
 <PR3PR02MB6012D4B2D513F6FA9D29BE5EB3F12@PR3PR02MB6012.eurprd02.prod.outlook.com>
 <87bk4pbve8.ffs@tglx>
Date: Tue, 28 May 2024 22:21:31 +0200
Message-ID: <8734q1bsc4.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The new AMD/HYGON topology parser evaluates the SMT information in CPUID
leaf 0x8000001e unconditionally while the original code restricted it to
CPUs with family 0x17 and greater.

This breaks family 0x15 CPUs which advertise that leaf and have a non-zero
value in the SMT section. The machine boots, but the scheduler complains
loudly about the mismatch of the core IDs:

  WARNING: CPU: 1 PID: 0 at kernel/sched/core.c:6482 sched_cpu_starting+0x183/0x250
  WARNING: CPU: 0 PID: 1 at kernel/sched/topology.c:2408 build_sched_domains+0x76b/0x12b0

Add the condition back to cure it.

Fixes: f7fb3b2dd92c ("x86/cpu: Provide an AMD/HYGON specific topology parser")
Reported-by: Tim Teichmann <teichmanntim@outlook.de>
Bisected-by: Christian Heusel <christian@heusel.eu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tim Teichmann <teichmanntim@outlook.de>
Cc: regressions@lists.linux.dev
Cc: stable@vger.kernel.org
Closes: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issues/56
---
Resend with LKML in Cc. Sorry for the noise.
---
 arch/x86/kernel/cpu/topology_amd.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -84,9 +84,9 @@ static bool parse_8000_001e(struct topo_
 
 	/*
 	 * If leaf 0xb is available, then the domain shifts are set
-	 * already and nothing to do here.
+	 * already and nothing to do here. Only valid for family >= 0x17.
 	 */
-	if (!has_topoext) {
+	if (!has_topoext && c->x86 >= 0x17) {
 		/*
 		 * Leaf 0x80000008 set the CORE domain shift already.
 		 * Update the SMT domain, but do not propagate it.

