Return-Path: <stable+bounces-6478-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3CB80F3E9
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 18:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B315F281C59
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 17:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A5C7B3BA;
	Tue, 12 Dec 2023 17:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgsmPJ9I"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DBF95;
	Tue, 12 Dec 2023 09:02:15 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1fb37f25399so3765595fac.1;
        Tue, 12 Dec 2023 09:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702400535; x=1703005335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qoqQk2DmNjPGewPO9m1lqeM/IXVqiFBd3DSgwHMPKp8=;
        b=TgsmPJ9IAPwrv5HPvPhG7o5o7671I00ltCnlLgdPMrS034Li/kQTtsmDwsItzAPU+t
         rnd08J64q4Q8StECnkOPvoL/cFmJY7W1O+zy2Zzto1rf+kVPWFVDJrU6E6QrsVGFWK49
         bmstD8pZOWy9suhPAfpgDesK/5G9Xi+CzQhB/AOUxXIHpkQh2LjXiefEHVjOEAjbTTTv
         e+tCV8exmiBccSO/Z+uWIaOGvwskiqRESh1n2QA8/U0ezb/VpR0M8ypvrbYA7ydYCjPU
         uzDGnWQbUggzqvKQnMXIYC5PjfAsgviz8vVyFusCLNSNO9VPy60oD+gtID4MJbEWh1sX
         a5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702400535; x=1703005335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qoqQk2DmNjPGewPO9m1lqeM/IXVqiFBd3DSgwHMPKp8=;
        b=bBxomti1ec6rqsPFYZomZDz6Xpb0NK/Ums8Ud2JF/mH7vOcoG6iCsgHGEhFTR0qJ9x
         6Sj2x1H5nJEsPUrUWBbUVa1jjCUAgzlbZbkovMi6lOcOJtskBUNbSTtAh4FbpcxnI1zA
         z+HsFTaLroJHsVKFiLlDS7oTpZLpkr9+6y1JMKVK6el6cObmv8REJrx8AUDbZ1XS/AY6
         HAl+IAiAsl/aox+9F/ty8MUYS5pEKFPacCyDvQZPEM9AlF0uWoJTutb5BcHRVfShMemm
         e+uxe90GXlH5x4zT8PTiQxwX22fkGnkoVuC1mKa/BOm7njvQxbbDZqIhmhiFSDSyinp2
         JVpQ==
X-Gm-Message-State: AOJu0Yx9fKuVWSGPFk7ywbwEeT0QpRtxfLyWB+YFtY82OiDFq9VxH6cB
	/SricxZON7QbEXNrlONioHw=
X-Google-Smtp-Source: AGHT+IF4r5BEwMRI4su0cbkDOAvMvmsdh67c/77qUVUOdyEitoEGMI1BoCTbktLSy9vPBysa16GYxg==
X-Received: by 2002:a05:6870:e98d:b0:1fb:1f51:e7f3 with SMTP id r13-20020a056870e98d00b001fb1f51e7f3mr5842413oao.39.1702400534905;
        Tue, 12 Dec 2023 09:02:14 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id gy16-20020a056870289000b001fb1bf9f5ddsm3297150oab.21.2023.12.12.09.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 09:02:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 12 Dec 2023 09:02:13 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/244] 6.6.7-rc1 review
Message-ID: <7962c895-674f-41c8-a7b2-3b0ec2c19e0d@roeck-us.net>
References: <20231211182045.784881756@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211182045.784881756@linuxfoundation.org>

On Mon, Dec 11, 2023 at 07:18:13PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.7 release.
> There are 244 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 546 pass: 546 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

