Return-Path: <stable+bounces-47598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FCC8D26FF
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 23:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D15092825BA
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 21:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E64817B4E6;
	Tue, 28 May 2024 21:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2OnjPhI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5299A17B439;
	Tue, 28 May 2024 21:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716931547; cv=none; b=czAQPYVt83eo/4/+0jORrDi4S2QUKxl7iKLDSCWY3NGpNPVmT1YRFH5fu4/SG4DywT1SbhpK5Gh2u6WCP2ZYMg+O6lsbnQq20Sgvm2NYaGK0j1eUBrzYhwyAAhpc6TunNb0QT/E8oP9LMKnjRcEuQ2yvzIT+MPpZ4h4RIrrxMmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716931547; c=relaxed/simple;
	bh=fZlxPWbgGevjd5cjd+01/dGc0pmuLz7vTQ5MZ5u224Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wtqt8qlix9gas3sRNkTBuLP9ZTBT5gCTFoDGKwl5ZFV3evZapRcUOGve/olAUYVmfOtRxx7iJIyvzVDUP8wOqIl0xailDLlneBvDctE4zVJcQw0doL6ohZPTOlfqMgfez7axij/FLdEm0HBHyoloK4skiXsak2KqWylGGwks9dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2OnjPhI; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f8e819cf60so1118196b3a.0;
        Tue, 28 May 2024 14:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716931544; x=1717536344; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q30G+Ol17wTE5vxf3RQS0d4phvzRCZNYkcikIChxgJ4=;
        b=R2OnjPhI/3PCNsImqTxCkIatf+zwlksHabb+3/XaeF8JAX4fbb6D/oTVl3PdpERIbv
         rhtf2WkS0WLehVA2Eng3IM625RJo0SQ9v8VyLk7fBUoNGKsMoXXhlB1Zf7CNVMPiDqrR
         8dTQAneOYDJcYukeEFYVRwR//05eK5L/L/suz9WMIn/7Jl3TUK4Gco78JofakiS9Dzcn
         l2dlEyvP7zNukCNADTuF5U25LxeqpPdShO4Pv9emFDCzFC5dgl1D+3mWXi/P+Nfj3z/p
         +kMJ4XGG1Dt79rH77VZWglVasb6f645Xjke4JKLg7ZunSF23xsEvBjMkJxGHwhDZiOBD
         S70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716931544; x=1717536344;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q30G+Ol17wTE5vxf3RQS0d4phvzRCZNYkcikIChxgJ4=;
        b=XLIYIcy8TJXW2JhiDuI7105CiM8Zlkl85WnQ4Df5pqMRmdgR4dGe+gPRUYK6UB/qKt
         8yVZHS+JdrBnhIMCpRUW+9x80ZraXsng/OADUjYlS+AZigMcq+547gh2pF0bstwKDbMV
         lZLw3caU3eGS9wLS8UTNtqxu5V9rNvrytEFCReoDtbXIjaNmIouVVApFjait7aLFFfna
         JnF9FM9hXcWPzXgsZ1PGp7VLuUUR7WIffasp6LI3LaRSmihK4Zgp/xngsYDeWv0fGjxX
         vCY5Z5p25E+T91U/0+mfvCIRyu6w/l4zNoHs0Jakg/8AHWpUqCf4+z5rH4y8C2C/yJwS
         52mw==
X-Forwarded-Encrypted: i=1; AJvYcCWYps+zh7PQQDBb6mAFAr31k2C5lAHfJqF9lkwJlLD0Rhs2CWRlRFYOnN4ZdMfgU3CB3vuRx60PvenbQvI77qwrHwrbHpd0YLx+wYSZGUY+CzFkKHMIc5P3sxI/75rB3cPEYBS4
X-Gm-Message-State: AOJu0YyfOM5e8fR6s4VczL68kEC5IJ3yP5ryn7/dBS4FN+XEM9VA1L4s
	bypb/TemcfxaI3k5Y8iBnI2fz4ztdFCMLijdj7psUupFl2FmstXQ
X-Google-Smtp-Source: AGHT+IFQQrrWfOhxR3usxN/wz3KXihWEswWZyob/o3XFZPagZv2IXPSZBbO6vbHoq4971OXdZ6Em9w==
X-Received: by 2002:a05:6a20:3955:b0:1b1:f6a9:6b0b with SMTP id adf61e73a8af0-1b212e2c3a4mr18856286637.51.1716931543494;
        Tue, 28 May 2024 14:25:43 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-6f8fcfe64d3sm6860782b3a.167.2024.05.28.14.25.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 14:25:42 -0700 (PDT)
Message-ID: <d0bd078f-a4f8-4928-9733-d7a021b91dbc@gmail.com>
Date: Tue, 28 May 2024 14:25:40 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.9 000/427] 6.9.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240527185601.713589927@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240527185601.713589927@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/27/24 11:50, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.3 release.
> There are 427 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 May 2024 18:53:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
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


