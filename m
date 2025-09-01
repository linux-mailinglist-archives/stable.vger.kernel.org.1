Return-Path: <stable+bounces-176856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8318B3E4D3
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 15:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 417801891B0D
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 13:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B87305048;
	Mon,  1 Sep 2025 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZCQG1m8I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53F6274B32
	for <stable@vger.kernel.org>; Mon,  1 Sep 2025 13:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756733134; cv=none; b=puIg/WWHjP2IT8HiL5PtFSGEckzUbgsDxYqH+nja5xI98w0l+I4+XETB4DZ/yD31M7Ri/QK/RQT/hfQuRaJhFzUX/djkDRwz1DAXs1fvMNl4HezFaUH466W5XnN4xEGLm2f616byuA3OgDDMwawdKku17sMTbpC6hSTeKOgGRvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756733134; c=relaxed/simple;
	bh=UYBMOWl+FxJegBFM9PUVZsyGGUVbO8IqPYuGcJPeXBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c15sc9uOAa9eax/5FBD9LarRvxkYvpdgorFidviC4dzQej0qSQ3PUnlusDgo0/XzKY2XN0WJOjEwi+DcYDkypCBHZFQnfo31O49KEt2xp39jGrEpdRbIgnjtgWNVZKY+3FLjinvnT4hl4+vXdMmzpwRySuTXDDjD/eNnCkSoLPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZCQG1m8I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6832C4CEF0;
	Mon,  1 Sep 2025 13:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756733134;
	bh=UYBMOWl+FxJegBFM9PUVZsyGGUVbO8IqPYuGcJPeXBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZCQG1m8IjUzz0WWmWu/Bq0L56Yp+Y4NXtl+LyQgxNMNh9VAI+Ov/ggOrmaBY/Go0P
	 f/vw81zuBcVnH1Nc/cMUu1WnYUX+/5xVDqgG/3+a7+E051WrL3GdT3ZKSXWSbf9h7x
	 Sm76/5DbauyWHs4IGzpQ+M1TrophHIBNG6dIu3ys=
Date: Mon, 1 Sep 2025 15:25:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
Cc: stable@vger.kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH linux-5.10.y 1/5] ASoC: Intel: bxt_da7219_max98357a:
 shrink platform_id below 20 characters
Message-ID: <2025090101-exert-deceased-3071@gregkh>
References: <2025082909-plutonium-freestyle-5283@gregkh>
 <20250901095440.39935-1-mgorny@gentoo.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250901095440.39935-1-mgorny@gentoo.org>

On Mon, Sep 01, 2025 at 11:54:36AM +0200, Michał Górny wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> commit 24e46fb811e991f56d5694b10ae7ceb8d2b8c846 upstream.
> 
> The excessive platform id lengths are causing out-of-buffer reads
> in depmod, e.g.:
> 
> depmod: FATAL: Module index: bad character '�'=0x80 - only 7-bit ASCII is supported:
> platform:jsl_rt5682_max98360ax�
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Link: https://lore.kernel.org/r/20210511213707.32958-5-pierre-louis.bossart@linux.intel.com
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Michał Górny <mgorny@gentoo.org>

This commit text does not match the upstream commit text at all :(

Same for others in this series, please fix.

thanks,

greg k-h

