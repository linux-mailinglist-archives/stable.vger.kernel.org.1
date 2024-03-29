Return-Path: <stable+bounces-33129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FAA8915AE
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 10:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C26F1C21FCC
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 09:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D16F2E635;
	Fri, 29 Mar 2024 09:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rk2pJ0EC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CEC1EB4B;
	Fri, 29 Mar 2024 09:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711704239; cv=none; b=XUCEcYUkr8TW79f1o8/YzdBc7RY7x727VBg0eJ/fu1dXytVh16dX4ClY4WW3slCoCaSUIX1IKtPTS4YtfVYz6qFUeh6Hwgp0l7+ZyG/6WTbYzTRbvVgINNRKR4NnCExSNElWBTf5y6bSemZ13k3lC1Vpge3QmIRsB5399amEA+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711704239; c=relaxed/simple;
	bh=TJLlT4e+J+W29O7RPoscY0Kx/HZJD7XHBxAVhA1Z4yE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AvjmE74eXY/0u8OHv8T7R9ATCXFV84H9054eXa+MtvdR+n7CVioWi9Un/ge54LEdMMp06UD8W54nwf5IVjOAjyPbQIcTxV+QO4V8F4vHSNMOvimuad5BGPByXUujbTRm0VfitJiI2tUInUltya7N3o3ElAcypBLY4eHtmcwyeFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rk2pJ0EC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A19CC433C7;
	Fri, 29 Mar 2024 09:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711704238;
	bh=TJLlT4e+J+W29O7RPoscY0Kx/HZJD7XHBxAVhA1Z4yE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rk2pJ0ECAK8VZR08hGtUpvk2jcUwb8uwf/zsiXY47gJAGOYYtZwaX0D15LCaGpwUX
	 sfSirqBMfhTex6ui8V0GEiL6TNOSQ0vfJ7AncyMA95SALmxGkNQCNNkTnbcAbPHwH1
	 wmfmm+X/RvlLoXQZW3N8zFN1jM01X/hIB4CB8px0=
Date: Fri, 29 Mar 2024 10:23:55 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Srish Srinivasan <srish.srinivasan@broadcom.com>
Cc: stable@vger.kernel.org, borisp@nvidia.com, john.fastabend@gmail.com,
	kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, vakul.garg@nxp.com, davejwatson@fb.com,
	netdev@vger.kernel.org, ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com, vasavi.sirnapalli@broadcom.com,
	Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] net: tls: handle backlogging of crypto requests
Message-ID: <2024032945-unheated-evacuee-6e0a@gregkh>
References: <20240328123805.3886026-1-srish.srinivasan@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328123805.3886026-1-srish.srinivasan@broadcom.com>

On Thu, Mar 28, 2024 at 06:08:05PM +0530, Srish Srinivasan wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> commit 8590541473188741055d27b955db0777569438e3 upstream
> 
> Since we're setting the CRYPTO_TFM_REQ_MAY_BACKLOG flag on our
> requests to the crypto API, crypto_aead_{encrypt,decrypt} can return
>  -EBUSY instead of -EINPROGRESS in valid situations. For example, when
> the cryptd queue for AESNI is full (easy to trigger with an
> artificially low cryptd.cryptd_max_cpu_qlen), requests will be enqueued
> to the backlog but still processed. In that case, the async callback
> will also be called twice: first with err == -EINPROGRESS, which it
> seems we can just ignore, then with err == 0.
> 
> Compared to Sabrina's original patch this version uses the new
> tls_*crypt_async_wait() helpers and converts the EBUSY to
> EINPROGRESS to avoid having to modify all the error handling
> paths. The handling is identical.
> 
> Fixes: a54667f6728c ("tls: Add support for encryption using async offload accelerator")
> Fixes: 94524d8fc965 ("net/tls: Add support for async decryption of tls records")
> Co-developed-by: Sabrina Dubroca <sd@queasysnail.net>
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> Link: https://lore.kernel.org/netdev/9681d1febfec295449a62300938ed2ae66983f28.1694018970.git.sd@queasysnail.net/
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> [Srish: fixed merge-conflict in stable branch linux-6.1.y,
> needs to go on top of https://lore.kernel.org/stable/20240307155930.913525-1-lee@kernel.org/]
> Signed-off-by: Srish Srinivasan <srish.srinivasan@broadcom.com>
> ---
>  net/tls/tls_sw.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

Now queued up, thanks.

greg k-h

