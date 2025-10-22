Return-Path: <stable+bounces-189020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 416BDBFD6E3
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 19:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F1E18584DB9
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 16:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF7A1F63D9;
	Wed, 22 Oct 2025 16:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="s3qodkyT"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B39135B123
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 16:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761151725; cv=none; b=rAe3y54ZFosFIAc7GjiBCZcgDLZmyFdBNvV4ZgWPt5Fb6TCkszLXD+mgk+w56nk0aH0k8kBazEP8nmDSjOdnxm89h1SRWSiGnerv/nhV0CDXlXqtnp5Jg7dlRujqWKoJB4sJ35q1Pj8z+7kqPzyU3pUUVV583OjRG/qofkX3eUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761151725; c=relaxed/simple;
	bh=cXXlxOryLhpoil0xaDUUECoDJ8mGRDgrUJYRq3Usfw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dudn8eTLESM6B1rXi6JjYQzK7UcbCAlAckvpxroxz1BHbtadS/GoWx4g2mvp/VWZNHD41B+sbnFpPvVk90pksehF80MA0ZjnhnKRcbCPHtp6lCEsLv3ab/Z+iMy7HGhw5UzOzKVmX6smsaLlnHD/KVT7rnzJTc2ueibbCEyu/GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=s3qodkyT; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-940d25b807bso208059739f.1
        for <stable@vger.kernel.org>; Wed, 22 Oct 2025 09:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761151721; x=1761756521; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lwpd3rmy29H1ooJYC2gH6QQxli+wXCcDxKShQQGlixI=;
        b=s3qodkyTkdBVX5VCQ4D8GW/vizTa/Gk+zIgJ5x7ZLOCy82gibra+rwIQrhU0SReUWi
         WpLl0SQ2l1dyTmbvNvbzNIVrQoFhvJZGoXNPSyZWfhdCaUShWIvuO01SiZ7Dzp9HWqZn
         tMRmWpws2/aywnGAM1l03fySIWiuyU27pdqv+TjUhipLyRU+x4EAN7I5RlbZ/kauHfjr
         pFG8vpi6T40NiWnsf2qKO6Z6kpDgsKJ7p5GTsYPoS/j0MftbkFolncomajdH+IwDkyPs
         1VGmbuhPE1VuNVD8Fru4ScYPugKTKX1FG3tJLJ76CZChCMwrL5Ku+qqmYQsFsHrZ4D/Y
         Nzhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761151721; x=1761756521;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lwpd3rmy29H1ooJYC2gH6QQxli+wXCcDxKShQQGlixI=;
        b=CVwLs43Ks/k0QOVExm0fJmFkQDzKmZ80VQ+Br3hNN4Dm3d5Hh3tcYKGcq9QqSP+kJD
         D75VeaFGdpsUY2k1rJrzef/9dide79m2foYCe307nY8557vfAKp7P3gfgEZ2PgwoX5sx
         hzZaXldc9UxMX7p8dEFInMuQOCla4dUhmYDiM+V4cbjYIZWlMXo0SJE1TCLDQTC5FtGw
         HCP+nVq1Sm0qP2QIYDgP+AK1n2SXJujMI5Adq6gXoixLELW491wK+w6LATpl2uqlAH4h
         /mw7hXHKgitnSYTqyJchfiq0AqKE7IXh4xesu0NZlBzAR/U8E19PmAl4QeUcntzvJPta
         jsyw==
X-Forwarded-Encrypted: i=1; AJvYcCV6di9gJwRsmh0G5LsfBP5AbLX1g95LI7HQHpsjDa4TA5ufI9tEJGz5BwXGe+vKyPpwLGg2wXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YylAjoMglT+TpzyvW8/GhsTzSxc0B3V/0T1kKO7kybhqIRvk+BA
	muuGgEOEl73tcfY3DWvk3cDQQHIRXvMHnI+oUB4sZzl47Y9Vf6ACGfrvImgGG47oX/A=
X-Gm-Gg: ASbGncta3hfZydYLOUyueCOwu7npzoMREDFnEPFA2UQKWTe5CaSPlnXFfgx4JB58oTY
	5bohg9oTUYVBK0VXVhK43d8k7xgw+DA5TR4zbMSz0dOglj867ANGyzdz1CbtitI0xGvUhGapoCT
	TBAi/oquvSGq2fjtzgnyPUFrtyoWO2x3bAMoaIPGAkM3mr8U/EqSKMHOOQMGLhW0OfJ/ztJ02cj
	xw6Sjm2KBcWmnQqfG6o11ysrHdavTGpIJDm04+IR6iPW+215IZG8Ta5O6mobMgD5KiyFP6npprU
	sUfDfJcKik97Y/xxuf8/sixxXODD6IQTLkQKDF6poytnDsbr7QDaM71JPKbdloBnCsJm8qCtbdC
	Y5zShAsketHB5s4M61gzNXyKMhX+Ag6tfI8yn5N7bNeDnnTPnApz3Dr2u4wKxYP1f0naNbfOmkM
	UM8LAQ/fU=
