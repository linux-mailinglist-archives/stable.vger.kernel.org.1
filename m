Return-Path: <stable+bounces-176965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EC1B3FB93
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 12:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2129D3B1924
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 10:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5468927B4F5;
	Tue,  2 Sep 2025 09:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aXgJs+jS"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966742F1FC0
	for <stable@vger.kernel.org>; Tue,  2 Sep 2025 09:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756807073; cv=none; b=W1sAEne7vjjbShBd91PHt1gz9qvv/cIJffqTrkgn2Tm8d+xeqdufbwPUQbymYKJzzUaSJ9SlCINtPc5Eo31uWZwYrAQAn7J/HIGmi974LtW5UoIYAG/yJrZAbI2antVsZo+u+rB2JBNoHp4wKy38cyMAUowVIQt9F5Lg1xrNms8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756807073; c=relaxed/simple;
	bh=z8gMwvXA44Wodi+hSnmRdnTeDizAmm+mkq0BLF6OVgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dsw+Eo2JhoAH14mMJ8bLaeX1nIVV5mCww6l0ST6xOGmhjBvva9nhkW4ir/XKwVXPvOwECrndVSOXHKkhY2lWMTOYbG88CXPW0zttHKhUeg8AiNzE4Mq2ac+F2vLYQfGPjW30DWEHeJBRLRhaU2hfgXB8864B8R1xjNzfEf6YgX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aXgJs+jS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756807069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HZc4GB0/gNL5X2pnt5xZy0Mk61OX021O6i+im+Ocmjs=;
	b=aXgJs+jSwLKWb1xFynmcC/GHudjEUgB5n34mP900CJ5MoMoz/jKrfZx5kt7uHExxklJA8E
	Xub3uo7ou6TueZWNIbVhfraYi43XScxBBk49mz0xvksWBNh7r0iBlNNjKZPZ3q0EOzy8eK
	0+8t3oZgpJXvIGnqabS+wZYQa4FOPbY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-AT4DvHaJN_6lxNnEdIWQmw-1; Tue, 02 Sep 2025 05:57:46 -0400
X-MC-Unique: AT4DvHaJN_6lxNnEdIWQmw-1
X-Mimecast-MFC-AGG-ID: AT4DvHaJN_6lxNnEdIWQmw_1756807065
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3cbd6cd78efso2364139f8f.1
        for <stable@vger.kernel.org>; Tue, 02 Sep 2025 02:57:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756807065; x=1757411865;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HZc4GB0/gNL5X2pnt5xZy0Mk61OX021O6i+im+Ocmjs=;
        b=ps855i2DkOZamt4EjDCQ0ZPEFH6akxDrv5FUz79SzM2+djW+Eoi6aPw018mc5PAblE
         w1HR0OjcNZWGEzxSIHDt2Ewg/BsSjSw3N9H8UZKA5GPcP4IJNanGbQaQShA8XviOvFC7
         tXcpA/Iko/7ryfd4hzmy92grwg2wDcKbiqHhsMwJYRXpmIyijJLDGRI4Qhi1mI47q5eE
         1APxTJDAzmFdyl+QVDXxvk9mfSPQTTBq2mYmKXQC4UUtVTD3TfvncG9C7usmvzMqSEI/
         FdSFCuSgqEj0sIKpQUd372yB6ocPUyYy+QJVoO4OGs2LHS1Vtw5diwjfhoZ79Ih19luS
         oHLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTV48xwvc12bFMSSdFdfoSCosU2AfPPP7IgH53D4IwIl6vOc1/Bf4s2ZPVIc4/PSvNif/bAwA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+z5L6hsyxD/md45Pp/XkVi6dqc2g/YMZEYsL0vqR4XHD/RyUu
	TizieOilvf8g6UNyiZD2ujW1IPNPFTHrk4Oqf++C2orWiiSZaG8jpF1/IwM9Nyuy2LhvJCz53Wi
	/E73T0IpJ+8Z1vDA01CwDfgMkSm8lp4SXjdi/c2mKuFZkqAJ3FBil1Hk6gw==
