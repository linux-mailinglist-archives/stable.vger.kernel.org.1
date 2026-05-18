Return-Path: <stable+bounces-249288-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGT8BlQUC2o5/wQAu9opvQ
	(envelope-from <stable+bounces-249288-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:29:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6252E56DA1E
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3ED9A3034BC8
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 13:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165D3472796;
	Mon, 18 May 2026 13:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="P80RgiWi"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128BF3F5BD9
	for <stable@vger.kernel.org>; Mon, 18 May 2026 13:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779110898; cv=none; b=ZtIqIQX0+IsCtWdU93lRryEe7MnT87+12YdQ0OebsElYsg12jqRw/fVUyCd80/OBbJKgzYNwsTGfetJI0F9qaHClctHJq+VKylZooeDGwAlFsFZxnXjL0ajAAOB6cHV2HCAo+9Nu2p3FX0DbDtJg54tfEPX6WMAGmvth1V94IGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779110898; c=relaxed/simple;
	bh=7qgIJKx6jB7//23rw9I/17KAcv7/R5w93uBSpHhdmZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d5zpvUZBDSzotQARn5AHwGGnyTLjMUEBZ6xCCs7loWPprbUHPkRewgSlfIPdbRe05/JN0LT5zcKVlWaOc+BnDTXCeoVZa9qs4AeUXDfcIzDzrOeK43/83DgU+o4l1qUmr02MkEsTz6f2zMyYLelLhPEGxzUKDoaalzZ1K3rmH14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=P80RgiWi; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-479d37e7d7fso605915b6e.1
        for <stable@vger.kernel.org>; Mon, 18 May 2026 06:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779110895; x=1779715695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=izu6ilS0aWgn06SyEgroVOflUroeHp1roh/NZR2jEuQ=;
        b=P80RgiWi39x4EfMuiZX9KyxYIKJQc69lt4SJ3zue1jbD5ETj+0Gd8eC8t8syp3BUb4
         RB1s1ETQ36JOYS1L0DMOYVkJlc6TsCETKdW+sRkAbveakD7M37zYIZMizl9LxFv9zgB5
         t+zJkKHptCeIgr+K60Ru7BuR0QeiYpQ0JTOMQifBkDY1Hqd4e+zuB4U53WcRc6ZXizew
         C8+4HAyM7NC4zWzqZL1K3CdqUeDn1I8KOh37gtKhXjnCHt4ILSsGkae9mA1uUMlsgPZ2
         /sSsphUI3hMKsa0uAZG05OLzHhpQc2gUG4TiIElsqVjLpuCUJndJE/WEbpjdzfyYwUEq
         eGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779110895; x=1779715695;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=izu6ilS0aWgn06SyEgroVOflUroeHp1roh/NZR2jEuQ=;
        b=fROGQnQf88cBsrIAQgF6QnPTK8rm9y00ByrIkHssa/asvzHQ9QcnjV1goSYn4w7J4z
         7Pl0vDRqaEXOLKfkmIVJ1ShipzldAw2XMqhiTxxb78ZfqyoJ6oSuNqa2C34VFj+09uIG
         YqRZNtI4AvJCleJ2PkoO6RVCdpozslodmPPtSjhAyxl2EDwJb16XNXWPhzcIFYUFyJWM
         Zv3JSE5jrTCsfrEcC3Daaa3PZaaS3eP3SG7uZUfmILbt6ODb+3F2PrJl1SONX5rxP9aO
         9Q8QMYCLrEUnTNLbrVJY6mEopijOu5BQ8bss6eEQZIxPfKfc8+gw9S+mJh+atpjGZSLf
         0dgg==
X-Forwarded-Encrypted: i=1; AFNElJ/hjeYVps/rgV9Ku5lJVIx+45zEJQMIK7Mo5UjANKnMLZndvDL+Eq3aeXo/3E6R12o5Hh+nKO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaaZ1ygw/vzopKW9D1Mx8B6lX3umhPRERqv82EK/M/Yv87GJbP
	sqFwPWRNjv7jJsXtDRfBefwalmuguVL938WIeqXyw8Nyw3sUBYCzmKbQNWC44CmFW+M=
X-Gm-Gg: Acq92OH8ZXDwduYZDCXe1WMwyhkElYQkIEO5zLFzpGlXY+3YKhprM9ZYpApYpuizIGV
	cNJx5b+7+UrTR7Oh2vQVscbMNxwwBhujAbyHS93huuR5LLa2nivkqThmO76swMjfXQCnF2Hr4XJ
	ceGAhLrby+pH7S5QNjKcMgVQz1lSo32n9/LT+KwjUPrfr/hpcnud8WY3a2mMM1dIeu/U3xJU8Bi
	Cib+ml3mRlHYtprGXHmpaZmr9Th1hztP2O7pknes1yQDYSf1cBhxZERJ+c9sZKsL85JJ2c9Kndy
	hmtjV3YMVucxcjsvCSLD1V570CDOzj5PFLMsAlBQfCyoCOkPVriCNyw4LuZx5SFJ0MvhEK+gtBS
	nN5I+J5xKaJ/OVqxrqobSANBSwTWe0Fx31bl2PnSyCTD6N54ddFCt8TcFalqf/L120oymgkMhpF
	FIfwGuOrcV6RJAlCaGiZ4vLmV2Mmu7xiuqPcp6Q7X3z7NEQmhcPqy9K1LFct6OjGLJW3gRjrX5X
	dAIr1wz
X-Received: by 2002:a05:6808:3992:b0:46e:df55:23fa with SMTP id 5614622812f47-482e562d225mr8979603b6e.17.1779110894636;
        Mon, 18 May 2026 06:28:14 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-482ee38c9aesm4861520b6e.8.2026.05.18.06.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 06:28:13 -0700 (PDT)
Message-ID: <77993be8-8170-4666-8531-1c46f49907ed@kernel.dk>
Date: Mon, 18 May 2026 07:28:12 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 130/144] io_uring/kbuf: support min length left for
 incremental buffers
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 stable@vger.kernel.org, patches@lists.linux.dev,
 Martin Michaelis <code@mgjm.de>, Gabriel Krisman Bertazi <krisman@suse.de>,
 Vegard Nossum <vegard.nossum@oracle.com>
