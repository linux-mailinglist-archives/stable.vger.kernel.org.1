Return-Path: <stable+bounces-72723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4499687FB
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 14:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7F8B1F230B6
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 12:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB6719C555;
	Mon,  2 Sep 2024 12:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="L/J73pKE"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893B0181B80;
	Mon,  2 Sep 2024 12:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725281651; cv=none; b=tN/7Xfp7b8adgo/lVxUhSniiaISYI0PQpK3I96xXJAaF0gwBB81KPRAiskWbNpS1dkqHPZYOnjy6sR9KMLhh4bEb7DMBJK9wt6pDelTZ9K75jQ+vRL/HLVeuZJBAiVBjgVSASvYsoH1YBiZWm3rx9iTm6LksvQKo5qO2CxhpIXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725281651; c=relaxed/simple;
	bh=rFQOK6VJteuZXKwiLuPjVYiP9/LxQxEj94oSEVurGjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g7izKGkGJH/E4krGHl/T2L8nH02bmcuvobWuAUMXACtC3dJA/AVVCEgMSUcEvUjT2ThNzRJJZzVAitPB/WUY2euYD1zGHJ2bIrVErMiC/2d1nRHQS6sji2GEZTl4/jU+4srkctAOTjzgvWAWNeYUvB7ySE+Al42LQ43tUFrtR2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=L/J73pKE; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=SSKrWHfr3RQQxlj73LfGosa+rJRjxqlAnWYQ+2sQHwM=;
	t=1725281649; x=1725713649; b=L/J73pKEMTny+tWvvZ5T4k0PwUtlJ1YkrVHMW/D1p/8H7qY
	eatahSeZQl8GNUcNOUL4ACRtuIvqv4S8rGWYI5Jodg1yxHGOFSmYhO5+g8NJp5zz+Ts0rbDYJfZOv
	cuEXN8TNZnbDuw/F44gH2tkn6Z06VvtnvesgM4fVqC+zLP9golVfY3L7NgbnfkKc2k6XPbQMJgtv2
	syrsdT9rGKkWJq2QTo9snvYUqmZeNIXoNvYOHCtSy1xbQ45oYpGZoNtxEhsyzrPyZhb3l1BHWZ6Z4
	sPYbEqsbddN3yAP/i1hDmD9u7RG7zDOgCqxPHIXm2hOSnP6s2ttXdo88PiIzKNPQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sl6ZA-0000Ot-MO; Mon, 02 Sep 2024 14:53:56 +0200
Message-ID: <56651be8-1466-475f-b1c5-4087995cc5ae@leemhuis.info>
Date: Mon, 2 Sep 2024 14:53:55 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] mm/gup: Clear the LRU flag of a page before adding to
 LRU batch
To: Chris Li <chrisl@kernel.org>, Kairui Song <ryncsn@gmail.com>
Cc: Ge Yang <yangge1116@126.com>, Yu Zhao <yuzhao@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
 Barry Song <21cnbao@gmail.com>, David Hildenbrand <david@redhat.com>,
 baolin.wang@linux.alibaba.com, liuzixing@hygon.cn,
 Hugh Dickins <hughd@google.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <1719038884-1903-1-git-send-email-yangge1116@126.com>
 <CAF8kJuNP5iTj2p07QgHSGOJsiUfYpJ2f4R1Q5-3BN9JiD9W_KA@mail.gmail.com>
 <0f9f7a2e-23c3-43fe-b5c1-dab3a7b31c2d@126.com>
 <CACePvbXU8K4wxECroEPr5T3iAsG6cCDLa12WmrvEBMskcNmOuQ@mail.gmail.com>
 <b5f5b215-fdf2-4287-96a9-230a87662194@126.com>
 <CACePvbV4L-gRN9UKKuUnksfVJjOTq_5Sti2-e=pb_w51kucLKQ@mail.gmail.com>
 <00a27e2b-0fc2-4980-bc4e-b383f15d3ad9@126.com>
 <CAOUHufYi9h0kz5uW3LHHS3ZrVwEq-kKp8S6N-MZUmErNAXoXmw@mail.gmail.com>
 <CAMgjq7CLObfnEcPgrPSHtRw0RtTXLjiS=wjGnOT+xv1BhdCRHg@mail.gmail.com>
 <CAMgjq7DLGczt=_yWNe-CY=U8rW+RBrx+9VVi4AJU3HYr-BdLnQ@mail.gmail.com>
 <CACePvbXJKskfo-bd5jr2GfagaFDoYz__dbQTKmq2=rqOpJzqYQ@mail.gmail.com>
 <CACePvbWTALuB7-jH5ZxCDAy_Dxeh70Y4=eYE5Mixr2qW+Z9sVA@mail.gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CACePvbWTALuB7-jH5ZxCDAy_Dxeh70Y4=eYE5Mixr2qW+Z9sVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1725281649;ebc597c7;
