Return-Path: <stable+bounces-194562-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2A0C505BB
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 03:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BD913B2815
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 02:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA1A2475CE;
	Wed, 12 Nov 2025 02:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="rUJ4InbY"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A381917FB;
	Wed, 12 Nov 2025 02:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762915583; cv=none; b=GWefmLL4X3iIZJT0PZuzt1YZec8jyafeZIVWNFcjFpmDHfZWJ2Am8ienf0uYSDb+OcFIVdE+IPnZopynbL4cnx5CQfEZMn2Da7OcgAinkdZ1SjZ5oXcxwy/Wr5atPOFRIlDCSWr/6Vo87AuSV9msX+pquWqcyhg/sp8Q5U+YfiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762915583; c=relaxed/simple;
	bh=kRt3n8O6vK4qpLGdEyuBya8570Ku53ZMmaNIrrZb9No=;
	h=Subject:From:To:CC:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=efhNhl8sxq3RCVmDBFyfpECOaRHEzoiggXTCJVSKogbHqgFknEakPPhY1jBKh+hiy+LSomGtvoh4OqjnWKvFyrMRnXxpnTMrr0bUGm71j/+5N00Zs0mUgOw6WtXAk5WmI24OYOUwKq0osztB8+cYnzBeQIHFSaPkHksxHQm+aaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=rUJ4InbY; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=uZxK81uKBVB1ClxVFm/AS/+d85lVTe1IzNUlzYqFDpE=;
	b=rUJ4InbY0ELXCpPBfyXshCtKAYFhhSno02TcaeKug6nfLVMCtHMo3CO0dy/SuTx1S0Tv9Pu7l
	LIAuuDoaJl50N9HiicFtAiWfiLjld8iB2d+2Xori9wL5AOCFszt+v0A0D1E45EC8pt/9sKlwE2P
	Juz4FFUaWGekgXiSz+ASSwo=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4d5nn14MYxz1T4Fn;
	Wed, 12 Nov 2025 10:44:53 +0800 (CST)
Received: from kwepemk200016.china.huawei.com (unknown [7.202.194.82])
	by mail.maildlp.com (Postfix) with ESMTPS id 82EB3180495;
	Wed, 12 Nov 2025 10:46:16 +0800 (CST)
