Return-Path: <stable+bounces-50328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A96C9905BD9
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 21:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 551DB1F24AF8
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 19:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD67982C7E;
	Wed, 12 Jun 2024 19:21:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from er-systems.de (er-systems.de [162.55.144.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E77A824A4
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 19:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.55.144.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718220079; cv=none; b=H9V+zYzlA+yS6CG6XqksH3YvmBkeSQS41N45n/mT0TtZOTVv04ke+WSVmjLm74+5i1T683rP/rpiTJXcJ7rlnC/Fz9z1wmLu0ZStbzSQrIbGY2QGKFuH8k2D2DJUUhQBe7CuOPC7dL5B7/TpG2OhrDVzkahUajpzzxfLTvtQokY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718220079; c=relaxed/simple;
	bh=bwO95nwm3irQTKcFjg3Vs5cDiKz6vsEQnsQSCgGK78Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eSOHTRaG/GdYkIQVsdTkyVi7nSzZsdYj3ZXdGNVH8ZCxPlkcJXHkK7irRUHea43xf5CZBrUlqkJzdFLKJEwW0yX6E6KNZeZbJ6JbDOVap9mvHXlfnUA64tKdJvg2Ktt+5nfODEca6pNFoxlVB3taeFd0U9M70OoNiKgtlflbZ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lio96.de; spf=pass smtp.mailfrom=lio96.de; arc=none smtp.client-ip=162.55.144.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lio96.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lio96.de
Received: from localhost.localdomain (localhost [127.0.0.1])
	by er-systems.de (Postfix) with ESMTP id 07561ECDAE5;
	Wed, 12 Jun 2024 21:21:12 +0200 (CEST)
X-Spam-Level: 
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by er-systems.de (Postfix) with ESMTPS id DAEA6ECDAE2;
	Wed, 12 Jun 2024 21:21:11 +0200 (CEST)
Date: Wed, 12 Jun 2024 21:21:11 +0200 (CEST)
From: Thomas Voegtle <tv@lio96.de>
To: Steven French <Steven.French@microsoft.com>
cc: Greg KH <gregkh@linuxfoundation.org>, 
    "stable@vger.kernel.org" <stable@vger.kernel.org>, 
    David Howells <dhowells@redhat.com>, 
    "smfrench@gmail.com" <smfrench@gmail.com>
Subject: RE: [EXTERNAL] Re: 6.6.y: cifs broken since 6.6.23 writing big files
 with vers=1.0 and 2.0
In-Reply-To:  <MN0PR21MB36071826A93A81733964CCB0E4C02@MN0PR21MB3607.namprd21.prod.outlook.com>
Message-ID: <07f55e43-3bab-33fd-fffb-2b6a39681863@lio96.de>
References: <e519a2f6-eb49-e7e6-ab2e-beabc6cad090@lio96.de> <2024061242-supervise-uncaring-b8ed@gregkh> <52814687-9c71-a6fb-3099-13ed634af592@lio96.de> <2024061215-swiftly-circus-f110@gregkh> 
 <MN0PR21MB36071826A93A81733964CCB0E4C02@MN0PR21MB3607.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Virus-Status: No
X-Virus-Checker-Version: clamassassin 1.2.4 with clamdscan / ClamAV 0.103.11/27304/Wed Jun 12 10:27:29 2024

On Wed, 12 Jun 2024, Steven French wrote:

> Thanks for catching this - I found at least one case (even if we don't 
> want to ever encourage anyone to mount with these old dialects) where I 
> was able to repro a dd hang.
>
> I tried some experiments with both 6.10-rc2 and with 6.8 and don't see a 
> performance degradation with this, but there are some cases with SMB1 
> where performance hit might be expected (if rsize or wsize is negotiated 
> to very small size, modern dialects support larger default wsize and 
> rsize).  I just did try an experiment with vers=1.0 and 6.6.33 and did 
> reproduce a problem though so am looking into that now (I see session 
> disconnected part way through the copy in /proc/fs/cifs/DebugData - do 
> you see the same thing).  I am not seeing an issue with normal modern

You mean this stuff:
         MIDs:
         Server ConnectionId: 0x6
                 State: 2 com: 9 pid: 10 cbdata: 00000000c583976f mid 
309943
                 State: 2 com: 9 pid: 10 cbdata: 0000000085b5bf16 mid 
309944
                 State: 2 com: 9 pid: 10 cbdata: 000000008b353163 mid 
309945
                 State: 2 com: 9 pid: 10 cbdata: 00000000898b6503 mid 
309946
...

Yes, can see that.


> dialects though but I will take a look and see if we can narrow down 
> what is happening in this old smb1 path.
>
> Can you check two things:
> 1) what is the wsize and rsize that was negotiation ("mount | grep cifs") will show this?

rsize=65536,wsize=65536 with vers=2.0

rsize=1048576,wsize=65536 with vers=1.0

> 2) what is the server type?

That is an older Samba Server 4.9.18 with a bunch of patches (Debian?).
I can test with several Windows Server versions if you like.


>
> The repro I tried was "dd if=/dev/zero of=/mnt1/48GB bs=4MB count=12000" 
> and so far vers=1.0 to 6.6.33 to Samba (ksmbd does not support the older 
> less secure dialects) was the only repro

For vers=2.0 it needs a few GB more to hit the problem. In my setup 
it is 58GB with Linux 6.9.0. I know. It's weird.


              Thomas



>
> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Wednesday, June 12, 2024 9:53 AM
> To: Thomas Voegtle <tv@lio96.de>
> Cc: stable@vger.kernel.org; David Howells <dhowells@redhat.com>; Steven French <Steven.French@microsoft.com>
> Subject: [EXTERNAL] Re: 6.6.y: cifs broken since 6.6.23 writing big files with vers=1.0 and 2.0
>
> On Wed, Jun 12, 2024 at 04:44:27PM +0200, Thomas Voegtle wrote:
>> On Wed, 12 Jun 2024, Greg KH wrote:
>>
>>> On Tue, Jun 11, 2024 at 09:20:33AM +0200, Thomas Voegtle wrote:
>>>>
>>>> Hello,
>>>>
>>>> a machine booted with Linux 6.6.23 up to 6.6.32:
>>>>
>>>> writing /dev/zero with dd on a mounted cifs share with vers=1.0 or
>>>> vers=2.0 slows down drastically in my setup after writing approx.
>>>> 46GB of data.
>>>>
>>>> The whole machine gets unresponsive as it was under very high IO
>>>> load. It pings but opening a new ssh session needs too much time.
>>>> I can stop the dd
>>>> (ctrl-c) and after a few minutes the machine is fine again.
>>>>
>>>> cifs with vers=3.1.1 seems to be fine with 6.6.32.
>>>> Linux 6.10-rc3 is fine with vers=1.0 and vers=2.0.
>>>>
>>>> Bisected down to:
>>>>
>>>> cifs-fix-writeback-data-corruption.patch
>>>> which is:
>>>> Upstream commit f3dc1bdb6b0b0693562c7c54a6c28bafa608ba3c
>>>> and
>>>> linux-stable commit e45deec35bf7f1f4f992a707b2d04a8c162f2240
>>>>
>>>> Reverting this patch on 6.6.32 fixes the problem for me.
>>>
>>> Odd, that commit is kind of needed :(
>>>
>>> Is there some later commit that resolves the issue here that we
>>> should pick up for the stable trees?
>>>
>>
>> Hope this helps:
>>
>> Linux 6.9.4 is broken in the same way and so is 6.9.0.
>
> How about Linus's tree?
>
> thnanks,
>
> greg k-h
>
>

       Thomas

-- 
  Thomas V


