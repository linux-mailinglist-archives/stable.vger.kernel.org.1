Return-Path: <stable+bounces-93548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A92999CE02B
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 14:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56E0F1F24086
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 13:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FB81CD21D;
	Fri, 15 Nov 2024 13:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="kzHEM7fm"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EA51CCEE8;
	Fri, 15 Nov 2024 13:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677808; cv=none; b=AHRlDtWWvhFamPdAvs3z9JED+3PjHJPEOOxgv473Hu9EMXI4VUeqWhyqZ63WXyrvFvyWFgA6oluxtB80kSU0a3LnIeeRdl9EM7ych51MLJ5CMoz5SJSP6gHibw5nlj05CShRdmLAcRXLNzmwQz1Rx25ozrCBbuKCIcn5U7uAA3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677808; c=relaxed/simple;
	bh=gd+fZnjtIrzZH8uRFuesecl8rg3R3bbNBsC0AcNkI2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qCISEN4lx3XQs1obnGeVWE9dPcnU6LM56vg0RbeMrAmnjyDlJbDnFLZrVSWVu8FRTYhFYPUQNkh72DObMlLBnl/Qov25QFGTznmYunZV6Tz/TgwBMxWFJMdRbBdM3LLoy3WwsV5CR6h+WDszgeDrM9fkmLpJh12BzhAmJqxpaNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=kzHEM7fm; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4315839a7c9so15674375e9.3;
        Fri, 15 Nov 2024 05:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1731677805; x=1732282605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QFMEoy+VpYmS896YAj0P2dmeI7XvRACI2gkwVcDp1l0=;
        b=kzHEM7fmloPhBc0IQt6/WezYsS9dIEmPFY/6WGhk1uq6MSlDzUPimMFh/xGmyXIlVi
         s5sN52oZsTYDmher0sVWXHkPeeqwoZn7k6UFqJ9HznKAQpmWJrah0SpdKn8Yd9p/oNQp
         g7gJ2V5WtP3apMl06QrR8bPragScVLWmDiX+ps+WjPb21+kLUeqpbRy2bEHRT7Ug/76c
         HSkf2aXqa8LF28P8f9BXdcB6eL619lQv2L12ilB13Sx0/YpHWULMG6KZ5BXc0yACfTkE
         uHEyj29aPBikhgq7FOtOK71kabaQbtDol9TtFIevACfjhE+FGynDbho1+S3eOBCGdd1b
         oCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731677805; x=1732282605;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QFMEoy+VpYmS896YAj0P2dmeI7XvRACI2gkwVcDp1l0=;
        b=u0ZWqJWL32sQ0OSTMKm0wkTWYkZatjaWThU6ncgeLKfXEehmZPLpVG5LfBkCf8G+rH
         MrnfSR4ePEnwQGA9GcU8wlNL+1V1CkKG5i//K7Z1FHE9Kzj10IMviqQrDvBAdrDF/Ntl
         P/wosclA8GVKKj1DbM8pRqXdA+AUD23bfJ1xe1w75c5gPGEnG7COcjCvdEQ5eUdVW0jj
         jHMdz5E7DK/x3vRoj+sRDVlFl03ccegzNRnHVRy9Cj3iTEbSOKzBRTbW9f2U1wK8ensE
         BpbtPOAVAMbXyMCpPURD+9XL0foRCyu9Oa2t9mzrfH+qIH/OMG8ZeYDR/XMl76i6x/2d
         0NTQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9CVgj30+/UtG/cV0s1Qdp6FNUT7KRIZ+frqUJ8hosLXIA30parmHzKkpbgWrJGgSoNgBoi/ZR@vger.kernel.org, AJvYcCXx7ovJbyNfQNr/I+N9WPOPJxc5wUYkanvm+GtFr7JtfLeXVbvZ+V1aTlPFxHbzdDXdG0syzD1pIQIKLE4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2vvTK4ZmM3vyZ56jjF1DhfTMRD2zAlvMsGBnOH5f4RHJKjxoM
	W3SmB27Q8kaArjnjRar5ADoD+fkr9Td81NllWaDLlQQC7fOQ600=
X-Google-Smtp-Source: AGHT+IFCGOXPuKhEx3Wk5YE8y8nyvKH/XqNmBteJiALxBgwKZI2U4Vxx8yVSP4YuFlEM3MRere3Prg==
X-Received: by 2002:a05:600c:4f06:b0:426:6455:f124 with SMTP id 5b1f17b1804b1-432df67783emr23283655e9.0.1731677804979;
        Fri, 15 Nov 2024 05:36:44 -0800 (PST)
Received: from [192.168.1.3] (p5b05792c.dip0.t-ipconnect.de. [91.5.121.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da27fc8esm58933775e9.21.2024.11.15.05.36.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 05:36:44 -0800 (PST)
Message-ID: <c4cda9aa-bead-4ca3-8878-8f6d05953ba4@googlemail.com>
Date: Fri, 15 Nov 2024 14:36:42 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 00/48] 6.6.62-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241115063722.962047137@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20241115063722.962047137@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 15.11.2024 um 07:37 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.62 release.
> There are 48 patches in this series, all will be posted as a response
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