X-Google-Smtp-Source: AGHT+IGbr9XnR2TUbKEnjg/86hT46+IWS1oykTlATWHGDSD8RC49VTaKnuN6LrFfvK2SIQeDITKEKw==
X-Received: by 2002:a05:6e02:348f:b0:431:da5b:9ef3 with SMTP id e9e14a558f8ab-431da5ba0a2mr12818015ab.27.1761151721532;
        Wed, 22 Oct 2025 09:48:41 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430d0611b4csm57438185ab.0.2025.10.22.09.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 09:48:40 -0700 (PDT)
Message-ID: <78c19746-132d-4e85-b4bf-9b251435cb77@kernel.dk>
Date: Wed, 22 Oct 2025 10:48:40 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] io_uring/sqpoll: switch away from getrusage() for CPU
 accounting
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: io-uring@vger.kernel.org, changfengnan@bytedance.com,
 xiaobing.li@samsung.com, lidiangang@bytedance.com, stable@vger.kernel.org
References: <20251021175840.194903-1-axboe@kernel.dk>
 <20251021175840.194903-2-axboe@kernel.dk>
 <87cy6f25h9.fsf@mailhost.krisman.be>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <87cy6f25h9.fsf@mailhost.krisman.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/25 5:35 PM, Gabriel Krisman Bertazi wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> getrusage() does a lot more than what the SQPOLL accounting needs, the
>> latter only cares about (and uses) the stime. Rather than do a full
>> RUSAGE_SELF summation, just query the used stime instead.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 3fcb9d17206e ("io_uring/sqpoll: statistics of the true utilization of sq threads")
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  io_uring/fdinfo.c |  9 +++++----
>>  io_uring/sqpoll.c | 34 ++++++++++++++++++++--------------
>>  io_uring/sqpoll.h |  1 +
>>  3 files changed, 26 insertions(+), 18 deletions(-)
>>
>> diff --git a/io_uring/fdinfo.c b/io_uring/fdinfo.c
>> index ff3364531c77..966e06b078f6 100644
>> --- a/io_uring/fdinfo.c
>> +++ b/io_uring/fdinfo.c
>> @@ -59,7 +59,6 @@ static void __io_uring_show_fdinfo(struct io_ring_ctx *ctx, struct seq_file *m)
>>  {
>>  	struct io_overflow_cqe *ocqe;
>>  	struct io_rings *r = ctx->rings;
>> -	struct rusage sq_usage;
>>  	unsigned int sq_mask = ctx->sq_entries - 1, cq_mask = ctx->cq_entries - 1;
>>  	unsigned int sq_head = READ_ONCE(r->sq.head);
>>  	unsigned int sq_tail = READ_ONCE(r->sq.tail);
>> @@ -152,14 +151,16 @@ static void __io_uring_show_fdinfo(struct io_ring_ctx *ctx, struct seq_file *m)
>>  		 * thread termination.
>>  		 */
>>  		if (tsk) {
>> +			struct timespec64 ts;
>> +
>>  			get_task_struct(tsk);
>>  			rcu_read_unlock();
>> -			getrusage(tsk, RUSAGE_SELF, &sq_usage);
>> +			ts = io_sq_cpu_time(tsk);
>>  			put_task_struct(tsk);
>>  			sq_pid = sq->task_pid;
>>  			sq_cpu = sq->sq_cpu;
>> -			sq_total_time = (sq_usage.ru_stime.tv_sec * 1000000
>> -					 + sq_usage.ru_stime.tv_usec);
>> +			sq_total_time = (ts.tv_sec * 1000000
>> +					 + ts.tv_nsec / 1000);
>>  			sq_work_time = sq->work_time;
>>  		} else {
>>  			rcu_read_unlock();
>> diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
>> index a3f11349ce06..8705b0aa82e0 100644
>> --- a/io_uring/sqpoll.c
>> +++ b/io_uring/sqpoll.c
>> @@ -11,6 +11,7 @@
>>  #include <linux/audit.h>
>>  #include <linux/security.h>
>>  #include <linux/cpuset.h>
>> +#include <linux/sched/cputime.h>
>>  #include <linux/io_uring.h>
>>  
>>  #include <uapi/linux/io_uring.h>
>> @@ -169,6 +170,22 @@ static inline bool io_sqd_events_pending(struct io_sq_data *sqd)
>>  	return READ_ONCE(sqd->state);
>>  }
>>  
>> +struct timespec64 io_sq_cpu_time(struct task_struct *tsk)
>> +{
>> +	u64 utime, stime;
>> +
>> +	task_cputime_adjusted(tsk, &utime, &stime);
>> +	return ns_to_timespec64(stime);
>> +}
>> +
>> +static void io_sq_update_worktime(struct io_sq_data *sqd, struct timespec64 start)
>> +{
>> +	struct timespec64 ts;
>> +
>> +	ts = timespec64_sub(io_sq_cpu_time(current), start);
>> +	sqd->work_time += ts.tv_sec * 1000000 + ts.tv_nsec / 1000;
>> +}
> 
> Hi Jens,
> 
> Patch looks good. I'd just mention you are converting ns to timespec64,
> just to convert it back to ms when writing to sqd->work_time and
> sq_total_time.  I think wraparound is not a concern for
> task_cputime_adjusted since this is the actual system cputime of a
> single thread inside a u64.  So io_sq_cpu_time could just return ms
> directly and io_sq_update_worktime would be trivial:
> 
>   sqd->work_time = io_sq_pu_time(current) - start.

That's a good point - I'll update both patches, folding and incremental
like the below in. Thanks!

-- 
Jens Axboe

