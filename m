Return-Path: <stable+bounces-46112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4168CEC62
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 00:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70B352827E3
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 22:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DDE83A0D;
	Fri, 24 May 2024 22:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PtYXgeY7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2e+EaWXF"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630B91DFFC
	for <stable@vger.kernel.org>; Fri, 24 May 2024 22:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716589495; cv=none; b=k7aOUlfGUr9EZ4Se71KD5RZ0pp/smbrapSriTj5pPBqr3CLqhXgM65pSpcfMVt9dI5TgCU1i7CN3x/moKr8lHs8jZm7O+FU/F5gXyj1oEZM5APtCPT8vZi7P3v/II8Xaw1u6QzkxLBaHZ8ycQiskpoTLl2AVJUpy4ExK5kY14yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716589495; c=relaxed/simple;
	bh=63lP2BE8n97WrUvMFNuXZDmluVUINhLsU69ydORbcj4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=O3QIU8VRWgsc0/RgEbk0K0d1aeDU6GjmeTrJtaJQ695fA2fFtcDMIRKRrQyqo9/zgJwCvzr3juCQvMir/YDhKbu151Qudb4wTW3Wuo+BCmcbHK8zOexD0U6UH1TtJb2SOlu5O0D/o4FMXacWSSM7TSXHuOnuDI17DbACQlfOUCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PtYXgeY7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2e+EaWXF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716589492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=vAyHpd+y9wb9+Ocz3J2wtvwNRH9pDQmg+qXN/Gdmjq8=;
	b=PtYXgeY7Zg54I2ib9FZT8iMvuFutopiCf2OComj8TUA/tG4fMQNZ3bTOFVUPfrd7+PobE0
	QLxrTTdNuoFAN/C4ivieHLGw+ur8ctZ5UpuKW+poGpibZhzE/DjgTmr/wlrXuJSFxN2JMO
	q2H6dBX2CpaHsN/R7hlOStgQTap0qRJnYXWcZS5ZcBg9ZRXFx8CWDssje/ubD4raPOHXdb
	e95RVc+QP/UzxnIOCTOQwflr582FjbyUB19CzO60N51NcKO36HY0rr5k/XyxfMcoTIQIV5
	S7ywJdB4JsJb7EQEamLVG8he7lUdNRAk/GImTUOjOwRiyL8fsPwG/jEzQIrk8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716589492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=vAyHpd+y9wb9+Ocz3J2wtvwNRH9pDQmg+qXN/Gdmjq8=;
	b=2e+EaWXFKwNMErmkqcgQg6AjPwBTK5p+X1hwlTuj1LUYASk7GYgQ+tdPMhFAFfnIGm+t2K
	RlpwAZH1dLnWZ/CQ==
To: Christian Heusel <christian@heusel.eu>, regressions@lists.linux.dev
Cc: Tim Teichmann <teichmanntim@outlook.de>, x86@kernel.org,
 stable@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED] Scheduling errors with the AMD FX 8300 CPU
In-Reply-To: <7skhx6mwe4hxiul64v6azhlxnokheorksqsdbp7qw6g2jduf6c@7b5pvomauugk>
Date: Sat, 25 May 2024 00:24:52 +0200
Message-ID: <87r0dqdf0r.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian!

On Fri, May 24 2024 at 23:23, Christian Heusel wrote:
> Tim reports a regression on his AMD FX 8300 CPU that causes him
> scheduling errors (see dmesg below), initially on the latest stable
> kernel from Arch Linux. The issue reproduces by simply booting the
> kernel on his hardware. He also reported some ATA related errors (also
> attached below the dmesg), of which I dont know whether they are
> relevant or not.

I've earmarked this but I wont be able to look at it before monday. 

> May 23 23:36:49 archlinux kernel: smp: Bringing up secondary CPUs ...

Can you please provide the full boot log as the information which leads
up to the symptom is obviously more interesting than the symptom itself.

> May 23 23:36:49 archlinux kernel: smpboot: x86: Booting SMP configuration:
> May 23 23:36:49 archlinux kernel: .... node  #0, CPUs:      #2 #4 #6
> May 23 23:36:49 archlinux kernel: __common_interrupt: 2.55 No irq handler for vector
> May 23 23:36:49 archlinux kernel: __common_interrupt: 4.55 No irq handler for vector
> May 23 23:36:49 archlinux kernel: __common_interrupt: 6.55 No irq handler for vector
>
> ATA stuff:
>
> May 23 23:36:59 archlinux kernel: ata2.00: exception Emask 0x10 SAct 0x1fffe000 SErr 0x40d0002 action 0xe frozen

That's probably just the fallout of the above.

Thanks,

        tglx


