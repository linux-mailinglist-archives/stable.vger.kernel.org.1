Return-Path: <stable+bounces-180566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC15CB86349
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 19:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA19F189D98C
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 17:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1549313521;
	Thu, 18 Sep 2025 17:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGiOso8b"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF683128B8
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 17:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758216413; cv=none; b=iCEGf7haAvBN8L8BChkTE7c66g5ymIEv1DcyhunALUr1iPSWJ7TDiMfXk0i3TATr/xQflfzarPRPjCjzxLnKPo1s1I2viTOda0gUDb8Fz3hiAArtJwIxFAerV+sp3J7bLi7f/fpxFkL3HSCxwQ9U2M6l3mhy2VlzWlYoXvdNFHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758216413; c=relaxed/simple;
	bh=rB8tPEOPRzhba5eLwtxrWUp/9qJMpIYZ22j7kwy6N+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s1+xsANe4v7bFvckB5QG6Y3M1YwdudGM6NcJzDielKnKjneohgcPUpxZn5eAyzQF3YPHXCFnsEsxG6iZ6OwynAzyXdyp2OjGkP0LMiANyRIUiOkco5AWz0rbOvreazAmNXHFvHQnNjAqE0hbHH3mJj0vvHrH0ub3Il5+uhrW7Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGiOso8b; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77d94c6562fso907935b3a.2
        for <stable@vger.kernel.org>; Thu, 18 Sep 2025 10:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758216411; x=1758821211; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lSL7OFemqt/NSr5lMBXtrsDUmlnbLhLq1OBPdZomIMA=;
        b=XGiOso8bZ+KYFaOWiVN/t6E52Y2ZhHWNbeSX3U/EDo6YJYbv8iQYnxwLRwIwNOK5P4
         9G+BAr7BLB7Btetd/r0mgmgX9gfbwkRtpzn1hJC4hkQ7Mt3qc3R3ws5UvyG+WYe85qmy
         lHY/5AazUgr+7/zvxYM6G5xOMgibB9GmMD1Uho60fjbrmQgE+KmYlwjCjrUnTJ5ym5e8
         HFxqEChvkCwboDXN8mxXPWwcmDjJYZ5he7gVaSP9B9EiqBryCJykT6/VhnHGWn/aP4K1
         VER82ek5mR81RJp8dMDtqGkYCa8XqkZ4NM0RbFF1PfBY3OMK03UkEuyVlDG6o+EBRMHP
         ACpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758216411; x=1758821211;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lSL7OFemqt/NSr5lMBXtrsDUmlnbLhLq1OBPdZomIMA=;
        b=eFblF+Pndlcq6A3aJq1j+SIGteq9QJystAwlAavt8dvC7A5g0KJajYZ8E27PvB9Ah6
         F6r1wLVPautK0ikkQHTTIQ2OrsHS4Jqq9pyCFV1XDAEiloFwvgNVwJj8xIlIJdduMGTN
         ZLIm+CcX3jqaQQ87kGNeZynsoG4Gcbc7Bg/HZ+KoUXuS0DBxRo6LWwKt6zxWUGt+xUWr
         QgdSp9N8+zkDCBTinvsUwvTyXIjWvclbxowUYJNNaKuKWwp9EXd07n9VyCMqKLjeRRup
         HYVfGaP9umWpwk4cpFwud0aWZOJw86tzOS3UmO53nt8jVU6tWJLv8YU4G2Yjediu/6ma
         Dfbg==
X-Forwarded-Encrypted: i=1; AJvYcCUqt6gyPMTY6I1vd4nVvjG9rFLShKk9/2P4hhBPvUTDxveomuOWL8rKxVqx2PLGOaZ+TOuQfkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8I84EmBKRCLPB4YsOobZcxGO0GQzz6yBYVaAwUj8rZSQkdtEn
	IPYv4zKFWs6kuW7ryDuENfYtGiUPEIVoeOyMWRJ5QDET5hf0AZKXtS3F
X-Gm-Gg: ASbGncvQiSLP4fEUccLZCJeD60DeQ42mUFfI4+SAo1eDR8hCsFO1eStcotinVUHbWAv
	ur77xapVFcmV1Wv5a9rgcNDqntRSnviPVuijK9Gz3FM0AksXKOefuQS7tUx64Ro8lTocYpG0wdM
	6+ZxhD5ljltUwWkPma1kRQf5R0JCSYv6qna+2nsWRyqh7qXs94mzp2jwuxnuzFAPprKJ6PxzOEj
	r7Iwj2nOQdaKxKl1eZh13C/4itIAyGi2rY3anqQVpFH11yemF7caiLUtaHgQ60TwUv5Hfj6QVpl
	h49OguI9/LmtqKLYfg5KhCiBd9bCpMB+ylIcuKK+RduFpP2sZCBsp8vcraiaTmVd/qyv5It5WWW
	tGzjtXcYovENRHwbjh22Ctvew9XOBqaCiTaRDSrQ6KAYGzFpRq3qcRwH3UmFsR/xF3eddr1+YOO
	Jtzz9aYgw=
X-Google-Smtp-Source: AGHT+IF3/L7P0F5rFfW+9cQVyy8quCWoy76tgJTxC2HHDreQRLnIJl3IZDhU8wQipfAMzXT01RaFYA==
X-Received: by 2002:a05:6a20:e291:b0:240:328c:1225 with SMTP id adf61e73a8af0-29257ff98camr555934637.12.1758216411343;
        Thu, 18 Sep 2025 10:26:51 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77d6d1883fesm2267894b3a.59.2025.09.18.10.26.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 10:26:50 -0700 (PDT)
Message-ID: <2270a44c-0480-4261-ace0-c2d6845d6556@gmail.com>
Date: Thu, 18 Sep 2025 10:26:48 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/78] 6.1.153-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250917123329.576087662@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250917123329.576087662@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/17/2025 5:34 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.153 release.
> There are 78 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 19 Sep 2025 12:32:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.153-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMST using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


