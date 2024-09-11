Return-Path: <stable+bounces-75776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E9497484A
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 04:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B2ED28863A
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 02:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A5038382;
	Wed, 11 Sep 2024 02:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ql5IT/A+"
X-Original-To: stable@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1394928DB3
	for <stable@vger.kernel.org>; Wed, 11 Sep 2024 02:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726022710; cv=none; b=YMkL3uCWH9mVsBzXFHewRenlwXazP9NQAhmCzpNjxfyiFxpbIL8LFIDnhwReKHjvfjCV39rMYBNjLXw8zC0m+uRjyW2jn9uLOxEK1vns4wOIdO/Ne8V20Xjnpfrj5IBeBKVbR7R3sjNvEGKk4+gsPUsT3IGgbPZIqW7BGNcR5r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726022710; c=relaxed/simple;
	bh=IPZupu1IxMFlRgI4XvH7OTS1Uw4WaTs+24VoYldLxQ8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fOLqaM4z9Ar/EL5n5uGuXfnuYe+VRosKcl+hKwV8EfaAlFNltfU8qUguXw0pohtzUfxgrlRzkaSB1hsws4vq4rCaL99BR7/7JIhTEIEpDdVShqI++hVIra9WvTD+F0plt1PeH6R68+rBd1C6f/FasUZ6FfHw3cM5TJS4MzzjcOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ql5IT/A+; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726022707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xO6HzKLBsfhvbV1IWU4G41rw/zPu4FEgENww3budsbE=;
	b=Ql5IT/A+axAiVlq60zdkh+6buhsXG9pcJ3oXG3Hk/lx0PmlQ29MGi4Mqky8z6s6QiBCZSo
	h/z9mRvk4WVFyaJthrcYKFE+F8ZHTrnCj4VumLch+9mNSXGg4WAdfi/wTshcimBLuO3vH9
	fAI6WRvE6crMaIF5mylrDu2kb423t48=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH v2 3/3] block: fix ordering between checking
 BLK_MQ_S_STOPPED and adding requests
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <db5193e8-5b8e-46f9-bbfc-a1821217f5a6@kernel.dk>
Date: Wed, 11 Sep 2024 10:44:34 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Ming Lei <ming.lei@redhat.com>,
 Yu Kuai <yukuai1@huaweicloud.com>,
 "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5F47D277-09E0-44FA-9EBB-D69786714A59@linux.dev>
References: <20240903081653.65613-1-songmuchun@bytedance.com>
 <20240903081653.65613-4-songmuchun@bytedance.com>
 <db5193e8-5b8e-46f9-bbfc-a1821217f5a6@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
X-Migadu-Flow: FLOW_OUT



> On Sep 10, 2024, at 21:22, Jens Axboe <axboe@kernel.dk> wrote:
>=20
> On 9/3/24 2:16 AM, Muchun Song wrote:
>> Supposing first scenario with a virtio_blk driver.
>>=20
>> CPU0                                                                =
CPU1
>>=20
>> blk_mq_try_issue_directly()
>>    __blk_mq_issue_directly()
>>        q->mq_ops->queue_rq()
>>            virtio_queue_rq()
>>                blk_mq_stop_hw_queue()
>>                                                                    =
virtblk_done()
>>    blk_mq_request_bypass_insert()                                     =
 blk_mq_start_stopped_hw_queues()
>>        /* Add IO request to dispatch list */   1) store               =
     blk_mq_start_stopped_hw_queue()
>>                                                                       =
         clear_bit(BLK_MQ_S_STOPPED)                 3) store
>>    blk_mq_run_hw_queue()                                              =
         blk_mq_run_hw_queue()
>>        if (!blk_mq_hctx_has_pending())                                =
             if (!blk_mq_hctx_has_pending())         4) load
>>            return                                                     =
                 return
>>        blk_mq_sched_dispatch_requests()                               =
             blk_mq_sched_dispatch_requests()
>>            if (blk_mq_hctx_stopped())          2) load                =
                 if (blk_mq_hctx_stopped())
>>                return                                                 =
                    return
>>            __blk_mq_sched_dispatch_requests()                         =
                 __blk_mq_sched_dispatch_requests()
>>=20
>> Supposing another scenario.
>>=20
>> CPU0                                                                =
CPU1
>>=20
>> blk_mq_requeue_work()
>>    /* Add IO request to dispatch list */       1) store            =
virtblk_done()
>>    blk_mq_run_hw_queues()/blk_mq_delay_run_hw_queues()                =
 blk_mq_start_stopped_hw_queues()
>>        if (blk_mq_hctx_stopped())              2) load                =
     blk_mq_start_stopped_hw_queue()
>>            continue                                                   =
         clear_bit(BLK_MQ_S_STOPPED)                 3) store
>>        blk_mq_run_hw_queue()/blk_mq_delay_run_hw_queue()              =
         blk_mq_run_hw_queue()
>>                                                                       =
             if (!blk_mq_hctx_has_pending())         4) load
>>                                                                       =
                 return
>>                                                                       =
             blk_mq_sched_dispatch_requests()
>>=20
>> Both scenarios are similar, the full memory barrier should be =
inserted between
>> 1) and 2), as well as between 3) and 4) to make sure that either CPU0 =
sees
>> BLK_MQ_S_STOPPED is cleared or CPU1 sees dispatch list. Otherwise, =
either CPU
>> will not rerun the hardware queue causing starvation of the request.
>>=20
>> The easy way to fix it is to add the essential full memory barrier =
into helper
>> of blk_mq_hctx_stopped(). In order to not affect the fast path =
(hardware queue
>> is not stopped most of the time), we only insert the barrier into the =
slow path.
>> Actually, only slow path needs to care about missing of dispatching =
the request
>> to the low-level device driver.
>=20
> Again, this is way too wide, it's unreadable.

OK. Will do.

Muchun,
Thanks.

>=20
> Patch looks fine, though.
>=20
> --=20
> Jens Axboe



