Return-Path: <stable+bounces-89908-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B299BD362
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 18:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 629E2B21183
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 17:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDA51E1335;
	Tue,  5 Nov 2024 17:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="otyGNmHY"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9091DAC97;
	Tue,  5 Nov 2024 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730827748; cv=none; b=LFJauAtwFJV1vQ/+j1mKqgqc3Sw+2RNSeZxjlknysl/Dp7lk+6MZKPt8tPGfrJE+BHTE3DbBCRnAIuSZZl50EMlVa8A18FCWTjEkaWy0nQJ7wokPjM9KA6+B/ouaYvanrl0JHbFpmX3PyrTGmoIJlO/Bb690/a6ev6lTXWDvJ3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730827748; c=relaxed/simple;
	bh=2CreGbVbrghJWkuQirEpZtxLk549tTFQhm8nQmAuIrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RlStkDv6rckclG7FZ2XACxcd0r7kB+vngHFw626yqVQvfpIZX1bJRj7r75CES8Dou6B5M6nyBRA+dhU+aIq6LXgqNW06UrEhZHQvOb4eBRzEwpGwXoTfhnMRw0opmaOyDi1U6+sNl89xeNTXLDM6oUf6+ggrFQlY3/S+6tSW5OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=otyGNmHY; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=1Xos5elWg8icATiAffzeQ33UcuMS/JSgbrNNE71ZqQI=; t=1730827746;
	x=1731259746; b=otyGNmHYD+SstgJ/gcaBKP5Dueh5WzyM1zRsj87xB1dBnt9k+YQqqtnVBE6CW
	RYSnlfau7IdhkuLldgnhpad+2Kmc77xIm5zv/DP+i4ajAktekBS7wDsjgwe9d//AOMSuzzSI31qbe
	CF23WkbrbySTELIbT47rWaixXu/B2tvyXNRwL0+BfLO63053c7wp2SZAFjM33Au6YcqOLaDWvtzRx
	KZJ8+HOZH0PfOEwqK0ITfJZIV/JELF/lIsGNU2U5K34hU7s1+PCisWyeqHBA1uYJDURWfWzOnL+G1
	s9fGxC2OHRucOigJ1+1Yj2yD1BlaGx8daJsOXDp9f3LHW+2h6A==;
Received: from [2a02:8108:8980:2478:87e9:6c79:5f84:367d]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1t8NMV-000621-Vp; Tue, 05 Nov 2024 18:29:04 +0100
Message-ID: <ab5e25d8-3381-452e-ad13-5d65c0e12306@leemhuis.info>
Date: Tue, 5 Nov 2024 18:29:03 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bluetooth kernel BUG with Intel AX211 (regression in 6.1.83)
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Mike <user.service2016@gmail.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
 Sasha Levin <sashal@kernel.org>, =?UTF-8?Q?Jeremy_Lain=C3=A9?=
 <jeremy.laine@m4x.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Greg KH <gregkh@linuxfoundation.org>
References: <30f4b18f-4b96-403c-a0ab-d81809d9888a@gmail.com>
 <c09d4f5b-0c4b-4f57-8955-28a963cc7e16@leemhuis.info>
 <2024061258-boxy-plaster-7219@gregkh>
 <d5aa11c9-6326-4096-9c29-d9f0d11f83b4@leemhuis.info>
 <ZyMkvAkZXuoTHFtd@eldamar.lan>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-MW
In-Reply-To: <ZyMkvAkZXuoTHFtd@eldamar.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1730827746;1e8941e5;
X-HE-SMSGID: 1t8NMV-000621-Vp

On 31.10.24 07:33, Salvatore Bonaccorso wrote:
> On Tue, Jun 18, 2024 at 12:30:18PM +0200, Thorsten Leemhuis wrote:
>> On 12.06.24 14:04, Greg KH wrote:
>>> On Thu, Jun 06, 2024 at 12:18:18PM +0200, Thorsten Leemhuis wrote:
>>>> On 03.06.24 22:03, Mike wrote:
>>>>> On 29.05.24 11:06, Thorsten Leemhuis wrote:
>>>>> [...]
>>>>> I understand that 6.9-rc5[1] worked fine, but I guess it will take some
>>>>> time to be
>>>>> included in Debian stable, so having a patch for 6.1.x will be much
>>>>> appreciated.
>>>>> I do not have the time to follow the vanilla (latest) release as is
>>>>> likely the case for
>>>>> many other Linux users.
>>>>>
>>>> Still no reaction from the bluetooth developers. Guess they are busy
>>>> and/or do not care about 6.1.y. In that case:
>>>>
>>>> @Greg: do you might have an idea how the 6.1.y commit a13f316e90fdb1
>>>> ("Bluetooth: hci_conn: Consolidate code for aborting connections") might
>>>> cause this or if it's missing some per-requisite? If not I wonder if
>>>> reverting that patch from 6.1.y might be the best move to resolve this
>>>> regression. Mike earlier in
>>>> https://lore.kernel.org/all/c947e600-e126-43ea-9530-0389206bef5e@gmail.com/
>>>> confirmed that this fixed the problem in tests. Jeremy (who started the
>>>> thread and afaics has the same problem) did not reply.
>>>
>>> How was this reverted?  I get a bunch of conflicts as this commit was
>>> added as a dependency of a patch later in the series.
>>>
>>> So if this wants to be reverted from 6.1.y, can someone send me the
>>> revert that has been tested to work?
>>
>> Mike, can you help out here, as you apparently managed a revert earlier?
>> Without you or someone else submitting a revert I fear this won't be
>> resolved...
> 
> Trying to reboostrap this, as people running 6.1.112 based kernel
> seems still hitting the issue, but have not asked yet if it happens as
> well for 6.114.
> 
> https://bugs.debian.org/1086447
> 
> Mike, since I guess you are still as well affected as well, does the
> issue trigger on 6.1.114 for you and does reverting changes from
> a13f316e90fdb1 still fix the issue? Can you send your
> backport/changes?

Hmmm, no reply. Is there maybe someone in that bug that could create and
test a new revert to finally get this resolved upstream? Seem we
otherwise are kinda stuck here.

Ciao, Thorsten

