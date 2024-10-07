Return-Path: <stable+bounces-81250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E137992A3F
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 13:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B26891C2294D
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 11:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2061CACC0;
	Mon,  7 Oct 2024 11:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="DnhDtAE1"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93486101C4;
	Mon,  7 Oct 2024 11:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728300688; cv=pass; b=Fdk2uajCCDfPOubpZxMnsrLIowhgZFByFu3oLsk2MjZLmQihcIVpW89DOUZQXBejJEdbQyAtvBF+QNT4zNLpOyLqDQWMSxpdoAS5q37VNpx7oEPmbsHryvlg0doapZ1y64LS1BnON9GFpxtFn8E2UfvSnb9i8Cyctpis8JL9Tps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728300688; c=relaxed/simple;
	bh=zB6cHrIxf8MAti/jSyoDypswPusO31FpIcIhlwrhIzY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aHS/HUnnDkKDKJ3YFegFOWW4WqKSE0Ja0EaFD+/nXiK9aq3r6ECpnwJQ5GyLwfTplsXdh0IGgAur3NR+8mb1Ic8wvgWtqIvhdstwC5+zCN99vVZtwTO/hztmbTtfRFS7KAW1h95xf61hWT9FElGTebYmKG6P9kpopw0+jsQKuKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=DnhDtAE1; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1728300673; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OpPE9fAAnOFuLxarIZG8HMCPijywuOof1PxDeoPioRi//9dAuaSNfgHCRKvd4DhhtQ1iqDnTCPP9gn2+b+TpvyNfBx73u6TVdXVEcaGUt8hqocx+0EoY/EZYZUTQk8+OFYOlPS9QcDGke79fzEgzzOwAfzYMAJetFSrZA7allaY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1728300673; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9onN0rTwv0VDbke7yVsL14uwCLFnY8cP6ctLDOhwCTs=; 
	b=lm+VbNGUBLSUigrWCBl3aICzGSejqX1d8gk5I14F3246aw5CbRb+EAdztLzKUD0/WL+9XSp9nqHFPiBczIOjz3HP8hyKjIOzjxsvzJY12XpXcSHhMyIKr8v0HH2v8tdT7H5FTltnU/3i8nk9JHE3mba5D4LXJqv4jFbhqlcFr6E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1728300673;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=9onN0rTwv0VDbke7yVsL14uwCLFnY8cP6ctLDOhwCTs=;
	b=DnhDtAE1dKIFov3oPuoZ2ubL3IOmlklo/ppKKWMXJMe11jWW6sQWe8PB26UGXlaf
	7tKEivakd6o6h3rPq9PrlFzXzbUOt1x/AaPuvGBHHIhJEP8VT5dSK4iPH5Li78ZFCTf
	a/6ol31BsT+ubNn0UzGvWdFzXudLmtrF61K00Cuo=
Received: by mx.zohomail.com with SMTPS id 1728300670434664.2188885986342;
	Mon, 7 Oct 2024 04:31:10 -0700 (PDT)
Message-ID: <697607de-5a01-4581-93a9-f4895f8a5739@collabora.com>
Date: Mon, 7 Oct 2024 16:31:03 +0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, akpm@linux-foundation.org, peterx@redhat.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm: remove the newlines, which are added for unknown
 reasons and interfere with bug analysis
To: Jeongjun Park <aha310510@gmail.com>, Greg KH <gregkh@linuxfoundation.org>
References: <20241007065307.4158-1-aha310510@gmail.com>
 <2024100748-exhume-overgrown-bf0d@gregkh>
 <CAO9qdTFwaK36EKV1c8gLCgBG+BR5JmC6=PGk2a6YdHVrH9NukQ@mail.gmail.com>
 <2024100700-animal-upriver-fb7c@gregkh>
 <CAO9qdTGSaJZ0oTmWqRouU45ur3drQVxRaH8aaBB99DXAoA40_A@mail.gmail.com>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <CAO9qdTGSaJZ0oTmWqRouU45ur3drQVxRaH8aaBB99DXAoA40_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 10/7/24 4:24 PM, Jeongjun Park wrote:
> Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> On Mon, Oct 07, 2024 at 05:57:18PM +0900, Jeongjun Park wrote:
>>> Greg KH <gregkh@linuxfoundation.org> wrote:
>>>>
>>>> On Mon, Oct 07, 2024 at 03:53:07PM +0900, Jeongjun Park wrote:
>>>>> Looking at the source code links for mm/memory.c in the sample reports
>>>>> in the syzbot report links [1].
>>>>>
>>>>> it looks like the line numbers are designated as lines that have been
>>>>> increased by 1. This may seem like a problem with syzkaller or the
>>>>> addr2line program that assigns the line numbers, but there is no problem
>>>>> with either of them.
>>>>>
>>>>> In the previous commit d61ea1cb0095 ("userfaultfd: UFFD_FEATURE_WP_ASYNC"),
>>>>> when modifying mm/memory.c, an unknown line break is added to the very first
>>>>> line of the file. However, the git.kernel.org site displays the source code
>>>>> with the added line break removed, so even though addr2line has assigned
>>>>> the correct line number, it looks like the line number has increased by 1.
>>>>>
>>>>> This may seem like a trivial thing, but I think it would be appropriate
>>>>> to remove all the newline characters added to the upstream and stable
>>>>> versions, as they are not only incorrect in terms of code style but also
>>>>> hinder bug analysis.
>>>>>
>>>>> [1]
>>>>>
>>>>> https://syzkaller.appspot.com/bug?extid=4145b11cdf925264bff4
>>>>> https://syzkaller.appspot.com/bug?extid=fa43f1b63e3aa6f66329
>>>>> https://syzkaller.appspot.com/bug?extid=890a1df7294175947697
>>>>>
>>>>> Fixes: d61ea1cb0095 ("userfaultfd: UFFD_FEATURE_WP_ASYNC")
>>>>> Cc: stable@vger.kernel.org
>>>>> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
>>>>> ---
>>>>>  mm/memory.c | 1 -
>>>>>  1 file changed, 1 deletion(-)
>>>>>
>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>> index 2366578015ad..7dffe8749014 100644
>>>>> --- a/mm/memory.c
>>>>> +++ b/mm/memory.c
>>>>> @@ -1,4 +1,3 @@
>>>>> -
>>>>
>>>> This sounds like you have broken tools that can not handle an empty line
>>>> in a file.
>>>>
>>>> Why not fix those?
>>>
>>> As I mentioned above, there is no problem with addr2line's ability to parse
>>> the code line that called the function in the calltrace of the crash report.
>>>
>>> However, when the source code of mm/memory.c is printed on the screen on the
>>> git.kernel.org site, the line break character that exists in the first line
>>> of the file is deleted and printed, so as a result, all code lines in the
>>> mm/memory.c file are located at line numbers that are -1 less than the
>>> actual line.
>>>
>>> You can understand it easily if you compare the source code of mm/memory.c
>>> on github and git.kernel.org.
>>>
>>> https://github.com/torvalds/linux/blob/master/mm/memory.c
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/memory.c
>>>
>>> Since I cannot modify the source code printing function of the git.kernel.org
>>> site, the best solution I can suggest is to remove the unnecessary line break
>>> character that exists in all versions.
>>
>> I would recommend fixing the git.kernel.org code, it is all open source
>> and can be fixed up, as odds are other projects/repos would like to have
>> it fixed as well.
>>
> 
> Oh, I just realized that this website is open source and written in C.
> 
> This seems to be the correct git repository, so I'll commit here.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/cgit.git
Get latest tag from
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/
instead.

https://kernelnewbies.org/FirstKernelPatch could be helpful in
understanding some missing details.

> 
> Regards,
> Jeongjun Park
> 
>> thanks,
>>
>> greg k-h

-- 
BR,
Muhammad Usama Anjum


