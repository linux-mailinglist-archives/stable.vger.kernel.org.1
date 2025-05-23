Return-Path: <stable+bounces-146198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4788DAC22B6
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 14:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF0841710E5
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 12:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9F511712;
	Fri, 23 May 2025 12:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="okSniAX1"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6FC35959
	for <stable@vger.kernel.org>; Fri, 23 May 2025 12:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748003769; cv=none; b=LU3KQGeyx4LXgeXIN9dTxeTCLI5BPQ7r0McUG1Dc4zWcO+LE91FDhbeX9oZQjDRAVczvvFhbadRIukrbXsxM5fFI28GU+yt8pJweu8A20cRP/ZM0cjToSsStBxVgGeD2OIHg28EDjp3M70KZEzyC5K3A+PBZQ8K2ya09LuFZ13c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748003769; c=relaxed/simple;
	bh=/jOvna1kAriW+4ouHfsm5vF80nnual3Bku0VjNXYzB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UoOlZ/JF0XUQtyCQQnM5q31iC8cV7JuMhW9eUG1rlSHkRT7hq4fu+PFu/iHBcqFc9uofLrHkmMxcRI1WVhKZ6186knEnckok+3L5kzIhLxtwuIBPxyXAB40PuNgkyAHHwCGMHGnRluVcF9GpUrvXyRpS5feKCGW0kbVumh5xd/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=okSniAX1; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-86142446f3fso230450839f.2
        for <stable@vger.kernel.org>; Fri, 23 May 2025 05:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1748003765; x=1748608565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RPVOaqcboXCtCMuB+uJcS6JdEK2FSqHpuCAw7qaiC3I=;
        b=okSniAX1yX6wtNO2zN3xHQeVuU1pYazLTTwM+EwF7DlAfbYmQOEm1mtg1PDUxBZfFY
         DiuvlZS6zOZOcbmRYX9/RMqs9NU04DXGistBW9NjpttOuohKvqm8Z5QEDeXDMVmVGoDc
         veACuabsbgd/WBxO258UOuZpCl8B6q6OwwIeus/lje+cmVA+H+7pbJkCtVbycTmppSlT
         u8/+B4oAN42fVes5Vti/0AiMfn3cRSdWsT5ns/fyTifCMKzP2jpQ99dgH+anL3TnCC+K
         DT/sQ6jdAXuJuS5UTsy+WhV3b7958MIUTUtoA3NYcQSal3NPNpZVwG7GsB+Gm+0vvaAR
         E3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748003765; x=1748608565;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RPVOaqcboXCtCMuB+uJcS6JdEK2FSqHpuCAw7qaiC3I=;
        b=VAyozw9GB4WB3HAl7YNbRupeyIYoNUoPe+RTHOZOnHlSPgqhP95lxdM5ZHAwsK2awu
         oO9iS4aLMXmNbok7RkCx65OgDDzZ08vJDr7oSi0FMkpaEMAR5ASf3VJajj2MUOsUPZce
         3/XkLliY6H8euCD9NfkxsINFZIubmUIITVd2qIotxN9+3Xljw0lH03BVVBKv4KWBlFAp
         OVaiWgC3OlgKr1u4Lni3n0srnuDXPr2ZYYoaCD+gBP8LjRKV9ZIigzwV4Ayz1k8D7vQt
         iiUIrAAAjKp1Qop/9hvFqlGh54/ubXr8+UqfE5eGVRwummxfjMh2nWZrdy46L0iryAvF
         lhzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXNp4VLjeLsmquVbpc9soP2V9Akpi8dS4mDDQp56TDDPrfUi/VyxmorqajKU3/JTeh2U5Llis=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxgE+rsx/xxcJOq5/mVtrZLHVv9gsR40WDLPOPpz1AD+ZLOIUa
	gw3MZLGMDkWWfdbq5TPVSVXe6RH+4l2s1gPwSY+JGeG7YWvBoQrRRW4X/F8DSszQj1+dlIDD7XI
	/oy4x
