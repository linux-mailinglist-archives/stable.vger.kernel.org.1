Return-Path: <stable+bounces-116509-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A822A37235
	for <lists+stable@lfdr.de>; Sun, 16 Feb 2025 07:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4650416CF50
	for <lists+stable@lfdr.de>; Sun, 16 Feb 2025 06:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344EF13D897;
	Sun, 16 Feb 2025 06:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="VHDfq+fc"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E618367;
	Sun, 16 Feb 2025 06:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739685927; cv=none; b=X+ox/H7uusT7pi7AbR1NcqSw2dWweWYS/v6Jq8lMFXV0wDLVCJQk934yMxfMIR+85/KVXhEOU72G86ypGRGXWc6G+4kUMtBIozIaNt19lVjBGvelfqfbYPjssZPDVNNVx/VORekPmtaegQIK4fbMgdJ3Hw8gTywhA5Y+7WwJCDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739685927; c=relaxed/simple;
	bh=OhaL9slNmUsK/Mpa2QptKckfEEgfXXdFLpuPR71wGL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wf/cmm/EANcWcauwM+Gg9FypnvKp8BEWOEprcUfUBK4EP3W4c5IDZR0s8Fl9HYmE4VnCnmD5+YgMxrkpWXlAKkg4Lw6aYdU1WW0GDzbCFhSKXAFP0iLJ74ikoyp5m7uZ+OzgIHp/UzkOw4NHUzlgCR5YqluWFk25yudbeBMZURI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=VHDfq+fc; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43937cf2131so22031385e9.2;
        Sat, 15 Feb 2025 22:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1739685923; x=1740290723; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=seds6rEanzkvGS/3OLh60miuFhKKG+9f4hFXMzC6V9M=;
        b=VHDfq+fcznkCX4jALQuspB5yckOFtZtYokzx9oXKWMTAP+uq9PH4qHAuYsmTAUvQJg
         SwHlfrIYu0q4jY+/P9ntI49210U1pRoYC4p1VtBBlOUtavmXhUw3jx3zrhew1Z9lLeLN
         OMMbWF1CnEcz7jyV/WO7Vx0/uzgZpZb98J2Mu3RsEZQrEvrgvN/9p28wyoX3G0fFWc3w
         2d76P2ffZaJmy1hWAtxFmZzctjRgD5GZOq7g+HsIv9B6XoI/mWSKIgqUHIsnySw7z70W
         vCC23v6qGIM0FOd45Y6QOsQ8jJVqAxUvLCv4dPwE+z9MWlzEnJ4N3ZUHxGlfq9EWhlzf
         2aAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739685923; x=1740290723;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=seds6rEanzkvGS/3OLh60miuFhKKG+9f4hFXMzC6V9M=;
        b=lzA7+Dkbw25m/akpLglrY/JS3foFWJICBsNLaFu5iCES5uT8Kt5nd+8blbLIEZpdMB
         6JTg1Ls1ABk1dULX13Hbvwwno4eMkmEcejMAoSZVJgOOEAo6EgLlPhrES34L1c+iXzTk
         PoalGon6ObARFS3LmygvUkU/vK8QZWdxaYKHPcTdbI+zldbPLM7EG6Jfkrgu0c1n2oyt
         dWzpCnXWW3OjMPhBxssy/6H5et23CJF6feZf9FjmgrPu/rUUZRigDnafhpCoj147p2+B
         PXEJQPASrKfAbH+tNRv58/5ve1NCNAeGcL6yRk7ilvzOIShQ4vGTUcg6XPG5eVRIGLOh
         D9Rg==
X-Forwarded-Encrypted: i=1; AJvYcCXFLRgvfj2O765KfpgdbAZ51GqgCXdf7xnU4rus6aaSMDMr2+rNTDbDt3GcexOHNV38oXWMENKOAxFkoSQ=@vger.kernel.org, AJvYcCXtLc0YUkyPIl5apT0Fy0OGeKy/s94gsCmP75qyjt2Fgu+vbRvwWjNTJG4iYJ0GzFnTXYu0Kpug@vger.kernel.org
X-Gm-Message-State: AOJu0YzGN7aXasVG5OPLjx8Bev/nwgb4nWIme0/EmNbcZB1pD3E0oTc8
	cHPDMDI6qRwe2bi3nwaW7DKg1ee9laI82Axn8WGlHP+AWIJcPd8=
X-Gm-Gg: ASbGncstwUWNLrt2uAguWy4LsNy0nmpJp7BJZeiHQcROF8L2PpdqmeM8r13YjsT1MO0
	/CrLhtv9uebeL+gTCEsVmgqeX4ngQjsK22JKRoiqpHynEDRj0E7g+XtcIuMLkoA7sgeBs32G+09
	4Nivea9Pn04PMW7bBSUTivjywn3INIiWsKxMjNdiVKQmx+3XbGeP8KiT3rcouzS724eK1dFgYzj
	pFyYtD70A+kL2/YDl3hOOS147mXUsA5IcIFsHIpMjsy7C/TZSh3KiU41TSwTT6imDITGcjb6PsU
	8/9TlmSjv3lsjVPhNgejP/Heir+BHZOn4hXVfjzxRFuL1vJ3rTX5hdm6SanhmE1qf9Yh
X-Google-Smtp-Source: AGHT+IHCHA4n/7FH5Y+lRBDP7CtQ0JE291+E2RuWebGty35SOl7fQM5SuPMzQk81ZJZ2t1ABlSP04A==
X-Received: by 2002:a5d:5f50:0:b0:38f:28dc:db50 with SMTP id ffacd0b85a97d-38f33f11953mr5975112f8f.1.1739685923257;
        Sat, 15 Feb 2025 22:05:23 -0800 (PST)
Received: from [192.168.1.3] (p5b2b47ca.dip0.t-ipconnect.de. [91.43.71.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b4335sm9042195f8f.15.2025.02.15.22.05.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Feb 2025 22:05:21 -0800 (PST)
Message-ID: <259fc09b-3185-47b4-a10d-46feb2e09eb0@googlemail.com>
Date: Sun, 16 Feb 2025 07:05:19 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/418] 6.12.14-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250215075701.840225877@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250215075701.840225877@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 15.02.2025 um 08:58 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.14 release.
> There are 418 patches in this series, all will be posted as a response
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