Received: from [10.67.109.153] (10.67.109.153) by
 kwepemk200016.china.huawei.com (7.202.194.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 12 Nov 2025 10:46:15 +0800
Subject: Re: [PATCH stable] notifiers: Add oops check in
 blocking_notifier_call_chain()
From: "yiyang (D)" <yiyang13@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: Alexey Dobriyan <adobriyan@sw.ru>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, <lujialin4@huawei.com>, Simona Vetter
	<simona@ffwll.ch>
References: <20251017061740.59843-1-yiyang13@huawei.com>
 <20251017152542.33202c28377ec9b86713ff4a@linux-foundation.org>
 <1b5d3721-469e-5ab7-6ae3-9a9ce2e6579a@huawei.com>
Message-ID: <f62055f2-777b-8990-5749-b6e8e014601b@huawei.com>
Date: Wed, 12 Nov 2025 10:46:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1b5d3721-469e-5ab7-6ae3-9a9ce2e6579a@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk200016.china.huawei.com (7.202.194.82)


On 2025/10/22 11:36, yiyang (D) wrote:
> On 2025/10/18 6:25, Andrew Morton wrote:
>> On Fri, 17 Oct 2025 06:17:40 +0000 Yi Yang <yiyang13@huawei.com> wrote:
>>
>>> In hrtimer_interrupt(), interrupts are disabled when acquiring a 
>>> spinlock,
>>> which subsequently triggers an oops. During the oops call chain,
>>> blocking_notifier_call_chain() invokes _cond_resched, ultimately leading
>>> to a hard lockup.
>>>
>>> Call Stack:
>>> hrtimer_interrupt//raw_spin_lock_irqsave
>>> __hrtimer_run_queues
>>> page_fault
>>> do_page_fault
>>> bad_area_nosemaphore
>>> no_context
>>> oops_end
>>> bust_spinlocks
>>> unblank_screen
>>> do_unblank_screen
>>> fbcon_blank
>>> fb_notifier_call_chain
>>> blocking_notifier_call_chain
>>> down_read
>>> _cond_resched
>>
>> Seems this trace is upside-down relative to what we usually see.
>>
>> Is the unaltered dmesg output available?
>>
> Below is an excerpt from the original error message:
> 
>   #0[ffff8a317f6c3ac0] __cond_resched at ffffffffa10d29a6
>   #1[ffff8a317f6c3ad8] _cond_resched at ffffffffa17292cf
>   #2[ffff8a317f6c3ae8] down_read at ffffffffa1728022
>   #3[ffff8a317f6c3b00] __blocking_notifier_call_chain at ffffffffa10c5c37
>   #4[ffff8a317f6c3b40] blocking_notifier_call_chain at ffffffffa10c5c86
>   #5[ffff8a317f6c3b50] fb_notifier_call_chain at ffffffffa13c83eb
>   #6[ffff8a317f6c3b60] fb_blank at ffffffffa13c88eb
>   #7[ffff8a317f6c3ba0] fbcon_blank at ffffffffa13d4a4b
>   #8[ffff8a317f6c3ca0] do_unblank_screen at ffffffffa144cb30
>   #9[ffff8a317f6c3cc0] unblank_screen at ffffffffa144cbf0
> #10[ffff8a317f6c3ce0] oops_end at ffffffffa172d6d5
> #11[ffff8a317f6c3d08] no_context at ffffffffa171cebc
> #12[ffff8a317f6c3d58] __bad_area_nosemaphore at ffffffffa171cf53
> #13[ffff8a317f6c3da8] bad_area_nosemaphore at ffffffffa171d0c4
> #14[ffff8a317f6c3db8] __do_page_fault at ffffffffa17306b0
> #15[ffff8a317f6c3e20] do_page_fault at ffffffffa1730895
> #16[ffff8a317f6c3e50] page_fault at ffffffffa172c768
> 
>>> If the system is in an oops state, use down_read_trylock instead of a
>>> blocking lock acquisition. If the trylock fails, skip executing the
>>> notifier callbacks to avoid potential deadlocks or unsafe operations
>>> during the oops handling process.
>>>
>>> ...
>>>
>>> --- a/kernel/notifier.c
>>> +++ b/kernel/notifier.c
>>> @@ -384,9 +384,18 @@ int blocking_notifier_call_chain(struct 
>>> blocking_notifier_head *nh,
>>>        * is, we re-check the list after having taken the lock anyway:
>>>        */
>>>       if (rcu_access_pointer(nh->head)) {
>>> -        down_read(&nh->rwsem);
>>> -        ret = notifier_call_chain(&nh->head, val, v, -1, NULL);
>>> -        up_read(&nh->rwsem);
>>> +        if (!oops_in_progress) {
>>> +            down_read(&nh->rwsem);
>>> +            ret = notifier_call_chain(&nh->head, val, v, -1, NULL);
>>> +            up_read(&nh->rwsem);
>>> +        } else {
>>> +            if (down_read_trylock(&nh->rwsem)) {
>>> +                ret = notifier_call_chain(&nh->head, val, v, -1, NULL);
>>> +                up_read(&nh->rwsem);
>>> +            } else {
>>> +                ret = NOTIFY_BAD;
>>> +            }
>>> +        }
>>>       }
>>>       return ret;
>>
>> Am I correct in believing that fb_notifier_call_chain() is only ever
>> called if defined(CONFIG_GUMSTIX_AM200EPD)?
>>
> fb_notifier_call_chain() is called in both the fb_blank() and 
> fb_set_var() functions, and it is not only called when 
> defined(CONFIG_GUMSTIX_AM200EPD).
>> I wonder what that call is for, and if we can simply remove it.
> The function called when an issue occurs is 
> `fb_notifier_call_chain(FB_EVENT_BLANK, &event);`.
> The purpose of this function is to invoke the notification chain that 
> has registered for the FB_EVENT_BLANK event.
> 
> The FB_EVENT_BLANK event appears to indicate a screen-related state.
>>
>> .
>>
> 
Do you think it is necessary to merge this patch into the 6.6 stable 
branch (or earlier versions)?
Currently, when an oops occurs, the actual panic stack trace is not 
being printed because it is being blocked by the notification chain.




