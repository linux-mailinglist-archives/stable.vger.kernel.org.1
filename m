Return-Path: <stable+bounces-57945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30319926448
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 17:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE153289421
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 15:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2715417DA25;
	Wed,  3 Jul 2024 15:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dQPIwRs2"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECB717C21F;
	Wed,  3 Jul 2024 15:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019158; cv=none; b=adC/WdsG6WdjE/TLS+xB/d5D16H9AOx57oTY0D0WN2KTjAEg42I3B4dwP2h5GoZ1kU+x9B7o3ne8jS966fjN5bECgTtE6PdAI0SDZNb/gx4tgGE/5YqPek00rYYLaZCDAp3XgLzstZZ9zjiK0YO/mbj3VekQ6AAN7q4HZH0Dz/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019158; c=relaxed/simple;
	bh=B6sujYJQENgveO7tnjCvpEBvHp1f2ksX/jbI4qsbw3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=evDCUaIZLlgEubRbYL+OjQqt1LoSb+Fk1nMv+NN8a0Siz9pUKl0DIioamCJvb4UkrFlB7nNrIiXFYNLHDkgb3vFd3SA/FuR6+eHNSYfYaZMvvuy3kFLrU7tWKxNdolJQ7rXPyuiDc3NGIu6q6PsfgUyF0Fzvqaz6W+eQx5b2OJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=dQPIwRs2; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7541fad560so251192666b.0;
        Wed, 03 Jul 2024 08:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1720019156; x=1720623956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OUv04gNK+axs6Kwx3JUMSuV2/tPCNKiXFLMvPtB/z+s=;
        b=dQPIwRs2isjSKGHHL2SnKitMtQZVraeh8YoUOfKUmB5Gvbp0y4OrYrsCyrTfabyEKK
         6B/voeUT5ooNjn/23+iioVAYPLsVKQEzBU8+l3tKVyZyMDxHbKbaSET2RClBwfmKjQpy
         74N7xS5XKa+HEI3bSqpsHPN+wjxUBB7D46E4jlrtwbSBl4XQghkVSuYVwMvfw+PL2Ybd
         5wyU0iV6xRJu5JeNA8YFsxIiGKRFrSKJ9R8Qp4ggvz2aouH59OU9Xf3+DoGnhyJcs7Lp
         IrsEI9M9c///R5dKETftl0dGgeQpBsXRnaSbb6YUfTOBV1LOUWhtGkRNxatDdmovZthQ
         VgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720019156; x=1720623956;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OUv04gNK+axs6Kwx3JUMSuV2/tPCNKiXFLMvPtB/z+s=;
        b=FnRblQKXvrTqYBjqzX8wh7xIT6zped6nAaPnfXt59WN3aKSENoVRHdVp+Vw77egY2a
         W6YcPgiC0vN1mdt+zWrKrPH6A4lewQc5gC/2ibm+Ybxj32VJwf9uzKD4y9JhpPO/dcSR
         HT9IRdTOMgbC+4Q3XGVwiaUdytlLWT2HEUJI1VBRiHGZlo2zE1RyWLVsGQYpQOzP9zyU
         V5w42ous3NmASPjJ353rD+IacU8t0NWsD2A4s3X+VfVaekVQLSAAgI6EP+c+uhnwdvnr
         9VGZ0xK/yipsyTSVbm/07iBNaZjvwnidCY0QFPLy3QT8Qgkx7CyQcXHXKzNzlAoxpbjf
         Vj1w==
X-Forwarded-Encrypted: i=1; AJvYcCUsBBwC7c2BTEAPL4eWkm6L/lrU/cSbLjoyUoRTpN1F5ZsRwtIBBB9JGGAVMkWfGm9yFGfX1SsCd4QbwLfnIbBr62x07GxeIk1r2xWkh0HK10zBVl8Cogp93ySbpp9I2itz9ZD1
X-Gm-Message-State: AOJu0YyMm1v3QPNQbOIQJqgQILICPEQgl9j8uwkFl00eKK70iVEjcrja
	H4QW81iD3SuWU/PJywZQfGidpYH2S7hnGl/OiEIivKRk4Rm/Lk4=
X-Google-Smtp-Source: AGHT+IHpMD6EDrrI/Wl0zM/QLJIENWXXXmfuMXLQ3fiJHPvoOk3BXQjywm+JvONRLzyxl9UjFiF7hQ==
X-Received: by 2002:a17:906:f88f:b0:a6f:e19:6fb2 with SMTP id a640c23a62f3a-a751443ba6fmr814949866b.29.1720019155086;
        Wed, 03 Jul 2024 08:05:55 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4597.dip0.t-ipconnect.de. [91.43.69.151])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf63dfbsm513147866b.84.2024.07.03.08.05.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 08:05:54 -0700 (PDT)
Message-ID: <e6c07abb-d202-4851-9e33-265e3ab51dc6@googlemail.com>
Date: Wed, 3 Jul 2024 17:05:52 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/163] 6.6.37-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240702170233.048122282@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240702170233.048122282@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 02.07.2024 um 19:01 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.37 release.
> There are 163 patches in this series, all will be posted as a response
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

