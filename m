Return-Path: <stable+bounces-69245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E90F953B09
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 21:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5496A1F262EC
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 19:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F467E107;
	Thu, 15 Aug 2024 19:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="jQHE9lx2"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720057580A;
	Thu, 15 Aug 2024 19:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723751179; cv=none; b=ROUpufMqMu/2y57T4ha3Uwj8CwJu0zp0J/qvl6zIjsGhmi1Nz9M/r0XEf9amELn/GfOV3mgHhdFoLrBJ8j9m0A62/J/04lVtjUfbQ1B7WYS+bwAMrOTSEcwoFqej3ZcvCEfPcRjl767er1n4jfL4qew7MP0s9wGsG+UBbo1Vv+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723751179; c=relaxed/simple;
	bh=YPNI8wuJj99Ae93OIxrv9+QMXIyi1RAagu1JFTzcgAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=puPoHpscNLWUpwp2UvYojmOL9HTQ0xuGfjq3Gl9OvWS0gSum3tP1gzp8UvOmKzo4ZPvA5TA+RcWIc0DxYf60wmSiaF6wU2dA8PHFxQQPwfCpVVpZ0gvuOEbLepLFuGFwlvbyPgfuP44c3XU414JUM+hQhPAXSaEHy7X6SjsT7B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=jQHE9lx2; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7a9cf7d3f3so172395066b.1;
        Thu, 15 Aug 2024 12:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1723751176; x=1724355976; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sy8P9QrulK+P7ooXh2LZEV47KGLvNUnsvqBeKPH/wzY=;
        b=jQHE9lx2EBp8LWcbhe4H/WD/EbLNQOxSZD2keRw9BW8gStOCUAj4ixTYOATrEjtzcJ
         Ix7sB37lgZF8sp6pz8FEydQJBt9ZQmmscjidpnfMH68Yn4IoHtRQGyl0dcdDCh31j6op
         VrAhor9cU3LPRSNPTiReakcjmnBRsD/Z2bCSxeyc+/CjgdOWmlbJ6qq17UYZ4b1JN7iO
         +/h8EJJn/XlKBlQ36Tls4tdcu7HFKnCXN2/7jKOJJsDxLy2xOZrG7tQzkfLZoCW9k73L
         77xKyNg/BbyGOmmR2kqqFQkYlbIEGN3XmppBLE3HqhDbPq6GSSOkxMcfuMCuIGCzAnPJ
         na3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723751176; x=1724355976;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sy8P9QrulK+P7ooXh2LZEV47KGLvNUnsvqBeKPH/wzY=;
        b=FsxfEv0cwmGw1KwlZnnaxnWy67o3+16Rng4oGlwar2MuMUdQKgHa0rP3NG0Ew9XjSA
         wgHuag34nhY+Ln+/VR3hvSvxLV0kEY5IvebPw6aAdjnmxmusQWd0hk9fAi3nYprpxVQt
         hS0fiQN5RTjvnzMIWTDy2lyZI/AvhrJgTYib8D3/HV+xTEFFWXZoT5iqO+sRG/TVpofR
         4OFhYdFo203dJ8a5niTxrDJYK8gk0EsYGu/WJ1pExh6ZnMSejg85K5/6iLhi3q/FAK6x
         8DDQxvpPMhnq70ug+HKoyao3Y3X2txEKy8EjLRpBdY1nnjFU/hzNBtR0x2lnLUqixOSC
         s4aw==
X-Forwarded-Encrypted: i=1; AJvYcCVkBxfQ4Jqqi5qHs8GYYv5wWkmnD9vYUQUfCKGDD1CurMsLCXItV2QKa5GPayzeqOaRiQ8/ysoQxRR8vdJFbz4ldq9qO7xis2lCbv3Ion/kCHeUdji8RzJJT1uE2dC8xen633Op
X-Gm-Message-State: AOJu0Yxx3TbKkW8tAcugG/rnM6T23N1j6koEEim04g/sziQAPRA1ff+0
	YvbNhd+7jPUI2QlguzWXodej8Lavl/+S976ojrvVmOc5N3puIfc=
X-Google-Smtp-Source: AGHT+IGh1+VMHRtt1C1g7Yp/ESqrgWggqhxY5saOKf4US1qEQm/fBr4sbt64hEYHCcEGCxgAYPPlvw==
X-Received: by 2002:a17:907:e21d:b0:a7a:a06b:eecd with SMTP id a640c23a62f3a-a83928a9edbmr46609066b.5.1723751175412;
        Thu, 15 Aug 2024 12:46:15 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b41e6.dip0.t-ipconnect.de. [91.43.65.230])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838d0232sm145152466b.83.2024.08.15.12.46.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 12:46:14 -0700 (PDT)
Message-ID: <94abbf9d-b859-423f-aa69-cb422c2e25cc@googlemail.com>
Date: Thu, 15 Aug 2024 21:46:13 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 00/67] 6.6.47-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240815131838.311442229@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240815131838.311442229@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 15.08.2024 um 15:25 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.47 release.
> There are 67 patches in this series, all will be posted as a response
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

