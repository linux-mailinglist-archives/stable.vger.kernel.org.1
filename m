Return-Path: <stable+bounces-121141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BEDA5414E
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 04:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED6823A9D06
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 03:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319C71993B7;
	Thu,  6 Mar 2025 03:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dFVcnFy5"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373101991CB;
	Thu,  6 Mar 2025 03:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741232603; cv=none; b=Y2Cc/Bo/lBgFIIs0MMpqxccCw/g9u2q/z1THiLEPe1zc2A/ey+LsenKtI/3FX2fYPLilmPSMY8nGQUES1VCBvPxFdpG0vsTo/oVdvqDfEMTPocqCe0uHs/iydQrYT6xrDppAg7spDgt7L70BXaXE/0Do9XGzcqKY10IlbAnNbvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741232603; c=relaxed/simple;
	bh=/shJ6VX/7A8nICUUOrOyA8xM0QkB+vTBPXISkMYVips=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cl8D6tCMY7v09Y7b8WXHfBgKUOqFOQkGx6Ot2emwzNokUwupFG5ufM9f+C5pCf4J1biv++FEK2mNyYZ0Cm1DPV4byDLHQ06ay9jZNdEw+xNh/wakjsTrewhX1bfdkNpD1e41OBcdaRYlXxjwoyExZCPKtqrL5d+xBspmTXtdj08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=dFVcnFy5; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39104c1cbbdso84322f8f.3;
        Wed, 05 Mar 2025 19:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1741232599; x=1741837399; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KvfaYVCJjOxUnzXkJLdVLBxKjcghXR6Hh+HVmJQ9ONE=;
        b=dFVcnFy5dQRqHvowmdrtJ3miYrjGBgD/0f2BqaTS9/J48MLzDAs9jWLtR9DyC4ejvQ
         M396k1PUeaTxmO6pg07HMRU5a8NFY3uW5DBPD29J2Nf7UtBQ7evqib8QYplf3Fut1cAR
         4w5QZHvsxhhnwkdYNBEInDN+PrLYX8/6MUsqUZxT3m+kbDZEffBh8Wwps4zPpBuGxy/J
         W3WJUksXVe93QtuSXUVvDC8LQr+H/lENW7yl9dYDuCM8soxUv4G34UF/AHwpweqgRom1
         KUB68r9uK2CRugByPhtvLQO1yt8If3czc58GCjqUHNyxtB4Yw/pU6sdwctR71jJQxhou
         jHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741232599; x=1741837399;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KvfaYVCJjOxUnzXkJLdVLBxKjcghXR6Hh+HVmJQ9ONE=;
        b=ROvfKFTXqX1F9xLpuIh2s5BkJ6sOg89h2W/QstcQLPhpCZQGiVrcYKwGIsaMfr/gk6
         y7LChG8YFpYbc8HJBrDD7mH/gtr3J3GMSAaLoDMT8aKwJHm06ExAI37rmQND7HwUTOwf
         OivSr4/i6WM8nQnJDtBnpcBHKQ5CAdfvuO5qhKCsvQDSp00L3SDDV6+Fpi/5uSTY372b
         TRsyZYX7J4U2UsxDW5b2JmL4bI+6r/c0ycmIspwZY5Y1537bDXHehkln0me8mDasJ11A
         461f6BTXRdiCcaH3ZbPmZFBjEA5UXa0/kxU0L9sKbiDhMu79N2xDoVOqe0/uA8DWS1Th
         XRHw==
X-Forwarded-Encrypted: i=1; AJvYcCVNt2c3eKoeZzgziXzctSuCamcu2+i8H2OoggP0N1SLqdDKqRqH3chqAi0v+0EyN4ciCnUP59lKYBLeHpM=@vger.kernel.org, AJvYcCWvjQMhda00oW6yH84EyEOvLWAG+TOdlfS18h1abYnyWrYY/3tTvYyGdn/iVY/mEWL+Mo63tQ/E@vger.kernel.org
X-Gm-Message-State: AOJu0YzKiVq/TMhb9Zyp/5pzijaWZdmi48maCIl5fEfqX2HtIbVs3huR
	jBwKSk8eU1libS48qIxrjTZci70UlhfmWzLhyrwFEkLfe5X3M14=
X-Gm-Gg: ASbGncs8QBzD2BkrUlXZxPZT534vWR36DLA37yuZ2SlyGwmE1Tos4Jr2AZBJuD3dVfw
	sc5ZP4zclCRN+qJQzg12crh6VVGY6s2cv8wLdUAQ1O/dJoB1QdmDORTwi+dys7HP9qo6rGMLxV9
	IHrtRCF51cuHuidwk9RlPXNoDI6vX9i2A8U6y9A8KmLNYUSHudNov+VD/4+WtYPGC2KsJdi9c+A
	+2NpYZwBuImtXFt6rTrdXHSA2/MfXOa23ZxcwplIhAeweNK71JgR7UGld3HBVvYD1lDBa1xLe/w
	iRyXZFsHcPh0QEP6o41rXBHL5tQb35ExMzvkPr2DkOuGxDiSs94mgAcJG4kLYbj9jlbsHqLdQ2f
	/NP1v0+WLkEJauOvYEBAp
X-Google-Smtp-Source: AGHT+IFZoJr4BpD0Wcdp0F2PVjihayKVse4R5DfOBq2DFLN6HWFFFJhBXhibGrJXCA8RwR8Cs1rHoA==
X-Received: by 2002:a5d:5f8f:0:b0:390:f88c:a684 with SMTP id ffacd0b85a97d-3911f7bb837mr4964247f8f.35.1741232599178;
        Wed, 05 Mar 2025 19:43:19 -0800 (PST)
Received: from [192.168.1.3] (p5b2b4217.dip0.t-ipconnect.de. [91.43.66.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfbaa94sm550605f8f.14.2025.03.05.19.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 19:43:18 -0800 (PST)
Message-ID: <997f3cf2-3718-47ea-ba11-a5255aa75ca5@googlemail.com>
Date: Thu, 6 Mar 2025 04:43:15 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.13 000/157] 6.13.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250305174505.268725418@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250305174505.268725418@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 05.03.2025 um 18:47 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.13.6 release.
> There are 157 patches in this series, all will be posted as a response
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