X-Gm-Gg: ASbGncujNjtgVzglch0eLBsUWROpCgLDFehLgc+to5Haka45wUS2cbhaMHwPSPMZRsn
	5agcqa2iiaGyC6TJw8o5vCAmxiwBkFVYv/zsVR7KYqXpFFEbtSlHnfW2LxpI9vmJU4GW5QeSYzf
	RwTX6yMQi1b/zriwXYLXb63+Vq3z7id9zR9PwCYQ4Re/3lhNAqjI+6N9TVo3p6ugGl7IgCgzGMW
	7GCsq7uS2T9FeeD7hlnv0pVi+M1z320cbpxfk/OIF5vZnXrLeeGZZlvFCniLy9btR+GXyKnjNAk
	uKbf59qHuWs3uMri3ma8/JcW3dZxXXDE43HLxZk4YZsWRr2v
X-Google-Smtp-Source: AGHT+IE1BFB341HFIvzkGVv8mg93Npy1NJuZZwL8VuxRQUxH4b9KZd3dXj/zVK29JhiCRrlkRI+VlA==
X-Received: by 2002:a05:6602:4144:b0:867:6c90:4867 with SMTP id ca18e2360f4ac-86caf1d00e4mr370501839f.14.1748003765415;
        Fri, 23 May 2025 05:36:05 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc3d67a9sm3558047173.64.2025.05.23.05.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 05:36:04 -0700 (PDT)
Message-ID: <ec434995-206d-4534-8ad2-c23ab60ff1f1@kernel.dk>
Date: Fri, 23 May 2025 06:36:03 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix a deadlock related freezing zoned storage
 devices
To: Damien Le Moal <dlemoal@kernel.org>, Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Yu Kuai <yukuai1@huaweicloud.com>, Ming Lei <ming.lei@redhat.com>,
 stable@vger.kernel.org
References: <20250522171405.3239141-1-bvanassche@acm.org>
 <b1ea4120-e16a-47c8-b10c-ff6c9d5feb69@kernel.dk>
 <3cd139d0-5fe0-4ce1-b7a7-36da4fad6eff@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <3cd139d0-5fe0-4ce1-b7a7-36da4fad6eff@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/23/25 2:10 AM, Damien Le Moal wrote:
