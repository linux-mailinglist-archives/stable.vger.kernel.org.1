Return-Path: <stable+bounces-210465-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B53BD3C3DA
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 10:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4E5005264F9
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 09:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4CA3D2FF6;
	Tue, 20 Jan 2026 09:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="avH0471/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cipVfxpu"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988C9345724;
	Tue, 20 Jan 2026 09:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768901006; cv=none; b=E+Ss7mKMGs5EfbSL5UHe8vGyPp3+rCI3khAVUGi942SGUM7fUAXKx44fcD/IEtV/Pgwo7MWLwQy3K9/gax9eJmHCDyWFjqmEnWgeOJb4AHANDVyarHdqfIXxoH5QEiSufzCxstulZRQNDdnyQu6VcltuIjbriGvHARt50pf9CNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768901006; c=relaxed/simple;
	bh=HyD+fL7SYM9OsQlA3LSqyHgM1jCI93quzAyEzmLv5e0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NPvTLI8nP6sCfnZeEvMOBGEFFRvJsbZelIPveAtoFVRcT3SHHc+b2dwuaYNcTpIbeknNeHEZI5ycpGmw//Mn4q3q33zF2hJ5Hy6Gvo/AzZwAN420FUq9SCd3vgGRjJIvE0GTB9hhio1QQdRK1rn2I/rR5UMAQT9qNz2FBuZL2kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=avH0471/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cipVfxpu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 20 Jan 2026 09:23:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768901002;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kvqOS+MYn2Hv2wwFIg15+15KddzCharWpR5ItvqtH6I=;
	b=avH0471/ATNUe+VrtSVe8HGtjt9KCx/oEGTBZHwTvyj8XbluDEHj7opBVpty0RFBtEGiC+
	dmxwEsPshsHb7nBj59r9T7G0ebZqZtrPx7qKjBskslgND+9/MercbYHz5sKT+Fg3D/5+Z3
	PAzMl3OW0+OLfPx/1AJO+KGgUngYxOSXZJy0rRVi30cMD7W7hLzJ2qiCdBMklVGyYxYVNN
	vNvYzSQLL6LR5IPqvPh9CMJNJCtH8kqyRijZsnQIv1Q29KHQ9IWTd4VMmfSCcOrnGQ9oUq
	wOuMWZhx+YSWOjwGte5v9woMpeXK924gLvDO0xz+cshOfg7rOWjrDkbXD4f8RQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768901002;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kvqOS+MYn2Hv2wwFIg15+15KddzCharWpR5ItvqtH6I=;
	b=cipVfxpu01H/tjQFLZ0KXvR6lzV349+OW55yQfVfBFAM6HWPuNwFeqTP3dGrHJLv+Q5aQo
	lKXBMV0kjYZztbCw==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] timekeeping: Adjust the leap state for the
 correct auxiliary timekeeper
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <20260120-timekeeper-auxclock-leapstate-v1-1-5b358c6b3cfd@linutronix.de>
References:
 <20260120-timekeeper-auxclock-leapstate-v1-1-5b358c6b3cfd@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176890100118.510.15064772554358918022.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     e806f7dde8ba28bc72a7a0898589cac79f6362ac
Gitweb:        https://git.kernel.org/tip/e806f7dde8ba28bc72a7a0898589cac79f6=
362ac
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 20 Jan 2026 07:55:55 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 20 Jan 2026 10:18:53 +01:00

timekeeping: Adjust the leap state for the correct auxiliary timekeeper

When __do_ajdtimex() was introduced to handle adjtimex for any
timekeeper, this reference to tk_core was not updated. When called on an
auxiliary timekeeper, the core timekeeper would be updated incorrectly.

This gets caught by the lock debugging diagnostics because the
timekeepers sequence lock gets written to without holding its
associated spinlock:

WARNING: include/linux/seqlock.h:226 at __do_adjtimex+0x394/0x3b0, CPU#2: tes=
t/125
aux_clock_adj (kernel/time/timekeeping.c:2979)
__do_sys_clock_adjtime (kernel/time/posix-timers.c:1161 kernel/time/posix-tim=
ers.c:1173)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entr=
y/syscall_64.c:94 (discriminator 1))
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:131)

Update the correct auxiliary timekeeper.

Fixes: 775f71ebedd3 ("timekeeping: Make do_adjtimex() reusable")
Fixes: ecf3e7030491 ("timekeeping: Provide adjtimex() for auxiliary clocks")
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260120-timekeeper-auxclock-leapstate-v1-1-5b=
358c6b3cfd@linutronix.de
---
 kernel/time/timekeeping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 3ec3daa..91fa200 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2735,7 +2735,7 @@ static int __do_adjtimex(struct tk_data *tkd, struct __=
kernel_timex *txc,
 		timekeeping_update_from_shadow(tkd, TK_CLOCK_WAS_SET);
 		result->clock_set =3D true;
 	} else {
-		tk_update_leap_state_all(&tk_core);
+		tk_update_leap_state_all(tkd);
 	}
=20
 	/* Update the multiplier immediately if frequency was set directly */

