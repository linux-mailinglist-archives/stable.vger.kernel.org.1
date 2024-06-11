Return-Path: <stable+bounces-50147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FC89039C8
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 13:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6F991F23340
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 11:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D47017B426;
	Tue, 11 Jun 2024 11:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="hOecMzlo"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397F514F10E;
	Tue, 11 Jun 2024 11:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718104554; cv=none; b=WQ1U8sQfBxbdsNUyWnYM20mD/Se+SBNLCn2WU37HHiKv8wTXpz8r5SX8wbtQIIeSlRhenZLAuvRx6A6F5Ms4Bc+YnXt8EKcEjHgXkBJDIjv+hVoKatBMK2BMFOQj9v6aeci4UFhCUgL92tTujaILOIN2TP7yzX6bqrGj2QCShJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718104554; c=relaxed/simple;
	bh=OpvF5mDtyVeU0KVHlm5XhPG3Vkdab3qKja2YZtr/KzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TACKE3oThwIOfOBUm7KhlBXQkA3MofBm6tID5F7cSCQxbL2PsqLGosnUsV55Q1wZy0uqpYXMuCIvy+RxKp5NCaIeMoRe/nXbtEkExBH0b01SU/NVFfDaKjk4YqVQxdpHKHx/3kKY+wpPKo3w7wwejWWZS9MNfzqnsOofYvZKjAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=hOecMzlo; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=tNr1TyDJ+j471eZd1sbbSlyQNA26yaRuPvfuZVUEL6o=;
	t=1718104552; x=1718536552; b=hOecMzlo6PnhSQAbQw5huWIf1qJkVC62wcaSphSFKYOByCe
	5CyF3geFfTGRdSkANDPUiY5x7cpY6fipBk9N2SVXKNQBxBTdFEK3z6TPNpJvwMZ47xRIK9FF5pQBL
	7oaD2JA1dbQoGq0BMe3zj4UpdYKeZKb44GiT7I1QMjPd7BrXm6XIXMJAIoWTTPNCq1tBOmXZI3ogu
	eCf57FTwLlSzlByEo3E08IczYB+X8BSyeZ2GF8CaN9PnaA7s4Qsp/kdWQNxKJZNcIz307PNQVzzrY
	AbsMHRXSnia3kAgLeejH07XrOj3TbkPdff4BEn4wohgdZQTQ60sxqADekTYFAcsQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sGzTh-0007XY-QA; Tue, 11 Jun 2024 13:15:49 +0200
Message-ID: <0c871021-321b-4a44-b270-508a64be1cdd@leemhuis.info>
Date: Tue, 11 Jun 2024 13:15:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Segfault running a binary in a compressed folder
To: Giovanni Santini <giovannisantini93@yahoo.it>,
 almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 stable@vger.kernel.org
References: <08d7de3c-d695-4b0c-aa5d-5b5c355007f8.ref@yahoo.it>
 <08d7de3c-d695-4b0c-aa5d-5b5c355007f8@yahoo.it>
 <0936a091-7a3a-40d7-8b87-837aed43966b@leemhuis.info>
 <bed7da51-cf89-422d-84f7-cb3d89ffbe40@yahoo.it>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <bed7da51-cf89-422d-84f7-cb3d89ffbe40@yahoo.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1718104552;eb435cb8;
X-HE-SMSGID: 1sGzTh-0007XY-QA

On 11.06.24 12:55, Giovanni Santini wrote:
> Hi Thorsten, nice to chat again!

:-D

> I am sorry for the lack of information,

Happens.

> this is my second bug report to
> the kernel; the first one was via Bugzilla and I filled more information.
> 
> Now, the missing information is:
> 
> OS: ArchLinux
> 
> Tested kernels: both latest Linux stable (6.9.3) and mainline (6.10rc3)
> 
> Regression: no, I believe that this issue has been present forever.

Thx. Okay, in that case anyone that replies in this thread consider
dropping the stable and the regression lists to avoid confusion and
spare the subscribes of those lists a few cycles.

> I realized it may have been compression-related only recently.
> I do remember testing ntfs3 long ago and having the same issues with a
> Ruby vendoring folder.
> 
> Please let me know if you need more information!

That's up to Konstantin (or others on the ntfs3 list), who is known to
sometimes reply quickly, while other times only replies after quite a
while. We'll see what it will be here. :-D

Ciao, Thorsten

> On 2024-06-11 12:04, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 11.06.24 11:19, Giovanni Santini wrote:
>>> I am writing to report the issue mentioned in the subject.
>>>
>>> Essentially, when running an executable from a compressed folder in an
>>> NTFS partition mounted via ntfs3 I get a segfault.
>>>
>>> The error line I get in dmesg is:
>>>
>>> ntfs3: nvme0n1p5: ino=c3754, "hello" mmap(write) compressed not
>>> supported
>>>
>>> I've attached a terminal script where I show my source, Makefile and how
>>> the error appears.
>> You CCed the regression and the stable list, but that looks odd, as you
>> don't even mention which kernel version you used (or which worked).
>> Could you clarify? And ideally state if mainline (e.g. 6.10-rc3) is
>> affected as well, as the answer to the question "who is obliged to look
>> into this" depends on it.
>>
>> Ciao, Thorsten
> 

