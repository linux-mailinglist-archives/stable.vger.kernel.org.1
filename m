Return-Path: <stable+bounces-150614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE5CACBA34
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 19:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80BA93A449C
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138C52253F3;
	Mon,  2 Jun 2025 17:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="N7OdBEWJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4374F224AFC;
	Mon,  2 Jun 2025 17:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748885147; cv=none; b=CG8uvAMCA3psn2Bs0tR4iSkF1Niu67FZrRgaybSZ3PUw8HZymKgFtNb+GPYpzlCEg63wpF+xKgm5h1R10R1GToFAq9nsTPN94ewtmhqcQGUSFUrP/8P8XuDXnX8uvXKXg8i2yHJY68/Y5WvqVAJbHBTlngObyjkwmR7+476SwiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748885147; c=relaxed/simple;
	bh=YfXGAwKO9Hp9sS3kUPLXOoBb62icCKPXTFupZoW5qiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d2yFFDuURKgnkTbQXoUGaCNcBptvg4DbO7UQsrJARsmtsIPjYpNis9Q5Q78NC+5uEU0JNxYcR3Xve0rR4Bvb+sfkTZlfST1gU9IoqeC2Q80+qK7wuaCZsTxB+kEP19hHfwftsakbUKbkeCeIU7G5BeecYCSy3D62FH/JgMjWwJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=N7OdBEWJ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a36efcadb8so4101579f8f.0;
        Mon, 02 Jun 2025 10:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1748885144; x=1749489944; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1S+RpxvxyphSVE8B8fHLWbnA8TTbuz2RmjgMW6z0rDE=;
        b=N7OdBEWJFVjoP83gg2ynyBCpnj64bNOjwRZP0xYIpqY/HndTzVaZvAe+WkAe867J2K
         STW841h3+PfRxVIujO38spb9ubq9WHfo+skg8dWUg2ROoJsifm5YLU5TgBIbv4qLauL8
         YT85vCf2PPyncUaCdJdJRqZgktGZE1P4bqS6AHudpq9Fp0PkiINCj85rP+7BShpsAdB8
         gdJkZffpchqUFY0/7+2VK36lwDMNnrDZD92WZOLe3VYjfDtCeBVMcRZXewHIkO0qhUiN
         SEWmes+zO21gOox9qUp0fhNrHzMoiBeuwNygE7gj1x5+Yl7/l19Do0/PYAwIOGybTeG6
         7cIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748885144; x=1749489944;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1S+RpxvxyphSVE8B8fHLWbnA8TTbuz2RmjgMW6z0rDE=;
        b=wsCXNrzrFTLeQSooeAUpn63ky/qcSpbq/H54GBAgUu6XjRZ4qcFzgjEs3bk2OLOSZp
         wOF9gQxcEbxoJK4u8FSvG+31jBjQMK4xqlJ40XiPg3EHmI8mXJqn2sNYHc4dTZTYpZr9
         2+HyVgDXMVGoeH/Vgw9kWBkfUd98yuEkp8KofJU3AMPrmEhfPfH8dvQIu/Tgq/AsNelM
         wc8YCcElqm5xj0Y1cohOiLUCmBzsXjafGGAh+0moI8plw5EEwoW6UUWGpKToA7unFWab
         3mtHQMyBAIToqRu0v1DXuyX1HAfjwTt5eWJEM0vVIONCOcnad3vGg/UBPEh+kecEemu+
         jhBA==
X-Forwarded-Encrypted: i=1; AJvYcCUoUf78wpjf1rG+QHAfTAd2QDowlMjNk+1VLJQuUdC8aI+r2HWVvsFBEHsHtp+fgPAh4MTXUBwr@vger.kernel.org, AJvYcCX8TXkmIERfpLx4/FJgKxw4lbOCjTfy3UoOVM4lPjf9Woe4E6yp5GBVtZQZ/omJrXtWfsnh7Z4gQrGEW9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YysXqyu5ILdQe9eVHEbC3npwPjEZLpVX3a6IHuldAr7rbnZOUX/
	dVKt+cVd09sr8LgG+veLd2Bt0HEtcaD47Osg2t1O2iKDS30fggzFrCE=
X-Gm-Gg: ASbGnct4tbtHR02dzXMuM9n4ZdkJqKyY9Ml8tkwqrVN6Jf6fZlaFrHxaV65wPDsgAwl
	y+sSVCKZV8qXINPzNjixryIj0JgyPm0yl/Uq0u1EDUst5j8Vx/geuSDTxgSXusmapj4XOBa8pP0
	lAVOJSPbsrS91vSvQIgK/SVmRnIKiFxCHqAqxFkuRqiPxExvvcDtVb64HtjXycBECtI7RS1WiQx
	BsBKqsrA6Jo7rjpUbuAv3dfonrk3y/9t1ALufAYPwo+xpPz1oBnVuQxydeudlQJf72aoiK5+Lvq
	iwdcIe3KOp8oK6Fp/L43FmxEYk2bANAVJkqUo1WyhL+HMjMfQtgZNy7AvmtfeIfnpN6B85YQ5G2
	SVNOV8aHBlGFPWIlndoyOleSVB6Y=
X-Google-Smtp-Source: AGHT+IEik8+s+HEIkjVI2p4vsVV/U7psFNK5HwtqnPw+czPQPwWPwcWIW7xERKd82VU4BHsRIw1WQg==
X-Received: by 2002:a05:6000:2c0d:b0:3a3:7115:5e7a with SMTP id ffacd0b85a97d-3a4f7a9d5e8mr10728344f8f.42.1748885144432;
        Mon, 02 Jun 2025 10:25:44 -0700 (PDT)
Received: from [192.168.1.3] (p5b057d53.dip0.t-ipconnect.de. [91.5.125.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe5b89dsm15756966f8f.19.2025.06.02.10.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 10:25:43 -0700 (PDT)
Message-ID: <5d3aa166-c713-44b8-8552-0992b2febb85@googlemail.com>
Date: Mon, 2 Jun 2025 19:25:42 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/444] 6.6.93-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250602134340.906731340@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250602134340.906731340@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 02.06.2025 um 15:41 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.93 release.
> There are 444 patches in this series, all will be posted as a response
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

