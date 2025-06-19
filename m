Return-Path: <stable+bounces-154836-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FB9AE0FC4
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 00:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A8D017DC6B
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 22:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9209F28BA91;
	Thu, 19 Jun 2025 22:54:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from constellation.wizardsworks.org (wizardsworks.org [24.234.38.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5893E241C89;
	Thu, 19 Jun 2025 22:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=24.234.38.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750373693; cv=none; b=DEW10u+w72MEytF/r52qBNXmGbdFygXZSkcbScmtNUKwQw+INt5NJ2Uz3rBgRQzn1IvwD2KEmTq2HqtLJOMvCh5kp7iRz1xQIa2OcIg/y6ZQ9zYWlRy4T1sT0X9l9V8As9PnNaVvisNqIAkMrOsYq0lKc+Us+yppQNjw2QjkPs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750373693; c=relaxed/simple;
	bh=qzYzFzR1DSG4tYJ1iiItLCVp+duz/23yoHhGRj7riNk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=BHmrYwL0rcnY4zErXZ/rZAVLDQNMQmS1Oh0QkQOD7/9Q4iYTF3oX4xA9C2WbmDpY1PsyYaQX9EDnphm2+XEv8YuSLRRYWJaibjKfylhCjNbT0EnNcIhibOs+OoQyoY8OISzIDUPk8CiRGeBLtaGaJ97vRim2H7m5QMSSfKS0TQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wizardsworks.org; spf=pass smtp.mailfrom=wizardsworks.org; arc=none smtp.client-ip=24.234.38.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wizardsworks.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wizardsworks.org
Received: from mail.wizardsworks.org (localhost [127.0.0.1])
	by constellation.wizardsworks.org (8.18.1/8.18.1) with ESMTP id 55JMuGB4008146;
	Thu, 19 Jun 2025 15:56:17 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 19 Jun 2025 15:56:16 -0700
From: Greg Chandler <chandleg@wizardsworks.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Florian Fainelli <f.fainelli@gmail.com>, stable@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: Tulip 21142 panic on physical link disconnect
In-Reply-To: <alpine.DEB.2.21.2506192238280.37405@angie.orcam.me.uk>
References: <53bb866f5bb12cc1b6c33b3866007f2b@wizardsworks.org>
 <02e3f9b8-9e60-4574-88e2-906ccd727829@gmail.com>
 <385f2469f504dd293775d3c39affa979@wizardsworks.org>
 <fba6a52c-bedf-4d06-814f-eb78257e4cb3@gmail.com>
 <6a079cd0233b33c6faf6af6a1da9661f@wizardsworks.org>
 <9292e561-09bf-4d70-bcb7-f90f9cfbae7b@gmail.com>
 <a3d8ee993b73b826b537f374d78084ad@wizardsworks.org>
 <12ccf3e4c24e8db2545f6ccaba8ce273@wizardsworks.org>
 <8c06f8969e726912b46ef941d36571ad@wizardsworks.org>
 <alpine.DEB.2.21.2506192007440.37405@angie.orcam.me.uk>
 <52564e1f-ab05-4347-bd64-b38a69180499@gmail.com>
 <alpine.DEB.2.21.2506192238280.37405@angie.orcam.me.uk>
Message-ID: <5a21c21844beadb68ead00cb401ca1c0@wizardsworks.org>
X-Sender: chandleg@wizardsworks.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2025/06/19 14:53, Maciej W. Rozycki wrote:
> On Thu, 19 Jun 2025, Florian Fainelli wrote:
> 
>> >   Maybe it'll ring someone's bell and they'll chime in or otherwise I'll
>> > bisect it... sometime.  Or feel free to start yourself with 5.18, as it's
>> > not terribly old, only a bit and certainly not so as 2.6 is.
>> 
>> I am still not sure why I could not see that warning on by Cobalt 
>> Qube2 trying
>> to reproduce Greg's original issue, that is with an IP assigned on the
>> interface yanking the cable did not trigger a timer warning. It could 
>> be that
>> machine is orders of magnitude slower and has a different CONFIG_HZ 
>> value that
>> just made it less likely to be seen?
> 
>  Can it have a different PHY attached?  There's this code:
> 
> 	if (tp->chip_id == PNIC2)
> 		tp->link_change = pnic2_lnk_change;
> 	else if (tp->flags & HAS_NWAY)
> 		tp->link_change = t21142_lnk_change;
> 	else if (tp->flags & HAS_PNICNWAY)
> 		tp->link_change = pnic_lnk_change;
> 
> in `tulip_init_one' and `pnic_lnk_change' won't ever trigger this, but 
> the
> other two can; apparently the corresponding comment in 
> `tulip_interrupt':
> 
> /*
>  * NB: t21142_lnk_change() does a del_timer_sync(), so be careful if 
> this
>  * call is ever done under the spinlock
>  */
> 
> hasn't been updated when `pnic2_lnk_change' was added.  Also ISTM no 
> link
> change handler is a valid option too, in which case `del_timer_sync' 
> won't
> be called either.  This is from a cursory glance only, so please take 
> with
> a pinch of salt.
> 
>   Maciej




I'm not sure which of us that was directed at, but for my onboard 
tulips:

Micro Linear ML6698CH <- PHY
Intel 21143-TD <- NIC

I know that the ML chips are most commonly used with 21143s and a very 
small smattering of others, I don't think they are all that common at 
least not since the late '90s..
I'm relatively certain all my DEC ISA/PCI nics use them though.

I found a link to the datasheet (If needed), but have had mixed luck 
with alldatasheets:
https://www.alldatasheet.com/datasheet-pdf/pdf/75840/MICRO-LINEAR/ML6698CH.html

Glancing over it I don't see anything about the link, I'll go stick my 
eyes in the driver a bit and see what stabs me in the eye....

