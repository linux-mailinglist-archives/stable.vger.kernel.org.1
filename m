Return-Path: <stable+bounces-80572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 787CC98DF2F
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 17:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA9A11C243A8
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697B51D0BA8;
	Wed,  2 Oct 2024 15:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Ns+AVoih"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BB223C9
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 15:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882953; cv=none; b=DM3DpBtGfSeuVyJNIcD1esxw7ZujM1Lr9MhYsLYbNFkDtPUeyRRGcYv1BgLpNt3+4caKm8vmPGxsvgretW2JItojonnxujrtQpi8tukrDXlDQPX73C0YtaeOCTL0ohXnGBdN+GMq5eHvperXczUSHy3JL/S/UpF83ud6b8Jn0do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882953; c=relaxed/simple;
	bh=RIQqVpmD98rk8cw0rX6CMBIy2c2HMiD50Q4AOR5xrS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pzhgb4FsuuH8OX9LNPweRMKo3ttrPGHvpiFUSkTpgRLEgbgVQ6qfPLwKTpWW3W/aHobWIzSvELAm4fAwX6jDS9HQKbcImuvMjihblDqSsZTJkNJFjZv5RtBYZLIOtcjz5nBQkOOzhjSGfArOvSkJ0gmIdKqLvMO7WQi/qVmJXx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Ns+AVoih; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a34460a45eso34006065ab.3
        for <stable@vger.kernel.org>; Wed, 02 Oct 2024 08:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727882951; x=1728487751; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x/6M+qes7zXTUVlM+gyvBxSlZYYBhmtiTmQsEyciSuE=;
        b=Ns+AVoihux49ULeWqOgQqkLcCtTh56hEFHZqm/5gifYtla6xELAFTtv0C1cgSnJtyS
         TyCgIZzt7dUsHKLNcUv5EhNSyulr46BTVymJUnkSGQsq6yOFLU5W/i31LDPbLf5b73Kn
         SwLqtKB//SlzNkhNDOksuJoBapYJl8NPvJzus8LzpHKNm6+S9Ocwga8lGHyblVwsojFC
         TJh2mXSRZsZScJIRoCzxwZLITOfNKbGCjw41zp4iQubVHos8JH6pGe+7Ex+gzUs84BzC
         pFUEK3Clpf3bdriQgg/4BLv9agbba7NI0zwnPpBFQJVl138sryB1+Gpvlaf6+uToj9I3
         T+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727882951; x=1728487751;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x/6M+qes7zXTUVlM+gyvBxSlZYYBhmtiTmQsEyciSuE=;
        b=fCif+N8ZAkwqH5tgZlHUPMbpLmC7FtSTJGLWInckHDBh2h6wSRZMCuCd1IHh39jrtj
         VjL4yqALTxS1xI0xTlYdM32inDX3DCOT8yAQPQaEt4aRPxMrkDxt2X7vQu1UmZpMKzxO
         nZSR9Q9/yVQt4eqcyLhrO5qb84EW8BRxdwNl5D7XD9S22NVva3FyOUrLOM30pBPVlBND
         DNxvvc35ITwWqGqzmeKmQawe2s2YVmoVkKbrGMTFyeP8NWYLP3vMFWLodPzQW2JLP1r7
         b1HQQ9nkv18Lki6IFBfxdaXOdyLkotMwPpePMQRC9skwtFFjSAhAxp+vKZmsn5RXKqhv
         tXsQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/2TDyC+QtO40NwV6QTo9kqa5Z5IELG7VGZpV3/CVzeEhMk3dlTkYPb3Z0ZkLSzucONba93TM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ0hzZ+k0MgIB+iTkTaMwt/SyeDEuahob9lNda2AIcqFoExz3C
	+XxaytiudeoYx2MpiC1Bquwtgd6CpbiLh55KhzpS+2Fo8+tf0LHrAKhIsZZ/IwE=
X-Google-Smtp-Source: AGHT+IFRG3OfaxVvfmQoDLeVl49PRb2iLOrVXoZvMsgISxySL9vW7HzeTwAphuvGn1NUeZklF21QkA==
X-Received: by 2002:a05:6e02:2161:b0:3a0:8d60:8ba4 with SMTP id e9e14a558f8ab-3a3659441c6mr35108335ab.16.1727882950950;
        Wed, 02 Oct 2024 08:29:10 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d8888e37e2sm3150948173.140.2024.10.02.08.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 08:29:10 -0700 (PDT)
Message-ID: <f02b4d72-796f-434d-b612-c37f02184f00@kernel.dk>
Date: Wed, 2 Oct 2024 09:29:09 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15,6.1 0/3] Fix block integrity violation of kobject
 rules
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 stable@vger.kernel.org
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Christoph Hellwig <hch@infradead.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>, kernel-dev@igalia.com
References: <20241002140123.2311471-1-cascardo@igalia.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241002140123.2311471-1-cascardo@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/2/24 8:01 AM, Thadeu Lima de Souza Cascardo wrote:
> integrity_kobj did not have a release function and with
> CONFIG_DEBUG_KOBJECT_RELEASE, a use-after-free would be triggered as its
> holding struct gendisk would be freed without relying on its refcount.
> 
> Thomas Weißschuh (3):
>   blk-integrity: use sysfs_emit
>   blk-integrity: convert to struct device_attribute
>   blk-integrity: register sysfs attributes on struct device
> 
>  block/blk-integrity.c  | 175 ++++++++++++++---------------------------
>  block/blk.h            |  10 +--
>  block/genhd.c          |  12 +--
>  include/linux/blkdev.h |   3 -
>  4 files changed, 66 insertions(+), 134 deletions(-)

Looks fine to backport, thanks.

-- 
Jens Axboe


