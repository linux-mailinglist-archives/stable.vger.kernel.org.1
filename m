Return-Path: <stable+bounces-4714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52566805A37
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 17:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FFD81C21243
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 16:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CE755C1F;
	Tue,  5 Dec 2023 16:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+OksTBB"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9703E12C;
	Tue,  5 Dec 2023 08:44:43 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-58e238b654fso1071102eaf.2;
        Tue, 05 Dec 2023 08:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701794683; x=1702399483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=66trihcq0zl6sdBww2Rlr95fZrHC76YJZk2mPSlTty4=;
        b=j+OksTBBXKaepzOmQuY5ERIt2wF/aJJvXXpW/DyWIxeg7IUybXLxioufYBfmU+9w8Q
         4lHEW99Td3tZ1KOhPGI2944Xv97o8JWS0i6RpgFhJbpmCBExShaOGfzv/EkUQZAygjNO
         rV+vTOXL3/BZwQpL7bDWnaSzD+GcRmWBmCmcY5jN0Ds5XhtkQmB19ptmXPymLm6X6IHW
         557kM6QLifqbRZMLmjxgig7DoNTQE6fwBKgLmjRteL/Xo2Y1ul4MzCHBjSA9lZQaymgL
         PypUgq3iXQY+VRXipscRyyq36ZebZ3KssKS4mFgUQqF31LSVDl26MnOieOxK6fawEJ92
         rUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701794683; x=1702399483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=66trihcq0zl6sdBww2Rlr95fZrHC76YJZk2mPSlTty4=;
        b=jr5VZ60UjU4n5Te7I+p9Et8MrmuRqLke9ESZVohDjBJeGT7Zp0rtfg3WwMBTQYmxWR
         ZbTX494sJLwMHZYwxn3r1jiyxM6kGVSXvtQrEClRXuCms3xjYbHK/YhYSyGQzX4IMjBu
         PHWmr4wtsU/f7wCW8mhMiYg/QqaQVcPeP8QnYjUOJHtylI9StOgy7Dhgs4sf1xbQVDSE
         r6UCfDUJSOjqpEu+4WP8x0G7CKdVOWqEyfjnCtDcBifWmH1vl0oQ+Gebp6M898Cfat1M
         1jx5AzHo3TauGByXBex787vPflUXFsB77gHUpoWcUwKN1bN876jmuBrB3+EwV+g2hpz7
         bKuA==
X-Gm-Message-State: AOJu0Yy32CfG16IZuhNrNxJanHaLlbIzLHCQMWDEQ/3AsEVAuTMTqm6L
	789awO+7Xp/+qNwTmuw+kKs=
X-Google-Smtp-Source: AGHT+IEzZb6Bldz+nyaGHnbOJgHdRm3EIq2ygKWuydiC0xBSuHl0DRoapcQTN+i0aFlNFH6mragYaQ==
X-Received: by 2002:a05:6820:814:b0:58d:5afa:b79d with SMTP id bg20-20020a056820081400b0058d5afab79dmr4427015oob.1.1701794682847;
        Tue, 05 Dec 2023 08:44:42 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k29-20020a4a311d000000b005902414710bsm680866ooa.6.2023.12.05.08.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 08:44:42 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 5 Dec 2023 08:44:41 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 4.19 00/71] 4.19.301-rc1 review
Message-ID: <00cbc776-a02b-4b1d-b1f9-f75dc119018a@roeck-us.net>
References: <20231205031517.859409664@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205031517.859409664@linuxfoundation.org>

On Tue, Dec 05, 2023 at 12:15:58PM +0900, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.301 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 147 pass: 147 fail: 0
Qemu test results:
	total: 439 pass: 439 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

