Return-Path: <stable+bounces-154643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB342ADE5AF
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 10:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F202218889D3
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 08:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4206B27F01A;
	Wed, 18 Jun 2025 08:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="af/mm8ES"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630B125B687;
	Wed, 18 Jun 2025 08:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750235741; cv=none; b=SND1mCJD5fVH4WPOMEDYRW4CjCsDmNzcTf5uqetuh1nXrrqGZ3XfLn7YaXG/RM84Tbhhju7SyYVcPGzMhWM+2+wQGZhmLIGIDJXoIb2J9JY9Yant9iQyIHGlGcUKcEC/GQLAXYzQfNwcn13a5ilbxVC1vAMd/BipOr4TLnn3c8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750235741; c=relaxed/simple;
	bh=gBtljSikQ7M8mWqxVvgYGqpBr7xVjnTyFw4I/3lyR2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Try3J7uHOB8rCF+4dMJlvloawZymHede7Lur3gfCFpQk8cz74EfOodEXpHnu5yq7eY1QIOepGpixQr/t3VYASzYnE0UeJu5Ih67o1fif3sjuRUaVNBkIg8kRczEcORhJNZwbMhxFLJ1/UOX5uf1nULkkQz27X1T51lyAxmUCpro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=af/mm8ES; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a361b8a664so6466591f8f.3;
        Wed, 18 Jun 2025 01:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1750235735; x=1750840535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=or8eckggWeI1vetStkkRDE0alDRrBXjfy41PRbvLl+k=;
        b=af/mm8ESJIWrBbiUheBSKxwLSc1znS8NtavvDoxHitTQPhwHuIoeC2qZpnu4HOMDIe
         GuJKR8NhAOnyNUDKoel3X7Y72JZPN9oOiRv/UOCXd+qq1tJIpsEtlXQ/ukzOcoysoDVR
         07Y/Is5nGNDJp3JR1tC7Q9mswJ0/gnhPINvzIRs6oOyjndOe4PB2VubBKbLFVIVpcgYz
         Uu5Vf/il4yKZWoOlWBGEZ8wuqFDG3McIhscX9LGLRCeQZiYMgox6nH4wyDfOw5HPGf5e
         cM/52F/xCHacHOhW/WK7OU7fSoZgCRlQtUtA2YPFU0S8kkw7yB2qvsrjPsCx8Z60MD7f
         ExXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750235735; x=1750840535;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=or8eckggWeI1vetStkkRDE0alDRrBXjfy41PRbvLl+k=;
        b=uq+iGmRXKeJVGnLMrWbRViD+oxGm5V+1My9R0YwhQqPpi4TxBLPbrLLPjUZA2crs8N
         BBMmGKekx858Dn3y3cTUrJ/CPQAqxBaxN4bqWvt5UJbaodbezXI37fhPACCQpg7TSjPO
         R4nFVyYeJ28fyWtWKSZpOuQHRuWWY7KOAw8xC3un0E+r91824uS1wQZeFlz4egcWA3wv
         5tvB/scg48x9l4YbiK9Lb+kOIitDeV/Xdofp2kXzjW87FXW8VJyW1yq33E8RMX3+J1rP
         Tn2IQXRPdQee3KNzRBAEiwI8/bWNaQ5eXbXCv/jgSh0WXsmACzT3ZnlAk2tiGX8WzGuP
         OGpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzjVbv4MJ7tl6dV2SirvgadWoC3gfYuUi3doKaUJ13yI+FqL8RJ5COadW2ZDMnA7isnenkgAR8cqaMylM=@vger.kernel.org, AJvYcCW84JoO4Ey3HhhYJxsff0X0TsIy4uZdmn3Kpgu/1+ZuDX0hUxorBLsWk1lJrIXHPwCZUEU4GMfc@vger.kernel.org
X-Gm-Message-State: AOJu0YwuEuzXrgcRM8Yv/R2+rY98R9arv3sOz6iocXtW7LoWurAwp53t
	N2B8Mp+X3n60wLAcDYRNdA6s5dDFsmdyXykbJf+I0lZGs8lqgGMqseM=
X-Gm-Gg: ASbGncvKMEmm2wUjOQCBK2ubqP61bUho2suToQDV0QnH5Mf9sgQw4mxb2PVbU+yQ4IT
	sDvmF4hgRSbgAZchXlM3QDIFPWUj/0QX8+bZI1QZhR2cby7MDHN0hfAZXto7Tkf6InX2Oyoj8Q/
	mprHxIil+3aArXAmcdx1jqsD3lYDxuu1ae/PQrF1DM9eruH6HGeLqA1ZRFRQgthjhgpLQrGMM3r
	wo6EtW5AnOfMgH9emqvx1SbPq8XNjRSbb8zzwe7tDzvEM89BEEw+vT06r4Jvg207HmjVMXNG0fj
	7gwvrnmkcDJgPwogDrpibr2Jce6eoRNbXTsU7zESMEJRIXfYtuHz3iai3zXOqkDL0VRF475WuKP
	+Wv1QjS8akqFGDwv8GNFqdipDWKWJu0U7MjpJMA==
X-Google-Smtp-Source: AGHT+IHK+9Vtgwvu3Uu9LRAqoRtjCRZP9zVBNDYDx6sb7yzZDk/wruWjNv3EFZExUxnqitSzI6gH2Q==
X-Received: by 2002:a05:6000:1ac8:b0:3a5:2ef8:34f9 with SMTP id ffacd0b85a97d-3a572e7971cmr13987677f8f.27.1750235735431;
        Wed, 18 Jun 2025 01:35:35 -0700 (PDT)
Received: from [192.168.1.3] (p5b057357.dip0.t-ipconnect.de. [91.5.115.87])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e2324c6sm196576805e9.12.2025.06.18.01.35.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 01:35:34 -0700 (PDT)
Message-ID: <b54abb55-ac5a-422f-b819-8b893f2974d7@googlemail.com>
Date: Wed, 18 Jun 2025 10:35:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.15 000/780] 6.15.3-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250617152451.485330293@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.06.2025 um 17:15 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.15.3 release.
> There are 780 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

