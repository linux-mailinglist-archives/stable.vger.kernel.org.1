Return-Path: <stable+bounces-160392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7441AFBA55
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 20:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1134C4A521F
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 18:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D751DE4CE;
	Mon,  7 Jul 2025 18:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OaeuJY+D"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ED91B4F09;
	Mon,  7 Jul 2025 18:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751911527; cv=none; b=SJmVvdwdSkxs3sp8GL0QzhD46ZO/LzpD6cp4jjjSBEZnlJQzA8TUVFx1KeR27wMxkSq5WQgeVa626cp5JutmZbn04xZHUfRuExuMXqE0emN5KB1HswAX1htJv1pa51ntKYdKQQfcb9y28PkD52yjUPb3wbS13nbYgoNDL1/sKmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751911527; c=relaxed/simple;
	bh=ET8EmaBNdei3xJi4B4cLjqXEvcH8Sbf8CCCcvWKdtDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdGMLEa4v9c6R+WgHzIuCSwo9S8/l/r6fMg3HPbKoFILbkT+oFkCT2Yz0q3C1Tx3oz32ki5uCHhsvoQ5bvT8AbPr9h1ylbxcKyX8ZhbrawMnp6vbfh9cm5BbGFITTMkve9mHOL+vqibDMwgjWa7H0vKwVj4thcEXv7K27J586do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OaeuJY+D; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23602481460so35461505ad.0;
        Mon, 07 Jul 2025 11:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751911526; x=1752516326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jGRWeZIvfrdfn238A8ByhfHB48bvZnAaHTC+lbbbmQQ=;
        b=OaeuJY+DrlIDx84JH1/AvS/HOeMtscBl3zECSIqMrYxokiX2nFNXCLvDE6idQEguN9
         n/kpL2UKmTqogaELbp2BV5WHvblWyvZQgGH+7JitTMiutwrIb87i70+04aLlyHY4Qjzk
         6cphE1tQXniHBFR69bTNKGqq2RIfVqscQAQhsk6L/UjCwYOZccFdIvSW3nG5pO/CzMT/
         18rd7x5/qkXESPoOx/aBalnsODHboc8l1hXIdEiWVCAKVqZPAuNeLyeJPa31FqafymmD
         3q9pb6PNYtcdMXOIuRHKYe9Y9to/zV+i/gLkcJDaYcegNWzKh+oBMuy+NLvqc5zV4q2J
         zp/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751911526; x=1752516326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jGRWeZIvfrdfn238A8ByhfHB48bvZnAaHTC+lbbbmQQ=;
        b=mnx4d1Jh/3UMtRmGnl24qiINkxGK2+YZeKv+l0b6yqD/kxYJTdg6W6gFwiZtKZxD4t
         G5nL++p3KReagC91fN0tl7PPFpTlCAKuNZtIvMDMzqSCrZOihu4o+0AFeRGoEDSEx/oU
         Txkp/s0E01n7eBNnREV2DtlTEXEh1WIESalw7NZOqKwPBjpGmqfNPe5ST+TXSIhdR9Eh
         e0ZRoS12X8CONzDfjyM5znl3+IM+ASSI4X//CEUotZi3kSBnxY6OrKlgsTgLIz48l3fF
         fMQEyJsYFFExldxErCvolaCSbJ7inM2qVFf4/2BbAJobK6IiNNlAvJ+iL6Ug2cJ7wJl2
         ROqw==
X-Forwarded-Encrypted: i=1; AJvYcCU5IcHQBKcde6JYgmm33297eQz5S3xVvsMzWwLWvnjPVVZUN6nPHu4wRuzjC5EKFn6jyKlJgpt/aqmuKs0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0HTSKPb/tqQpkkC8Ck13VaYpmlSqvVNeA1ZPalUDf2uHNZQ4D
	4X9LgiTJeND0Nuu7CDPBRd3x3fbPl2IX09Lrtm3iI6UlvOBKBpwU508j
X-Gm-Gg: ASbGncuYiax7HWBFhhpq4Usk6oiwMuqAb6AkGOLRbi3T41d5CVG9awy2aLALJY5lYZg
	6hAtClc6JUzbiejY8V0oE1q3r2KAeZOXVAUdilU011oA+oJ4baKl3B9loz49Tb9FJFJTA+iFhN/
	86yIrtZh8/8IK4YuiqaX4ka3VBmWDyRkOrKkjVzLbjue2/mw0PUk17ttQ7gOHwRwdtd+TNzSiTh
	6+VFRdlzBBfdQpGWORbgQzAAf62kD0SQW7Q+VOKzppRfzz2ndxqsbdI95EcT/Iw1Ph9Vtsvpgfx
	cO0hbaamAuh8xGYK0l75jq1qxvrw2mtPUPzrlQy6IH4/luCQ1fsmQUwtfHCzuP6Ee1YR1ARq2T+
	JnwRs2hy9/A==
X-Google-Smtp-Source: AGHT+IF8G66eWIGfiuyKX7WIcA+9Ua7I+8KWD093Xk4sBikABXPxGJdwqU5ds1taXMamobTiLOFfKg==
X-Received: by 2002:a17:903:1967:b0:225:abd2:5e4b with SMTP id d9443c01a7336-23dd0acf77dmr4732315ad.16.1751911525596;
        Mon, 07 Jul 2025 11:05:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455b966sm89110355ad.101.2025.07.07.11.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 11:05:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 7 Jul 2025 11:05:23 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 5.15 000/411] 5.15.186-rc1 review
Message-ID: <70823da1-a24d-4694-bf8a-68ca7f85e8a3@roeck-us.net>
References: <20250623130632.993849527@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623130632.993849527@linuxfoundation.org>

On Mon, Jun 23, 2025 at 03:02:24PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.186 release.
> There are 411 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Jun 2025 13:05:51 +0000.
> Anything received after that time might be too late.
> 
...
> Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>     drm/meson: use unsigned long long / Hz for frequency types
> 

This patch triggers:

Building arm:allmodconfig ... failed
--------------
Error log:
drivers/gpu/drm/meson/meson_vclk.c:399:17: error: this decimal constant is unsigned only in ISO C90 [-Werror]
  399 |                 .pll_freq = 2970000000,

and other similar problems. This is with gcc 13.4.0.

Guenter

