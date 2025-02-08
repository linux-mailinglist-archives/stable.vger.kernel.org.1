Return-Path: <stable+bounces-114359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F86A2D2F7
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 03:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4436916BD24
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 02:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DF6149C69;
	Sat,  8 Feb 2025 02:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="jC4puXz4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE5C45979;
	Sat,  8 Feb 2025 02:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738980832; cv=none; b=bx+VeRs8GZGNMaTbqLXxj/SzZM6vnRwNUqQX6qXJCaJH7UsXJ8qbKlYxflnsArKUzq/kYAZg8b0mIe+3oYxuBxkW55te+n8j92zeL7oCXuKSyX0nx2FC/lXOTpFFZl/VpQhl2FvReVDZlvkznWG8AlK8kNGDc6kXJrZ5c32iwBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738980832; c=relaxed/simple;
	bh=yeOAfOTcWI69kvo4UfVbd63U27LvdUDiuNEX53ysFZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qn3yYomnr33dj1ouBlG707Hm6A8OQyj5Uk0TGGtoiTk9yXXMkAEssZwadsH6NC//7CsjnjnEfZyC9jafuHDleXTcg19HNqN72GITJ1j+n8hynyHqJND83blbekJQST+nBSkbBwIdH8q5bbHZxNXtzTp6X0TGgrhnDdhVBmG9CwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=jC4puXz4; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38dae9a0566so1316940f8f.3;
        Fri, 07 Feb 2025 18:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1738980828; x=1739585628; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KFjUJ7x/jFIJeuzuwLBbU1zsiQZ5FR4tRjGt0l22YrA=;
        b=jC4puXz4j9A/rVqtixz/bIQaq9EcxvB5sDtDCmW7rOJLwqVVgaNokbHJDbcuAxAtvS
         lrYrO/CLo5X0NLR9Nz3o/Ry0dWT/iJEdGQnw7F0col4JomjId3XkIbbXumPdOPEBBNOp
         gPzRiMK91VvREvqYMBLssTSffdOobgAy0wllLdcQSw6ES8UOZWizAtjBHUIWDlOVR82L
         DdGGvASZ78ECepcVQpF9bUD2+AzMvHSQxGIdGhEwLeFkt/KHWcrzjs3OgQwvge7Hj6We
         w/mq34S8AKUEW4HOrBAANuGXIfZRTq5KXQN2Edh2f3rr+hwZWQpAzcYe+qHOhPgKyDs/
         yi+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738980828; x=1739585628;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KFjUJ7x/jFIJeuzuwLBbU1zsiQZ5FR4tRjGt0l22YrA=;
        b=eMr580Dfkl3CMGj9JF+jCQ3dmBS4jvUxPUWcHOW2XY4NN0VOZUJ8cyKiKLWf6TfZzn
         HGJ+awiv939p2cSCPTeaVLu0l31QwnvrA/UW8bRBf87g/sIuws4iAZidST63crtenyhF
         Xrnc6nChEEewEGoqQnSRR06OOR2BE6ErF95GMjN0bjyEsL+KpEFGHS60LgiPZWscu4Ji
         n1gkz1PkoCRcCHiqFQ+LmUbuVuodjvXAw1qZEJn6LjWFAHUqKp/pfJY9Kpk1BsLFbWAA
         hnWElvwnY71JttK3dSRVbLPwXWXLmhF+ZdqGpz7fc4m/bw/jKlCbiWzLsU97xOXqoZZt
         LCrw==
X-Forwarded-Encrypted: i=1; AJvYcCV2z4Y1j3BiYGkL3ortqDKlyXwRkelDbihTG7G16QmvzSNr0v8VbY3smkUVh1mp6qb7Up7mxhS9@vger.kernel.org, AJvYcCWtVpEMMUp9tS+PCxgeKrTZIPJ8x60EBMnAXo5yWUqXW8Nqpqq0W2Wq3A7aSMUYKsLA6YxhM+pu20HxNRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDHFyoKjEN+U+FikkezpkWwfl10iwbd7PEjZxqu+7ZmANRq34c
	YpKRwJkXPn74Kg5LkHIx0xJlkvoHSR+P4nvo1t/pg9da+KTJUAM=
X-Gm-Gg: ASbGncvrsvbDorg78yzPO5R4VaHgSfED/MNeLSJXHlhkGCk6UXi+J0Yy04n3RjoT55P
	sz9A7pNl8nmrvhaTEq4b2oKFhnMV8AgodAztRXDhwNG3yyRVPPsIc77Ieck5Y2rg3lPgiXNnbyv
	eDA/ZqyYCKgRtlk3aBQoxs2o/07ZQIVrRCh17RTTsrZrRfrVOvkUAj/xkPxllLvc9gMH679UJ/x
	m/UAXqdVSs8WlG1j4EvlGrTknunfqbTT9goUsV51coslpHg2OopMBmPCoPf/ktS0eXqvcXzPqb/
	dIGYMuhjiBkEUH1n69d854hDaEFKHjZ4ggy8ToXeaQNcE6Kucz9XFiYgB7Kkil6uQo6U
X-Google-Smtp-Source: AGHT+IH23NV5ohzZLD3pCYDgj/pjnD4892PA/FRvcWDFkpPnQCQz/wLEIxVNaftguMLXLf/FT4bLWA==
X-Received: by 2002:a5d:64cb:0:b0:38a:8d4c:aad3 with SMTP id ffacd0b85a97d-38dc913180cmr3799850f8f.18.1738980828314;
        Fri, 07 Feb 2025 18:13:48 -0800 (PST)
Received: from [192.168.1.3] (p5b0574a7.dip0.t-ipconnect.de. [91.5.116.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dcdb54668sm2570722f8f.35.2025.02.07.18.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 18:13:46 -0800 (PST)
Message-ID: <9625dd20-d66d-493a-8e1f-5104c9664ec4@googlemail.com>
Date: Sat, 8 Feb 2025 03:13:44 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/389] 6.6.76-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250206155234.095034647@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250206155234.095034647@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 06.02.2025 um 17:06 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.76 release.
> There are 389 patches in this series, all will be posted as a response
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

