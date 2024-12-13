Return-Path: <stable+bounces-104053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FCB9F0D40
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 14:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A4CA162C91
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 13:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EB81E00AC;
	Fri, 13 Dec 2024 13:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="JZ8v4Iel"
X-Original-To: stable@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067411DE899;
	Fri, 13 Dec 2024 13:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734096385; cv=none; b=IpgSn7R/e7rdc6TJW77RKFgcvMN2vDS8lyXShgNZzr17FGNDrMI9VB9mTarrtv4Jk5qZlC7NbU9h+Jw6frtFYpliS+3CsCGMaF79+VrCzSSkWYU8ww/zol0JQggAMCa8fSAdu5Ms37ZtFgApbnD5Jeo1Gk191PbI5HG8RkUJImk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734096385; c=relaxed/simple;
	bh=pq5E2dClTb3b+TgYz6BmlZ0VaMkh6Yol45ssZt5Flt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXp6zq3VELdmsbKizQaAswCtfP9lPQSE6YgF8AlJXiQQ5z2NWg3meKgCxtcuhGCVU5HLPliXQRCAGX9yx1bQ6phr5SdmPt6GJAXZwb7anoGSV6ffLaFn6EEzhzYieyuGWMleu7RdhIlEXywMG0e450EbWQZUIIEuVzsy1JXOIYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=JZ8v4Iel; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id D128D14C1E1;
	Fri, 13 Dec 2024 14:26:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1734096373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NSxcARGH8lpnoYOuXPDZNEAu2lX0pFm+l+w1f6zH2n4=;
	b=JZ8v4IelH/Ih0MvPgds5TamtYsW4tuOjGVUKqjzNX0NvFryQnnvYnPqNXgqXkz8Ls+peaC
	xq4kQ1ANqkpD971fgwU2HW5G/Yj2PzFNcJmkrTAIuLZIQsBqhwis9ooow+/MlYUpY8X0ZR
	ZutvF0q/oJ+fiHSPb54b/n8O0ys1rFhAyr6gTJN+oZLKVgNGyfmR46mTYUi2YH8tIX5LXg
	tsbgJsVE2lgVbfHRMZMnquejLAKEz7hqerHVqsZ8fdmCT8vricNMv5Ka31fvilq0dQN87G
	kRHy9AUpJdm7xNxgudZDqm4Yse8OjXeXjD2Aenhjs9yC8itpMrbVVqjFMAb/5A==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id a0c62334;
	Fri, 13 Dec 2024 13:26:07 +0000 (UTC)
Date: Fri, 13 Dec 2024 22:25:52 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 5.10 000/459] 5.10.231-rc1 review
Message-ID: <Z1w14PaRR2d7lyHZ@codewreck.org>
References: <20241212144253.511169641@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241212144253.511169641@linuxfoundation.org>

Greg Kroah-Hartman wrote on Thu, Dec 12, 2024 at 03:55:38PM +0100:
> This is the start of the stable review cycle for the 5.10.231 release.
> There are 459 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 14 Dec 2024 14:41:35 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.231-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.

Tested 2146a7485c27 ("Linux 5.10.231-rc1") on:
- arm i.MX6ULL (Armadillo 640)
- arm64 i.MX8MP (Armadillo G4)

No obvious regression in dmesg or basic tests:
Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>



> Shengjiu Wang <shengjiu.wang@nxp.com>
>     ASoC: fsl_micfil: fix the naming style for mask definition
>
> Shengjiu Wang <shengjiu.wang@nxp.com>
>     ASoC: fsl_micfil: fix regmap_write_bits usage
> 
> Sascha Hauer <s.hauer@pengutronix.de>
>     ASoC: fsl_micfil: use GENMASK to define register bit fields
> 
> Sascha Hauer <s.hauer@pengutronix.de>
>     ASoC: fsl_micfil: do not define SHIFT/MASK for single bits
> 
> Sascha Hauer <s.hauer@pengutronix.de>
>     ASoC: fsl_micfil: Drop unnecessary register read

Just a note on these, our version (from nxp) of this was full of
conflicts and too much effort to merge for something I cannot test
easily, so I squashed out this part and re-cherry-picked just commits
c808e277bcdf ("ASoC: fsl_micfil: Drop unnecessary register read")
and 06df673d2023 ("ASoC: fsl_micfil: fix regmap_write_bits usage")

The other three commits are marked as a stable dep of 06df673d2023 but
it really is trivial to backport and not worth the risk to me; if you'd
like me to send the minimal backport I used I'll be happy to.

(but, as far as I'm concerned I'm fine as is as well and consider this
closed; just reporting I didn't test this 100% as is. Not that my
automated test actually exercises the micfil code anyway...)


Thanks,
-- 
Dominique Martinet

