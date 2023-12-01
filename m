Return-Path: <stable+bounces-3677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA895801476
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 21:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4A671C20A30
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 20:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEA84D136;
	Fri,  1 Dec 2023 20:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/uTRaUr"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C821210F3;
	Fri,  1 Dec 2023 12:30:12 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1fada19f3faso577142fac.1;
        Fri, 01 Dec 2023 12:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701462612; x=1702067412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jbNdNNSBQ0EoHwFhwo0aWSCVH17l4EH+UviT2695PgM=;
        b=m/uTRaUrARfaarNV4QbgKijQF1uUYTAdjgTNVfUQctedjCktB242trWFLVuvsBSue+
         Ap3nrodB+ACDHtf0TMQz/NyvqyyZgUyHGXy6sDmcKP7oxt56pcudsyEE1nOM8r4/VaHt
         bunU1MdPro2/wusd0GSnCeZ2GCsFgYoUHf6CDH9GdOAMCvPMZWeeyRz0kItyq5Uw7I+/
         Ice0iotB4wTyveGVibWXDygx6jZcCqVuiwi0VVzFr+m+bPULsk7z0cvVOF64zj78Tlax
         MuaqPfI0Q8HlowURS7X1j4Vvfh1DyJWRPiskDtDemcpBejRST2rJMXcEgHz5Q0mbrFUR
         QrEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701462612; x=1702067412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jbNdNNSBQ0EoHwFhwo0aWSCVH17l4EH+UviT2695PgM=;
        b=Q6a+v69oDUuAqWKj9b9Munoi9pDLqbBNwMIrKh8M0MvCncpF3c6akNcgUlSNRCWzkP
         95x26jyHiP/mXyPcgIE57vyfYs2G7GUpy8bXjdwFflZtmujNBgHFhUpk8KNznpJEw53G
         niiNvzyMj1uQxR5x/o9U0Z+X3jk8wH/QFYgMi4vE4P7BduhRD15rVLgj9o/opiIlRktw
         UKSP6Pok7YasITmlimRclS6SOiq2oShJgSNk6246KcjISokt1I+1jQjeU+Hx1w0m7hL3
         uiP1kSax9CoZ1Wdcpemx4LVfSAVBqIMgsuY1dSfURxaXF23oADqmo3tGPJk3ktAkssL5
         zu5A==
X-Gm-Message-State: AOJu0YwH8IDUbV4z8ZX8uQvLfJdqSUsZ3MLHWNUnGz6xMLfVi3UZhNa6
	Gas4KRMeV2QBe4WNdlbGv+U=
X-Google-Smtp-Source: AGHT+IHc/dk/fvx9Ez1ghD8BsxT77tMOmxBBAZ5MHiA7fDEeP8EmpnI7V2Xfc84OoIG7qPwE67CSkg==
X-Received: by 2002:a05:6870:168e:b0:1fa:f20f:de3e with SMTP id j14-20020a056870168e00b001faf20fde3emr134514oae.54.1701462611758;
        Fri, 01 Dec 2023 12:30:11 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id qx2-20020a056871600200b001fac77ee907sm598790oab.33.2023.12.01.12.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 12:30:10 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 1 Dec 2023 12:30:09 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 5.15 00/68] 5.15.141-rc2 review
Message-ID: <2c816cf8-91f4-4e53-b4fb-654bab9dee49@roeck-us.net>
References: <20231201082345.123842367@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201082345.123842367@linuxfoundation.org>

On Fri, Dec 01, 2023 at 08:25:54AM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.141 release.
> There are 68 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 03 Dec 2023 08:23:33 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 158 pass: 158 fail: 0
Qemu test results:
	total: 509 pass: 509 fail: 0

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter

