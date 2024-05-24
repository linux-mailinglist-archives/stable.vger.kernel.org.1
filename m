Return-Path: <stable+bounces-46029-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB1F8CE05E
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 06:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17A551C20F78
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 04:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEBB26AE8;
	Fri, 24 May 2024 04:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UjzBHD3A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B7B15A5;
	Fri, 24 May 2024 04:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716525200; cv=none; b=nuBipWssgvN5i8ikYzF2lVlh49ZMXCvseE1pDo1GZ4VmpAWoIIgOQf861HKZQV1d4UNeMgyUAvbZGeBKHXMlarEx8B+3lqdnXWauaHUwYH2I9Q6u89FZ9G3yPWXqhGH5d/6B9/Rk9w/Qki78PqHteKTZBRCrC392bpUsZ4BM0uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716525200; c=relaxed/simple;
	bh=01XdbQZbRvuTXSoXutZnp5QEAgb262rIjygPLBfceLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SiTg+1a1QQb5xkIYRX29QlOtaCMTj77hHY3epZVx6/e3L505EdqzqXTbycmJSmJPqG3R8IbuwrPe9+7wxS2sTm1CQRb1k3Zzmrw/BfsRNgV16xll2CQkDaHcl2JLy4BUzziMAmxivqMvbDzhV3A0NidRoif+5+qNXqAfPWxFwHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UjzBHD3A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00BEAC2BBFC;
	Fri, 24 May 2024 04:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716525199;
	bh=01XdbQZbRvuTXSoXutZnp5QEAgb262rIjygPLBfceLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UjzBHD3ATt9wp5XvgDIpCZxnEb7oIcvqxbeWkKLI8G2cNqUFBlJ6WkBeMiN/bwJ7T
	 fGmGuBRjJTHfX0XYQMgpd7zLqjRfPWVFfMS6JpvJTNL0L6Ko2tR8KwU2A9NyItWnoj
	 XD5PctTO2QgAo2Udu7TL6DNb2z9EmgLU3QHV0XDE=
Date: Fri, 24 May 2024 06:33:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: rafael@kernel.org, akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] kobject_uevent: Fix OOB access within zap_modalias_env()
Message-ID: <2024052418-casket-partition-c143@gregkh>
References: <1716524403-5415-1-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1716524403-5415-1-git-send-email-quic_zijuhu@quicinc.com>

On Fri, May 24, 2024 at 12:20:03PM +0800, Zijun Hu wrote:
> zap_modalias_env() wrongly calculates size of memory block
> to move, so maybe cause OOB memory access issue, fixed by
> correcting size to memmove.

"maybe" or "does"?  That's a big difference :)

> 
> Fixes: 9b3fa47d4a76 ("kobject: fix suppressing modalias in uevents delivered over netlink")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  lib/kobject_uevent.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> index 03b427e2707e..f153b4f9d4d9 100644
> --- a/lib/kobject_uevent.c
> +++ b/lib/kobject_uevent.c
> @@ -434,7 +434,7 @@ static void zap_modalias_env(struct kobj_uevent_env *env)
>  
>  		if (i != env->envp_idx - 1) {
>  			memmove(env->envp[i], env->envp[i + 1],
> -				env->buflen - len);
> +				env->buf + env->buflen - env->envp[i + 1]);

How is this "more correct"?  Please explain it better, this logic is not
obvious at all.

thanks,

greg k-h

