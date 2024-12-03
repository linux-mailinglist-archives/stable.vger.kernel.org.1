Return-Path: <stable+bounces-98184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1199E2FA6
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 00:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88310B28989
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 22:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF3F1E1C34;
	Tue,  3 Dec 2024 22:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEP3wb9n"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0435E1F76A1;
	Tue,  3 Dec 2024 22:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733265415; cv=none; b=cgk25ws5m6Gu6JNZ0okuIhJoy+N+y10Qe5ciHJ5LsPld/zZ0lJqIBer0+jjrDQ5cUyJ1axFO8TeET4nFZRjDTqXcK+UKGXEofh0/Cy6jtqUHxU6wjrV2FgAF1hSHJZvJ36LXoiOeSxxCOwPitJbBZnxcSBQxKx+xA4NfyZrTxf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733265415; c=relaxed/simple;
	bh=qOI/ig1QDv+Wtqaxl61xm8chjhmXcLx8lqKwGKoDZDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ad3uwYmV1dprUk+zENC8jX0BiGTWEVI/67RcMm/S6MP/7mQwonfhgkT3iLs5g1WkBd/68/SvLg8WlqWGB2k6Qgp8oG3AMAQIsSdpFUCnmbE2J/9y9pWayBa5c4n7UARVdNCeVKtIj9i6CyrhRCIFqOApIMufreKNrwmKbnIvF3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEP3wb9n; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-215513ea198so2216805ad.1;
        Tue, 03 Dec 2024 14:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733265413; x=1733870213; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=c0MGb16YH2aWkzNnPP+Ws/sefGovgAngp5l3l7ZM9e8=;
        b=ZEP3wb9nYh7c4a6oCc2i6zRgCFWLAe66add7hRsliF++kIWzO564eOVIwT8jlKdJHz
         c01Ecd+c5HRL82lhJ5ssJEG5E1i14bu4vX7O8hC6vMM1VRxRUycRP2o7Fx4kwCQlHtfe
         10tUHiOEbyrvVZ+jUEng5UoMNqedRiNR2kpRmnNwsnd5kpbIUegIvJBN5QrtzMshYpd1
         K2Cse6OBV4XurUn/pXiFiILsz4PZIRjYzc8E5pHiam6VNSSNzRzdTFy+FQwWOJRTPXdQ
         wW/c2v820U2dOwYWCNYu7kBLrNiW31wm1ECEdlLNA62+UH+sHfQ5cOg5cbBsNOpnCn+i
         3o0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733265413; x=1733870213;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0MGb16YH2aWkzNnPP+Ws/sefGovgAngp5l3l7ZM9e8=;
        b=Cj3+WTtPVqezIqAkiUxqmlmVKGQiIs7gdEWthISh9Ne4jOrr3LAwhljBGtBcpkge2A
         AxX3x5A+MrsN2x7G9nG0j4asnnA8tR4cxL0q6yj6kOslaKCgbnWrF/Qits+t2csYK1Li
         cUF9y4B/Y97YPb3dNvLwctIimrHavtWMhQNESAdVamHTNOrq5EXg5Z4PCDC9z/fdhmFL
         65Qn+U5XTLLXCDNbr3S5Ko9I/vaBmmsn3SaipL4ZGrZuWHxLUFTBqPtpccV+uNUhC7zS
         61Pux1WUHm+7fyaa+yqQmm0h2N1eIonB8qMzOjb7FQ12qcuSgKR/jORh98ZnQ5yHWN2t
         nP2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVnSgp3GVT01yZTsn9Y/+grWX7LG8j8ImXXE4xyDoSwny3bs/vY2cDsnEuTOv44RpNoJVwY6Dc0JJ9bgXg=@vger.kernel.org, AJvYcCWBf4QxvG9V2dlBhAPuXYmfSKqhCZ9wvqQkZjy7d0DIZ07GnC45RKKT/r9RfKGOEkk+IWEJKy+P@vger.kernel.org
X-Gm-Message-State: AOJu0YxnFR0eKTwEH41QUpjUlooGJpluEzpZZ+OO+48VlYiw8pQd/KM3
	9yhquUOyemV471iISljOkroYZ/30CcX2wcBZF9N+wFdEH1KtI5vz
X-Gm-Gg: ASbGncuV5tBVxE8OltdiG7ljaKcmW90gKSCB8++m/JOL7xaZbVhfvIrWSjqN0tAf5+F
	M4xnITNeQg4WPVV2q5ycydBxZ3N8WgFlhdWOBcCz2nv60JkeLfT29cy68mHqaq/mdw/+PpbxppB
	pK3en/oZ66wH6kh/Vj7RRx8qNXwv4TpEC+ZIovHJ1XDhyFVZY3uWXofczqimznU9mJc+uMQHm0j
	n0KbNRg2Nb8oOJq+YC8n/rKc1yr1GN2Mr478CAZgiVOygpLt8zlIqRHsTsNWb0Ie6T2PXQs1i4i
	hw==
X-Google-Smtp-Source: AGHT+IHG8yy/5ZNzwUCkxKjCQQfRjePsw3KTiv6MjhBgxNc20eGp6xaX9Myomz22N9ui8afV0b1Keg==
X-Received: by 2002:a17:902:db10:b0:215:65c2:f3f2 with SMTP id d9443c01a7336-21565c2f650mr243763255ad.6.1733265413165;
        Tue, 03 Dec 2024 14:36:53 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21589aa5478sm45813675ad.59.2024.12.03.14.36.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 14:36:52 -0800 (PST)
Message-ID: <5eeb1f9c-2b9f-49f1-9861-051478a8630d@gmail.com>
Date: Tue, 3 Dec 2024 14:36:50 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/826] 6.12.2-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241203144743.428732212@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/3/24 06:35, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.2 release.
> There are 826 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 05 Dec 2024 14:45:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Same build issue as the one reported for perf on 6.11.11-rc1:

util/stat-display.c: In function 'uniquify_event_name':
util/stat-display.c:895:45: error: 'struct evsel' has no member named 
'alternate_hw_config'
   895 |         if (counter->pmu->is_core && 
counter->alternate_hw_config != PERF_COUNT_HW_MAX)
       |                                             ^~

caused by 629f9fa8142105b4cb07e9b4d4452dab0ca40914 ("perf stat: Uniquify 
event name improvements")
-- 
Florian

