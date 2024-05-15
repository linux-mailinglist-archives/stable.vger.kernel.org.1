Return-Path: <stable+bounces-45201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C78668C6B26
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 19:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B6841F23320
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 17:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC90536AF2;
	Wed, 15 May 2024 17:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8pviMLG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705894C3CD;
	Wed, 15 May 2024 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715792431; cv=none; b=GpR/zNme/jlRpReYKjcbAXmjINPb0OB1sQmKC45dmvjRFPLBx9MMbwLLaGFUeuD9AZrghsBO2vDXgXSMAWV6PrAPg54hK/7poWM54mTUEiZzpQpGYBbt+LkVB9jPwryMiUD2SI6SjU6TRkoZi8aPjczOt9hS6BI0Tv+ttPFxU+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715792431; c=relaxed/simple;
	bh=ipUnLDSp5m6fO2qsq919pjRhPcJf9w9/0pt/Gw5+BIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p4CxReHhTuC4ugEEjEFGcPWs7FpUcRa1S8kH+GkfLhXpB38sGzDnoHqLE4RR89R9ac+gUD4O0LgDtI3DhRDCrz8ki9XlhW7Cz8nD64TsWIzYwfC/g/FE89AS1ZMX3MHjFFwB1dZGydLBx3Hjo+jrOQV0vf3bRzmCzbSugmsI8hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8pviMLG; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e3c3aa8938so49525315ad.1;
        Wed, 15 May 2024 10:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715792430; x=1716397230; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ogL0PcSv5uEu2C9EyEKXQC0QIaA8VojhP4hQHXPLTM=;
        b=k8pviMLG5WTKPBONdQCQKzWvpmrf/uKR8e5HXZ6DnvaAIztOz3TdNW2Rl1YkMBfopb
         WtIIZIvFJlTYp4+wkiXuEQA01Su4kfasToLfMMsD61O/bqnFN7c/7Ct+YYe9LK9+nIuA
         +X/FQqyV/2luKlpnikNz2r9S0SRd+PIp2sphLjFlk9Cau6vCMOoUw/F/bs+HxAiP7rIf
         VBBzh+5VGeAng2JmOw/b/uVKB1NH0f6/FQyFcBRFph+T/ewg83uliVdvs1S91/aVOUDE
         wL1IYC/9SyZhoNC+cgOkzWEFkg1Zf7pMbxOLZr2DHc5T6uVr3K51ORuqLznqNTNk/Auz
         Q/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715792430; x=1716397230;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ogL0PcSv5uEu2C9EyEKXQC0QIaA8VojhP4hQHXPLTM=;
        b=ItPsQuLqirf8WSrbXwMvpdI+ILYkEE98AnUWPo9LDklPNjjfahZZTn1AWRM4MEMqRg
         B8goJnW94zQ4NBHBVPBrV2zi1x/yhUVwA18UqPhj1nRN5XQesrup7gt0kyTKA6fea0Dl
         VpkRutZx2KaLIAPiBlMj5LMbNFcZ8nK6bkuaEes2SCTmGJ3M0XYXfIiCcwGATJjRljOG
         /jLteCyANGe539eBs3u1h0iwFrfLGDTfZ9ZUXYHhjWy5dn1YTDU84nu7iGFLr3WJfvVV
         2qr0GgImWcQ5H8PkX8HZt1dRnmhvi1hW97fd8DCRuWL/9zAfYCUXu9SRcds5VgPNQCnu
         NLVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3tIA2HMAh82+tGRVsvFwjGySHbVMoPjJi/21Tj7eMuCUJ3KBPqXY97IE4jgB7Q1Hdsv0+Ms6bohLb70U8u3bS2gUMBdtMSkHiNUyEFAEOdpB5PBC6FU/aB1SGdSUQKJ4sUsQ6
X-Gm-Message-State: AOJu0YzA4/EmTKSex+XsNPFahri8f+rQrTlPLPeeuRwzDzhExYZ/8Lct
	6sMGVGXNua6GdktSi6QegmZxn2euzx1twN70wOC7I+o5LAld5EYu
X-Google-Smtp-Source: AGHT+IGipl44hFoMXSggtw7I+OXvYdffK5jFslHogrO9eSXQLuWok/sVFoWFpgfWeMn0Iha3zJ6dZA==
X-Received: by 2002:a17:903:24d:b0:1de:f91:3cf3 with SMTP id d9443c01a7336-1ef43f4d284mr168274375ad.55.1715792428282;
        Wed, 15 May 2024 10:00:28 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ef0c0361b2sm120009205ad.202.2024.05.15.10.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 10:00:27 -0700 (PDT)
Message-ID: <7e82ae93-5067-4bcc-9a73-27820d8b3dca@gmail.com>
Date: Wed, 15 May 2024 10:00:25 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/243] 6.1.91-rc2 review
To: Guenter Roeck <linux@roeck-us.net>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Doug Berger <opendmb@gmail.com>
References: <20240515082456.986812732@linuxfoundation.org>
 <39483cfc-4345-4fbd-87c2-9d618c6fdbc6@sirena.org.uk>
 <CAHk-=wjntFiQ=mM-zDHTMnrqki3MN3+6aSXhjnJozBaKqLLUDQ@mail.gmail.com>
 <823e7e2e-4536-428c-a029-8907ebf89635@roeck-us.net>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <823e7e2e-4536-428c-a029-8907ebf89635@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/15/24 09:58, Guenter Roeck wrote:
> On 5/15/24 09:20, Linus Torvalds wrote:
>> On Wed, 15 May 2024 at 09:17, Mark Brown <broonie@kernel.org> wrote:
>>>
>>>      A bisect claims that "net: bcmgenet:
>>> synchronize EXT_RGMII_OOB_CTRL access" is the first commit that breaks,
>>> I'm not seeing issues with other stables.
>>
>> That's d85cf67a3396 ("net: bcmgenet: synchronize EXT_RGMII_OOB_CTRL
>> access") upstream. Is upstream ok?
>>
> 
> Upstream code was rearranged. d85cf67a3396 affects bcmgenet_mii_config().
> 3443d6c3616b affects bcmgenet_mac_config(). bcmgenet_mac_config()
> is called from bcmgenet_phy_pause_set() under phydev->lock. I would guess
> that trying to acquire the same lock in in bcmgenet_mac_config() results
> in a deadlock.

Yes that's exactly what is happening:

https://lore.kernel.org/all/d52e7e4a-2b60-4fdf-9006-12528a91dabf@broadcom.com/

Thanks!
-- 
Florian


