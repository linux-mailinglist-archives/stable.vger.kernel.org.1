Return-Path: <stable+bounces-107834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2DBA03EDD
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 13:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A8971885303
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 12:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2BA1DF756;
	Tue,  7 Jan 2025 12:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OS+x5My5"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0708C1E;
	Tue,  7 Jan 2025 12:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251982; cv=none; b=bM0X8DyB91QiJ6NNJbN6uIL5IhWyyWOI70HrTPrnBXOZ6dyunkymJ9RrddQow6c58p5p4BW+TTg9RaiDntKggwQFTtifkdP48Aeu7EfLeJUB9fiGkjQap3bdk2SBpK68ZWRa/xnx058VAdddBzi7IQ1zaFutRbEHpoLfELqL69U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251982; c=relaxed/simple;
	bh=LT27heAOjDF/SMRtDIkYdufE0ltxFQe7yGYcUmlMEEs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gUgSlqb4yLLAsNM9jsvumi6Oc76Kn8pBxDaYNka8qcPC9fxWRRrvad1hlKgdLVSLhMUnbL56McS7uMACdvX2PlJJ80uRCN52Ki625KY4t8PV66c5FNPXiYF5YRub+pTXSCXMBp8zYLJasFolDZKGM5uIXi+JY2kobwbusdQrCkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OS+x5My5; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1736251979;
	bh=LT27heAOjDF/SMRtDIkYdufE0ltxFQe7yGYcUmlMEEs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OS+x5My5y8Zv5tCI8vuqHayvFk8ihZvw1yn7i52y3H4RHZ1VeHrcwhAWnuytJpsA2
	 e3l/d8L9C8vSFT/bZKg2Tz0HCswnAIk0C9tGg3QLEFaKaIRnea9c6S3Gs7V6DvbC/H
	 CW+tVCSqaGor1XEy26aE2la2ORQGxdjbI4sw9nXyvWl7CYKwCvZZQb1QfMK96MxmP9
	 YxQyey4LoqBx59UCjRKgQ646EqCkVXci9JQo6MmjL3vb65SMFETKDoz79DNyTLzsS3
	 xSW92+7rbFxS9GMTWz1zGkq3Lg6iOBGc+gbX22UpFMXKx5SiudnOjMYOIirpmTK2Lc
	 8ltX5BzqPgw+g==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D3B5817E152A;
	Tue,  7 Jan 2025 13:12:58 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 Neal Liu <neal.liu@mediatek.com>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: stable@vger.kernel.org
In-Reply-To: <20250104142012.115974-1-krzysztof.kozlowski@linaro.org>
References: <20250104142012.115974-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] soc: mediatek: mtk-devapc: Fix leaking IO map on
 error paths
Message-Id: <173625197880.58535.7586799150314757117.b4-ty@collabora.com>
Date: Tue, 07 Jan 2025 13:12:58 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Sat, 04 Jan 2025 15:20:11 +0100, Krzysztof Kozlowski wrote:
> Error paths of mtk_devapc_probe() should unmap the memory.  Reported by
> Smatch:
> 
>   drivers/soc/mediatek/mtk-devapc.c:292 mtk_devapc_probe() warn: 'ctx->infra_base' from of_iomap() not released on lines: 277,281,286.
> 
> 

Applied to v6.13-next/dts64, thanks!

[1/2] soc: mediatek: mtk-devapc: Fix leaking IO map on error paths
      commit: a985d806d231ab40992f59a8bf96acf1b7a94762
[2/2] soc: mediatek: mtk-devapc: Fix leaking IO map on driver remove
      commit: c2bcebc6fbf74a5aa5b127349d5cd15577d78cd6

Cheers,
Angelo



