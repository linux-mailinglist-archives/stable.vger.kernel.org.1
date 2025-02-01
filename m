Return-Path: <stable+bounces-111880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BF6A248F5
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 13:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FA943A8B09
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 12:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0863C20318;
	Sat,  1 Feb 2025 12:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="SJeaTMC9"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8A115A863;
	Sat,  1 Feb 2025 12:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738412361; cv=none; b=TZBRDHdNXCZHXutpkKfWTqSjBd1pG/LiF3gwZCc/O1G5tOpDyD+/jnlehmKxes1i33UBnLgcpMpxKQPgY3ih1bEDUdbp6j2RRYPsAip/IJhXkpybzUGfVAwdB2TDJ8yGv87fD4SjL0gSdfaOzoAN4f8JJgbX9N309MXuMa6148w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738412361; c=relaxed/simple;
	bh=Wb8pMmRQqy3Suk62MAYpZ+z15qKy2esVQmc5jfi94oQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zml1LtFtoDD2/gXpLSZnBNch8ZNWYUftWjD3p7ih+xge2tHDjKnQVxLZLG+fSOFsB+l9tNOSvrtPzBpeiOtK9mq/9gtxftkL9sP1+UCxaZVHz48/66kOboueJj19cmTL6bp+rOC3+YfA/iOsoHaxPUZ6acFb+g6CxTiLDNB3Y3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=SJeaTMC9; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-436345cc17bso21548265e9.0;
        Sat, 01 Feb 2025 04:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1738412358; x=1739017158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GYuh5DtsmGWHaTrLME5ClByDosbMcK1IaSFMaCKacRY=;
        b=SJeaTMC9mKqCLP2xfIXPzBzTUCTuUlzVNzxCsrdiXLquHFzkkcH9gaLEc6uTQ/YxUW
         C1SIJFTG+eYSxWNfoKAOSF8p6SRzLOtya8r+UiNTk0mXosZA3PzC3VMmREhCUJA+5Z0S
         qUtTUhhKXO5mXX3W43GJIr9BC+d0fixCvlHMhhAM5q8LjW5dmIy0rFwiu/yDt+aWHmRL
         sUej7LXalDIWnzOZNvYzvBG/S7V0r1wZ4Utq9VQe3Nscw6faYm2mHkY1qzCcWpc6Wzaq
         TQQbbAB9JN1bqXnwOceUMUPtk3NNsQH5jb8Vus3kkBzoswhfzpSs4broQ7JpBqrSKjUw
         KX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738412358; x=1739017158;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GYuh5DtsmGWHaTrLME5ClByDosbMcK1IaSFMaCKacRY=;
        b=t6iT8Nl27ZNtXiy5vEXUGaPcLz0p7aXrYGyjsISnOqCY7y/Ax4VA5EMKORTVT5nGxL
         2+TPk46Qrd69Rq/G+uTswFMvpTfeXzCmEug0x7Eo++BhlVkcDW8bhxhYydJkF51QO5ZF
         T3RRdm3Z9dAgWBvVQVGEVm/bJx0xETwQ2ffgreWR0s75NbWwQLUIPyQRbWEAWSaxlB8C
         nTfQ7EO+X2f5pKfYAaVKsCCzn49K9P76hmsPAqwWjm+MOSOfL6GWHU+r2EtFzb4UJT3I
         rantKvdz7jApSLAHprcmkkqQgx3z274zM6XEHKiS4O/5NkB71q1x5qff0+pLaG3mVmB2
         5SGg==
X-Forwarded-Encrypted: i=1; AJvYcCW+36WolJehUG6b9N6fcEP6E3qi9DKHZvw0cRRpNoRIe9Uu5M82W+PTADT9G3pOFNuGenOAHBZAhCG/DBk=@vger.kernel.org, AJvYcCXQWtCu3n67bX4zzeW4F45SoCug90ygF1ag+J3IMWa4TfFK1Xk1eDcVwtUtY4ZQbY0aUPzo3aUK@vger.kernel.org
X-Gm-Message-State: AOJu0YwB0CZbjoxiIsC3PmL9D9per3OGIT2ESadoFi9PsJUSqhQEeal2
	+tjQpVOIq4GkmtTXnhU+AUIWgZlnN+BJ5uj24S8bHmBcoT/AR34=
X-Gm-Gg: ASbGncsx3UG7X/v3JKoJmt6LSLUPr6k7E95t2qp0S89AjpvmTZbDvyq8Fse7CiuMtel
	ozuiTLp7TfVczICaRSktKrSAW79Xq1We+54rTbU2IED9JllbcCtBh1oB7ziD/q55/Lc2kJSzWGb
	afeG5F7ontkLYaW09HEULLI/7hYqjiSPiz3rCKlo6oTSGJeoDHH0kGgHgdASFbD9icPmQzqALVh
	0Pv8xCeZauLQsHmlgM/cgVMIBsxQcTT3myIsuc0piROmc6jQZlmL13a7L5fe5PayjfQZ0RPpWGI
	6IorDjLvrq39lwm3CzB4BIjmkAiqsWTO84Jbcx1CHfR4x2dhBxOdodlh0872E9pT9wwW
X-Google-Smtp-Source: AGHT+IGIJyZqDzi2Uuhe2Zq000WfiFpxr+97ES3vVgwpkpirHdfzxp2zoWICnZtajDV0P4RGwWdDYg==
X-Received: by 2002:a05:6000:4008:b0:386:459e:655d with SMTP id ffacd0b85a97d-38c51952173mr11817346f8f.20.1738412358116;
        Sat, 01 Feb 2025 04:19:18 -0800 (PST)
Received: from [192.168.1.3] (p5b0573ac.dip0.t-ipconnect.de. [91.5.115.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c1016a1sm7198078f8f.21.2025.02.01.04.19.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2025 04:19:17 -0800 (PST)
Message-ID: <c843c84a-c158-4984-a8a6-fa7e20ec3307@googlemail.com>
Date: Sat, 1 Feb 2025 13:19:16 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 00/49] 6.1.128-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250130140133.825446496@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250130140133.825446496@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 30.01.2025 um 15:01 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.128 release.
> There are 49 patches in this series, all will be posted as a response
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

