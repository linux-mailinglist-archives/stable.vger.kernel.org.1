Return-Path: <stable+bounces-192469-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BC2C33BD7
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 03:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF5AE4ECD35
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 02:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E0422D4F6;
	Wed,  5 Nov 2025 02:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOXRdKOU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A503221264
	for <stable@vger.kernel.org>; Wed,  5 Nov 2025 02:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762308495; cv=none; b=pzPkZpjeJXhNtNuhn2ki800MYyV6OwWQuC9meWY0o9nyaowUxEDCyiFuyM9NhH2h/bMlHsf9sKh+NxRgg5ZJin2/gTfYiE2iBTJ++q/2x0jT7xVdXIC4vpd4lWmkekiIsTmecApgU8r1F/z8Hcv83woMpDYLg3i5I/Ks1RKmSZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762308495; c=relaxed/simple;
	bh=aCIePvxR6b0aME6sxxADpgHuW9tgTHqfJqmmFPqOqb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hx/Z8mHBQje1bj2pSWhrSV/Na8sXxJAq90dWGrILt7dg2mfYN+Qm8n9XuXzhQPTLdR+9bV/SYt/GyV28gku+t5yrI4tID1fKaAUB6/eERIuB8gAP6GyXXjAwg0oq1Bvcw+ScrReGtjl5QcFwX9IxD+pE/s8CSWeYyb82bjOTZW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOXRdKOU; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-27c369f8986so63192985ad.3
        for <stable@vger.kernel.org>; Tue, 04 Nov 2025 18:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762308493; x=1762913293; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a4yDBu3bQnhMe9kSGDJfDwWvTH191XsVU1fFztibKfQ=;
        b=AOXRdKOUWbvJa/YjPYbAkr6KmAf/lpgcXmUSDMlJy4DYU6lDrP6RkJyQnnU8PTt7ke
         2sY+RCUIJTIcQig8mGcG5B3Qu74NRGKT6e2gucYzRCyw68u3Pxc6r2DV2z4GhAvecxsc
         M9hVastkDwW3WAqenP+6idkb7Yif1hEeYLO9+Zf3Txax7je4fkY4p+Ch5NTCg2FNHrgx
         X1ALGtL14NAxGbczmqgoq/HBmD9874hXQHTZx3j3lXwqrycY1t3Pl2jwCZmxgN6vIaIy
         FFHgaA11QsAfEFUtoKWa/9nuuOomJepM+uB1M1KJ4mb6OKwJf8I/DpYIAOi9vYjMCcDu
         UI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762308493; x=1762913293;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a4yDBu3bQnhMe9kSGDJfDwWvTH191XsVU1fFztibKfQ=;
        b=SphaMiTDegb/uPT4Vs+bBTJmFjxd2PuIRXJep0lzdLHbqPuD3DM6aZcHFwLoWyiIKv
         zAkcYW6fEB9PBKmibIv255TS33GwcdUXbe0XSyoO4czEaBbxWry7/13VMYJNQvlp4ve1
         3NtpCOVxh2aDfC+MSPV4ibmX9MVpU9/5R5OWwMk2MUP8VVaJldNNedMETvNIzouh028U
         1ZTiUPl3GmMxqK+g+lo+ux+2Vu6MTxRDmqAEFYVtXksKsJXbR4ucR6rAMrysxivsu2wQ
         wds5l5cCWUxisnU+Wp7cerjupjkikL8uGAmlRTqhU5gJO7az0ljbjA3dIK5Ij9gMMUX1
         FelQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5e3hrBp62BeVtQqHoL0ZwNtKULOTG573TMCncWwb1+x/170bboeRPXQjTKeKOznWmAnfDIaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YziWSrHSEgiEKGn6roWBc0Gk/48Lav3u3uKUr8+I7Vg4XnMSfVy
	11wtJI53xb+9Jeoak5vnJJKqKkK/PfaobsuUhaLcZ+5VEIjVmmwnKDU/
