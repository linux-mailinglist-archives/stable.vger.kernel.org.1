Return-Path: <stable+bounces-139476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E64AA72A7
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 14:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E79893B11A3
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 12:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6D324677A;
	Fri,  2 May 2025 12:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aikm8zVq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE3723C516;
	Fri,  2 May 2025 12:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746190565; cv=none; b=c0T0BFCX5kwU6lBiBFMtWxvQz/8hA8IPbj5SpOBRG/N/C/j+AeTmmnqQIAziv2bhEqqt6b3d4pW45QogyhoaQ9IKDVzxLEhnS99Lrh0HtZkkvHYxNfk7djla9sw/oa4wMY8KL0LdSQm6RkN9iOA+kYTiMudC+8+w1BMuuUiQeC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746190565; c=relaxed/simple;
	bh=T5RCaQh1OS1YVWXXdYqLrdqh+D9eSumycnqxc6D3umQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qKUWTvWyNkeOerxA2Y2y339xP8UN7KZ66Sm/LtzwJBR80LzQeuY75jWL29XkQkfMSqjAigHDtdTvv1kvM2o1r8ZLDpYRmtIVoI73UbBrKqofmR1e/2XSobAKAS2a9IAtgo5QD1fN9DTfLFCOkOADvT0KIOLzBunOX5CKT0N9l70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aikm8zVq; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b1fb2040de6so247588a12.1;
        Fri, 02 May 2025 05:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746190563; x=1746795363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uB/hNXSf2TW7hHGTMgSqzWRu2TdmA38pn6TeFi8PGBI=;
        b=Aikm8zVqPz6vhmUmtUFW+WC2nmLT76kE4ijw4929hcbq/81zFjMqTydvzBZW1RZ5Av
         6wXxScD6KneWEUw2gFhOdeg305lbtxicGHQOFqQzbD8RbG9ZiDVVk74CxoxGVsmWsY0M
         R/aG8X+w4oQPzG0Mgr0AfX3qKgf7jhTDg1O314uPpWUsaBIVzCmR3rrSe8mCsv2Lcjc1
         QfJGQ/ZrNct+Tylxhbdn9hE/los1iqvqQMS093h9nkQBORUBIXrJJCQHPnB+7a59S05r
         t+qveuq6U3wFHkY9I39LavVtvjI/Llf4WZviBiarlnOQnubiRrxf03T+nL/Kvsrezzl9
         0Tcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746190563; x=1746795363;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uB/hNXSf2TW7hHGTMgSqzWRu2TdmA38pn6TeFi8PGBI=;
        b=on6JHBHFk/agWy8GSL/Qrf5Q0YtFr2aXt5GbwBpgkBAUoWty4BKxmnePbzm1k+S+cA
         fK8n1Rn7kzFt5/bzQ9MKZz+nn80oz68GtBpHHaFpVoLAD/k2zvu/QG4+wYylff3L7leq
         +alTAcvM7sjtQNKbJ4mfp6BHi5jil5r2d3d2tQv+7XCd8mjDKhEbZsoZutbKdUT9sL+Q
         icSg11jg6675uV5hz7vspm1HxyDr3/vdu5XKmkraR0AlNh5C6BnnGKqrPGOLXACHSfsi
         znQbWR20VMI7+IAVqisub2S6Bw/lKHKUOngRfiqBYr0g86dfW//Ao3zTyN3xzQ0S4ydd
         y2Ug==
X-Forwarded-Encrypted: i=1; AJvYcCVJzPGJEHno07mi0rGGx0TyOEnbL3f27Lzd1DuqHkTXsTfrPqX20Nke3Kk1GUJEcejlV9B4EM5FcYZjiHk=@vger.kernel.org, AJvYcCVKsxTcWuEoHL3JwPZjgwFKEAjICXn/uraIPlL8w2XVtcdxvZ2AbgPosQvc9lLDdab4s/pO99yL@vger.kernel.org
X-Gm-Message-State: AOJu0YzmjSSfTpWg035ROMDu3EMqS1NWa6GwV92oMCOZpc9VsN6qYhax
	P7+zoqGJ8IgkMgaPPdiwzpng6NHd7SzrrFLRqL3qsqK9A6Nq2mlciBFXLG+u
X-Gm-Gg: ASbGncuR9aRVXjACeYinsurmBh+LMnwqDlCFG7NPzgv514plb95LP7JXMPVlTzB30RB
	3Qq5/r+y7gtSogO4giLL+HrzYAHcucOCZ5np1B5SfyheCC0QfnsxAOupQJnS8eQxqnS7v7GlQ3s
	181KvMKe2QM3Yh+5sXICZQ7qnaMwzsjFfL/ia1QlQYWkbcfH858SRELbqz94a/TsMwIy5dd4/LE
	4BXPIb4vx0ZBnQtQGTQ9w97uB5hmAeQLnvOMQtxd9+CIhUxBg5ViRDbptheP5zcwIRuQi8D/RDT
	0apYYMIqNxFLlNCYegugN1sNI0hqegnH13h1HisjIC4fn7SiwPjYFkNPJ2KVppsujnVEFeDvioC
	XMw==
X-Google-Smtp-Source: AGHT+IEZsLyuz5gPjySkbBTwVbbuiFfqFW70gHuZpGjmgca7zpMRw2fN/Bj8nQUWoG6avxHD0ZGu8A==
X-Received: by 2002:a17:90b:2f90:b0:2fa:21d3:4332 with SMTP id 98e67ed59e1d1-30a42fd0713mr8604445a91.12.1746190562757;
        Fri, 02 May 2025 05:56:02 -0700 (PDT)
Received: from [192.168.0.24] (home.mimichou.net. [82.67.5.108])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a34826755sm5575486a91.48.2025.05.02.05.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 05:56:02 -0700 (PDT)
Message-ID: <6524f500-3fc2-4301-8702-8999edc99306@gmail.com>
Date: Fri, 2 May 2025 14:55:56 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/157] 6.1.136-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250501080849.930068482@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250501080849.930068482@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/1/2025 10:14 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.136 release.
> There are 157 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 03 May 2025 08:08:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.136-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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


