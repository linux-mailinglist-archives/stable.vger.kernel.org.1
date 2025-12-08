Return-Path: <stable+bounces-200343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5F0CACFF7
	for <lists+stable@lfdr.de>; Mon, 08 Dec 2025 12:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1561C301E6FB
	for <lists+stable@lfdr.de>; Mon,  8 Dec 2025 11:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C847313E08;
	Mon,  8 Dec 2025 11:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RZdoCdds"
X-Original-To: stable@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B0817C9E
	for <stable@vger.kernel.org>; Mon,  8 Dec 2025 11:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765193229; cv=none; b=XuEc4yVWl6CUOUfqpW/AVrK2mvIeVHkCyrLF945Ju2QS3TXnucEgtzetnIl9Ddv/uMlje26r2mc08A/f5Mz9il10SDNIVBGQqBmZch7UkwiDE+bJ459Lt9e2z99jR/O6u1DbTuy+hnNgbHpX+LyLaykVqFhmEevmBRMXh3TnABs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765193229; c=relaxed/simple;
	bh=Uxvc0qN1aVKZrytCBMtpqiJHC/U5kWCKmiBua2qivZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cKiuYjMDezWCZMCdIZfegn0Vh+b1KfvXvagUjj7xMPTqUcA3Un+pQgquRmT6iLmx+lyP8Rnj4hfkw/v4S51cBzNJo2t2qBucZ129tG5LEVYrX6E1PJ6qPHXMASiT7CFXMmexDaZsJ2hi5x+QK354nqOtvcfkacDZ2i2KAquAMuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RZdoCdds; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3f2aee2b-578a-4d82-8dac-14cb9f2ada05@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765193224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KS9+fkJURzUJE1mmvUiBXK04jhbhsrgQmnTnkE10avY=;
	b=RZdoCdds7YbZnHkW/nYm6bY4Esp1KjkxKwlJIihYgTfYeYRjDlUR+QMDbixZCFIL3ijkfb
	MRc4SImvpFbKrkzgt+mxIM/1RqwJgHViy1Bvvv5PWU7XWqKJfJYPOIEoDHWSHfQFq+aJD9
	6YpG+e5x6gt+bZ2igvQFu1iLzobsD64=
Date: Mon, 8 Dec 2025 11:26:54 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 4/4] drm/tidss: Fix enable/disable order
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Chun-Kuang Hu
 <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Jyri Sarha <jyri.sarha@iki.fi>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 Linus Walleij <linusw@kernel.org>, Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Vicente Bergas <vicencb@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, stable@vger.kernel.org
References: <20251205-drm-seq-fix-v1-0-fda68fa1b3de@ideasonboard.com>
 <20251205-drm-seq-fix-v1-4-fda68fa1b3de@ideasonboard.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Aradhya Bhatia <aradhya.bhatia@linux.dev>
In-Reply-To: <20251205-drm-seq-fix-v1-4-fda68fa1b3de@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 05/12/2025 09:51, Tomi Valkeinen wrote:
> TI's OLDI and DSI encoders need to be set up before the crtc is enabled,
> but the DRM helpers will enable the crtc first. This causes various
> issues on TI platforms, like visual artifacts or crtc sync lost
> warnings.
> 
> Thus drm_atomic_helper_commit_modeset_enables() and
> drm_atomic_helper_commit_modeset_disables() cannot be used, as they
> enable the crtc before bridges' pre-enable, and disable the crtc after
> bridges' post-disable.
> 
> Open code the drm_atomic_helper_commit_modeset_enables() and
> drm_atomic_helper_commit_modeset_disables(), and first call the bridges'
> pre-enables, then crtc enable, then bridges' post-enable (and vice versa
> for disable).
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Cc: stable@vger.kernel.org # v6.17+
> ---
>  drivers/gpu/drm/tidss/tidss_kms.c | 30 +++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
> 

Reviewed-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>

