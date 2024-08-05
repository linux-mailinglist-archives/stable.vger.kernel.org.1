Return-Path: <stable+bounces-65386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D138947CBC
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 16:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7B3E1F21D33
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 14:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE7713AD18;
	Mon,  5 Aug 2024 14:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xCXzZrER";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3gig/tZa"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CF013A3E4;
	Mon,  5 Aug 2024 14:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722867733; cv=none; b=n6hdFp21O/Lwzl0liARPDbWqfQ8KAEOhLjSThTOUV2MuhprSRWtORgTig/hVWTPWPiw7pyq2R4soXtvwNZt806mFx43crIzRNan/psAndig0bRejyQsroMYJ9Op3KdpaPBva2m/kZMyn/sVHjI5pSQw3si8BsHQxM9EeEaXIM3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722867733; c=relaxed/simple;
	bh=jyOgadAbgRp8LlSP+mM326NjeiSM8aUOiA1omn4ldJs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hN0r8hbMKW+JMZzOZMHjekv+cg5a7oVZjrgT5HEslNgESN6pW2DpePrVMK5MYPk34PJ+1wmOzaXuRbSPpWXAlJggO/6leqtsakd6MDEvwY7LSO337MgCJ+LukoPxqTiBLGF8Hc2ogzkfgletzeCGhTa1h6sgGejzDvK+KUPXsn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xCXzZrER; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3gig/tZa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Aug 2024 14:22:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722867729;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IA51O2hejSjpJYB2Z3AN5iVD0NKI82bW97I8fCeIC8o=;
	b=xCXzZrERCMuSbXeC4bsMuOnKhOhvJjnxMBPyGtX7eLWoZwp7XpF8sndTsXbqHJH4TmRsMh
	Y6s0H0FzfCAejarcnrgm60I53/SvbKgOeg4rRNj8Jnq25fPlZTJMFo9ipfmHr7EdivA3rY
	y/4NDy1+fmwzdsn9iQ0j3Hf7zGzkP0xPU/3NqOckK4zdwrybNRv1l3tZXeK3XZQkSM+6HM
	KNtyWMElQSN7oTnSn6HpP3zz/X7wbtg24pdoJ0vEL5nD8cz+xakTMGk2S8WsJIBZDXjZCc
	dWyJFynSv0wwR08tuOGd1eYqONBmlbBINXyyuC4QEMnKrVVXMAp+aSYYK4+IMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722867729;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IA51O2hejSjpJYB2Z3AN5iVD0NKI82bW97I8fCeIC8o=;
	b=3gig/tZakG/axklSkARpwkI5z3RGQCn5Nrf/V9UCnHZ/YnnjHO76Y+dw/vHHiAb47I0ro/
	X4/IBpPInRlRrGCw==
From: "tip-bot2 for Justin Stitt" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] ntp: Safeguard against time_constant overflow
Cc: Justin Stitt <justinstitt@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Miroslav Lichvar <mlichvar@redhat.com>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240517-b4-sio-ntp-c-v2-1-f3a80096f36f@google.com>
References: <20240517-b4-sio-ntp-c-v2-1-f3a80096f36f@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172286772947.2215.2079424255616133044.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     06c03c8edce333b9ad9c6b207d93d3a5ae7c10c0
Gitweb:        https://git.kernel.org/tip/06c03c8edce333b9ad9c6b207d93d3a5ae7c10c0
Author:        Justin Stitt <justinstitt@google.com>
AuthorDate:    Fri, 17 May 2024 00:47:10 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Aug 2024 16:14:14 +02:00

ntp: Safeguard against time_constant overflow

Using syzkaller with the recently reintroduced signed integer overflow
sanitizer produces this UBSAN report:

UBSAN: signed-integer-overflow in ../kernel/time/ntp.c:738:18
9223372036854775806 + 4 cannot be represented in type 'long'
Call Trace:
 handle_overflow+0x171/0x1b0
 __do_adjtimex+0x1236/0x1440
 do_adjtimex+0x2be/0x740

The user supplied time_constant value is incremented by four and then
clamped to the operating range.

Before commit eea83d896e31 ("ntp: NTP4 user space bits update") the user
supplied value was sanity checked to be in the operating range. That change
removed the sanity check and relied on clamping after incrementing which
does not work correctly when the user supplied value is in the overflow
zone of the '+ 4' operation.

The operation requires CAP_SYS_TIME and the side effect of the overflow is
NTP getting out of sync.

Similar to the fixups for time_maxerror and time_esterror, clamp the user
space supplied value to the operating range.

[ tglx: Switch to clamping ]

Fixes: eea83d896e31 ("ntp: NTP4 user space bits update")
Signed-off-by: Justin Stitt <justinstitt@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Miroslav Lichvar <mlichvar@redhat.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20240517-b4-sio-ntp-c-v2-1-f3a80096f36f@google.com
Closes: https://github.com/KSPP/linux/issues/352
---
 kernel/time/ntp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 502e1e5..8d2dd21 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -733,11 +733,10 @@ static inline void process_adjtimex_modes(const struct __kernel_timex *txc,
 		time_esterror = clamp(txc->esterror, 0, NTP_PHASE_LIMIT);
 
 	if (txc->modes & ADJ_TIMECONST) {
-		time_constant = txc->constant;
+		time_constant = clamp(txc->constant, 0, MAXTC);
 		if (!(time_status & STA_NANO))
 			time_constant += 4;
-		time_constant = min(time_constant, (long)MAXTC);
-		time_constant = max(time_constant, 0l);
+		time_constant = clamp(time_constant, 0, MAXTC);
 	}
 
 	if (txc->modes & ADJ_TAI &&

