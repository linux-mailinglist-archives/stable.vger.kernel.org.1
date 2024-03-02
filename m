Return-Path: <stable+bounces-25770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B1C86F0CD
	for <lists+stable@lfdr.de>; Sat,  2 Mar 2024 16:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC032840C2
	for <lists+stable@lfdr.de>; Sat,  2 Mar 2024 15:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482E417C62;
	Sat,  2 Mar 2024 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="Sq+zqYLl"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEEE1877;
	Sat,  2 Mar 2024 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709392653; cv=none; b=gTZyegPxU/IUCL+ZOfLDhG7mzJHPZn+eVrt11NiVapRwOt9/BeUuUdPzVIqX182VzHD+hIJuysRpc4UVu9/9j89CHAIu3uckUPBuklHDKOHnpKW6D00uOA4bxgs11GAStUXuY1exnACGL+ThJs2l22nuWlydiBBl3nPFZkvUi9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709392653; c=relaxed/simple;
	bh=5aa3JwbAJ7HqcOVbevqDDtinVe43s9Jaky7ezA/pLAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=A350Mb0sJ6JBGoPd3Cj8dDLbnyJ2puM9spwPNpwe7AlBNpAZcNHBjwZSMBee3OisNgEOQPw6go6Q9XMbmTVeEE/konHtLFRMOS2DrWpJA1CvNZEPXh7CR3rp+elYhFbpkWFM4VXZ9uNoBOLAVvy8icTDfCPYDF92Ceo4FpLygvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=Sq+zqYLl; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:Cc:From:References:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=ZbdqKHxuRKEi81jBudXJdZ1j0bHvXwlxCvfOIjtR3mg=;
	t=1709392650; x=1709824650; b=Sq+zqYLlK0n8/+K2jE9PFiBqWmijNZfHozxCmkAWgSH3cO2
	TYVnRmrHJvcczHC1SyzhBP1sXrjyZe04suYRiWNgEMB9FJlTtDiZ86IbxMxBZYOLhSK1IGm7wYalF
	+n+Y41jocb/Gvj1bJ3ga0b7JjcYcYVUV+QuSdbgAvZzbRMRb30Rqlo8fihv1y7AFoiVxXr2P5d/zV
	TTsOZron2nnyxQGYdYDme3fMBmLY49SgrJc7etGLP/U2YmOIPsXGbalXANj8g2n3mRDv4Gms5BPwy
	rL73CxzOhnL+rICvIMZDBqRaBZ/fSJnNrJXRi1Ggr2X2yWqbNWEx/ztjgM6espKw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rgR72-0007eG-Rg; Sat, 02 Mar 2024 16:17:20 +0100
Message-ID: <a84c1a5d-3a8a-4eea-9f66-0402c983ccbb@leemhuis.info>
Date: Sat, 2 Mar 2024 16:17:20 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] kexec does firmware reboot in kernel v6.7.6
Content-Language: en-US, de-DE
To: Steve Wahl <steve.wahl@hpe.com>, Dave Hansen <dave.hansen@linux.intel.com>
References: <3a1b9909-45ac-4f97-ad68-d16ef1ce99db@pavinjoseph.com>
 <7ebb1c90-544d-4540-87c0-b18dea963004@leemhuis.info>
 <3a8453e8-03a3-462f-81a2-e9366466b990@pavinjoseph.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Cc: Pavin Joseph <me@pavinjoseph.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 stable@vger.kernel.org
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <3a8453e8-03a3-462f-81a2-e9366466b990@pavinjoseph.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1709392650;2fc99635;
X-HE-SMSGID: 1rgR72-0007eG-Rg

[adding the people involved in developing and applying the culprit to
the list of recipients]

FWIW, thread starts here:
https://lore.kernel.org/all/3a1b9909-45ac-4f97-ad68-d16ef1ce99db@pavinjoseph.com/

On 02.03.24 09:24, Pavin Joseph wrote:
> On 3/1/24 20:15, Linux regression tracking (Thorsten Leemhuis) wrote:
>> Does mainline show the same problem? The answer determines who later
>> will have to look into this.
> Yes, I reproduced the issue on mainline and the latest stable version
> 6.7.7 using your excellent guide.

Thx for testing and glad to hear. Still: if you have any feedback how to
make that guide even better, please let me know!

>> With a bit of luck somebody might have heard about problems like yours.
>> But if nobody comes up with an idea up within a few days we almost
>> certainly need a bisection to get down to the root of the problem.
> 
> Full bisection done, culprit identified, and validated by reverting
> commit on mainline.

I assume the latter meant "reverting the culprit on mainline fixed the
problem"; if you meant something else, please let us know.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

> Attached bisection log and config used.
> 
> Bisection final results:
> 7143c5f4cf2073193eb27c9cdb84fd4655d1802d is the first bad commit
> commit 7143c5f4cf2073193eb27c9cdb84fd4655d1802d
> Author: Steve Wahl <steve.wahl@hpe.com>
> Date:   Fri Jan 26 10:48:41 2024 -0600
> 
>     x86/mm/ident_map: Use gbpages only where full GB page should be mapped.
> 
>     commit d794734c9bbfe22f86686dc2909c25f5ffe1a572 upstream.
> 
>     When ident_pud_init() uses only gbpages to create identity maps, large
>     ranges of addresses not actually requested can be included in the
>     resulting table; a 4K request will map a full GB.  On UV systems, this
>     ends up including regions that will cause hardware to halt the system
>     if accessed (these are marked "reserved" by BIOS).  Even processor
>     speculation into these regions is enough to trigger the system halt.
> 
>     Only use gbpages when map creation requests include the full GB page
>     of space.  Fall back to using smaller 2M pages when only portions of a
>     GB page are included in the request.
> 
>     No attempt is made to coalesce mapping requests. If a request requires
>     a map entry at the 2M (pmd) level, subsequent mapping requests within
>     the same 1G region will also be at the pmd level, even if adjacent or
>     overlapping such requests could have been combined to map a full
>     gbpage.  Existing usage starts with larger regions and then adds
>     smaller regions, so this should not have any great consequence.
> 
>     [ dhansen: fix up comment formatting, simplifty changelog ]
> 
>     Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
>     Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
>     Cc: stable@vger.kernel.org
>     Link:
> https://lore.kernel.org/all/20240126164841.170866-1-steve.wahl%40hpe.com
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
>  arch/x86/mm/ident_map.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> ----------
> 
> Btw, the issue appears on LTS kernel 6.6.18 as well. I didn't build this
> one from the source and test, but installed it a while back from
> OpenSuse Tumbleweed repos as "kernel-longterm" is a new addition and is
> being actively tested over there.

P.S.:

#regzbot introduced d794734c9bbfe22f86686dc2909c25f5ffe1a572
#regzbot title x86/mm/ident_map: kexec now leads to reboot

