Return-Path: <stable+bounces-92779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C469C5782
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 13:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45741B25286
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893FD1BD4FB;
	Tue, 12 Nov 2024 11:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="j0Grg/Gv"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDA02309A9;
	Tue, 12 Nov 2024 11:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731412498; cv=none; b=qSvoUu9/0OIUSVjAOSe6Nm1g69Xa9tLyW6H0nfZVqkPtVwJj5/vt2Bj4ScHoqB4w2BVggAvoDYRkn/XCbkdniuW6gcpcOW4FyrVZGCi87mJ23boSsgJp2X0QzeEcJ0CIWXgKjUg7HNrzjUxCZ/le4d/opdGzADLk/BPUi7hhmDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731412498; c=relaxed/simple;
	bh=DXuCeGCDe0e9tK0ZBKJgVVVCnJUmBXSY0HbbHG+KACQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=sBPB8Zd/WLPl9NgokhNBkNHRcO2tvoCF4tisWKR0aK8WD0xY5iNFwqdPq2ZiR0bpdTp6TtNPKJGYzZrX8SrLyRFKfrnn6d0pUy6n3N9RxaF8HcNdWxRWD+BQS7ZqwNwwPyPougMkx8l0vgh2eViaRZtKbuBhkSoJl4q1jQvrHjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=j0Grg/Gv; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=+29nMEMWF0cXHDicySrRbkmnuY8UY651XMA/aWkQmqI=; t=1731412496;
	x=1731844496; b=j0Grg/GvGYjam/jRsNB5cddnZi5O/LRJgsF+yQf5YG7O7aulWoQyjOVtgtiAt
	I7G6RxwWk1485bevPT8wF5OKSC/E+gFLQ+L3Vp0AynSmWb+24BFA6tcbuvgLXHzgWEJJWyAJiWVwr
	4vf/ifDfSv3YCHbRbw2PCR/6eppcr6YdJbhN+E9kgWjAcGARThsm0lcwcT7y1uuLX0WEcAHdyzyiT
	PVu/UwdDbddMxkIyibZI7+kZPT9f7VBujFubCBYBA3QxOBHVQ9N0EbS2AVcqmadrljkUDdEJbPEeZ
	tuh3vVWh+MjVHUYCz0ELaFhn4Ew+wzH4CtfVgv01svicgaL56w==;
Received: from [2a02:8108:8980:2478:87e9:6c79:5f84:367d]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1tApTr-0006Vv-I3; Tue, 12 Nov 2024 12:54:47 +0100
Message-ID: <4f8542be-5175-4cf1-9c39-1809a899601c@leemhuis.info>
Date: Tue, 12 Nov 2024 12:54:46 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: Bluetooth kernel BUG with Intel AX211 (regression in 6.1.83)
To: Greg KH <gregkh@linuxfoundation.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Salvatore Bonaccorso <carnil@debian.org>,
 Mike <user.service2016@gmail.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org,
 Paul Menzel <pmenzel@molgen.mpg.de>, Sasha Levin <sashal@kernel.org>,
 =?UTF-8?Q?Jeremy_Lain=C3=A9?= <jeremy.laine@m4x.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <c09d4f5b-0c4b-4f57-8955-28a963cc7e16@leemhuis.info>
 <2024061258-boxy-plaster-7219@gregkh>
 <d5aa11c9-6326-4096-9c29-d9f0d11f83b4@leemhuis.info>
 <ZyMkvAkZXuoTHFtd@eldamar.lan>
 <ab5e25d8-3381-452e-ad13-5d65c0e12306@leemhuis.info>
 <CABBYNZKQAJGzA8th8A7Foiy7YaSFZDpLvLZqDFsVJ3Yzn8C_5g@mail.gmail.com>
 <Zypwz65wRM-FMXte@eldamar.lan> <2024110652-blooming-deck-f0d9@gregkh>
 <Zysdc3wJy0jAYHzA@eldamar.lan>
 <CABBYNZKz_5bnBxrBC3SoaGc1MTXXYsgdOXB42B0x+2dcPRkJyw@mail.gmail.com>
 <2024110703-subsoil-jasmine-fcaa@gregkh>
Content-Language: en-MW
In-Reply-To: <2024110703-subsoil-jasmine-fcaa@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1731412496;6430918f;
X-HE-SMSGID: 1tApTr-0006Vv-I3

