Return-Path: <stable+bounces-145700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E350AABE343
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 20:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 834FC4A884E
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 18:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26EC27BF7D;
	Tue, 20 May 2025 18:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEJjpUFu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4402C1B7F4;
	Tue, 20 May 2025 18:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747767441; cv=none; b=SoUexoXqfkiR1fuZetCwa3FCGz2bTvj23UDj3VlNHFTvvr//40JzUnOW9bFh2vGyjM2d1Vq8IQZmvpq904uhf8vgKt2CVno94oQLPWLgWWv02pe8yagfJf1R4NBpmZ8Szjc6SxQuGULebYlrrUTSuO+9fW5QwlfmLzf7HgKCrEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747767441; c=relaxed/simple;
	bh=Iu+EBt1ey8793zxc0OaK6I5nCsHR5WA1JAXchlguGGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HJtiQ+vy8h7wh+PJ4gdXXjehBYsbSdMEzkvIpQUl6H2THIh1xC+Gje7lyKse8KR+/KkOxUHnQUiTmF1fnZ33n6buvp0IbpAxrvZ+3e1VIKLwOTmYADiPFf3OFlws4TzDbwyTT7p1cFBCyKA6CX7B8S0mlcodkx+RRDmMlTeAyEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEJjpUFu; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-742c7a52e97so2515626b3a.3;
        Tue, 20 May 2025 11:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747767439; x=1748372239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AK3bjHmIwSweZcXCzDyi7zWqw9eq+X3ekc7onIFfKAg=;
        b=EEJjpUFu2ZK7ZYuHI+pcMiH++t/GfRocmb+tdKnG066B9nWjUeP3+gAxiE5elXNoug
         wvDgg5uLdJgCCqeh+xnMBR2+9vc2Q8FJclv3ovE795K6/EV1smbmw6h91mloHjOZckkE
         XqYTCPDyU/nt62JmMfhbufjUw38G/mL3dWzOOitN8zllCK5Rnrtitt+F4psJsWaamEuV
         Z/NAAKsxhx3WIg9tlS7hJ3T9LF6hl89j8PXpubHrXLJcBj1OxEzkB2MWQRSu/7qVrqX7
         7Wc7tXCrEBWbF0CmctACBenM4lWdjZAj1wGQXDcsdXe2M8QR+U7M/ukbmfEIf7LZffxZ
         vOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747767439; x=1748372239;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AK3bjHmIwSweZcXCzDyi7zWqw9eq+X3ekc7onIFfKAg=;
        b=mJ0EqoGrPah/OW3iEtyFSxbA9lPgWpEEEpi3+b/raIdAKmgKYoYrVnm/0VTCbcy/ps
         FaZUrls4S9XWkg/jkS+EcFJohXKL75+BwVTLM2MM7q6YHdJRiiPbqFAV4RotCjNDd86r
         8SeVCAfKDgBYu0mCNkztRQ9jRf94kWdg72YlxoPYYV7a5PC83TzFUnyef7B+h5vl/SuQ
         egJm0A5MLEQcQimWk4Njf0yiSdezmQfjZZF8yUq4CKI/r/PBcBPF0024NQUrhqMGm/d8
         8z91n+J+79BOpnsQYzgnKWhdFQkXBlqRVLtQ9wCGQSFhZn0ESPaBEI+nBN4X1/GGfgD7
         VfDA==
X-Forwarded-Encrypted: i=1; AJvYcCVcGB0BSmG02z/kyoU4Jc6ypBO2OKiFHPzQRrJtRXZjUVa0gHxEAGM992z0WNZo2BRj3cqtzbiTxh5XXt0=@vger.kernel.org, AJvYcCXR15P2XA52hNP8pmHODaWJX/IskSCMwWFDkrhpmSO50t2huIDxMUnFyDxxIcthw7y+H5z2HclL@vger.kernel.org
X-Gm-Message-State: AOJu0YzJcVhTQ5EnhMPymIZSkNdEtCeiCEjjWLAxZCpR10i7p2BIwEmt
	Jt+w0VDpmp68AFCb+OIoKbGxnaBfpak9/HgOI1sg/Twt/qxu4J90ypWa
X-Gm-Gg: ASbGncsd4BxzFRVXFodpuREzD7Q9gtt4orrGq1+3h//rdDdQg9C30V0ryuanbXrsrYZ
	q7gt+XQewBhmpF/zFA/d4EDnuqG7jDLkt3gPV29zfWzCL66HCMdnbVz9hiPD/57Mc5lNpxltGNF
	SmEu3xvZgchWQqp6vEbQgILAcxUMh+XCo8SSqrxtbZpTAfUPNEre065ssBtHt4L2F3qDwVjC1V2
	zgUReneKBPXC2yA6JFCnnq9ES6buXR5hbs57XbSE/v5YRQ3LOEV6xhFyFRYmZ4jXmv2EkG8YWca
	333Dv1JnT0fj72KnLgyT3xoVAyo7wlT0M3c0YZygT3QAQr3QyxhU+Ghc/a7S6KrV7dEUYWIPmcp
	zpyo=
X-Google-Smtp-Source: AGHT+IHO41jYR+8sMJWPwVnYqu464iXdLnM80a5AO2hVfo6uTCsl9lkpD95stZdqefaGEzFyqtPWqw==
X-Received: by 2002:a05:6a00:391a:b0:734:b136:9c39 with SMTP id d2e1a72fcca58-742acd509f2mr23053388b3a.19.1747767439431;
        Tue, 20 May 2025 11:57:19 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829ce8sm8206496b3a.118.2025.05.20.11.57.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 11:57:18 -0700 (PDT)
Message-ID: <a611296a-93ce-49fc-82a4-17442bb1c233@gmail.com>
Date: Tue, 20 May 2025 11:57:17 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.14 000/145] 6.14.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250520125810.535475500@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250520125810.535475500@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/25 06:49, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.14.8 release.
> There are 145 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 22 May 2025 12:57:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.14.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.14.y
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