References: <20260515154653.469907118@linuxfoundation.org>
 <20260515154656.529062291@linuxfoundation.org>
 <876ac528-b2db-4d52-afff-2a44f13a6767@oracle.com>
 <bc8ede5a-ab28-4191-9153-7e66c28916ac@kernel.dk>
 <2026051801-trifocals-gummy-2be3@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2026051801-trifocals-gummy-2be3@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6252E56DA1E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-249288-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email,mgjm.de:email,linuxfoundation.org:email,kernel-dk.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

On 5/18/26 6:16 AM, Greg Kroah-Hartman wrote:
> On Sun, May 17, 2026 at 07:02:25PM -0600, Jens Axboe wrote:
>> On 5/17/26 12:39 PM, Harshit Mogalapalli wrote:
>>> Hi Greg and Jens,
>>>
>>> On 15/05/26 21:19, Greg Kroah-Hartman wrote:
>>>> 6.12-stable review patch.  If anyone has any objections, please let me know.
>>>>
>>>> ------------------
>>>>
>>>> From: Martin Michaelis <code@mgjm.de>
>>>>
>>>> commit 7deba791ad495ce1d7921683f4f7d1190fa210d1 upstream.
>>>>
>>>> Incrementally consumed buffer rings are generally fully consumed, but
>>>> it's quite possible that the application has a minimum size it needs to
>>>> meet to avoid truncation. Currently that minimum limit is 1 byte, but
>>>> this should be a setting that is the hands of the application. For
>>>> recvmsg multishot, a prime use case for incrementally consumed buffers,
>>>> the application may get spurious -EFAULT returned at the end of an
>>>> incrementally consumed buffer, as less space is available than the
>>>> headers need.
>>>>
>>>> Grab a u32 field in struct io_uring_buf_reg, which the application can
>>>> use to inform the kernel of the minimum size that should be available
>>>> in an incrementally consumed buffer. If less than that is available,
>>>> the current buffer is fully processed and the next one will be picked.
>>>>
>>>> Cc: stable@vger.kernel.org
>>>> Fixes: ae98dbf43d75 ("io_uring/kbuf: add support for incremental buffer consumption")
>>>> Link: https://github.com/axboe/liburing/issues/1433
>>>> Signed-off-by: Martin Michaelis <code@mgjm.de>
>>>> [axboe: write commit message, change io_buffer_list member name]
>>>> Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>
>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> ---
>>>>   include/uapi/linux/io_uring.h |    3 ++-
>>>>   io_uring/kbuf.c               |    8 +++++++-
>>>>   io_uring/kbuf.h               |    7 +++++++
>>>>   3 files changed, 16 insertions(+), 2 deletions(-)
>>>>
>>>> --- a/include/uapi/linux/io_uring.h
>>>> +++ b/include/uapi/linux/io_uring.h
>>>> @@ -758,7 +758,8 @@ struct io_uring_buf_reg {
>>>>       __u32    ring_entries;
>>>>       __u16    bgid;
>>>>       __u16    flags;
>>>> -    __u64    resv[3];
>>>> +    __u32    min_left;
>>>> +    __u32    resv[5];
>>>>   };
>>>
>>> ^^^ let us remember this. More comments below
>>>>     /* argument for IORING_REGISTER_PBUF_STATUS */
>>>> --- a/io_uring/kbuf.c
>>>> +++ b/io_uring/kbuf.c
>>>> @@ -47,7 +47,7 @@ static bool io_kbuf_inc_commit(struct io
>>>>           this_len = min_t(u32, len, buf_len);
>>>>           buf_len -= this_len;
>>>>           /* Stop looping for invalid buffer length of 0 */
>>>> -        if (buf_len || !this_len) {
>>>> +        if (buf_len > bl->min_left_sub_one || !this_len) {
>>>>               WRITE_ONCE(buf->addr, READ_ONCE(buf->addr) + this_len);
>>>>               WRITE_ONCE(buf->len, buf_len);
>>>>               return false;
>>>> @@ -727,6 +727,10 @@ int io_register_pbuf_ring(struct io_ring
>>>>       if (reg.ring_entries >= 65536)
>>>>           return -EINVAL;
>>>>   +    /* minimum left byte count is a property of incremental buffers */
>>>> +    if (!(reg.flags & IOU_PBUF_RING_INC) && reg.min_left)
>>>> +        return -EINVAL;
>>>> +
>>>>       bl = io_buffer_get_list(ctx, reg.bgid);
>>>>       if (bl) {
>>>>           /* if mapped buffer ring OR classic exists, don't allow */
>>>> @@ -747,6 +751,8 @@ int io_register_pbuf_ring(struct io_ring
>>>>       if (!ret) {
>>>>           bl->nr_entries = reg.ring_entries;
>>>>           bl->mask = reg.ring_entries - 1;
>>>> +        if (reg.min_left)
>>>> +            bl->min_left_sub_one = reg.min_left - 1;
>>>>           if (reg.flags & IOU_PBUF_RING_INC)
>>>>               bl->flags |= IOBL_INC;
>>>
>>>
>>> I have run an AI assisted backport review and it spotted an issue: I
>>> have taken a look and the issues goes like:
>>>
>>> Backport updates struct io_uring_buf_reg to min_left + resv[5] but
>>> keeps legacy validation that only checks reg.resv[0..2], so resv[3]
>>> and resv[4] are silently accepted.
>>>
>>> Upstream has something like this:
>>>
>>> if (copy_from_user(&reg, arg, sizeof(reg)))
>>>     return -EFAULT;
>>> if (!mem_is_zero(reg.resv, sizeof(reg.resv)))
>>>     return -EINVAL;
>>> if (reg.flags & ~(IOU_PBUF_RING_MMAP | IOU_PBUF_RING_INC))
>>>     return -EINVAL;
>>>
>>> 6.12.y still has:
>>>
>>> if (copy_from_user(&reg, arg, sizeof(reg)))
>>>     return -EFAULT;
>>>
>>> if (reg.resv[0] || reg.resv[1] || reg.resv[2])
>>>     return -EINVAL;
>>> if (reg.flags & ~(IOU_PBUF_RING_MMAP | IOU_PBUF_RING_INC))
>>>     return -EINVAL;
>>>
>>> So we are not checking resv[3], resv[4],
>>>
>>> This commit is needed commit: 172484907285 ("io_uring/kbuf: use
>>> mem_is_zero()") to fix this. It is a clean cherry-pick, so I think the
>>> best thing is to take it for next cycle. this commit is present in
>>> 6.16-rc1+ so newer long-term stable kernel releases than 6.12.y don't
>>> have this problem.
>>>
>>>
>>> Jens, please correct me if the above understanding looks wrong.
>>
>> Nope you are right. It's not an actual issue, it's just future proofing
>> checking. So it's quite fine to just add that commit for the next stable
>> release. I'll check the others too, as the mem_is_zero() commit landed
>> in 6.16.
> 
> Thanks, now queued up.

Thanks Greg!

-- 
Jens Axboe


