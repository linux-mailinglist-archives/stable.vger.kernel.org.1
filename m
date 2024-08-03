Return-Path: <stable+bounces-65321-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DB89468B2
	for <lists+stable@lfdr.de>; Sat,  3 Aug 2024 10:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94C4A281D19
	for <lists+stable@lfdr.de>; Sat,  3 Aug 2024 08:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667B314C5A1;
	Sat,  3 Aug 2024 08:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="puJSPfPR"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DF111725;
	Sat,  3 Aug 2024 08:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722673881; cv=none; b=WQGUmET7mGXVNxcNrZiqpmXXIa2mBCvHh9Yu4YxU/dyj2t6UhbIcagwbsSqigwTOkAcLhL8TUVI+Vy058XgFn7P1FhDTfAgvqEVqdSz7k2t0I/PhC1dJpjpTlHL574OIz4bAE/noPTa7FAb7/o6CE/Fny9fYcM4T6zaQGiTh1Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722673881; c=relaxed/simple;
	bh=20ngJhnEYCJ2Jabgx0PDp3lidOvpjlu2l+AUQUDCK5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V7j5+ONRY4OjS775Yd1TODRtZnjN27JOQAKRt8VB+1sZhS3iot6Petff+FyUn6SFDeM1Xe+yBLEf9tegacgmqqziO+3sZIKKs9+aldFwv6c7slDLqXlbd9HEWcGhaF4ntes5Z9KHIMuBncPimsHTqTafd5whzmgadv44/Qi7lj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=puJSPfPR; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=Kwd1m/MJjIKZrkhAS/DcQ+MhwBRzkHYonfxsoBTNhuU=;
	b=puJSPfPRrwF0CizM0FbDc5aT0e/lsQ65uxHQ9Xi++dZ5IUXWIEsAoxO7phOT94
	h9E56Chff4GhV2K2co5KX9oFb5UKZBUwVdDZpav6tY9jeWBwUL6NdfWoh8NYbXVD
	a36rQROHiAFzfc+SkyXqOvOmzb0/7C6VxMySKJKejjKCs=
Received: from [172.21.22.210] (unknown [118.242.3.34])
	by gzga-smtp-mta-g0-0 (Coremail) with SMTP id _____wDH7y936a1mSUgJAA--.4106S2;
	Sat, 03 Aug 2024 16:25:29 +0800 (CST)
Message-ID: <00a27e2b-0fc2-4980-bc4e-b383f15d3ad9@126.com>
Date: Sat, 3 Aug 2024 16:25:27 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] mm/gup: Clear the LRU flag of a page before adding to
 LRU batch
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
 Barry Song <21cnbao@gmail.com>, David Hildenbrand <david@redhat.com>,
 baolin.wang@linux.alibaba.com, liuzixing@hygon.cn,
 Hugh Dickins <hughd@google.com>
References: <1719038884-1903-1-git-send-email-yangge1116@126.com>
 <CAF8kJuNP5iTj2p07QgHSGOJsiUfYpJ2f4R1Q5-3BN9JiD9W_KA@mail.gmail.com>
 <0f9f7a2e-23c3-43fe-b5c1-dab3a7b31c2d@126.com>
 <CACePvbXU8K4wxECroEPr5T3iAsG6cCDLa12WmrvEBMskcNmOuQ@mail.gmail.com>
 <b5f5b215-fdf2-4287-96a9-230a87662194@126.com>
 <CACePvbV4L-gRN9UKKuUnksfVJjOTq_5Sti2-e=pb_w51kucLKQ@mail.gmail.com>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <CACePvbV4L-gRN9UKKuUnksfVJjOTq_5Sti2-e=pb_w51kucLKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDH7y936a1mSUgJAA--.4106S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxArWkur1kXFyDXr1rKFyUWrg_yoWrXryUpr
	yfJ3W2yrs5JFnFyrW2vay0vFy29an2gw4Y9345t39xZ3yqqrn7ZF4IyrW5ur9rtFsrKw4j
	qF1Yy3yI93yqyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjpB-UUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiWR4wG2VLb3y65gAAsN



