Return-Path: <stable+bounces-47820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C91778D6EA4
	for <lists+stable@lfdr.de>; Sat,  1 Jun 2024 09:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA10D1C21C71
	for <lists+stable@lfdr.de>; Sat,  1 Jun 2024 07:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051EA17583;
	Sat,  1 Jun 2024 07:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G34B6l6p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9q/Ql5bb"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6B014F6C;
	Sat,  1 Jun 2024 07:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717226460; cv=none; b=n6D8vQRy2g+4MG+7LWu0rMqqKZByXVdkpPmvvbtWtW1QUB0HXCLQ9fOEpiyv1mW3s0snyNZXfetSlc4twVo1v7YqEwrndCVdmLiMBh0EkN1MUzbGDTeY8mjCuVkDohCUHRpR77tqzVgRBa4Ki/VrRJaDN92d2BD9o2fL5pyd7to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717226460; c=relaxed/simple;
	bh=nIJVZnemYSJymQwAgR9I3u8898f3WuAb/FTpYjyJLMU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=icMYx9N/9pphSzWyQGtQoOdK5Iswcj0CY8xB/mXKFoeJEIkQUHYQTC/AOZ9I6+gDMTPGB7YrPYnGwTDWJlmiugy/t0k2xD08OKyPGTsn8nxZ/3SVnCL0LwAZCmxPTjICFNh3lOEO4Yx4Ikwo7r/LMk0SHDApIkaW6mE3FDcc7aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G34B6l6p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9q/Ql5bb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717226457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LADDSgHl7x8uNhsWeAQXUeTw3+xJnL0w1xNgSzy+2QQ=;
	b=G34B6l6pxsUKoDTWInyt5t5AhuabXEewoZ/zNLT5cgXV984skmYcJHUTmZwnOg20WQpBjE
	CxVXGH/Gf3EvbcLp4dRYQTebEc/vwcpaZI3sgrUoVutN9B0xXCNAsczByNwR0maiKucF2c
	F4X9PvbGy7NDACM9O7JjAGszSU+jXauYcqxRG+WfBrM7FtSdennXWDMJYIf39qFxPdf1W+
	vSNGYu6eICyCVpwv3T6PiAJ5gH1xnGy+mF6UbNsLtCUiBDNQpmfEXpCX+7ohokePG6xR1U
	0UxPe1xzUPCHYb9AQOc2A3o96mbe2KaLv9dmK/KEFCc97oOX2robDQ+8neEUpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717226457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LADDSgHl7x8uNhsWeAQXUeTw3+xJnL0w1xNgSzy+2QQ=;
	b=9q/Ql5bbrkE/MyJdO0dqyaNiAuU3ue7oi2JykvNMTPGmnz5ARK7U24XFeICRpP+lS3Wh1D
	Gg38BzL5B/ABgtDA==
To: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>, Peter Schneider
 <pschneider1968@googlemail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
 stable@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: Kernel 6.9 regression: X86: Bogus messages from topology detection
In-Reply-To: <1e26effd-a142-44f5-9a72-90a823666d7c@leemhuis.info>
References: <877cffcs7h.ffs@tglx>
 <16cd76b1-a512-4a7b-a304-5e4e31af3c8a@googlemail.com>
 <ce3abe01-4c37-416e-a5ed-25703318318a@googlemail.com>
 <87zfs78zxq.ffs@tglx>
 <76b1e0b9-26ae-4915-920d-9093f057796b@googlemail.com>
 <87r0dj8ls4.ffs@tglx> <87o78n8fe2.ffs@tglx> <87le3r8dyw.ffs@tglx>
 <bd7ff2f3-bf2c-4431-9848-8eb41e7422c6@googlemail.com>
 <87ikyu8jp4.ffs@tglx> <87frty8j9p.ffs@tglx>
 <1e26effd-a142-44f5-9a72-90a823666d7c@leemhuis.info>
Date: Sat, 01 Jun 2024 09:20:56 +0200
Message-ID: <87mso56sdj.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 01 2024 at 09:06, Linux regression tracking (Thorsten Leemhuis)=
 wrote:
> On 31.05.24 10:42, Thomas Gleixner wrote:
>> On Fri, May 31 2024 at 10:33, Thomas Gleixner wrote:
>
>> ---
>> Subject: x86/topology/intel: Unlock CPUID before evaluating anything
>> From: Thomas Gleixner <tglx@linutronix.de>
>> Date: Thu, 30 May 2024 17:29:18 +0200
>>=20
>> Intel CPUs have a MSR bit to limit CPUID enumeration to leaf two. If this
>> bit is set by the BIOS then CPUID evaluation including topology enumerat=
ion
>> does not work correctly as the evaluation code does not try to analyze a=
ny
>> leaf greater than two.
>> [...]
>
> TWIMC, I noticed a bug report with a "12 =C3=97 12th Gen Intel=C2=AE Core=
=E2=84=A2
> i7-1255U" where the reporter also noticed a lot of messages like these:
>
> archlinux kernel: [Firmware Bug]: CPU4: Topology domain 1 shift 7 !=3D 6
> archlinux kernel: [Firmware Bug]: CPU4: Topology domain 2 shift 7 !=3D 6
> archlinux kernel: [Firmware Bug]: CPU4: Topology domain 3 shift 7 !=3D 6
>
> Asked the reporter to test this patch. For details see:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D218879

Won't help. See: https://lore.kernel.org/all/87plt26m2b.ffs@tglx/

Thanks,

        tglx


