Return-Path: <stable+bounces-119519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBE1A442A8
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 15:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25DA43ADFEE
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 14:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABE5126C18;
	Tue, 25 Feb 2025 14:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bKo/+XI2"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E188726770B;
	Tue, 25 Feb 2025 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493524; cv=none; b=VtEEcjaFS7233tT4dhsUqTVU2rtF0C+GI7FgC+BDQ/kYtSdzRQPVPGI0oQ8V0NrrTHGRgj3vMX++YzGfC4b3cxD8fXfsEz6v4xHifImJfHXPSutb3zjByqB3jbGNqvanfZSwr20rz7utRvvd6AJua+yjqMXk5VSvPiJYa24b5wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493524; c=relaxed/simple;
	bh=Q3RJil+VHeqSzKmw90XF0Ub/vSs2FGhiO8M1TWVwjXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MKZh4biwZ1DxlhTKoGROFGZXRZLQ7/yLAXohfvzItqvsz5ATabphmio4vRtG/Bi9+AdOI9PU72pKofe1XHTFk4Ma2Fafy/aPdLYk3JtaoQjWFZXfh977wzp7fuS7WTYallOKkNnR9EdmISczr8u8eqUZTfJeOjwdwmIMFn8fR8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=bKo/+XI2; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso57208065e9.1;
        Tue, 25 Feb 2025 06:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1740493521; x=1741098321; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AZf/o+N6Kz1RJg00ifbZNFSz2scXP1N3IPoo+w/Gz88=;
        b=bKo/+XI2aLEcD29B3+8d/h0kkJFq+X4Y3g5QOYNCRWXSnOLF5QGqzdqlHZ+Z+dSbWE
         LbWWJSYpl4wIjr24sux+/+/VE4j+c6FUAZsoIw/rQAtryaxAWaGgMC1Zup8XncTHQqeP
         vrpgZ2i3AFBgBQy6eGrnAV1CyfJHmZsRqAVwaH2/XphMaA8qAmr2Wtnu/9Oj3lxFY+pe
         ypyTqRV5gDHu8nGE0u4gaXDruxCRn6DgZT4B+3sPg0PURABm1ATagOyOyN6jWxjXYYlS
         epPHHlxRTrVYQX5oAkUJAyULqwYtX+hR1e5jLhh8pm2Cliyi8n1fkVdyMKC1t29ihW7J
         EzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740493521; x=1741098321;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AZf/o+N6Kz1RJg00ifbZNFSz2scXP1N3IPoo+w/Gz88=;
        b=FG7U4IK27ojM0+c6Q183yVv1S3bS0LV/KXOR16Sp/S3VqiqHUzzGshVNRvjvJBwSwt
         z8WrgospxNgypiTYzPhvd06AXznlUq9bLkcTfSCSu60FwQAFf1qCKPHNoJvev0qdIKTJ
         tSEvl+FVa03DsevPBsRPnBepRQYtN7Q5wKpY2MRr0tYh0IjygaC+f5uvSD7E2KwCk4Cj
         W/+nCmHzF4iOWoBVmjEWodskuMkA0ETpcv5R9j1njx2jT8prNhCMa0osledn8ZYf40dE
         zlWxkzOSK9KvHRE96HPKqcuZAij5CqG7yPF2+f3ZB8hupOcIVZiFefQNrTTu41LpsQoa
         3G3w==
X-Forwarded-Encrypted: i=1; AJvYcCUOv8mMYkbSPpi8MHxPDBFN20FATBC0lpSSYAoYcizhqef8Wm11K8fZ9CQzNBDFn+lx6Hg2naPF8BS6pl4=@vger.kernel.org, AJvYcCVeI0cJeD1HbydKCUOD1hi5NNisN50gn9i+Ij+qyh0mydPyNokw6OO12CsbmZZxGsghauGUya7J@vger.kernel.org
X-Gm-Message-State: AOJu0YxdeflfRmRGFQbv4EDUKZzFrYoL/yrRFgCfGq54XRECf1H3CzlJ
	Lan7H6dvxbsM/zhNyJNwI+oGPExSB5295p3FvNJ4f1YxORGmN4jQHxP0IxD0Cw==
X-Gm-Gg: ASbGnctrwTXDFuneYeOqbWVVupJq0NOYjDT/3jJHSZthuqPbD61MfwYtk+/BAZjSvmG
	zWpqMz7f1olyz8I8ibmy6XbfWSYSePxvc+onKpGFNYxP0vWdP6mCaFftdLrH79cNn0q/f9NEHV4
	HJprpfgHXH70wq5BYOU2asCvaBZea/7khre+pajsQZOO5dKM49N6LTA/8DSKn+yn8vu1ZIrWjww
	WrAruRKZtm44g+BZUISnK3NmJ87netXTGo65fUAa89PrQ5CG76M3wQ6g3dHTPov4g4FBsNdJ67t
	oc0jPQmVAMN+WPmF+lYIiix9b0bMrfZqF7id6on9Ozq7XgdsctNQTw7xpYUJYlK3CnXYvJoN5R5
	MGRdM
X-Google-Smtp-Source: AGHT+IGhdhiXQ4ECqTY9URWLiprLLnF779OXP/tKMzgBk9NQek5Qvqkfk5EpfkDRo1p5zSibaF4ZuQ==
X-Received: by 2002:a05:600c:4446:b0:439:9274:81cd with SMTP id 5b1f17b1804b1-43ab0f2566emr37255015e9.4.1740493520894;
        Tue, 25 Feb 2025 06:25:20 -0800 (PST)
Received: from [192.168.1.3] (p5b2aca7c.dip0.t-ipconnect.de. [91.42.202.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02e6cffsm142049515e9.19.2025.02.25.06.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 06:25:20 -0800 (PST)
Message-ID: <8301ce47-ce5b-498e-b2e3-412a0741c4a3@googlemail.com>
Date: Tue, 25 Feb 2025 15:25:19 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/153] 6.12.17-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250225064751.133174920@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250225064751.133174920@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 25.02.2025 um 07:49 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.17 release.
> There are 153 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Like -rc1, no problems with -rc2 here. Builds, boots and works on my 2-socket Ivy Bridge 
Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

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