X-Gm-Gg: ASbGncuVSEoPVTM9gV6IzOQrxL1SfyjoqyaSFu3jhZoJCU60nOt46+jQXeVE3YZtogv
	40ZOVCJUXUZSjOcz0ZJ4q8gpjBTQglMiwTGx0X1znuy79PsZH5dKUzIsrL6v9HX2yGxAPJCxBVr
	AWjl69UWnd4iLLguhAOtU82ZrA1N4GH5qRNjNFSvmP1LWLW4HmlLy4UrFOBurqaReMAIpEXPZ/f
	ekBdDhsNIbxQ9Arml6dU0GVVXAWIqQPBHL8dyJgNZ+jT9CmukGZaQ8wA1CifX02xdTo3ohrDBi5
	K8uBw8uYvJ8p4V8cAkY8ekKMX4+QiAz5B/7o0zBI/2F5841cF0n1eIuTcdD4f34YZX/AlxDBK1n
	JDvhq9P7nQTGeJSLJVOzfRVd2z6kzlmCvWGES5iom5U8LqGUIO1nhrd/LGIQ5C2mSgDcDz8vxSE
	rtqDFs4KAE7mNBm13nVtwyuh4=
X-Google-Smtp-Source: AGHT+IHFEEDEwbkYMhDcYlAouSByZjRV09d05fMzqHjwPvk8mlwVG2htfWc/MvggLNSc+kqx17qoEQ==
X-Received: by 2002:a17:903:2448:b0:295:6d30:e263 with SMTP id d9443c01a7336-2962adafc02mr23971055ad.40.1762308492736;
        Tue, 04 Nov 2025 18:08:12 -0800 (PST)
Received: from [10.189.138.37] ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601978210sm42828115ad.2.2025.11.04.18.08.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 18:08:12 -0800 (PST)
Message-ID: <221cdf62-f8aa-421b-9d39-d540cbe7346f@gmail.com>
Date: Wed, 5 Nov 2025 10:08:07 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] xfs: check the return value of sb_min_blocksize()
 in xfs_fs_fill_super
To: "Darrick J. Wong" <djwong@kernel.org>,
 Yongpeng Yang <yangyongpeng.storage@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo
 <sj1557.seo@samsung.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Jan Kara <jack@suse.cz>, Carlos Maiolino <cem@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Christoph Hellwig
 <hch@infradead.org>, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 Yongpeng Yang <yangyongpeng@xiaomi.com>
References: <20251103163617.151045-2-yangyongpeng.storage@gmail.com>
 <20251103163617.151045-5-yangyongpeng.storage@gmail.com>
 <20251104154209.GA196362@frogsfrogsfrogs>
Content-Language: en-US
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
In-Reply-To: <20251104154209.GA196362@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/4/25 23:42, Darrick J. Wong wrote:
> On Tue, Nov 04, 2025 at 12:36:17AM +0800, Yongpeng Yang wrote:
>> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
>>
>> sb_min_blocksize() may return 0. Check its return value to avoid the
>> filesystem super block when sb->s_blocksize is 0.
>>
>> Cc: <stable@vger.kernel.org> # v6.15
>> Fixes: a64e5a596067bd ("bdev: add back PAGE_SIZE block size validation
>> for sb_set_blocksize()")
> 
> Odd line wrapping, does this actually work with $stablemaintainer
> scripts?
> 

Sorry for my mistake. I’ve sent v6 patch to fix this issue.

Yongpeng,

>> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> Otherwise looks fine to me
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> 
> --D
> 
>> ---
>>   fs/xfs/xfs_super.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
>> index 1067ebb3b001..bc71aa9dcee8 100644
>> --- a/fs/xfs/xfs_super.c
>> +++ b/fs/xfs/xfs_super.c
>> @@ -1693,7 +1693,10 @@ xfs_fs_fill_super(
>>   	if (error)
>>   		return error;
>>   
>> -	sb_min_blocksize(sb, BBSIZE);
>> +	if (!sb_min_blocksize(sb, BBSIZE)) {
>> +		xfs_err(mp, "unable to set blocksize");
>> +		return -EINVAL;
>> +	}
>>   	sb->s_xattr = xfs_xattr_handlers;
>>   	sb->s_export_op = &xfs_export_operations;
>>   #ifdef CONFIG_XFS_QUOTA
>> -- 
>> 2.43.0
>>
>>


