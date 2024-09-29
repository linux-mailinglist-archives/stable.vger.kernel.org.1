Return-Path: <stable+bounces-78206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CE2989350
	for <lists+stable@lfdr.de>; Sun, 29 Sep 2024 08:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDE99285AB4
	for <lists+stable@lfdr.de>; Sun, 29 Sep 2024 06:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671D7137772;
	Sun, 29 Sep 2024 06:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="I44kMcGX"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5927128E37;
	Sun, 29 Sep 2024 06:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727592097; cv=none; b=BWV4I0sDBOaEOglKs+x+adDY9sG8RUGWDgkQk9r5nUBn3K2GUaGvft1iSKySC+aIElfE8XXsodLWV5EHEnAaVCoXZcDlKSb4yFu5r/g54415GTGgASSRga/yBVevDSLvXk1tNxgt2B7yc6ute679Wv05Hl3MurtsOE+lsx4srMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727592097; c=relaxed/simple;
	bh=mlRKFJzlJGGf7SYJivn22/YB5fqswy9nAEADlLxOGes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gErw2ITyxtMEjNZ/JIoRwwLgf+tS7Bc0fKH8AxLTg4iVZw1+yHcfNJJXKQAcKLE8zbrGjr7i8menVwAdqcann5Deaaytrx2b9MDQBC3JNxhrfpt9d3hGQEqZhGCPq0bm6UHwvUNeImgvnMu830X8+pva1gH3Lh/at9/5zOjTt4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=I44kMcGX; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=k/e080hWv1/phh7G1n4JyJkR+5g5OEdJ7sD74mBcFBE=;
	t=1727592095; x=1728024095; b=I44kMcGXZ7cjRam4HBeaxzv8djzvimPmkPKxb/CDSlK6Ekt
	fPqBW3dSJUqmav/dkrEoKYsCLI12vDKlT0MJO73xSPG36sfAXhummfrCG0r5t9OFOixN668BQ2CFQ
	2A9H2T/Vjoqbi/ELEb+8qkxPMnRh80fm8jyuiYCHXtxIuavx1orJVSlddPHeYjqLkNjBaczips0wD
	VWYjEN0EjWDyqYrGRv4vjzM+xAA85QP+At81O48JiA7xLDzC0+ORt05DrSW2Zb/v3QE2nKr8XCikM
	CpvDuaz9E5nmic7sLMSTe9QmrJFvQ2RO/wV22z9wlHpqY5LmdaiGued75xMOzPEQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1suncU-0006TT-Tp; Sun, 29 Sep 2024 08:41:27 +0200
Message-ID: <3cc1eca2-0278-4b90-9cc6-e5c75ed4327d@leemhuis.info>
Date: Sun, 29 Sep 2024 08:41:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [regression] Regular "cracks" in HDMI sound during playback since
 backport to 6.1.y for 92afcc310038 ("ALSA: hda: Conditionally use snooping
 for AMD HDMI")
To: Salvatore Bonaccorso <carnil@debian.org>, Takashi Iwai <tiwai@suse.de>,
 Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org
Cc: Eric Degenetais <eric.4.debian@grabatoulnz.fr>,
 linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>,
 regressions@lists.linux.dev, Sasha Levin <sashal@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <ZvgCdYfKgwHpJXGE@eldamar.lan>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZvgCdYfKgwHpJXGE@eldamar.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1727592095;86a46c88;
X-HE-SMSGID: 1suncU-0006TT-Tp

Hi! On 28.09.24 15:19, Salvatore Bonaccorso wrote:
> 
> In downstream Debian we got a report from  Eric Degenetais, in
> https://bugs.debian.org/1081833 that after the update to the 6.1.106
> based version, there were regular cracks in HDMI sound during
> playback.
> 
> Eric was able to bisec the issue down to
> 92afcc310038ebe5d66c689bb0bf418f5451201c in the v6.1.y series which
> got applied in 6.1.104.
> 
> Cf. https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1081833#47
> 
> #regzbot introduced: 92afcc310038ebe5d66c689bb0bf418f5451201c
> #regzbot link: https://bugs.debian.org/1081833
> 
> It should be noted that Eric as well tried more recent stable series
> as well, in particular did test as well 6.10.6 based version back on
> 20th september, and the issue was reproducible there as well.
> 
> Is there anything else we can try to provide?

Just "the usual", which is not widely known, so allow me to explain.

Please in situations like this *always* try to test a recent mainline
kernel. Given the timing, it's best to test 6.12-rc1 once it out later
today.

That's because it's unclear if this is something the regular maintainers
or the stable team/the one that asked for the backport has to handle.
Some developers do not care, but often it's required, as otherwise
nobody will take a close look -- especially when it comes to longterm
kernels. That's because participation in stable/longterm maintenance is
entirely optional for mainline developers (e.g. the author of the
culprit). This page
https://linux-regtracking.leemhuis.info/post/frequent-reasons-why-linux-kernel-bug-reports-are-ignored/
has a few points that explain the problem in more detail.

HTH, Ciao, Thorsten

