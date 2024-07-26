Return-Path: <stable+bounces-61876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8BB93D36C
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 14:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97C6B1F223E9
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 12:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77A217BB17;
	Fri, 26 Jul 2024 12:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=heitbaum.com header.i=@heitbaum.com header.b="Xt4lDSCQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D5517B40C
	for <stable@vger.kernel.org>; Fri, 26 Jul 2024 12:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721998045; cv=none; b=T3jgvwuIR5d7Q3HWBJDhD7rd5vcAr3T3s4D1JBNww4kwltwwzrH8HzpcXzkf2gS9lmFGslMBRN276aDbUvf2IBri3L+NCWWPDMer5hzpmrvpNx6GfpUOLuGCiYRcy/iaZT+9cfrHSWLikI1uS0AX14Qar6PuIFNp/RCZFPGSbhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721998045; c=relaxed/simple;
	bh=AyDcpglcnAZJu8d4p/qX2MF2idreXS8s4AoxvlcBbZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dT6/LZhc7eqGI2yBIF0dbMpp2FyhoEPWeG/ZuE9PlEyvn4qoepQg49iNTEzYqxo/i/H80Il9Pf5u7CxprO6PbhVJMbLpYTAsUMOCDfzS5CexZNp3zbh6/ZGHGK8PjAx3IIMQ5nSGUNj9u8EE80SHhtpkt2iXZiL/Zr/TtkE2Ulk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heitbaum.com; spf=pass smtp.mailfrom=heitbaum.com; dkim=pass (1024-bit key) header.d=heitbaum.com header.i=@heitbaum.com header.b=Xt4lDSCQ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heitbaum.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heitbaum.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fc56fd4de1so4262445ad.0
        for <stable@vger.kernel.org>; Fri, 26 Jul 2024 05:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google; t=1721998041; x=1722602841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8l8joD/B/Ny0D69O5QWhryzHOxOF9XKcR1JNT/d3NAw=;
        b=Xt4lDSCQ0ViLZ1kNO5TXqF/B/ngLPZO5FP9Y8qFFcBFfM66DNGREPtkoRz0MPDNbVA
         GzQZMIvaVX6RykqRbSEBB5YNL5BZrjhNZEDaVtyf2u0Uhe67oJvb7GYRi14mT38cKASk
         yeBa7DkKqogxHXMt2PLY8HKRPnehCWnCfeg4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721998041; x=1722602841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8l8joD/B/Ny0D69O5QWhryzHOxOF9XKcR1JNT/d3NAw=;
        b=Iwrurxr5i6Hy03N+wB3fX5MT12+CopskpMi/jAOl4T8qfBmtZTOAY4cVT8cjWL6iVU
         V7BYDOC9zLthakBhPUiSRCpEvbfVSinq1RQDlcfHjaoYEVW77y09DF7FsortjvL3v6Uo
         i4I/DQ5qhqiBjn9BdFc9v71BzZEynfFD479S9srUd43tavJqBvT82VS88jclk2jbhpJR
         HrB5Mb8KWm3Mzi3fnTIZXeUJKVnriYAYhZrapHMoDsyKXIdLxavs4vMxa/7KSckN72tN
         J7XYkbmDUJXbMfC7C9ButErqhoEtu4fxOk7JObxd71ToPQshtpjfqaLnymZTfwYp/N7X
         tFlw==
X-Gm-Message-State: AOJu0Yzjdrtc2a5h301m+1M3V25KKud738iiVz6RR7OXqFA/8lwzIvBZ
	rtnxSGLRt2GNVkz8tjUu535F69182DV949N9Ck1hxrKB8ImbzWZM+ZqYcfqXxUY=
X-Google-Smtp-Source: AGHT+IFKQK0LMOyyZckLxck2QvcJ6V4ue+gRwuncvfh5n1T2VrUXoDHQ2luoru6Zafq5PoTw0Wx+Ew==
X-Received: by 2002:a17:902:d4cf:b0:1fd:d4c4:362a with SMTP id d9443c01a7336-1fdd6e25be0mr129047395ad.24.1721998040930;
        Fri, 26 Jul 2024 05:47:20 -0700 (PDT)
Received: from 536e1befedf2 ([122.199.11.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee8177sm31287905ad.124.2024.07.26.05.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 05:47:20 -0700 (PDT)
Date: Fri, 26 Jul 2024 12:47:12 +0000
From: Rudi Heitbaum <rudi@heitbaum.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.10 00/29] 6.10.2-rc1 review
Message-ID: <ZqOa0HvI80LrQJfL@536e1befedf2>
References: <20240725142731.814288796@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725142731.814288796@linuxfoundation.org>

On Thu, Jul 25, 2024 at 04:36:16PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.2 release.
> There are 29 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 27 Jul 2024 14:27:16 +0000.
> Anything received after that time might be too late.

Hi Greg,

6.10.2-rc1 tested.

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

