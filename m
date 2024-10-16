Return-Path: <stable+bounces-86497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD949A0AEA
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 15:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 255DC287147
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 13:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D506208D78;
	Wed, 16 Oct 2024 13:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MMoFT1/z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IXAy6QJJ"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021E02076D3;
	Wed, 16 Oct 2024 13:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729083673; cv=none; b=TjXr5EAAgkJOdtcdRe1VaVwFuWfPQULqUd9VLTvJZ0bkod3V0eWQbGC8h+KhI9DcxjaviZSRQCnCKUWjA0jbm7DcM3ChKowEZgZi4HzdDuH1em9SYEzXbEE29xymO6sqJHSHTDq9zKAyjwQGvajh3SdUt7yLxnpypL5F3zU1OF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729083673; c=relaxed/simple;
	bh=bYfp9+1y4YrjG9+X9wHOLY33jonU96f0HxrOazpEnUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+rM1VXZ/8nPysbyil0WeUG8da+GPfpbI+L+OyYMuaEYh2VhYGPle6MD79pCaYuumoVEqI5SlQqDdHCfIohbqNOOSELnvrJW+ivA52jfD09s+QOumSN+36WOQLvKJKZJmQFwexflQLkXWxEvq3tBRyqab4RUAc4CNueZtCwwD1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MMoFT1/z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IXAy6QJJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Oct 2024 15:01:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729083669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wfzEBRGmNU+FiyMdj/ozOziQYV9X5iY/Zqk64/75Cmw=;
	b=MMoFT1/zypkB6R35lMKgVfGeIrZrYUbmrpbomTwu9bsm9W4qNshC3ubQGojJfg0M/PT5gr
	NAWgc0USyWxgx6Bywx0Gqv+oaJr01jLQMH7uy9+Kc6cth/vZjLNlX3Y/iisCBflH6vdqjo
	oy2NlrgXS9PHN1ke/nmomD+cahGToadrZcegtj9XfFAs6UdEmoyn5i4Jcay0+853TLyVgi
	t169dlTy/4O/Ml16tavaK+2947U+RNpUzYSBQdqvBaV6UV+9fo4icnR2IYjzrAuElVIAA7
	XSPUbT7SwM2+SDxZTuV5FEwa9g+E1MFBG6p6+8/47Kf0zfIgW/ZWJZsjzhhi+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729083669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wfzEBRGmNU+FiyMdj/ozOziQYV9X5iY/Zqk64/75Cmw=;
	b=IXAy6QJJKnaA4BwiaPbjxPz3+3jXNDdantzQCZjOffhzHhARXgR/jCwL0ownXx3YSNGjuj
	fwviTSVaOPs/d7Dg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Willy Tarreau <w@1wt.eu>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	"Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc/stdlib: fix getenv() with empty environment
Message-ID: <20241016143300-a80ab677-e0bc-444e-9bfa-1670069b7a77@linutronix.de>
References: <20241016-nolibc-getenv-v1-1-8bc11abd486d@linutronix.de>
 <Zw+uxLIklMHSSxTu@1wt.eu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zw+uxLIklMHSSxTu@1wt.eu>

On Wed, Oct 16, 2024 at 02:17:08PM +0200, Willy Tarreau wrote:
> Hi Thomas!
> 
> On Wed, Oct 16, 2024 at 01:14:51PM +0200, Thomas Weißschuh wrote:
> > The environ pointer itself is never NULL, this is guaranteed by crt.h.
> > However if the environment is empty, environ will point to a NULL
> > pointer.
> 
> Good point, however from what I'm seeing on glibc, if the user sets
> environ to NULL, getenv() safely reports NULL and doesn't crash. I
> don't know what the spec says about environ being NULL, though. I
> just tested on freebsd to compare and also get a NULL in this case
> as well. So I'd be tempted by keeping the check.

Ah, environ being assignable is something I did not consider.

