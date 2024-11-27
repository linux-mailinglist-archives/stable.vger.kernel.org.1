Return-Path: <stable+bounces-95627-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4899DA9DE
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 15:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AE1F281BEE
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 14:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC2C1FCD1E;
	Wed, 27 Nov 2024 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FtwH6dmI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O7CQAmPL"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496A926AD0;
	Wed, 27 Nov 2024 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732717871; cv=none; b=oaMkyYX9Uh4QlvXU7qo/GIeH7vVEXXFJGUY1BJ/7Dyk1rxw+YvdSVqGPC8mkRU1lyNtt0iLLPGl44vAfqBYlN+XChGVlijK5UaZfwaCOo4/Q2NIZ4//Zkff4WjWRR9Bu1zgN7vU8ZiKrfoBzEi3P7dmuzossVXA+321YJqJTxVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732717871; c=relaxed/simple;
	bh=SbWvi8b3kQtxd0QIMyleExujGM9/6bgLGFH9pA41o+U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dd0GmmSp98OitCMu41vor2QIsxJfwWgg6m3n8bzf3FxERNSJhLGcv5lsrRWiXlZt1VTygkhVF9R15X5RNy9FGo+zcRPwlD5TbA0m/vqCStXf+mtRgZuJe5l7WRffgPzuPZEb0c0TJVzVaExNBDRrQjSAjLTPvAw3XkSkp//Bao8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FtwH6dmI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O7CQAmPL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 27 Nov 2024 14:31:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732717867;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W860JXMaS5h6j69idQvjzaaXJ1b9J9Sr1Z08VvEaE34=;
	b=FtwH6dmI8cJppsphir/G/FF3qdH+PLcj2d8+wUvaeAzkqxF7RaJ08Ok5ODfFhjVD6/FmwY
	JJeiW/QupH4NwHTHTPAcv5hSbVNfd5fsMyEh0bXHiaAiGbNkwm5gYUd5RcC2tzPSjK/Bw4
	m+DJ8ckWGrpS6sS2fR3hHCbaTwKaE4dKUkgoaEyx7SkRQm3CSGgr+Sa7/YUcTe6tcUCKJ6
	b2xRisHax1n+yWgnxw31OyJSF8Qq5THitPKN3bsEryHTn+/4BAPhxoeGC+I/oD5S1RzYDp
	v35CGwSro9r0SciEE7enssLtRUnqAAuZ0FsREN3WW58h9YGvPcqyih8NKujY8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732717867;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W860JXMaS5h6j69idQvjzaaXJ1b9J9Sr1Z08VvEaE34=;
	b=O7CQAmPLPLP+fK/6dSDTlHBs3K7yHJ46ftlWTk9ePg4I9ERi6ZRXVkga3wRuc4dY3JLdCK
	KTbu89C2PhlkA+DA==
From: "tip-bot2 for Marcelo Dalmas" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] ntp: Remove invalid cast in time offset math
Cc: Marcelo Dalmas <marcelo.dalmas@ge.com>,
 Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3CSJ0P101MB03687BF7D5A10FD3C49C51E5F42E2=40SJ0P101MB?=
 =?utf-8?q?0368=2ENAMP101=2EPROD=2EOUTLOOK=2ECOM=3E?=
References: =?utf-8?q?=3CSJ0P101MB03687BF7D5A10FD3C49C51E5F42E2=40SJ0P101M?=
 =?utf-8?q?B0368=2ENAMP101=2EPROD=2EOUTLOOK=2ECOM=3E?=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173271786637.412.11744400812569588652.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     299130166e70124956c865a66a3669a61db1c212
Gitweb:        https://git.kernel.org/tip/299130166e70124956c865a66a3669a61db1c212
Author:        Marcelo Dalmas <marcelo.dalmas@ge.com>
AuthorDate:    Mon, 25 Nov 2024 12:16:09 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 27 Nov 2024 15:18:45 +01:00

ntp: Remove invalid cast in time offset math

Due to an unsigned cast, adjtimex() returns the wrong offest when using
ADJ_MICRO and the offset is negative. In this case a small negative offset
returns approximately 4.29 seconds (~ 2^32/1000 milliseconds) due to the
unsigned cast of the negative offset.

Remove the cast and restore the signed division to cure that issue.

Fixes: ead25417f82e ("timex: use __kernel_timex internally")
Signed-off-by: Marcelo Dalmas <marcelo.dalmas@ge.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/SJ0P101MB03687BF7D5A10FD3C49C51E5F42E2@SJ0P101MB0368.NAMP101.PROD.OUTLOOK.COM
---
 kernel/time/ntp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index b550ebe..02e7fe6 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -798,7 +798,7 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 
 		txc->offset = shift_right(ntpdata->time_offset * NTP_INTERVAL_FREQ, NTP_SCALE_SHIFT);
 		if (!(ntpdata->time_status & STA_NANO))
-			txc->offset = (u32)txc->offset / NSEC_PER_USEC;
+			txc->offset /= NSEC_PER_USEC;
 	}
 
 	result = ntpdata->time_state;

