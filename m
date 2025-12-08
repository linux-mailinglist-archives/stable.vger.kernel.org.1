Return-Path: <stable+bounces-200340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4114ECACF3C
	for <lists+stable@lfdr.de>; Mon, 08 Dec 2025 12:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 25956301DE19
	for <lists+stable@lfdr.de>; Mon,  8 Dec 2025 11:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D27E30F94A;
	Mon,  8 Dec 2025 11:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOm4weY7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDDB29B8E0;
	Mon,  8 Dec 2025 11:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765191975; cv=none; b=dZ8YOAjR9YbC+SkZCvLidwCbEpg5VIrC3Ro5W6+UfI+5/O/qS+9ngeUxYDUhgm/X0ZXsI0cU96dXykQlUjX7z3FmR7jq6AGsaom/tTVtuoNH1fkGFpnkDY9+eyftj9QCPyzadvYM8fVAW0mVJTBXaYX6lf/+4j+gmxlX6kiy7FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765191975; c=relaxed/simple;
	bh=+Sg4+xUyee1JdQ9aNzal0X1KGSxSHxdpxDRWre8j8BY=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=bsSdoX3mDV0YTC22FfmK909bP11Db10z1C++wzSCGMoeimZVknYUa+xx1hEjOQ1S4deIFufa2on3DWXwJPXZ/5b24Zsrj/w+Yu1ki6jGISSJHgRtBrOEQgInkLRmR7dSwMraOrQxNwPlfU64PbB4l0UrbDXDgEPaoU+UQghIo3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOm4weY7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F8BC4CEF1;
	Mon,  8 Dec 2025 11:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765191973;
	bh=+Sg4+xUyee1JdQ9aNzal0X1KGSxSHxdpxDRWre8j8BY=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=IOm4weY7TQGzaGOq9hS9L4Rw5s5O2X4t18f++QMBkFetLbd9WX4JEk2F+x+p39to0
	 wki37JFXH/Zr+f+T5z7MmQA6fpjGF6GUrATz9sWrHV2JAaUU395O7VU43JpztG1mpq
	 KgVegQPaV2r4vuEohxqhODX7VQvhZALfdSCINStSM393Ks9noAyLTs32hY6a1GuXn7
	 yiV3kozVHZ+bi5cIxv/qX678bSnWrNEWTjOBlveCzJ6mqgF1vJT+bPm8xt11xBhCq4
	 lh9I8oBTDygDeM06pa8UJiO8dMlR5jz+yOYrFtOtsnlt6OT2+1dOiOrV6/fPDZHdCc
	 6YWWBMQ7lv40A==
Message-ID: <b2cd921b3682355b0c64d107f1dae998@kernel.org>
Date: Mon, 08 Dec 2025 11:06:10 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Tomi Valkeinen" <tomi.valkeinen@ideasonboard.com>
Subject: Re: [PATCH 0/4] drm: Revert and fix enable/disable sequence
In-Reply-To: <20251205-drm-seq-fix-v1-0-fda68fa1b3de@ideasonboard.com>
References: <20251205-drm-seq-fix-v1-0-fda68fa1b3de@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, stable@vger.kernel.org, "Andrzej
 Hajda" <andrzej.hajda@intel.com>, "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>, "Aradhya
 Bhatia" <aradhya.bhatia@linux.dev>, "Chaoyi Chen" <chaoyi.chen@rock-chips.com>, "Chun-Kuang
 Hu" <chunkuang.hu@kernel.org>, "David Airlie" <airlied@gmail.com>, "Dmitry
 Baryshkov" <lumag@kernel.org>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Jonas
 Karlman" <jonas@kwiboo.se>, "Jyri Sarha" <jyri.sarha@iki.fi>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Linus Walleij" <linusw@kernel.org>, "Louis-Alexis
 Eyraud" <louisalexis.eyraud@collabora.com>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Marek
 Szyprowski" <m.szyprowski@samsung.com>, "Marek Vasut" <marek.vasut+renesas@mailbox.org>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, "Maxime Ripard" <mripard@kernel.org>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, "Philipp Zabel" <p.zabel@pengutronix.de>, "Robert
 Foss" <rfoss@kernel.org>, "Simona Vetter" <simona@ffwll.ch>, "Thomas
 Zimmermann" <tzimmermann@suse.de>, "Vicente Bergas" <vicencb@gmail.com>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

On Fri, 5 Dec 2025 11:51:47 +0200, Tomi Valkeinen wrote:
> Changing the enable/disable sequence in commit c9b1150a68d9
> ("drm/atomic-helper: Re-order bridge chain pre-enable and post-disable")
> has caused regressions on multiple platforms: R-Car, MCDE, Rockchip.
> 
> This is an alternate series to Linus' series:
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

