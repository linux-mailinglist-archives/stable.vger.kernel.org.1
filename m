Return-Path: <stable+bounces-2553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D677F85C7
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 23:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E29291C20B42
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 22:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AFD3C47D;
	Fri, 24 Nov 2023 22:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EQLq442U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zZvS0vzu"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40522DD;
	Fri, 24 Nov 2023 14:06:23 -0800 (PST)
Date: Fri, 24 Nov 2023 23:06:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1700863581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lYWKtxRcU5OtvShV9MVXedkqLwLEiA10wruWu5tg6y4=;
	b=EQLq442UGtTT/DnnjDkqTXlQiiNsR0bBnLFgSJiH2fVNkQreIt7BSV6qYVrer6J4bFdSB8
	Ouo9K1qlIDcGyZqGlFc30ktEUE071Oe2AVo5bfuCeb98WCu7sjqYNCh5bDu9emE7KDdSAy
	PwyF1c0zQlTPmNxgy5d1o/hqUJIpnURqDhQBgaTlY7GbAP3V5XeX/O4fu1F6fn5FUl5bhY
	KSyOZKnts6gH18nyV+tcky1ApazGKbfsCVBLhVLMIXeNxIa9cvnSv1gMaOe5k/m9cC9rJH
	4NXUGiuMOV2WWewEi6m0kA5oWaAZZy5khnfKGO/peMmYGno/exJGZpXfDaik1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1700863581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lYWKtxRcU5OtvShV9MVXedkqLwLEiA10wruWu5tg6y4=;
	b=zZvS0vzuzH+La0XV7q4a47WiYqqYw+neRHd0ZuEDS44yCC/aafCpv44B1tZgS6raa+X66X
	XtPGt/29k30/xRDQ==
From: Nam Cao <namcao@linutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org
Subject: Re: [PATCH 6.5 000/491] 6.5.13-rc1 review
Message-ID: <20231124220617.l5Rx1XH4@linutronix.de>
References: <20231124172024.664207345@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>

On Fri, Nov 24, 2023 at 05:43:56PM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.13 release.
> There are 491 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 26 Nov 2023 17:19:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.13-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Noticed no problem with qemu-system-riscv64:

Tested-by: Nam Cao <namcao@linutronix.de>

Best regards,
Nam

