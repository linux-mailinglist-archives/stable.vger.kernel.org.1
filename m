Return-Path: <stable+bounces-183411-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE23BBD808
	for <lists+stable@lfdr.de>; Mon, 06 Oct 2025 11:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E74A4EA2D8
	for <lists+stable@lfdr.de>; Mon,  6 Oct 2025 09:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F172420298C;
	Mon,  6 Oct 2025 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8NcdP3t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96E3126C05;
	Mon,  6 Oct 2025 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759744189; cv=none; b=KhbdmwI2XDpIRYe13b08KQaVzAKg0PN6n84GxxSnNHCpkDYfywe3UAI0XGckeN3bKSC752inqzTRa//Obkqgnwe0AsARI/gOTTy7EnagWAtMoytjjq6lERs0p4bQQbkVAIShKcvbqY1lhxpybvjUeyLCtrHFXvajE++tBXu0zlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759744189; c=relaxed/simple;
	bh=bQYO0VYtBtio80MmlSTfZwF05jmL0sNFgnqPZjKtqzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khS7k9puDR7whN1CAcJYrfql6v/TS0g7lLd6T5mTgJ1P4n1PjqNq06L+Iqus1PzeG9I8CWhjdYQz2AoOKFgt11YmL8LLU+XL+4MZuDqLSmb738fRjGiln4fWxrmLn+3qGS9p83AYxSAWFF2VbI4AmpqEH+UbFhfkPAp+a35mhas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8NcdP3t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 409EBC4CEF5;
	Mon,  6 Oct 2025 09:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759744189;
	bh=bQYO0VYtBtio80MmlSTfZwF05jmL0sNFgnqPZjKtqzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r8NcdP3tmUHEJD/5oHfudOZ3+YWlX59Fzq+n2oTdWwrvPdSOEOpBO04z+2qMleb2t
	 mTSxMK6cFadRiZbhMGuRNRCanftfMrGqUS1EIO1lLxiDAFrzwCwHDxNA6EQqxHFk2H
	 u03XXCBG9JKSAG1S3iGxX+OTGY0jH/qcmQWU2Pow13z0tm/lyQWDe1Rh7gs9YNbZfD
	 x3R387n+1EwQwBU7OwpJQd0iQkaIjOplQsG0Rfd9D6cvKhFQopXDu6mdCCjju3+VAz
	 3qKpA/bwvjD7QpTj7cjlEK7lHHT4+IezQzZTzKDkFRq8QwDqAvHsJtP4a2wCxyhSWa
	 8kr+wc2WDemIw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v5hql-000000007Oc-0j5U;
	Mon, 06 Oct 2025 11:49:47 +0200
Date: Mon, 6 Oct 2025 11:49:47 +0200
From: Johan Hovold <johan@kernel.org>
To: Sjoerd Simons <sjoerd@collabora.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	CK Hu <ck.hu@mediatek.com>, dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/mediatek: Fix refcounting in mtk_drm_get_all_drm_priv
Message-ID: <aOOQu9Lu_3-EhtGd@hovoldconsulting.com>
References: <20251003-mtk-drm-refcount-v1-1-3b3f2813b0db@collabora.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003-mtk-drm-refcount-v1-1-3b3f2813b0db@collabora.com>

On Fri, Oct 03, 2025 at 10:08:28AM +0200, Sjoerd Simons wrote:
> dev_get_drvdata simply returns the driver data part of drm_dev, which
> has its lifetime bound to the drm_dev.

No, that is not correct: the driver data goes away when the driver is
unbound, not when the device is freed.

> So only drop the reference in the
> error paths, on success they will get dropped later.

But there is indeed a partial fix for the device leak here which was
overlooked. Good catch.

> Cc: stable@vger.kernel.org
> Fixes: 9ba2556cef1df ("drm/mediatek: clean up driver data initialisation")

This is clearly not the commit that introduced the issue (even if I also
failed to notice the reference imbalance).

Since there is no need to keep the references, I've just sent a fix
which instead fixes this by dropping the previous partial fix:

	https://lore.kernel.org/r/20251006093937.27869-1-johan@kernel.org

Johan

