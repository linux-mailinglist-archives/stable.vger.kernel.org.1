Return-Path: <stable+bounces-47621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD26C8D32E4
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 11:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D8251F2474E
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 09:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09867169AE6;
	Wed, 29 May 2024 09:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="It8emVbG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HhD0qEXL"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B11A13E8BD;
	Wed, 29 May 2024 09:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716974752; cv=none; b=IzAcQ7ARyqBUribupaINx42hc+eHMdwYujcjkpkd9NCm6NP+zIkfab5Z1c4ECHRgzRkYViLp0P1iZRG5yuhbHOhgnhCIuelZ/dBPlKALIn/hLQBjGzq89kj1xEaUj+d4C3g2kcgVR/4gpqmQWYX53ChnxQ9qyv6biQPq9wkdMy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716974752; c=relaxed/simple;
	bh=G3edRpMzbg5HHY5drPrF6AcqvazAmZsmRfp8TMwv1rM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MS21Wb8YAKcmmW5JqWJh7e1doySQWsKKAnCFDLTSeCbQzB6W5Y2JRctSKKau0dIDapn4j9W8tBGsJT5pfZs3Gt1ar/ApWywYKwFkiDVStIBrsZmcqLiSGYDh7lGd8nQbIAieIGqd9AjoMqABuYp7rRUpQNQbnH/VvxomAbyGOXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=It8emVbG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HhD0qEXL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 May 2024 09:25:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716974749;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gYf6hhq55nlaV5z/0xlR1QSxXGDBh7E2b5APlc26He0=;
	b=It8emVbGlZJ/nSR4gCgU7iDA90/u7zQLMMOUR/rnqf0ooMMLRci5/BIbH3SAw1IjuZnUys
	iciuhVfbLrC1APxeF6v/bILif+XTO10hGbVOfBdYfq7MLZK2XkqGeGjEC9qSJHKHGpaKzJ
	sTmB8EeabVCQsv/uYPJfKFhEsd1zcR4ujngp6vEJ8+z6p4ZC7+PAhWLTJVcqruJPjiCTCK
	82+Wmw1085vB5Ji16wAZRIUYTwwqvO9sF8bEM5LuUsItyirqukPnFNZb1o/Wf/3EtRPsD5
	A7XBPrRKbUGeg2478l44MAOyCUcqJvfO4kcS52iJQ5JMXviiDO7vG5adyU16dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716974749;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gYf6hhq55nlaV5z/0xlR1QSxXGDBh7E2b5APlc26He0=;
	b=HhD0qEXLeDpOAI1XQdEvE8rEj9N9vJ7ACiB1m9rRBRAu4k/wv3lfy7ZCvf5ZVRw+TdZygw
	Izypo9GSxbFVFBBw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/topology/amd: Evaluate SMT in CPUID leaf
 0x8000001e only on family 0x17 and greater
Cc: Tim Teichmann <teichmanntim@outlook.de>,
 Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <7skhx6mwe4hxiul64v6azhlxnokheorksqsdbp7qw6g2jduf6c@7b5pvomauugk>
References: <7skhx6mwe4hxiul64v6azhlxnokheorksqsdbp7qw6g2jduf6c@7b5pvomauugk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171697474837.10875.6335609575452053884.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     76357cc192acd78b85d4c3380d07f139d906dfe8
Gitweb:        https://git.kernel.org/tip/76357cc192acd78b85d4c3380d07f139d906dfe8
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 28 May 2024 22:21:31 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 29 May 2024 11:01:20 +02:00

x86/topology/amd: Evaluate SMT in CPUID leaf 0x8000001e only on family 0x17 and greater

The new AMD/HYGON topology parser evaluates the SMT information in CPUID leaf
0x8000001e unconditionally while the original code restricted it to CPUs with
family 0x17 and greater.

This breaks family 0x15 CPUs which advertise that leaf and have a non-zero
value in the SMT section. The machine boots, but the scheduler complains loudly
about the mismatch of the core IDs:

  WARNING: CPU: 1 PID: 0 at kernel/sched/core.c:6482 sched_cpu_starting+0x183/0x250
  WARNING: CPU: 0 PID: 1 at kernel/sched/topology.c:2408 build_sched_domains+0x76b/0x12b0

Add the condition back to cure it.

  [ bp: Make it actually build because grandpa is not concerned with
    trivial stuff. :-P ]

Fixes: f7fb3b2dd92c ("x86/cpu: Provide an AMD/HYGON specific topology parser")
Closes: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issues/56
Reported-by: Tim Teichmann <teichmanntim@outlook.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Tim Teichmann <teichmanntim@outlook.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/7skhx6mwe4hxiul64v6azhlxnokheorksqsdbp7qw6g2jduf6c@7b5pvomauugk
---
 arch/x86/kernel/cpu/topology_amd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology_amd.c b/arch/x86/kernel/cpu/topology_amd.c
index d419dee..7d476fa 100644
--- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -84,9 +84,9 @@ static bool parse_8000_001e(struct topo_scan *tscan, bool has_topoext)
 
 	/*
 	 * If leaf 0xb is available, then the domain shifts are set
-	 * already and nothing to do here.
+	 * already and nothing to do here. Only valid for family >= 0x17.
 	 */
-	if (!has_topoext) {
+	if (!has_topoext && tscan->c->x86 >= 0x17) {
 		/*
 		 * Leaf 0x80000008 set the CORE domain shift already.
 		 * Update the SMT domain, but do not propagate it.

