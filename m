Return-Path: <stable+bounces-161426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BF3AFE6CC
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 13:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A184D1BC0CE3
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 11:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9769328DB50;
	Wed,  9 Jul 2025 11:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dMhAddBt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AC2262D0C;
	Wed,  9 Jul 2025 11:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752058919; cv=none; b=SOt0WJupVSduK2C1xM9E5BvnxQqJ+vjRBPqBPMtKCR8eilF/8n2RwX1BQlaKuRnu6EkBdY+9X7AzErn6JObRZtbqg71mSA7VHCcQwJO5U2116SdRhAeT6hkzXSWJh5VkEcPBW4UXWEdJfTwQ4ZpQuO/CDHoq4V8aTj3XbRyl76c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752058919; c=relaxed/simple;
	bh=gc4HSCuDDXMYHWvKvmPjisGfE43XmLIbYsjIXa3JOUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W25ONsKL5Z0TiClGZJhpLfyqO8QQuCbQiU6SLJSvURj8F1fGAFYXCXupEO2NSfkmz8AV7ewrvHFMqbzZm7l2Lf5EnjcfTw8CLHGrXuAzGmJcb1Fb84yB8rMrmhkEy0o0b6eJRTrayjXT90ouoUFxBmeptgrrnqVMOPm3+T4sacs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dMhAddBt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12EA4C4CEEF;
	Wed,  9 Jul 2025 11:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752058918;
	bh=gc4HSCuDDXMYHWvKvmPjisGfE43XmLIbYsjIXa3JOUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dMhAddBtYzYy7yQWFvVtz0cvZmFHy2Sl0Yn6xJDUT5n/0XRqHTD8zmpABnZZtPybY
	 NVo6bfiHJDk2ApmVmvVTKRykrns9tj+qbPoFosT8PNZLMdBS9S792Wvv9VR+mZ4ASh
	 GUZqVle1Qrz0kEW4G2ZqGSJCyxgbGdWJeq2M+aWY=
Date: Wed, 9 Jul 2025 13:01:56 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: linux-serial@vger.kernel.or, open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	linux-stable <stable@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>,
	Aidan Stewart <astewart@tektelic.com>,
	Jakub Lewalski <jakub.lewalski@nokia.com>,
	Fabio Estevam <festevam@gmail.com>,
	Anders Roxell <anders.roxell@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Ben Copeland <benjamin.copeland@linaro.org>
Subject: Re: v6.16-rc5: ttys: auto login failed Login incorrect
Message-ID: <2025070924-slurp-monetary-a53f@gregkh>
References: <CA+G9fYtK2TLbpo-NE-KUXEp0y8+5zXNVRFkqdMjaGgcNFFG77g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtK2TLbpo-NE-KUXEp0y8+5zXNVRFkqdMjaGgcNFFG77g@mail.gmail.com>

On Wed, Jul 09, 2025 at 04:26:53PM +0530, Naresh Kamboju wrote:
> Approximately 20% of devices are experiencing intermittent boot failures
> with this kernel version. The issue appears to be related to auto login
> failures, where an incorrect password is being detected on the serial
> console during the login process.
> 
> This intermittent regression is noticed on stable-rc 6.15.5-rc2 and
> Linux mainline master v6.16-rc5. This regressions is only specific
> to the devices not on the qemu's.
> 
> Test environments:
>  - dragonboard-410c
>  - dragonboard-845c
>  - e850-96
>  - juno-r2
>  - rk3399-rock-pi-4b
>  - x86
> 
> Regression Analysis:
> - New regression? Yes
> - Reproducibility? 20% only
> 
> Test regression: 6.15.5-rc2 v6.16-rc5 auto login failed Login incorrect
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> ## log in problem
> 
> runner-ns46nmmj-project-40964107-concurrent-0 login: #
> Password:
> Login incorrect
> runner-ns46nmmj-project-40964107-concurrent-0 login:
> 
> ## Investigation
> The following three patches were reverted and the system was re-tested.
> The previously reported issues are no longer observed after applying the
> reverts.
> 
> serial: imx: Restore original RXTL for console to fix data loss
>     commit f23c52aafb1675ab1d1f46914556d8e29cbbf7b3 upstream.
> 
> serial: core: restore of_node information in sysfs
>     commit d36f0e9a0002f04f4d6dd9be908d58fe5bd3a279 upstream.
> 
> tty: serial: uartlite: register uart driver in init
>     [ Upstream commit 6bd697b5fc39fd24e2aa418c7b7d14469f550a93 ]


As stated before, those are 3 totally independent changes.  Any chance
you can nail this down to just one of the above?

thanks,

greg k-h

