Return-Path: <stable+bounces-16417-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D46358407B4
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 14:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 828741F227CD
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 13:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4539657AF;
	Mon, 29 Jan 2024 13:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SdRiaIhI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07230657B5
	for <stable@vger.kernel.org>; Mon, 29 Jan 2024 13:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706536710; cv=none; b=RKah8w4Z0D1kZtKro37K4k9TY0Ojc1+3EjdhccWSZfd/RMoJn+0MimCuJA6FPnNleKg25jjdiiJ358dRSpN4TB4XfiICNgzG5qHxwYQ+xxbKiyJGv6MYO1/XD+C8ne+N3/lzHmNUcYqZ2g/rEQaeuv5NloKdzEYFg/Ei7XzW+L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706536710; c=relaxed/simple;
	bh=y48ldhgmUteIT+QxkwDO00dkg8kHn6oV31PBR6FRHRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OYRU7l4wM8SRNvJZ6IKV878eq6yuxIFbYPkQiMuvSZuO4p+ae39Z3Qcd8MsR+RTxC8mtUHH0Y4mE4lTjk/jrcDd8NZ9b8GUKEu3wafo7iO+J7JITBYUktUUCcqboYjd02BhmSFxw65OnJOILE3ZzB+TEjJnF9nR9lAAH6aINI9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SdRiaIhI; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d8e07a45a1so2833845ad.1
        for <stable@vger.kernel.org>; Mon, 29 Jan 2024 05:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706536707; x=1707141507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8zcr8bAW3nHh/yZfh9fbXuXuWVRPjHHfOdMz1V4E0TE=;
        b=SdRiaIhIyWcAMsPh2kSHwYz8m68bXnTFlQH38xqe6gYkOIGDm3AaRcrzA39cQDQZoI
         huZ/hY+Z4t/00MzsJY+6o/AnWzNM71yW99Tdo42ez4dKIBaBUNuTS7qswv9Q3znM78OH
         e9F2c+ZgEOhB60XUv4q2SY3xJLwHJFadm9tJds6RQYwkdmDKcDY+qiwnGgbDhaawzvX/
         BjGzzolSBFf57xWZ+3ydvNy7DuAEyubCajmeX9hH923MxM3CL+C4lCd0VFfV6BolW7+H
         g6H+O1vmY6QKdEmj0XsmIkXNksnaEeCRYFO8+DKYD7E2HYMrOEhK0VQzlHW2iAXj/cjY
         aGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706536707; x=1707141507;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8zcr8bAW3nHh/yZfh9fbXuXuWVRPjHHfOdMz1V4E0TE=;
        b=juAE0B0jpjAqiQsG/GIorLtr9vgnmrSwzG9mEUaUP+oZLFpRfkY9OVynknMVm7amIt
         ySfBI66Lfz0fl85dEuN8gdI5zIQ2KAzk8FanBkLgGb9qZwCXcLzuR8Oq4uVddObjeVqJ
         jJgbFTMmLa1sDiNkR/d7h/PDLpeDv/2bJJL39Fj0AFrl4x5VXDLZnOTKXFVC0wAjbj6m
         OFYo6EKqhHGVE7pP1qu9xSNBHsSNgAAZVBu+NOoFvIebv9WgfUNxo8ofw5WDhSttom7/
         P0rtAWEpQi3LCVPiKNEXgXTCDinwm1COFJjj1JzSjIJ6P2gu1xEUoIbEcdrgVv1JPZG3
         Rdbw==
X-Gm-Message-State: AOJu0YxOvJQEAHgdZEZfDNM9EBmv1XmGaL4Mk1NjWo9Zsc6PEONwZYvn
	kI/9eRvRxYszZbd275o6cylhqjVOPgPafUjSBYY4rFThcYiQkohtMjgQnUAeKBg=
X-Google-Smtp-Source: AGHT+IEYOdFEWVUh4/4tvmU0s/bKl+WFtuT+3/PgSwYvYrDl7rd6ZEDkIIi9zotBwcEyXP2o0OTEFA==
X-Received: by 2002:a05:6a20:3d81:b0:19c:b1f1:614e with SMTP id s1-20020a056a203d8100b0019cb1f1614emr1518151pzi.5.1706536706956;
        Mon, 29 Jan 2024 05:58:26 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id q13-20020aa7982d000000b006ddc661a619sm5797965pfl.7.2024.01.29.05.58.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 05:58:26 -0800 (PST)
Message-ID: <6c91c497-0653-4901-a673-66922f3f5e7e@kernel.dk>
Date: Mon, 29 Jan 2024 06:58:24 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.7 427/641] io_uring: dont check iopoll if request
 completes
Content-Language: en-US
To: Jiri Slaby <jirislaby@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Pavel Begunkov <asml.silence@gmail.com>
References: <20240122235818.091081209@linuxfoundation.org>
 <20240122235831.353232285@linuxfoundation.org>
 <9fc00f54-24d5-44a6-a690-d4f73c37caa1@kernel.org>
 <8ec60240-800e-40b5-838f-b4779b5fee36@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <8ec60240-800e-40b5-838f-b4779b5fee36@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/29/24 12:34 AM, Jiri Slaby wrote:
> On 29. 01. 24, 7:44, Jiri Slaby wrote:
>> On 23. 01. 24, 0:55, Greg Kroah-Hartman wrote:
>>> 6.7-stable review patch.  If anyone has any objections, please let me know.
>>
>> Hi,
>>
>> 6.7.2 fails in liburing tests (both x64 and x86-32 lib on x64 kernel):
>> [  115s] Tests failed (5): <fd-pass.t> <msg-ring-overflow.t> <pipe-bug.t> <poll-race-mshot.t> <reg-hint.t>
>>
>> I cannot reproduce locally, that happens only in openSUSE build machinery (the errors are transient, the links might not be valid in the future):
>> https://build.opensuse.org/package/live_build_log/openSUSE:Factory:Staging:H/liburing/standard/i586
>> https://build.opensuse.org/package/live_build_log/openSUSE:Factory:Staging:H/liburing/standard/x86_64
>>
>> So I cannot tell if 6.8-rc is affected.
>>
>> I suspect one of the 6.7.2 uring changes:
>> e24bf5b47a57 io_uring: adjust defer tw counting
>> 22eed9134509 io_uring: ensure local task_work is run on wait timeout
>> ba8d8a8a36b2 io_uring/rw: ensure io->bytes_done is always initialized
>> d413a342275d io_uring: don't check iopoll if request completes
>>
>> It looks like EINVAL is received unexpectedly (see below). Any ideas?
> 
> Forget about this. The build service is currently broken and is using
> 5.14 kernel instead of 6.7.2.

Ah that makes sense, the tests should work (in the sense that they
should not fail) on eg 5.15-stable, but I guess the 5.14 kernel is
something else entirely? Most of them would return 77 on older kernels
where a specific feature is missing, but eg pipe-bug.t should definitely
run and pass on older kernels.

-- 
Jens Axboe


