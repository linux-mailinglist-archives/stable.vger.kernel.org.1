Return-Path: <stable+bounces-104003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B83A9F0A93
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 12:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C68A2813DF
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 11:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD011DB34B;
	Fri, 13 Dec 2024 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kmaRwMMW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931AA1CEAD6;
	Fri, 13 Dec 2024 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734088453; cv=none; b=CvChmeLu919Ewb8jaL3N+FcgGTpuLZWbk49yy8uSlldC3npjW0aY3xCwvbYqvNRKslaIduuGz2OcED16VibAEUAmjHpn/Ly/tHfb+JHbMc8bolyqwGePv5IkTdi6pkql3SDJEG744HR9RSl1ragCrEWbVwrml7v7Cfdaj0hQOjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734088453; c=relaxed/simple;
	bh=6646rlh+vU0geIq1jRDLfASPiHXhYsJuMUx/KA8ipK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Db22dDSxrTg54B9GUncW5Fhv1fWIuhyZgHWgQrDbEkSONXPv6yPsPn1QRtLiQY79Rr1PlZ0gZzeApR9VStDnqVo7LmVaA9lfABgn9VEAMF3ETEmjIBnqvsM82NIn3PAzSs5CXZzRF993TOzwp/93Gf+7GkuNAPrY8qhEFmEDOPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kmaRwMMW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85744C4CED0;
	Fri, 13 Dec 2024 11:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734088452;
	bh=6646rlh+vU0geIq1jRDLfASPiHXhYsJuMUx/KA8ipK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kmaRwMMWuDBJ02xjNv1OVGvUGGZmgNvUxL8+/iSi0uzmdFX2Cj85wPkCApS/2Zh94
	 f8+d60af/ohbFE2gH97H+Y02Gt5dH4I0WX9maAh+tSefEIrxEcKZ1RhXr3fSmmbx5V
	 3Ljz3NGfWuQFOgnIYNnVDyRcsf1e7l9RVbWkSLE8=
Date: Fri, 13 Dec 2024 12:14:08 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: haixiao.yan.cn@eng.windriver.com
Cc: nathanl@linux.ibm.com, mpe@ellerman.id.au, benh@kernel.crashing.org,
	paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	haixiao.yan.cn@windriver.com
Subject: Re: [PATCH] powerpc/rtas: Prevent Spectre v1 gadget construction in
 sys_rtas()
Message-ID: <2024121332-earplugs-monkhood-745d@gregkh>
References: <20241213034422.2916981-1-haixiao.yan.cn@eng.windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213034422.2916981-1-haixiao.yan.cn@eng.windriver.com>

On Fri, Dec 13, 2024 at 11:44:22AM +0800, haixiao.yan.cn@eng.windriver.com wrote:
> From: Nathan Lynch <nathanl@linux.ibm.com>
> 
> [ Upstream commit 0974d03eb479384466d828d65637814bee6b26d7 ]
> 
> Smatch warns:
> 
>   arch/powerpc/kernel/rtas.c:1932 __do_sys_rtas() warn: potential
>   spectre issue 'args.args' [r] (local cap)
> 
> The 'nargs' and 'nret' locals come directly from a user-supplied
> buffer and are used as indexes into a small stack-based array and as
> inputs to copy_to_user() after they are subject to bounds checks.
> 
> Use array_index_nospec() after the bounds checks to clamp these values
> for speculative execution.
> 
> Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
> Reported-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Link: https://msgid.link/20240530-sys_rtas-nargs-nret-v1-1-129acddd4d89@linux.ibm.com
> Signed-off-by: Haixiao Yan <haixiao.yan.cn@windriver.com>
> ---
> This commit is backporting 0974d03eb479 to the branch linux-5.15.y to
> solve the CVE-2024-46774.

Now deleted, please see:
	https://lore.kernel.org/r/2024121322-conjuror-gap-b542@gregkh
for what you all need to do, TOGETHER, to get this fixed and so that I
can accept patches from your company in the future.

thanks,

greg k-h

