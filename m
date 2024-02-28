Return-Path: <stable+bounces-25397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0689586B562
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 17:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D0351C23C8D
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 16:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828F015D5DE;
	Wed, 28 Feb 2024 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fUc750sA"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC93215D5AE
	for <stable@vger.kernel.org>; Wed, 28 Feb 2024 16:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709139449; cv=none; b=Y/eC498JxUUBBU3JRC5FxChGOwzDU4F3TBu9zsbd+0f+38nFDqx5u7D8dn/HgickafqOoRbKe6wLQwxljfB6knpmsH++aQvTW9fg24k4T4FI5batk2YcCwp5pgQQVCJd+2vG3/HmCdAb1XauBU7BXwJx+gGRqR6K9RC0PYjI4Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709139449; c=relaxed/simple;
	bh=/2Azqu1VyiRaiAF7AA3juHS2VEk/q1WqTNt34zVPHsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jtDqzv2SdD0+/N58ri5eKkyVTyX0UrgGHAzd6GjXnM7kqzoSesyl1x2oqCwCAOuP3Inn8PySDw39Qbq4yPZNKuoy9Nq86ZT/y57E2NIyZQSy4Hhd3sldJ8Xzd8LKtk4787Q9xE/qNFRUJbw7jil6hOJ+HXHG096TnIT0wWysQXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fUc750sA; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7c49c979b5dso114353739f.1
        for <stable@vger.kernel.org>; Wed, 28 Feb 2024 08:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1709139447; x=1709744247; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HNUHzB6bTR8lkrQrwB9JvKFIHk8OQ9UNvaD+yVEbMY0=;
        b=fUc750sAFxkfAwL2xCN8vk2E3aaNJkHVaqoP4wIew8jDZ0K82+NmNHjhneAKgIoamY
         cNgfN5dc0PnWnLchxYWNszlUpc280bk5g250901utF8NBer/j/bmcoRyjdTCvIOx1zor
         dzRnkIdkqos/pObvqOt73+0+PYIKkI4YHHWHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709139447; x=1709744247;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HNUHzB6bTR8lkrQrwB9JvKFIHk8OQ9UNvaD+yVEbMY0=;
        b=k0vHRQ/O+2wdyIojK4VpEXdlKlnRoWUsu3Myrlpg+PIzCdt6WN2mi+AKeU4oueb3na
         TyQaaKCOacg0SQ8BfP5WE2fG6o/kkoacAQAROKXHnYNV38AnRIajfwJkEh/Cl36mgW2s
         G1a1L4hGFBZjKhD00vc44kk9hedaXrTs73DxmTirmlZ40+wPTzn0tgr1tLwHOX5dIQdr
         MgHlddYLl1EJhfULyBoN7mjUUExV7xNSvzuSkqFruOpbQZFgdfv4bJ6BFKrhuwdIgytx
         lYkm0YB6MdSpaJZlttJ2RMkmIlaErWr9TFa2l27i3N/jLihqACiOg3iAex52BPhShUIG
         7R7w==
X-Forwarded-Encrypted: i=1; AJvYcCWGsx7NBbPVArrAm8owlz9oLmBfIUM1uVoenDUbcUPgoA9T+++cQ8HwUMS5yMticoSZrIHgjzRXzRqvisn8vd2EfilLojg0
X-Gm-Message-State: AOJu0Yzmoe1VoiUkqMiMfdjQi6ehGNExtk3C4M8GVj8vO4TByIAnYm3x
	HI7SzzrWS1tU30SKTf2FwFGVON5NrGODjKy5PwBoikZ7hccIWXeFbY+Mi19gjSlU4QAzWILDa1S
	nk28=
X-Google-Smtp-Source: AGHT+IEYqpBKyp8I8JnTiZT8VG1R5X6EV3Xdx0Ok2vStet+qqfgqgLz4QUj/IMZf8xcfL3JAP7OUlQ==
X-Received: by 2002:a92:cda6:0:b0:365:4e45:33ad with SMTP id g6-20020a92cda6000000b003654e4533admr12522573ild.1.1709139446863;
        Wed, 28 Feb 2024 08:57:26 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id bn29-20020a056e02339d00b0036533cae5afsm623565ilb.60.2024.02.28.08.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 08:57:26 -0800 (PST)
Message-ID: <fa711f78-98b0-48a3-95cf-594ff41e0998@linuxfoundation.org>
Date: Wed, 28 Feb 2024 09:57:25 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/84] 5.4.270-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240227131552.864701583@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240227131552.864701583@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/24 06:26, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.270 release.
> There are 84 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.270-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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