X-Gm-Gg: ASbGncugZilKape1Og1akZfbFtVcAEhn2r7mv6dmRcIBAea731M76gLvhmIXzEkizw9
	3lgNX1iMD1zBXCUf4K39hNTNI+/U5vPcLkf4pTojwIFxFV9y2uDuGPMP1vMmy8RWfuOQ1kGyQk9
	xNtkgWOVbIZ32eBAl+xeTdVUybvoU5+s2+krk17tV+F2tpu2K1UYvgNGYWknZ4/hOyr2Q5uABCi
	+BQqynYWN5E0auHlnpgvT51NM52OXm02DiwGpy/0Kb1Wqt9/HxgANy7fK0GVsEivrTjMs5OE4Se
	9npTr/XmEUFcKuc0YDqydu45LGH9LTksPZYlziiqConLmbqOAG8C358fPqM06J7SQBo4fjk0a0k
	XeMfhcC4nzPg=
X-Received: by 2002:a05:6000:2110:b0:3d2:52e3:9220 with SMTP id ffacd0b85a97d-3d252e39a50mr6205384f8f.5.1756807064874;
        Tue, 02 Sep 2025 02:57:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBBKawshRRcWgMajhrJGR9pfMn2+8pBgJ1J6VR2pISIYxt4qBpwtVugddscbM7nf2wPfGedA==
X-Received: by 2002:a05:6000:2110:b0:3d2:52e3:9220 with SMTP id ffacd0b85a97d-3d252e39a50mr6205351f8f.5.1756807064174;
        Tue, 02 Sep 2025 02:57:44 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e00:6083:48d1:630a:25ae? ([2a0d:3344:2712:7e00:6083:48d1:630a:25ae])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d21a80c723sm14068985f8f.9.2025.09.02.02.57.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 02:57:43 -0700 (PDT)
Message-ID: <a46cca6e-5350-4ca4-ba17-bf0f89d812cf@redhat.com>
Date: Tue, 2 Sep 2025 11:57:42 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] selftests: net: add test for destination in
 broadcast packets
To: Brett Sheffield <bacs@librecast.net>
Cc: Oscar Maes <oscmaes92@gmail.com>, netdev@vger.kernel.org,
 kuba@kernel.org, davem@davemloft.net, dsahern@kernel.org,
 stable@vger.kernel.org
References: <20250828114242.6433-1-oscmaes92@gmail.com>
 <03991134-4007-422b-b25a-003a85c1edb0@redhat.com>
 <aLa54kZLIV3zbi2v@karahi.gladserv.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aLa54kZLIV3zbi2v@karahi.gladserv.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/2/25 11:33 AM, Brett Sheffield wrote:
> On 2025-09-02 10:49, Paolo Abeni wrote:
>> On 8/28/25 1:42 PM, Oscar Maes wrote:
>>> Add test to check the broadcast ethernet destination field is set
>>> correctly.
>>>
>>> This test sends a broadcast ping, captures it using tcpdump and
>>> ensures that all bits of the 6 octet ethernet destination address
>>> are correctly set by examining the output capture file.
>>>
>>> Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
>>> Co-authored-by: Brett A C Sheffield <bacs@librecast.net>
>>
>> I'm sorry for nit-picking, but the sob/tag-chain is wrong, please have a
>> look at:
>>
>> https://elixir.bootlin.com/linux/v6.16.4/source/Documentation/process/submitting-patches.rst#L516
> 
> Thanks Paolo. So, something like:
> 
> Co-developed-by: Brett A C Sheffield <bacs@librecast.net>
> Signed-off-by: Brett A C Sheffield <bacs@librecast.net>
> Co-developed-by: Oscar Maes <oscmaes92@gmail.com>
> Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
> 
> with the last sign-off by Oscar because he is submitting?

Actually my understanding is:

Co-developed-by: Brett A C Sheffield <bacs@librecast.net>
Signed-off-by: Brett A C Sheffield <bacs@librecast.net>
Signed-off-by: Oscar Maes <oscmaes92@gmail.com>

(if the patch is submitted by Oscar.) Basically the first examples in
the doc, with the only differences that such examples lists 3 co-developers.

/P


