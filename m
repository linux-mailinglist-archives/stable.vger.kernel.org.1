Return-Path: <stable+bounces-43500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 329CA8C0FDD
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 14:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 381181C2231C
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 12:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCBC146D7B;
	Thu,  9 May 2024 12:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQoXxdBT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B672913BAE3;
	Thu,  9 May 2024 12:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715258817; cv=none; b=V9dXHcQXRxgEfOl13z0i3S92LEPhl9RZTbVOKSAbKJzou0iVSZNeX59kEnqK7ANKFbd+gr/EvH3qcaVzGPLIPC9t0GDJod34jAEbtHOmlFKRtBF03yGztAlebWZiDqlWqEkeaeBy9EryXNnpFWJZbgSnv2FyhBHt4ygwyQ+ilQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715258817; c=relaxed/simple;
	bh=Y1puUf3Rn4PFEIfYWjo05C5VlGgGVxqEMZoIhApAwoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJmO1sxx8jCR1DM2/MaECwS1fxcpxzDcFxeR3I0KkZFHcXlKNxAfT2Oec/HnH5frzFSMvZ+Voe/6kZyQNc0WrxsB5a92rIUPeb2P9gmdBIKPBa6NwLVPbDJ0JK+SqYNALztuiY6DlJBScvThtdbV3oijvMpCuayAxIK4SqUn7hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQoXxdBT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D71C116B1;
	Thu,  9 May 2024 12:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715258817;
	bh=Y1puUf3Rn4PFEIfYWjo05C5VlGgGVxqEMZoIhApAwoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AQoXxdBT+Gf6/1FnwrPKEUEL8un/LA/u/2/sGpDCC3rxgKcoqyWXiIYW010ItlUum
	 CLW5mYm545cimXqZBYmCGhgG0TDtnkqwrORVR4iSIbEqIRhyhcrt3kwfXNkXg6K64O
	 w/OV3lp+KVg/vrgpg6Otpk5K6rEE7UjvK0+ZQ/3ke7FMj3+1HjaVBF4DAXoz4gPzwI
	 0n+UHl6L4pv6WqF0RUQ69KZCeD51zRNa7aM9mIiyeZyDaYmsZpsgrROCD8g6oq1W5t
	 bWTjyIxOyJS//5RBCY/Nlq3g0oX9RTKZSdE+TICUdGYgN2wahiJLQ61bVw8OeIOqkv
	 DvX0r1wcBJS5w==
Date: Thu, 9 May 2024 08:46:55 -0400
From: Sasha Levin <sashal@kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Joerg Roedel <jroedel@suse.de>, yong.wu@mediatek.com,
	joro@8bytes.org, will@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, iommu@lists.linux.dev,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 4.19 7/7] iommu: mtk: fix module autoloading
Message-ID: <ZjzFv38K2fudS_zQ@sashalap>
References: <20240422232040.1616527-1-sashal@kernel.org>
 <20240422232040.1616527-7-sashal@kernel.org>
 <Zied1/2cELhaQupG@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Zied1/2cELhaQupG@duo.ucw.cz>

On Tue, Apr 23, 2024 at 01:39:03PM +0200, Pavel Machek wrote:
>Hi!
>
>> [ Upstream commit 7537e31df80cb58c27f3b6fef702534ea87a5957 ]
>>
>> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
>> based on the alias from of_device_id table.
>
>This patch is queued for 4.19 and 5.15, but not 5.10. I believe that's
>wrong.

Heh, this is funny. It fails to build on 5.10:

drivers/iommu/mtk_iommu.c:872:1: warning: data definition has no type or storage class
   872 | MODULE_DEVICE_TABLE(of, mtk_iommu_of_ids);
       | ^~~~~~~~~~~~~~~~~~~
drivers/iommu/mtk_iommu.c:872:1: error: type defaults to 'int' in declaration of 'MODULE_DEVICE_TABLE' [-Werror=implicit-int]
drivers/iommu/mtk_iommu.c:872:1: warning: parameter names (without types) in function declaration
cc1: some warnings being treated as errors
make[2]: *** [scripts/Makefile.build:286: drivers/iommu/mtk_iommu.o] Error 1

But not on any of the older trees.

-- 
Thanks,
Sasha