> On 5/22/25 19:38, Jens Axboe wrote:
>> On 5/22/25 11:14 AM, Bart Van Assche wrote:
>>> blk_mq_freeze_queue() never terminates if one or more bios are on the plug
>>> list and if the block device driver defines a .submit_bio() method.
>>> This is the case for device mapper drivers. The deadlock happens because
>>> blk_mq_freeze_queue() waits for q_usage_counter to drop to zero, because
>>> a queue reference is held by bios on the plug list and because the
>>> __bio_queue_enter() call in __submit_bio() waits for the queue to be
>>> unfrozen.
>>>
>>> This patch fixes the following deadlock:
>>>
>>> Workqueue: dm-51_zwplugs blk_zone_wplug_bio_work
>>> Call trace:
>>>  __schedule+0xb08/0x1160
>>>  schedule+0x48/0xc8
>>>  __bio_queue_enter+0xcc/0x1d0
>>>  __submit_bio+0x100/0x1b0
>>>  submit_bio_noacct_nocheck+0x230/0x49c
>>>  blk_zone_wplug_bio_work+0x168/0x250
>>>  process_one_work+0x26c/0x65c
>>>  worker_thread+0x33c/0x498
>>>  kthread+0x110/0x134
>>>  ret_from_fork+0x10/0x20
>>>
>>> Call trace:
>>>  __switch_to+0x230/0x410
>>>  __schedule+0xb08/0x1160
>>>  schedule+0x48/0xc8
>>>  blk_mq_freeze_queue_wait+0x78/0xb8
>>>  blk_mq_freeze_queue+0x90/0xa4
>>>  queue_attr_store+0x7c/0xf0
>>>  sysfs_kf_write+0x98/0xc8
>>>  kernfs_fop_write_iter+0x12c/0x1d4
>>>  vfs_write+0x340/0x3ac
>>>  ksys_write+0x78/0xe8
>>>
>>> Cc: Christoph Hellwig <hch@lst.de>
>>> Cc: Damien Le Moal <dlemoal@kernel.org>
>>> Cc: Yu Kuai <yukuai1@huaweicloud.com>
>>> Cc: Ming Lei <ming.lei@redhat.com>
>>> Cc: stable@vger.kernel.org
>>> Fixes: dd291d77cc90 ("block: Introduce zone write plugging")
>>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>>> ---
>>>
>>> Changes compared to v1: fixed a race condition. Call bio_zone_write_plugging()
>>>   only before submitting the bio and not after it has been submitted.
>>>
>>>  block/blk-core.c | 18 ++++++++++++++++--
>>>  1 file changed, 16 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/block/blk-core.c b/block/blk-core.c
>>> index b862c66018f2..713fb3865260 100644
>>> --- a/block/blk-core.c
>>> +++ b/block/blk-core.c
>>> @@ -621,6 +621,13 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
>>>  	return BLK_STS_OK;
>>>  }
>>>  
>>> +/*
>>> + * Do not call bio_queue_enter() if the BIO_ZONE_WRITE_PLUGGING flag has been
>>> + * set because this causes blk_mq_freeze_queue() to deadlock if
>>> + * blk_zone_wplug_bio_work() submits a bio. Calling bio_queue_enter() for bios
>>> + * on the plug list is not necessary since a q_usage_counter reference is held
>>> + * while a bio is on the plug list.
>>> + */
>>>  static void __submit_bio(struct bio *bio)
>>>  {
>>>  	/* If plug is not used, add new plug here to cache nsecs time. */
>>> @@ -633,8 +640,12 @@ static void __submit_bio(struct bio *bio)
>>>  
>>>  	if (!bdev_test_flag(bio->bi_bdev, BD_HAS_SUBMIT_BIO)) {
>>>  		blk_mq_submit_bio(bio);
>>> -	} else if (likely(bio_queue_enter(bio) == 0)) {
>>> +	} else {
>>>  		struct gendisk *disk = bio->bi_bdev->bd_disk;
>>> +		bool zwp = bio_zone_write_plugging(bio);
>>> +
>>> +		if (unlikely(!zwp && bio_queue_enter(bio) != 0))
>>> +			goto finish_plug;
>>>  	
>>>  		if ((bio->bi_opf & REQ_POLLED) &&
>>>  		    !(disk->queue->limits.features & BLK_FEAT_POLL)) {
>>> @@ -643,9 +654,12 @@ static void __submit_bio(struct bio *bio)
>>>  		} else {
>>>  			disk->fops->submit_bio(bio);
>>>  		}
>>> -		blk_queue_exit(disk->queue);
>>> +
>>> +		if (!zwp)
>>> +			blk_queue_exit(disk->queue);
>>>  	}
>>
>> This is pretty ugly, and I honestly absolutely hate how there's quite a
>> bit of zoned_whatever sprinkling throughout the core code. What's the
>> reason for not unplugging here, unaligned writes? Because you should
>> presumable have the exact same issues on non-zoned devices if they have
>> IO stuck in a plug (and doesn't get unplugged) while someone is waiting
>> on a freeze.
>>
>> A somewhat similar case was solved for IOPOLL and queue entering. That
>> would be another thing to look at. Maybe a live enter could work if the
>> plug itself pins it?
> 
> What about this patch, completely untested...

It's exactly the same thing, more zoned sprinkling in code that should
not need to care. Only difference is that it moved to a function.

-- 
Jens Axboe

