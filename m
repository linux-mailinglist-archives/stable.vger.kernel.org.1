Return-Path: <stable+bounces-163466-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 852C2B0B6AE
	for <lists+stable@lfdr.de>; Sun, 20 Jul 2025 17:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4D92178E8D
	for <lists+stable@lfdr.de>; Sun, 20 Jul 2025 15:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF13B1FF7D7;
	Sun, 20 Jul 2025 15:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="FqIpilAe"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A432110;
	Sun, 20 Jul 2025 15:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753025315; cv=none; b=pVmmlW73ZawToRRGD5frnndBlhHIncn7dJLRzCelY/t+pJff+YZNUU+y2CNlP/09DaGhc+Ec+XXbUZCFORwkyD3f6nkjaUIvk4Bbaq/nDPGc12VJauLEtGeLz2/9WkIT0c7OwtY3+E9GVZJr/kt7/KmaErzsnqs/gaeZAEYOOsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753025315; c=relaxed/simple;
	bh=vw3B+BY6+qIM9DgVnAe81FwN6eUSuK6u24e/pzPik7Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dFGmPS3A2csAeFCbXoiKI9K5wdQ3KeGcbIDZMndtL9y5LUCLgO9S5RkkXEnVW2fPbaGaTN3eoj5uDF9shBJjrqoFn2SvB/IuhGKR6L6Thi4+Z68Zws+PZti+3c2EnXcEnjxfN3n9u/TTdO/XatprZUKb6skyCYZYB/6NFGFO2DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=FqIpilAe; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4blS9313FTz9sTh;
	Sun, 20 Jul 2025 17:28:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1753025303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uTfKqqTtkECSqtOjE3YTU9nXZEzTHSw7SiYUrtyFCPE=;
	b=FqIpilAeds61mfKnaHz46CVnwnRevVjRcsPrLLShEqlirRRYPVYg8jFHhBdBiz1y5alysh
	AQhJkdmFuXWdh6nRm6fDEXvpiJ+7teHnYluxXvG+T1lAK1IMJzf0vJiYaUSzWkP6EXp3q/
	OOYa8rGFuk15TNmjNQtqTBwEoIvAs3whfD660gYNucGcAtQQ+AWg8/arwku0HkS1EUQbsV
	ztsk06QVTV4Z5+z7zy21PvZv4zxowg2gfrlcM93csNMm7VQ0V6KeN4fG94DA930/MIpUFT
	Fg7nDBOp1VeYMGBR1harymXgQHQ8VpysJ7zSPWZLJiIPKKpYRtGdssDUqiOFBQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of hauke@hauke-m.de designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=hauke@hauke-m.de
Message-ID: <1f81e064-1b19-475d-b48c-39f56381058c@hauke-m.de>
Date: Sun, 20 Jul 2025 17:28:20 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] kernel/fork: Increase minimum number of allowed
 threads
From: Hauke Mehrtens <hauke@hauke-m.de>
To: David Laight <david.laight.linux@gmail.com>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: sashal@kernel.org, linux-kernel@vger.kernel.org, frederic@kernel.org,
 david@redhat.com, viro@zeniv.linux.org.uk, paulmck@kernel.org,
 stable@vger.kernel.org, Tejun Heo <tj@kernel.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 "Luis R . Rodriguez" <mcgrof@kernel.org>
References: <20250711230829.214773-1-hauke@hauke-m.de>
 <48e6e92d-6b6a-4850-9396-f3afa327ca3a@kernel.org>
 <20250717223432.2a74e870@pumpkin>
 <576d1040-4238-4bf0-aa61-e1261a38d780@hauke-m.de>
Content-Language: en-US
In-Reply-To: <576d1040-4238-4bf0-aa61-e1261a38d780@hauke-m.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4blS9313FTz9sTh

Hi,

I am not exactly sure how I should limit the number of parallel user 
mode helper calls.
The user mode helper is calling wait_for_initramfs() so it could be that 
some calls are getting queued at the early bootup. This is probably the 
problem I am hitting.

I do not want to block the device creation till the user mode helper 
finished. This could also result in a deadlock and would probably slow 
down bootup.

When I limit the number of user mode helper calls to 1 and let the 
others wait in a system queue, I might block other unrelated tasks in 
the system queue.

I would create an own queue and let the async user mode helper wait in 
this queue to only execute one at a time. When one of them needs a long 
time in user space it would block the others. This workqueue would also 
be active all the time. After the bootup it would probably not do much 
work any more.

I do not like any of these solutions. Do you have better ideas?

Hauke

On 7/18/25 00:52, Hauke Mehrtens wrote:
> On 7/17/25 23:34, David Laight wrote:
>> On Thu, 17 Jul 2025 07:26:59 +0200
>> Jiri Slaby <jirislaby@kernel.org> wrote:
>>
>>> Cc wqueue & umode helper folks
>>>
>>> On 12. 07. 25, 1:08, Hauke Mehrtens wrote:
>>>> A modern Linux system creates much more than 20 threads at bootup.
>>>> When I booted up OpenWrt in qemu the system sometimes failed to boot up
>>>> when it wanted to create the 419th thread. The VM had 128MB RAM and the
>>>> calculation in set_max_threads() calculated that max_threads should be
>>>> set to 419. When the system booted up it tried to notify the user space
>>>> about every device it created because CONFIG_UEVENT_HELPER was set and
>>>> used. I counted 1299 calls to call_usermodehelper_setup(), all of
>>>> them try to create a new thread and call the userspace hotplug 
>>>> script in
>>>> it.
>>>>
>>>> This fixes bootup of Linux on systems with low memory.
>>>>
>>>> I saw the problem with qemu 10.0.2 using these commands:
>>>> qemu-system-aarch64 -machine virt -cpu cortex-a57 -nographic
>>>>
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>>>> ---
>>>>    kernel/fork.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/fork.c b/kernel/fork.c
>>>> index 7966c9a1c163..388299525f3c 100644
>>>> --- a/kernel/fork.c
>>>> +++ b/kernel/fork.c
>>>> @@ -115,7 +115,7 @@
>>>>    /*
>>>>     * Minimum number of threads to boot the kernel
>>>>     */
>>>> -#define MIN_THREADS 20
>>>> +#define MIN_THREADS 600
>>>
>>> As David noted, this is not the proper fix. It appears that usermode
>>> helper should use limited thread pool. I.e. instead of
>>> system_unbound_wq, alloc_workqueue("", WQ_UNBOUND, max_active) with
>>> max_active set to max_threads divided by some arbitrary constant (3? 
>>> 4?)?
>>
>> Or maybe just 1 ?
>> I'd guess all the threads either block in the same place or just block
>> each other??
> 
> I will reduce the number of threads. Maybe to max 5 or maybe just one.
> 
> I think we should still increase the minimum number of threads, but 
> something like 60 to 100 should be fine. It is calculated based RAM size 
> 128MB RAM resulted already in 419 max threads.
> 
> Hauke


