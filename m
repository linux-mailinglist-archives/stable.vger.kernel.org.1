Return-Path: <stable+bounces-224674-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mA52MwtPsWlCtAIAu9opvQ
	(envelope-from <stable+bounces-224674-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 12:16:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 343F7262CE1
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 12:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68C6D3072DB9
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 11:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9483D6CA7;
	Wed, 11 Mar 2026 11:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjJ1hyo8"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4853D6CD7
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 11:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773227610; cv=none; b=UXWUXyOAaLnrZYgcJy3oLaQRq+mYJjlMXPDnGca3O3iVltIi+FllDzUSU3mEqis/EkM7IzM3WubtuIwCyOLam+60NHHR2kPbsm24uWaKxRzmbBLBniOv94GUZkpZ1OtfLJGEi34n6xI7cn4HUw2uIEbMWRqq0H7S/AzxFgzsBCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773227610; c=relaxed/simple;
	bh=4lX+kBPGqJ3QkimSYJuNi93y7EH2IixXEvvpadxc03o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UXqMjoXloiUvnbIetarA8HjdC8NLk/67kofvc8bw79zWOcuzglCGL6AYyclQ/jH9teLAYJpRpUrAPm8avDMNZlzcC3r3OIk4ynCQHH79Fs/rhbycgoRzC39D5mouiGcOHh/iQZYA4qaFeK+E3EyfdsVeBrt+RsZ1rwBLf944NAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjJ1hyo8; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so44855775e9.0
        for <stable@vger.kernel.org>; Wed, 11 Mar 2026 04:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773227603; x=1773832403; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qnfnqQA087ph9rwVER4jOdXVQrVQv1Zi9ON3TBE4BwA=;
        b=OjJ1hyo8Y5G/h08jF6fcpkZ/oUtq73oQ2VePvyE0nB61vPEBr/OxPycmCrWe8Qf8M/
         RpJvLNph+gVHFZ72lnvHFj5wQiJMudZkGFiuvXe9It7U6H6+czYawu4BalY8qOsRFHPG
         POeWRyvDR8uaqK7MpsFeZNFWLPFzqcdqaKYKMn5unOcp1RLdz9jeCqHjxo7aGcZzY018
         wtLsIOaL4CZX/P14wspHteJV3ZEmBVpstKsl7W+O50RefN0dvwRtlk/RHvKh/ihpQeaI
         oYH2pyW36OKypvh+SWOemCmLzyEPj6qhN29+q0P1Uo3R9SS4FbvPylZjMWE9eVuNPW1h
         ASfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227603; x=1773832403;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qnfnqQA087ph9rwVER4jOdXVQrVQv1Zi9ON3TBE4BwA=;
        b=jip09km73LyCwcQn2BcFUV4gewEWRdeu4y0VkRVi97+pMwoKZK4/sFzeu3adiTDVt4
         5h14+njKbhSMU9FF1Kd+MYBcJ3F2litNKEGy/pujyKQLJvyflHHAsl2WjqXX9BN28OGp
         +T9g+fZoYC0JTUtWXDXp3h1dr8JzB2pQ4yuuWPrMUfW8qtWAhDocv2znLYnH8whZLL06
         nsnf0cuYNDvf7kRMy0ARSZOIl7CNmJsseE+s3ierDjKHvdOguGoHa3iEvhBoolwYc5YJ
         UzKvGvC+8sJt0qHvAB/Frn7LlQOoD2RcLstcPAonEdupg3MeQhFhX+N0UCLoJZjk1+Sl
         ddsA==
X-Forwarded-Encrypted: i=1; AJvYcCUF3AayNegdz5h17tlpwL/KrM0SqcXeEwp40oOJgE5NoWYN97QHshQa1cOgY8iOLFzyOd5c6GI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4jqC/mXflAuSQ9Kqs8l/6wDen/mmKTjg8Wp2L5GpSRX4YUbTn
	IckCFRIMLimqHhW8oDdlWH6kKx6PE0HAtLoeHHIXfzARg7b9babH5tML
X-Gm-Gg: ATEYQzyw03v0gyzDM/iSwAQEKMk8rR0wBB6C5ZEnEuSpCJN8cMaBAsjrMat6q2mzGnu
	pidhRdPHn5iP3fKetm9RtlKF9FQl3qFbsWpB4xTDwOuQAadQuye06vdBFyMm0MkVEACLTvICEF8
	HKB6aD8WX4ifToIcLdNnB1axMJGKZsedL8ZEIol9tfa4EZv0oANQxKvfAiZBu6BozHK2M8cdYjI
	GsyH5kpTZPC4a9nIxq3gwcLUj0PwldhSV2TNYmSU8KMi7YpEw4W39pKaNYbueXlLuIrxxg5VS8d
	LGkx6JNSCoSci33wSeytuD7dl4nQDsGGqmxg7/DbInwKXEVjslUqujZ4mP0XIfGjrgityyVbij5
	H+NoRigocLCikIqzmwTer/MT7wDWsse0NRdrSeJ5oapAwshW4DybkFj264MjOUSfWEAfw8qLqyX
	eHDKtM05C6oGpyc4IGyO9mt1m+UXH1lbkX4hiPBGpT4avSTyIvKe0K3AR1NNMK8MJDVieSX5cuD
	aAeTUWD3+EoG7HDLRBja6G0l1ukALbGQ5/lvsdCjEKgsNoGwK785tqOGg==
X-Received: by 2002:a05:600c:154d:b0:485:3983:aba2 with SMTP id 5b1f17b1804b1-4854b109d15mr35244795e9.23.1773227603058;
        Wed, 11 Mar 2026 04:13:23 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:bf9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854e67e8d6sm2339475e9.1.2026.03.11.04.13.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 04:13:22 -0700 (PDT)
Message-ID: <39d1678f-7a7e-43d5-a92d-0b26b9bfd44e@gmail.com>
Date: Wed, 11 Mar 2026 11:13:20 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] io_uring: ensure ctx->rings is stable for task work
 flags manipulation
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Cc: naup96721@gmail.com, stable@vger.kernel.org
References: <20260310145521.68268-1-axboe@kernel.dk>
 <20260310145521.68268-2-axboe@kernel.dk>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260310145521.68268-2-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 343F7262CE1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224674-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/10/26 14:45, Jens Axboe wrote:
