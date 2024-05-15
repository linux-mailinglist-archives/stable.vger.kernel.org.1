Return-Path: <stable+bounces-45231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6823A8C6D05
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 21:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDE6DB22AD9
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 19:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2327415ADAF;
	Wed, 15 May 2024 19:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FBHrmERa"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE541591E8
	for <stable@vger.kernel.org>; Wed, 15 May 2024 19:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715802890; cv=none; b=uCjYHubKQiKbzKpKvb+Ad/GIs9eYivoB9Xdabes7PUakSorPuFBF2MIhCXyw+z1hhg+Xmgqd/6Fu+gP0OSLzZpZjJWSwFlwWifMozcc29Oxb0g2eqLXm0Ay1XYmMM/AggXtTL7Bv/i7WLV2Mg3YAzM8Jg6k4QepbVVzb0mIWRsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715802890; c=relaxed/simple;
	bh=RpY1ZLIWGoaTSG2trt5v7gG4sxt/2eeLMWhzG0YEN0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GakjOvCGcOyLb3x4ah9VRG8bO+5mlfnSqHsYOoBLwTD+vadPzZdKQS+Q6fAIPWkkwsbkPmrOvJcCHd+UBqxfqpWzwxW0lzckgwy8NDNbkhVaN+FNVh9pax1pP4Rkhqzzp6gGzm2mNarJ6Zu5jPelXbaCy1mrnYQqZEs4atc0q1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FBHrmERa; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7e1b8718926so49326439f.2
        for <stable@vger.kernel.org>; Wed, 15 May 2024 12:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1715802888; x=1716407688; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bl2K9Oe3kWb4B4ZrUWnPsSq8OrI5PV1sUFttZ0QWN3U=;
        b=FBHrmERaPo3bslvzJKg7CI0QF9sA831aYRUvcOlOwqlVts8d67bRFDkPMYwKuIrPaL
         2heF2L3EY4mdz6UHtgoDEaB5oqVxnwKmw0CzHbBwEvIIwHK4u8B5ZB+TeVrMPsDMWyFS
         YRF0SprgpWhhD1cs8y8hY/lTHtzY+Q/ogqRu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715802888; x=1716407688;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bl2K9Oe3kWb4B4ZrUWnPsSq8OrI5PV1sUFttZ0QWN3U=;
        b=kaokOUR6/I4aOjq3pVI7iRuajAroiQBLbapYU6x6scypBC81Kuf8nc3QB9YArjZAei
         I3yYzzdfGuQDpn7mnh6EjIL3wKoKhBlPzOrIf5Z2DT1SjED6pyJDtQLb7NGdj5ndnrjQ
         AYEWmQKnej2DsRi2t6fBj7gXK6xr7IKhDq95x07IC3CRHp3Cs09xELXo9Z2G+DUYXD2t
         mHtAzQ8l5sXxg0jkn/W57vXxzRD7K5lNOYUXXtXNK8lGhJBlNBSWk8OErhIlChsRvf2+
         WYM+XqHKhMOTVgGF/TEmpsMhhw6XsdgUNZXMcSKEFVk86+veS7Zoet21WoruenME2jS/
         GOIQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4EDIi4jtRIrb86dtqTJlXa5CH5X1scIKZhpm5ivllcoqM/rd/n7P7sbty9dA/xZZyFOI+solJSOviMOE1iZgmiF3ApuWG
X-Gm-Message-State: AOJu0YyU1ibX7JcYTvS29Ramrq3vc284k+lXuT/SoaaQ3wLQXq/v1M97
	8GUB9UGsA8vu9noJ9w255FaXKVc7Pnfpfw2aYaGGXuNFScH+uyjivTiRrwacseMQZfwvFEfaZ+K
	fhUs=
X-Google-Smtp-Source: AGHT+IEt+AFs1YP+RmbhIVtPtEK1Ie3e0g8AnrQnfralB4FlTv2dlK5IMdCEU/UsVRuCWZYJWFA6Ng==
X-Received: by 2002:a6b:d203:0:b0:7de:e04b:42c3 with SMTP id ca18e2360f4ac-7e1b5022577mr1766220139f.0.1715802888578;
        Wed, 15 May 2024 12:54:48 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4895841e9c9sm3311353173.4.2024.05.15.12.54.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 12:54:48 -0700 (PDT)
Message-ID: <ee899ee0-f3e9-4f61-b48f-ccd6efa28127@linuxfoundation.org>
Date: Wed, 15 May 2024 13:54:47 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.9 0/5] 6.9.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240515082345.213796290@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240515082345.213796290@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/15/24 02:26, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.1 release.
> There are 5 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 17 May 2024 08:23:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

