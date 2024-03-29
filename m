Return-Path: <stable+bounces-33153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE28689182D
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 12:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AA9A1C21E38
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 11:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799E76A35E;
	Fri, 29 Mar 2024 11:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b8ZZZ7wn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7AE3D0A1;
	Fri, 29 Mar 2024 11:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711713003; cv=none; b=XIMBRwcE8mAWk735JFUod1iesrTGRKVcDb1x1tyyNTUUD8ahERRovC6VOjukwXy9kp8h8q2BbHYoHaD7eWo93FaiaUsB1gtSSPU+6w2As1GEwlfiN1EV/Vi9467UH4YNmMFj9ZE2PawWJNka4LXuLJruEALmxJqOzYuIsjImk+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711713003; c=relaxed/simple;
	bh=TRstkE3u+0gcwMpKi9ozzrepkqrfjWhnAKA/qyO9J0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLJTNfCzgb53djb31enwh5FI9LItGbaasaYi/6vniGLDdsGqLBlgdwi6HHJeleD/l+IbjNhGuybQC4bWqvJtqNr0JwPlh4+b6Ym7QIP5N4YYZcckDU5pPnoI3P612U1nm54RMvLekb9zehejfARlahFEJoHpeOstSghqV30lgyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b8ZZZ7wn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFDDC433F1;
	Fri, 29 Mar 2024 11:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711713002;
	bh=TRstkE3u+0gcwMpKi9ozzrepkqrfjWhnAKA/qyO9J0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b8ZZZ7wnoGxIUIS0XfXdi7vHLi2KK2cZoy+AWOzR2W1SyFblQFupKC4vPeuiAS6jR
	 bRlblvBHKizduBPi6C9q/JofEyoivV0OF4JL+caK+rkuyrQxTmQevs95ubKsO/nvBn
	 TXH2IWcfc9e4qhZEVZrzfggAUhw8b+V5/0YV7MrY=
Date: Fri, 29 Mar 2024 12:49:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Srish Srinivasan <srish.srinivasan@broadcom.com>
Cc: ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com,
	borisp@nvidia.com, davejwatson@fb.com, davem@davemloft.net,
	edumazet@google.com, horms@kernel.org, john.fastabend@gmail.com,
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
	sashal@kernel.org, sd@queasysnail.net, stable@vger.kernel.org,
	vakul.garg@nxp.com, vasavi.sirnapalli@broadcom.com
Subject: Re: [PATCH v2 6.1.y] net: tls: handle backlogging of crypto requests
Message-ID: <2024032945-payer-many-c4a3@gregkh>
References: <2024032945-unheated-evacuee-6e0a@gregkh>
 <20240329102540.3888561-1-srish.srinivasan@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329102540.3888561-1-srish.srinivasan@broadcom.com>

On Fri, Mar 29, 2024 at 03:55:40PM +0530, Srish Srinivasan wrote:
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
> [Srish: v2: fixed hunk failures
>         fixed merge-conflict in stable branch linux-6.1.y,
>         needs to go on top of https://lore.kernel.org/stable/20240307155930.913525-1-lee@kernel.org/]

Identical do what I queued up for v1, but oh well :)

thanks,

greg k-h

