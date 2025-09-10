Return-Path: <stable+bounces-179148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E861B50A16
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 03:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 433C41BC7A3C
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 01:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0D41E0DFE;
	Wed, 10 Sep 2025 01:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MU/wT21q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956751DF98F
	for <stable@vger.kernel.org>; Wed, 10 Sep 2025 01:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757466605; cv=none; b=HSOtmPrYmohtlgK0icd9/VIDtb+ryoWKUUPHziPvlIuk6WnkSLsK45YDRFHuSyOVvjhT5TvovMClRvuQzXxqB0Ikmo2RythVmG3DQqkOxpwQJeY5KCB7dw1xvNtwEkAuwt4FmqSaEzTmHVr8cBR48Bbk+LB3OQ6dE484aQ03Bes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757466605; c=relaxed/simple;
	bh=C2k9MiDhguBj9/iGc24WyCBUOM1Yq/qbPPGVNZ1cbjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YnS6exGXtOf3xPSM4/lLRGp4Ig51YvgA/kuAmu9dieEfkYKOj/5nr/BWW3Ipcy+ZwVsFH/8pMQ6vzgNkFV4z/VtAd6z14M3XQm5HpbW1AyWQRY/AYR+Z+WczL0mvIRbHCeJuOj31T7CRamIqbaiHBjhwL9jHFzclLFBHK/7VFlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MU/wT21q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46590C4CEF4;
	Wed, 10 Sep 2025 01:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757466605;
	bh=C2k9MiDhguBj9/iGc24WyCBUOM1Yq/qbPPGVNZ1cbjI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MU/wT21qyNV/bhIBvS6UUGsqUz7rYtzIgbTv/6/evmCJ5o8A793tbjUmmbK0hvJYR
	 7l2EQ0lsGZ/5N/mHSrIJDzAEj3/7XX/hbAFU6mBIZ9s9KffKaf1a0tY6aoKrZcxKMP
	 ky/s/Ws8OawTkXTkm5Ks9JgUY9l4Wwm+TcONmlVra00tshug0YDRXjsJFN9J/aF91o
	 4O7za00iaVTBF7U54Jau9WXxolpauRX0Z1WQra9YVsboRwoGDwL+z2HVnop2Ne9T33
	 9bWQW14gu/i4C8xai3uxa/AIwAuO5+APics6r/9W1GldbCy9YlVhG21h0F7dN4f15N
	 5K6suluVGSa5A==
Message-ID: <fcddf681-aa4f-4d62-a900-af96c1801fcf@kernel.org>
Date: Wed, 10 Sep 2025 10:07:02 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: pci-epf: Move DMA initialization to EPC init
 callback
To: Niklas Cassel <cassel@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Keith Busch <kbusch@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 stable@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20250909112121.682086-2-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250909112121.682086-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/25 8:21 PM, Niklas Cassel wrote:
> From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> 
> For DMA initialization to work across all EPC drivers, the DMA
> initialization has to be done in the .init() callback.
> 
> This is because not all EPC drivers will have a refclock (which is often
> needed to access registers of a DMA controller embedded in a PCIe
> controller) at the time the .bind() callback is called.
> 
> However, all EPC drivers are guaranteed to have a refclock by the time
> the .init() callback is called.
> 
> Thus, move the DMA initialization to the .init() callback.
> 
> This change was already done for other EPF drivers in
> commit 60bd3e039aa2 ("PCI: endpoint: pci-epf-{mhi/test}: Move DMA
> initialization to EPC init callback").
> 
> Cc: stable@vger.kernel.org
> Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

