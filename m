Return-Path: <stable+bounces-195273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD7BC74199
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 14:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6476F34380A
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 13:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE2233A00C;
	Thu, 20 Nov 2025 13:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLIf89DD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D09337115;
	Thu, 20 Nov 2025 13:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763644249; cv=none; b=HzuQfMWI02/579+AQYrrXYDSyicYo1kzLpJSYsvmQyVQDSfnk1G+Y1TVDt0JORsnY2adE+baLTJ7pruw+Y3i5gt3XkHD2xPJQ85EgZynnnptS3pH4MEtRncjN0MBr/isjtS1w10eyOH/BRyDFq4yGDi2jAAeFXXln0NYZJEC+qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763644249; c=relaxed/simple;
	bh=tInkj9k/KoTfRE/DCb2/fIYjK50Qkfn/zzltlCIrwn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQpnkf7gK8jcr1HA1/tlqB2+f631hCu6vWtesD1eLvkap8atU/YCu1WJkgNr+GUgeKCph5F2GJOTiTtx8r8l9LBNUNZ+XHrj9/hH0IBpNBPRiIfJAAHUtYirxMwDsX9oc869bGI58HrDdOoQJ/Iu1r7U36bkEVb42HLYTTvAqgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLIf89DD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2865C4CEF1;
	Thu, 20 Nov 2025 13:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763644248;
	bh=tInkj9k/KoTfRE/DCb2/fIYjK50Qkfn/zzltlCIrwn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WLIf89DD66733v36XtULgPqICwqz2b4vsfxkfIANlg8yqOIFKayEZe/IS4gN91nQi
	 OXUt9d3hp/w+2cMByRe3OnKwvUWiNU9tnh9Y6RuDnWwj/7474eROt/WyT9ZgItFdka
	 5qLInIwFsbUQtZx3c3in6mV2AoBqEaQANwx1i2zl6asIYhFWrxS0CaqMexYkgAzFhY
	 1Gx4lg17VPqWEX7B2rnf1NtL8iBgVpZrYiFStHKt/J9jx8BRdILJ0JqmmEAKFJ9lk2
	 fLwpli0JV3s3BBkf8P146ECYnE6aQYuICXVf1pNSi4Pea3XeUOoWjFLVl44TIqzNsS
	 c/6FPDUQ5+Eiw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vM4Qy-000000003jl-3z4E;
	Thu, 20 Nov 2025 14:10:49 +0100
Date: Thu, 20 Nov 2025 14:10:48 +0100
From: Johan Hovold <johan@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2] drm/imx/tve: fix probe device leak
Message-ID: <aR8TWJurF1a0LLGJ@hovoldconsulting.com>
References: <20251030163456.15807-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030163456.15807-1-johan@kernel.org>

On Thu, Oct 30, 2025 at 05:34:56PM +0100, Johan Hovold wrote:
> Make sure to drop the reference taken to the DDC device during probe on
> probe failure (e.g. probe deferral) and on driver unbind.
> 
> Fixes: fcbc51e54d2a ("staging: drm/imx: Add support for Television Encoder (TVEv2)")
> Cc: stable@vger.kernel.org	# 3.10
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
> 
> Changes in v2:
>  - add missing NULL ddc check

Can this one be picked up for 6.19?

Johan

