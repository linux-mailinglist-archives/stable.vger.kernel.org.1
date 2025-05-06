Return-Path: <stable+bounces-141748-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D82C3AAB969
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 08:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 324253A82C0
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B671C07F6;
	Tue,  6 May 2025 03:59:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99F71CAA76
	for <stable@vger.kernel.org>; Tue,  6 May 2025 01:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746494760; cv=none; b=JD/nyRvpRE3AQ3AmkXkDorJlCrAjUO8ElpdUraaEt7dHSNUYo+c9PPS61q1xxtGee000xafAk24P4Qtb0897olPBUfK4JcAiXtQTamn+DnWMNQojO56q/Hdrtg7h1UXRK3ijupEM1YxxT2bds5BMxQc0USwHvCcTULpIJfzNNpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746494760; c=relaxed/simple;
	bh=Bq96aD6+ZjgA4RCTUXaYtsQk/AzJO03m72VagKdV+Ro=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=p0K699q93Ko5+4hLbkDiG72cAmtQ2GLU/yDRMk9JPMyN0weeW90Xlge3UMuvKjhSa3SryCQtW/UYJEqwU7ISN8RykZgGHlDYF0CqaSaYvr4NFjvSyyzbySxOQKRMJrZDtyHCFlD4YffEg+yLbuuel5HQRHHY7MOOoCbjATH4CC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4Zs11c25wVzYQtdT
	for <stable@vger.kernel.org>; Tue,  6 May 2025 09:25:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A36DC1A018D
	for <stable@vger.kernel.org>; Tue,  6 May 2025 09:25:55 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgD3W2AeZRloUqM_Lg--.29436S3;
	Tue, 06 May 2025 09:25:52 +0800 (CST)
Subject: Re: Bug#1104460: [regression 6.1.y] discard/TRIM through RAID10
 blocking
To: =?UTF-8?Q?Antoine_Beaupr=c3=a9?= <anarcat@debian.org>,
 Salvatore Bonaccorso <carnil@debian.org>, 1104460@bugs.debian.org
Cc: =?UTF-8?Q?Moritz_M=c3=bchlenhoff?= <jmm@inutil.org>,
 Melvin Vermeeren <vermeeren@vermwa.re>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Coly Li
 <colyli@kernel.org>, Sasha Levin <sashal@kernel.org>,
 stable <stable@vger.kernel.org>, regressions@lists.linux.dev,
 "yukuai (C)" <yukuai3@huawei.com>
References: <174602441004.174814.6400502946223473449.reportbug@talos.vermwa.re>
 <aBJH6Nsh-7Zj55nN@eldamar.lan> <aBilQxLZ4MA4Tg8e@pisco.westfalen.local>
 <aBjEf5R7X9GaJg2T@eldamar.lan>
 <174602441004.174814.6400502946223473449.reportbug@talos.vermwa.re>
 <aBjhHUjtXRotZUVa@eldamar.lan>
 <174602441004.174814.6400502946223473449.reportbug@talos.vermwa.re>
 <875xiex56v.fsf@angela.anarc.at> <aBkhNwVVs_KwgQ1a@eldamar.lan>
 <87zffqvknw.fsf@angela.anarc.at>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <4762cbe1-30a2-e5cd-52e1-f2de7714da1e@huaweicloud.com>
Date: Tue, 6 May 2025 09:25:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87zffqvknw.fsf@angela.anarc.at>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3W2AeZRloUqM_Lg--.29436S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJw13Jr4kZF48GFyftFykAFb_yoW5Zw4fpr
	W5ta1Ykrs8tF97Aryqqr40vFWUtw4fJryrXrs5Jr1UAayqyryrJr4Igay5ua9rXw18Kw1j
	qry8Xa47XFWDAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUrsqXDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/05/06 4:59, Antoine Beaupré 写道:
> On 2025-05-05 22:36:07, Salvatore Bonaccorso wrote:
>> Hi Antoine,
>>
>> On Mon, May 05, 2025 at 02:50:32PM -0400, Antoine Beaupré wrote:
>>> On 2025-05-05 18:02:37, Salvatore Bonaccorso wrote:
>>>> On Mon, May 05, 2025 at 04:00:31PM +0200, Salvatore Bonaccorso wrote:
>>>>> Hi Moritz,
>>>>>
>>>>> On Mon, May 05, 2025 at 01:47:15PM +0200, Moritz Mühlenhoff wrote:
>>>>>> Am Wed, Apr 30, 2025 at 05:55:20PM +0200 schrieb Salvatore Bonaccorso:
>>>>>>> Hi
>>>>>>>
>>>>>>> We got a regression report in Debian after the update from 6.1.133 to
>>>>>>> 6.1.135. Melvin is reporting that discard/trimm trhough a RAID10 array
>>>>>>> stalls idefintively. The full report is inlined below and originates
>>>>>>> from https://bugs.debian.org/1104460 .
>>>>>>
>>>>>> JFTR, we ran into the same problem with a few Wikimedia servers running
>>>>>> 6.1.135 and RAID 10: The servers started to lock up once fstrim.service
>>>>>> got started. Full oops messages are available at
>>>>>> https://phabricator.wikimedia.org/P75746
>>>>>
>>>>> Thanks for this aditional datapoints. Assuming you wont be able to
>>>>> thest the other stable series where the commit d05af90d6218
>>>>> ("md/raid10: fix missing discard IO accounting") went in, might you at
>>>>> least be able to test the 6.1.y branch with the commit reverted again
>>>>> and manually trigger the issue?
>>>>>
>>>>> If needed I can provide a test Debian package of 6.1.135 (or 6.1.137)
>>>>> with the patch reverted.
>>>>
>>>> So one additional data point as several Debian users were reporting
>>>> back beeing affected: One user did upgrade to 6.12.25 (where the
>>>> commit was backported as well) and is not able to reproduce the issue
>>>> there.
>>>
>>> That would be me.
>>>
>>> I can reproduce the issue as outlined by Moritz above fairly reliably in
>>> 6.1.135 (debian package 6.1.0-34-amd64). The reproducer is simple, on a
>>> RAID-10 host:
>>>
>>>   1. reboot
>>>   2. systemctl start fstrim.service
>>>
>>> We're tracking the issue internally in:
>>>
>>> https://gitlab.torproject.org/tpo/tpa/team/-/issues/42146
>>>
>>> I've managed to workaround the issue by upgrading to the Debian package
>>> from testing/unstable (6.12.25), as Salvatore indicated above. There,
>>> fstrim doesn't cause any crash and completes successfully. In stable, it
>>> just hangs there forever. The kernel doesn't completely panic and the
>>> machine is otherwise somewhat still functional: my existing SSH
>>> connection keeps working, for example, but new ones fail. And an `apt
>>> install` of another kernel hangs forever.
>>
>> So likely at least in 6.1.y there are missing pre-requisites causing
>> the behaviour.
>>
>> If you can test 6.1.135-1 with the commit
>> 4a05f7ae33716d996c5ce56478a36a3ede1d76f2 reverted then you can fetch
>> built packages at:
>>
>> https://people.debian.org/~carnil/tmp/linux/1104460/

Can you also test with 4a05f7ae33716d996c5ce56478a36a3ede1d76f2 not
reverted, and also cherry-pick c567c86b90d4715081adfe5eb812141a5b6b4883?

Thanks,
Kuai

> 
> I can confirm this kernel does not crash when running fstrim.service,
> which seems to confirm the bisect.
> 
> A.
> 


