Return-Path: <stable+bounces-116468-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C247EA36A10
	for <lists+stable@lfdr.de>; Sat, 15 Feb 2025 01:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 894C716C845
	for <lists+stable@lfdr.de>; Sat, 15 Feb 2025 00:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913C81CD2B;
	Sat, 15 Feb 2025 00:48:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807805103F
	for <stable@vger.kernel.org>; Sat, 15 Feb 2025 00:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.202.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580521; cv=none; b=joMPwRYN/BTrwjvDk2Jvdbd/9TRhXSUh/+qgw31dV52oGcafQRDVXBWbaUzGAgfZkC7PfyooXzm7rr3w6Lxg704gvaG2xifimMnWfGCmOHtZRcquKt8GNio0y9imdjWbgJPh1lvIcdtMEyuUO+16pJSes04Bquz45GHm0FhFRS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580521; c=relaxed/simple;
	bh=J8WUjsnnP7sCIDzXp/yxMBz/NbLT/IgBeDS5wJ1BZkQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uP8yCFf5hSWFSnePgt5CI/H9JglFmVCHPhMrtRXQp95vifXEDtctDzem8k8bs63dA9ROMnDaHSdhagzH5kdSA2RSUO7FdJpRRjQoSP3hIczU133D6/CjNon7nE5A5HlNBwZ1PsT7eA+WVPbPOd8HDxcRdwjaF6jgvD60iq/5YNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com; spf=pass smtp.mailfrom=applied-asynchrony.com; arc=none smtp.client-ip=85.10.202.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=applied-asynchrony.com
Received: from tux.applied-asynchrony.com (p5ddd71dc.dip0.t-ipconnect.de [93.221.113.220])
	by mail.itouring.de (Postfix) with ESMTPSA id EFF5A12566F;
	Sat, 15 Feb 2025 01:48:34 +0100 (CET)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
	by tux.applied-asynchrony.com (Postfix) with ESMTP id A7DC360188735;
	Sat, 15 Feb 2025 01:48:34 +0100 (CET)
Subject: Re: Suspend failures (was [PATCH 6.13 000/443] 6.13.3-rc1 review)
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Phil Auld <pauld@redhat.com>, Waiman Long <longman@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 stable <stable@vger.kernel.org>
References: <20250213142440.609878115@linuxfoundation.org>
 <e7096ec2-68db-fc3e-9c48-f20d3e80df72@applied-asynchrony.com>
 <2025021459-guise-graph-edb3@gregkh>
 <9a44f314-c101-4ed1-98ad-547c84df7cdd@applied-asynchrony.com>
 <CAHk-=wiqfigQWF1itWTOGkahU6EP0KU96d3C8txbc9K=RpE2sQ@mail.gmail.com>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <9d2efa62-3b80-b594-5173-ca711a391dbe@applied-asynchrony.com>
Date: Sat, 15 Feb 2025 01:48:34 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiqfigQWF1itWTOGkahU6EP0KU96d3C8txbc9K=RpE2sQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 2025-02-15 00:18, Linus Torvalds wrote:
> Adding more people: Peter / Phil / Waiman. Juri was already on the list earlier.
> 
> On Fri, 14 Feb 2025 at 02:12, Holger Hoffstätte
> <holger@applied-asynchrony.com> wrote:
>>
>> Whoop! Whoop! The sound of da police!
>>
>> 2ce2a62881abcd379b714bf41aa671ad7657bdd2 is the first bad commit
>> commit 2ce2a62881abcd379b714bf41aa671ad7657bdd2 (HEAD)
>> Author: Juri Lelli <juri.lelli@redhat.com>
>> Date:   Fri Nov 15 11:48:29 2024 +0000
>>
>>       sched/deadline: Check bandwidth overflow earlier for hotplug
>>
>>       [ Upstream commit 53916d5fd3c0b658de3463439dd2b7ce765072cb ]
>>
>> With this reverted it reliably suspends again.
> 
> Can you check that it works (or - more likely - doesn't work) in upstream?
> 
> That commit 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow
> earlier for hotplug") got merged during the current merge window, so
> it would be lovely if you can check whether current -git (or just the
> latest 6.14-rc) works for you, or has the same breakage.
> 
> Background for new people on the participants list: original report at
> 
>    https://lore.kernel.org/all/e7096ec2-68db-fc3e-9c48-f20d3e80df72@applied-asynchrony.com/
> 
> which says
> 
>>> Common symptom on all machines seems to be
>>>
>>> [  +0.000134] Disabling non-boot CPUs ...
>>> [  +0.000072] Error taking CPU15 down: -16
>>> [  +0.000002] Non-boot CPUs are not disabled
> 
> and this bisection result is from
> 
>    https://lore.kernel.org/all/9a44f314-c101-4ed1-98ad-547c84df7cdd@applied-asynchrony.com/
> 
> and if it breaks in 6.13 -stable, I would expect the same in the
> current tree. Unless there's some non-obvious interaction with
> something else ?

I just booted into current 6.14-git and could suspend/wakeup multiple times without
any problem - no reverting necessary, so that is good.

As for 6.12/6.13 it might be necessary to revert an accompanying commit
as well since it seems to cause test failures with hotplug, as documented here:

   https://lore.kernel.org/stable/bcf76664-e77c-44b3-b78f-bcefc7aa3fc1@nvidia.com/

..but I don't know anything about that; I just wanted to find the patch causing
the suspend problem. Other than that 6.13.3-rc2 works fine.

Not sure if that was useful information. :)

cheers
Holger

