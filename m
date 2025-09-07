Return-Path: <stable+bounces-178029-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F13EBB4797C
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 10:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A970D20289B
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 08:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41D01B0414;
	Sun,  7 Sep 2025 08:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="geC64+e3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D2827707
	for <stable@vger.kernel.org>; Sun,  7 Sep 2025 08:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757232141; cv=none; b=cieOjHR4zpF+0rCdsstA4tIzDIYAJTYcbJHNb++6x2NAxfwSmV7fsk16b5PZEaNQeiZzEZKRSE94jMeUc5mEBAjCPihLFx3VKASMTK5ZDLk+2Zn2nygxVOrZPsVN7v28m7FyMvWhH4c7GJZn58T4jboP78rSC/adbgm3FDie4b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757232141; c=relaxed/simple;
	bh=Ci6hkp4c04B4EEDPBpeYbMccnU/rsLn+LzB/xbGxYGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2rSEvwwQ/NvzNW9i8Pd8VNhhhsBF0+5wcnJZxa3WT/yxNdurK/VJb4My1g9UXoZlB5jaAunVSWVekY/t7V02in47mP47TvjKRgxKLgIMTKuerwnfKGMZk7SsuP1DdC+AOsPiR8oWAQAOcggLbrbTDBcEOMJPpgJgYcqxZ2YW9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=geC64+e3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F092EC4CEF0;
	Sun,  7 Sep 2025 08:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757232141;
	bh=Ci6hkp4c04B4EEDPBpeYbMccnU/rsLn+LzB/xbGxYGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=geC64+e3UJshrUgkNXQKt7LDdYcMFFvd5XFTb1bYQeHtlljlH2Ad8LC2V9Y9zg3QF
	 C1sBDhWUIKkp23WxwBt7/R7mHWkRVASOIcmsNUxPgftZ8xJCKXrB88rbT3PrFHOqfR
	 tHID9q6Xo53xURawfF+6GAK0r91vq0ozUoQSGfgo=
Date: Sun, 7 Sep 2025 10:02:18 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: stable@vger.kernel.org, Jonathan Bell <jonathan@raspberrypi.com>,
	Keita Aihara <keita.aihara@sony.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Avri Altman <avri.altman@wdc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Subject: Re: [PATCH v1 1/1] mmc: core: apply SD quirks earlier during probe
Message-ID: <2025090705-rumbling-twirl-81e2@gregkh>
References: <20250905111431.1914549-1-ghidoliemanuele@gmail.com>
 <20250905111431.1914549-2-ghidoliemanuele@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905111431.1914549-2-ghidoliemanuele@gmail.com>

On Fri, Sep 05, 2025 at 01:14:29PM +0200, Emanuele Ghidoli wrote:
> From: Jonathan Bell <jonathan@raspberrypi.com>
> 
> Applying MMC_QUIRK_BROKEN_SD_CACHE is broken, as the card's SD quirks are
> referenced in sd_parse_ext_reg_perf() prior to the quirks being initialized
> in mmc_blk_probe().
> 
> To fix this problem, let's split out an SD-specific list of quirks and
> apply in mmc_sd_init_card() instead. In this way, sd_read_ext_regs() to has
> the available information for not assigning the SD_EXT_PERF_CACHE as one of
> the (un)supported features, which in turn allows mmc_sd_init_card() to
> properly skip execution of sd_enable_cache().
> 
> Fixes: 1728e17762b9 ("mmc: core: sd: Apply BROKEN_SD_DISCARD quirk earlier")
> Signed-off-by: Jonathan Bell <jonathan@raspberrypi.com>
> Co-developed-by: Keita Aihara <keita.aihara@sony.com>
> Signed-off-by: Keita Aihara <keita.aihara@sony.com>
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> Reviewed-by: Avri Altman <avri.altman@wdc.com>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/20240820230631.GA436523@sony.com
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> ---
>  drivers/mmc/core/sd.c | 4 ++++
>  1 file changed, 4 insertions(+)

What is the git id of this commit in Linus's tree?

thanks,

greg k-h