> If DEFER_TASKRUN | SETUP_TASKRUN is used and task work is added while
> the ring is being resized, it's possible for the OR'ing of
> IORING_SQ_TASKRUN to happen in the small window of swapping into the
> new rings and the old rings being freed.
> 
> Prevent this by adding a 2nd ->rings pointer, ->rings_rcu, which is
> protected by RCU. The task work flags manipulation is inside RCU
> already, and if the resize ring freeing is done post an RCU synchronize,
> then there's no need to add locking to the fast path of task work
> additions.
> 
> Note: this is only done for DEFER_TASKRUN, as that's the only setup mode
> that supports ring resizing. If this ever changes, then they too need to
> use the io_ctx_mark_taskrun() helper.
> 
> Link: https://lore.kernel.org/io-uring/20260309062759.482210-1-naup96721@gmail.com/
> Cc: stable@vger.kernel.org
> Fixes: 79cfe9e59c2a ("io_uring/register: add IORING_REGISTER_RESIZE_RINGS")
> Reported-by: Hao-Yu Yang <naup96721@gmail.com>
> Suggested-by: Pavel Begunkov <asml.silence@gmail.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   include/linux/io_uring_types.h |  1 +
>   io_uring/io_uring.c            |  2 ++
>   io_uring/register.c            | 20 ++++++++++++++++++--
>   io_uring/tw.c                  | 24 ++++++++++++++++++++++--
>   4 files changed, 43 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
> index 3e4a82a6f817..dd1420bfcb73 100644
> --- a/include/linux/io_uring_types.h
> +++ b/include/linux/io_uring_types.h
> @@ -388,6 +388,7 @@ struct io_ring_ctx {
>   	 * regularly bounce b/w CPUs.
>   	 */
>   	struct {
> +		struct io_rings	__rcu	*rings_rcu;
>   		struct llist_head	work_llist;
>   		struct llist_head	retry_llist;
>   		unsigned long		check_cq;
> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
> index ccab8562d273..20fdc442e014 100644
> --- a/io_uring/io_uring.c
> +++ b/io_uring/io_uring.c
> @@ -2066,6 +2066,7 @@ static void io_rings_free(struct io_ring_ctx *ctx)
>   	io_free_region(ctx->user, &ctx->sq_region);
>   	io_free_region(ctx->user, &ctx->ring_region);
>   	ctx->rings = NULL;
> +	RCU_INIT_POINTER(ctx->rings_rcu, NULL);
>   	ctx->sq_sqes = NULL;
>   }
>   
> @@ -2703,6 +2704,7 @@ static __cold int io_allocate_scq_urings(struct io_ring_ctx *ctx,
>   	if (ret)
>   		return ret;
>   	ctx->rings = rings = io_region_get_ptr(&ctx->ring_region);
> +	rcu_assign_pointer(ctx->rings_rcu, rings);
>   	if (!(ctx->flags & IORING_SETUP_NO_SQARRAY))
>   		ctx->sq_array = (u32 *)((char *)rings + rl->sq_array_offset);
>   
> diff --git a/io_uring/register.c b/io_uring/register.c
> index a839b22fd392..5f2985ba0879 100644
> --- a/io_uring/register.c
> +++ b/io_uring/register.c
> @@ -487,6 +487,18 @@ static void io_register_free_rings(struct io_ring_ctx *ctx,
>   			 IORING_SETUP_CQE32 | IORING_SETUP_NO_MMAP | \
>   			 IORING_SETUP_CQE_MIXED | IORING_SETUP_SQE_MIXED)
>   
> +static void io_resize_assign_rings(struct io_ring_ctx *ctx, struct io_rings *rings)
> +{
> +	/*
> +	 * Just mark any flag we may have missed and that the application
> +	 * should act on unconditionally. Worst case it'll be an extra
> +	 * syscall.
> +	 */
> +	atomic_or(IORING_SQ_TASKRUN | IORING_SQ_NEED_WAKEUP, &rings->sq_flags);
> +	ctx->rings = rings;
> +	rcu_assign_pointer(ctx->rings_rcu, rings);
> +}
> +
>   static int io_register_resize_rings(struct io_ring_ctx *ctx, void __user *arg)
>   {
>   	struct io_ctx_config config;
> @@ -579,6 +591,7 @@ static int io_register_resize_rings(struct io_ring_ctx *ctx, void __user *arg)
>   	spin_lock(&ctx->completion_lock);
>   	o.rings = ctx->rings;
>   	ctx->rings = NULL;
> +	RCU_INIT_POINTER(ctx->rings_rcu, NULL);
>   	o.sq_sqes = ctx->sq_sqes;
>   	ctx->sq_sqes = NULL;

Should be better to not have a transient null, and then there
is no need to check for that in task_work. I.e. don't zero it
and only assign the new value if you successfully created a
new set of rings.

-- 
Pavel Begunkov


