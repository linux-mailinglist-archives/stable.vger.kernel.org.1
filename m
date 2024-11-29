Return-Path: <stable+bounces-95816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B68809DE793
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 14:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73FA0161D80
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 13:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB98E19CCEC;
	Fri, 29 Nov 2024 13:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DtPrP9oR"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C302A1990C1;
	Fri, 29 Nov 2024 13:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732887101; cv=none; b=gjvFhrxl55cOSK2k26RFS5GdenVGd3IRR+lz9RUqX6Aw4MmJqbIvJb9HAuEWk+ckApP0KIFtCiDpKXhnyqTcmNmhz2Dr10vrzDX79yAcaaEF2a//1W6ITTSd4Jxa5WQ8ThBPwKuf56TlhyX5YvK5BraIwVddMNBuP+BJL0fIUTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732887101; c=relaxed/simple;
	bh=TVF56yUixt/gS2om0wEACFTPzCeFFlAZUBAhnjZhioA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KoGnHsq+xLQMo6XU2sCvBBQpJ58QczdaXr+lxQP6cp0gzle2W2Ny3hELQ5JssIRpSq7cltINccm0kwokmPR4xBLwXJelxze3ilq83iEYth3ay+OwbH/4Z8Qk/R6e+vEJ74+3nKfWQIEzBszvdw7RWIsN65HgunInSGrVmqeXnPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DtPrP9oR; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 168C140E0275;
	Fri, 29 Nov 2024 13:31:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QyzO6poWvbnK; Fri, 29 Nov 2024 13:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1732887086; bh=1nB+GU9FO2NKW8BvfXaEwoGeBuQi6PQV1hY9JL2NLy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DtPrP9oRtajh/NuNxcL4t/dZCgldlAxiI4ndqEb6gXr9FIoQPC+I5cexnSZGVkDIv
	 rh1l0cq80SukLFopBCv9n+SDKSpXFmrMcAleLzSum9irRQevK3hRNPJ+yfAeV1q2Kb
	 7O+Kyy4w9KZ0dbeIR7ZVMBE0/haUpKi0PW79WasuUqIxBQXNkIS4GI18OhqfjdYedQ
	 pXbCjBLmurjsvtAUYKDh2mAzABsgd1V1GxURQw1+I+aTHOJ/iJ+8tgN9lo6g6CGcfZ
	 3k/Gk3wAnzJDqWjbp38SsrhvfPnFVgOYeBaWQRd1y3JGopIqeXnTVmtLOgEt+OEfl4
	 Qm2A00Y4TMhzbs9Txy7eyY1ywQEn14Tydph3XB6tukg27goVk8ldKcPhhHLKAPqXlx
	 /IaaMXaIj+rqdyPdEtib+4MpXjKkLz1WAd+FV8+Q00jlxXHptysaVfkrFEKIi2/m+3
	 ADe7Xf/7zzhtl3eewwVIBfLInPeq94ayoxHD4Y8fBKlcgll+V477vL7u3oiL0eb6a7
	 qDPMlGGNVxel1YZ83kAN12RF0Spv6h7dWj8YQi54FXikKq93T2ZnGpidJozoSSIR7d
	 1evDTMyKoh1WLGkg6tAVgVpSAxeGnc8H7GG15PiUtzv4ogg8RGYuoXFCQT0+NZCp1O
	 xLAC9kUtvYH2ALilTkEQJM2Q=
Received: from zn.tnic (p200300ea9736a103329c23fffEa6A903.dip0.t-ipconnect.de [IPv6:2003:ea:9736:a103:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 084ED40E0200;
	Fri, 29 Nov 2024 13:31:00 +0000 (UTC)
Date: Fri, 29 Nov 2024 14:30:54 +0100
From: Borislav Petkov <bp@alien8.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, puwen@hygon.cn, seanjc@google.com,
	kim.phillips@amd.com, jmattson@google.com, babu.moger@amd.com,
	peterz@infradead.org, rick.p.edgecombe@intel.com, brgerst@gmail.com,
	ashok.raj@intel.com, mjguzik@gmail.com, jpoimboe@kernel.org,
	nik.borisov@suse.com, aik@amd.com, vegard.nossum@oracle.com,
	daniel.sneddon@linux.intel.com, acdunlap@google.com,
	Erwan Velu <erwanaliasr1@gmail.com>, pavel@denx.de
Subject: Re: [PATCH AUTOSEL 5.15 11/12] x86/barrier: Do not serialize MSR
 accesses on AMD
Message-ID: <20241129133054.GCZ0nCDrwBN0wpjP4t@fat_crate.local>
References: <20240115232718.209642-1-sashal@kernel.org>
 <20240115232718.209642-11-sashal@kernel.org>
 <20241128115924.GAZ0hbHKsbtCixVqAe@fat_crate.local>
 <Z0iRzPpGvpeYzA4H@sashalap>
 <20241128164310.GCZ0idnhjpAV6wFWm6@fat_crate.local>
 <Z0kJHvesUl6xJkS7@sashalap>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z0kJHvesUl6xJkS7@sashalap>

On Thu, Nov 28, 2024 at 07:21:50PM -0500, Sasha Levin wrote:
> Suggestions welcome... I don't really insist on a massive flood and was
> mostly following what was the convention when I started doing this work.
> 
> I thought about cutting it down to one mail per commit, but OTOH I had
> folks complain often enough that they missed a mail or that it wasn't
> obvious enough.

I don't know. It is a lot of mail and I doubt people look at most of them but
it's not like cutting down the mails from stable will alleviate the general
firehose drinking situation so...

> It might be all those thanksgiving drinks, but I can't find it in
> 5.15... I see it was part of 6.7.6 and 6.6.18, but nothing older.

Sorry, I meant 6.6.

> The stable kernel rules allow for "notable" performance fixes, and we
> already added it to 6.6.

Frankly, I don't have anything smarter than "well, it needs to be decided on
a case-by-case basis." As Erwan confirms, it really brings perf improvements
for their use case. So I guess that's a reason good enough to backport it
everywhere.

But cutting a general rule about such patches...? Nope, I can't think of any
good one.

> No objection to adding it to older kernels...
> 
> Happy to do it after the current round of releases goes out.

Thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

