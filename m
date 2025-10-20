Return-Path: <stable+bounces-188034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BFBBF0933
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 12:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B36E188A3C8
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 10:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EF72FBE15;
	Mon, 20 Oct 2025 10:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FW4/sZPF"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F582FB0B1;
	Mon, 20 Oct 2025 10:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760956562; cv=none; b=U264PP9rRwftgq3N1izOGdcKiRWstUKp+D8rM6oyd9uI/K4YQs7ECvHczmw8ukUBhvs5FJprd09EOXccdrZJAkiJrRw0UeVWPvHamKq2nINrXKau5FDVrOvFRaA+p+b66iTbRzaVbh7RdYrJANw9+av4yhue/zi5J5f0QLZRQsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760956562; c=relaxed/simple;
	bh=GlPRnhvTkY2sAG96sRPyf5FBZxMsGVmonJWGyXdZSIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aIRPCsPFA//0GbovMlOQzD8VRUYeQZodlgPIvfIi3U55eYvILSnoXKylrnkWyXHC9S+w3mtwlIGnCSDrnfAKnHsa7qhW6I5BOUrK7NK0qP5bgwsaRt1noaUb6l9rZjuqqrT1XmP3Wa7BmPto27mh2WE/rwahGDRgXTzXsOd2yuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FW4/sZPF; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760956559;
	bh=GlPRnhvTkY2sAG96sRPyf5FBZxMsGVmonJWGyXdZSIY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FW4/sZPFX43xuFdEiJI19pfIOQZMgoWWmmzWhTmD565solxcwhJRc5+t0YNEZXrIK
	 PKPlqh1cuUwlAdmnvQsrT8GoHMh+ihMOm454CBwSX/1mFuQiY+KlxH2w5OeuHu3nqA
	 p8FFZiODXjTPnnIzgVQm/q0v+fy3Ao6XfxIhTvI/mcorrcWx/dul0eZX66aQvg8Rmw
	 3Kh1Lei+jjAn8I0gGya9lv2rRSNHyKGwRCQou1p/6ZMsXcWSiSumtWlSNBN0qygDL4
	 apiK4hSZbnp4qnmpKhLTt6s7mBZ+tUXLi1EiVU9Vj9Fn2MDKB8MeP1po6vBR0cwM57
	 SuQDwrNwGapwQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9764B17E108C;
	Mon, 20 Oct 2025 12:35:58 +0200 (CEST)
Message-ID: <20a763e9-3574-4284-ab3a-f25f18d50c6b@collabora.com>
Date: Mon, 20 Oct 2025 12:35:58 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/14] iommu/mediatek: fix device leak on of_xlate()
To: Johan Hovold <johan@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Sven Peter <sven@kernel.org>,
 Janne Grunau <j@jannau.net>, Rob Clark <robin.clark@oss.qualcomm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Yong Wu <yong.wu@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Thierry Reding <thierry.reding@gmail.com>, Krishna Reddy
 <vdumpa@nvidia.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20251020045318.30690-1-johan@kernel.org>
 <20251020045318.30690-6-johan@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251020045318.30690-6-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/10/25 06:53, Johan Hovold ha scritto:
> Make sure to drop the reference taken to the iommu platform device when
> looking up its driver data during of_xlate().
> 
> Fixes: 0df4fabe208d ("iommu/mediatek: Add mt8173 IOMMU driver")
> Cc: stable@vger.kernel.org	# 4.6
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> Reviewed-by: Yong Wu <yong.wu@mediatek.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



