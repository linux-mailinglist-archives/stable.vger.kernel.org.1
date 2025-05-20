Return-Path: <stable+bounces-145719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B52ABE5E6
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 23:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8C711B6284E
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 21:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AFA1D63CD;
	Tue, 20 May 2025 21:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CC029M17"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4B64B1E7B
	for <stable@vger.kernel.org>; Tue, 20 May 2025 21:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747775816; cv=none; b=W0R/A7/NJO7TiHF4QD2LL+NB05Twk9kYlhQzbp5QZIM/LCctkSSqdssObLU1E42e3Bu2bJVJPWXK/zLqGj3iKiswNiFhwRojW+aaGF9sNR9sFNlRdIO6BnPLhmqAzWD+TlliNqXgts3HOyzE6WQyZATFq4rQ+Op/jVt7dzdoBNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747775816; c=relaxed/simple;
	bh=tmAXI5Vz6kKlh04iIaEoTryqP3ZZCQEc8B5PrHjzjGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lOT4oLX3iQypuc1PeyfLhSIvMcZD5rA6zLjZjw1+E07kVmDi2nR4wDV5iQClTnM3R4whBUTjEPLYKM7YFropNFUM3n7eVkicEPKFZRdpfuxnYRxbmI4qvK6TXpWjzMFFtsH14JffFYoQDpU4lC4hNjrRvVAJZfpWj/TKXzlyfVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CC029M17; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-85de3e8d0adso144057339f.1
        for <stable@vger.kernel.org>; Tue, 20 May 2025 14:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747775814; x=1748380614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yGTzXh3InLODqO504vLG8maKIJQ4gfFaDVwDUD+ra6A=;
        b=CC029M17lJB3d/9Lq4eYrwr3yYZ9lvmeASAqS8qT4bET/DaSDc8pppVKZafML2V750
         yOuvHjb03sSxOfOMgh5U42r1o+k/LtZ5dMxqwpFzZexzIvMDTOX8e6FGnJDDSNVTvxll
         w0pWemy2fmoPHHTjVWNi6HyBoOSqLTvepLuxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747775814; x=1748380614;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yGTzXh3InLODqO504vLG8maKIJQ4gfFaDVwDUD+ra6A=;
        b=FftC3ZH9KaFOjj7IY6LMWPvLacGy/VlQmYpNbqSamMBXd713qgFN1OsTIa4uX/dnTh
         6a+3kpR7zl3+/FTCDRI/9kASvPo7B7OeVvUIQhUgebarNQp1mj9bCM2zc+DQmGWqkcSX
         to0lEEbrtygL9IxlqNBA5FfjHf63uGK8ndwqrMfJ3B2FVBsTlKzO9iLzHxy17k6g2AjG
         kv/f2KrO2rnQm8M5OSugteNnc7ikcn6TiaR36jZjpOzaNytpIFm18Sv7uQMlUhdxDxN+
         J5mN/TOnuH2T3fyqDJqrUI5Yu0ZSgnP85C40xm3VKnIm5NdMLN6Kvz+VvHIEKTkKKN57
         /FRg==
X-Forwarded-Encrypted: i=1; AJvYcCWE37VKf0ekjljdakN/JrQIkIqfDAuzapocEmvVisNH5DBgT+DETbgS3Ue5/a2WQzB2CyoT/4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVOjDZYKNw1e/3nR8m86AMYk/3KxDsH1RSHlg/MWIktmmiOGNH
	niL3/aubSxUUEnnBwjiK8LiKFAOC/JeuvKzS9WHE/zpKnIf+ajXu3I3/6wyc0gx0Auk=
X-Gm-Gg: ASbGncu0Vx1YY8js7iWolZG6NnmBXwkxRJiSRRIF24ndOxFCMbXzNIbgEV/Lt3ryeZb
	7gD6bw4gwRrOaM45/pHRAjZuzQMktsL40eBfBbqS/za8doa/5klXiQOP+PnT0OK9A8CNziRB24z
	jbOx1u3y5moTw7fTSWNVS0rOeUEZaoaIFhGDxXRMGA/0nCdGK2uZqfq7cJl7LSmUFscIYV8plTq
	EnyIsUg7vJlX/bC0KkJ4XFPsnhTliCm2xGBffRchKuxyN7AmS+vdYScJo8VR6+r6/puj0QHjdWl
	IbBL+O0SEX93L+awUdHEOXQUT6/hsEgdHRGRqqyqU5Y5rVL71Lffj3QwJHZCIQ==
X-Google-Smtp-Source: AGHT+IEMRyI+8zulQv0se3ozP6ij1ybvQAhG+E/hVHlSg6txJKueo5YQaKNLbqitTbAHP3RIFXXtIA==
X-Received: by 2002:a05:6602:3944:b0:867:3670:5d49 with SMTP id ca18e2360f4ac-86a24bfbfdcmr2441929939f.7.1747775814121;
        Tue, 20 May 2025 14:16:54 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc4eaa3csm2357278173.143.2025.05.20.14.16.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 14:16:53 -0700 (PDT)
Message-ID: <010b13ee-d640-4563-9215-a78c4c4015da@linuxfoundation.org>
Date: Tue, 20 May 2025 15:16:52 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/117] 6.6.92-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250520125803.981048184@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250520125803.981048184@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/25 07:49, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.92 release.
> There are 117 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 22 May 2025 12:57:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.92-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