> >  	int idx, i;
> >  
> > -	if (environ) {
> > +	if (*environ) {
> >  		for (idx = 0; environ[idx]; idx++) {
> >  			for (i = 0; name[i] && name[i] == environ[idx][i];)
> >  				i++;
> 
> However as a quick note, if we decide we don't care about environ being
> NULL, and since this is essentially a cleanup, why not even get rid of
> the whole "if" condition, since the loop takes care of it ?

It's not only a cleanup.

Without this patch I see crashes due to illegal memory accesses.
Not reliably, only under special conditions and only on s390, but
crashes nevertheless.
It's the same binary with the same kernel that sometimes works and
sometimes crashes.
The proposed fix makes the issue go away.
But my original analysis looks wrong, I'll investigate some more.


User process fault: interruption code 0010 ilc:2 in test_nanosleep[43c4,1000000+8000]
Failing address: 0000000000000000 TEID: 0000000000000800
Fault in primary space mode while using user ASCE.
AS:0000000000d0c1c7 R3:0000000000d00007 S:0000000000000020
CPU: 0 UID: 0 PID: 30 Comm: test_nanosleep Tainted: G                 N 6.12.0-rc3-00054-geabcf2284b9c-dirty #104
Tainted: [N]=TEST
Hardware name: QEMU 8561 QEMU (KVM/Linux)
User PSW : 0705000180000000 00000000010043c4
           R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:1 AS:0 CC:0 PM:0 RI:0 EA:3
User GPRS: 0000000000000000 0000000000000000 000000000000004b 0000000000000000
           0000000000000001 0000000000000000 0000000000000000 0000000000000000
           0000000000000000 000003ffffaa0858 0000000000f9a6c0 000003fff59fa9c0
           0000000000000000 0000000001007430 00000000010064bc 000003fff59fa9c0
User Code: 00000000010043b4: e33010000004	lg	%r3,0(%r1)
           00000000010043ba: e310b0a80014	lgf	%r1,168(%r11)
          #00000000010043c0: b9080013		agr	%r1,%r3
          >00000000010043c4: 43101000		ic	%r1,0(%r1)
           00000000010043c8: a73800ff		lhi	%r3,255
           00000000010043cc: 1423		nr	%r2,%r3
           00000000010043ce: a73800ff		lhi	%r3,255
           00000000010043d2: 1413		nr	%r1,%r3
Last Breaking-Event-Address:
 [<000000000100435c>] test_nanosleep[435c,1000000+8000]


0000000001004320 <getenv>:
 1004320:	eb bf f0 58 00 24 	stmg	%r11,%r15,88(%r15)
 1004326:	a7 fb ff 50       	aghi	%r15,-176
 100432a:	b9 04 00 bf       	lgr	%r11,%r15
 100432e:	e3 20 b0 a0 00 24 	stg	%r2,160(%r11)
 1004334:	c0 10 00 00 21 76 	larl	%r1,1008620 <environ>
 100433a:	e3 10 10 00 00 04 	lg	%r1,0(%r1)
 1004340:	b9 02 00 11       	ltgr	%r1,%r1
 1004344:	a7 84 00 ad       	je	100449e <getenv+0x17e>
 1004348:	a7 18 00 00       	lhi	%r1,0
 100434c:	50 10 b0 ac       	st	%r1,172(%r11)
 1004350:	a7 f4 00 92       	j	1004474 <getenv+0x154>
 1004354:	a7 18 00 00       	lhi	%r1,0
 1004358:	50 10 b0 a8       	st	%r1,168(%r11)
 100435c:	a7 f4 00 08       	j	100436c <getenv+0x4c>
 1004360:	58 10 b0 a8       	l	%r1,168(%r11)
 1004364:	a7 1a 00 01       	ahi	%r1,1
 1004368:	50 10 b0 a8       	st	%r1,168(%r11)
 100436c:	e3 10 b0 a8 00 14 	lgf	%r1,168(%r11)
 1004372:	e3 10 b0 a0 00 08 	ag	%r1,160(%r11)
 1004378:	43 10 10 00       	ic	%r1,0(%r1)
 100437c:	a7 28 00 ff       	lhi	%r2,255
 1004380:	14 12             	nr	%r1,%r2
 1004382:	12 11             	ltr	%r1,%r1
 1004384:	a7 84 00 2b       	je	10043da <getenv+0xba>
 1004388:	e3 10 b0 a8 00 14 	lgf	%r1,168(%r11)
 100438e:	e3 10 b0 a0 00 08 	ag	%r1,160(%r11)
 1004394:	43 20 10 00       	ic	%r2,0(%r1)
 1004398:	c0 10 00 00 21 44 	larl	%r1,1008620 <environ>
 100439e:	e3 30 10 00 00 04 	lg	%r3,0(%r1)
 10043a4:	e3 10 b0 ac 00 14 	lgf	%r1,172(%r11)
 10043aa:	eb 11 00 03 00 0d 	sllg	%r1,%r1,3
 10043b0:	b9 08 00 13       	agr	%r1,%r3
 10043b4:	e3 30 10 00 00 04 	lg	%r3,0(%r1)
 10043ba:	e3 10 b0 a8 00 14 	lgf	%r1,168(%r11)
 10043c0:	b9 08 00 13       	agr	%r1,%r3
 10043c4:	43 10 10 00       	ic	%r1,0(%r1)
 10043c8:	a7 38 00 ff       	lhi	%r3,255
 10043cc:	14 23             	nr	%r2,%r3
 10043ce:	a7 38 00 ff       	lhi	%r3,255
 10043d2:	14 13             	nr	%r1,%r3
 10043d4:	19 21             	cr	%r2,%r1
 10043d6:	a7 84 ff c5       	je	1004360 <getenv+0x40>
 10043da:	e3 10 b0 a8 00 14 	lgf	%r1,168(%r11)
 10043e0:	e3 10 b0 a0 00 08 	ag	%r1,160(%r11)
 10043e6:	43 10 10 00       	ic	%r1,0(%r1)
 10043ea:	a7 28 00 ff       	lhi	%r2,255
 10043ee:	14 12             	nr	%r1,%r2
 10043f0:	12 11             	ltr	%r1,%r1
 10043f2:	a7 74 00 3b       	jne	1004468 <getenv+0x148>
 10043f6:	c0 10 00 00 21 15 	larl	%r1,1008620 <environ>
 10043fc:	e3 20 10 00 00 04 	lg	%r2,0(%r1)
 1004402:	e3 10 b0 ac 00 14 	lgf	%r1,172(%r11)
 1004408:	eb 11 00 03 00 0d 	sllg	%r1,%r1,3
 100440e:	b9 08 00 12       	agr	%r1,%r2
 1004412:	e3 20 10 00 00 04 	lg	%r2,0(%r1)
 1004418:	e3 10 b0 a8 00 14 	lgf	%r1,168(%r11)
 100441e:	b9 08 00 12       	agr	%r1,%r2
 1004422:	43 10 10 00       	ic	%r1,0(%r1)
 1004426:	a7 28 00 ff       	lhi	%r2,255
 100442a:	14 12             	nr	%r1,%r2
 100442c:	a7 1e 00 3d       	chi	%r1,61
 1004430:	a7 74 00 1c       	jne	1004468 <getenv+0x148>
 1004434:	c0 10 00 00 20 f6 	larl	%r1,1008620 <environ>
 100443a:	e3 20 10 00 00 04 	lg	%r2,0(%r1)
 1004440:	e3 10 b0 ac 00 14 	lgf	%r1,172(%r11)
 1004446:	eb 11 00 03 00 0d 	sllg	%r1,%r1,3
 100444c:	b9 08 00 12       	agr	%r1,%r2
 1004450:	e3 20 10 00 00 04 	lg	%r2,0(%r1)
 1004456:	e3 10 b0 a8 00 14 	lgf	%r1,168(%r11)
 100445c:	a7 1b 00 01       	aghi	%r1,1
 1004460:	b9 08 00 12       	agr	%r1,%r2
 1004464:	a7 f4 00 1f       	j	10044a2 <getenv+0x182>
 1004468:	58 10 b0 ac       	l	%r1,172(%r11)
 100446c:	a7 1a 00 01       	ahi	%r1,1
 1004470:	50 10 b0 ac       	st	%r1,172(%r11)
 1004474:	c0 10 00 00 20 d6 	larl	%r1,1008620 <environ>
 100447a:	e3 20 10 00 00 04 	lg	%r2,0(%r1)
 1004480:	e3 10 b0 ac 00 14 	lgf	%r1,172(%r11)
 1004486:	eb 11 00 03 00 0d 	sllg	%r1,%r1,3
 100448c:	b9 08 00 12       	agr	%r1,%r2
 1004490:	e3 10 10 00 00 04 	lg	%r1,0(%r1)
 1004496:	b9 02 00 11       	ltgr	%r1,%r1
 100449a:	a7 74 ff 5d       	jne	1004354 <getenv+0x34>
 100449e:	a7 19 00 00       	lghi	%r1,0
 10044a2:	b9 04 00 21       	lgr	%r2,%r1
 10044a6:	eb bf b1 08 00 04 	lmg	%r11,%r15,264(%r11)
 10044ac:	07 fe             	br	%r14

