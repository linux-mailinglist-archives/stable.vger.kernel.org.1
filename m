Return-Path: <stable+bounces-206151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1963CFE811
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 16:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5E663027DBF
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 15:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E1B3557E9;
	Wed,  7 Jan 2026 14:34:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C053557E4;
	Wed,  7 Jan 2026 14:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796471; cv=none; b=B8rPuHtmgW07C/9gCjXeZs0ZZ0vSSWp61IQaSzx3wU7aEJ2w1GEOVM1BQH/W4eInFO3j9dzpCckeCSl9PcUoyjnjaxfzIu08QSH3OVZrVS6Nf6/cTGB3sS1kRlvz4ONBZL+ot/bD/HoPNCux3TmfV8sHz0tp7J7KwX0PHpMb8vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796471; c=relaxed/simple;
	bh=URHm3oFjJ+vczd2ypknyKHgPWj9RYURWhQC48hUI9ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXE/SzGlDZU60D33cwRPMnxOnW1784QkiFjKC8w9o4IBXs6pqmTh9bsN1QK3620emCM+/KDq4LB7c8symWkRPsfR+GOCISK0ivjh4x5v96wZJsAlT5DAUHbY7Acs4MD/nx+xQeh9W9itet3zhDdmyALNQnyx+dSoVF550+tsGJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7B7CC227A87; Wed,  7 Jan 2026 15:34:26 +0100 (CET)
Date: Wed, 7 Jan 2026 15:34:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Arnd Bergmann <arnd@arndb.de>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvme-apple: Add "apple,t8103-nvme-ans2" as compatible
Message-ID: <20260107143426.GB14506@lst.de>
References: <20251231-nvme-apple-t8103-base-compat-v1-1-dc11727dc930@jannau.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251231-nvme-apple-t8103-base-compat-v1-1-dc11727dc930@jannau.net>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Dec 31, 2025 at 11:10:57AM +0100, Janne Grunau wrote:
> After discussion with the devicetree maintainers we agreed to not extend
> lists with the generic compatible "apple,nvme-ans2" anymore [1]. Add
> "apple,t8103-nvme-ans2" as fallback compatible as it is the SoC the
> driver and bindings were written for.
> 
> [1]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/
> 
> Cc: stable@vger.kernel.org # v6.18+
> Fixes: 5bd2927aceba ("nvme-apple: Add initial Apple SoC NVMe driver")
> Reviewed-by: Neal Gompa <neal@gompa.dev>
> Signed-off-by: Janne Grunau <j@jannau.net>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


