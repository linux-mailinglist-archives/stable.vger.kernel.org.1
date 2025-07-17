Return-Path: <stable+bounces-163305-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7B1B0970B
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 00:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B62BF7AF622
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 22:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F891225A35;
	Thu, 17 Jul 2025 22:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="1Iujcath"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42171547CC;
	Thu, 17 Jul 2025 22:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752792764; cv=none; b=OrRQdQ211NlwLUyt30D8C9yZpYVJ/K9IADUZF1zlXfwahyDK8vU2ffUdcwo0NjvQTDwTK6ptZ9SOLotoemRSVhOrIA9GDJIHcBz8PxAK2RLZp30y8sQBHsE01AhQUUkiG/5S4+NqjlXxmIT5yAgLw2fDJwtJT9E6dBd0qP13Wec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752792764; c=relaxed/simple;
	bh=iM7vGutXiV9jv9DBh78AMndt0vOp16U5gZNXCVl2QBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pig/8VOAmMCIt/yHLOiKfItZ1D+AZ8d4kbSTfbmlszqPSLyt2dZyjb0SpYfVDXEd+ul0qbxSLkfB8zXsUqK7ggdXpth1a4l1Tn1n39xoo2l6CReaDkUu35vcj6ss0mn/AKl+uaFQqlDI1Eh3gX0kG1Pmnic2I16+Bo7CLEFGERk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=1Iujcath; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bjp8w4XcHz9srm;
	Fri, 18 Jul 2025 00:52:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1752792752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TG54JTZbO77Ve++1V/J2c8Zltjjd4U0RCUVFfO4a/sg=;
	b=1IujcathHVcIU3FV57F1kYXy7LaNwFtJdJEk12dF3X3JmsUI+TmebIYUi+9XKD2pvVf1zw
	cAeChUiYRa6mjwttdI1vYLdo6+12HNfhxkQrZCOxl3Eh0tF/AiUULOrW44/ZnSHJMNXxGp
	lPjFl81KcQnkTANvpB0w9UQI9F32NsXuOonmRAJOqTDEfgA0+Y9aKac5LvDx/0+1BxA4kR
	IN7ptPSLp1K0EyGTj0pl1yfIS+Gb31OC6tmsyArvxOyJorVZ2a0XyH3L05tRQCy6m7XVjQ
	JiNaHMBkG/nQZQ3j3MvX+y2hbH6OabB3soUwqw64wJwqHGHLZYeMaS6WrFMPgQ==
Message-ID: <576d1040-4238-4bf0-aa61-e1261a38d780@hauke-m.de>
Date: Fri, 18 Jul 2025 00:52:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] kernel/fork: Increase minimum number of allowed
 threads
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
Content-Language: en-US
From: Hauke Mehrtens <hauke@hauke-m.de>
In-Reply-To: <20250717223432.2a74e870@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/17/25 23:34, David Laight wrote:
> On Thu, 17 Jul 2025 07:26:59 +0200
> Jiri Slaby <jirislaby@kernel.org> wrote:
> 
>> Cc wqueue & umode helper folks
>>
>> On 12. 07. 25, 1:08, Hauke Mehrtens wrote:
>>> A modern Linux system creates much more than 20 threads at bootup.
>>> When I booted up OpenWrt in qemu the system sometimes failed to boot up
>>> when it wanted to create the 419th thread. The VM had 128MB RAM and the
>>> calculation in set_max_threads() calculated that max_threads should be
>>> set to 419. When the system booted up it tried to notify the user space
>>> about every device it created because CONFIG_UEVENT_HELPER was set and
>>> used. I counted 1299 calls to call_usermodehelper_setup(), all of
>>> them try to create a new thread and call the userspace hotplug script in
>>> it.
>>>
>>> This fixes bootup of Linux on systems with low memory.
>>>
>>> I saw the problem with qemu 10.0.2 using these commands:
>>> qemu-system-aarch64 -machine virt -cpu cortex-a57 -nographic
>>>
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>>> ---
>>>    kernel/fork.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/fork.c b/kernel/fork.c
>>> index 7966c9a1c163..388299525f3c 100644
>>> --- a/kernel/fork.c
>>> +++ b/kernel/fork.c
>>> @@ -115,7 +115,7 @@
>>>    /*
>>>     * Minimum number of threads to boot the kernel
>>>     */
>>> -#define MIN_THREADS 20
>>> +#define MIN_THREADS 600
>>
>> As David noted, this is not the proper fix. It appears that usermode
>> helper should use limited thread pool. I.e. instead of
>> system_unbound_wq, alloc_workqueue("", WQ_UNBOUND, max_active) with
>> max_active set to max_threads divided by some arbitrary constant (3? 4?)?
> 
> Or maybe just 1 ?
> I'd guess all the threads either block in the same place or just block
> each other??

I will reduce the number of threads. Maybe to max 5 or maybe just one.

I think we should still increase the minimum number of threads, but 
something like 60 to 100 should be fine. It is calculated based RAM size 
128MB RAM resulted already in 419 max threads.

Hauke

