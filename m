Return-Path: <stable+bounces-191755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAC8C213C4
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 17:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 717BB1882188
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 16:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3B42DA779;
	Thu, 30 Oct 2025 16:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1tv4rfk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B461E7C19;
	Thu, 30 Oct 2025 16:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842156; cv=none; b=qL4h4sGlt9y6c9hf0WoclUICJYg1gxmGOu0Bcp8LJaRyn1Ji+4O0CnAdQxJgCqVAC0nRdM8mPmCfF3FNHmj05KPaF9XQ6Od6vpxcMHSKO2JtZ5BMDeCqLaU2a+WfeFtoX4XJHAeFHQhcpykGTH47t9/3yPCdzaTC9/kSeVqmDbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842156; c=relaxed/simple;
	bh=CfnYUWF6HP6k/DFvfFErDlrFLZvLTOj+ynI24ImztDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yjta0aJ0Tumfe7nCLfpHPDE8NXEsMNmAF3OjEKk3Oxk8gQzc+moljseb/pRJQ1On7HIahob+vyxTRljfgfLr/xB3mY28o6es1xvIzss1l7ulVp1jr9TwvEN4ptXYXzjjSre9JQ95hUblbs1iBXiZ7ahXS9iitK3ESHv3H0pwhdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1tv4rfk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBEE6C4CEF1;
	Thu, 30 Oct 2025 16:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761842156;
	bh=CfnYUWF6HP6k/DFvfFErDlrFLZvLTOj+ynI24ImztDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y1tv4rfkEtG/H8aTguT6cQ9sYYapqEvRcduBQmIkAPSiriNlROWulWjQNirQWZQXk
	 6st8s+bvdYw/u8GqRBtcSAIO/eSlRrp1D71FHF61CLdn5Npif5GOj77gNASf/BgJbW
	 PamGKSJeZznZi3djmxUwdAnD+Bm9kYOPreFObhdPJZawlwvrxKVbdVOoGyOE9LEd5n
	 k8W5+FHRluzZBY2r3An52q6zXKKG9c1nSOc66vwHt2UUDBbR0z8gV1lSUuimcAnGlc
	 /7BTPfMjrLkEjga5dioUWGP4WUfn9yUPOw3aEeWwjCZfHJrDGOuahw3RdGiItGSNb2
	 tzYCLG2bkAY3Q==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vEVd5-0000000048K-2wdE;
	Thu, 30 Oct 2025 17:36:03 +0100
Date: Thu, 30 Oct 2025 17:36:03 +0100
From: Johan Hovold <johan@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/imx/tve: fix probe device leak
Message-ID: <aQOT8zD1hsK4SJ_c@hovoldconsulting.com>
References: <20250923151346.17512-1-johan@kernel.org>
 <89a86fc1c48f921aa3b06146f43a32dc58515548.camel@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89a86fc1c48f921aa3b06146f43a32dc58515548.camel@pengutronix.de>

On Thu, Oct 30, 2025 at 04:27:39PM +0100, Philipp Zabel wrote:
> On Di, 2025-09-23 at 17:13 +0200, Johan Hovold wrote:

> >  static int imx_tve_probe(struct platform_device *pdev)
> >  {
> >  	struct device *dev = &pdev->dev;
> > @@ -546,6 +553,11 @@ static int imx_tve_probe(struct platform_device *pdev)
> >  	if (ddc_node) {
> >  		tve->ddc = of_find_i2c_adapter_by_node(ddc_node);
> >  		of_node_put(ddc_node);
> > +
> > +		ret = devm_add_action_or_reset(dev, imx_tve_put_device,
> > +					       &tve->ddc->dev);
> 
> I think this needs to be wrapped in "if (tve->ddc) { }",
> of_find_i2c_adapter_by_node() can return NULL.

Indeed, thanks for catching that. Just sent a v2.

Johan

