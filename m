Return-Path: <stable+bounces-18812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E0B84949B
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 08:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 201B81C21BD1
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 07:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC38E11199;
	Mon,  5 Feb 2024 07:35:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D1211193;
	Mon,  5 Feb 2024 07:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707118533; cv=none; b=KQXkuEG2rP6zCuZSQkivLedh1bZYcmabxoq1KoinkteWPMghXApINcDaXmwuM1g1zcdoatP25tjw+Hr1NcAPzv1WGIIjyfJUdvo8eraGydH2sYGCblUomOb7tEf7S03F4DjIEtdWRUBapUQRhDMSoaHouMdfONhbmM2jsQ1Akec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707118533; c=relaxed/simple;
	bh=5aTSrCYKf9FMbG5bWnxBlEmn0e03fsCoBTEYrJ7KGDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IoK8rf/NeMf0sBhufBbj+cADpXrjZNOOLiEfB+j26ysONjVgqwIdKsLYXAG3UgV5kZnyXeYqRp/RRg0nhj5ffbzB8IlZod18vaVET+mRv88QQGKHhazmDUcPx4lvhOmWtsl6k4UCxdL9mHu0wANn9P83FMlCs1ggWjCGDVNzLus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rWtVp-0004Wt-6y; Mon, 05 Feb 2024 08:35:29 +0100
Message-ID: <bf07c1bc-b38e-4672-9bb0-24c16054569a@leemhuis.info>
Date: Mon, 5 Feb 2024 08:35:28 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: S/PDIF not detected anymore / regression on recent kernel 6.7 ?
Content-Language: en-US, de-DE
To: Serge SIMON <serge.simon@gmail.com>, linux-sound@vger.kernel.org,
 regressions@lists.linux.dev
Cc: stable@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Jaroslav Kysela <perex@perex.cz>
References: <CAMBK1_QFuLQBp1apHD7=FnJo=RWE532=jMwfo=nkkGFSzJaD-A@mail.gmail.com>
 <2024011723-freeness-caviar-774c@gregkh>
 <CAMBK1_S2vwv-8PfFQ4rfChPiW7ut5LXgmUZRtyhN=AoG3g5NEg@mail.gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CAMBK1_S2vwv-8PfFQ4rfChPiW7ut5LXgmUZRtyhN=AoG3g5NEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1707118531;cb06fef0;
X-HE-SMSGID: 1rWtVp-0004Wt-6y

On 05.02.24 08:09, Serge SIMON wrote:
> 
> Any news on this ?

Apparently not. I added the sound maintainers just to be sure they are
aware of this.

> Just to say that i tried the 6.7.3 version and i have the exact same
> problem as described below
> ("linux-headers-6.7.3.arch1-2-x86_64.pkg.tar.zst" for the exact ARCH
> package, of course with a system fully up-to-date and rebooted) : no
> more S/PDIF device detected after reboot (only the monitors are
> detected, but not anymore the S/PDIF output at motherboard level-
> which is what i'm using).
> 
> Reverting to 6.6.10 does solve the issue, so per what i'm seeing,
> something has definitely been broken between 6.6.10 and 6.7.0 on that
> topic.

Unless the sound maintainers come up with something, we most likely need
a bisection from you to resolve this.

In case you want to perform a bisection, this guide I'm currently
working on might help:

https://www.leemhuis.info/files/misc/How%20to%20bisect%20a%20Linux%20kernel%20regression%20%e2%80%94%20The%20Linux%20Kernel%20documentation.html

> Is this tracked by a bug somewhere ? Does i have to open one (in
> addition to these mails) ?

No, this thread (for now) is enough.

Ciao, Thorsten


> On Wed, Jan 17, 2024 at 6:39 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> On Tue, Jan 16, 2024 at 09:49:59PM +0100, Serge SIMON wrote:
>>> Dear Kernel maintainers,
>>>
>>> I think i'm encountering (for the first time in years !) a regression
>>> with the "6.7.arch3-1" kernel (whereas no issues with
>>> "6.6.10.arch1-1", on which i reverted).
>>>
>>> I'm running a (up-to-date, and non-LTS) ARCHLINUX desktop, on a ASUS
>>> B560-I motherboard, with 3 monitors (attached to a 4-HDMI outputs
>>> card), plus an audio S/PDIF optic output at motherboard level.
>>>
>>> With the latest kernel, the S/PIDF optic output of the motherboard is
>>> NOT detected anymore (and i haven't been able to see / find anything
>>> in the logs at quick glance, neither journalctl -xe nor dmesg).
>>>
>>> Once reverted to 6.6.10, everything is fine again.
>>>
>>> For example, in a working situation (6.6.10), i have :
>>>
>>> cat /proc/asound/pcm
>>> 00-00: ALC1220 Analog : ALC1220 Analog : playback 1 : capture 1
>>> 00-01: ALC1220 Digital : ALC1220 Digital : playback 1
>>> 00-02: ALC1220 Alt Analog : ALC1220 Alt Analog : capture 1
>>> 01-03: HDMI 0 : HDMI 0 : playback 1
>>> 01-07: HDMI 1 : HDMI 1 : playback 1
>>> 01-08: HDMI 2 : HDMI 2 : playback 1
>>> 01-09: HDMI 3 : HDMI 3 : playback 1
>>>
>>> Whereas while on the latest 6.7 kernel, i only had the 4 HDMI lines
>>> (linked to a NVIDIA T600 card, with 4 HDMI outputs) and not the three
>>> first ones (attached to the motherboard).
>>>
>>> (of course i did several tests with 6.7, reboot, ... without any changes)
>>>
>>> Any idea ?
>>
>> As this is a sound issue, perhaps send this to the
>> linux-sound@vger.kernel.org mailing list (now added).
>>
>> Any chance you can do a 'git bisect' between 6.6 and 6.7 to track down
>> the issue?  Or maybe the sound developers have some things to ask about
>> as there are loads of debugging knobs in sound...
>>
>> thanks,
>>
>> greg k-h
> 
> 



