Return-Path: <stable+bounces-144175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A23CAAB5692
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 15:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 555711B43189
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 13:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3092BCF49;
	Tue, 13 May 2025 13:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="J+kATbTa"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B5228D827;
	Tue, 13 May 2025 13:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747144552; cv=none; b=cpPWGGVld6N0FjivB2/nZ92s/JwD+SaFYK/k/2OHiqTN6W0tRiYO7BjkpdywT4tcuKVUJEKSDBibM58YAwZRrzoboB/0b6w3AYMVQIJydU/dCHANsJQw8paXGuj8/bhFyGLT8SaKaQH0ozinD9gkY85P7RINrn1s+L9s5a5ZemU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747144552; c=relaxed/simple;
	bh=xba21NOG7rOPSMa3tD/pBNgqk2u75/Ck61P3nj8vnGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T65Zbywtd7xwW8Lapx3NDXqQBNbG1biP4Y47/3pKitmk0lvGjYE5gE6GEkTcTnCNYO+GEUfAh/Mff2D8T+iQtl7xkwfjyQZmSEpJwwS5XPO3physmZgfmWXfZ2z+4QmhdfUIlAlISO1ZSLncRBAT/qJDJmNoRb4bh3ZHfC5ksOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=J+kATbTa; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-441d437cfaaso34625635e9.1;
        Tue, 13 May 2025 06:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1747144549; x=1747749349; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JiwK2SmUmEjixY9V6aTByvju0iHDjXppkgr75q/PvCw=;
        b=J+kATbTaYeHAZ5qInkR7sZJ89U3GoW/niOgmKVZwaH+XP+PkS2HQcggwGioqxOmY5v
         RV2dlw9gtqxFl9cnGMCbGPTIk0TxXrXR5F2rBl/ln0hIfAMz5pTa2Tax8dcyDasTawSK
         P5fZSzHuHvuM0eVyDTEqCJlvb0N2jaG5bW7QkGbf7Owd8jHepqaqVTtLAYCyA63p2czc
         VXhSrLy8enDvSu7igul2WFubhYM8Ej/BLhLeZyFgfQrobU45lGJGwRRLw3ZUd9qiutVH
         LKPYsQ33pomPjE0exadVg1eIogEW+humKNZM3YeEl4sVPpXuKGJzghrpHyIjqG0lUSF/
         Fgdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747144549; x=1747749349;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JiwK2SmUmEjixY9V6aTByvju0iHDjXppkgr75q/PvCw=;
        b=NK6pAfdIq7w06b2FexX8TLqKSI2fPaVvnC3iyldJ1VUeWiyZ+Un6kGd+G7e3SbFsX7
         9GJ5UdW6P5jvGQv9nQzjbHctUfEuLQq3q27vuHAEfJ8WfFXCTISJBAxDo3DGv/+2INIn
         C3B05J5iNMOENCcneioS/5peyF5qlWiaYS6fHBSUFoHXXrj+99Kj/UuFNS27yPiSb+uZ
         /l+zLBc7nUhkkwPn4vyib91cHRMhgaYWPfMfFMAmgeAPPaNzO0tAzfAkBcyAZsq2XtgF
         rfjDfgPFfY3Tr14im8YQtkSJODTPF6JPSG+0MU3W0ScXp7chL0YN1v8Q19fiIXreCGF2
         q3kg==
X-Forwarded-Encrypted: i=1; AJvYcCUGdbo2Hxy4ljAuI51RG2YaMZrGpq59bPL9PJH20lt+Drp7cJHc3uDJmajY9Y0FegsL5Weh/EP/@vger.kernel.org, AJvYcCWLvkCEYaM9enDDf5hk76lDf9UKeunYrO5F7LGq67PsFpTaOJuGPurZwPzeel0uNh5mEPza2n/g7BkJyBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0T6oo5PUTrR0SvjXdkZb7evn+snevVtoPx0l7Kkd5I+L1O/Z7
	1uO1OFuDbL5yuUBLkfb2cVzkLcbxZjpAS6uol7cvpSUWkAaSaTo=
X-Gm-Gg: ASbGncsqiZRWrgpBlcYXVabdjSgtnxs6o0TrVX+5bjrMZQFFEToDvhyRaVc38rkfVS3
	3Q1NHEjKoJVKHzXTenLQn8C5N1aknLzDNxAOcVsvcTOeSN/T2r9qXuZHMKR0s0QYiRiTYmly4De
	8E7pbZtI0iTbAG6bqC8RV9A9U8REx8BX42yCOP5+MmqRi+UzQ0wfG7gPBmCaX4OeaXwg12NJ8xD
	brBkW1SJkivGWwJoPzdKuO56iqbXfkhDcBUoRGE+WigDX7Hkuv7im5KGbfszvSTfdkCXS6jq6lh
	1zBOBwDeNOg9NWR93qgvH3d2kbKUunT7hvREiSSVm+bq+UX/YyEZCim9NbN/cA2dIhFauDXUQjR
	50hDgdU0lvZYoZ9I9m6nH6vqUW5U=
X-Google-Smtp-Source: AGHT+IEGlSuTKL4fmNNNRhzmQjtY+As7pEhqwbmEI9ncsp5AvdxKJcrNJ/Hx8amETLQ/f9NE3zQuhA==
X-Received: by 2002:a05:600c:4fcd:b0:442:dc6f:7a21 with SMTP id 5b1f17b1804b1-442dc6f7cd0mr104539115e9.3.1747144548505;
        Tue, 13 May 2025 06:55:48 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac006.dip0.t-ipconnect.de. [91.42.192.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57de0b2sm16620420f8f.19.2025.05.13.06.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 06:55:48 -0700 (PDT)
Message-ID: <2e141e82-7e1c-41d0-9ef8-b98e2633301d@googlemail.com>
Date: Tue, 13 May 2025 15:55:46 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/113] 6.6.91-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250512172027.691520737@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250512172027.691520737@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 12.05.2025 um 19:44 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.91 release.
> There are 113 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

