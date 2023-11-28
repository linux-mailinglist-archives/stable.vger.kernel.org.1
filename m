Return-Path: <stable+bounces-2874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE957FB4EA
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 09:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6687DB21725
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 08:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA222E3E4;
	Tue, 28 Nov 2023 08:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=heitbaum.com header.i=@heitbaum.com header.b="cenDLV1U"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1729CA7
	for <stable@vger.kernel.org>; Tue, 28 Nov 2023 00:54:38 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6cbe5b6ec62so4140289b3a.1
        for <stable@vger.kernel.org>; Tue, 28 Nov 2023 00:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google; t=1701161677; x=1701766477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3lEAT4IE+5TgDTGRd46y46TF/1k7v9CaLegPFey+I88=;
        b=cenDLV1U5hQL5ZNdo6tbK71SvJsFMgFfRJ2dwDHo3YuSVSfYQLc5kSEgIk55suVYVu
         kwp+hHc2RWEoHim+TMBqgWr8KlaFSG0yReJsSXcH836+qXgbFBiBCXshpExrrlGsYGXE
         Vhi4NGs82Z3KnlXe5ld3Rns9k+VlgzMHkqdkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701161677; x=1701766477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3lEAT4IE+5TgDTGRd46y46TF/1k7v9CaLegPFey+I88=;
        b=sqN1Y4H7lwFsrfdncID/GIEVhaMKBV70zhcvZi8Fnm753sKsZSGl9CBZDnYnFUFtgc
         nZAc1t8D3Ja2PTDyHmxIkgeodfk2AuVspE+FqN2cEXK8pRjnt/98F3Oars5jN2E+Saf0
         ZbSqEOHFQlDFX05tneaJ+naTXHX5STWagVm+r2meDZbr/HdciQgP9Kkm2L1nRMWmglRi
         wCwq7Hz4P+N7YTsKHsOFbXFnyjtssecusIWqWuAYjIJbt0DDdcgGlPHb9KClf9QDFGBq
         KSXT4cp0CwsOdP/DIkNpONBxsqjBe9Ss9JciBagJVyyuLsfBAK6DHAebalUz41OsVzZi
         jtmQ==
X-Gm-Message-State: AOJu0Yx5QqiRgvHqdeHqK8KoSU2yKW7DYT86bfvy9o66jMsUN7+og/5U
	XvyWuBOek+DvFa7+Z+9Guusuj5zHF2cmVJpcr/GcUawq
X-Google-Smtp-Source: AGHT+IF/gklNETPClvaFFsJJAdl1ueNFy4xOPR3Sk46cb9O3ud98cElsa/5CMYbsEFz1SuE1IoxsJw==
X-Received: by 2002:a05:6a00:f8a:b0:690:d620:7801 with SMTP id ct10-20020a056a000f8a00b00690d6207801mr13935663pfb.11.1701161677532;
        Tue, 28 Nov 2023 00:54:37 -0800 (PST)
Received: from 179c313f1339 ([122.199.31.3])
        by smtp.gmail.com with ESMTPSA id p24-20020aa78618000000b006926e3dc2besm8331807pfn.108.2023.11.28.00.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 00:54:37 -0800 (PST)
Date: Tue, 28 Nov 2023 08:54:27 +0000
From: Rudi Heitbaum <rudi@heitbaum.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/525] 6.6.3-rc4 review
Message-ID: <ZWWqw7BVP5NfY/k1@179c313f1339>
References: <20231126154418.032283745@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126154418.032283745@linuxfoundation.org>

On Sun, Nov 26, 2023 at 03:46:18PM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.3 release.
> There are 525 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 28 Nov 2023 15:43:06 +0000.
> Anything received after that time might be too late.

Hi Greg,

6.6.3-rc4 tested.

Run tested on:
- Intel Alder Lake x86_64 (nuc12 i7-1260P)

In addition - build tested for:
- Allwinner A64
- Allwinner H3
- Allwinner H5
- Allwinner H6
- NXP iMX6
- NXP iMX8
- Qualcomm Dragonboard
- Rockchip RK3288
- Rockchip RK3328
- Rockchip RK3399pro
- Samsung Exynos

Tested-by: Rudi Heitbaum <rudi@heitbaum.com>
--
Rudi

