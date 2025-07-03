Return-Path: <stable+bounces-159322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07951AF77B6
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 16:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04F3F7B665E
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 14:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564F62ED143;
	Thu,  3 Jul 2025 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZX1gEZ2M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C0553365;
	Thu,  3 Jul 2025 14:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751553393; cv=none; b=MbChFXeFGfw74DBQ+VQ3xZncb0dfHtWgLLVjkwEo2jZq1UYbsXd9/WIRhlfnmKJVtTW/ZvxaUmNz4bQDhlyPeDxEwZL6T0bkifCPJXFVzRShrkBw7KvfAp9feijK1bxyKfkR6UiDFo8IKEy2p2ZIsReHupEFU8LD79cXg87dixo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751553393; c=relaxed/simple;
	bh=nVETv5P+aZJXZMi/j9tZ4lMlgii5uB8/cLl650IqYz4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b9eo2+no1bXGPD/aL6/S83fwhMpqGJGQW7YAe2KrUwk/7s1uHKfwxd2LhRzPsajCvMGQGaKyzRfYLFr3t0sbvoORBE5y6aTmXuxw8hp1SEwSFrRKF+HIYoPLF17qzd7oWXbdjXfABJahLVnCrSLM48YGT/wFnXGgvVeApnU9oy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZX1gEZ2M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4288FC4CEE3;
	Thu,  3 Jul 2025 14:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751553392;
	bh=nVETv5P+aZJXZMi/j9tZ4lMlgii5uB8/cLl650IqYz4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ZX1gEZ2MfK1BlIWOgyLEvlzdfuO2erIRE46NeqJirWqY6OZzikE6lonT111+8HmaT
	 TCOwfMTmTOVW7Cjphh81nYEWjNn+hTkEYq93XWVE415vOdmboI1FpXLMoq6m3gfTU1
	 IXsqCPmx6xPRGRd1TeV0CsP03HXcmjxmmkHMxCOVSXoAfYBnY3GzDHthoKnub60/Kd
	 B6C+INru0iZXzK8g2SsLOsclpZeRr12Uw00vIgpT2UVIOIc8fPv2KFmxKYeN5D8p/T
	 rSGCcy3dmsa9Pd9Q3tP0P2gwCW2fRz4AFJU6swTckApFni+/Dk6TyBBuyTnnKEe+M9
	 5Yp+Kxet5QD/w==
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
Date: Thu, 03 Jul 2025 16:36:30 +0200
Message-ID: <mafs0sejd1gup.fsf@kernel.org>
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

I suppose some of this code would be cleaner if we declared a size
variable instead of typing out nor->params->size every time, but I don't
think it matters too much so this patch is fine too. Thanks for fixing
this!

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

