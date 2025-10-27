Return-Path: <stable+bounces-189983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1FCC0E13D
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 14:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8AB4234E0DA
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 13:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E70130594F;
	Mon, 27 Oct 2025 13:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjqLPiaz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359913054E8;
	Mon, 27 Oct 2025 13:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761572128; cv=none; b=c31LAI5UljbYOG4JfHV9rmTiwjkMoc7bxM5a7mwwmqRDs/+dMqG5e8/gGUeSOHTV0JkwqbPoMiIiQ90S3XoDw4F5n7XeTZfNGuKLlOcEX78m0TPLt3j6YF9bmxdScRU8zzab3YjB/HWBqvHgh53MeXOEg4+10yakjXv9nha1/NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761572128; c=relaxed/simple;
	bh=aRsCfY5+Xwn/NNYCzEP+7073Q7UM7+DwDHvkcIvZjJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Waro646PUTHxgSpLusRMxY5/YIhrPAGjvnNbU5WuYeB/dk8zWHu6R/TPyLOZDC2DuHghnHmDQdfGBfhnmgBvczozjAj2b2w1ilIexDqUSngN/6yGMF2zOvKrDEl4R+4vkRY2r9ILFWwKUAkPmXdQBOL9tyo28KayreK23r9CuOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjqLPiaz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2245C4CEF1;
	Mon, 27 Oct 2025 13:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761572127;
	bh=aRsCfY5+Xwn/NNYCzEP+7073Q7UM7+DwDHvkcIvZjJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NjqLPiazll1u7aGaUDZ8Ocn+voLiyebRoHfnMgV6vvaf0ZxBAGKS7TDQdkeF31tAM
	 mOsaMma6fmrVWOQ+3uMzXqr2LK7UCR92JGXyt0NeRmSYfCVkPowHCT2/1UsE+yU5Rz
	 pz8OOqipJxV46XhVItfePHxgzNpwpyTwiNsMjkpBSIMMXg1dEyhB8XiRSjuqJJI6Nb
	 xHYX1v9okS1xy7uHRtIsDeKFY1EhlqdkBH2fFju8fRb7XdRY0W/um83eFGP9O7Ravq
	 E2KhPgmiQnUcIjh/NcuWy9EJ96wR3MgY4Fgn/cMoVNyw9fdmJeDc1Ai4l3eKd02pYG
	 YRCrCZc2QFDiQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vDNNj-000000000HH-0GcS;
	Mon, 27 Oct 2025 14:35:31 +0100
Date: Mon, 27 Oct 2025 14:35:31 +0100
From: Johan Hovold <johan@kernel.org>
To: Alain Volmat <alain.volmat@foss.st.com>,
	Raphael Gallais-Pou <rgallaispou@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: Re: [PATCH] drm: sti: fix device leaks at component probe
Message-ID: <aP91I9j-OV4j3A49@hovoldconsulting.com>
References: <20250922122012.27407-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922122012.27407-1-johan@kernel.org>

On Mon, Sep 22, 2025 at 02:20:12PM +0200, Johan Hovold wrote:
> Make sure to drop the references taken to the vtg devices by
> of_find_device_by_node() when looking up their driver data during
> component probe.
> 
> Note that holding a reference to a platform device does not prevent its
> driver data from going away so there is no point in keeping the
> reference after the lookup helper returns.
> 
> Fixes: cc6b741c6f63 ("drm: sti: remove useless fields from vtg structure")
> Cc: stable@vger.kernel.org	# 4.16
> Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Can this one be picked up for 6.19?

Johan

