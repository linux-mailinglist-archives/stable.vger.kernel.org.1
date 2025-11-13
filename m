Return-Path: <stable+bounces-194715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B18BC592DB
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 18:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61567500DFA
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 17:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8A93590A1;
	Thu, 13 Nov 2025 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JVN/txP2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OEthngAY"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CF82C21DF;
	Thu, 13 Nov 2025 17:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053623; cv=none; b=jYaRHO6SkSXnbBw8OlSF2svxAxBCKr9Z4UBbaA3hKYY3hPfxsa3VaRBmEI6hExl/HncuDH32PfFim4volkQOD62xgH1Cj/BdSGj44DnK32QHlxv4lnhT4hoWy2uReLke4Dn5vGagwlNnpzQ+TPf6wPkji6kdMw+mxGCU62F8oV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053623; c=relaxed/simple;
	bh=9dAaIOs3rAYPxGHSfIiOz3cQ+9IFBZ5qeehTd/g/Nu8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aEomJWESWapQGK/e+7H4aAMnQ4nmQOZEIkTT3KjJnmkwAwRn50P9852W1bXe9/5vLHnMXDQCLdwCjrlXyTD9FdjYjOOHOUaBgrihnm2JShiT19QLglaKTzyUZDcp3ACi2G23402n52ulgRMQtjgLsoFvcJWd+n+nLtaZy8J2lyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JVN/txP2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OEthngAY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763053618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T+nGnj7ZMz7mfV8MZgv8GRt6v8MVSGMnzy3RM2g4/2k=;
	b=JVN/txP2lVqxPSnDFNKVnZmX9SYMbgjUVG2H/ffOPpcQWrAh+UeTUZM37kagPNCWNZVmWR
	3tRef1eol4YSPXIHwEol2ipJbh+Xg42B4WbVoXlnqRuY0mrQ1MGq71k0pIptRIhvPMXGhD
	Vu8KqaTGFPX4UoUZAfLisk++h2yUXA/MEvg2Znq1PpF/7U6WA4gEox5kHmc4NJHN6W4EQq
	O5Deapou6qc9vRATpR8vcTlLYNS/kTaNeJTNdP+AbMddqnIY1H+NzBK0ow0xl5IpaaWNBy
	nE4vM4up4lGOjjPt0VyKRYqU/3TdVCK1lLBx3IJGHKIrPpizDlu+CvfM0c7rsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763053618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T+nGnj7ZMz7mfV8MZgv8GRt6v8MVSGMnzy3RM2g4/2k=;
	b=OEthngAYRUpCcUNQvf3H4PcDV5DuOVrCrZvvU9+kPpTbKmVSQf2xLMrV4pnpkRSlop7ol4
	0zbSPXn3QEwGAUDw==
To: debarbos@redhat.com
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, Sherry
 Sun <sherry.sun@nxp.com>, Jacky Bai <ping.bai@nxp.com>, Jon Hunter
 <jonathanh@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH printk v2 2/2] printk: Avoid scheduling irq_work on suspend
In-Reply-To: <jvn24vsnd2utypz33k33n3ol3ihh44tcyhcbtjhfxnepuvb7hn@qhcikbtwioyk>
References: <20251113160351.113031-1-john.ogness@linutronix.de>
 <20251113160351.113031-3-john.ogness@linutronix.de>
 <jvn24vsnd2utypz33k33n3ol3ihh44tcyhcbtjhfxnepuvb7hn@qhcikbtwioyk>
Date: Thu, 13 Nov 2025 18:12:57 +0106
Message-ID: <874iqxlv4e.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Derek,

On 2025-11-13, Derek Barbosa <debarbos@redhat.com> wrote:
> Thanks for this. I have recently have been seeing the same issue with a large-CPU
> workstation system in which the serial console been locking up entry/exit of S4
> Hibernation sleep state at different intervals.
>
> I am still running tests on the V1 of the series to determine reproducibility,
> but I will try to get this version tested in a timely manner as well.
>
> I did, however, test the proto-patch at [0]. The original issue was reproducible
> with this patch applied. Avoiding klogd waking in vprintk_emit() and the
> addition of the check in nbcon.c (new in this series) opposed to aborting
> callers outright seems more airtight.

I assume the problem you are seeing is with the PREEMPT_RT patches
applied (i.e. with the 8250-NBCON included). If that is the case, note
that recent versions of the 8250 driver introduce its own irq_work that
is also problematic. I am currently reworking the 8250-NBCON series so
that it does not introduce irq_work.

Since you probably are not doing anything related to modem control,
maybe you could test with the following hack (assuming you are using a
v6.14 or later PREEMPT_RT patched kernel).

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 96d32db9f8872..2ad0f91ad467a 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3459,7 +3459,7 @@ void serial8250_console_write(struct uart_8250_port *up,
 		 * may be a context that does not permit waking up tasks.
 		 */
 		if (is_atomic)
-			irq_work_queue(&up->modem_status_work);
+			;//irq_work_queue(&up->modem_status_work);
 		else
 			serial8250_modem_status(up);
 	}

> [0] https://github.com/Linutronix/linux/commit/ae173249d9028ef159fba040bdab260d80dda43f

John

