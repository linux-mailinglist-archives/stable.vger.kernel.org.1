Return-Path: <stable+bounces-126931-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E2CA749E2
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 13:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F1B1888ABE
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 12:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF63320B;
	Fri, 28 Mar 2025 12:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="VbIUA2p9"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDB18F7D;
	Fri, 28 Mar 2025 12:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743165478; cv=none; b=b1SqPgZB1kOvoI1t1knKH9ykLKhKs109j/kL9aux8gjUbSrOhzhaka2az80fxAapYPiJCFEGiITlZ+gZwqH8+s8xXOvf/B1IsBLCt8GKBb664tIFBzHgphCuriPK4jlcdD/5r2FmIbjf6IizfIv9BGWA9ZeshXZEWV9Rqh7mMXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743165478; c=relaxed/simple;
	bh=gXZMM9dIJk+UayztFAHwSYgFE4erlyKrm08RE2SIk7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sBsbSn5iQvmW2r3lislDh8ofH9w8YEQWBjUGBpLCq5nL6WkblxD0paihZupd5YaBAtaCRsHVMGAixqQbf3iwWa/4clHorGUjqVjlaMa4OZJiRnBRZ+Mon6gn5LTtp4OHjqA8n8qwPts564dS7U96WS2BrQ7uhuqB6ZWNVmuSGAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=VbIUA2p9; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso13757915e9.3;
        Fri, 28 Mar 2025 05:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1743165475; x=1743770275; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xQTCb13dlcBwF4DMmiRnbU7+UrXrX4JGlrCk5UoyzXc=;
        b=VbIUA2p9yCUuPKFjF62octjpZkjUbVa1JE6gqdUMGcCIbYWBAB/0x66/RHTbnDqd1A
         iZAGWGOuaWWfj5ZlKxbkQ16X8h+hxxAiwSZ3RKCvxH7Ely3BdefOPOb1pZUVY8klZSPj
         iyDTN1DhBT7cJG0fj7EnlPHv8wWdau6jxqbzWotXcNv0baLDkx/NU5ibq77vPRe/bjlJ
         SwzjWXMLxIfeKmjrYMeLeRiqS+VB3zc2qPopwS/mQLZDrNwtTrhacd0ZDXnCBri2TUCY
         taPysRVTZi86n3oksLfPJJPDbiDEPVMXmZFKZTy/aIUH3DhkS4JQc3DPfRGeia+x8EFx
         YioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743165475; x=1743770275;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xQTCb13dlcBwF4DMmiRnbU7+UrXrX4JGlrCk5UoyzXc=;
        b=CGuAJ10rD/uzdSbsbMx058QGkVecPETXyACNL4TPF/uuTvnWs0uQyrgceS9QGddY8R
         QhdLS8Xrke/X+lf5P6XdmASj2Xo+kl/YA/ZWIb/1DSa6rXfDC31BDVZO6X+hD1KddO6t
         ZeGG4X0t5Rqu9riLPxb6b4001/YchsSYUt1s/PsewZ5izoX5HctwgKCJuQO/+Xx19YmP
         vaQ/NPfQV1gtqYIv539/QxUZ25vsF4Ka0t8Ifax9LSp81WwU8QSA/WKz8InVeNrEHVX5
         W6rOndLKvjGPXdLSCxsZZ642vqhpBO9FGUHuClEvDphyfPHH8oXo7tfhntzl0z32Y+n9
         paXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAP/mIgnSvEd/OIK2JlphsrAPmkrBLsPRx11x62E6OZygV8kxjk3+yh9K08r9GxhT9+CuDSTl1tdcXuuo=@vger.kernel.org, AJvYcCWwnXT1j/dkr+frgOZpHdzMirp1lnvzg05mimfm38nOAtjmewjeX8yeIIJkZTzhoy6oTonRFY51@vger.kernel.org
X-Gm-Message-State: AOJu0YzAeNncI2Pole0k+cEoex/78tjZ+c4YlQw55g5g+dTx1i5PqPXM
	cdX3wrI0SuVNRGGhGnu7yh3480V9Tus/WQ9FPeKLDrHfic7INn8=
X-Gm-Gg: ASbGncv4otkLrfPf0uFupNYq+AJ0mKv/rhMUZWRhOFdkTn8FsqlhpRl3qc1sMxhYkGi
	WViF3RGU/gUZxe3SZm5ZZn/RCGNYtUjncrUyz1hWwk5QLiT5f35UZ52ul5cHz2LBvAJsYLCTtCv
	iItye2kt30gEqHFX7lpsquoZNkLT/KY9Eo+njTp94GIL3gN7G1K1AMr30QKQ8tn/JtANEE0ScyG
	0Rg0NgOtyCGK+86X/+btSRjPSo5L26ThLOfeaNltzP2RAIoqdxFKiJvVyhXTLKiUJca2FM+uDqf
	fFc9xStAzEIQLK9571lNcWx4NdCGNrMq/1GRcs93XGgsFEnY1Py2pyZPW2dBptT4R036vPX6fF3
	hDrZJrUuT7Y57SUK2cLGiP2w=
X-Google-Smtp-Source: AGHT+IETWTz0/f50w8S5qemUwIFlMsEwzmPuImlQZlXznfvbz7J2nktJXxQNH6s//faEpXnd3Av+FA==
X-Received: by 2002:a05:600c:4f89:b0:43c:f5e4:895e with SMTP id 5b1f17b1804b1-43d84f5b4d4mr68120615e9.1.1743165474637;
        Fri, 28 Mar 2025 05:37:54 -0700 (PDT)
Received: from [192.168.1.3] (p5b2acddf.dip0.t-ipconnect.de. [91.42.205.223])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82e834a5sm71937665e9.13.2025.03.28.05.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Mar 2025 05:37:53 -0700 (PDT)
Message-ID: <689412eb-8c45-452b-9364-c6edbcd655aa@googlemail.com>
Date: Fri, 28 Mar 2025 13:37:52 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/197] 6.1.132-rc3 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250328074420.301061796@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250328074420.301061796@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 28.03.2025 um 08:47 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.132 release.
> There are 197 patches in this series, all will be posted as a response
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

