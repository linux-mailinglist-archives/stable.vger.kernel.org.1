Return-Path: <stable+bounces-87758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A2A9AB4C8
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 19:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 926BE1C226D5
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 17:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CCB1BC9FB;
	Tue, 22 Oct 2024 17:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="JvzJn82G"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112A21BC091;
	Tue, 22 Oct 2024 17:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729617111; cv=none; b=KqOnWkdXumF5XL0UELcXveKcLQyV+W/2sntDqI9EJoxU+Mvl2mpuEdrRoh/2uVDDLoHifYflCq5gciKCMOxJjR+sOZgweIaTRVkmHYFkQiLIuW8cZyUbJj1Y16Bg+kdg7/a+9c40oSRBdiDKtmdU/9NqwPTHfnPMto9LRIsk1k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729617111; c=relaxed/simple;
	bh=zgKF43dkTCb7+rHdwfykRvvAg016VrUQvbCDvWFrWZE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jScmcEJLPW/oHfyGM8c9QRQk56pNawDEUwaS1Mky9eriFDxI+21h61X8sGXjOC/T+Aqe1rkQO/Pa6C9f/y0X3ca4j+2Sl2OIuJpresstmH+o1SAxUDUr1+C+2xGtRmRNaX1+exFZBqCQBHbU9EXm+ohtcnc6Kr91/HokGB91a18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=JvzJn82G; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id D714A1F9B6;
	Tue, 22 Oct 2024 19:11:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1729617104;
	bh=k1oO2yPovWzkvp/CtKxWHByIK1XlmGAmvnAAyw45gFo=; h=From:To:Subject;
	b=JvzJn82G7aY9bSOxYKRQu46aeAEQFWvg1/W+CAuYCsIDUq6FCTmQGNjJUnjlURmi4
	 I8X+BP60cIKUvi5+GEWPXAZvScxt1tw3hu0JSCttXcl84/SvVauItyOX5ssNOz1LcG
	 3FGXNRx+30tk0m5IopqJFY326bJgEepfCR4yIc+5u7rZouYKW7h7NEVHCp3aiIk21E
	 onIWMn94nuywKQiW45X8kg0q+YS7e7XQurHMkZFb4/CejoY5wy4rZ2EKldVCjGZEp4
	 MgZiS5jUp2gMF6WwJc+lmGEfKRLqND5RqRrENDorF1pluPZzEmooFwK0wipjksgbzj
	 8h2EucngP2HNg==
Date: Tue, 22 Oct 2024 19:11:39 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] drm/bridge: tc358768: Fix DSI command tx
Message-ID: <20241022171139.GA71850@francesco-nb>
References: <20240926141246.48282-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926141246.48282-1-francesco@dolcini.it>

Hello,

On Thu, Sep 26, 2024 at 04:12:46PM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Wait for the command transmission to be completed in the DSI transfer
> function polling for the dc_start bit to go back to idle state after the
> transmission is started.
> 
> This is documented in the datasheet and failures to do so lead to
> commands corruption.
> 
> Fixes: ff1ca6397b1d ("drm/bridge: Add tc358768 driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Just a gently ping on this,

Francesco


