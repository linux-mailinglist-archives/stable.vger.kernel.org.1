Return-Path: <stable+bounces-83067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 985A9995400
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 18:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8A081C23BFE
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 16:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B2318CC15;
	Tue,  8 Oct 2024 16:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="LwhcxvxC"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD7E224F0;
	Tue,  8 Oct 2024 16:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728403526; cv=none; b=DHDu8gqZQOaOLyxlwKvKbg0SUD3AIemT0ef4voFtGf7l913Q50L59lVlMFtNtvT3frvAl9YWBiG+nOmDGBjkdMDXrd5qoaPWDrMUFKaSu5jeNQrCFxyztWQ2cT4qWqcaP4gKI6S0opI4i2uE+b2032sBHk6t5HS9P7j4sbD3hPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728403526; c=relaxed/simple;
	bh=W66HPaI7vCTTXRg0sHOI+UJgtuGeaYK/rqCGihZVcsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rO/nWgaM6TcAo7xEFycP0GfCRg2zmEUQpFa+hCdtiBzd2QnQj0x3cIlvwNePOqPaHrF1AVP/G0nwYw5eF5B9087tncKTkJRGmk0/oeaaIK8Oz9kln73yHgDyys0CiA6nS3KYnHgvBzxW69lCoRFJOh6poQhTnOO7iA9PEfi0GJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=LwhcxvxC; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42ca6ba750eso37006535e9.0;
        Tue, 08 Oct 2024 09:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1728403523; x=1729008323; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uyg5938XUdbci+Id2jSlJ3QKaymXAYrdG/rjhrWuEI8=;
        b=LwhcxvxC5sMbd/k1VRshfwpJNoD63Na1G8wJXsXtkTedlG9LrDK4npmpNK2jW9kn9s
         fspvB/TQfDx1abpEeplNgD7AUBjFnP2W4U/oIuaahlT7pbCjptil0UcTsr9z3MPYYj8K
         3vJ+R+JUmul/NzRckwbYYXcv3T2NoHLOgz4a2qlUek96WoltuG5LwbRxD4b4MgJBcAjg
         Q545SckHpijt0+zi6mox2RqDTNzceciVhUVDnANvhdUABATC38i0rxk6ShNjhiap5D49
         /GuU8AzM60mOnkNkiv1+cC9LgbZmGkQx2JCvwFfn8kcGK3ajIqLCs7myLZwyJpUqaSXV
         18Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728403523; x=1729008323;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uyg5938XUdbci+Id2jSlJ3QKaymXAYrdG/rjhrWuEI8=;
        b=CQG7Ti7L10hVy2ECEXgNDSBkjVIlAqtdWa/LXj9rEJCjLMy5mIgFYNBbfPhcwc+jMc
         wsbTI7Xyn1KUBqAXyrUV0CBnLJIWXrhVnDyilAAFFACXezd8N7z16xkChdUQ/Wf5/j/z
         JcGSHDU0ZJBp7xwrZANr3b/6NPMdNJCvRpQ3ddCd147vYJ6Ict83PcBDuPexaEweDPeH
         xMJthF1sbbucye4uKf/lAQcrCEA3h+vAIYiXAPIQvJ/asdA8T8sRtzbEPo23mLoVzBrD
         VTvPiFvKv9Gz5V1TMVsvN//AMSua90EUMRc+cHUCfdcyvg6oxPTMRWT2pJcHYgiXY2aB
         A1xg==
X-Forwarded-Encrypted: i=1; AJvYcCVJlzt1I2vA3ulbuOEmSTps9Ph/NnQd3lhZyM6xEhYpvBFbGXuklpqnjIhHExELkUTUjnhFuKY3@vger.kernel.org, AJvYcCXJn3KaXAupa621k3jAsBt2iGmKZeTWIbmbhxoR8SvPChOJq+bYd9ML8E7C8GaNvgwwUvan7FYZG0sMSnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLU+Auj5CMfQrTKrLMsXJb2pUzgKVXGiHPzV5XjzMJ2HOjrWyw
	bSq9xj2Ux9UceQ66vkblVGJFJndoonp8LjEHxSm378KtJ0kBX+8=
X-Google-Smtp-Source: AGHT+IHI3HNkUhkt+2Et79RsDlbHBNOOu28DFhEn8C0r9PruI3pYmDHi7Vz5GxFuYkTpi1aT6S9+/g==
X-Received: by 2002:a05:600c:1391:b0:42c:bd5a:9471 with SMTP id 5b1f17b1804b1-42f94c18e42mr24494485e9.16.1728403522574;
        Tue, 08 Oct 2024 09:05:22 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4723.dip0.t-ipconnect.de. [91.43.71.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4304efc442esm19349255e9.1.2024.10.08.09.05.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 09:05:21 -0700 (PDT)
Message-ID: <62aeeca9-ab16-48e2-b529-1587556bf19d@googlemail.com>
Date: Tue, 8 Oct 2024 18:05:20 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.10 000/482] 6.10.14-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20241008115648.280954295@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20241008115648.280954295@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 08.10.2024 um 14:01 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.10.14 release.
> There are 482 patches in this series, all will be posted as a response
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

