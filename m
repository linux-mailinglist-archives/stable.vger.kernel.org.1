Return-Path: <stable+bounces-181559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1680B97E58
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 02:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06FCE1AE150F
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 00:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAB07260F;
	Wed, 24 Sep 2025 00:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UJc5/0NN"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3ED18B0A
	for <stable@vger.kernel.org>; Wed, 24 Sep 2025 00:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758674015; cv=none; b=T7SswAYIFnlIC6V0qAJcxUH8wBSlAuQDBUzx8wbWc13dKhToazip7SMigiY3dEc/mmkeQC1gxfZOSAKstaUs6kWaAjYuv+bsXq8x8Wl1AUp0u9zCDXNm9O4ANkXiXl/KAo6c75OgyzdyDJaYLUBpemBzzF+5vc4Vc88Y6oYo2WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758674015; c=relaxed/simple;
	bh=C5xHHpQBIRnwOxQRsuVMnox28OdPSZKgsMEWMSVqR14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PeJErx4BfoyYDz7e4SfU+4SZUEFxZONJgOIGu7EFHQFpuwNy4zdjjBH2SDSMx0zOQnloTCeM/YfVPYVIUSW0iX8+z/KxvKqxUXxbvKWKT0eYcmCJgrexZeNdDlHpTMUVujsDSBY3nfV/KriKFWbfwNpcZ6R4+qV1gIFPCx3HjL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UJc5/0NN; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-42480cb42e9so26188615ab.0
        for <stable@vger.kernel.org>; Tue, 23 Sep 2025 17:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758674012; x=1759278812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QeCpOzQKe2yNJ/96XeJlPPvMwoakp9LE73apKlL8nBs=;
        b=UJc5/0NNNFr7vsO9PyYKDsVFmBXJ2pItelTKja5hgRUAFOuPWbIoKedppI7R/QP3s+
         DyHREbW7v07pepFUQ8yepf8E7UaWLhmvCYwKl1HEQMA090yilk31OI+ki3AGA0jq8EoS
         gLeRlfGmGYSkgQk/anEf090cyeE+JHkTNGI6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758674012; x=1759278812;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QeCpOzQKe2yNJ/96XeJlPPvMwoakp9LE73apKlL8nBs=;
        b=NgIjCdb34Co9540b/rdhDCji5LEz46X3D27b9RUm1QWeOFBDcP2jLAcrYt4WNGJ7TI
         5z4kmvS6qmuXSqdLs2YEkwK0uWb6KsYIDl8BQeUUePvIZAKSW+GYsKHakxsYac23TOYT
         mNEEJnXX+jFQQywRSNcvhO9IlD8Jn1wBl0Kpq9eiQjrpsgxf0rlL0QrlbEixby8DUOWz
         LVLKzdeXeR9rdIEh2ab80LedQ58UFyfc/+wKrM0auQKEn9ojRVdFxuhUkuJDQ6WNKcxX
         WXOJjNx6iwH1rouiK4DQ0GFrsPmiwwp1q+DRsCdh5V6G3Ki2eW6uWTTyJOFSCD58sOZA
         gPfw==
X-Forwarded-Encrypted: i=1; AJvYcCUqIxYjnjzDYmf8vEVd6md+nsbnbSM1dGIG5W6i5sCIsnxJDcywI3XSNH0QjFMBhOuc6b4aLtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqiQUl7/KTcLyAB/S508GtdEXWDDYbFMdTQPPR0+acZekmTn5V
	KkYcpv1oVAHs8zhsYMyGctswVhi8hhylXXaUoq/e2Y8FttFfeBDAHGOGs9elKloE+yE=
X-Gm-Gg: ASbGnctosOuXFgP0UGUxXUctz9rkwqCy+srHR6DuVV34i62x9XFuzyDtivEsIRXXC2t
	q6QKjpC5RB5JpN2gCV6TmLhPp6qyb0Zmy1u/EURDf9AqsE+/PybWq9FyVkOvDAlm2uhVU/TNAjR
	JCHlFosR2VgbodbVIsPLMZK3QLopHQVSUGncEvHE/S1HkoaZSTJjELbQx6qYQ8jqIhJ1qmgzR2f
	FTbStYuoDyBpvAxqFsYqcNsifR5QG1tlAudSRrTtDdNFjn8CPpscO7ByGXrYOciRE7Bq/GkkSCs
	LYHPBhNIQa5H9JWIEjEndC5ecItpoSDSajDbHAx9vmVvvpjy64h5ZtLlG8tOoAl3J7TWDY8loFP
	YDA+YqurN0tqFUKfsnZqrhIJVa9Q+6aKpisygjBv1wk1y6g==
X-Google-Smtp-Source: AGHT+IGMzxAmPOIYUqjqDWkSj1Vv2Q3usl1ONJIUBuObLOZq0Lscrf1N9LalcNZh3CtVcwMy11Qc3Q==
X-Received: by 2002:a05:6e02:2181:b0:424:71e8:3a2e with SMTP id e9e14a558f8ab-42581e7a670mr60747925ab.16.1758674012501;
        Tue, 23 Sep 2025 17:33:32 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d3e337433sm7570329173.27.2025.09.23.17.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 17:33:32 -0700 (PDT)
Message-ID: <69689eef-8323-4afe-bc29-bfb5954137f1@linuxfoundation.org>
Date: Tue, 23 Sep 2025 18:33:31 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/61] 6.1.154-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250922192403.524848428@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250922192403.524848428@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/25 13:28, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.154 release.
> There are 61 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 Sep 2025 19:23:52 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.154-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

