Return-Path: <stable+bounces-80578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1B798DFF2
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 17:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37C64B2CC0D
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0921D0BBE;
	Wed,  2 Oct 2024 15:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="cfbiVh4B"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37ED31D150B
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 15:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727884146; cv=none; b=Uamf0D+2P2SVqEqoA7HfNjQow8IiRwLGQvvwTeiTxEqZQQZO5LMDVdpytExy7mxXuDlYoKJN8Y93YWl4u8PdR8j6CVriMS9JGlESbnBGtXjcPlecVlLtAQfAbzZwW4NVvemn5FGkX6vvNmnHdSzlEpE0OpRlTrZ92bfG8wUI38U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727884146; c=relaxed/simple;
	bh=aaj9zre/uwqMblhG4pe0pijifwiVwEqQ4QKDRrej9ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GKnVT3He/HSkLRTXsF8uhArnLQYZobNilXn6EvgENkIBGXwo/QNR0HwZTZDZwABe4b7tpAyb6JboMVDSicWIpH8h/auNrkQojHFC827zfGFv1Rue7jr9AdxAV6ecfH+JVMLlCAvDVJGqqz9QqYeJ8uLUpsTwDJEFeosRwWeMrso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=cfbiVh4B; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-82cf3286261so267225039f.0
        for <stable@vger.kernel.org>; Wed, 02 Oct 2024 08:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727884143; x=1728488943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mIkrrivDIMdnYD+IC6hZMjebhopI4PLOHI/5u4DmK3U=;
        b=cfbiVh4BDompCmV5rku46S4cdIWeCMJvT7Rl+5IQW78jJehX/JfZe+txKN1CBrJjG5
         LD0c0sHAsjDSX5CCfzmHeAVakb63R3dlBrcYTPn8sqorE9wODXYqCqXMEyVKAsTLkL6p
         I9+FkeyE50KJ63ACIHaEBARXlcftIwWkdNm8aDz4t+fBx62vOxs6kk3yuUL2X1L4K0ej
         mjNBIdLhXPV/V6xh+5M0F3a+XBwf+92nfsJzhXlAzyAQcI/04Cu8z2oSCVmqcDuaCf6H
         E6vpIm0Jw9nbrtcRuPxYsxBdm/JgmyfZT96XiSyo1ysbF+BEIw7xu1lbb977FJru9LWm
         IcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727884143; x=1728488943;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mIkrrivDIMdnYD+IC6hZMjebhopI4PLOHI/5u4DmK3U=;
        b=Wixa2aopvfAWmwN7RdtThH7HQbs/nFZ07MK5OQCu2d30+Pl4xpXxBcfhVjYALY2pbE
         EG2UBml73sDV2aUm54P2mT5WMmTZwiFl6It6vRudVCLrElxxAs1tLCI4DTdNT3R3YcSr
         k5zoeUAUxNzfSdp7vWjwjhRUNO/qdo8Ga1aCrwATZ36T+CGL9Nl/1k06X9VvA5Mjq1Ij
         lURQGy7ROfPvuk+bvjN4COee5iu5fvIVNNt+olLZ0D+hE2sRMityIzQvpen/nqx3Ym0Q
         r1GDu7UMZVn1mnLjmiihvMzdHCmYXFRHw+YaNyN94IngU6b5ZE4N5lpAm33MVIehhZ1s
         QuKA==
X-Gm-Message-State: AOJu0YxZ3gL8DhF6qwNjASA0x36HPpKwZVzvfIuWnS3e/rsjrTwjGa8m
	y6D6JqxoISLwPygenx5aoUzZgUb3kbf8Phk35UypBafbYbEMEqJWBOG9gSROnIs=
X-Google-Smtp-Source: AGHT+IG6er745iv+LFb8ahTTNZNWjsljGR6VeD2Qtr2lPcs1APZMJ3u/N5ry0PbsaZO8vVwYrtkSOw==
X-Received: by 2002:a05:6602:150c:b0:834:d7b6:4fea with SMTP id ca18e2360f4ac-834d83f5d81mr426633539f.6.1727884142885;
        Wed, 02 Oct 2024 08:49:02 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d8888c33f8sm3182936173.89.2024.10.02.08.49.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 08:49:02 -0700 (PDT)
