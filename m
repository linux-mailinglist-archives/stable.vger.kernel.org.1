Return-Path: <stable+bounces-191553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 126B4C1726D
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 23:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083131B26610
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 22:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A609C35581B;
	Tue, 28 Oct 2025 22:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="fs5EU/At"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F4B355806
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 22:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761689483; cv=none; b=hFZ2nFgwbDes4GTMk9zmt4Fi0Lnxt2uvcXkgZ4kD3MlG1V6G5K2OfT9sK9p6S/1x5317WZ8pcGdZZYeg8fbMpCYq3XVcyQt8BrAXzj5bKWrnN3hqvx+tfCCuoLIWUcFhDYKS20Djf+alArLcyGDPlZ9sLHSLiXZm8bC/DH89ZNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761689483; c=relaxed/simple;
	bh=SajjjPU7ooHm9j1bcOZQP2p2t6mzMP8oH0w3pXmySUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jn7JyaYGDA23/c1dddnP00SntrJhb+qsHL7UdR6WhzQ5Br+73yuG08qM/Q4Sz7YnXTEBsX+Q6oViwJVSwtGS9V8cZo2Mfzj6lrbfLchFRvHrvM5ha5tYFlDRjdFL9RfbRT92AEpuvNxLVJwUAR2XVyEiWfgmXM0S2yTad67hstA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=fs5EU/At; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-87fc4d29301so61407326d6.2
        for <stable@vger.kernel.org>; Tue, 28 Oct 2025 15:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google; t=1761689481; x=1762294281; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JtLU3JE9Y5OXHhXpJkKXkmYHPl8HTetY/QdDWBoDdO4=;
        b=fs5EU/Atf7os3gWp6MkTot8wLwUu+DoY+bmGhgvsI6muD31N0VIwfYaQwokNsi6a2j
         EW3weJkUahcXk06um4RNHsk8gxGDx8qxHNU+LPoc8EixeeKLG66oOyYeZXzGX4cY5uMn
         trtqFxLoQTWfwHwxfxEgWk6RyjN57JXxwKkLxCOHSfNXSRygPy32CtcwEMRwyKEzZpMH
         xSjMh4pOE6z7yJhESiEN3wB/fbOsjlKca1V4Zx7/iNUDQCP7riiY/QMDkVRoYxWWFI8O
         ewI4pinYvBxltiG1+eYayc+b3/na+kSw+cJkAubtRpRIwH+fvmmvSCodhucSaLkj+fw8
         cNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761689481; x=1762294281;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JtLU3JE9Y5OXHhXpJkKXkmYHPl8HTetY/QdDWBoDdO4=;
        b=vSSs3JMQFKdsLBqKXBLytxMn00c+CrV6ygdZ85GbgknnyCz8ZRKg5lAxKfdGiyWp2K
         +YGz0qvMnKu7BOogtCDlrSUHSizmskElFY7DpOUdyhZu2V9bC6mppKMQPRtTM0gVaO+e
         BlilLips1kEO8cT5Dy8ZmdXL2eWl9ehqBqy3KVLy8a933j51S7i2kW23l01ckODAOi0c
         xm6Ws6b6qOQwLJXh5Gk++gcGNpz1LVm89Pqisr+5kAuJzif4o8rq7PmoWwLxJiY0csFR
         linDqPE4lu+8n0YKvGmddrMwDgaYxlo0UPGQ35L0iQ93Bib7ckU3OG5PY/u44zY1C2Eu
         CWzw==
X-Gm-Message-State: AOJu0YzVcYG0S2WchuatO548GxXQXkWlJreV48R15QxxGNycqyPsLYMZ
	xse6hIdkxPwIZBwx6bRYJ9ei8znqt77snO1gxV7IRVGlpVxcde8ViHtGyN5cVcTixQQ=
X-Gm-Gg: ASbGncsPODteBnPdDSmZcI2mtdstWHoJa1cHS3kDBO6JQfuTVLfzpU3UYNwLmQnwl+7
	hK+GQjkS6TE1dN///qhP8FfYZJWEQR5xtK9lnNrUMUIb3Aaze12DZQHszuIZ+5jM6MCH9Vt/daK
	VavOi5s+Kp5Ln8+3xA8mufX4AAUoRms+kM0QtxEecTPVOejrKL2giBER9o0gn0upNSjAa3GMOvM
	j1/ekbB4XqTYpeJZUhoVWg2/P15afBm0uIWc1p9rGoIUGU4JoNjjqzLYnjI/ImcOJe1eJJbSLfY
	ogrpyfywHnJG0wjAtncsNRJ/shulyMMvqkAWCJuV5ZTh2uIhVtZjo2yt2kMyUjl3PMSo+XtX3bS
	9F1MRgq+jnL5cv4IRcARwYbvDRL6jqbLASBNMBykgXjVBe/lllwWvmkty9J/JnE5+YThNF86lKg
	lmrXJwwYDWgDjkyNqzC2Hxke3K
X-Google-Smtp-Source: AGHT+IH8IqWGuZZlKiFkTKML7svZTrrSeVNnrFoedT23cSoLdRm4s4MqFN2yRRflIL9ChyeaLS53ow==
X-Received: by 2002:a05:622a:1f85:b0:4ed:c7f:c744 with SMTP id d75a77b69052e-4ed15bcbfd6mr13483461cf.42.1761689480630;
        Tue, 28 Oct 2025 15:11:20 -0700 (PDT)
Received: from [10.10.13.73] ([76.76.25.10])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f25a8c492sm914103085a.41.2025.10.28.15.11.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 15:11:19 -0700 (PDT)
Message-ID: <da504bf7-c9a5-4a29-9404-6aff5a7cda75@sladewatkins.com>
Date: Tue, 28 Oct 2025 18:11:18 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/84] 6.6.115-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20251027183438.817309828@linuxfoundation.org>
Content-Language: en-US
From: Slade Watkins <sr@sladewatkins.com>
In-Reply-To: <20251027183438.817309828@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/25 2:35 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.115 release.
> There are 84 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.


6.6.115-rc1 built and run on x86_64 test system with no errors or
regressions:
Tested-by: Slade Watkins <sr@sladewatkins.com>

Thanks,
Slade

