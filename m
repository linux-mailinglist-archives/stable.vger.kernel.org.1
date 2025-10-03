Return-Path: <stable+bounces-183166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE65EBB63B5
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 10:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9816F481735
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 08:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A54825EFBE;
	Fri,  3 Oct 2025 08:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="O9dz+Yxq"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E6023D7E2;
	Fri,  3 Oct 2025 08:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759479607; cv=none; b=NAeGKp3FKC2y/k2ZDJNxQsinubAgyMd1BdURf8jGzIBnMCW8KKp46DN92UCaO7ZLy75xK6EUV1s0sgWzn3n3Hl6+iQ3lVm1Gxw4pP/jd0hFgPKA4ePMG0uH9chlOe02RAaDOrHDrbOZ91SXYwe1orpEzQ3hImTZv+VnFbIn76i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759479607; c=relaxed/simple;
	bh=ITjlkM0aGbos1XSt8ueuI2NEXdJ0dWrdlYRm6k9TIrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bq+wnKeR3ooLjnu3mTp3nFTm62f12/rqugs4jktA3/07LER9JC5akY0LIVwZ+Z8j5smdTx4RjopNijEkLUkeYFnF/AS9fZGMJoIXo9vJ+mxCvimWwfgzIcToWMCeHWJJ7Y0pBiZkjt1wQ+6091iI5vVLU8LFzlVftqxV9hsQgg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=O9dz+Yxq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759479603;
	bh=ITjlkM0aGbos1XSt8ueuI2NEXdJ0dWrdlYRm6k9TIrk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=O9dz+Yxq50GBeUPj/rHINpU4WkHjjZFDuyxvTgrx3OVsWKoiEnfxmAR0+VIOIzxAP
	 rLVYoNKtfhFJWcSoAxaq5kAuUjxHt5SebW5fxERuO73qn0yF2ko84OIBIFdV7idXyx
	 23ncQAwcVx6CXmV8k7qy6hodmoDpBKGw75yvdhV4z8jlExPfcc8g+dykS08bZiXtVg
	 4hKHTicInZfc6yYalFDczTANuxVmPOs0Rt3Io/ZJqmPe1riuA3/pnjY7JCoXJqt5by
	 s/VIXnI9c2Bk2G9ZfHHUcbKv2iHZ78FDl9QWT+rf/x8GVLe6kpgi9JvhwzSy08YoDN
	 h2ZQqrQgka7/w==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AE23D17E129E;
	Fri,  3 Oct 2025 10:20:02 +0200 (CEST)
Message-ID: <6ad27d61-5907-437b-afda-6e1453a19f88@collabora.com>
Date: Fri, 3 Oct 2025 10:20:02 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/mediatek: Fix refcounting in mtk_drm_get_all_drm_priv
To: Sjoerd Simons <sjoerd@collabora.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 CK Hu <ck.hu@mediatek.com>, Johan Hovold <johan@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel@collabora.com, stable@vger.kernel.org
References: <20251003-mtk-drm-refcount-v1-1-3b3f2813b0db@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251003-mtk-drm-refcount-v1-1-3b3f2813b0db@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 03/10/25 10:08, Sjoerd Simons ha scritto:
> dev_get_drvdata simply returns the driver data part of drm_dev, which
> has its lifetime bound to the drm_dev. So only drop the reference in the
> error paths, on success they will get dropped later.
> 
> Cc: stable@vger.kernel.org
> Fixes: 9ba2556cef1df ("drm/mediatek: clean up driver data initialisation")
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



