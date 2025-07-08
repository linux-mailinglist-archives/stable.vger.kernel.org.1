Return-Path: <stable+bounces-161341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 625C7AFD68D
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 20:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11F7618997CF
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA361754B;
	Tue,  8 Jul 2025 18:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfiMmISP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DAD2DC34A;
	Tue,  8 Jul 2025 18:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751999854; cv=none; b=M6tFxh323ICxdm9WhKQ5mdoDhgPTa7Ep22ytAabJD/nHWhkkcunkj4X6xZ1GtRNP7fdCCy8T0tk7HuYpskxkKHvKp4UbPKmIOSRctQIJ3T5JzmWmE1R4NrAs/upbz6qR3iH5SXnnrX6cTBifaTfR7KFR7qz55FljupPY7LnDWVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751999854; c=relaxed/simple;
	bh=un4jqr41VWnF4oK/40uHqoHyG+jR+1QJuARpkPxDymI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LdFTpBHuphWWWk+EjJnOGyrPxLezLV6PjxyDFU3H+Ewc6qMJ5kICSHLcgV3Jxd0BwUun8oe0gjPC1txht1aOduEbEtgSmnUE1IuXA2qA/td2cmzVoYpolwIPoyavPU8uKxJkOelu0W9C+fNxdEJHs2jK0s45f9VaQPiDl/uT4Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfiMmISP; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-234b9dfb842so43478985ad.1;
        Tue, 08 Jul 2025 11:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751999851; x=1752604651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yFq5U93lGfg6l2vT4qFW/REi+QnjIyuVbXAzMMJ9buE=;
        b=OfiMmISPUmFujtiuy/ABK1FDgHEmzvlLhJhA26axsNcq1ATzvqUglSjXPVglR9hrys
         95/JcSIwlQtd/uRoU7in0n/Z2egA2uAW9gh61OzxtKC/yfc0lDnEJwfjK5JGUCKmrHMK
         tp5ROyqjRBEIjP7mY9INyFzhPgSlUm0gpTd4DZjKadI8LZ1LLpP0tkPdosDJdVj5eOpM
         VKHawJ/JX32diJgoiUIAOLSpTjobpKew5vGfAZn+PCahxpEhYYkmPLAHAXMaTkjfLpyH
         /TCIVlMf71a9xA+BA3bb5Dj9HA2XsU57e8eu7GxJ7yi9nghoxeR4/8JAGWiFXulNYMRu
         ivgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751999851; x=1752604651;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFq5U93lGfg6l2vT4qFW/REi+QnjIyuVbXAzMMJ9buE=;
        b=cDA1gI8T3K4/kv/VMXDEl6wQeyZU/KstWSrae1c2MSxaHwceMK0uQzU894yrTH1Pas
         EiJ/j82fVg2dkpwv0RBu7NpeTRdea5I7ZLi71gkKqzwEARz6LrVCGZyE8d0xb7NDyFX8
         mXOFN1FVKF3ZH4Zo4TWWulwidhVUz29UAYi6XSrmADaqlQO8McasY3EigS3kiC0t6T0X
         fxTIzEHhhxJ0N+St3P2hiUWtrcz9BV7q7mUiH9M59ieGH08ZPRdY7WIvOpXFwnO1SjBR
         WCzrMs9W6ArrArzpgiE6PA8lotpd5DnN/F8DbIbSwL9dkb/OSDL5AzqmC2sgL4LKIowc
         Mcig==
X-Forwarded-Encrypted: i=1; AJvYcCVlmm/a8+HECWfcFDotlAUV6Ty6ejZu7SYv0MXcLYZXDsAYHKNlD0WDhF4iGmrK3gTWZSCEXRmRpg+rjLs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo+eMe8TfbpIcRGpHRWFVJ1XLKCLSAg/Ksz1RmkSTbVK3NsO7T
	GKvXLv+UE3HHtV4cykxn68cVkwyx5jPEoFoZb6AU/vjj6TqukkYNQfAe
X-Gm-Gg: ASbGnctZYfXKUdJAq+7dLhOUu4bvOM7ToVHgMWJVKbATAnJPQBGJdUvqWF6CSERN53X
	H8t7PWoWUcCY+EHkrWe32ea0HBRo3O7SHT4+Jk/to2agy4Dx6eZoKtBUcdgLZcAOOOCpZz4aCNr
	csrtEmagfU3GagtadxxFqFXq3jaIn+ZNpJcNBAIeQGxytw0EQfck5/iszFUwZEOpG1COJpS+Yn1
	jOibGMDYRrNFf3uiZ/ZOM6WHuopVfIbEKn3PdqRPCkYBhKio2Kk1wmKYLHnyZOegEoXd+6LaZ2c
	fjJWl9K6Hq0/M2ApWhb5LqZFP4RkUdl95ZBfMH6KRCZSl+Ut8z8PhXjC7JlzlQ03PqaEMU9yZZB
	OB3UE0Q==
X-Google-Smtp-Source: AGHT+IE6Tp1/WzRvpW55BQkqs3s7L2F6IMLeVntT2MgmwhleqyQv/9dSyJlzGlUXDuJ/0RxU1xMlgA==
X-Received: by 2002:a17:903:950:b0:234:c5c1:9b5f with SMTP id d9443c01a7336-23c8747274fmr263138545ad.16.1751999851392;
        Tue, 08 Jul 2025 11:37:31 -0700 (PDT)
Received: from [10.230.3.249] ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c84581113sm114374185ad.183.2025.07.08.11.37.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 11:37:30 -0700 (PDT)
Message-ID: <7cdb1dd3-2993-4bb7-bebe-e9d9a2fa6dda@gmail.com>
Date: Tue, 8 Jul 2025 11:37:28 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/160] 5.15.187-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Borislav Petkov <bp@alien8.de>
Cc: stable@vger.kernel.org, Kim Phillips <kim.phillips@amd.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250708162231.503362020@linuxfoundation.org>
 <2438aa80-091d-4668-90e0-fb75f3e0b699@gmail.com>
 <20250708172319.GEaG1UB5x3BffeL9VW@fat_crate.local>
 <12b05333-69c2-42b7-89ea-d414ea14eca0@gmail.com>
 <20250708174509.GGaG1ZJSHsChiURgHW@fat_crate.local>
 <20250708180400.GIaG1dkGnKYAS1QOu0@fat_crate.local>
 <2025070800-staff-expire-a6d9@gregkh>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <2025070800-staff-expire-a6d9@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/8/2025 11:09 AM, Greg Kroah-Hartman wrote:
> On Tue, Jul 08, 2025 at 08:04:00PM +0200, Borislav Petkov wrote:
>> On Tue, Jul 08, 2025 at 07:45:09PM +0200, Borislav Petkov wrote:
>>> Right, it needs the __weak functions - this is solved differently on newer
>>> kernels. Lemme send updated patches.
>>
>> ...and 6.1:
> 
> Now applied, thanks!
> 
> I'll push out -rc2 versions of both of these now.

Thank you both for the prompt reply!
-- 
Florian