Message-ID: <8fcfa0a7-5641-48f2-b368-b43219f9daff@kernel.dk>
Date: Wed, 2 Oct 2024 09:49:00 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 6.6.y 00/15] Some missing CVE fixes
To: Vegard Nossum <vegard.nossum@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, pavel@denx.de, cengiz.can@canonical.com,
 mheyne@amazon.de, mngyadam@amazon.com, kuntal.nayak@broadcom.com,
 ajay.kaher@broadcom.com, zsm@chromium.org, dan.carpenter@linaro.org,
 shivani.agarwal@broadcom.com, ahalaney@redhat.com, alsi@bang-olufsen.dk,
 ardb@kernel.org, benjamin.gaignard@collabora.com, bli@bang-olufsen.dk,
 chengzhihao1@huawei.com, christophe.jaillet@wanadoo.fr, ebiggers@kernel.org,
 edumazet@google.com, fancer.lancer@gmail.com, florian.fainelli@broadcom.com,
 harshit.m.mogalapalli@oracle.com, hdegoede@redhat.com, horms@kernel.org,
 hverkuil-cisco@xs4all.nl, ilpo.jarvinen@linux.intel.com, jgg@nvidia.com,
 kevin.tian@intel.com, kirill.shutemov@linux.intel.com, kuba@kernel.org,
 luiz.von.dentz@intel.com, md.iqbal.hossain@intel.com,
 mpearson-lenovo@squebb.ca, nicolinc@nvidia.com, pablo@netfilter.org,
 rfoss@kernel.org, richard@nod.at, tfiga@chromium.org,
 vladimir.oltean@nxp.com, xiaolei.wang@windriver.com, yanjun.zhu@linux.dev,
 yi.zhang@redhat.com, yu.c.chen@intel.com, yukuai3@huawei.com
References: <20241002150606.11385-1-vegard.nossum@oracle.com>
 <612f0415-96c2-4d52-bd3d-46ffa8afbeef@kernel.dk>
 <69e265b4-fae2-4a60-9652-c8db07da89a1@oracle.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <69e265b4-fae2-4a60-9652-c8db07da89a1@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/24 9:46 AM, Vegard Nossum wrote:
> 
> On 02/10/2024 17:26, Jens Axboe wrote:
>> On 10/2/24 9:05 AM, Vegard Nossum wrote:
>>> Christophe JAILLET (1):
>>>    null_blk: Remove usage of the deprecated ida_simple_xx() API
>>>
>>> Yu Kuai (1):
>>>    null_blk: fix null-ptr-dereference while configuring 'power' and
>>>      'submit_queues'
>>
>> I don't see how either of these are CVEs? Obviously not a problem to
>> backport either of them to stable, but I wonder what the reasoning for
>> that is. IOW, feels like those CVEs are bogus, which I guess is hardly
>> surprising :-)
> 
> IIRC the ida API change is not a fix for a CVE, but it makes the other
> patch apply more easily.

Ah ok

> The other patch is a fix for CVE-2024-36478, here's the CVE assignment:
> 
> https://lore.kernel.org/linux-cve-announce/2024062136-CVE-2024-36478-d249@gregkh/
> 
> An issue being a CVE just means that it has been identified as a
> "weakness" and assigned a unique identifier, it does not mean it's
> necessarily a severe issue or that there is an exploit for it or
> anything like that.
> 
> Unfortunately for distributions, there may be various customers or
> government agencies which expect or require all CVEs to be addressed
> (regardless of severity), which is why we're backporting these to stable
> and trying to close those gaps.

It's a root only thing, have a hard time a world in which that's a CVE.
Not that I really care, what constitutes a CVE has a wide spread.

-- 
Jens Axboe