在 2024/8/3 4:18, Chris Li 写道:
> On Thu, Aug 1, 2024 at 6:56 PM Ge Yang <yangge1116@126.com> wrote:
>>
>>
>>
>>>> I can't reproduce this problem, using tmpfs to compile linux.
>>>> Seems you limit the memory size used to compile linux, which leads to
>>>> OOM. May I ask why the memory size is limited to 481280kB? Do I also
>>>> need to limit the memory size to 481280kB to test?
>>>
>>> Yes, you need to limit the cgroup memory size to force the swap
>>> action. I am using memory.max = 470M.
>>>
>>> I believe other values e.g. 800M can trigger it as well. The reason to
>>> limit the memory to cause the swap action.
>>> The goal is to intentionally overwhelm the memory load and let the
>>> swap system do its job. The 470M is chosen to cause a lot of swap
>>> action but not too high to cause OOM kills in normal kernels.
>>> In another word, high enough swap pressure but not too high to bust
>>> into OOM kill. e.g. I verify that, with your patch reverted, the
>>> mm-stable kernel can sustain this level of swap pressure (470M)
>>> without OOM kill.
>>>
>>> I borrowed the 470M magic value from Hugh and verified it works with
>>> my test system. Huge has a similar swab test up which is more
>>> complicated than mine. It is the inspiration of my swap stress test
>>> setup.
>>>
>>> FYI, I am using "make -j32" on a machine with 12 cores (24
>>> hyperthreading). My typical swap usage is about 3-5G. I set my
>>> swapfile size to about 20G.
>>> I am using zram or ssd as the swap backend.  Hope that helps you
>>> reproduce the problem.
>>>
>> Hi Chris,
>>
>> I try to construct the experiment according to your suggestions above.
> 
> Hi Ge,
> 
> Sorry to hear that you were not able to reproduce it.
> 
>> High swap pressure can be triggered, but OOM can't be reproduced. The
>> specific steps are as follows:
>> root@ubuntu-server-2204:/home/yangge# cp workspace/linux/ /dev/shm/ -rf
> 
> I use a slightly different way to setup the tmpfs:
> 
> Here is section of my script:
> 
>          if ! [ -d $tmpdir ]; then
>                  sudo mkdir -p $tmpdir
>                  sudo mount -t tmpfs -o size=100% nodev $tmpdir
>          fi
> 
>          sudo mkdir -p $cgroup
>          sudo sh -c "echo $mem > $cgroup/memory.max" || echo setup
> memory.max error
>          sudo sh -c "echo 1 > $cgroup/memory.oom.group" || echo setup
> oom.group error
> 
> Per run:
> 
>         # $workdir is under $tmpdir
>          sudo rm -rf $workdir
>          mkdir -p $workdir
>          cd $workdir
>          echo "Extracting linux tree"
>          XZ_OPT='-T0 -9 –memory=75%' tar xJf $linux_src || die "xz
> extract failed"
> 
>          sudo sh -c "echo $BASHPID > $cgroup/cgroup.procs"
>          echo "Cleaning linux tree, setup defconfig"
>          cd $workdir/linux
>          make -j$NR_TASK clean
>          make defconfig > /dev/null
>          echo Kernel compile run $i
>          /usr/bin/time -a -o $log make --silent -j$NR_TASK  || die "make failed"
> >

Thanks.

>> root@ubuntu-server-2204:/home/yangge# sync
>> root@ubuntu-server-2204:/home/yangge# echo 3 > /proc/sys/vm/drop_caches
>> root@ubuntu-server-2204:/home/yangge# cd /sys/fs/cgroup/
>> root@ubuntu-server-2204:/sys/fs/cgroup/# mkdir kernel-build
>> root@ubuntu-server-2204:/sys/fs/cgroup/# cd kernel-build
>> root@ubuntu-server-2204:/sys/fs/cgroup/kernel-build# echo 470M > memory.max
>> root@ubuntu-server-2204:/sys/fs/cgroup/kernel-build# echo $$ > cgroup.procs
>> root@ubuntu-server-2204:/sys/fs/cgroup/kernel-build# cd /dev/shm/linux/
>> root@ubuntu-server-2204:/dev/shm/linux# make clean && make -j24
> 
> I am using make -j 32.
> 
> Your step should work.
> 
> Did you enable MGLRU in your .config file? Mine did. I attached my
> config file here.
> 

The above test didn't enable MGLRU.

When MGLRU is enabled, I can reproduce OOM very soon. The cause of 
triggering OOM is being analyzed.

>>
>> Please help to see which step does not meet your requirements.
> 
> How many cores does your server have? I assume your RAM should be
> plenty on that server.
> 

My server has 64 cores (128 hyperthreading) and 160G of RAM.

> Chris


