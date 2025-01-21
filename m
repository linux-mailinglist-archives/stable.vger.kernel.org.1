Return-Path: <stable+bounces-109596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1443A17A8A
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 10:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C40DC3A39D1
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 09:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B721C1F0F;
	Tue, 21 Jan 2025 09:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DjwuNruN"
X-Original-To: stable@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6047B3BBE5;
	Tue, 21 Jan 2025 09:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737453217; cv=none; b=CxzaUibgEjBPQ8foo34kvWAlOYN61toz5k7fqJ05FUmKWfxZwOk45LUvPU/nMHS7fnQata4Fp8HPG7NJ58ljYL6d2JW3DekJJu78mI05T9Wv25wGdTnhvF7rhI3mPnmzjl4GpoAiGpB6s8ixfg1qJT0n/ao57/3vw3jk7+Ix+30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737453217; c=relaxed/simple;
	bh=G+c6kQoGMII5VVsutdEuxvBRff1dE5WdMaDtL/pUrqU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NiMtqin0TO77Dmw0R87XPwcT5262Y5zmHYrM2dJ2fLeYbktd1g0gWn0B9NcKfX5VIrCnYn5ZVMgbbqeBK1wfLYJt1GBEsJdZ0lF0R+zg3Z4oRgkQgj343dAcyQkQvB+kz1xXHDbMUOrFsC4GFn/qEkx3j68U9hRx4cds642pLhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DjwuNruN; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A2ED3FF811;
	Tue, 21 Jan 2025 09:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737453207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G+c6kQoGMII5VVsutdEuxvBRff1dE5WdMaDtL/pUrqU=;
	b=DjwuNruNGDTiV/G6vejkSBTSpcBLSk3yVsf6RR7t/BviF9sNhEXHYAUC7FqQMu0pJwIDDF
	AziEnKbIk4Wrp0G201/tESCyRdTKQUw6yX7sWiF28of7bnTwlPAAcIHsTs+8BtffBV/tsS
	pfYex/+amlQ2HyWPl1ENdOucWoURjvSajsQDrh2AQy6QHU4zg1OG1wdFWnHcjYlHsJNbnt
	MrTz7Y/GDU+VA0uzBzDOgE4Kyu/F0dpHb55U0juMNGpa2F/0MmWjq4yCEodMr0k/euWV3i
	3RXF/rrXcX+HxlldP6eeB84vha9yj2vKmlONYCgVfBphz83hzzr7Eg11vS75dw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: niravkumar.l.rabara@intel.com
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  linux@treblig.org,  Shen Lichuan
 <shenlichuan@vivo.com>,  Jinjie Ruan <ruanjinjie@huawei.com>,
  u.kleine-koenig@baylibre.com,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH v2 2/3] mtd: rawnand: cadence: use dma_map_resource for
 sdma address
In-Reply-To: <20250116032154.3976447-3-niravkumar.l.rabara@intel.com>
	(niravkumar l. rabara's message of "Thu, 16 Jan 2025 11:21:53 +0800")
References: <20250116032154.3976447-1-niravkumar.l.rabara@intel.com>
	<20250116032154.3976447-3-niravkumar.l.rabara@intel.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 21 Jan 2025 10:53:26 +0100
Message-ID: <87ed0wpk6h.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hello,

On 16/01/2025 at 11:21:53 +08, niravkumar.l.rabara@intel.com wrote:

> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
>
> Map the slave DMA I/O address using dma_map_resource.
> When ARM SMMU is enabled, using a direct physical address of SDMA results
> in DMA transaction failure.

It is in general a better practice anyway. Drivers should be portable
and always remap resources.

> Fixes: ec4ba01e894d ("mtd: rawnand: Add new Cadence NAND driver to MTD su=
bsystem")
> Cc: stable@vger.kernel.org
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

Thanks,
Miqu=C3=A8l

