Return-Path: <stable+bounces-94424-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8089D3D88
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 15:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 636B128446A
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 14:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA9A2746D;
	Wed, 20 Nov 2024 14:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fN0gsP4W"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67F5174EDB
	for <stable@vger.kernel.org>; Wed, 20 Nov 2024 14:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732112883; cv=none; b=RAJWDfFe+YjKkgMHiFBXDDtcwQD+402lrnGVp0v2cO6GE4OIXLF1oOHZKl/GWaZpu8J4qr5s33sW6gxEoiVn8gUA3mrJ3UuHwXJkSNdCO7yJ+yyeyUdm+exmThXM+dqXd/JhHK5Xjzhk9rHlI4yhUxYN9Mnql2Fq0qc+dzlzM5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732112883; c=relaxed/simple;
	bh=b2dOhAceJSD3kqQt9+Jcd3JVZf4eh0JzExHUTxlRIU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LYLcIkPS73bLZC6B+rPk3iALKc2mUm7aI3yRxq9aMc2Muiy81iHQ/lCW2xXRcvc5RSBoo1Q/hM+ijEmM03dPLSuvb0lpQF/ArRd6jhAsBltdt5mtNRbB839rUgmzYXdi8QVBv+H5h1ojVfGvYgl3M3A9BNClHsS4i2R5ZI9Bdgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fN0gsP4W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732112881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k8FqI6bon1QS1nbiupJDYJ5P5cl8zCH5ATXfrWn/wQM=;
	b=fN0gsP4WvnCgzEtTKDurCzwg8wTXyaUYe90OXKeFtc3IdkZkY65J3UxTc8aXStO0cLTr1e
	x2DnHAlU7b/eiDl5+mEJa5c7MwN+B3f16eL7VR+Mxpo7SBF3ZN2//eNQQ73FDQq6LTbINr
	BMiTXKifCzQvzcrzti2fPdgPgbQ9Dcg=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-u2zyz3T0OgCKy1i6cVj3_Q-1; Wed, 20 Nov 2024 09:27:59 -0500
X-MC-Unique: u2zyz3T0OgCKy1i6cVj3_Q-1
X-Mimecast-MFC-AGG-ID: u2zyz3T0OgCKy1i6cVj3_Q
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a77fad574cso15253215ab.2
        for <stable@vger.kernel.org>; Wed, 20 Nov 2024 06:27:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732112879; x=1732717679;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k8FqI6bon1QS1nbiupJDYJ5P5cl8zCH5ATXfrWn/wQM=;
        b=iIpZ1HosWuLeiXttSpvU4E6SuGiCgIPJlvCk+7Lxxn0xYNgqvF0CLyG878dXoX1AhE
         scrc35QhCHsPJYE40RYgZFbI1KbBoXEYfdOKYfat0/51aCIQnLyF8s+EDkExtvIztJzC
         x+nC2T8PnvxpkAWHkTPXbb+DwV69d3IzlrlCcXAkku55R7jQ5WAMSbaECkDbj/f1J9xd
         +iM2GeilNJqsjLWaoGkcvPJCXhj7ZDinZ9aIPc+7/fj8wfVWpxq0dgYQSGV0B+bolz4q
         1Fsp0pUWD+1DuWsh8EJODkq1oMWJBiis+ScUa9o7lrjgU9nORJa51AoRx8CgZs8unZGz
         GLEg==
X-Gm-Message-State: AOJu0YznzBKr/5IMq3o6tFJ8AGJp9EoK1y5gRs7r65ZAe1ABtFkeTvdx
	cRL+flI9YrauzGs+Bwzvswa6RW6l+mWVkIefeLEQfhfyOH/xMx2jVlOdzxkWFZ1CYjnH7w4a0wz
	AKyT9bVEx5ogfW43c9obmFoT4MevYwJpF2wyj3A6TorbVs5w+ze2Wsw==
