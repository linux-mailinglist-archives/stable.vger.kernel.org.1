Return-Path: <stable+bounces-184042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B32BCEE6B
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 04:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 90A324E31E6
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 02:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20881B808;
	Sat, 11 Oct 2025 02:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="jMnCmS8Q"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA2F17A2F0
	for <stable@vger.kernel.org>; Sat, 11 Oct 2025 02:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760148225; cv=none; b=K+r6ebd6oWKJQPmSJ9JAJEtA8ZCzuq2Dsz6IyOlCNCJDP7nG5YLEPW+8Z2yfXNV+jHz2NgypOypIvHIihpXN9kvxBQGq38n6d6zdXko58o4iz9IzMi4ukTMl/mt2u5NYFKZHh5skFn20vSru4peWI1b7feKI0xP/QL5c3jaMslQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760148225; c=relaxed/simple;
	bh=J6f6D5SVGpsnY4yP8EqgefwChZvPqHmOfrrHo5VD59U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=U9osoDy4Ja20OTfppMR9dze84nfP98hPlho3usENgINCOjWlX/YP2q1PAOz1G/ZVsgYDnn9yJ0zS/IN+y292g1jDm9WOCK+fbfYjt/Bn3S8Ec8dgreIEKurwBjRojWqWTwdPwp1H7U9moPhuN+sOde477TNX36SNxHYCz2tmKzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=jMnCmS8Q; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Fmq1hzAjqTB3zEn3i0QtA4ds365s1BcSK6+vhRUry4w=;
	b=jMnCmS8Q0ypCIwGT9fM0Cq5RpSRXuk5wuX9WqEoY+V0HL6EXiVBDWdtT41ZcA3e7TgSyucRUi
	SxE1xKtM1FfvOiimLYtCuIPjSmSRJZ9JcZ32V3+rdrld1h5WmrSEXitul3OCd8Mfc8h+3UOL8Gl
	5OxRD9U4bBDiASdxjAekLPo=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4ck6Mn1Vd2z1prPt;
	Sat, 11 Oct 2025 10:03:17 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 261A5180495;
	Sat, 11 Oct 2025 10:03:35 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 11 Oct 2025 10:03:34 +0800
Message-ID: <96be24b3-8fe0-4660-ad5e-7fd6199ff6c7@huawei.com>
Date: Sat, 11 Oct 2025 10:03:37 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: regression in hostfs (ARCH=um)
Content-Language: en-US
To: Geoffrey Thorpe <geoff@geoffthorpe.net>, <stable@vger.kernel.org>
CC: Christian Brauner <brauner@kernel.org>, <regressions@lists.linux.dev>
References: <CAH2n15x389Uv_PuQ8Crm7gg4VC0UZ3kJg+eEfHMy8A6rzUtUAA@mail.gmail.com>
 <75a53a17-b5fe-441e-8953-8c1d5e7ca47a@huawei.com>
 <028786fa-8964-4dd1-8721-62a5b757237c@geoffthorpe.net>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <028786fa-8964-4dd1-8721-62a5b757237c@geoffthorpe.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr500015.china.huawei.com (7.202.195.162)



On 2025/10/9 22:04, Geoffrey Thorpe wrote:
> On 2025-10-08 22:42, Hongbo Li wrote:
>>
>> Hi Geoffrey,
>>
>> On 2025/10/9 7:22, Geoffrey Thorpe wrote:
>>> Any trivial usage of hostfs seems to be broken since commit cd140ce9 
>>> ("hostfs: convert hostfs to use the new mount API") - I bisected it 
>>> down to this commit to make sure.
>>>
>>
>> Sorry to trouble you, can you provide your information about mount 
>> version and kernel version (use mount -v and uname -ar) ?
> 
> 
> root@localhost:~# mount --version
> mount from util-linux 2.41 (libmount 2.41.0: selinux, smack, btrfs, 
> verity, namespaces, idmapping, fd-based-mount, statmount, statx, assert, 
> debug)
> 
> As for the kernel version, I have been bisecting different kernel 
> versions to find the culprit commit. The problem occurs with the commit 
> id I mentioned (cd140ce9: "hostfs: convert hostfs to use the new mount 
> API"). This appears to be between v6.10 and v6.11. The most recent 
> kernel releases all seem to exhibit the problem. My own code has been 
> using kernel v6.6 up till now and that works fine.
> 
> By the way, did you try using the steps to reproduce? No pressure to do 

I can reproduce this with my own rootfs (not your docker built one). Let 
me try to investigate more.

Thanks,
Hongbo

> so, I am just curious if the instructions I provided work OK for other 
> people (or whether I missed something essential). If you do follow those 
> steps, you should be able to see success if you use v6.6 or older, and 
> you should see failure with anything newer.
> 
> (Side note: when bisecting, I noticed that a number of commits had to be 
> skipped because they seg-faulted during early boot. Fortunately, that 
> didn't prevent me from finding the culprit. I mention this just in case 
> you stumble across a commit that seg-faults too - it appears that's 
> unrelated to the current regression.)
> 
> Regards,
> Geoff
> 
> 

