Return-Path: <stable+bounces-76079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D323978064
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 14:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A60BDB23AEB
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 12:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3BF1DA31D;
	Fri, 13 Sep 2024 12:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S1s91YYi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0301DA2EC;
	Fri, 13 Sep 2024 12:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726231768; cv=none; b=i+oZSHlUxufWii0yuTj89nxsdgAC5La+6hC9kRX6wFpizsWroKRDrCzgS4Sxd1B1msUNPy+vQIcA7G3ucYUL3TgR9iCzO2HET1rjQKpGpiINv4gyn3NPHfRPMbN8oUS4oKSVeTPW3ytq7Gsgn+paPO2uLy9ZeVgEA16YLxZ9XOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726231768; c=relaxed/simple;
	bh=eEatxwgAdoKuKzetIiUjFO5HPQ2Wq+jwTdApxUrQ9ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuGWfqh6Kg318UIK2MBzmh4eRxPS4tqA8HrDIWKo/7Cb5ACzC1e4O+qIR6gfq1eNrMf97nUjo13GAj1nSbhLVaEga1VXXTBri6EYXcjzRD6zwXHyrpTKcf/D1PzV2zAgyBWE4bvw+LOhDZj4HDUWa+COpfBzow+L1w7hcClZLlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S1s91YYi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D5FC4CECC;
	Fri, 13 Sep 2024 12:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726231767;
	bh=eEatxwgAdoKuKzetIiUjFO5HPQ2Wq+jwTdApxUrQ9ns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S1s91YYiP2AuKbP7PIrT9nNSx1fFEAFMGeI8O77GioefJIAUmOdtIAQayTLJwtDRr
	 DWd/zXwvjdTkBt7fjOjPjezG35Xq4DSfmURrwA4PkROGfB3h5lP7cx/FrHz11EfLKU
	 Vnhx+Agu8uPCJMMAy8lM+VjOkPebVY5J0orsTFdI=
Date: Fri, 13 Sep 2024 14:49:25 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Subject: Re: [PATCH] net: xilinx: axienet: Fix race in axienet_stop
Message-ID: <2024091355-remedy-cadmium-7de9@gregkh>
References: <20240910144607.1441863-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910144607.1441863-1-sean.anderson@linux.dev>

On Tue, Sep 10, 2024 at 10:46:07AM -0400, Sean Anderson wrote:
> [ Upstream commit 858430db28a5f5a11f8faa3a6fa805438e6f0851 ]
> 
> axienet_dma_err_handler can race with axienet_stop in the following
> manner:
> 
> CPU 1                       CPU 2
> ======================      ==================
> axienet_stop()
>     napi_disable()
>     axienet_dma_stop()
>                             axienet_dma_err_handler()
>                                 napi_disable()
>                                 axienet_dma_stop()
>                                 axienet_dma_start()
>                                 napi_enable()
>     cancel_work_sync()
>     free_irq()
> 
> Fix this by setting a flag in axienet_stop telling
> axienet_dma_err_handler not to bother doing anything. I chose not to use
> disable_work_sync to allow for easier backporting.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
> Link: https://patch.msgid.link/20240903175141.4132898-1-sean.anderson@linux.dev
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> [ Adjusted to apply before dmaengine support ]
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> This patch is adjusted to apply to v6.6 kernels and earlier, which do
> not contain commit 6a91b846af85 ("net: axienet: Introduce dmaengine
> support").

Applied to 6.6.y and 6.1.y, but nothing older as it didn't apply to
5.15.y :(

thanks,

greg k-h

