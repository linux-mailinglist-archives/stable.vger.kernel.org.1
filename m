Return-Path: <stable+bounces-171797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA99AB2C6AD
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 16:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D94B1BA7D4A
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 14:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406EB2222C7;
	Tue, 19 Aug 2025 14:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Kn33S7ms"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFBB22173D;
	Tue, 19 Aug 2025 14:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755612734; cv=none; b=WSE1UQcLuBShRIeJtMNk3GiprngQarPIehUatHjHEWSMHB9JcWZHaF5DrMauZgVP+UUu576U4QeEhESegijHNStc7Mt52cFakMKDPULEw/BWpnwJRILqfJNxrY4U0wM/qHtIykFTSDGp+f+IohJ2Q832Yl8c17iN4Oe8Z2Jtvlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755612734; c=relaxed/simple;
	bh=ge2meW4wDhR3pK7MFHommUvVtySG9dJaaFNMBxeqzrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oSo8sWnGDWIbuhS25NWAatMr56ZmgTfoUaJXsDEH0cVTsmAmu5b+eTdUlo7Z6hzzmcv7ijQDE3rDoVr7adRN6+94xzYxb6tiKU2k9gDgoEOzZmYYnyfDkBtRV3dhrNkdjHqy4Au4uhKRhjumz/mvAJ2i370y9IVuQtZEtJxJaWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Kn33S7ms; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b9ba300cb9so3358508f8f.1;
        Tue, 19 Aug 2025 07:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1755612731; x=1756217531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1HHpf1YrkxxnOj4AkD8QjsFlDWSc1jFIYwktamOS/So=;
        b=Kn33S7msj/8NPHkDUOaOS1Bm+mDWLyKrHE1LzsTwOlhBoKaQlhNZIW84e0QPVfvXx1
         X2fJ60qghoc6pm74udaiYUfsNprvM4gxjQLQNywXNcR/aozP7HZp5slemeemUoR/vsPr
         /0PSnnrUrMhg8YLeD3zzRa+Hh4BoLztNx37vf4Sz0uer1G53GwdUusVAzyq8Gy3LgWIB
         T3X0bX16XYnOG4q6V6IQX2rHjB/zojsnVzmssX8wZWw4B8gEE1W7c5kOY+LMABBm/wyQ
         sfi/joP/LqGXlUFVP0QDlstO1aTrB7torwNidBrAgs6js2A1K7PtGD3MByxg6xwPbojz
         ttAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755612731; x=1756217531;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1HHpf1YrkxxnOj4AkD8QjsFlDWSc1jFIYwktamOS/So=;
        b=nAB5dzuqaJhJ0uvl5FWG/+14w/c0U7LvQIJdAgmF4njVmikCxOQ4A3SpCN3W4gzh9o
         FGAYR7ZahE/7D91w/fAOVX/6hN61nrgnRV/GbXAAayQEB2o8W9oefpWdBmeCoLFNsbin
         VrpjQU6lkD203lKniT8Z6L8kx7vSXu7+S2ZsGxQey/Kvrxsy8s/80STxar6aGjMMh9OM
         FXY4VgC4nqbQJpGY6hio7RHEPr4/L8jMxinSglscoWfZut9596Gg1jTp+v1MfBr0/jAZ
         fSKFT4WV5il5iSW/QeVJJZh3KnlInQo1Xo0VHA7SWJotz6Nsy+HsLPSXRz3kbLT53py1
         f3ww==
X-Forwarded-Encrypted: i=1; AJvYcCX72Z5/PQs+qn7kgyvxdflmbhnMNknwPWRVoYv9DRhCDxr0AsgqEcjikh4+k49gSGZ4+qrGwWMJ@vger.kernel.org, AJvYcCXdbxgJTr408vpF7nAuxAtEKkQ5E87yqIVuw2+4AVIA97sfG4GWiQeQCyxp0gUlig/ziJnIJ9bUpJgs+8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyKaGCqoOG5onq3GUqXLavivEvRcgx88/BkkWt3pTRruO9R2D2
	XB8e9XbVJIsMPutawrrbHPyyj+lA/nUVnOPDSInx/fTyaTuq03TXR0A=
X-Gm-Gg: ASbGncuEu3Wu5urH59g1e//4oRpSdVYXe7XzZVEKwoekOIr16GAug3rdo0Nd+QLdtFt
	owtXfUuHZaYlHO/7T83WDj+2JB42eNTekO6EFOyGDnRYzwsamgyu3mZsgWx4+kfUPAT6KXW8gt9
	fy7pDdWe+Fw+/2gv4017d9HqiqcdANiVCc7H5SEUdljn1pf7dbs7/9tnM0MHeULshEj6sQtSo7a
	mkFJ4n5KyMT9opvk8OYHGYs7sx5LS1wfMzOaN8qj5KakYBq8RAMZGB16P4xMrUuFEO+3J85yIdI
	QmJ/g4Ghu4G8wLvpM6VTMJ5kx6SrlFAVudfIgfcLQomnYXTEPJhk8BIWG7lo6moSSFMoe8FObNa
	h3AeznLq07T18ppeGRd/+rKVV+8wGhhU4wS7LERB0ie7X1VR+sVvPr7l4Gts1IId6x/W6s+9Lvb
	pLxxldGXkSYFo=
X-Google-Smtp-Source: AGHT+IHVnzaJyzc7gseopxzW2ojb/NLDXOuX/N0VMrXnz0K0HgHowbTGDkJTK+MscfsYOvOaBEEy/g==
X-Received: by 2002:a05:6000:200d:b0:3b9:6:8970 with SMTP id ffacd0b85a97d-3c133798ce2mr2215959f8f.23.1755612730513;
        Tue, 19 Aug 2025 07:12:10 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac4f3.dip0.t-ipconnect.de. [91.42.196.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c077c5731dsm3864846f8f.59.2025.08.19.07.12.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 07:12:10 -0700 (PDT)
Message-ID: <e3d22025-03a5-446e-97e7-4a06db968e7f@googlemail.com>
Date: Tue, 19 Aug 2025 16:12:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.15 000/509] 6.15.11-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250819122834.836683687@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250819122834.836683687@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 19.08.2025 um 14:31 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.15.11 release.
> There are 509 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

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