On 07.11.24 05:38, Greg KH wrote:
> On Wed, Nov 06, 2024 at 10:02:40AM -0500, Luiz Augusto von Dentz wrote:
>> On Wed, Nov 6, 2024 at 2:40 AM Salvatore Bonaccorso <carnil@debian.org> wrote:
>>> On Wed, Nov 06, 2024 at 08:26:05AM +0100, Greg KH wrote:
>>>> On Tue, Nov 05, 2024 at 08:23:59PM +0100, Salvatore Bonaccorso wrote:
>>>>> On Tue, Nov 05, 2024 at 12:53:50PM -0500, Luiz Augusto von Dentz wrote:
>>>>>> On Tue, Nov 5, 2024 at 12:29 PM Thorsten Leemhuis
>>>>>> <regressions@leemhuis.info> wrote:
>>>>>>> On 31.10.24 07:33, Salvatore Bonaccorso wrote:
>>>>>>>> On Tue, Jun 18, 2024 at 12:30:18PM +0200, Thorsten Leemhuis wrote:
>>>>>>>>> On 12.06.24 14:04, Greg KH wrote:
>>>>>>>>>> On Thu, Jun 06, 2024 at 12:18:18PM +0200, Thorsten Leemhuis wrote:
>>>>>>>>>>> On 03.06.24 22:03, Mike wrote:
>>>>>>>>>>>> On 29.05.24 11:06, Thorsten Leemhuis wrote:
>>>>>>>>>>>> [...]
>>>>>>>>>>>> I understand that 6.9-rc5[1] worked fine, but I guess it will take some
>>>>>>>>>>>> time to be
>>>>>>>>>>>> included in Debian stable, so having a patch for 6.1.x will be much
>>>>>>>>>>>> appreciated.
>>>>>>>>>>>> I do not have the time to follow the vanilla (latest) release as is
>>>>>>>>>>>> likely the case for
>>>>>>>>>>>> many other Linux users.
>>>>>>>>>>>>
>>>>>>>>>>> Still no reaction from the bluetooth developers. Guess they are busy
>>>>>>>>>>> and/or do not care about 6.1.y. In that case:
>>>>>>>>>>>
>>>>>>>>>>> @Greg: do you might have an idea how the 6.1.y commit a13f316e90fdb1
>>>>>>>>>>> ("Bluetooth: hci_conn: Consolidate code for aborting connections") might
>>>>>>>>>>> cause this or if it's missing some per-requisite? If not I wonder if
>>>>>>>>>>> reverting that patch from 6.1.y might be the best move to resolve this
>>>>>>>>>>> regression. Mike earlier in
>>>>>>>>>>> https://lore.kernel.org/all/c947e600-e126-43ea-9530-0389206bef5e@gmail.com/
>>>>>>>>>>> confirmed that this fixed the problem in tests. Jeremy (who started the
>>>>>>>>>>> thread and afaics has the same problem) did not reply.
>>>>>>>>>>
>>>>>>>>>> How was this reverted?  I get a bunch of conflicts as this commit was
>>>>>>>>>> added as a dependency of a patch later in the series.
>>>>>>>>>>
>>>>>>>>>> So if this wants to be reverted from 6.1.y, can someone send me the
>>>>>>>>>> revert that has been tested to work?
>>>>>>>>>
>>>>>>>>> Mike, can you help out here, as you apparently managed a revert earlier?
>>>>>>>>> Without you or someone else submitting a revert I fear this won't be
>>>>>>>>> resolved...
>>>>>>>>
>>>>>>>> Trying to reboostrap this, as people running 6.1.112 based kernel
>>>>>>>> seems still hitting the issue, but have not asked yet if it happens as
>>>>>>>> well for 6.114.
>>>>>>>>
>>>>>>>> https://bugs.debian.org/1086447
>>>>>>>>
>>>>>>>> Mike, since I guess you are still as well affected as well, does the
>>>>>>>> issue trigger on 6.1.114 for you and does reverting changes from
>>>>>>>> a13f316e90fdb1 still fix the issue? Can you send your
>>>>>>>> backport/changes?
>>>>>>>
>>>>>>> Hmmm, no reply. Is there maybe someone in that bug that could create and
>>>>>>> test a new revert to finally get this resolved upstream? Seem we
>>>>>>> otherwise are kinda stuck here.
>>>>>>
>>>>>> Looks like we didn't tag things like 5af1f84ed13a ("Bluetooth:
>>>>>> hci_sync: Fix UAF on hci_abort_conn_sync") and a239110ee8e0
>>>>>> ("Bluetooth: hci_sync: always check if connection is alive before
>>>>>> deleting") that are actually fixes to a13f316e90fdb1.
>>>>>
>>>>> Ah good I see :). None of those were yet applied to the 6.1.y series
>>>>> were the issue is still presend. Would you be up to provide the needed
>>>>> changes to the stable team?  That would be very much appreciated for
>>>>> those affected running the 6.1.y series.
>>>>
>>>> We would need backports for these as they do not apply cleanly :(
>>>
>>> Looks our mails overlapped, yes came to the same conclusion as I tried
>>> to apply them on top of 6.1.y. I hope Luiz can help here.
>>>
>>> We have defintively users in Debian affected by this, and two
>>> confirmed that using a newer kernel which contains naturally those
>>> fixes do not expose the problem. If we have backports I might be able
>>> to convice those affected users to test our 6.1.115-1 + patches to
>>> verify the issue is gone.
>>
>> Then perhaps it is easier to just revert that change?
> 
> Please send a revert then.

We afaics are kinda stuck here .

Seems Mike (who apparently had a local revert that worked) does not care
anymore.

It looks like Luiz does not care about 6.1.y either, which is fine, as
participation in stable is optional.

And looks like nobody else cares enough and has the skills to
prepare and submit a revert.

In the end the one that asked for the changes to be included in the
6.1.y series thus submit one. Not sure who that is, though, a very quick
search on Lore gave no answer. :-/

There is also still the question "might a revert now cause another
regression for users of the 6.1.y series, as the change might improved
things for other users".

:-(

Ciao, Thorsten

