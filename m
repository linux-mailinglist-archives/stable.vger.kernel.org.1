Return-Path: <stable+bounces-3638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D83800B8B
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 14:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DE6B2818F8
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 13:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C852576F;
	Fri,  1 Dec 2023 13:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=heitbaum.com header.i=@heitbaum.com header.b="IjcCfwzZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DD110F9
	for <stable@vger.kernel.org>; Fri,  1 Dec 2023 05:15:06 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cfae5ca719so4430385ad.0
        for <stable@vger.kernel.org>; Fri, 01 Dec 2023 05:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google; t=1701436506; x=1702041306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gvg9SzsVyrg1+cSkW8ZTDbtaOZGy4u7v+r+pXKw+7Dc=;
        b=IjcCfwzZxvQlK5LOPODZESjQvSi3CpAJh9O1qB+ZfEs85CNEsnI1FYmDyruZ3qyzfk
         o7447Y94YiZyDAscf2iAQXR2+4qmANUTzgpT43cxBEJ+QreWI7HDvNxJ7IB0gUR4j0XK
         GcgOj4NZxfHybZeYmPvbFZExY2KTbB2NnDdKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701436506; x=1702041306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gvg9SzsVyrg1+cSkW8ZTDbtaOZGy4u7v+r+pXKw+7Dc=;
        b=hR+Kdh2WYP1O6BErS/h1Hb3VDIA90nf0YyiKQtp8u/yjtM7lEXfc+8RCRmpq53t1yw
         vvug93wNyUYV/eu54K8Iz0IVdnriWhBIIX2Gq5qtx3KHoKvPVt3DLANLB6hJ/5PvIYKF
         aYcJ0+GWx7dsO3vr04msLtQkwSsOFoYtBgpcYxdujNMk79CddNZmEHsYFhGukZzU+Eti
         s1ZFlep637NJSBw2T6pN+yioB4G57PgqawWM04/e57n4iJjKcYCMFYI4bkVVOO1Z3C62
         Y9TYjGjWRat6YYNiVrauYEkp3E7xKxcXhq1aFi1YM5Jws9a0lwRbgaiq0qfIp00M3cwa
         9KrA==
X-Gm-Message-State: AOJu0Ywimsf2vUdlrxS/mNiyst2nTClXTQA7gDdKcgsZmqINwHLCFMRB
	ORKYz8pcpDZjk8sl0tgKUpOdrA==
X-Google-Smtp-Source: AGHT+IGkj80lTOlpVv7cLv0ty3QcpEA/UEzBSdkHRwLlyy2C0DVPD4e+YQqHJcf5zZY1pKqlA911HQ==
X-Received: by 2002:a17:902:aa02:b0:1cf:fe32:634a with SMTP id be2-20020a170902aa0200b001cffe32634amr11199468plb.43.1701436506057;
        Fri, 01 Dec 2023 05:15:06 -0800 (PST)
Received: from 8bdb44144243 ([122.199.31.3])
        by smtp.gmail.com with ESMTPSA id iw1-20020a170903044100b001cf59ad964asm1575312plb.140.2023.12.01.05.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 05:15:05 -0800 (PST)
Date: Fri, 1 Dec 2023 13:14:55 +0000
From: Rudi Heitbaum <rudi@heitbaum.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/112] 6.6.4-rc1 review
Message-ID: <ZWncT50EfYHdJS0x@8bdb44144243>
References: <20231130162140.298098091@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130162140.298098091@linuxfoundation.org>

On Thu, Nov 30, 2023 at 04:20:47PM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.4 release.
> There are 112 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Dec 2023 16:21:18 +0000.
> Anything received after that time might be too late.

Hi Greg,

6.6.4-rc1 tested.

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

