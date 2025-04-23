Return-Path: <stable+bounces-136480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C36A99948
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 22:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7907D3B3241
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 20:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E52F1FA178;
	Wed, 23 Apr 2025 20:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="cgCWl/Df"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C080D25C82B;
	Wed, 23 Apr 2025 20:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745439416; cv=none; b=N+1VcbLXVoL8NYdxe48lSYGRT9tuRDwz3HNSWnvwZpA/qx8LKFAz+sfn4HckcQlb8yfFQ88lm7incldfhVQLCKxHzh3key/UTn3FPgEDqHeKx9bZEsbuqMo9H38E3CDdYpc2p2OqylrN3diuiEUqOxVunW8cASO4bPAIjwPFgcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745439416; c=relaxed/simple;
	bh=h7T8+dLPFaxvNr5PCwSx7NoiX1XTm7peKqnR6Y+iAV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DZhMAu+ieJQTdATHzVp8FpVQ0xapAcD64VjBhltzP5WgK+LyWXwfzUnVNs1Ei4Vb05pRZv5WAE/FJbUZmvtIYun9NJ6JyxCmg14ZxvaSiB+2F9Xmw7kpe1+NV2/0wkUZmthde2TBwITogoRSKPNNVSNXxPR35wRTeXmrXngaRec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=cgCWl/Df; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43ce70f9afbso2603575e9.0;
        Wed, 23 Apr 2025 13:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1745439413; x=1746044213; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pk6xFqDW2cX7PSH4k7StvfF5r46ogCFacc7tpRNh320=;
        b=cgCWl/DfQShLxdcd42QqtvdD2wPDuhvMDBKrIQKo8jscrqBCPVJxXwthCcx2crxxOY
         usk0451C9x/J99teje7CK/KNWDWzgr+v0EBpaa4g9Ex17ADrRMOlTyUfcfY6BZI/SEXI
         2ysj/9ZmLHsY80MKQqslXo0uBX2a7Vek5NTdwM3Av+1UJPpKarKD1di1VguLRWIZvhuZ
         o1N3porlVVLKImmJUhlwdMtw448ldRYKa+V4MofOkcrFcGWnu5SvjA74m/IyvVMtkqf6
         v55bwtKoGZCyuBqlSSpMY7TUsJUHMuoqicbnY+H+iOGSa/sQ12I84EBsf8rAHCCchuJ9
         wiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745439413; x=1746044213;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pk6xFqDW2cX7PSH4k7StvfF5r46ogCFacc7tpRNh320=;
        b=LFT1ADxCPfbpJ6THaT7LUrZpqcWMSh4+d2IifqYjKEsrOA+6+sZ/sT2zuNG9XmkRHL
         8dAqE2DOFplXD6n6PXyUkHdbwZoK9pj5V0Cl17gbbTlvkw+1XkspxDEOA1IeYZlUoTvM
         judZvcao3kLWV1okBEYvdX3KhD6Emi5ndGdalBnt4z40zNonx2VDMrt29I0dxHgyfZuv
         F/4Hig0/TbXmI/3jqLxkJl9iOsc1xYZgHkllSH59eT6FtkafxHBzQQyMtLJvCjZzJWn0
         g0SLihdirQB6WedN+P/u7ZbMmNOHNDKANulVNk9fpQuyXchlaSnOFBbA86KgduS6bgYI
         qsUg==
X-Forwarded-Encrypted: i=1; AJvYcCVZCkA1yWnBNf8JC4Xu+VvTgAD3SfnZLHbLLD8xZZk/7Osw+b8zC56qJUUk+AImgaGCwD4h/8tORcRiNGM=@vger.kernel.org, AJvYcCWtb7vOHRbx9sxi61WegGRn7DjYMuLVF2Dr+YM16sBpO3cB9kCEhLIGyT34/GyU4hLJGa2OMNCZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ3Ue/+Ea6Lge841e6/SRxFFPVu/M7hTQwoidxMJbE2wySvVTn
	8jKDB8HP8WLpq4nsAl53oupMteagqfHEje/uZENBY05KXJWnsxY=
X-Gm-Gg: ASbGnctT3jh0hjjhbtPsGwnweWMUilqYAggeNf9XKC1WXVOoL82wNOKM2DsC0usJohF
	svGOIOeUh7NjaJk8R8OaQsUJStZhdZX+QwdSulliFI9E35fDQp0cwdloIMolhUdjiWg468KH3Mz
	9aqQ12qWlBCLWBO9U82rSTjehe+sTFC7cuso23JzW/966lY9nO3YCXUHYdazbnu6nFPQ6iQP16+
	RpgZtl5wn4Tki+KWCpOOr5Vs2YqRT/Nx9VLLgs/ZSsK7BVzBzHTGdfIf8qxcSY/nZkxKTaERPaK
	ctH01pVdSONNX5hejU5EI6u5jUktnXzdXiBEwDmWMLfffkoGXIIFt4iXsoAkLQJSjIYSLh2rGg4
	XGZVTb89KSQ0VYLql6Q==
X-Google-Smtp-Source: AGHT+IG6ygyb+JLOfPMzuWw3Oq5oLqz59HuZQFAmh9OMTxU+umN9328qIdPjwtVWAQ1dcTM7yJGv2A==
X-Received: by 2002:a05:600c:a4f:b0:43c:fcb1:528a with SMTP id 5b1f17b1804b1-4409bd04a6amr102715e9.6.1745439412610;
        Wed, 23 Apr 2025 13:16:52 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac758.dip0.t-ipconnect.de. [91.42.199.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4408d04802fsm36964285e9.1.2025.04.23.13.16.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 13:16:51 -0700 (PDT)
Message-ID: <2f9db195-4d99-47ff-8384-1f2f225178c3@googlemail.com>
Date: Wed, 23 Apr 2025 22:16:50 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.14 000/241] 6.14.4-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250423142620.525425242@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250423142620.525425242@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 23.04.2025 um 16:41 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.14.4 release.
> There are 241 patches in this series, all will be posted as a response
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

