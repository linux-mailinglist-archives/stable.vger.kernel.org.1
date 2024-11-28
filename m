Return-Path: <stable+bounces-95698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 728A99DB640
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 12:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 200B3164E21
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 11:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE513194A74;
	Thu, 28 Nov 2024 11:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cbEy/XSI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="do+HA9pX"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D869C192D82;
	Thu, 28 Nov 2024 11:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732792082; cv=none; b=nCFhK1Y2c9xwZTf2clwr4ogDkI4x6cmzkFkVBNb+Jl61a9p3bo7jVYe8E/QFGmitwrLAL+/oz89NAsEP3+FaR26jlglPf6GXKEPxZtcDm1a7M6GXEmVSKIKxopF9AiNpGfozBjgKbpDarQOX2aVRB1hPK61+NO5VTEkLDn3hwBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732792082; c=relaxed/simple;
	bh=8OV/+RhPfyvUachcUbgg6ACmykl00zvXmFN+CISQq8A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OzrAMhcFtZ+WzVD+l0RNVS0y0KpKs8AQ6B5jpUIwT016T0+bdcWcHHBjcL+ZCrh4l6j3ZvQZoZuvaaQz9hD5MBC/rHdFRaXir/SP9MHddrpEDjhj7EIwOGCdagZhnZeyQH0QDb8bI7QtJZGlqQQP+jUuVQbFp7bVQlsMlMZT60s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cbEy/XSI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=do+HA9pX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 28 Nov 2024 11:07:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732792078;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bO/GNKFrr2wZhrmREpgjYFqHi+It2Yxj+rYr6/1hJmk=;
	b=cbEy/XSIEJ3Wnqt1fqo19fyj1GDWSVt3fpacEnCx9PXZepynOd/BRIIi1jLrFujYuHmWiw
	FG4+v8KlW0yGuNQ4un0hlraWqv3ISsuFxAlzm+m1Oj91jTCg5TrhINW+PJ7/844w11CKqC
	NsjxNP5/Gfiwn551JlVUe6JbtRx6kRGrLHJqnNFG3PlqTiIIqnaTHqCp6VsD84QsoArC5L
	pgzxkFyCAl256zJZq3cbuKUbZm7pMDJO/9vG1maBCd0Qi8B+5BoAD32ykRIEOUU5kIfP9R
	0aq5Fqqkk8fQ6+kAeIpE5Sl7EBZZDPskQji9R+SXkNEk6KI/UcHtuc/0tRoo1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732792078;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bO/GNKFrr2wZhrmREpgjYFqHi+It2Yxj+rYr6/1hJmk=;
	b=do+HA9pX4V8tsNfrecu2ibQnwvOw6ci29RtZfhx/NRBhm3xlapZ7JgcOjaHF8G9Sz5MCeN
	Rf8t3wY8cFJlptAA==
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
Message-ID: <173279207753.412.15377961196958450230.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     f5807b0606da7ac7c1b74a386b22134ec7702d05
Gitweb:        https://git.kernel.org/tip/f5807b0606da7ac7c1b74a386b22134ec7702d05
Author:        Marcelo Dalmas <marcelo.dalmas@ge.com>
AuthorDate:    Mon, 25 Nov 2024 12:16:09 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 28 Nov 2024 12:02:38 +01:00

ntp: Remove invalid cast in time offset math

Due to an unsigned cast, adjtimex() returns the wrong offest when using
ADJ_MICRO and the offset is negative. In this case a small negative offset
returns approximately 4.29 seconds (~ 2^32/1000 milliseconds) due to the
unsigned cast of the negative offset.

This cast was added when the kernel internal struct timex was changed to
use type long long for the time offset value to address the problem of a
64bit/32bit division on 32bit systems.

The correct cast would have been (s32), which is correct as time_offset can
only be in the range of [INT_MIN..INT_MAX] because the shift constant used
for calculating it is 32. But that's non-obvious.

Remove the cast and use div_s64() to cure the issue.

[ tglx: Fix white space damage, use div_s64() and amend the change log ]

Fixes: ead25417f82e ("timex: use __kernel_timex internally")
Signed-off-by: Marcelo Dalmas <marcelo.dalmas@ge.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/SJ0P101MB03687BF7D5A10FD3C49C51E5F42E2@SJ0P101MB0368.NAMP101.PROD.OUTLOOK.COM
---
 kernel/time/ntp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index b550ebe..163e7a2 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -798,7 +798,7 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 
 		txc->offset = shift_right(ntpdata->time_offset * NTP_INTERVAL_FREQ, NTP_SCALE_SHIFT);
 		if (!(ntpdata->time_status & STA_NANO))
-			txc->offset = (u32)txc->offset / NSEC_PER_USEC;
+			txc->offset = div_s64(txc->offset, NSEC_PER_USEC);
 	}
 
 	result = ntpdata->time_state;

