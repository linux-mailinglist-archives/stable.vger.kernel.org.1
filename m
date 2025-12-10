Return-Path: <stable+bounces-200722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD62CB2E5B
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 13:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 555693068029
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 12:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254F12C0286;
	Wed, 10 Dec 2025 12:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="igNNwqHt"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422F51F3BA2
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 12:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765370002; cv=none; b=ZrLXJnp1f6ORy0A76KO7j80vvzRYAgNdooX+LuEPh7nvTIAB0fE4otvRZrIMHCgJN/8Hi7pZ8fx3aCGKHLQSJOCumA/LVb57o1t9Bd7WeAhFVN88xsislpUpDGGp31QhV6F0BympWh4CYDJC3wt6numXftpXCWvtDCnGasi4sKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765370002; c=relaxed/simple;
	bh=JfxDjyamM9WaYpVnHOT3P1cNbeTdg3sojWRxERSzR+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AajiMMBASeRLwblCW36incqDjCX1JVruLGw5x5uREXL3TEYuM71BcKYcjGOCTm5VuOh3BEqPNJXLXgSyjGDQDmbIxMJVrSnMtEW3q/Ihuhr5IGHJIFsoaIUUqC4UtddSt8N3Qw+PfQcPM1fLt9JmU5qPSLPcPYUWXw858GKMH94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=igNNwqHt; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso52435705e9.1
        for <stable@vger.kernel.org>; Wed, 10 Dec 2025 04:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1765369999; x=1765974799; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oVUoIaFOxcBrziHPtBUq4vWBign2WgxiWVbaopM5Zo8=;
        b=igNNwqHt5AFmgzlJ6EGKw2OoG5B+25NNe8s8URoUGJBvXFCEEiv6jhAhFiPM33p7SH
         gsFvAqBHqeZCvwB4Vpe6pzx/J1HaDCx4cJkQ9h/hd5G0CvhM/qOWPWKf6vU0pubKMuv7
         lsrcGSBQVcawCqLro3fPTEIYIOMJewbkp/06QA+9F67OmGhmL6jbr3ouj96jb/L8P+sO
         8DeWJRNUVAfyyyJkObh2zUzzJKngI8O0q33z5xxaRPqRw70bGy6cYxNR4/wd/MOJu4Z5
         ERn+JMRmiPqtIxa1kCjtPhZA/9C7niQQEkDOZt3PgpEjofeU5ofwrPPUiN/Z8tkftI69
         em+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765369999; x=1765974799;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oVUoIaFOxcBrziHPtBUq4vWBign2WgxiWVbaopM5Zo8=;
        b=WRgGm5y7lbwRRKdTvAOnRgOQ5Vhjtl/EZmP04W7FmsVxRbSBXqasQI1zoe8EcBpx/4
         RhhxjsA7hRycWKlD52UWhUqNsZZZQq3AjQxy0ooDTu2Mbg/rMc0rzKcK76BsDRNE2+JN
         ok5kZ1134xkjbppZam6vyM+pw6PhQ/NCWGC70IWlpzszoeB48Ta17gscuiG0Q2+1Zj85
         cjQ2B9ZqpzMnV98agMwynx2X6HUxD9sh2Vz1B2dGwgwGj2LG6Lx7garrmMs8nSF1oTN3
         LkjBgA3D+l1u8WvMPZpxfuBP/+eWLUMzSb+Yx1iQOLXciCGL+GRKw9yjfPzX1U0BCxtR
         50Uw==
X-Forwarded-Encrypted: i=1; AJvYcCWR+ETD0fiMee46p1qnjH+NJmFLJZbeEa6dj+nMja3tkGX8FDGjp71zzY+MxCJX6Ze71c4Ndnw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx36gCglgFSNTzY15A/42gHipld5X+iGWLwkmiqV3XGIha+dox+
	gJAqlSIP4JkPRUi6Ila2P4xoSFWWRd6qTWP/O3fcD50ZUdC3NLFzEQg=
X-Gm-Gg: ASbGncv+VDrxpZHBwff3aehEQ92bgX44xhD08sxWhtnt5nmv+PNiPdxltJ8EPBy7nX5
	uA6bOq0HQtKhGu1+B8bLf58W7iYTCC+Ub77ALd/K2IHXawsGVFW6SvwA1L56EuCaGiX2hsZo3VJ
	5ijVcvNXPWu3xg+49FxiPIABl2S9Qzthw2I+I/pJP69VWDWw0cE6wvtE6ApPK+mmSVL99dWSEQl
	fxavKEB6ve4lgYGH7nxqdSzVDbMmS2JuLZW4X+8T47Mr4GsZ5VE2SYIIRG0HnYWh77isIoh65q4
	1B2YVAWxCskwqz17vE2OwFJXmhfGss/njWPLMGF4xqVYNeb93y3Y5xHWbHOK5UZeMbzZApjcobi
	p+ZMFczVE3/8PwGDnYlfeMW7K5JeERDSjopCBA8HUst7WIiBvNPMwekKdq6ajJLRK9cWmmC1g03
	ijc79R9Tmb+Xhw5f8FtTGRlFfoGhb8OREBBHN3gfOPixejT3sNqoySnvdJuWzcUIpceXKFSTwz
X-Google-Smtp-Source: AGHT+IHOPYRlGLqkl9OBrneNq5hSr/5akjNj3KqTKVjghTmRCEdijqyuELLJzzcB99oktVjOSqjggQ==
X-Received: by 2002:a05:600c:3b13:b0:477:8a2a:123e with SMTP id 5b1f17b1804b1-47a83853344mr24532115e9.33.1765369999254;
        Wed, 10 Dec 2025 04:33:19 -0800 (PST)
Received: from [192.168.1.3] (p5b2b444c.dip0.t-ipconnect.de. [91.43.68.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a7d930dffsm49772075e9.2.2025.12.10.04.33.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Dec 2025 04:33:18 -0800 (PST)
Message-ID: <1dd77802-cd1f-485a-9658-0515440ea2fe@googlemail.com>
Date: Wed, 10 Dec 2025 13:33:17 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 00/49] 6.12.62-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251210072948.125620687@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251210072948.125620687@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 10.12.2025 um 08:29 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.62 release.
> There are 49 patches in this series, all will be posted as a response
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

