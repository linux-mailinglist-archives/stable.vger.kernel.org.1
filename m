Return-Path: <stable+bounces-2551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F21D17F85B3
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 22:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F9271C20B14
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 21:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C8C3C088;
	Fri, 24 Nov 2023 21:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YNNmlLvk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GiGqa24U"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41FF1987;
	Fri, 24 Nov 2023 13:58:00 -0800 (PST)
Date: Fri, 24 Nov 2023 22:57:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1700863078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rSTUC3Op/EFAq9YtNWIi3KTCQElfEX0irM5VEDsNnSE=;
	b=YNNmlLvkv+GbxwoQj22Nn6OsTCcCbBq2BKTtaZpYwn51Ai/9w4IVfLiNFJqX5QlbVuowvU
	hnZjBTHtDcA4fT8Gr/FWeD/lrVo6zTv2nKDIy74d4S8PPLMNtqGYz9r5ePjXTtaRXZ1Sg/
	g7HfHq7hAErHEHiXVh4FmEP/a5yjYCLKjzK0Ja+k0LJ2fafBaoch2odym54FpxBjc2ET+P
	jYEv10D9wJMuui7lskOuBZnarfaixKtpoYoHCsjbBc/dN2VUDdsNzndazAVfHhSrWeyMnW
	/GeBBBL0x50LqgABCUxgY/bwSMHMjRFYUzk5ofV+SGi2GC2zToOaf3gy8ir1wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1700863078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rSTUC3Op/EFAq9YtNWIi3KTCQElfEX0irM5VEDsNnSE=;
	b=GiGqa24UcQfccaOabdJHe8AgdVxCXDpKNWsm/vl34occyRzjdGShO0xaolEQ63yVGh/hi9
	SHucaEK1NpuNbKAQ==
From: Nam Cao <namcao@linutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org
Subject: Re: [PATCH 6.6 000/530] 6.6.3-rc1 review
Message-ID: <20231124215753.CGLbt4PG@linutronix.de>
References: <20231124172028.107505484@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>

On Fri, Nov 24, 2023 at 05:42:46PM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.3 release.
> There are 530 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 26 Nov 2023 17:19:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
 
Noticed no problem on my Starfive Visionfive 2 board (RISCV):

Tested-by: Nam Cao <namcao@linutronix.de>

Best regards,
Nam

