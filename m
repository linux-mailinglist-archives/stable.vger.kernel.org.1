Return-Path: <stable+bounces-105160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 574BD9F6664
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 14:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96413169147
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 13:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7425B198822;
	Wed, 18 Dec 2024 13:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="AUGl1Mga"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958271A9B45;
	Wed, 18 Dec 2024 13:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734527020; cv=none; b=UgjxPHFIDsLYWOQ4oUocYkbkVpyrQhwslmAwqPSx3lTR/25yla31Ru4f7SBDhyjVTB/ixKFyBFt/3mqeFbxwmXsi3lR5AfwVORgBVfzBDrGHMGFtpm4OC9XwQ2BshVG+2WODDaT5geVYoB5183KWT1o8K4a8/4SwMn2GJlS0toc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734527020; c=relaxed/simple;
	bh=2Q11by8Eyqqk22xtjTbwVSKRj/gLhnmQuflq5gu16io=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JWOOpw0cUBQIQBKfYQ4h/uSKdJrxug+ECQNjQdaLt2ge0vvL1jvLU0hcOA7AzOD4WUAINuLPQVIC2q8cMBhCuxlfqy4+kCs9a2Oa2cyaJrYvLLppFrpohXnjQVb8HytWUjlUd/8xOY5WlAnLUd6kOA+JbjvmKl/Jpki6TMtPKjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=AUGl1Mga; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so69665815e9.0;
        Wed, 18 Dec 2024 05:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1734527017; x=1735131817; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CzfU29FRUWWPESoiLcy7OK/RM7Kv3I87gaQYkF8dmuU=;
        b=AUGl1Mga6pq+oxRE3amYmrQeNPV9qw89Ykf3139Dv8+2N2O7EGQ/GstXcHZUXGHbqm
         uuXgenMI9iKvJiq0SypYeoChI1nqsgRG4hCM7+AThab4O1abO0yumIUeC1xSSbaCkz4C
         Tp7oAo4YT2MDKTA0xC3Xmw95nBcVEhdb5RQCG96ztyEVnss300s7EyN3WNJpuhxPRkEs
         YmETWpW7vQHP9lTn9tU2Pu/nHh2kugievuonDycmsopWhBTUe3D3zDJleb592IfKu12r
         gOxAeuhCBtFbMQoz850nxluwbMR02+EYNEsA2RnPE3waCZhWKybUbVSgn1yTR7u/h4aJ
         OoJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734527017; x=1735131817;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CzfU29FRUWWPESoiLcy7OK/RM7Kv3I87gaQYkF8dmuU=;
        b=wNjelJlcO1AGmvjELiAF0gwDGK5KJ7EX7jBvz54ULifzm61xJ7yBpgQmIObbGzQvWV
         YrY6PohAVphqUIaWwbBeyv7BWQQu+CaczRWGrKiC30ZtE1APW7kBNvWtYgE4WM72QIO2
         SGHqjiZTsJYWeaDvHgsiV6uIZsMMNPH/miztx2UmRth84dyCSGeD1ZPQiItpIJ8capcn
         7vGNHvNF24Ia6tmkRmiXbulRsopTUhsxnwpsq5SnBc5Ua1fjUZYKM0ApK0lQDsWUajcl
         QZpCNQpBQdMeqnLnWMGsLxPp6zYWReqo81hoe+ND8AG3IfpPrYvPw6PmAg1FR3g9Auj8
         DodQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV7T+2WqMcBwW/B4H+eSa2N+xRlqFIoQ14qqIGbmFazTlY4rh2+XcDZ5HH2CIb20ZhqKg/qJhb@vger.kernel.org, AJvYcCWNlk5gwunts6BhLtIv3RLw/fIcJiX8/kQergtn+nYMwHzo1888qNNi9mCRRRzYpZgAkwW9TrorvQjULCE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw312mPTm01198a8IRH6lmpkopURJG0UkvQ2nlOwq0FMXW3MnBN
	FCVPG7hG/npvr+rnPDzEiBWJiHIj3hor/qAUUIu8CS4fJQo68Rv2F70skJQ=
X-Gm-Gg: ASbGncv3T4DCeU2Z9DoW6eEN1cyTSIlTX6c1FL4uxZv9U+6TLHnq2FN9uDUrBqj2OHu
	1+YLHKSbJnn+Y6yUkz6RddWM3XDHqRX9lvaHPRivyVgQ3sCXjoCvNLQxYSNUfjJqr6ySDf708z4
	ySIwrcnL00ti24vxHQVaNUJ2jWMHwu7fTk4nI6qkWgJXAuW41YvTtDrO2eKECRtvRVpDvIBNKwP
	Lxz5JAfB35d48lpluDNZZxcd6ANxjewR/JnU5wHpuMfn0K4e/4ndqKVUerijq6sJjCkbzb3+z9I
	LXblkUEbxzAMqEyEDuIZ89lL7iUYcbTqHg==
X-Google-Smtp-Source: AGHT+IEgh/fetkIoNzePBdFjZBzARmIDvBkSuvRxUEdO9TVyaoAPJt71/E1wg4AFqsLLuMkWiYu4fg==
X-Received: by 2002:a05:600c:4f4d:b0:434:f9c4:a850 with SMTP id 5b1f17b1804b1-4365535b592mr31375295e9.10.1734527016421;
        Wed, 18 Dec 2024 05:03:36 -0800 (PST)
Received: from [192.168.1.3] (p5b057eb9.dip0.t-ipconnect.de. [91.5.126.185])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656af6c25sm19852355e9.8.2024.12.18.05.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 05:03:35 -0800 (PST)
Message-ID: <c06fe553-2583-4ec9-8a10-155ee086ddb5@googlemail.com>
Date: Wed, 18 Dec 2024 14:03:33 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/172] 6.12.6-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241217170546.209657098@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20241217170546.209657098@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.12.2024 um 18:05 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.6 release.
> There are 172 patches in this series, all will be posted as a response
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

