Return-Path: <stable+bounces-144159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A73BAB53FC
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 13:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C8D01B44A4F
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 11:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A46C28C84A;
	Tue, 13 May 2025 11:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="MdVihagh"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842F228C5AF;
	Tue, 13 May 2025 11:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747136391; cv=none; b=oQg/r0AjT+lD54vYekPtVNE7MVcFS6pqBWmpQKo2b5zEZmBW+tCGR1UvW5hx9zMp93B72zf8gTChWiRkpD6sMZjObpPbf/ZKRp3xtuviIviNRSia79WfE2mhf9Bo9EdcQSpAa48yZkVujm8PrXL+W7Wn1Yf1A+ZdWOrMylsA1uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747136391; c=relaxed/simple;
	bh=kNT8fQ1sCfHXSprcogGJmSSqrboRbv5c9tc4C1sfofc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HoRBys3brEKoRmvG+xky+vgz2EeTiqtvDGY2ltP2MhBkFILOSj8XR/0NCgjA8bkCwdtcZtbZl0gJBDl8AP6DhRTytMfAwHQ4x9HcwBEDtkKo93hbM0T6UQw2PtZ/ncjk/DkeloPoGf9tbNADSG6/BCfMLsVjpHx/3+1Y2qf64ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=MdVihagh; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a064a3e143so3154990f8f.3;
        Tue, 13 May 2025 04:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1747136388; x=1747741188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kaFnDrgYgykdtxL/lmy+IZqOZa2/HPvZV0a+ILjXC1c=;
        b=MdVihaghe8tF9sg95W25rHem1FJLV9eQ+sGgloatAUUftjxZXBAZwf8FDwk40HjJdB
         AqPR3jL2r0R9vqjIWul6zc03K2+hq4sFAmv9/o/CIy+h3TK1Mdcu/Ki74TAgpO3+WJDf
         OpmVjMDWqRsAfeQHumd/OGBbQeR8oFeeHb+5iA26FCub16A2dSJWOu0jIk6j9rlK2WUr
         Rpi+ssY6HOPvPoufvlx9rTJV9n4+eRAC8/1n3W5c08cx+OjkOtZDkfdTaRdqDNX62h1K
         huModw0WpKBUW7rgXqTGVhhoYy6RtDzjclBhwfcFukSHIhGlV6cuNe0ycHD9qjB+0Df6
         EgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747136388; x=1747741188;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kaFnDrgYgykdtxL/lmy+IZqOZa2/HPvZV0a+ILjXC1c=;
        b=fqxgDV4fO4J0E86iuswZrFrK7iCeUPu2EAKBwKRqkYwVqvPx2wuk07n5gZ76RySQhB
         alE8izWBQXzTd84zCTaFflqxhzjlXtPK/SHRrZapaO3iV/rIXU07SmTj+7J5kuHIyoXy
         uyyWlAgHFxRj4Fpc7it4nPzlmf2OMC38dNE+yLOIDY6IJBHbUtQow2DoY9gy3KcYAyFz
         2M9jQTuvIbOSMlaC0kt1BXkkkm1B85J9TuE5OxvNaU9+Fw8Ukss9YtmhzI+nR24iLnAK
         RAitOSYDUEwZk122i8DiX5Zicqf/RUD27pFdcIXqkbANNsqWmzioipJQ1R86ffDfgrg7
         dDsw==
X-Forwarded-Encrypted: i=1; AJvYcCVcxysTc7AoTfBXT+MFV6UKuoGs0cmBsTvDI+0pnn2/bZv7LNVxNG2oBm2/G7gfuPgCEJIzEYzVKqi8fA4=@vger.kernel.org, AJvYcCWNADPxRL04qlCRNuCg2+/+PFvSYeR6n3+tkE2EJeVcfktUhPsxRhGn0X4SjKqnikbSe9T9P+Aw@vger.kernel.org
X-Gm-Message-State: AOJu0YzWliGHmy26vnxvnI/w9cFWvVuxbbzpfmktiPcLTwAHziF9anFm
	bomEmDfHQZr0cz/L2FSPEmbzxBM49Z133tugiXYk81F2010DW6E=
X-Gm-Gg: ASbGnctMV+YnWtRI8Iz/Q2nTyjWparFRS5adUtheyh1OcLQmygNhJiLckG6Lhb+X4Ik
	u4nAoP1p4ctDmq5SfD9wkEQNwwYNPp1UJNs8ojmsKARzIvq7T1Ty9BRHEv20g4Z833rMQiQVyvL
	lvR3wtVS0hNu/MzprS70UUBwDtJ2vER+w8SMZcs9Rlug2SBCv9V31n70Q1XgHdL179GJtmmpGpz
	zZgfgPSqrllbj/1Sxl1lJCPYtc4ps3+fkRiMHRiOQzRfSruGImIVlXxmYt1wCIayu3sQZ4yLgte
	M9M350KKVxG4iAdguRYHuUpXGypJhTJzbFmKa0I7CVQMTbEDQ26PS3Nw5pHqc9x0YxHkRZxL3h7
	SxjibbY5EGtP4cZO9ftxHkznzNJg=
X-Google-Smtp-Source: AGHT+IEplDFuN2dh3lCZVBALO+XGKlSlWYb5rOawb7A5PX/PlKHh+e4UJH03tKOvimPZ+ksur0fgpA==
X-Received: by 2002:a05:6000:402a:b0:3a1:f5c7:c50 with SMTP id ffacd0b85a97d-3a1f6488071mr12005690f8f.47.1747136387506;
        Tue, 13 May 2025 04:39:47 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac006.dip0.t-ipconnect.de. [91.42.192.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4cc2esm16248093f8f.90.2025.05.13.04.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 04:39:46 -0700 (PDT)
Message-ID: <3bc38f30-b340-433f-8732-954214e41fa2@googlemail.com>
Date: Tue, 13 May 2025 13:39:45 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 00/92] 6.1.139-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250512172023.126467649@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250512172023.126467649@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 12.05.2025 um 19:44 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.139 release.
> There are 92 patches in this series, all will be posted as a response
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

