Return-Path: <stable+bounces-126960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B86A7507C
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 19:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BD457A5CB1
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 18:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BB41E0DDF;
	Fri, 28 Mar 2025 18:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WM55f7eG"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35F01DED59;
	Fri, 28 Mar 2025 18:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743187299; cv=none; b=j9S4xCNdnCvHkDFU0HOL4/uJXid3k9GEYEkw9JjtK+tl94ZCI+e/sS2NInp1itcEGyP3CNUq+jCBIHILkj8DXVdE6/JDIP9yhrVVnkAdFUEflxJu0bUrrVR7ViS6bjTGwe++gin91h6UkUyjIVtxa78wph/+aKVrQrXGzJKMnK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743187299; c=relaxed/simple;
	bh=nBBmE2RxZp6NIWrtD2YR+UuEN4LSkgNN4JCokPTjVyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y5r6kV4ODbLdEaY5TuwAsX7TZ1dS/SSi+m6Hbdcoa7cT9sztbkKzZNpBEyRT4xLTbJupGAByPX3JLB4GMWNc185hJmxDhQhI5n3dlFH7lNnLgJkHloDo9j1LCRsezXCMWmTr+7zCJV76HEUaysWnhfDcOoSm/eVZOh9wSTSdpTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WM55f7eG; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3f9832f798aso1473876b6e.2;
        Fri, 28 Mar 2025 11:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743187296; x=1743792096; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G9o9kMhE5UdbSc+QmWRC0lyBqoo7YvUBLbl8Fqh4Iqk=;
        b=WM55f7eGF7UfeUHlZNDTS8zGaB1W7DgBoH3xsbQlFPojEAvDdCumv8hSN26+qC1TDC
         es07EMYttpltbZGBvaT8HV72wft14i53R5Z6he45qlZAALb08cS7STC0h67ePhtUIQL/
         6KtITlW1z3tW4quSlonwxnnQOyyB2NFBxjsx8Um0bAZW7J8Zc7g4kq8wYdrSdKpkW2S4
         p27FtdzAJK5dua2n8kvQhS9l26afX0CWKLkL9jCBxS52YOA1gGDuJm4hVg/hvJfHvxie
         17bsFcKe4HT+fTIJ7nembl583u/jiAg3qdfq7Tje7LMWkbDLYmsNTxsbLrR/DCHMLk97
         +JWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743187296; x=1743792096;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G9o9kMhE5UdbSc+QmWRC0lyBqoo7YvUBLbl8Fqh4Iqk=;
        b=ufNq2txjCDPTdQdNtnPssj9QJJ/C+FexNxLMB272dgYMoU93e1vn1KHo0eYWWpgdWf
         FsQt5gaXt8LbJMAz3eloQNVOg1/oZk+Xb2fml6ibzBrw8nEsEMuS6AetkFlL6j2fRJTs
         kTJl9azTxUaRhXBlhWcDOoGVqxj5k2GsRYQHvgjkqznL+jN/zptJke2tSilH9zvPyTlV
         JkAxb17Y+NeZD7A9LxkP/LZGiOq/l+HApxQLwnr9A6yEmXdKwJhYfZ9ddJLrh+wXku6E
         YJEDY1z9O6JuOQZiuM+Z4Amyp3Ep8MwFwj/5YlTFnP9i+4g0nHznn5lPOtcw9WeYlDvy
         iZ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU2QPUgiaMPeuST9dqz1aBxY77CrHGmtC7kwc+SyMMdGmjkBgcRIdmWI8sN46Rp3itbUzCbGjPT@vger.kernel.org, AJvYcCWuMPoJ7/YTpmT4mOX/mSmuRL/XBgZZD4YPVIpQTK2h83AsOpWSrYtDx6pZSoiTRFqbOqxnruUf1Zo1HEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTJqp9YYgQA+a/ZkYJ9UzA6zxvkkLDt7R4gLVJYZWcC89Qh6+g
	N+l2MVtSgV1IBBq4PSQPF9hJo3qDQ5DX7GJ4+7ftDfVbWGhxL0MF
X-Gm-Gg: ASbGncvBIin98vVMnVtPXJdCQ+FXIlLCgGWHOn3x6pK7AYfuyzNj1oNhlxudOPchDc3
	a31tl/J36OSrTdNTxWRjIjyxHSv5HzCI5i6MJIxkwAS5y7QFdnRM9GB7pPM0qaT8GE/ndLVSvzX
	6E8TLBv0RV1LHz1tWa2ve+ZVhgmHga96geXaiIEViO/FkNo0rPZkb1ByhmkhUidCH9IIfNdglE3
	P91o51IoZ192PFZ+b64OWnfec4hZE1fVA19zDoFybFvnaz1hwjABSLxy38nkR0Mb7qJHBAKr0D8
	Wtxy5x89YoIke1tAGPvbK+4Mwt2DO8oIN754d/siVglUa9WfreIICpITKej+enFSYxfdbvVcCwG
	bMbnncvI=
X-Google-Smtp-Source: AGHT+IHvm2PyJiKouM80BtF5bu0WNeH59ysoYWD31c4Uw8WAwJtKaeV0ODNDDYa74l3xVxtyirZs7Q==
X-Received: by 2002:a05:6808:13d3:b0:3f6:6d32:bdb4 with SMTP id 5614622812f47-3ff0f5b4178mr212821b6e.24.1743187296477;
        Fri, 28 Mar 2025 11:41:36 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ff0516733csm429759b6e.2.2025.03.28.11.41.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Mar 2025 11:41:35 -0700 (PDT)
Message-ID: <32ec9d16-ad39-41e3-a505-640025ecc92e@gmail.com>
Date: Fri, 28 Mar 2025 11:41:32 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/197] 6.1.132-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250328074420.301061796@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250328074420.301061796@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/28/25 00:47, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.132 release.
> There are 197 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 30 Mar 2025 07:43:56 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.132-rc3.gz
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

