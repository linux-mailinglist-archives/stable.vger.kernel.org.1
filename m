Return-Path: <stable+bounces-188031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EAABF0936
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 12:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B2C03ADE68
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 10:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309A82F7AD5;
	Mon, 20 Oct 2025 10:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WGIjd0V+"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA1C2ECEA7;
	Mon, 20 Oct 2025 10:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760956558; cv=none; b=UZ02uYEh7XStbzA8SH+Pi8SbtWZpfbZX3XgmN0Ss7g2ApZYqoAupRLvMYUZlPFKj6HVtLjfVGqO9SexSncfjkM+nrCkRWQLlP5Uq2z0ZI1CdNu5kEVzqamYLF9FLLJet8mLIVB+8MmGQ2/LCFtGVXA/36134LNmEGKiTiNIK2gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760956558; c=relaxed/simple;
	bh=EBhRgaiQ6/W9CPnpGDJ5KuATCP7EtkH0S/7FRN0UfMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fnzBqnylHmI2DNb0c75NAW26dcqeaoaydgj4P9YceC6n4gBgmBaukHlrCr5NBK00H9z+rfHj17MZJ/PVJJUSVla+JfVSnxUTsRaiJojob2vl+F3rTNYyay1VQlnSE7DdPDWsFhPR51DeH2ZCPlsrYLVfg6ZZoUyNYok04/IkYxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WGIjd0V+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760956555;
	bh=EBhRgaiQ6/W9CPnpGDJ5KuATCP7EtkH0S/7FRN0UfMI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WGIjd0V+RgumDJYFFKGx+s83IOl1hwloTZTw4+2oIDIjqU7ylMQbLImzZZDWALo1J
	 jbbmvoOTSzhl8H5wg5PPj+UCWrAOImTljSZ4E6YvJyJMjvn1xZlPS1wmvDhb4wrXba
	 tLC+euW9wc7b4DjOjKBmyHzU0hnpZdKi4OPXQjyfV3Vi6L60U4niT9gXMn9TZnuRAW
	 eVW8uszDadUGjAv2XGuwlcsfUOj3MDjpEBF3tEz4uvpvTlas02uRlGVxw/XXysqe2B
	 VMyHnDDFhbSnSCcmWJHojVW2hbEcdS3asTD9xTRQJQ6NU5O9TkafMCq4ev234Mx6L8
	 Tud9g8HIAxzPw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9487C17E130E;
	Mon, 20 Oct 2025 12:35:54 +0200 (CEST)
Message-ID: <6af6bf9b-1188-49eb-bcb6-f0355afa4c7a@collabora.com>
Date: Mon, 20 Oct 2025 12:35:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/14] iommu/mediatek-v1: fix device leaks on probe()
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
 <20251020045318.30690-10-johan@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251020045318.30690-10-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/10/25 06:53, Johan Hovold ha scritto:
> Make sure to drop the references taken to the larb devices during
> probe on probe failure (e.g. probe deferral) and on driver unbind.
> 
> Fixes: b17336c55d89 ("iommu/mediatek: add support for mtk iommu generation one HW")
> Cc: stable@vger.kernel.org	# 4.8
> Cc: Honghui Zhang <honghui.zhang@mediatek.com>
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



