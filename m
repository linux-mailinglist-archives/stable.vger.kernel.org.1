Return-Path: <stable+bounces-61278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C7693B15F
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 15:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B416D1C231BE
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 13:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885B615884F;
	Wed, 24 Jul 2024 13:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="QjMhcG39"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F4815748D;
	Wed, 24 Jul 2024 13:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721826739; cv=none; b=HfpQjhuMfen8S3FyELT2s6gDLsYQrm/4Kn4ifdTQ9PIiYFfgZM7/DQtvU0cKvOTa7gRcxevekzFITc3QIr02PLCA1bIzWQtKGHSfM0Um1o1bAwE5H7dSWeKJQsShih38s1fIews19+cKta1zOReaXAXD60vkNGBTq0NoG1++h5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721826739; c=relaxed/simple;
	bh=okQJO08cg1z+VKw5TZoAGSyIpXrmh6t0Fy4RAysp5ZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o/hFGsko5QHAzUK0H9ElPwW5S/M508Plz2Z0pSee6k+SX1rQbQbhrdPJ+boYCnblAP4rv/2+dRhlHznTwbLNqfXvWOz2OiHCIrm8hafyf8osQMYAHcGA2UcEyKHar9oH3UZ5n/eScy9WDF70Gz2aSUCooHlBI648NVU3rQ2KH5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=QjMhcG39; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7a9cf7d3f3so214321766b.1;
        Wed, 24 Jul 2024 06:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1721826736; x=1722431536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k6SyZqu8Tx++VUI1E1JtOKm2pAJQRvY3MmRJGI28d08=;
        b=QjMhcG39k3M3Q7xzlge5f7mpqYpgzcJRAHe2eQBHWqu/o0f8eeBvOQOacC1+RGyr1F
         by+Z4HW3E25FKYa1QRaUuQhSYdsvtQQQY5ACf4qdZiSAYSsymhYi1NKqAhO5td9oGyfK
         yshJOIlGKNh1xxWx4C49DvBYu5AHWfiv6N8Yn7qSMePFA7OU9X6QrPkhG612TSf5sJpg
         JMIVc04MrVdWY2oBWSyDM5VCKKceH0McHO6hP9ojY97+RO8cjq48BPI6PkCpxRfXfRbS
         RhPL4OD2Us49XorksvPHxTfp5l3ex2aBs4V0XJ5G9Sx8t9nYQ5LCGkfzzg2DsKfb77/V
         UQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721826736; x=1722431536;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k6SyZqu8Tx++VUI1E1JtOKm2pAJQRvY3MmRJGI28d08=;
        b=lemKGwRC2vtTWaYiJGAVOlpClaZl1eGMzV1eFiDLBxZoGWuHJgpVZFN6vzr1tplxsL
         hlyZKp3Ylq1I3RMCBeYpXEZN0VVgaF7aTnFe3wtD65ajPcmxCNWosruIL/e09cf2H3Vt
         lwOcCwtE7MALGIKeEVu9M4Q6nW+Apje5ix3cl03ZLQ9m0vAFJ6LM4LkuC1q56vScV7lR
         Ij2uf12LPYNYdS+81luoNqecEr6iCTXX5xR7zZjJ89iSVuf0g1kwnUOuGYHeXIKmpEHb
         WxXpEQWBOiBa2oGw6IYen2sszkGdOZv/FZKzuO1xjgoY1yONYHjwhhODB69y4wiikFIy
         CZ8g==
X-Forwarded-Encrypted: i=1; AJvYcCVmb4f7C4b1gwj0vRJnagXdB2McJH5asYlrw7PRFhbYej6b/aNXwI/7SVCwVZeSD3s4cTZgWFkygm2yI806jsC+kBtSVPrL+xMan4yIhhY2Ji2PDkSjuW4Cp5W/2hdOuqJ3MiaQ
X-Gm-Message-State: AOJu0YwkVfQOPKKqUHYzml1wAc4n84iK0CjdYqlSZZhM7nU3t4JyxAcA
	44GcJ8q+KD3U8RyGWLTnd34UfWY0QZFFtjnGvTCXuEy7OWUPKKc=
X-Google-Smtp-Source: AGHT+IFPILakQyCipw5kBSFqvZG6rNfHySm90c3nN2evpAn2HZOh2tr/4kB/5o0WyxC/vSHivwDCpw==
X-Received: by 2002:a17:907:2da8:b0:a7a:8cb9:7491 with SMTP id a640c23a62f3a-a7ab10c3ed6mr167395366b.54.1721826731485;
        Wed, 24 Jul 2024 06:12:11 -0700 (PDT)
Received: from [192.168.1.3] (p5b057b1e.dip0.t-ipconnect.de. [91.5.123.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c922d6dsm646600966b.169.2024.07.24.06.12.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 06:12:10 -0700 (PDT)
Message-ID: <ae5b02e4-3c12-49b9-95a3-c1da06dab146@googlemail.com>
Date: Wed, 24 Jul 2024 15:12:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/129] 6.6.42-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240723180404.759900207@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240723180404.759900207@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 23.07.2024 um 20:22 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.42 release.
> There are 129 patches in this series, all will be posted as a response
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

