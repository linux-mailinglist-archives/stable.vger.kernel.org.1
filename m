Return-Path: <stable+bounces-2793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABEB7FA88E
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 19:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C9D51C20B70
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 18:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF06E3BB43;
	Mon, 27 Nov 2023 18:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2417bYZA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JQtmTrdx"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1984F18B;
	Mon, 27 Nov 2023 10:05:55 -0800 (PST)
Date: Mon, 27 Nov 2023 19:05:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1701108353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dbq4OQoSfWFS9FgkbZcpJ5aq/YAe/Q1LrLucoLiHihQ=;
	b=2417bYZANSH6L6nmlzSRn4yRZ74XrgOs/DgfazV7+JV6X0M71yzFL39JTQXnkP/AypgyA7
	jICjgyy9Ei5gDoDIdTMcVQODm4nEF5jGzWUDmb8cxa9pETnam0LWVcsH5hAiVD8/xm79bK
	kH5R+RTdM2LtpfV1egRCgiGvMicGjaEoqvR6Psn9rBNnMZoA3A2ytnxtPsFI5lu6+8yuWW
	51EJHZe7wWCdgYTkMjYY8LC2qvciUgaThnjwZPtUNHjzq1VNJNZYAjUZRRvZMliZ2SG6Cs
	JXcx5HCLEXcoHbzxeRbSQrHk1Wg7MMkbd8NdpIn4CxctntWA0iZ2O9kTlBJaZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1701108353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dbq4OQoSfWFS9FgkbZcpJ5aq/YAe/Q1LrLucoLiHihQ=;
	b=JQtmTrdxhC6FHw2bTrRQR95o9DQ6Q7hjyEp1A9J6BEsr8zi/2N740nkGg9PXXCHI5OkMUu
	rrCtaCiUylGIX+Bw==
From: Nam Cao <namcao@linutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.5 000/483] 6.5.13-rc4 review
Message-ID: <20231127180526.p8eeyOL1@linutronix.de>
References: <20231126154413.975493975@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126154413.975493975@linuxfoundation.org>

On Sun, Nov 26, 2023 at 03:47:04PM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.13 release.
> There are 483 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 28 Nov 2023 15:43:06 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.13-rc4.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Noticed no problem with qemu riscv64:

Tested-by: Nam Cao <namcao@linutronix.de>

Best regards,
Nam

