Return-Path: <stable+bounces-142924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A12AB03FF
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 21:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61EE13AA1E2
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 19:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DF3288529;
	Thu,  8 May 2025 19:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzVa9d0L"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328364B1E7C;
	Thu,  8 May 2025 19:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746733885; cv=none; b=oDzr3L7mObudVpljfWaFZEeysUjbX3X29iNFUCxrDsx6EQnH06AESBwK0BG9lq6aJm2JFx5x7N03r/U6tD6gGN7U/DLDr5uMJ1FUwiqpABvIVfuqipTMorSXL6xzeqxxy9h2SoPg5xq3bz/52Kughr0z9AoRZQE5O1ZnNh40TZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746733885; c=relaxed/simple;
	bh=NxSLgtwGa5Pvm3sSaGJSWkuVJbuhdtpWSuSUnu/IKFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PeAuf8KPgP6D720HEbivt7spXe2s47ScLX2WyiwdKGWhTTMco7FyoVvTExg010DLnZgroezWal4l6id24VJPZWNcwc1DEqJHrWJfX8RG5ggS/Y0cBBaV1VQGTnCUh7U5lwuFy4LKQAIFMwORofFs/JOfoyihJ0BfINahnrFbUTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QzVa9d0L; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7376dd56eccso1528302b3a.0;
        Thu, 08 May 2025 12:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746733883; x=1747338683; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BxFtwmyoa5Fo1/6tSGbyqsFnT+GrzfrM2vUs8B7e09U=;
        b=QzVa9d0LZf5g21QnKYdol5ibj13EBIIN6GHG5wIG6Ij1yeW4MWR3ovFKCh9EccHhgd
         2ZTgj2D9re3Q94eCAnqIcNKyV4Qm+6PjS5IPCCaMyE7XBFKEP2N/FCsx9EOfeRpthS3F
         e4d8cgo4ytrARbG7Ra/mdNnSjqFa5zrQbcYqXF5zZK8Ba6UZV4ZMP/V2Li9DNm9UfGCy
         XucBcQtaAsH5NoddtVAFl2Vy14BArwfTph1HoWNUzlc0tlCUmmqqOeyCivSvrHHrAawf
         9EqYafkYYw69ttxIUN5lZI3goiAbg9RND0oEvHgk9VdDgT46TfgyRH5Z5nhSHydv2xYr
         ckew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746733883; x=1747338683;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxFtwmyoa5Fo1/6tSGbyqsFnT+GrzfrM2vUs8B7e09U=;
        b=GpzPXE5Qpgw3SJZr5jA1dQ+qoLkfo4w8Q8tRcQ/1y3k/WVqV9rnSExKKFa0L+w3U1s
         HmLcVSENMNo5pqbyZVaA8UpGuf8fDZcpRaUfegBrTqmLygIF641kj6eRyzhvmnkTaGLj
         ZkRdAIz89znCVTXZ2OhhO/XkPUkWE1HU3PT9N/yNcAQL6nr58nkMMj1nTlcYeyXgKG51
         aKHB7A9WZlKKAzI+2ch73i0VzKckxS4xL7zSk8NMEqyKhCsnNAwjX1plovKI/+5RyZ9V
         UXnpKsdmUqaKMRSwupFtcFa1iJcbTz2VjUC8m9jBnzNa0STIrzfVjMLdYfopHpeTDcas
         5xDw==
X-Forwarded-Encrypted: i=1; AJvYcCVPbh1eT1igkHX/3alDm+NmxaKqG6SwZ1qfBj8kHvoyFlxFFU3Wmn0/zlmX1KczdwYaNuroScMw4BvUVfg=@vger.kernel.org, AJvYcCWluTXWjcgAO66yNzmql9dkZHpGf6/hJYsBgig69vn72KvP4J13k0lrR4m9H8nCd4OyoiS9ALAw@vger.kernel.org
X-Gm-Message-State: AOJu0YwFeFLsWPXL3LTZkiMraXDhCs8CpyitOJ3sFhuUORTB/ucKH4uJ
	JtQ7413JA5uAeDmtm7VU87wXCr0ogHtE//OKDdB/p2Pq4gVAzIth
X-Gm-Gg: ASbGnctSIDy07/7eoMDYXgFrowZ5DwHPdjayWcIqNwKeXanNiTM6KpumjgUtcGWTC93
	us1hdTbZE5+lzeCSyZexJ3GgmVeGnsyOwyuva4xFk9r+2a7RpNOp2O44ymiUcmU4PmQ244lZ1dI
	IUzf15+bFP8U1dEUKuDu7VZdnUP4/yDB5yiYwWdATlUufLnr8YcVLlr0cx2wrGQtvPq1JlKT+gj
	2aQ2MBW280Jn8QDOxxDKrVzB6r0VF5lTzFLOuzUaSwsGyUZurDKJMxh2Ogjop4FSMr5ed/VJ8Y+
	r6dLn01JiVk0FsOJDEaiX0NFfsdf+lCL/84MFsc6sAHrn5vq079ONxfUXBygctoShOi7VWOtbWT
	nP0q5
X-Google-Smtp-Source: AGHT+IGMfZ8xzshY932iVGkJXt00AIUnjSibA64iPqAaIAFBbci7gB43Nlq621rK0qJj+ODf6GJ3ww==
X-Received: by 2002:a05:6a00:f0b:b0:737:6fdf:bb69 with SMTP id d2e1a72fcca58-7423be92b53mr753548b3a.13.1746733883325;
        Thu, 08 May 2025 12:51:23 -0700 (PDT)
Received: from [192.168.1.177] (46.37.67.37.rev.sfr.net. [37.67.37.46])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7423773c796sm430081b3a.69.2025.05.08.12.51.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 12:51:22 -0700 (PDT)
Message-ID: <7098bb22-76d2-4097-918c-7120a4998b92@gmail.com>
Date: Thu, 8 May 2025 21:51:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/55] 5.15.182-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250508112559.173535641@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250508112559.173535641@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/8/2025 1:30 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.182 release.
> There are 55 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 10 May 2025 11:25:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.182-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


