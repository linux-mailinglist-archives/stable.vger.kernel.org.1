Return-Path: <stable+bounces-196607-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A52FCC7D84B
	for <lists+stable@lfdr.de>; Sat, 22 Nov 2025 22:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2869234710E
	for <lists+stable@lfdr.de>; Sat, 22 Nov 2025 21:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F4227CCE2;
	Sat, 22 Nov 2025 21:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tEDhDwsU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="koxvInjL"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB97123D7C8;
	Sat, 22 Nov 2025 21:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763848625; cv=none; b=YZUKa3DMYfvaNr/uo5rty9HxIywZOj6X1yuxj2Mul6/os8lUepz5FFoeDLFLTUSzapByPvG8xcPdmP1fx33H4dipy3GXRnDb4wryZHygPz6wSJkBPrum3ojy4ZAcLnK+5gW8Dhrk/jagjH6L2rObhS8AwtUqCBbU1pS0VLIbixQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763848625; c=relaxed/simple;
	bh=J+7JAnSP9bUprgQRaynkO3NFdNfvKEVHYXFm9zEit+0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=U/6vUkOg9WfnAi3/4CZFV2G4cstx752HwGOMD4k+Pm0H1p1q8+kM4+9IOJ63TJ7oiZEdHN+GYWLSXZBQA2cRs3X37knWebkRLEsm/gNS7YgcD5ssHbbs46onVSoKDoP4Z3XbNoGYV55WZ+rttu8XLf910Eg6HR7dvNV8ZuZHmaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tEDhDwsU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=koxvInjL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 22 Nov 2025 21:57:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763848621;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VBmFtYG+iLUHGHF5V6Busfs0QrMJ/FoTRd7IbKgT/i0=;
	b=tEDhDwsUdq00NialL4CdtPmCS3cbVl5B27lKnzBGLjs/QXPc9pRCTF6f5Y/N68UeRV6LCu
	CchwfVF3CZOUETjevVBXg74PIKimIZyatgo5EKEHLZXrFAmWiiYyhN3HVCmim6SSibNK4Y
	zYI0NAYNSXDWMGL2O09tOox6eEUXMrGlQxRPKWxK2+zqSffuNXrbLOdUXFIMqtyac6U755
	st/YahWU6tiFMd0U8xBS2ijs2lcPNrEQJBzAq43PdeQLhbOABdl772TyUk9bbEu6krjr/1
	cXceDikhYpSWqQIVGHbNx7oHL1TYDg+9Bh493VNdxTuyiy8D4+vnYgFQAXI5YA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763848621;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VBmFtYG+iLUHGHF5V6Busfs0QrMJ/FoTRd7IbKgT/i0=;
	b=koxvInjLlZnGdqPfIfObsmFyoeXO3+VTe24kxGu7Wv5qdd5m5aTvEtHWIRjQhojbELZBTV
	MJMxDPBkDKM2GKBw==
From: "tip-bot2 for Yipeng Zou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] timers: Fix NULL function pointer race in
 timer_shutdown_sync()
Cc: Yipeng Zou <zouyipeng@huawei.com>, Thomas Gleixner <tglx@linutronix.de>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251122093942.301559-1-zouyipeng@huawei.com>
References: <20251122093942.301559-1-zouyipeng@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176384862016.498.10720277913756598678.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     20739af07383e6eb1ec59dcd70b72ebfa9ac362c
Gitweb:        https://git.kernel.org/tip/20739af07383e6eb1ec59dcd70b72ebfa9a=
c362c
Author:        Yipeng Zou <zouyipeng@huawei.com>
AuthorDate:    Sat, 22 Nov 2025 09:39:42=20
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 22 Nov 2025 22:55:26 +01:00

timers: Fix NULL function pointer race in timer_shutdown_sync()

There is a race condition between timer_shutdown_sync() and timer
expiration that can lead to hitting a WARN_ON in expire_timers().

The issue occurs when timer_shutdown_sync() clears the timer function
to NULL while the timer is still running on another CPU. The race
scenario looks like this:

CPU0					CPU1
					<SOFTIRQ>
					lock_timer_base()
					expire_timers()
					base->running_timer =3D timer;
					unlock_timer_base()
					[call_timer_fn enter]
					mod_timer()
					...
timer_shutdown_sync()
lock_timer_base()
// For now, will not detach the timer but only clear its function to NULL
if (base->running_timer !=3D timer)
	ret =3D detach_if_pending(timer, base, true);
if (shutdown)
	timer->function =3D NULL;
unlock_timer_base()
					[call_timer_fn exit]
					lock_timer_base()
					base->running_timer =3D NULL;
					unlock_timer_base()
					...
					// Now timer is pending while its function set to NULL.
					// next timer trigger
					<SOFTIRQ>
					expire_timers()
					WARN_ON_ONCE(!fn) // hit
					...
lock_timer_base()
// Now timer will detach
if (base->running_timer !=3D timer)
	ret =3D detach_if_pending(timer, base, true);
if (shutdown)
	timer->function =3D NULL;
unlock_timer_base()

The problem is that timer_shutdown_sync() clears the timer function
regardless of whether the timer is currently running. This can leave a
pending timer with a NULL function pointer, which triggers the
WARN_ON_ONCE(!fn) check in expire_timers().

Fix this by only clearing the timer function when actually detaching the
timer. If the timer is running, leave the function pointer intact, which is
safe because the timer will be properly detached when it finishes running.

Fixes: 0cc04e80458a ("timers: Add shutdown mechanism to the internal function=
s")
Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20251122093942.301559-1-zouyipeng@huawei.com
---
 kernel/time/timer.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 553fa46..d5ebb1d 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1458,10 +1458,11 @@ static int __try_to_del_timer_sync(struct timer_list =
*timer, bool shutdown)
=20
 	base =3D lock_timer_base(timer, &flags);
=20
-	if (base->running_timer !=3D timer)
+	if (base->running_timer !=3D timer) {
 		ret =3D detach_if_pending(timer, base, true);
-	if (shutdown)
-		timer->function =3D NULL;
+		if (shutdown)
+			timer->function =3D NULL;
+	}
=20
 	raw_spin_unlock_irqrestore(&base->lock, flags);
=20

