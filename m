Return-Path: <stable+bounces-203165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FF9CD42F2
	for <lists+stable@lfdr.de>; Sun, 21 Dec 2025 17:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3837F3007634
	for <lists+stable@lfdr.de>; Sun, 21 Dec 2025 16:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7AD70814;
	Sun, 21 Dec 2025 16:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="huHgVUJH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEAB168BD
	for <stable@vger.kernel.org>; Sun, 21 Dec 2025 16:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766334704; cv=none; b=BNl80Q901uu8SNd0jj+sV3xQAUGOaKwioWuxby5HloDoJI5D/1sW8c++jEfCo835u52qUCqFeB9eS/c0UaAPPkXosPDLXEeMwwit5P6WQ+CuanO9flLO0l3bixxn4P/lyql+ZACVdlaOTo/IS0Pgcp1Ck4eUigbTDIoYAIQsa7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766334704; c=relaxed/simple;
	bh=rcioyuv8KWc6q+wSc62GtvQU2TZF4ns4K1vBn2VN0L4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDnEZWVCk4NJAAhqbjXahRJ91DeqhkbfyVAUseY9DpDzzxN6mMyUL8cKqisjWWF2TiXjkKA+BOub2+EM/cp8BhU/LnezML7SFIGRYHBwRpUCShuSqnMAy/8eTSIwtPpXUPqOLIsd1eFzKhGBC/rNrPAsdZk6NnYfR48Gk4MmK0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=huHgVUJH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E998C4CEFB;
	Sun, 21 Dec 2025 16:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1766334703;
	bh=rcioyuv8KWc6q+wSc62GtvQU2TZF4ns4K1vBn2VN0L4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=huHgVUJH5K+d6nGUzM6aBJ73QpNBvwQFN7d89fKrLR3red+UtXnovyP7/vEXzdDvU
	 Mu10369Zl7ZPI6ZBJebKEyWfOV2kYpmCA5LvdzX6pj8jdedOmnPUbHW+PZo/wW9UUr
	 DyihM8BmJ+5PB04y/2h6kgSBz9hIv5d40ux3f1Ik=
Date: Sun, 21 Dec 2025 17:31:40 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Zhaoyang Li <lizy04@hust.edu.cn>
Cc: stable@vger.kernel.org, dzm91@hust.edu.cn,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Dhruva Gole <d-gole@ti.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6.1.y] spi: cadence-qspi: fix pointer reference in
 runtime PM hooks
Message-ID: <2025122106-value-precook-634a@gregkh>
References: <20250516062528.420927-1-lizy04@hust.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250516062528.420927-1-lizy04@hust.edu.cn>

On Fri, May 16, 2025 at 02:25:28PM +0800, Zhaoyang Li wrote:
> From: Théo Lebrun <theo.lebrun@bootlin.com>
> 
> [ Upstream commit 32ce3bb57b6b402de2aec1012511e7ac4e7449dc ]
> 
> dev_get_drvdata() gets used to acquire the pointer to cqspi and the SPI
> controller. Neither embed the other; this lead to memory corruption.
> 
> On a given platform (Mobileye EyeQ5) the memory corruption is hidden
> inside cqspi->f_pdata. Also, this uninitialised memory is used as a
> mutex (ctlr->bus_lock_mutex) by spi_controller_suspend().
> 
> Fixes: 2087e85bb66e ("spi: cadence-quadspi: fix suspend-resume implementations")
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> Link: https://msgid.link/r/20240222-cdns-qspi-pm-fix-v4-1-6b6af8bcbf59@bootlin.com
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Zhaoyang Li <lizy04@hust.edu.cn>
> ---
>  drivers/spi/spi-cadence-quadspi.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Turns out you used a LLM tool to generate this backport.  Any specific
reason why you didn't identify that and tell us you did so?

thanks,

greg k-h

