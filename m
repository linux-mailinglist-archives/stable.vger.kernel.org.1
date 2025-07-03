Return-Path: <stable+bounces-159864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C4DAF7B1B
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D31A188BC2B
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EB62F19BF;
	Thu,  3 Jul 2025 15:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvSYvhWQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826392F19AE;
	Thu,  3 Jul 2025 15:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555596; cv=none; b=qvbLo5/FRGBiUMEoouUlRsdWnbMxduDsmpd7cf3YuLLY59LB4sgd+KLxz4V67BrZxGYap935SdqVsAWVbO6vqdmGir+qJWnbVRJNfN3jTIZrbZPW3zctMaWGQQtdnHJfJKU0CY4dWaMwQrnUOWmhriBIAlKs48PJIS2vj14LfY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555596; c=relaxed/simple;
	bh=8e5mj+lNVEPhzv6lVExpdk5WTdjfGcM+AvYmWCMOf/Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VOdLedDX6KnPcq/LnNi5jeXPS7/awWT8Znbl5qJHQ5qzc4ayyMxtcEKYSCa6qlHE1unGLBRlfPejYYgJ2MfQJRtsRneLtEGFmrYoPyrvoVeubrPCl1agEN1aeQIlr/nzPW1wpXEu9eWrk0PElYDKLjJvJoXdOgMdamMNZ1SteJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvSYvhWQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A21C4CEF2;
	Thu,  3 Jul 2025 15:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751555596;
	bh=8e5mj+lNVEPhzv6lVExpdk5WTdjfGcM+AvYmWCMOf/Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EvSYvhWQKzKV27w7+3Ixr/7N1sLHclKLx7rxFl8hztoEiB9UEDZXFfnyJy+Ax8yVX
	 zx2rVF3oiVJ11sWkrknBIDPtMOvdEYevge3k3Xw9LvmlBGD49uQ/qd1Ku7h+KaAYym
	 rMQobezhY8xiv75FaN+JJwjC7wDf4nfDQ8ffj058gv/v/TNmAZi7+YOdwxH2OgeYYN
	 /I8sANGHL9rrFBfVbHXazhJSJSk5EzYHeS0NBX3ZagEgZrSuAdV8PlmfqalqgOcCG6
	 aWFsMEISu55ziLVNqkUUO3FFzM2Nt2x5/z+AcOwZPkZ1e17zWeGk5H0i+SVtJ+nrT9
	 2Sp+Qzkye9+kw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Michael Walle <mwalle@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Miquel Raynal <miquel.raynal@bootlin.com>,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org,  Jean-Marc Ranger
 <jmranger@hotmail.com>
Subject: Re: [PATCH] mtd: spi-nor: Fix spi_nor_try_unlock_all()
In-Reply-To: <20250701140426.2355182-1-mwalle@kernel.org>
References: <20250701140426.2355182-1-mwalle@kernel.org>
Date: Thu, 03 Jul 2025 17:13:13 +0200
Message-ID: <mafs0bjq11f5i.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 01 2025, Michael Walle wrote:

> Commit ff67592cbdfc ("mtd: spi-nor: Introduce spi_nor_set_mtd_info()")
> moved all initialization of the mtd fields at the end of spi_nor_scan().
> Normally, the mtd info is only needed for the mtd ops on the device,
> with one exception: spi_nor_try_unlock_all(), which will also make use
> of the mtd->size parameter. With that commit, the size will always be
> zero because it is not initialized. Fix that by not using the size of
> the mtd_info struct, but use the size from struct spi_nor_flash_parameter.
>
> Fixes: ff67592cbdfc ("mtd: spi-nor: Introduce spi_nor_set_mtd_info()")
> Cc: stable@vger.kernel.org
> Reported-by: Jean-Marc Ranger <jmranger@hotmail.com>
> Closes: https://lore.kernel.org/all/DM6PR06MB561177323DC5207E34AF2A06C547A@DM6PR06MB5611.namprd06.prod.outlook.com/
> Tested-by: Jean-Marc Ranger <jmranger@hotmail.com>
> Signed-off-by: Michael Walle <mwalle@kernel.org>

This patch hasn't had much time on the list but we are already at -rc4
and I want it to get some time in linux-next. If later reviews come in
and changes are needed, I can drop it and apply the new version. So
applied to spi-nor/next. Thanks!

[...]

-- 
Regards,
Pratyush Yadav

