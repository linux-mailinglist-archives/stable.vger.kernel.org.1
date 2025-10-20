Return-Path: <stable+bounces-188033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC00BF092D
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 12:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB90F188F80A
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 10:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30FC2FBDEA;
	Mon, 20 Oct 2025 10:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="b1GKZjqF"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5202F83DF;
	Mon, 20 Oct 2025 10:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760956561; cv=none; b=FT8QwWqHBQaj9p02dNiAqL2G285BAxO3XTuvir8S5OPRlZPYyi+J5EQZWGjEMgOQu6AF4Pd4ieDzO1weOJJlocKPnO/S45mPJgOD1F8eTb0yhwgmGG9AmNd0iNU7qMbN60N+kiXAtGh8urQuuCxeDE9AZHmpnnCdQ3n2W1V8/Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760956561; c=relaxed/simple;
	bh=1rDA5pW/PXgKlX69oteGcZotgG2f37mTGcLdniqd/Ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HuCMNmVHuPhvdsENJuYJwhumbQtTKUPTXcqlm+USsu5TE3lkCz3qbBlfshI62RnUtZtB9+OVmmnCF0US/09hVg40CcE1+XfmVeuVFuhDasxfJn6LqPf8ogsVscYsFF/1Qtfnr8Ab50J8hwHH9xJjvYxjv2NAM8ITSXHuGD+65sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=b1GKZjqF; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760956558;
	bh=1rDA5pW/PXgKlX69oteGcZotgG2f37mTGcLdniqd/Ow=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=b1GKZjqF7sJqkoxEAdPSxJ4pepOxshB4Ov7T8sQlUBTZNBTSaZVQWiVc/mk75BQd6
	 9foSwCgRzKnXbLcxAONA1K2KnvOFhIm59KlM/8tOVfuDt5cHDxfgw8MNfm1q4fh/c8
	 j348nSbYuxA6LAci1NC8apAxKv8rYBXVokgqvN1S1EsHmbet8E0lCNYyGbemKqdSo4
	 /x54vuszNaskxgjvXOHCPWYDuS3TZ+B8gwCae61o9FLh8BGEf9xiuO6IIT8UqlExVT
	 8hE32+ZUizxzBpPp6F2rWBQ/x7UGNEpEXuO+Vy1uRG35p/rG4zijPOn6lTjWJFzYFk
	 Ll0G0vtsEnjTg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8EADD17E0FAD;
	Mon, 20 Oct 2025 12:35:57 +0200 (CEST)
Message-ID: <7a0b8e58-1389-4409-abdc-a66232a70d4a@collabora.com>
Date: Mon, 20 Oct 2025 12:35:56 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/14] iommu/mediatek: fix use-after-free on probe
 deferral
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
 <20251020045318.30690-7-johan@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251020045318.30690-7-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/10/25 06:53, Johan Hovold ha scritto:
> The driver is dropping the references taken to the larb devices during
> probe after successful lookup as well as on errors. This can
> potentially lead to a use-after-free in case a larb device has not yet
> been bound to its driver so that the iommu driver probe defers.
> 
> Fix this by keeping the references as expected while the iommu driver is
> bound.
> 
> Fixes: 26593928564c ("iommu/mediatek: Add error path for loop of mm_dts_parse")
> Cc: stable@vger.kernel.org
> Cc: Yong Wu <yong.wu@mediatek.com>
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