X-Received: by 2002:a05:6e02:b21:b0:3a7:6825:409d with SMTP id e9e14a558f8ab-3a7862bdeb2mr30647445ab.0.1732112878957;
        Wed, 20 Nov 2024 06:27:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBqdKIPt9WPJWK5kvNRHw1ul4I/pgYBloYCTR7r3E0Kf9ycgztAK7c2iqmaxbfhxQuCnm+5A==
X-Received: by 2002:a05:6e02:b21:b0:3a7:6825:409d with SMTP id e9e14a558f8ab-3a7862bdeb2mr30647265ab.0.1732112878678;
        Wed, 20 Nov 2024 06:27:58 -0800 (PST)
Received: from [10.0.0.71] ([65.128.99.169])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a74c2b477esm29631795ab.11.2024.11.20.06.27.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 06:27:58 -0800 (PST)
Message-ID: <493ce255-efcd-48af-ad7f-6e421cc04f1c@redhat.com>
Date: Wed, 20 Nov 2024 08:27:57 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "f2fs: remove unreachable lazytime mount option
 parsing"
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Cc: stable@vger.kernel.org, Daniel Rosenberg <drosen@google.com>
References: <20241112010820.2788822-1-jaegeuk@kernel.org>
 <ZzPLELITeOeBsYdi@google.com>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <ZzPLELITeOeBsYdi@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/24 3:39 PM, Jaegeuk Kim wrote:
> Hi Eric,
> 
> Could you please check this revert as it breaks the mount()?
> It seems F2FS needs to implement new mount support.
> 
> Thanks,

I'm sorry, I missed this email. I will look into it more today.

As for f2fs new mount API support, I have been struggling with it for a
long time, f2fs has been uniquely complex. The assumption that the superblock
and on-disk features are known at option parsing time makes it much more
difficult than most other filesystems.

But if there's a problem/regression with this commit, I have no objection to
reverting the commit for now, and I'm sorry for the error.

-Eric

> On 11/12, Jaegeuk Kim wrote:
>> This reverts commit 54f43a10fa257ad4af02a1d157fefef6ebcfa7dc.
>>
>> The above commit broke the lazytime mount, given
>>
>> mount("/dev/vdb", "/mnt/test", "f2fs", 0, "lazytime");
>>
>> CC: stable@vger.kernel.org # 6.11+
>> Signed-off-by: Daniel Rosenberg <drosen@google.com>
>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>> ---
>>  fs/f2fs/super.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 49519439b770..35c4394e4fc6 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -150,6 +150,8 @@ enum {
>>  	Opt_mode,
>>  	Opt_fault_injection,
>>  	Opt_fault_type,
>> +	Opt_lazytime,
>> +	Opt_nolazytime,
>>  	Opt_quota,
>>  	Opt_noquota,
>>  	Opt_usrquota,
>> @@ -226,6 +228,8 @@ static match_table_t f2fs_tokens = {
>>  	{Opt_mode, "mode=%s"},
>>  	{Opt_fault_injection, "fault_injection=%u"},
>>  	{Opt_fault_type, "fault_type=%u"},
>> +	{Opt_lazytime, "lazytime"},
>> +	{Opt_nolazytime, "nolazytime"},
>>  	{Opt_quota, "quota"},
>>  	{Opt_noquota, "noquota"},
>>  	{Opt_usrquota, "usrquota"},
>> @@ -922,6 +926,12 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>>  			f2fs_info(sbi, "fault_type options not supported");
>>  			break;
>>  #endif
>> +		case Opt_lazytime:
>> +			sb->s_flags |= SB_LAZYTIME;
>> +			break;
>> +		case Opt_nolazytime:
>> +			sb->s_flags &= ~SB_LAZYTIME;
>> +			break;
>>  #ifdef CONFIG_QUOTA
>>  		case Opt_quota:
>>  		case Opt_usrquota:
>> -- 
>> 2.47.0.277.g8800431eea-goog
> 


