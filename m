Return-Path: <stable+bounces-81186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC3B991BA3
	for <lists+stable@lfdr.de>; Sun,  6 Oct 2024 02:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0001FB21B76
	for <lists+stable@lfdr.de>; Sun,  6 Oct 2024 00:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1195C7482;
	Sun,  6 Oct 2024 00:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2PbNC2ZV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DE74C9D
	for <stable@vger.kernel.org>; Sun,  6 Oct 2024 00:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728174984; cv=none; b=G3RCzwKWDV23BFlGlh3h9wTCSKTzF02B4D3bhxWCfJI1MI1/4PpKajtR+scFqPea8v7g2pYmSjbnKxckf95lxsRlordoBc9GOk8v3RTgWJnlDIKn8666QvAo8szWpJeip8ElVgqNcWB4TDXxZrkaGTc/AstE+7gGGy40Pze+05o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728174984; c=relaxed/simple;
	bh=3YsAgxjaNnAfxCx6k7+Qrasfd1NiWse39qG242ZIikQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dC+PJQoKjEGW5INd8q3niYa/35fDpOK0p2odhiMDe1lM77NwaH148EEEf2FpDTHiiqP7HNUOYcnh6e80KOei9SrCL8JgL2knyqZX6a2vqZKiO9ab84pbnQAQ/vdUXig6iDtD1qQdGNe9/9O5b0AbeJp24dh0HcgrqSSm+35PPcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2PbNC2ZV; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e0d9b70455so2635099a91.3
        for <stable@vger.kernel.org>; Sat, 05 Oct 2024 17:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728174982; x=1728779782; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RrQlj2YvojzM59I8X95OkVlUrsJhhMGAu/0Q3InO4TY=;
        b=2PbNC2ZVhJes18F+lOb6XyrRDmlbTQwXuMC/MFU6smfDV0RF+Aj6hQJMsPVtBLy8p2
         cciywnVNdzN8kg4GS/yvDkU9TqcQXg+mqT5tXoGcGfoFByAHRZfUqAcPQ9Wg+1h5qEAE
         45OmMPWVLiVlT2puWz6M4EJ8GI3m1ehYkSXyoB22VAQfiThj2dhQw2zwBNiP+BZE2sCC
         y1aOQOfigIGts5hf4s9xD2cZABMDa+t4k/1pXINoS/O/nlCA8Z98dqGnXS86mPJ57evl
         mBYOl/A5F1PH09LgIEAWiAET1RkhU7Z/1Wfkzo5v97jfdbWHyNbDVYY0ml2fAg1kizsu
         uRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728174982; x=1728779782;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RrQlj2YvojzM59I8X95OkVlUrsJhhMGAu/0Q3InO4TY=;
        b=SPlNQgqcqFV1FjPDgusIYh/HRnLW4/6ROPj3qjiW9khHvnmHR2skKLSZq6CLEklyB0
         xhseW//zIdtRePfgx38KKqnplgeYnABW4OZmaliBkVTVrsMUQ46KCbVEf7fhzCNA2ZrD
         YbhZeLuHt+mANegHD+EGhS9of0cDpf4xs2wNDdSvecNhbvBKSGNtQMq4IxkXOEG5LHGt
         dn8RlRTEj8JgmGs2RivKCN0rRVkswWUPt2H7RbyyFnsBFwYij+RLYwfUaDSmhbxT280a
         KQGsSSguBRYEeTgWGykMzo7IXBbyzSNPC6QOxzqffl2YoBUI7BEg2sQ5y0c6xivWxkzt
         aFCA==
X-Forwarded-Encrypted: i=1; AJvYcCXYW9cjWlDql9rJdOMDrz3RT3YWvrvzRifa3cvDliV7pCqJiBHHBtNNl/XBQTzlsxDGIy0UdbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDBNyIEo7EolIUvybZUFkvw11fTP9DkCrsHCHLwQVWaUchxCjN
	W85QOvGvU50D/mCQokXJ0QQ3YcW0HGgCYLDS00UvIrzfzij/fJEGMoVq+pucWl0=
X-Google-Smtp-Source: AGHT+IFgsyI1HW/VvMNJ57lGMOCOdsh02gySVKetjct1KsIL2siQLk/lQbjYjV3W7fPLnj0qxChvLQ==
X-Received: by 2002:a17:90b:4c04:b0:2e0:7d60:759 with SMTP id 98e67ed59e1d1-2e1e620e9efmr9416886a91.3.1728174981711;
        Sat, 05 Oct 2024 17:36:21 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e85c91easm4188459a91.21.2024.10.05.17.36.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 17:36:20 -0700 (PDT)
Message-ID: <ed87fb71-cbfb-4c0a-a01c-f6cc83753432@kernel.dk>
Date: Sat, 5 Oct 2024 18:36:19 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Stable backport request (was Re: read regression for dm-snapshot
 with loopback)
To: Sasha Levin <sashal@kernel.org>
Cc: Leah Rumancik <leah.rumancik@gmail.com>, Christoph Hellwig <hch@lst.de>,
 stable@vger.kernel.org, bvanassche@acm.org, linux-block@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <CACzhbgTFesCa-tpyCqunUoTw-1P2EJ83zDzrcB4fbMi6nNNwng@mail.gmail.com>
 <20241004055854.GA14489@lst.de>
 <CACzhbgT_o0B7x9=c10QpRVEm1FuNaAU3Lh0cUGQ3B_+4s21cLw@mail.gmail.com>
 <65e41cfb-ad68-440f-9e2b-8b3341ed3005@kernel.dk> <ZwHYRg1rBi_nYNGb@sashalap>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZwHYRg1rBi_nYNGb@sashalap>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/5/24 6:22 PM, Sasha Levin wrote:
> On Fri, Oct 04, 2024 at 07:22:24PM -0600, Jens Axboe wrote:
>> On 10/4/24 6:41 PM, Leah Rumancik wrote:
>>> Cool, thanks. I'll poke around some more next week, but sounds good,
>>> let's go ahead with 667ea36378 for 6.6 and 6.1 then.
>>
>> Greg, can you pickup 667ea36378cf for 6.1-stable and 6.6-stable?
> 
> Queued up, thanks!

Thanks Sasha!

-- 
Jens Axboe


