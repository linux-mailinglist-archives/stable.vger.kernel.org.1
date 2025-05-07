Return-Path: <stable+bounces-142116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCBBAAE84B
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 19:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6572D18876BD
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 17:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D6928DB4E;
	Wed,  7 May 2025 17:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1sxwnlmF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FB828A40A;
	Wed,  7 May 2025 17:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746640764; cv=none; b=JAIT0U7W8OBpx9UwNbzLOPIOOEqJesSC5y3M4PmjmOO8zgf5uPIkWymsjeljK7t8RZFu0m+zfbOt35Nq8mBgSxEvwMFbWLq/E5pZGgDadi+GKVrYF8iHPbYGjVZVoIFGuuNfqYU+kyzq6eJM9X8Lv5ZKqdu10pAIv4HxQvkKRtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746640764; c=relaxed/simple;
	bh=lYvYVOSNKMKM27i75o7v1s/eru9+kKgBC5E7tpAZqSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XN+jG+sg9HEHDHNd+959wJmWCySwMndpMhEX4h+NqLfmOnfMZfEWxDK4IlLslPwW2yvpoqmwVTX7XAZcwCaqs3AILI+Hv134TFBHXwo/jthiEGSaY6sP5d8lhmBNtoUkaBcWNh1xVHs9BG5ddJisB3B7gcxFFi6Mfcpx2Pt8LeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1sxwnlmF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4FFC4CEE2;
	Wed,  7 May 2025 17:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746640763;
	bh=lYvYVOSNKMKM27i75o7v1s/eru9+kKgBC5E7tpAZqSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1sxwnlmF5MaWiFe5wIKW4mdHk2r72J1XBt2xo6jBKTul2qJv36EGbUsd1rWzFcybJ
	 XaXs64tpGE21Op/pf/EUrTawYZCuf8lAQNe69cGtanQOvVuUMQqYVWxSGFi6k1+CxN
	 88p0n7guSK6HYGhLU/UOfG1xgvFafc2QqskKB2k0=
Date: Wed, 7 May 2025 19:59:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	webgeek1234@gmail.com, Laxman Dewangan <ldewangan@nvidia.com>,
	Mark Brown <broonie@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>
Subject: Re: Patch "spi: tegra114: Don't fail set_cs_timing when delays are
 zero" has been added to the 6.1-stable tree
Message-ID: <2025050709-tightwad-afraid-1eca@gregkh>
References: <20250507154327.3165360-1-sashal@kernel.org>
 <2928a808-c4c0-4ef2-a6d7-79e7053c6915@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2928a808-c4c0-4ef2-a6d7-79e7053c6915@nvidia.com>

On Wed, May 07, 2025 at 04:50:26PM +0100, Jon Hunter wrote:
> 
> 
> On 07/05/2025 16:43, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >      spi: tegra114: Don't fail set_cs_timing when delays are zero
> > 
> > to the 6.1-stable tree which can be found at:
> >      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >       spi-tegra114-don-t-fail-set_cs_timing-when-delays-ar.patch
> > and it can be found in the queue-6.1 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> Please don't queue this up for stable yet. This fix is not correct and there
> is another change pending to correct this change.

Now dropped, thanks.

greg k-h

