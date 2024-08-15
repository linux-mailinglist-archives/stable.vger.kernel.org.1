Return-Path: <stable+bounces-67754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C39952B36
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 11:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46BD91C21444
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 09:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C4A1C8253;
	Thu, 15 Aug 2024 08:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lGURleej"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D841D19ADAC;
	Thu, 15 Aug 2024 08:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723710824; cv=none; b=AgPemc11CiCIGWwp2K+VODnTf93z2Hdx7Eb8iKRyB1/qAnA+SmRaSkNiqoF1BCwaQSHnuRTATfr35LJcMHsTBlo+rSfFeHwpSKvLK14TKc3+I1h97cOlG17VHIQ1OxZONONB4SVThOQIg42yZlz3f0E64qzM1FBWLUIiapCbnOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723710824; c=relaxed/simple;
	bh=6us9hoB+KXaOxwEhwckxMnGzhRmLnTauWqGGPmbGrzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHPz0nQ4Gmh2Ik1APJAPjtgjr3oSelaXnndUP362fNJRiR2BryB85BId4q3dsOSf/PDmbPA98/R5ED0rVZKxRb7bIyyn8GBpoMq4+HU9Qltx7XRo/cJmX9CjE6DKmAZQ4t7gPnJY+LrIuFqPTjQW8WvaIwfwLdllOaEcbLkwVg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lGURleej; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABE2C4AF09;
	Thu, 15 Aug 2024 08:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723710824;
	bh=6us9hoB+KXaOxwEhwckxMnGzhRmLnTauWqGGPmbGrzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lGURleejvrRTfr1w4JPAN8VGbEu4hJ19OLPaEj7pMo/sAgaI07E4Ph2ZU5jviYl+H
	 /OKZu2xiCFxOAAVaQ5H38efaLQmHTZzjx9HsGDlXqSvC8JKWCbK7MhOyJr9wlh2HvE
	 ks+s5/0icY8mB4CnvLIA6/aJP4oFucy6ZcZY3KR8=
Date: Thu, 15 Aug 2024 10:33:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: stable@vger.kernel.org, linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	Simon Trimmer <simont@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH for-6.10] ASoC: cs35l56: Patch CS35L56_IRQ1_MASK_18 to
 the default value
Message-ID: <2024081532-grab-diabolic-cc34@gregkh>
References: <20240813142216.17922-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813142216.17922-1-rf@opensource.cirrus.com>

On Tue, Aug 13, 2024 at 03:22:16PM +0100, Richard Fitzgerald wrote:
> From: Simon Trimmer <simont@opensource.cirrus.com>
> 
> [ Upstream commit 72776774b55bb59b7b1b09117e915a5030110304 ]
> 
> Please apply to 6.10.
> The upstream patch should have had a Fixes: tag but it was missing.
> 
> Device tuning files made with early revision tooling may contain
> configuration that can unmask IRQ signals that are owned by the host.
> 
> Adding a safe default to the regmap patch ensures that the hardware
> matches the driver expectations.
> 
> Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
> Link: https://patch.msgid.link/20240807142648.46932-1-simont@opensource.cirrus.com
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  sound/soc/codecs/cs35l56-shared.c | 1 +

Now queued up, thanks.

greg k-h

