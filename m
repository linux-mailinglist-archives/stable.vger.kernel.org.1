Return-Path: <stable+bounces-6477-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A155780F3E5
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 18:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42361B20C48
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 17:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9167B3C7;
	Tue, 12 Dec 2023 17:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8OubeDc"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884AAE3;
	Tue, 12 Dec 2023 09:01:24 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1fb04b2251bso4286940fac.0;
        Tue, 12 Dec 2023 09:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702400484; x=1703005284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3FhVzYWda/1YKc/fSv1uyXT3s6nzoViCVsvqyIDm9fA=;
        b=J8OubeDcEctdi5EJywGw9TKq/YzNa0+myW2yxzMayTzbSccD4ijh7DQiGPuKODQ00P
         9VyuFkUZ1iUE/x+B2zARxL9qt7F8P+MdRI+8AqjUYCtP8slxETWbebHUQDDAr/auIbi2
         hMwBPbGDD0e9w74G2HkdB0IOAQtgCsESwiFFUp5srPMV7HCrSHVx53RJ16MoXsAANfuX
         qy/t1UePvcjl3ykE3Rv9evDH35daOVTKB0nm3AWD40I2Q6AYLFkkr0VtZ3U5lyxrnLBl
         LKxr8i0W7s6ERPT6L2FleDfIUTzKPjPwjZ4JXiP7xMIZd3HNeY7ItBpaxpc9mE6HL3G5
         cREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702400484; x=1703005284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3FhVzYWda/1YKc/fSv1uyXT3s6nzoViCVsvqyIDm9fA=;
        b=lYZ7RQehi6K/qwrn6QLIv6qHVsxI8DZM42Eu0ZIpW5HdWHKSPH8bcktyBct4EPAHGv
         NdurcoKEVSB5RXEzcnavy7HzdxnlWEXyPDCLm64edmijMgeoVtPHHD4CEv6AhJOkGaQT
         r1EpYV5h+M6PV7vArEbRCRXtV+4grE3eLDeBxvdYf6YncgwWL1ZSQZ/uAirJKQ24Lmfo
         jP+XT87YSXeXfhMPUZNHBEpYFyBikWrcKxkAJRHhHgGF/9xWO5CE0vkhJSmqmkmC24kK
         xL9SQWhgTbQPKHX0WakMDJbE0sL9dqr02Z1W48OnNWUbJLTpL5sBCDeF0Xg4bD0skSOP
         XWew==
X-Gm-Message-State: AOJu0YwCf7eS9tFwrpnKwO5ZS3RejGCJ+fxXwAnEn+FhE1Dlghrl/8HV
	O21AN7FQT138+XQi9S6zI7c=
X-Google-Smtp-Source: AGHT+IFGQtN+ItUbfxXhZIMFm4LB9DC+KDHLOiUSUrfESB+fKdBZbBDRdNSBSqdGz8U2dG6mdmvS1g==
X-Received: by 2002:a05:6870:700a:b0:1fb:75a:de58 with SMTP id u10-20020a056870700a00b001fb075ade58mr7982583oae.70.1702400483727;
        Tue, 12 Dec 2023 09:01:23 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k29-20020a05687022dd00b001fb0edac63csm3267075oaf.6.2023.12.12.09.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 09:01:23 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 12 Dec 2023 09:01:22 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 5.10 00/97] 5.10.204-rc1 review
Message-ID: <687d692f-389d-4990-b678-7486c6b7ff4a@roeck-us.net>
References: <20231211182019.802717483@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211182019.802717483@linuxfoundation.org>

On Mon, Dec 11, 2023 at 07:21:03PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.204 release.
> There are 97 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
> Anything received after that time might be too late.

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 495 pass: 495 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

