Return-Path: <stable+bounces-118575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FACA3F473
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 13:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7432B7AA15C
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 12:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE1D20B1F2;
	Fri, 21 Feb 2025 12:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="KWe8oHvZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2A31EB1B9;
	Fri, 21 Feb 2025 12:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740141201; cv=none; b=c5zp1jcZ0CYMIHHkbwh1wCdB7zMAb7mc+NaJblwu4w/T47WuNQSqNmTzSrIWGFvdmij8+M0cej2utyHTygeGUDKHkANwzTSgXr48qtuTDtvoq+BotohPck+aOKycKtO1Wueko42O17UFZ6lFOpeLZf5mEo7/QK8tNNQSc2zuuiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740141201; c=relaxed/simple;
	bh=7h+xKsbMfStig+XlYD+UdroH+uVoiqQNnDneazl/cf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qWQVGVOcKfcMMgOqfX2MpeL6mRp/UiIQVwgYP9mv82KkqvqDG1aXYCCVQUeCSciXMe2/QU9wVtsNtAQdt8anUNrUX05Qst34RK9nUTq0LEjNatZOvhYxsfKb5pSZXBK+su13QSckqQVq2qtUxkKsFTAdxrV+mFyMWqXnEwiTfPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=KWe8oHvZ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-439a1e8ba83so19786015e9.3;
        Fri, 21 Feb 2025 04:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1740141198; x=1740745998; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ukGOvykZUEzCZzFlDm/VHVrIH7A0BbFaLwBfx+r//9s=;
        b=KWe8oHvZLKuV0U46dPD/fogzoahxl6JuxXzwrBN+dww7AtQV1HVym7ApIMZnu89vnX
         eVEhgLnztTxtzUDCPtYKWDDMN8N63JJS/WKNPXHCreXLFQjrt200it0B0UxatY8oqaj9
         Mxk3j76x6KwmEadIA7MIH0vJUZZttwY/g/RB3kv/QWLfNbar8Rgz7ww6oyMkbUfqLELb
         HejrERDqmA0qBoCuSOLu50EFL6KXFitqK+BNEAFS3tFFpu035sDqPgFHFhyPqdvHbLon
         ywhMoBPiyux3P2ZhtO9XsPJYudUYLeh+QWd7hAkq1gHkEPnRg4KGDjktbFb97EbcHkmJ
         c1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740141198; x=1740745998;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ukGOvykZUEzCZzFlDm/VHVrIH7A0BbFaLwBfx+r//9s=;
        b=N8k1WDskFBtdwJ3XVIoUdLtF2SbvUcHA1aQnFAhjqF4+VNgU4kkV2q+dNJpom5lurw
         XfXHptk/3SsUyB1Kv64Sk6+ZyyHWt+BO+vjKbAcCddHhZUY68wQGiVN+YW2k0/2WUfr9
         j5DvyyWMJ9Hc5Db6HtNVhBi3xOmZtYnlowOIHCf4trRQKc09BjRzwB79/WmNHCm7sJwR
         o0Z/2GyySgCg3UjXEbq1IvQ2dd1IEvkXtZwshDlxh3rCcO7vmTungFfUuqZM8vxws0Bm
         TA0GSTATlGkWrzey3jcH3274osyWTJ6UUlXEBB/7cWcTGvNXfv0b9PY5JcDOdjCrjmJS
         BsPA==
X-Forwarded-Encrypted: i=1; AJvYcCUQ74SSdDH+AwSY8xBySQeehHhnPT+pINHYPlMYA2VhTm47B/C0ghBkO73S94T1dUcdxPp4FX9R@vger.kernel.org, AJvYcCV55dVrEtoQkzPA/T+m51aDo96FxfKC50RqiypU8+cReTi9LWY2ZPZx4Aqzorq1fdgnCUpa9mKp/tl6EoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhrvOq7Q2gui7iZkDuzby4Cr7SnK9gXyDnEPpT66r8x5eUPy6d
	9qQYiBljU+tzLGJzC48QOpqfNGr42xgllaHsU34yrvMD6r3RNkcMgNIHwTg=
X-Gm-Gg: ASbGncsE5KSDedVgOVTrv6nl0RGE8fMv2emaGtv9lNwCgGPtoI7OvNRydPHs83zCxwG
	62+TK8NSZfc5WJ4Hx4M6iN81AM9xU9i2YGmktTJHQNNCI2WGx9tPlPQiyOMF34GW3LCzQMCdmSK
	9oznkvn91ffDqUV3fhtS9B1rffsY8hxga/5XTlc13n/sSslyrBZVkblRTJW1PVxnvbpENcgwB9F
	kjxU3cOaCubewvaOg3Ac0WVqQ57B5TIeshy9n2vkJYeM06Zfo1/Y0Ar9a2UUkqJWt6KLijdRgtq
	DdNX3hrihQ2euvfLsxTSP7JOk5KIgKD6k9SEuv1Y2zbDafjabl2TVTfX24D3f0CedE/K7ipVwLF
	2dHA=
X-Google-Smtp-Source: AGHT+IHi+9gA7iLuLNRjwkEHuSn4XLZGb306Rvq3LF2wd97SMFpiWRkCm0uOoyNBvbMFfHBHoywnnQ==
X-Received: by 2002:a05:600c:4687:b0:439:9aca:3285 with SMTP id 5b1f17b1804b1-439b6ad5cbfmr4543865e9.6.1740141197480;
        Fri, 21 Feb 2025 04:33:17 -0800 (PST)
Received: from [192.168.1.3] (p5b2b437f.dip0.t-ipconnect.de. [91.43.67.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f85c2sm24045464f8f.91.2025.02.21.04.33.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 04:33:16 -0800 (PST)
Message-ID: <9344125e-f18a-438c-9e50-535c7e5d1c3d@googlemail.com>
Date: Fri, 21 Feb 2025 13:33:16 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.13 000/258] 6.13.4-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250220104500.178420129@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250220104500.178420129@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 20.02.2025 um 11:58 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.13.4 release.
> There are 258 patches in this series, all will be posted as a response
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

