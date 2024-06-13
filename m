Return-Path: <stable+bounces-52097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B923907C84
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 21:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB08D1F22A2A
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 19:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449AD14D443;
	Thu, 13 Jun 2024 19:22:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from er-systems.de (er-systems.de [162.55.144.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5635E14B075
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 19:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.55.144.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718306520; cv=none; b=nj4QRpyij9/YB0msBfIWuHAX83L80neDjcDFXLb2D/RxpOLPtSS7ESbJJ7WmUc2U8V3mT7zTjDGMH/GYvaT4Q2jPTHxmg2NKTjUEOPZnc3WgRbv3klA4IfYLOdE2wy8FY6o5mQdh+OIfVWBjBsWqPG5ntKwMCYtm9LNdi5ACJLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718306520; c=relaxed/simple;
	bh=zpFP3myNABgypvGhVP6yP73vo7AYQFBmJ5kGkXQysR4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AqxOs2lwmWF6yvaAws8qvb6R7n0zvPhk68NHBWTCc0mP4nHnFE5TgD16kSTsDdC1hNCR5qdbT+duJWFVNJ0GW1NHvuz5AbXbYrAOmosXZd0SJTV9+P39XxZDGyz/ULwg1jlgSjPVyt/PBtvpWzxGu6SPom6ojEV0H7jN/f0O2PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lio96.de; spf=pass smtp.mailfrom=lio96.de; arc=none smtp.client-ip=162.55.144.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lio96.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lio96.de
Received: from localhost.localdomain (localhost [127.0.0.1])
	by er-systems.de (Postfix) with ESMTP id 41A81ECDAE2;
	Thu, 13 Jun 2024 21:21:46 +0200 (CEST)
X-Spam-Level: 
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by er-systems.de (Postfix) with ESMTPS id 23065ECDAC4;
	Thu, 13 Jun 2024 21:21:46 +0200 (CEST)
Date: Thu, 13 Jun 2024 21:21:44 +0200 (CEST)
From: Thomas Voegtle <tv@lio96.de>
To: Steven French <Steven.French@microsoft.com>
cc: Greg KH <gregkh@linuxfoundation.org>, 
    "stable@vger.kernel.org" <stable@vger.kernel.org>, 
    David Howells <dhowells@redhat.com>, 
    "smfrench@gmail.com" <smfrench@gmail.com>
Subject: RE: [EXTERNAL] Re: 6.6.y: cifs broken since 6.6.23 writing big files
 with vers=1.0 and 2.0
In-Reply-To:  <MN0PR21MB3607C6D879D4A92EFCAB1664E4C12@MN0PR21MB3607.namprd21.prod.outlook.com>
Message-ID: <7f5d7d2a-14e1-a33b-626d-d8e851a32b8a@lio96.de>
References: <e519a2f6-eb49-e7e6-ab2e-beabc6cad090@lio96.de> <2024061242-supervise-uncaring-b8ed@gregkh> <52814687-9c71-a6fb-3099-13ed634af592@lio96.de> <2024061215-swiftly-circus-f110@gregkh>  <MN0PR21MB36071826A93A81733964CCB0E4C02@MN0PR21MB3607.namprd21.prod.outlook.com>
 <07f55e43-3bab-33fd-fffb-2b6a39681863@lio96.de>  <MN0PR21MB3607C6D879D4A92EFCAB1664E4C12@MN0PR21MB3607.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Virus-Status: No
X-Virus-Checker-Version: clamassassin 1.2.4 with clamdscan / ClamAV 0.103.11/27305/Thu Jun 13 10:33:25 2024

On Thu, 13 Jun 2024, Steven French wrote:

> I haven't been able to repro the problem today with vers=1.0 (with 
> 6.6.33 or 6.9.2) mounted to Samba so was wondering.
>
> For the "vers=1.0" and "vers=2.0" cases where you saw a failure can you 
> "cat /proc/fs/cifs/Stats | grep reconnect" to see if there were network 
> disconnect/reconnects during the copy.
>
> And also for the "vers=2.0" failure case you reported (which I have been 
> unable to repro the failure to) could you do "cat /proc/fs/cifs/Stats | 
> grep Writes" so we can see if any failed writes in that scenario.

On Linux 6.9.0 and vers=2.0 while hitting the bug and getting slower:

cat /proc/fs/cifs/Stats | grep -E 'Writes|reconnect' ; uptime
0 session 0 share reconnects
Writes: 887694 Bytes: 58072834560
  21:15:27 up 6 min,  2 users,  load average: 9.36, 2.84, 1.06

The last one:
cat /proc/fs/cifs/Stats | grep -E 'Writes|reconnect' ; uptime
0 session 0 share reconnects
Writes: 901903 Bytes: 58985102336
  21:20:22 up 11 min,  2 users,  load average: 28.16, 17.01, 7.49


> And can you paste the exact dd command you are running (I have been 
> trying the copy various ways with dd and bs=1MB or bs=4M) in case that 
> is why I am having trouble reproducing it.

Strange.
I just do this:
dd if=/dev/zero of=bigfile status=progress

Something over 70G is good.
Everything else freezes and you hardly can interrupt the dd.
Maybe with more memory or faster target it is different?

It is so nice reproducable for me, so I did a bisect search for the fix, 
and it is:

commit 3ee1a1fc39819906f04d6c62c180e760cd3a689d (refs/bisect/fixed)
Author: David Howells <dhowells@redhat.com>
Date:   Fri Oct 6 18:29:59 2023 +0100

     cifs: Cut over to using netfslib


And that's bad? As I see it, there are many commits for preparation 
commits to switch and a few fixes. Too many for stable?




>
>
> -----Original Message-----
> From: Thomas Voegtle <tv@lio96.de>
> Sent: Wednesday, June 12, 2024 2:21 PM
> To: Steven French <Steven.French@microsoft.com>
> Cc: Greg KH <gregkh@linuxfoundation.org>; stable@vger.kernel.org; David Howells <dhowells@redhat.com>; smfrench@gmail.com
> Subject: RE: [EXTERNAL] Re: 6.6.y: cifs broken since 6.6.23 writing big files with vers=1.0 and 2.0
>
> [You don't often get email from tv@lio96.de. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Wed, 12 Jun 2024, Steven French wrote:
>
>> Thanks for catching this - I found at least one case (even if we don't
>> want to ever encourage anyone to mount with these old dialects) where
>> I was able to repro a dd hang.
>>
>> I tried some experiments with both 6.10-rc2 and with 6.8 and don't see
>> a performance degradation with this, but there are some cases with
>> SMB1 where performance hit might be expected (if rsize or wsize is
>> negotiated to very small size, modern dialects support larger default
>> wsize and rsize).  I just did try an experiment with vers=1.0 and
>> 6.6.33 and did reproduce a problem though so am looking into that now
>> (I see session disconnected part way through the copy in
>> /proc/fs/cifs/DebugData - do you see the same thing).  I am not seeing
>> an issue with normal modern
>
> You mean this stuff:
>         MIDs:
>         Server ConnectionId: 0x6
>                 State: 2 com: 9 pid: 10 cbdata: 00000000c583976f mid
> 309943
>                 State: 2 com: 9 pid: 10 cbdata: 0000000085b5bf16 mid
> 309944
>                 State: 2 com: 9 pid: 10 cbdata: 000000008b353163 mid
> 309945
>                 State: 2 com: 9 pid: 10 cbdata: 00000000898b6503 mid
> 309946
> ...
>
> Yes, can see that.
>
>
>> dialects though but I will take a look and see if we can narrow down
>> what is happening in this old smb1 path.
>>
>> Can you check two things:
>> 1) what is the wsize and rsize that was negotiation ("mount | grep cifs") will show this?
>
> rsize=65536,wsize=65536 with vers=2.0
>
> rsize=1048576,wsize=65536 with vers=1.0
>
>> 2) what is the server type?
>
> That is an older Samba Server 4.9.18 with a bunch of patches (Debian?).
> I can test with several Windows Server versions if you like.
>
>
>>
>> The repro I tried was "dd if=/dev/zero of=/mnt1/48GB bs=4MB count=12000"
>> and so far vers=1.0 to 6.6.33 to Samba (ksmbd does not support the
>> older less secure dialects) was the only repro
>
> For vers=2.0 it needs a few GB more to hit the problem. In my setup it is 58GB with Linux 6.9.0. I know. It's weird.
>
>
>              Thomas
>
>
>
>>
>> -----Original Message-----
>> From: Greg KH <gregkh@linuxfoundation.org>
>> Sent: Wednesday, June 12, 2024 9:53 AM
>> To: Thomas Voegtle <tv@lio96.de>
>> Cc: stable@vger.kernel.org; David Howells <dhowells@redhat.com>;
>> Steven French <Steven.French@microsoft.com>
>> Subject: [EXTERNAL] Re: 6.6.y: cifs broken since 6.6.23 writing big
>> files with vers=1.0 and 2.0
>>
>> On Wed, Jun 12, 2024 at 04:44:27PM +0200, Thomas Voegtle wrote:
>>> On Wed, 12 Jun 2024, Greg KH wrote:
>>>
>>>> On Tue, Jun 11, 2024 at 09:20:33AM +0200, Thomas Voegtle wrote:
>>>>>
>>>>> Hello,
>>>>>
>>>>> a machine booted with Linux 6.6.23 up to 6.6.32:
>>>>>
>>>>> writing /dev/zero with dd on a mounted cifs share with vers=1.0 or
>>>>> vers=2.0 slows down drastically in my setup after writing approx.
>>>>> 46GB of data.
>>>>>
>>>>> The whole machine gets unresponsive as it was under very high IO
>>>>> load. It pings but opening a new ssh session needs too much time.
>>>>> I can stop the dd
>>>>> (ctrl-c) and after a few minutes the machine is fine again.
>>>>>
>>>>> cifs with vers=3.1.1 seems to be fine with 6.6.32.
>>>>> Linux 6.10-rc3 is fine with vers=1.0 and vers=2.0.
>>>>>
>>>>> Bisected down to:
>>>>>
>>>>> cifs-fix-writeback-data-corruption.patch
>>>>> which is:
>>>>> Upstream commit f3dc1bdb6b0b0693562c7c54a6c28bafa608ba3c
>>>>> and
>>>>> linux-stable commit e45deec35bf7f1f4f992a707b2d04a8c162f2240
>>>>>
>>>>> Reverting this patch on 6.6.32 fixes the problem for me.
>>>>
>>>> Odd, that commit is kind of needed :(
>>>>
>>>> Is there some later commit that resolves the issue here that we
>>>> should pick up for the stable trees?
>>>>
>>>
>>> Hope this helps:
>>>
>>> Linux 6.9.4 is broken in the same way and so is 6.9.0.
>>
>> How about Linus's tree?
>>
>> thnanks,
>>
>> greg k-h
>>
>>
>
>       Thomas
>
> --
>  Thomas V
>
>

       Thomas

-- 
  Thomas V


