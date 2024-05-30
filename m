Return-Path: <stable+bounces-47713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 310658D4D75
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 16:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97D69B23EE6
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 14:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C9F186E45;
	Thu, 30 May 2024 14:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CEHs+mnA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cU0klByx"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B5F186E32;
	Thu, 30 May 2024 14:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717077977; cv=none; b=YNi5PnfqjDqHzdIVLwVz0iOHxoPVfiiy+Iq5PUBERHc2Lc40Yz62j+oVGkjtQ6RYRrYdOO8xnSk5MY7w9yXAIG3a0Hfq7ZS5pYFpUWxdzNGQmDlb0orRyGb05593BCwkBnNXRsEh24cJMXeVeXq66OjgAROBNjnPCIuQyiKuNCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717077977; c=relaxed/simple;
	bh=YBMOAyCBcFgvcCBMtcMZvnXu+mAomOWGRZXqez9nBgo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YIR+tPIsNqxLuxrOwpGNoxUQIGf3l8hbT3WWhpaxrldDDARYLcu9s11xhHRZcZCPi1IsnLi6fAxlYDAs2TsJGUfL/cp7u6wod47CLKOCj9UdzL+7xeeGqRSZVoduOdeQ9ngO/QkAUkdRfnlRi/UIdirw+UwusCkri3NSQFZugMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CEHs+mnA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cU0klByx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 30 May 2024 14:06:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717077974;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OS8Id2nCSN/fXoy4VK7jJRP3GU3EeLv5GyCQcWx88mk=;
	b=CEHs+mnAAVC8qGnvr3qbcF2DSK0/4KvRrzUr5Ef2VlXFFUexXvbYA3PnZVMv8+PSLya4/0
	CJPoytpfOsZ1jPrudIPnpWSt0q07jQGqadHLwe+R+PK1K53cHZw6CpCktwBU+0G7magZQ4
	eqIMrY39DMMQQsPGuKv6/lCjCQcrRJHHhBzTikqlNCbvw/UGZvv514iMsrYWxLo4JlrE06
	iEHzlprolNe1SFA0QvEF5eatnE/xB/Nejil3DngoDxcm+4tBaEpxAvMPgWKucSIVWOTyy7
	VemRaKVqUhDCoJ8kmoIuUc0K1eQb30mRrO67Hog0XitDdne0DNuaD965q2eZtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717077974;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OS8Id2nCSN/fXoy4VK7jJRP3GU3EeLv5GyCQcWx88mk=;
	b=cU0klByxwrv7J+azJ440bpWNU2bM1NofpK7ebb6rOev19r9M9JsP4873I+4dx4+0jGKgFH
	B9dAQZ7GTXdIOhCA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/topology/amd: Evaluate SMT in CPUID leaf
 0x8000001e only on family 0x17 and greater
Cc: Tim Teichmann <teichmanntim@outlook.de>,
 Christian Heusel <christian@heusel.eu>, Thomas Gleixner <tglx@linutronix.de>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <7skhx6mwe4hxiul64v6azhlxnokheorksqsdbp7qw6g2jduf6c@7b5pvomauugk>
References: <7skhx6mwe4hxiul64v6azhlxnokheorksqsdbp7qw6g2jduf6c@7b5pvomauugk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171707797395.10875.8250870947985684035.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     34bf6bae3286a58762711cfbce2cf74ecd42e1b5
Gitweb:        https://git.kernel.org/tip/34bf6bae3286a58762711cfbce2cf74ecd42e1b5
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 28 May 2024 22:21:31 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 30 May 2024 15:58:55 +02:00

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
Reported-by: Christian Heusel <christian@heusel.eu>
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

