Return-Path: <stable+bounces-188032-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01529BF093C
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 12:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6839A3B4DFB
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 10:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356E42F8BD2;
	Mon, 20 Oct 2025 10:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VN6MfDXl"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F0D2F6933;
	Mon, 20 Oct 2025 10:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760956560; cv=none; b=fHqm5x2Xo0rQoS1A2acrdBd1zAUS4yVgo6W+tLmAiTKeFUM+UPITdAzkSjAQzRI4LYpNys6N387GDHsCWbzbCV7DLWyGO2wYvSpviSjjVa8nB2plxuis6QwVJa1Z53SIDnZrCNDmJeD9exuCH63RaR3T/o4qbsePebpOmr5fvds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760956560; c=relaxed/simple;
	bh=V4y+htwEdDmlnLK1Fy+0wRN95xzwTz+++IQ2l0uvEM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YS3vcwZ6olrTs6Eh8pvMjmuw3jMywUOiUQ+bL/r9uP68gwwO12U/FqLZLr+4xnOVoN22S777sx7hktD84P5wCYb+gx9m1DWq5MCCipUJpvTKeyuC5Z49d5UrugoBe/FlLx3UaFdx460XQ6oit45utyRqY6LP+xuxnLsVQswZ2F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VN6MfDXl; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760956556;
	bh=V4y+htwEdDmlnLK1Fy+0wRN95xzwTz+++IQ2l0uvEM0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VN6MfDXleMzUgYPAqde+/NStyEs/FvxzccEouEiYA07mr8NfQC96cQhOoR0eiq3Xu
	 ZqdmP/thH4nT3adCmRBgKJOFLOn1bEe0W/uYR9PO6cz4HGSICLF4fICP2u+MPlHbYL
	 AxMyD0ziBu0p0Kf1rhywGhZr3TKpe16ePuCNl26ig6KAVR83GSACyozArd0NpwRvI4
	 /AjOtQLhbiUAOX2W8+o9CAbYFLKWOoDnLSGiSfeaboe4OVm/Vkcpc5yfKUR9ZDzAVO
	 /4iURn10rwFcdrURFFRpGRcvSxy04Tufjr9GvoLyo9/MApfG4lqY2R30lWTZ/hHhWx
	 aNHS76UKI7VCQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A622017E13F9;
	Mon, 20 Oct 2025 12:35:55 +0200 (CEST)
Message-ID: <9177efff-3ded-4ea8-844c-c1a2178c58d4@collabora.com>
Date: Mon, 20 Oct 2025 12:35:55 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/14] iommu/mediatek-v1: fix device leak on
 probe_device()
To: Johan Hovold <johan@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Sven Peter <sven@kernel.org>,
 Janne Grunau <j@jannau.net>, Rob Clark <robin.clark@oss.qualcomm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Yong Wu <yong.wu@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Thierry Reding <thierry.reding@gmail.com>, Krishna Reddy
 <vdumpa@nvidia.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Honghui Zhang <honghui.zhang@mediatek.com>
References: <20251020045318.30690-1-johan@kernel.org>
 <20251020045318.30690-9-johan@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251020045318.30690-9-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/10/25 06:53, Johan Hovold ha scritto:
> Make sure to drop the reference taken to the iommu platform device when
> looking up its driver data during probe_device().
> 
> Fixes: b17336c55d89 ("iommu/mediatek: add support for mtk iommu generation one HW")
> Cc: stable@vger.kernel.org	# 4.8
> Cc: Honghui Zhang <honghui.zhang@mediatek.com>
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> Reviewed-by: Yong Wu <yong.wu@mediatek.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



