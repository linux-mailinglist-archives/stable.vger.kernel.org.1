Return-Path: <stable+bounces-100633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1CF9ECF5B
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6D34188BD0B
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 15:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B3D194A67;
	Wed, 11 Dec 2024 15:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dwUGHTIF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0D6246345;
	Wed, 11 Dec 2024 15:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733929547; cv=none; b=AeszTa6Gf9lN5UmY9HfTkrhIUGaUBQSsV1BpY+FTuOu5yc4hUwpYbV8AbPELCCjWUJ4tGmb0ZbJbRLUnZTyz29lMCsulWjePU3uLAsvkOUWv7Hq/k8HdwgJjK6BaPer3WgnwgxYahVjGmObyDGbPdnRMfIQta8/kxU4UHDK5VHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733929547; c=relaxed/simple;
	bh=Xn1bRBCrBZyfsMfTclG8G1ekwObh2rzI4N3qryEVgBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tW+oBn3gUYNxrrASlcq3z6wbYmITRp6cEwW9dvMU/LqcKikJsWcAHl677Z0lqcGcs1gM1VvbdaEDe3g1OkDr9gfNcF+2XC0vJMAImGSSG/+d5Kszd7KOdarbE2uUtwcw8vLsSOQqkbac7WOpXc1euG8xJnSbNC5FHrNEUblFBSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dwUGHTIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA20BC4CED2;
	Wed, 11 Dec 2024 15:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733929547;
	bh=Xn1bRBCrBZyfsMfTclG8G1ekwObh2rzI4N3qryEVgBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dwUGHTIF/xKuArd1deUS5GFuta1yLbITmLzhSaFv889t08SCznjaHVU0fuPRKfjKL
	 O38dd+ngx9U5p8IhjRZJf6/30IE88Tm/MNyVay8gqTdTjyM267MVUmi3DrifbxqtX7
	 9XbYqgALmQTuOy24tIE9bhKsszUL2HBVXgsfA03U=
Date: Wed, 11 Dec 2024 16:05:44 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org,
	Stafford Horne <shorne@gmail.com>
Subject: Re: [PATCH 6.6 000/676] 6.6.64-rc1 review
Message-ID: <2024121138-skyrocket-online-3fda@gregkh>
References: <20241206143653.344873888@linuxfoundation.org>
 <e05374de-a45d-46b6-9ac2-a4aba932c6d2@roeck-us.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e05374de-a45d-46b6-9ac2-a4aba932c6d2@roeck-us.net>

On Tue, Dec 10, 2024 at 02:01:56AM -0800, Guenter Roeck wrote:
> On 12/6/24 06:26, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.6.64 release.
> > There are 676 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun, 08 Dec 2024 14:34:52 +0000.
> > Anything received after that time might be too late.
> > 
> 
> Building openrisc:defconfig ... failed
> --------------
> Error log:
> drivers/tty/serial/earlycon.c: In function 'earlycon_map':
> drivers/tty/serial/earlycon.c:43:9: error: implicit declaration of function 'set_fixmap_io'
> 
> Bisect points to:
> 
> > Stafford Horne <shorne@gmail.com>
> >      openrisc: Implement fixmap to fix earlycon
> > 
> 
> Applying commit 7f1e2fc49348 ("openrisc: Use asm-generic's version of
> fix_to_virt() & virt_to_fix()") fixes the problem because it adds the missing
> "#include <asm-generic/fixmap.h>" to arch/openrisc/include/asm/fixmap.h.

Thanks, now queued up.

greg k-h

