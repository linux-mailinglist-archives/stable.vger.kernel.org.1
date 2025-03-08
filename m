Return-Path: <stable+bounces-121551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C57BFA57CC3
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 19:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A33003ABC7C
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 18:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9671E8337;
	Sat,  8 Mar 2025 18:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBAFJT45"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6462314A8B;
	Sat,  8 Mar 2025 18:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741458283; cv=none; b=iBrgfVEZZ5vephWpue59YS22ZUlbi4N53Qb9nlbAsumEPYYHwcaejJAKXWdwYuy69YqHsViMh2WqTh/8gqxC//hd8biVhkLiNDimZqjjpycHHlNgwR5luNv+KdQELTdBQMoFRUMZ+fVzUjN8vx8BACwYIfn4MDNZbUcearGZNW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741458283; c=relaxed/simple;
	bh=Ex91Fnzm2pOZxAoz7jFo9ArugUV39OZ5TQsj2eALoPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCyjYlkqvp5hiam9ZSOHrpsMIocTh9PUCZCdnlgIIV97xZUuYFJFooky/bxF1n1W1ZFNf4p6fxk6xGO1+/7riNlChEGWtfic8WgC+OKTY4C/NCrTp4oAOtqa4A2QmBPO5mJTFcoefz9tYMDzu3K2EB1ReAKo6eS7QMNEfHIwl54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBAFJT45; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2239aa5da08so46861585ad.3;
        Sat, 08 Mar 2025 10:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741458279; x=1742063079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mD5I6E5iqsSGKDuW5ALiPqqhXMadeoFBk39l810IWd4=;
        b=aBAFJT45Hncn349NWr8p9PQURsdEVpXlvVzDdRO9cPV8OARY3UwFIkpOj0gaQngt38
         Unrndfgs0NvoCSNHqc4YhxYGCkTBbBnb9D24Pst8DWTtlP9lFQo90hU302Iu9Bj5QJ12
         boQV059EfXAKOHvFzyeJ/5HGoM1HhXS62awE2eENA5Ren1CWoH3HXe+AP0FTtL7k5PiD
         0Mk7xsN1tXCxFQC+RVeT4a8Myho/9A1ARUz2iGam8XYxnyim6qG3u4FZezCBQDfXNQvC
         LyeE6BdD6m+E3uFSeQtnAtMId02Tyha2RdrC0TwPhfXcVpmNWdxJmLREtmm+58aB3tfH
         zFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741458279; x=1742063079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mD5I6E5iqsSGKDuW5ALiPqqhXMadeoFBk39l810IWd4=;
        b=b5LCHqdQph8/FZsbKOvxhmALgA7n2HxioB3SCqR83cDJJylo8HymV04myHhG4HSc9n
         IX0ddOGWEzjotxoXsSxBbVfui6YW4sY9egGBhGToUEaobVocP02s+pFSAUA4R68GTlGV
         6F9u8jRAEsNsc67DnKgtScFIwmQvHJ/fI0OQX64aT3Pf/AJwGyHBSKOPe6aK5vkaKdMr
         alNiPFB4GAZhns8Iv+vCuKEIIl0B3VjkFZNIs/dNTonHp5F4TI2u6OqT/mKLBdID8EiZ
         VaW/jRXb315bCjIv7KSC4Ijw8VNSSz4dPgqkksqrpC1FBDpit+BkUr9XsP7zlGMcQhv2
         IcAg==
X-Forwarded-Encrypted: i=1; AJvYcCU/uCNTL3jF9J+ePR4tXChVKKXjTI2LNanhc023SkLJpCdYUFZ6enhr+/q7eIqQv5Jt5mTGU523gDFemfg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz7mDneQ5FiDAgb0+Buz9FcBFKHFBSd8tLMh7vUynsNUQgo2xn
	iP65TZZAnMzyBqCxRlU920EJ7GEinHetBP7mrpxCmQ33nQch4qM7AAkc4Q==
X-Gm-Gg: ASbGncskbXsSjOF0VyPOgqqr3KGnremKCrTvnyM7lB7de/iagtL6IpLuZIKOdquaYGU
	7VLZNN8gxNdAJ852j1jKPYUGmvYQvMBtS6XHXqsE7ybRTw5Z6LLteDpHbOXYSZcRQfAGKJWRfjE
	jXDQGC+41JZuSHWTGewL6C5hc3wcWXA7bAyrfdWZYSwdvuNNnw9K9v3/WPRSVz65TqLQfcXmi6r
	wFXDZ8Isao5CJVaqErH5Of2Tp/TtRLJGttVCtH/ITg3s5kDxHUITMs5tSreWn19V5t5c42tyQD5
	wN+XC0CS7IM6CDx7blm5muS/hLkj9CjUeRw8+Yz5acVFBCNYgGwP51tBqg==
X-Google-Smtp-Source: AGHT+IFIriNfji3U4cU6+vyYKbGBdNwqtnp867yNUQakxaOvbR1n8eOo3teInhy883mWIKgfAF+oyQ==
X-Received: by 2002:a17:903:2405:b0:223:64bb:f657 with SMTP id d9443c01a7336-22428c02a95mr130001765ad.46.1741458279527;
        Sat, 08 Mar 2025 10:24:39 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e9f7bsm49489445ad.80.2025.03.08.10.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 10:24:39 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 8 Mar 2025 10:24:37 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.12 000/148] 6.12.18-rc2 review
Message-ID: <3d99c624-88a8-4a98-b614-7565aa5dc4ba@roeck-us.net>
References: <20250306151415.047855127@linuxfoundation.org>
 <1c813c9d-de04-487c-a350-13577dbdd881@roeck-us.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c813c9d-de04-487c-a350-13577dbdd881@roeck-us.net>

On Sat, Mar 08, 2025 at 07:15:35AM -0800, Guenter Roeck wrote:
> On Thu, Mar 06, 2025 at 04:20:53PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.12.18 release.
> > There are 148 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat, 08 Mar 2025 15:13:38 +0000.
> > Anything received after that time might be too late.
> > 
> v6.12.18:
> 
> Building loongarch:defconfig ... failed
> --------------
> Error log:
> In file included from include/linux/bug.h:5,
>                  from include/linux/thread_info.h:13,
>                  from include/asm-generic/current.h:6,
>                  from ./arch/loongarch/include/generated/asm/current.h:1,
>                  from include/linux/sched.h:12,
>                  from arch/loongarch/kernel/asm-offsets.c:8:
> include/linux/thread_info.h: In function 'check_copy_size':
> arch/loongarch/include/asm/bug.h:47:9: error: implicit declaration of function 'annotate_reachable'
> 
> This is not surprising:
> 
> $ git grep annotate_reachable
> arch/loongarch/include/asm/bug.h:       annotate_reachable();
> 
> Caused by 2cfd0e5084e3 ("objtool: Remove annotate_{,un}reachable()").
> 

The same problem also affects v6.13.6.

Guenter

