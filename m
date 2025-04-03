Return-Path: <stable+bounces-128158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D51ABA7B214
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 00:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96106179648
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6471AB6F1;
	Thu,  3 Apr 2025 22:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="mBbfLtHu"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9DD1A317E;
	Thu,  3 Apr 2025 22:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743720021; cv=none; b=rL+H92BIcDGuXVRteA5SaCUnCcIP3FCWln1ElV37WY0YFrm1+KlJta/wHzp470tCTXbhDA9VsVRqr0HIKT2FcM5MwZYgWos0sWTlpurA6CBN7kK7m+JH1+YwxjeLOXVDk4ZZbEG9cn7s4nglxHjFxuqD+TZdaY7nAjrXj2IOgrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743720021; c=relaxed/simple;
	bh=C0vdjRDJZakc74qJQQwFBMNl7Rcg1MWJAF0DjtgwOlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nT25DJakRYhVr1ZYQ4X30pRKKh8hM9eHk9V5g1b9jTEI5mjol6aexaENGfEXU1kaq7MIAF7xuQbB0ccL2Ih+cu88u1xWw2kr3AiGhuYReTD9FH5vIzOAAxBCE/OrzC7xHeiopo+XSnM349AwkOikZnGc75pFUMRe0oyypkvQEKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=mBbfLtHu; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3912fdddf8fso1615474f8f.1;
        Thu, 03 Apr 2025 15:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1743720017; x=1744324817; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1OPzpbeROVt3iebNoDgfJuVub0bw6Mab3GZ6fxFNwb4=;
        b=mBbfLtHuO2o0hJeh2X+Hq0nvJAuLSXOnRbowBTR78TGwjxAN73BmdrDRRo8c6G3EVw
         BCsqjGC399ZY7cQc8xB/sUQZAjrbMnqbLeN3phMJj9Tws7kEK3UaXraQZUuNLadRhgcG
         Ua/RCYaEUx2QYSjX35LVdIrOP7YVU/4W9NW0QPG5YazJgBSiSS86YIENz2Q5JOxcxaxS
         gB64+awbuBM6eC+lnyl+Lg4DowpluOmBR3HxlgB/PXybHCqCfmXRwf2BmtGoxKBiqw0K
         3NNURJ4O5dLElMsGI9IG+CPWZmOc/YTzFoGqc1iSJteukytpU75unU42bPyxNH68DkS8
         EKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743720017; x=1744324817;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1OPzpbeROVt3iebNoDgfJuVub0bw6Mab3GZ6fxFNwb4=;
        b=PngOnD2NtafWgx4dVYntPdwrj/WBaJU0fBr+0t7gaNB77+64sTBTA+ur/Fm5Qpw5RQ
         1lpn+iMi5Q2WWs9KZJ1ysg0k3v7tcyOKor3DL3opbkrfrNU6HdHQOYr84Dt7puexiQmh
         fTU6v666L9tmjU1GIe3fCXF1Xyj8I7/jMm/Ud5f4vPEANimTNIFf2sm5NFcqGy5pWdTJ
         QGCbktMrUGpWN9jJ/ITpt7PU0uLHYXdcplcd9r5rFjjMlcxRNiL4vSfB9CW2zQCZ3cOv
         N0j+H2pbsYy9jsOfvhFQV+F9Lmn16hHPMg9cAvrLJ9nf7OBC187awlMA4w5dtwGdG2kE
         UFaA==
X-Forwarded-Encrypted: i=1; AJvYcCVOg5sBD51jL4cOMo8gR4tyObf52hTL5HEnnbhY5Xc0u7W7n+UU616jGsgvYZjcIIMs2Rhoq14SPoAihiM=@vger.kernel.org, AJvYcCVOvWX+W+Jw8GegqvgOW4DaP0Qne4kx6Q5fKvMuPk568lmoUxMCAnVen9euERekYYAf4TM1qM/L@vger.kernel.org
X-Gm-Message-State: AOJu0YxYDA+aTt8r8FMZR+1mdmmAa6ZOZtR3WoZr3LdIf6/98bbwHlw0
	a3bEBogUui8BRfpZM4hdwTTe9KjMrHcVBdW4Efzfjkr84JCgYrLwra4r
X-Gm-Gg: ASbGnctUiaN5em95WOPkKypM05hA4dtxnIX1SIc71kGAalQ5XO2042e9tL/kRoIaBIZ
	iYkWu0Ff6t47DW9uLLc5guySGP2c1jEM5iZZj2tGbeT858xsKWlrIGHpXEGgbYmkv+mDewZBfLP
	7xq6Z2FTs1o0N7ATO2iPmtZjzCj7Rv67Ph9AJrEnEc2yDCWQGyBjQPddfHkTKwfzeMlAZXMpp0d
	+0z1wqwvs9WXsiNBz5UxUn45ppJV532nAYmnD5qE1T3+IpaEJ99HFaHZjl0LdWRTrYT/H4Yu/ku
	6WflDb/fFRI8/+aVdeZQGuICkrGnJDM6J0zKhsjkSMRNjpI09GF+BjXAFMoz4d89eEQtc6YlkX7
	YfiubWmeEQ11xSIk/O+mEtQY=
X-Google-Smtp-Source: AGHT+IFOb6izVa62SvLGubqLsioOz8B+D5IB4XXfBBTooXiRS5/iI5bZDjKC0LfOU2ryXUUnVZHr8w==
X-Received: by 2002:a5d:5848:0:b0:39c:1efb:f7c4 with SMTP id ffacd0b85a97d-39c2e65a54fmr4290054f8f.25.1743720016962;
        Thu, 03 Apr 2025 15:40:16 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac393.dip0.t-ipconnect.de. [91.42.195.147])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec364cb9asm29384235e9.31.2025.04.03.15.40.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 15:40:16 -0700 (PDT)
Message-ID: <e4761e82-52ab-42a9-ba61-d95f46fd90ef@googlemail.com>
Date: Fri, 4 Apr 2025 00:40:15 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 00/26] 6.6.86-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250403151622.415201055@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250403151622.415201055@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 03.04.2025 um 17:20 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.86 release.
> There are 26 patches in this series, all will be posted as a response
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

