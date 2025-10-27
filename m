Return-Path: <stable+bounces-189939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B85DCC0C595
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 09:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 02B794F1190
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 08:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FA62E8B77;
	Mon, 27 Oct 2025 08:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rufVP4OS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9502D24A7;
	Mon, 27 Oct 2025 08:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554474; cv=none; b=QP9DRe/TXcZkmSh2zIoAW1Xp1mJHBrwHZPbGABT8CWGHcGTJKJWYPtKdd+3HYe3dwO+nQdvrP0+o4OGl2e4K4KAyQApaUvgz7zl55ksJu2RLMw0jGO7WhfqgL0RWfAwwdejbkAQMQRjmdO0u99rDgimfv8VDkg55Ahb7borKIe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554474; c=relaxed/simple;
	bh=p7L1ppdjpTPK5vdV3Mi+mMZfy8PqxfrJ0ZCIY6BoM3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jirHwokdigZ1MccY1q3t7ulQe0K8hzt4ncQYg5r2ad0meM/RPr8gXY5Mf0v9R7xD9ldcBhx/RCyKFJ6/Kq8fVnOgN3EM1P91330beAmSVvJevcbcZA2xq7aXbCHVZenVSpCGel8nSAU2CeBE38iTsQP/Wsx7CGdS20PglIz16do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rufVP4OS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADEC6C4CEF1;
	Mon, 27 Oct 2025 08:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761554473;
	bh=p7L1ppdjpTPK5vdV3Mi+mMZfy8PqxfrJ0ZCIY6BoM3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rufVP4OSJtQ3/mqTsI9HPHrUO+OB+vlQGbAQqIDt1z1/AZr7oI74LCqffPdj8vLew
	 JW1i1LFS8BrXSqZRhEm8DGIdLLQVtvMjlTR4+W3Nd5kmSFHSa0+5cnJLiMCDqe1zZi
	 BZNURd+k0QiE1zTDpsPp4znfOXhDST9Y3ZAdAzHCG4QUeEz2dKvoj2FRR+7KtARw0K
	 x93tfow3vIZdl4w3bnKt+Aq0n8eljgp5LLbcx8nSChwFpPFXxJxXmmuBeEl5qZ6Ewt
	 QStYGjeV2llAJvn5SGcXYs1zeEWXAMkH7z30MF1MUyoV1y4kbm/N2jrDV4GJAx84ZL
	 F0pZYbv/EemuQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vDImy-000000000Gc-2Ow9;
	Mon, 27 Oct 2025 09:41:16 +0100
Date: Mon, 27 Oct 2025 09:41:16 +0100
From: Johan Hovold <johan@kernel.org>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	CK Hu <ck.hu@mediatek.com>, Ma Ke <make24@iscas.ac.cn>,
	Sjoerd Simons <sjoerd@collabora.com>,
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/mediatek: fix device use-after-free on unbind
Message-ID: <aP8wLMrFTsJI-Lr3@hovoldconsulting.com>
References: <20251006093937.27869-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006093937.27869-1-johan@kernel.org>

Hi Chun-Kuang,

On Mon, Oct 06, 2025 at 11:39:37AM +0200, Johan Hovold wrote:
> A recent change fixed device reference leaks when looking up drm
> platform device driver data during bind() but failed to remove a partial
> fix which had been added by commit 80805b62ea5b ("drm/mediatek: Fix
> kobject put for component sub-drivers").
> 
> This results in a reference imbalance on component bind() failures and
> on unbind() which could lead to a user-after-free.
> 
> Make sure to only drop the references after retrieving the driver data
> by effectively reverting the previous partial fix.
> 
> Note that holding a reference to a device does not prevent its driver
> data from going away so there is no point in keeping the reference.
> 
> Fixes: 1f403699c40f ("drm/mediatek: Fix device/node reference count leaks in mtk_drm_get_all_drm_priv")
> Reported-by: Sjoerd Simons <sjoerd@collabora.com>
> Link: https://lore.kernel.org/r/20251003-mtk-drm-refcount-v1-1-3b3f2813b0db@collabora.com
> Cc: stable@vger.kernel.org
> Cc: Ma Ke <make24@iscas.ac.cn>
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

This patch fixes a regression in 6.17-rc4 that apparently breaks boot
for some users. To make things worse, the offending commit was also
backported to the stable trees.

You need to get this one into mainline as soon as possible, that is,
this week and into 6.18-rc4.

Johan

