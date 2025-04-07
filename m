Return-Path: <stable+bounces-128554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 010F6A7E0C0
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 16:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC5393AFAE5
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 14:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BA91CD210;
	Mon,  7 Apr 2025 14:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OjNRpCBv"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED681CAA9E
	for <stable@vger.kernel.org>; Mon,  7 Apr 2025 14:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744034709; cv=none; b=J82BpsB/wrbQVHJ0Ffinlx4LBsviAOisTvY8mgVGgTJM08ZZ+OrODMQ2DO41fcP+wVRckGdfkQmUgIt/CBlgN+D4Oe7g4tK7UHLtQjLlg7I/57vFac/y9fOQ1ob2FHXKWWfQIuunMLWVz3ehtn8wJxxfNitdvu/Y5G11kwQLwsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744034709; c=relaxed/simple;
	bh=8rTBrjU7WEbXVPx/Yiqa2sA20+TaAZJFX/oS/EAcwzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mlSEy/NvEcVjIDj4YKkD+ynS+1Fykh0MQk4VFGVhU5y7Ag70Mw6K56oSQLcx4Y2hfX1/depGMzwLizH8Jldw0BsYb7hCUS9+omTGuitl8errPiH3Xl6reB1wHJsNlyxyxgNEvr5h5HY7a/8Bvpil4F7ZpyqdwFFFrf2DPuTqMD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OjNRpCBv; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-85e15dc8035so110278939f.0
        for <stable@vger.kernel.org>; Mon, 07 Apr 2025 07:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744034707; x=1744639507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ckFV/anSlOVmmBa0Q7XtGoLVqAn0zuW7LC82t7EokqE=;
        b=OjNRpCBvSGAgCZuLRBNgIF53uIq1Z6dOdah4Et5+EyJ/+9BWm3lf5HnVjs4nlrUCLn
         HfXWfg1DFrjowmC1voz9e+Uqjekqk+Vu0nZKVUcOBVDkUsz1PtqgjiqnO35tN/jEBUYP
         KoehPHXK4waTd87cWHD884x6VJjQaw6GNjYy4lbFLbIDyxlp7h1VgK55gEzlKnzEvV+x
         yV0lNbbiiwbp8bFT4a9SDQpcZse6ws3luEqL1F9lOjyzqziDSSw9GeGjWa9cMk6j3bxb
         dF0dONgNEnyyGrK3+o78jD/05gnsMNhkN26IqVRMp+Rcq1p4oHIJ3rhu2W08wS5HXp31
         wdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744034707; x=1744639507;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ckFV/anSlOVmmBa0Q7XtGoLVqAn0zuW7LC82t7EokqE=;
        b=ZPpTt565xgvU566EPxWb2VZhyfxvvJCI8sjap7ZerLyfD4NFgk1je+5SSr5pVg/+BL
         WJS6lGVWSrCp2tzrGxWwuqfWQPKpli/exZO3iYI3RxPRHqcr0Zhq41c+IuhkQhYnEAyu
         Ra5rlYpY7X+NkAOsySpv7aTNUxSZPfWWFsTRtuVGzabUUZBdX80g2duqvBaloR993jqK
         GbX4aaqTz8WxdMCzxwuSvWbGB3TYyTLTZvvOCrdamH5wyCteCUni0D6MxCOjThkLGw0N
         Y40hdD/xB9F4uwpUTMqF7BVJWSulLJ9THgOvKr+Arb9AK/H4oii7AU9NJNJIRDz0is1G
         V8RA==
X-Gm-Message-State: AOJu0Ywb/7c5jySGrVJpOMNLTaICDxSmJjbap4pd08d6gJezhKPID2gO
	ugSSURohfRNBOQdjDa9Sf/fGGWYCF6VUBKaQHJWpAfJr4h6LbsvmaAY/Os00GoxFMWyr3Bo6Rzb
	m
X-Gm-Gg: ASbGncu85EvUM44O3YJHM9b3oPynEWWQFPJcAzQPovc6kiQPUOTHuB4612a2Lgz2b1S
	rpHKKFBK6DiWsznbkkaLHoaXGk12aLFYFemdoYgmnI2VMGLSNwPMBF6lW1bRFJyZBMn1dFyATnc
	x96x08OpZOr1gkrxB3zgfhjNtj3KYimuHtuQHYyNM6zJbpaZVYQagH5HYB9DdSsYw0oA5lIr1Fr
	3FlbBQkBZxQdbn8QvGu8PgJqa9cVSd2e5HWGae7E/nMxrBz/QjfEQS6ZBajiWCCSTlezLhDvp92
	fORtw/BCocIpDdPG+InSEcW9Lh8AC4iEbwNQGHmt
X-Google-Smtp-Source: AGHT+IEHPsz9HqIlrQ0vxK07HJWO1Md9/9KgFg3EtX5s8Hs4vA4gMbdHLqbK8PZ8gTRrk5cfjDxOLw==
X-Received: by 2002:a05:6602:1cf:b0:861:1ba3:3e50 with SMTP id ca18e2360f4ac-8611ba33ef5mr1118221739f.0.1744034706830;
        Mon, 07 Apr 2025 07:05:06 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4b5d245e9sm2316917173.82.2025.04.07.07.05.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 07:05:05 -0700 (PDT)
Message-ID: <932669de-1d62-4b02-b191-6be3869c986e@kernel.dk>
Date: Mon, 7 Apr 2025 08:05:04 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.1-stable fix
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable <stable@vger.kernel.org>
References: <0b556f07-d48a-4d01-84a9-1c79cb82f7dd@kernel.dk>
 <c31bd917-2166-468f-a998-da44d250b274@kernel.dk>
 <2025040725-watch-animating-4561@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2025040725-watch-animating-4561@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/7/25 8:01 AM, Greg Kroah-Hartman wrote:
> On Mon, Apr 07, 2025 at 07:56:18AM -0600, Jens Axboe wrote:
>> On 4/3/25 10:55 AM, Jens Axboe wrote:
>>> Hi,
>>>
>>> Ran into an issue testing 6.1, which I discovered was introduced by
>>> a backport that was done. Here's the fix for it, please add it to
>>> the 6.1-stable mix. Thanks!
>>
>> Ping on this - saw a 6.1 stable release this weekend, but this fix
>> wasn't in it.
> 
> That's because you sent this after I announced the -rc1 release :)

Gotcha, makes sense.

> I'll add it to the queue now, thanks.

Thanks!

-- 
Jens Axboe


