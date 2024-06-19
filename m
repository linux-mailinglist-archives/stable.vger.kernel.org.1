Return-Path: <stable+bounces-53704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A433C90E518
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 10:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C1F7B226E7
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 08:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B86377117;
	Wed, 19 Jun 2024 08:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="I3aYBPwc";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="tCb+5qj6"
X-Original-To: stable@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C7278297;
	Wed, 19 Jun 2024 08:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718784084; cv=none; b=Rcbx4jMQoqWjb75jwaN/2WTO7KTlYDv/F7KqgUaTg1xB6+JEARGceXszN+4UdlgKW7TPuOIPhxXGfk6lgAS4t6FWHGg9/d3y6+wrA/X5jqWbLadqCqfs10rrqezmj0kqJiqHFWOh/neIsV6+sdRZg0lQLkjkOlFFDuUgg0LXX8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718784084; c=relaxed/simple;
	bh=PdAEo097Rs0EOuRHSnYrSWDaONVLaa5zFC8TP4Dn004=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=msG+2kHZgQJiBjtMEqPBSLPzYwDrESJ3RbBZ2tdjS++t7D/tx5HDbtWvp8AeoiznHLIl/3RNYDHs2t5+VCbK9hpYIS1AzAY+IYBgAmAoInCQEKhvIMtkWKGrIeDij1NCZtTXLnn7Ue/lGoYb5kxVcvD0GKkGBOdhRq57owAvZRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=I3aYBPwc; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=tCb+5qj6; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 337031D0F;
	Wed, 19 Jun 2024 07:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1718783213;
	bh=PdAEo097Rs0EOuRHSnYrSWDaONVLaa5zFC8TP4Dn004=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=I3aYBPwcm+ZpGLtAtXisY/W5H1xOB3HH5XeufOPvSS9z1YxrNoutxZQAXnlOLPyxh
	 5eLw/rPSPQ+K7z4N3XrKE+F1ogwZclyBbiYU0Kn6ZTjHmyZRVYHIIREp2mDOwdHFaY
	 N5QkvuiTT8GWGzbmV4c2fvZmmt21fpjtGBdrQzwQ=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id D2A2A6A;
	Wed, 19 Jun 2024 07:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1718783692;
	bh=PdAEo097Rs0EOuRHSnYrSWDaONVLaa5zFC8TP4Dn004=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=tCb+5qj6BmBlvR3G2rYahlJ06oyY0Rrzq0+b7/BzEDBPyp2rPfSU1Ggnz9Ac9zh7h
	 lSJ9dYS/xLx2xGlRS75Sp5liFRJDZfaYbqosbs646oDkBvQdVD4Tjv3doEs5zSCPWP
	 GYjxovQSzgfe6jFMRWhupF1MV5guNZxwOOxGz4Uw=
Received: from [192.168.211.147] (192.168.211.147) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 19 Jun 2024 10:54:52 +0300
Message-ID: <b65e13cd-7479-4146-a6bf-cdbadab6795a@paragon-software.com>
Date: Wed, 19 Jun 2024 10:54:51 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Segfault running a binary in a compressed folder
To: Linux regressions mailing list <regressions@lists.linux.dev>, Giovanni
 Santini <giovannisantini93@yahoo.it>
CC: <ntfs3@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <08d7de3c-d695-4b0c-aa5d-5b5c355007f8.ref@yahoo.it>
 <08d7de3c-d695-4b0c-aa5d-5b5c355007f8@yahoo.it>
 <0936a091-7a3a-40d7-8b87-837aed43966b@leemhuis.info>
 <bed7da51-cf89-422d-84f7-cb3d89ffbe40@yahoo.it>
 <0c871021-321b-4a44-b270-508a64be1cdd@leemhuis.info>
Content-Language: en-US
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <0c871021-321b-4a44-b270-508a64be1cdd@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

On 11.06.2024 14:15, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 11.06.24 12:55, Giovanni Santini wrote:
>> Hi Thorsten, nice to chat again!
> :-D
>
>> I am sorry for the lack of information,
> Happens.
>
>> this is my second bug report to
>> the kernel; the first one was via Bugzilla and I filled more information.
>>
>> Now, the missing information is:
>>
>> OS: ArchLinux
>>
>> Tested kernels: both latest Linux stable (6.9.3) and mainline (6.10rc3)
>>
>> Regression: no, I believe that this issue has been present forever.
> Thx. Okay, in that case anyone that replies in this thread consider
> dropping the stable and the regression lists to avoid confusion and
> spare the subscribes of those lists a few cycles.
>
>> I realized it may have been compression-related only recently.
>> I do remember testing ntfs3 long ago and having the same issues with a
>> Ruby vendoring folder.
>>
>> Please let me know if you need more information!
> That's up to Konstantin (or others on the ntfs3 list), who is known to
> sometimes reply quickly, while other times only replies after quite a
> while. We'll see what it will be here. :-D
>
> Ciao, Thorsten
>
>> On 2024-06-11 12:04, Linux regression tracking (Thorsten Leemhuis) wrote:
>>> On 11.06.24 11:19, Giovanni Santini wrote:
>>>> I am writing to report the issue mentioned in the subject.
>>>>
>>>> Essentially, when running an executable from a compressed folder in an
>>>> NTFS partition mounted via ntfs3 I get a segfault.
>>>>
>>>> The error line I get in dmesg is:
>>>>
>>>> ntfs3: nvme0n1p5: ino=c3754, "hello" mmap(write) compressed not
>>>> supported
>>>>
>>>> I've attached a terminal script where I show my source, Makefile and how
>>>> the error appears.
>>> You CCed the regression and the stable list, but that looks odd, as you
>>> don't even mention which kernel version you used (or which worked).
>>> Could you clarify? And ideally state if mainline (e.g. 6.10-rc3) is
>>> affected as well, as the answer to the question "who is obliged to look
>>> into this" depends on it.
>>>
>>> Ciao, Thorsten

Hi Giovanni,

ntfs3 currently does not support mmap write to compressed files,
as indicated by the driver with

   "mmap(write) compressed not supported."

We are aware of this limitation and will implement this functionality in
the future.

Regards, Konstantin

