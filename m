Return-Path: <stable+bounces-2794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD7D7FA8A6
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 19:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4239A281757
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 18:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665CC3BB4E;
	Mon, 27 Nov 2023 18:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iKUe7lS+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ckI9tv5b"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BF5198;
	Mon, 27 Nov 2023 10:13:17 -0800 (PST)
Date: Mon, 27 Nov 2023 19:13:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1701108796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v5NyQGF45mYqImvmQ3ULjobI6ABngkvPGQ8K288LfVM=;
	b=iKUe7lS+JD1/Ss8mKcJXw1lDZRDVbV9NCkGEO7fkFSsthvrE62e4FK3lHezBOhL6PJm54E
	G+QW7plJOfem/NXSJlx4ib4f0L9xWc87x8e/hJkU0CiZBW1iP2w9KWvJcOFNRzF5pyU7Mu
	GBvuZUQ1k3gcoAgeq81EHUnPl0TL32b3mKFBv/M3LfTlKFa53lX2Kc//ToQ2ubAZQUf0lZ
	f/6KLCY3LqU5+bJXaYbIw+pNBT+jViTYH/HXqaZM8IL7NCfnWqb/bkT5417w9/fJqSS/hx
	7t7HGygM+URBHdfzvNq0vzIMktUqEIAitu/xJbB9yXeEr//Bc8Dg2VuRdZrcTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1701108796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v5NyQGF45mYqImvmQ3ULjobI6ABngkvPGQ8K288LfVM=;
	b=ckI9tv5bNdT5QEAEElpBLTb+iYzGmuTa7z+vyGEe7Fxt0+1DwPB96SZDo/RtJjxcg3u1zD
	0gEWy+r5SHMODWCQ==
From: Nam Cao <namcao@linutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 000/366] 6.1.64-rc4 review
Message-ID: <20231127181311.1FFxgWty@linutronix.de>
References: <20231126154359.953633996@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126154359.953633996@linuxfoundation.org>

On Sun, Nov 26, 2023 at 03:46:28PM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.64 release.
> There are 366 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 28 Nov 2023 15:43:06 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.64-rc4.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Build and boot successful with qemu riscv64:

Tested-by: Nam Cao <namcao@linutronix.de>

Best regards,
Nam

