Return-Path: <stable+bounces-158431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31553AE6CA4
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 18:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 721D27AE5FA
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 16:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095D22E2F07;
	Tue, 24 Jun 2025 16:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="cMiwsUfE"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EAD770E2;
	Tue, 24 Jun 2025 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750783261; cv=none; b=LDJoGbrD4W+Fl9VUzn/d+PRBYD4w+Wp19zJTWs1uByLoCBTOV9nrCwX724iLFCElZXsT+qF0udXYIC67AhTnvqZW1dwKYSuuP+kqyKbHgTdlBf7+Hhbc7gWfzP/8UYcGcIUrm805ELXxgUPy4EGbGeNvO8lP0kTrrlt7y/Oe38c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750783261; c=relaxed/simple;
	bh=bLv2ZvkgYW7eElSTuPTXO/NeEVfHDPT1jlpcZEZNU7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c1AdG3Z9DkodRYMOqXCqTBSTveST84SujN7erMewyOPXz/5snzffa5ghknuRMBHsH6j5iROgaFOxqJ3ZYWvcZUIvVyA9MPA/X2NznIKMr4ibfRz/hFAGY1jR11YlW8I0ZCLVzznDvzrvOV8R3216kDoe167EhST+l6GA5SCYGXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=cMiwsUfE; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-453398e90e9so38462885e9.1;
        Tue, 24 Jun 2025 09:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1750783258; x=1751388058; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vf4F0rlWcp9KU3CJvu4wbkYZgfX0ZRwl7p2Dj8IyGas=;
        b=cMiwsUfEyl40o7UUdW1/izhhl5GguKoH5Vh02SYHb7nz/4BKdfHKccfqvAPp3N6Mq6
         GVzvKZRzmSGA0wJ4Ycx/sLPixkaeZGZzwWbRmuz3jvcOuo3sN7CpE1j8xOCu9X7k16vM
         U5yBkBELFFCmGbgl78Yo5l11qDFr/9gdhjNOzPtcStt/VOWxF6fSaMuLw1vR++4Rz3Ic
         N2UGNReZD/dzsXy6wGp9k4YH9Bsvv63XJUUY9Nrid9vEMoROi9RyHvdsCe5KFedj0U6U
         VLN8WeXR2j7D3PWn/F+IIwi+NOKd2vGuQUHAVlnTvI1O4F/PnZJSKVthmKYvMCEQNv57
         tIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750783258; x=1751388058;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vf4F0rlWcp9KU3CJvu4wbkYZgfX0ZRwl7p2Dj8IyGas=;
        b=WaXK0L2toUj/phW3aqwWmVTspxOw7Oy1/O11peKAnX3vgk86AU1QEgQfIIuXcemKAo
         FIgOdNkorLS55vUsl3jgDBZkB6ju6mRiYpaXFCTcxWBB9YTx2wNiq+oLKu84jW5pqHDz
         1Q4fYotd4Opc/FnN2aMXCT2gg8875XxuXJDLcQKs1x8JtUB2KminnTQnLuY7X1mS+AbB
         8uxeeT5x7rZVaGcZq7G8rlVYk8ml+mZv8+o2365ZFdEa8GWdkTg/6qU91A6344wJnLao
         3YX6jtDaFZQ6RWRol2yKJNh3hLAwPvI+NNSvgVdKgbp5X74Dv9XQe3aLyP99RjFU0Jwi
         5S2w==
X-Forwarded-Encrypted: i=1; AJvYcCVaDvGTwq21pi1I4aMpzCicvHjxW6wEUOx6abJlq1EKg3MmhhL1lTmsAxNx3F3oCfnvbGtKEIhq@vger.kernel.org, AJvYcCVzDJQEizxvCP2k8YV4TvsBBV6arGWN9eteQfZuo79sZwV+1boQfQvtxaWYJkjxJVL/jaeCcHbUTHFWVB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL2A97E/7cMT9dJyMYy65ttw7g/lTSMkssYf/vkwrQzchYz/3I
	R2JDjiT8LXum7wkdQJSBGQfTVXNyPXZ/rlBrmaKa/m1fqd2oZ8iw5cg=
X-Gm-Gg: ASbGncuPgYwowrHl1ScimRsKf2EO7L1zivJv36CvL3dXaZvhDjkNNUqsuV1t8clOXGT
	h0qF0oIWlyV70xoJ/e4FiU3V0jlP4xIp0VOFMpiYSeq/AU9iSVDdnyhErNZaM0f7nH+TN4vrKAp
	1DDOkab+5Y2f4AZ8pCWVUFQi5VJxaQLhgUE9d0qGS+Bk3AvmiI22KFeF4W/oZri7c6QCIfRhPvS
	rVEWpbxi3WKKJOX8X/7zAoHvsB263IxygHS3dUoKdZSq5HUSSlfsw7lMH2erCZpZp/nHlLtuwYB
	hOOVxBlHxCo+Xwh7KwSn7Gx+dQWuXNS7GnCk2i8oj9CZdM0YvFP1POmPPSkXysMgoHuULoHejzC
	wofTjjcylFXiCWvY4TowHzpC2h0xMEnkKiRZkuFM=
X-Google-Smtp-Source: AGHT+IHL37tk7x87MU4ZTonT26CiX0N0ee272yuwd/21jHdnNVtMyb7eo70HBqeMi4qHY2RQmZWlfg==
X-Received: by 2002:a05:600c:1e8a:b0:44a:b9e4:4e6f with SMTP id 5b1f17b1804b1-453659ec1b7mr149785565e9.16.1750783258235;
        Tue, 24 Jun 2025 09:40:58 -0700 (PDT)
Received: from [192.168.1.3] (p5b2acd47.dip0.t-ipconnect.de. [91.42.205.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535e97abf6sm179158175e9.6.2025.06.24.09.40.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 09:40:57 -0700 (PDT)
Message-ID: <0b783dcd-75f8-4b1e-b0e3-9052e419e62b@googlemail.com>
Date: Tue, 24 Jun 2025 18:40:56 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/288] 6.6.95-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250624121409.093630364@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250624121409.093630364@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 24.06.2025 um 14:29 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.95 release.
> There are 288 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Just like rc1, rc2 builds, boots and works fine on my 2-socket Ivy Bridge Xeon E5-2697 v2 
server. No dmesg oddities or regressions found.

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