X-HE-SMSGID: 1sl6ZA-0000Ot-MO

Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
for once, to make this easily accessible to everyone.

Chris et. al., was that fix from Yu ever submitted? From here it looks
like fixing this regression fell through the cracks; but at the same
time I have this strange feeling that I'm missing something obvious here
and will look stupid by writing this mail... If that's the case: sorry
for the noise.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

On 04.08.24 21:11, Chris Li wrote:
> On Sun, Aug 4, 2024 at 10:51 AM Chris Li <chrisl@kernel.org> wrote:
>> On Sun, Aug 4, 2024 at 5:22 AM Kairui Song <ryncsn@gmail.com> wrote:
>
>>>> Hi Yu, I tested your patch, on my system, the OOM still exists (96
>>>> core and 256G RAM), test memcg is limited to 512M and 32 thread ().
>>>>
>>>> And I found the OOM seems irrelevant to either your patch or Ge's
>>>> patch. (it may changed the OOM chance slight though)
>>>>
>>>> After the very quick OOM (it failed to untar the linux source code),
>>>> checking lru_gen_full:
>>>> memcg    47 /build-kernel-tmpfs
>>>>  node     0
>>>>         442       1691      29405           0
>>>>                      0          0r          0e          0p         57r
>>>>        617e          0p
>>>>                      1          0r          0e          0p          0r
>>>>          4e          0p
>>>>                      2          0r          0e          0p          0r
>>>>          0e          0p
>>>>                      3          0r          0e          0p          0r
>>>>          0e          0p
>>>>                                 0           0           0           0
>>>>          0           0
>>>>         443       1683      57748         832
>>>>                      0          0           0           0           0
>>>>          0           0
>>>>                      1          0           0           0           0
>>>>          0           0
>>>>                      2          0           0           0           0
>>>>          0           0
>>>>                      3          0           0           0           0
>>>>          0           0
>>>>                                 0           0           0           0
>>>>          0           0
>>>>         444       1670      30207         133
>>>>                      0          0           0           0           0
>>>>          0           0
>>>>                      1          0           0           0           0
>>>>          0           0
>>>>                      2          0           0           0           0
>>>>          0           0
>>>>                      3          0           0           0           0
>>>>          0           0
>>>>                                 0           0           0           0
>>>>          0           0
>>>>         445       1662          0           0
>>>>                      0          0R         34T          0          57R
>>>>        238T          0
>>>>                      1          0R          0T          0           0R
>>>>          0T          0
>>>>                      2          0R          0T          0           0R
>>>>          0T          0
>>>>                      3          0R          0T          0           0R
>>>>         81T          0
>>>>                             13807L        324O        867Y       2538N
>>>>         63F         18A
>>>>
>>>> If I repeat the test many times, it may succeed by chance, but the
>>>> untar process is very slow and generates about 7000 generations.
>>>>
>>>> But if I change the untar cmdline to:
>>>> python -c "import sys; sys.stdout.buffer.write(open('$linux_src',
>>>> mode='rb').read())" | tar zx
>>>>
>>>> Then the problem is gone, it can untar the file successfully and very fast.
>>>>
>>>> This might be a different issue reported by Chris, I'm not sure.
>>>
>>> After more testing, I think these are two problems (note I changed the
>>> memcg limit to 600m later so the compile test can run smoothly).
>>>
>>> 1. OOM during the untar progress (can be workarounded by the untar
>>> cmdline I mentioned above).
>>
>> There are two different issues here.
>> My recent test script has moved the untar phase out of memcg limit
>> (mostly I want to multithreading untar) so the bisect I did is only
>> catch the second one.
>> The untar issue might not be a regression from this patch.
>>
>>> 2. OOM during the compile progress (this should be the one Chris encountered).
>>>
>>> Both 1 and 2 only exist for MGLRU.
>>> 1 can be workarounded using the cmdline I mentioned above.
>>> 2 is caused by Ge's patch, and 1 is not.
>>>
>>> I can confirm Yu's patch fixed 2 on my system, but the 1 seems still a
>>> problem, it's not related to this patch, maybe can be discussed
>>> elsewhere.
>>
>> I will do a test run now with Yu's patch and report back.
> 
> Confirm Yu's patch fixes the regression for me. Now it can sustain
> 470M pressure without causing OOM kill.
> 
> Yu, please submit your patch.  This regression has merged into Linus'
> tree already.
> 
> Feel free to add:
> 
> Tested-by: Chris Li <chrisl@kernel.org>
> 
> Chris
> 

--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

