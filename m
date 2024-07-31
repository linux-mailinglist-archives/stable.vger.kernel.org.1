Return-Path: <stable+bounces-64727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41851942973
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 10:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBF611F24BF7
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 08:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B3E1A8BF0;
	Wed, 31 Jul 2024 08:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amiMPkOX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC531A7F8E;
	Wed, 31 Jul 2024 08:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722415556; cv=none; b=Q/Awp1GDw+XTSwKtvj5WzDjgLhx+dmb1cgZOb1rHnJd0zqeGani1x5WPw82BSB6dQWr4BDbTfpXmfRMhuSRZ7LUcILDn/7zN5zTZmeJqjhziXnnGJsk77sNQNbTz77twxB6tWh1P7s3Ocbthe1icKGB0I9nYfmELN4YQeZQwNK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722415556; c=relaxed/simple;
	bh=2XLxAIc6IiUvdSzD2ExFN0aiYA4Po6apdRHywpfIuJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1oU7H9aVUiTDUjQE2WLLxii4/DYw6Y5Ywf7Rn3ooNFFSI2VJ+9sYyhUShLXYe1e0yQ05hr8ExwTMb0AaJpLcZx0PEvp/dK6Yx0Ny4xr6M1Bmu1CrF7sXvYa1TCFaLga++l6mH6V9UF0b7PMc8zXOpOXxVb9lfzMbeqmh+ts+Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amiMPkOX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B59C4AF10;
	Wed, 31 Jul 2024 08:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722415556;
	bh=2XLxAIc6IiUvdSzD2ExFN0aiYA4Po6apdRHywpfIuJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=amiMPkOXaIEqDy8nSDola/nQWxqE60JDoCHCdcxkNowuGUEkYpe0F2flZzG0dG1ce
	 mD+E8nbaJxDzqx3ItGMLfsxAU4EvEWIFBZEgq/O3snn7fd4RHs/wfVZOdj9DRfinZ6
	 HoSWe+Tv/Z8LaaG9F7ZOtG8WhwJ0co+I8ASTG22nm+LzcyZrY6/uydTDOVc58LNN7d
	 rJwPOxvAeQwia32HtjQ0RPMxMEMUajWzONBo86Uhc0DNrwMrxSB2jY82wIe/lMrkWw
	 spFnmVZLjidrfQzkbkfsCuppSgO2L83TxQU1jB06psKADEB/P5ti4AniVd32gwtgn/
	 97fB0PlUDQREQ==
Date: Wed, 31 Jul 2024 09:45:51 +0100
From: Simon Horman <horms@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH net v1] net: wan: fsl_qmc_hdlc: Convert carrier_lock
 spinlock to a mutex
Message-ID: <20240731084551.GM1967603@kernel.org>
References: <20240730063104.179553-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730063104.179553-1-herve.codina@bootlin.com>

On Tue, Jul 30, 2024 at 08:31:04AM +0200, Herve Codina wrote:
> The carrier_lock spinlock protects the carrier detection. While it is
> hold, framer_get_status() is called witch in turn takes a mutex.
> This is not correct and can lead to a deadlock.
> 
> A run with PROVE_LOCKING enabled detected the issue:
>   [ BUG: Invalid wait context ]
>   ...
>   c204ddbc (&framer->mutex){+.+.}-{3:3}, at: framer_get_status+0x40/0x78
>   other info that might help us debug this:
>   context-{4:4}
>   2 locks held by ifconfig/146:
>   #0: c0926a38 (rtnl_mutex){+.+.}-{3:3}, at: devinet_ioctl+0x12c/0x664
>   #1: c2006a40 (&qmc_hdlc->carrier_lock){....}-{2:2}, at: qmc_hdlc_framer_set_carrier+0x30/0x98
> 
> Avoid the spinlock usage and convert carrier_lock to a mutex.
> 
> Fixes: 54762918ca85 ("net: wan: fsl_qmc_hdlc: Add framer support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Simon Horman <horms@kernel.org>


