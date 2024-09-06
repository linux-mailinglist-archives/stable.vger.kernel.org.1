Return-Path: <stable+bounces-73775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEA496F363
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 13:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D7FC2881E0
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 11:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A6E1CB154;
	Fri,  6 Sep 2024 11:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="PEDV3qIW"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4521C1CB525;
	Fri,  6 Sep 2024 11:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725623042; cv=none; b=Ivz+s0pwVTOQj5VTrVCjywfrczN7/adF257kuIHH+XPlBKZdJeHdMWUpv89cpui5vQZ+X8PV+1q48mjP1bdaHvBOr3X2wDgs//cOJUMY3oLNPrDu3i5dKEtOxY+ACsL1tPzTm+w8raOX2/5qtX0k+afcTSF5FZrNyn+e2SO01/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725623042; c=relaxed/simple;
	bh=l8aLiUfVudm/vd/SUVGzTAzBmw1eCXX8xhWSjKpyNoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XnTPXru2Nr2t03p6HXTg0G8qDnQNXHehCyS3vgxbt7aTjF7RO59DGFQaRIlgKy9czxz3uwa+hbji3d4AwnB0zhZTENcl0e6a31fVIqYXfIz7LpQ0ERIfttWyV2FNiVtqwaknzlasBznxdIes3e/Pl0K4+fpf+Fh5gL7VQ3N6nQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=PEDV3qIW; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a86883231b4so278962266b.3;
        Fri, 06 Sep 2024 04:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1725623039; x=1726227839; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oZFH4n8uj7LbYUyljomrXbAE8uZuiKQjDhK2lQm2YzI=;
        b=PEDV3qIWxI96C7JiOmKglZb96jMQSMe3uwTIdUYA5crXghX3o80kMvre2H99n2CLEE
         k13An/FYy9+KXu+XQcI3ClF3ouCYFy/aBOcu60Z2o0229q3Am9FSbto3By59ihEyFEcb
         7BKoQhEqp44PLKXIiRQyOCPNjrq8NL+P0fr1MBc7h6j/OYbbr0zRhixNwCLRLbyLBgbS
         u3JeBSryQFIycTb4AHg9jRShk5LXaj6TjPbb0CVa7DTOzCUxaVAXMS1nlJrAxmi8Z2B+
         rZUc29ARJuXsXtLuBQrblr7uzKR3eEAILP++qNOAB0wdzrM2/TCh6bA2a4wy68wE4+pA
         byRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725623039; x=1726227839;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oZFH4n8uj7LbYUyljomrXbAE8uZuiKQjDhK2lQm2YzI=;
        b=pEXsEAYfdy5yqBnLLjb/FzWObwZYV6bpY32l+3q5mcIkB+/YML4pwOtiVEJfYplOjY
         VSYQZhdOR0+WIvQycqy6TDZ3mh4+EbZsOP6Hhl6MFZxnjRx9XmKccLq+oLoV/y/VJhZK
         A8bgFX8g1DNFlrYzWBzJDlUvlcW9vtC64ttq5nYneMf/XCSYMbKISRuL6D40DwOapSR0
         munDDGQ2Vx349yC6biLdGG8HWmRmTgEO1fiGG3IxXVJjN74ClKF6U1M3X9Mhh/ttoXl3
         3GHmx/l9F4wX2qpB5nUWPfjV1x7I+BXCV8o8h89fNWFlPx/RBq6WlwTzHnCuzloPf6G/
         qGgA==
X-Forwarded-Encrypted: i=1; AJvYcCUODFAFboY0W2NJiNbKgiWdosmiGeaQzQEVfv8qylivGGVOjRZvDgy7Nc5e8PANVv2O7IeW6o5/igh4rK0=@vger.kernel.org, AJvYcCXW5CdZey4SBcSp2AnYCTpy+UIJJXo2RamYmpZJXXdtNQhHZ86oLwxelj5GMGml58kzavr4j69+@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb0YCWPka+OqZFNensF5ohbYRR4+cVN6jJFfNFBCVzIRHnnQLK
	yYD8tRqrT0gmTy3vdfUQWQozwV0/c3pVfWE3VmEo2GQObm3zp7k=
X-Google-Smtp-Source: AGHT+IFCw8zYSN000juj26FedmQuKiZajxfLCf0UF8fTvienYRXLIOxkWkuV3DS6cW+Fy2eAX6MWKg==
X-Received: by 2002:a17:907:501d:b0:a8a:8d81:97ac with SMTP id a640c23a62f3a-a8a8d81a95fmr101434566b.4.1725623039218;
        Fri, 06 Sep 2024 04:43:59 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b40f2.dip0.t-ipconnect.de. [91.43.64.242])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a7af8e46dsm174836966b.16.2024.09.06.04.43.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 04:43:58 -0700 (PDT)
Message-ID: <6cdc4ef9-8eee-4691-89e7-4d9fc5d27564@googlemail.com>
Date: Fri, 6 Sep 2024 13:43:56 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/101] 6.1.109-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240905093716.075835938@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240905093716.075835938@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 05.09.2024 um 11:40 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.109 release.
> There are 101 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


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

