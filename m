Return-Path: <stable+bounces-7844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AB8817F1F
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 02:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E75141F229D5
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 01:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28857FB;
	Tue, 19 Dec 2023 01:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PIz9b1EH"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F7110E6;
	Tue, 19 Dec 2023 01:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1131)
	id B4DC9208A7FD; Mon, 18 Dec 2023 17:05:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B4DC9208A7FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1702947928;
	bh=2RWmgZua3mam8qu8Wy28PQBrZ4o1/o9rVFWO5Y+a2Pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PIz9b1EH/yUCoicK0m4/Xv3XQzACOi10z/gro2esg/xelEy4Ojhdh2/eDZwOcCnpk
	 ziacp6xU0hyh+Mt1ruH2MXU5LedmhaJanGTF8cViJq9BHXKjfQ3rImUZ5WWSCwkqCy
	 ob6gcHa/Sp8EVGV97SmYa2gOiOherXUMoqLAnpYU=
Date: Mon, 18 Dec 2023 17:05:28 -0800
From: Kelsey Steele <kelseysteele@linux.microsoft.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 5.15 00/83] 5.15.144-rc1 review
Message-ID: <20231219010528.GA15952@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20231218135049.738602288@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218135049.738602288@linuxfoundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Dec 18, 2023 at 02:51:21PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.144 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 20 Dec 2023 13:50:31 +0000.
> Anything received after that time might be too late.

No regressions found on WSL (x86 and arm64).

Built, booted, and reviewed dmesg.

Thank you.

Tested-by: Kelsey Steele <kelseysteele@linux.microsoft.com> 

