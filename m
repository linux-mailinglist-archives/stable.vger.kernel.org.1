Return-Path: <stable+bounces-100250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1849C9EA04B
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 21:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D321016665B
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 20:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA2D19C54B;
	Mon,  9 Dec 2024 20:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hc3HPJWh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B647223315A;
	Mon,  9 Dec 2024 20:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733776322; cv=none; b=TRXlL6cMY4rcYmV2677XHtPZQNCjv51o6DJIKThRagJDIoUzIwaJIoRMWXkTJZPaiv3lVmKj0/uj/uMu+uDK1nstRfeGvs926nsdCo4YkeIH5MLlLCOSg2DfePFqAHAmmZto0MKPsD28d8dbDDx/4UWniN8pcYfgOT5+YTr/hy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733776322; c=relaxed/simple;
	bh=wpgzYV9P/iqfJu/uKuikGtFuJPC6IBtMiMfoMSv56sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSUb9r05Pt87H818KIvN/kfzlTU+Cr1wvkIFE/38QCTgcLx8VArWkOsWbEXULpv+R2ELFDdk5mvZXvJ3C6PYjQjwuJ/pKIQli192n0mlPgl6M34nhv+Fos59rqZqmXVPvUwDxy1lD4nkBCL7U8lhPPPt9Oa9EIHWYbY2PuGiEfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hc3HPJWh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFAF4C4CED1;
	Mon,  9 Dec 2024 20:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733776322;
	bh=wpgzYV9P/iqfJu/uKuikGtFuJPC6IBtMiMfoMSv56sM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hc3HPJWhRXcHBxhmPwUYAYM77Ohadjum2ZaPWO+920b5ZpqNB17fExI0q179iPPwU
	 Tdp5zJajw4LlTgRYxYdKHjde4CvcKowmgHaOzg7uqbwBU+8Uyj1mPD/wgKjrRBZvha
	 QltwfxUBz1kAfl3S4s72woG4sJKt+m1aidlCTh5SmVNez/SrbnMpEWcZYxlQEhRJta
	 Cl1SedwtzZnE45u0eVpxeKTn21ieP29RLbj1vs+i6kJsoTp6eytB7c6FvLEdpYw8kf
	 e9Sfy1AmzyQD43XeOYRrToZc3dwK4fJHI8evPjj5+deqvrk2nRzbGmLHe0rQcpMrEs
	 k5JO8Nr42k/DQ==
Date: Mon, 9 Dec 2024 14:32:00 -0600
From: Rob Herring <robh@kernel.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Saravana Kannan <saravanak@google.com>,
	Leif Lindholm <leif.lindholm@linaro.org>,
	Stephen Boyd <stephen.boyd@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
Subject: Re: [PATCH 04/10] of: Fix refcount leakage for OF node returned by
 __of_get_dma_parent()
Message-ID: <20241209203200.GA925532-robh@kernel.org>
References: <20241206-of_core_fix-v1-0-dc28ed56bec3@quicinc.com>
 <20241206-of_core_fix-v1-4-dc28ed56bec3@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206-of_core_fix-v1-4-dc28ed56bec3@quicinc.com>

On Fri, Dec 06, 2024 at 08:52:30AM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> __of_get_dma_parent() returns OF device node @args.np, but the node's
> refcount is increased twice, by both of_parse_phandle_with_args() and
> of_node_get(), so causes refcount leakage for the node.
> 
> Fix by directly returning the node got by of_parse_phandle_with_args().
> 
> Fixes: f83a6e5dea6c ("of: address: Add support for the parent DMA bus")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/of/address.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Rob

