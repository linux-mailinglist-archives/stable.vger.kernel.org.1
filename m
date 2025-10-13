Return-Path: <stable+bounces-185473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B776BD55DB
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 19:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B50414F2093
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 16:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1323629B8D3;
	Mon, 13 Oct 2025 16:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxsY4ykY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F6529ACF7
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 16:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760374667; cv=none; b=m365hehAIRHCIOXXtFKZJ4lNWPFuRrKlgbAoycPdSSGjn7hP4+jgNnRfE30G+OaU9ba4wzlGGPHp/iy1knFGUZxy4jF+YWfQZKcIA1uEg5JlC1V+ertx+kTARkwEn1gwWJtz73HnHJkOfxJTsCsOyHThZyAE7pn0lW1vGwLW6eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760374667; c=relaxed/simple;
	bh=uIZm0faNhTPOO/c5jIlL+XBC6TybQp8kD6+Bxh0rKbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MOPyJ5IpA5nkuDODSXoIs7xZrOBUvJ6IC1W8vU17jXttNiFSLvBoM1uDqzlm9/EOyyUUrTzJQQXaQy/9Ysx+ze321hkPS4glGzqG2dZrf0wjtiCqWJVXtB4fNOF3/p8CA3MvJ/OsvCaZt0O45UyHyVkup+e4fwiJQr+3sBa/tts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxsY4ykY; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77f605f22easo3805123b3a.2
        for <stable@vger.kernel.org>; Mon, 13 Oct 2025 09:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760374665; x=1760979465; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GIBQ7DXPPtVFtqnlKJKBgEnwsBKQuDpfZoq02adf1b8=;
        b=hxsY4ykY8MBlaVfSkEmXZpmSXXCnPFOdZ/1WcsiRq0SX+mvHVCUd8xYaKMrziZEdXa
         S9viHCYrpEFDs+/U2zzQv8j/4YM5iw0NtcZMaFwhIoewcr5Jb4ahMpcw98nCECkxEN4d
         tgL+eafs4SEiQcvCpjNi6jwkwJ1mz88bvukoSb8lHtoRsOv5TJTcHXqNBvdURfhWo9G9
         DsFRX/Q5zzz/iTPo+nXDAMCASICNPCXIs9nIwJI2G1YWEJXDF3phfLZkqnLRTRimELGf
         32UYhp8gePcF34YJdCNYdYQ/Ws3lj7e3+YL4Ula4xDcPar40fv72mMAIydfzxckT16pd
         fUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760374665; x=1760979465;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GIBQ7DXPPtVFtqnlKJKBgEnwsBKQuDpfZoq02adf1b8=;
        b=pch5ZCMVcJkxmQYnJi7c7c/q6xNYan1Dn7e8p52RM0P8nw1voCAv7V7vt6jqES7zNn
         4WgmI3aNZUH6tUXvQ3DGffX9MldwmObF7Dnx0quXF3vQzO30uwSoulHz43YXHGQo3TSq
         QuyU0+zQPP49GbyLxJL6G6TxhN+DNxXLpwOxW3Efp/oOsl2LK5jgW3vVvQBIo5ohb0lw
         m4EftzcC9ljH8jeg6VgiJf5lMkYd3ExIJc1t2kj9xWSNAEIUZbka2YMjBGks9Oztr39o
         lDly9xK/N9Ny9SYlR+qe/eV+0bbPkZCNnxT6zac+k1DBhRbI+uZZd8D9qdwmTw4q3yBJ
         rPVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5601EAxPkufWUPfV6mj0bGqxc0SYqXTWLV4XD2poXDeRGse3GybeXlNaJqszYr9tUAdLOYTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4EGO5grJVyGY9aU1Exbmp4GhWGwNZkWQD/rC+YyUNiDXpDR+R
	GUNcD81L0ffCdKtWJ71em9i3RR6qzXNi8hqHjy84RuFBiUDJZXCiu84qHv5h3Wxo
X-Gm-Gg: ASbGncsshDgYsDGvwfpOZZ8w9PKPAAR4xbZ2hkkNeWk1ztlVHMXlHeGcxT/amD7ItD+
	1hyTqVGmrVz5ZW6yb9TuVQbPi/n74bAArP8WxK6e5BLqBYA7OAl/FUNquDDkdHmR292y6p1OsF4
	KSFIu7wYcgE+JSyANvaKv7y4vm3/0C0n0IoZUxyUhzHtDTOYU6IZgFCnNTqkjiWxuLasmnGiKFM
	qgKbWOi1xsm2Yrp/7b+63X8AvdU5e/qQZgq5jAFcORGBjZj8Qjbc+RKr8E/5P6NitZgjhDuPH/s
	e0Zh8AUdQpXNpNWhFSh5JKT7LsLT4MW8rd8yphfcmWJLxQo+UymPq7VOa9G3jURVs8d8dYmWczr
	SsfOPYCMtPMfbSQNwZTRT8JdW+VpzEJw+VOYJT3IoqURlblUoDmeAR/u+Wgp5HBDKHyYYTBtfOh
	m8df2XK/mBTTxSiQ==
X-Google-Smtp-Source: AGHT+IF/F1baTGtfkyX/X4yywp8EinMnUc951in+FzSitmy5hmr0L9dH/16lif2v07+i6Ky7Ytd7RA==
X-Received: by 2002:a05:6a00:17a5:b0:781:1562:1f9e with SMTP id d2e1a72fcca58-793880f0678mr29157568b3a.32.1760374665325;
        Mon, 13 Oct 2025 09:57:45 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d993340sm11936331b3a.72.2025.10.13.09.57.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 09:57:44 -0700 (PDT)
Message-ID: <cafe0391-a33f-4bcc-b2dc-b1ac524c31ac@gmail.com>
Date: Mon, 13 Oct 2025 09:57:43 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/262] 6.12.53-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251013144326.116493600@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251013144326.116493600@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 07:42, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.53 release.
> There are 262 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Oct 2025 14:42:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.53-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

