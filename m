Return-Path: <stable+bounces-181867-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F215BA8D57
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 12:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D0847A4D04
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 10:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7CF2FAC0A;
	Mon, 29 Sep 2025 10:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vpva2PZ9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BD829E110;
	Mon, 29 Sep 2025 10:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759140726; cv=none; b=Uh+NLZwXe2vPMlmjekPIrrWY3e0mWAXWtXsuuTxq6QZ3Hsz0Ow99IY+Xkf59NKkiqDYAiCr0MjwTE9dwo+J25xfvhFTSuMYxzY4k29gzmiwmTXGDJ3PJ0MIvTsXrZvy9YA/3HV5Mq+ulmzKSCZznmLBbj/jpR6/bcQQr1Ak+zI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759140726; c=relaxed/simple;
	bh=8hDDedxdqSeLYiNLy/lB9IugtMeACP+2qj98espXOI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1VcOvlbG8HoVrtawXwP4q3dHhd1O7Ramhe2OFi7DG9rrjPovcDFopXpRfsLJZ+XiJRR2zeD01Wnif+8jVPSMwphye7vnxtariZqE43jEzco2nlHJLSljYYiqpHKr/pOyCVbjatBXRFtHAN35X85/L32MNytEryLQP10kuD0ego=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vpva2PZ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3A7C4CEF4;
	Mon, 29 Sep 2025 10:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759140725;
	bh=8hDDedxdqSeLYiNLy/lB9IugtMeACP+2qj98espXOI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vpva2PZ9Km+ZNK2lZG387/onIdNAzcf52TPMlU+Fje2AFlYSjze7PAJ7eq26x8ude
	 Y1x3pckd8K01IExt5mBfnQidkETFiWn99Xl/rgEEQHPOJ5VkbGYcTMAFw0wOwRySR3
	 5Ow7YPqGiEW0r1Ww7aNvdM37Ed2YgTVh2F16VF2mB4i/zYDwv/Ka4lZQM5xzQFIFao
	 xff3IaQ/2NksHKDNY6vr6Tz3Kyy+ktPV3LskTrVuWmrhkvVpPa94NbZWMfAV2IiKD8
	 rbjoOcEIA6s/6/Rmf2sLLX44fjz6NH93nR6O2RpTJRStzNKR5oC4PBvMc06KBWloUq
	 c4wku151gNASQ==
Date: Mon, 29 Sep 2025 11:12:01 +0100
From: Simon Horman <horms@kernel.org>
To: Bo Sun <bo@mboxify.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] octeontx2-pf: fix bitmap leak
Message-ID: <aNpbcfxWnWQK3nNC@horms.kernel.org>
References: <20250927071505.915905-1-bo@mboxify.com>
 <20250927071505.915905-3-bo@mboxify.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250927071505.915905-3-bo@mboxify.com>

On Sat, Sep 27, 2025 at 03:15:05PM +0800, Bo Sun wrote:
> The bitmap allocated with bitmap_zalloc() in otx2_probe() was not
> released in otx2_remove(). Unbinding and rebinding the driver therefore
> triggers a kmemleak warning:
> 
>     unreferenced object (size 8):
>       backtrace:
>         bitmap_zalloc
>         otx2_probe
> 
> Call bitmap_free() in the remove path to fix the leak.
> 
> Fixes: efabce290151 ("octeontx2-pf: AF_XDP zero copy receive support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bo Sun <bo@mboxify.com>

Reviewed-by: Simon Horman <horms@kernel.org>


