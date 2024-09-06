Return-Path: <stable+bounces-73767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7245196F107
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 12:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E6981C21761
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 10:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913631C8FAB;
	Fri,  6 Sep 2024 10:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REG6L9wf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCD21C8FA2;
	Fri,  6 Sep 2024 10:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725617269; cv=none; b=t2tLqciDEvX/DSbt6SBTp3bhDc/VjBt82fjk0dTvRqcu6cc9JKUriEZsDSaqSrDQBYY0IwtiaK0aGZhYjK+uQyLTFFm4v7xyP3toyBm4Q0O0TdZAPGjnLoSvqfHKddx/ovMXKNUt3TWyMytzcrgJqcuDBaCx3VZIbqPau9gHF+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725617269; c=relaxed/simple;
	bh=FCSv6cJ5FuPF/zRuRCjlJnApaDNcik03hhh2o208Kdw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bw8lyXOfwjtGtwb2g8K9VonCuO1weBcnIvGdT1ZkRjC2UlHSrpynQj6pZf3h+wLQB0fz0HZ4+2BGJj1+VMorN/mAAhYf9JX48WnjQpovb7KrGsdgPEVpq6i0JfC9XubVJoDbCkC41m+Uod1B/2XI6tzHG7SmlyBNr+7+uZHX+Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REG6L9wf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4068BC4CEC4;
	Fri,  6 Sep 2024 10:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725617268;
	bh=FCSv6cJ5FuPF/zRuRCjlJnApaDNcik03hhh2o208Kdw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=REG6L9wf7TZO56IfPnqKdeu+elBvPdpxYpEZi8N/byczUXM2hmHqq4uvSOqVvjIkX
	 GSeYRk7VV15c5yPk3/aE+rvTQgsbNCf+ch9V1kPPN3Mrxp0xALkpuqYJtvL7R/WdqN
	 c0fAWAON305uFyKffeSh/TUJRZhS2ybUGnByIEyeaJq0ge1lY/Io+gSYrQIV65Q8+w
	 xgpdMgUl+zKqS/oWd8LEKTGtdXcV+NSMhpDVnLpQoGwSNwDjasqDSUwvIT3RfCfAt7
	 VTv+br6eWWaBS/HbuGT44PfvGIhIMdoegt9Pup+HuprhF06MnNYYpsJDaUop+1iDPN
	 EeIu391794a/g==
Message-ID: <d5505e7f-19db-44dd-8c3f-5b43cfff6b29@kernel.org>
Date: Fri, 6 Sep 2024 18:07:44 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Wu Bo <wubo.oduw@gmail.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] Revert "f2fs: stop allocating pinned sections
 if EAGAIN happens"
To: Wu Bo <bo.wu@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20240906083117.3648386-1-bo.wu@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240906083117.3648386-1-bo.wu@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/9/6 16:31, Wu Bo wrote:
> On Tue, Feb 20, 2024 at 02:50:11PM +0800, Chao Yu wrote:
>> On 2024/2/8 16:11, Wu Bo wrote:
>>> On 2024/2/5 11:54, Chao Yu wrote:
>>>> How about calling f2fs_balance_fs() to double check and make sure there is
>>>> enough free space for following allocation.
>>>>
>>>>          if (has_not_enough_free_secs(sbi, 0,
>>>>              GET_SEC_FROM_SEG(sbi, overprovision_segments(sbi)))) {
>>>>              f2fs_down_write(&sbi->gc_lock);
>>>>              stat_inc_gc_call_count(sbi, FOREGROUND);
>>>>              err = f2fs_gc(sbi, &gc_control);
>>>>              if (err == -EAGAIN)
>>>>                  f2fs_balance_fs(sbi, true);
>>>>              if (err && err != -ENODATA)
>>>>                  goto out_err;
>>>>          }
>>>>
>>>> Thanks,
>>>
>>> f2fs_balance_fs() here will not change procedure branch and may just trigger another GC.
>>>
>>> I'm afraid this is a bit redundant.
>>
>> Okay.
>>
>> I guess maybe Jaegeuk has concern which is the reason to commit
>> 2e42b7f817ac ("f2fs: stop allocating pinned sections if EAGAIN happens").
> 
> Hi Jaegeuk,
> 
> We occasionally receive user complaints about OTA failures caused by this issue.
> Please consider merging this patch.

I'm fine w/ this patch, but one another quick fix will be triggering
background GC via f2fs ioctl after fallocate() failure, once
has_not_enough_free_secs(, ovp_segs) returns false, fallocate() will
succeed.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> 
> Thanks
> 
>>
>> Thanks,
>>
>>>
>>>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


