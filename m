Return-Path: <stable+bounces-150620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1D8ACBA8C
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 19:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D739177CDC
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03768221F3E;
	Mon,  2 Jun 2025 17:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ienwBjFr"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2557317B421;
	Mon,  2 Jun 2025 17:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748887053; cv=none; b=kmejqzumCgR9QPwFM/d9OsnViQh9LXjR9jMtn+QBdnWsJKTSCyGoFeIIjkyJyNkxcdUARKEHYlG1SAfrXZdQKzwNLXYc0Kk1LazQgAjR7fQgrVDlBq+eMMUBLfLUmzB2AsNUYv+Uzr+gGJylZCDjak4fKjh3H7qLtnxOGYuzU44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748887053; c=relaxed/simple;
	bh=2GOZf3ZK+kouf6eCuH3GRhVA+4PJHHD1r9Kyl/KkY3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IzHaPQM4Vye2bBffPw8mrPHMYxee0JWssXQphxYIRgwchyIBMwgCfC2hV2wkO/FP7NLX3Rs1+0tOg8pJRu9KQRfR8QSUeIK9b5Dv8QtDRrF6QrP4vacfR/zyEGX2S5IkawiJjyXq1lKRLXxJaRGO6G+KuKBOiYzHLlM3F6wCy2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ienwBjFr; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so2404935e9.1;
        Mon, 02 Jun 2025 10:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1748887050; x=1749491850; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=snGX1yC3gwQhHh/3Yw2dMzBXiCeMuuYo8J/wjCbyLCk=;
        b=ienwBjFrf740qASwLiN0GSyDDsSvkA4A3fk0vn0G5zz1yeSAxSuOpfOsaHhFLbtizv
         YCxioE6RbsnVolMPl+aaJmwng4Jg0DHYACtpLDlABgRkpELmdzs6t5o3n6wAmI+JSV8O
         J1XLTQrt2oMr3bejJb/XXMLYjLyVwSyLe1MWLCXGCdFizmjDUbmZRVLsh1BhpnpJGDnn
         +qE+Z3ZlJRyK2hCu3p1n8O2t5qB3EpW3BIsWaFPC5JFW1WeAh9GJmpeqGiz2Gh/X2VBi
         vDM/MFVLWfy+GhAcqBWv9RL1WqhJCdGnp5LWnYQtipgISQuZb/bAcWvypHqf2Knq+l7d
         Lr9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748887050; x=1749491850;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=snGX1yC3gwQhHh/3Yw2dMzBXiCeMuuYo8J/wjCbyLCk=;
        b=uKUP6oNjHroM3aFs/QOaT4h7FgIlYSK3/zXrxnmPkfTpPm0PMFakDkbtVxwntJDlFD
         VIxj+K0KfgdkuBNVmSMWOnFZK4aVUUdmz9WPYtgl8pO5+AqAWpZWdUiUJvXIP498I8G/
         LG1m1k26mNFVeVkky8NbmG7w6a3V0cfG6K4pGIQjUvZEtqgc65GUFQ75askLhmBkxSgV
         CePVPpnWIB3Zezjzid8nGQ9kdDrGUYtL2IU1DTdjwsLQ2o+KgsHuf3pvrj1IqRRiWpsl
         0mlxXTyL+gjbAr5IDhj4v0OHAtB0+75lzWhpJnBk0qxlN2fmQobZ9FWii6nzjiZV++LU
         hFVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVz+9LNSnLmRi913coJhhLN8mdc04MUXcx6lakdahjYLAs6U4LCJE1rioncrUyrKODYkeFdTb7377nsegw=@vger.kernel.org, AJvYcCWxWXUttA2kpZMixJRf6LB743IEEz7IotWNH2kU8mgblpw1SVdJgiB++S1EBIPYv4GnUqPKD4qP@vger.kernel.org
X-Gm-Message-State: AOJu0YzlWOqhFiF6SjlCBaDcvlQTcg7aNNw4ZKF6+8TNveQn6I3S2d+7
	b88XcJ+ji7dBtL2jnXsRmgxuIgSg/t01I9tTyyU9mZU7/PTmk0p3GKE=
X-Gm-Gg: ASbGnct/ul3TAww8zArHCANdD6brs1mu5gH9b7OuT0Nmww7kqGvEKTCj2A8OD3w4xGE
	btiawxYpcxUIf6DH5OvYgAPBJCBJUNBs5Ay1SjkXu5f823mTZut2nhdZTPQUu3ybN28ynmARoaZ
	A+ALSGbgmvpQHHi6mlb2ZRvbuX7KL4L0JdxoXFtNTEDnSYg52n0kbi5gg7Td2SoHfEDFPqNJezw
	ZjHjIw9d/jLC2sBh29CDDrqPXRmegICxz8pvwHxw2T0K31ZqQjUQ+cx9/W6bA7xUm9TZRrLC9G3
	wUonmVPqA8TL6tg9ONsrecWd+qPyS+Gk3j0osa4HzVQ4A4mRo7Dy+Lw041zB6S1w7NJ1ZOqc81f
	WeHWe4z4US6OoOGnLrt7bcY4L6Yc=
X-Google-Smtp-Source: AGHT+IFcbGuzF0PMHMSj1i2nbCS+NR23yMX77ZiMp+Zs5v+Lo07vDZLMwFprl5U8Gd6qyt0ka711AA==
X-Received: by 2002:a05:600c:5009:b0:43d:5264:3cf0 with SMTP id 5b1f17b1804b1-451e3985fd1mr3277755e9.11.1748887049922;
        Mon, 02 Jun 2025 10:57:29 -0700 (PDT)
Received: from [192.168.1.3] (p5b057d53.dip0.t-ipconnect.de. [91.5.125.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe5b96fsm15479495f8f.8.2025.06.02.10.57.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 10:57:29 -0700 (PDT)
Message-ID: <0d778507-0c69-4c48-9c8f-e5f7da3393ac@googlemail.com>
Date: Mon, 2 Jun 2025 19:57:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 00/55] 6.12.32-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250602134238.271281478@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250602134238.271281478@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 02.06.2025 um 15:47 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.32 release.
> There are 55 patches in this series, all will be posted as a response
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

