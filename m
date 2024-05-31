Return-Path: <stable+bounces-47776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 092E48D5F3D
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 12:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 386911C222E4
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 10:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A60143723;
	Fri, 31 May 2024 10:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zI2/dNii";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E0QquJ1L"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49A41422DA;
	Fri, 31 May 2024 10:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717150038; cv=none; b=ieEj4b43nou41uSiSvfxE0KAFW4vDXcoDtHTw1MdOgBj5irjpjKRGr38VKV4nZHhtrcUn5/LEANNS7NgmkceHRoR/yp9YFh2hj7E3h2JJ8CT5GyjjKLjtQRIth89KU5n2IZbpXvqBfIUKnt474JKHvcTDOgp8xnNZauJvyfrj5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717150038; c=relaxed/simple;
	bh=NMTU3pxi7UKcMSiTL7Ysh/AVfIuKQmazDHD/xsZGNfc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aV+4AksDwOL61aRp50evqVpGd1An5EI1n712GHlhTkQli6MiyefcK8TgramHF8q0byS902Upne4MNMX8OSz3E8sAOeORWHjJNcW3gmCPYL+FAcifIwIc6LIbAsW+tr9UyB4GHvXGF0oevdauZiCSehfesDTg9XN79bV+8BEsDfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zI2/dNii; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E0QquJ1L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717150034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YEhhT+5dH1vYGUO4W2LMvyfj5PkiRdgoZHd30AvP03A=;
	b=zI2/dNiiftJHjwSy2qBj/TkVOGN/az4z04M5u0rB5C+1zWjeQNXzkdrF3F725nvE1xopZa
	GX2SA9GyTBoeRm/xsGiOrTbxH37vPyQ0Es7Mnr0Vo3/MXF4kK7dO1t93E+zMIX5ujWublK
	zZqzLd5JAV6LdDEC8clsUSyB+m5mXYbwmNo3iMxFF6699mT6GbUS/CgQb5qOkV+7CiflP0
	hHIzrmhZiQyOyJYCWTRNLRE688nFPGSSe3zMsnj/9YDxnfreyO/x7NxHE1YvAdAXj0WDvh
	cC1ghZLN3hap/Tiea69Bu+RNrMKKK3+3/ubldgS/WdlEk1UVtrcU54VU2MLGgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717150034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YEhhT+5dH1vYGUO4W2LMvyfj5PkiRdgoZHd30AvP03A=;
	b=E0QquJ1LURRSgg3AIudbCUfBMHUXcoKDHNRPc0soIX51ytOK8+HZtPA0f5JPBbwmxm4rh0
	8ZhOjWIk3mC/z7AA==
To: Peter Schneider <pschneider1968@googlemail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
 stable@vger.kernel.org, regressions@lists.linux.dev, christian@heusel.eu
Subject: Re: Kernel 6.9 regression: X86: Bogus messages from topology detection
In-Reply-To: <087b4298-6564-40ad-a4fb-32dbb2f74a43@googlemail.com>
References: <877cffcs7h.ffs@tglx>
 <16cd76b1-a512-4a7b-a304-5e4e31af3c8a@googlemail.com>
 <ce3abe01-4c37-416e-a5ed-25703318318a@googlemail.com>
 <87zfs78zxq.ffs@tglx>
 <76b1e0b9-26ae-4915-920d-9093f057796b@googlemail.com>
 <87r0dj8ls4.ffs@tglx> <87o78n8fe2.ffs@tglx> <87le3r8dyw.ffs@tglx>
 <bd7ff2f3-bf2c-4431-9848-8eb41e7422c6@googlemail.com>
 <87ikyu8jp4.ffs@tglx> <87frty8j9p.ffs@tglx>
 <087b4298-6564-40ad-a4fb-32dbb2f74a43@googlemail.com>
Date: Fri, 31 May 2024 12:07:11 +0200
Message-ID: <87zfs670s0.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Peter!

On Fri, May 31 2024 at 11:41, Peter Schneider wrote:
> Anyway, this last version of your patch fixes things for me, please see attached dmesg 
> output. Thanks very much for investigating and fixing this issue!
>
> Tested-by: Peter Schneider <pschneider1968@googlemail.com>
>
> If you like, I can retest with your first patch (with additional debug
> info output) additionally applied on top of that and send the output,
> if that would be useful for you.

No need. I'm properly coffeiniated and confident enough that this cures
it. :)

Thanks a lot for testing and providing all the information!

       tglx

