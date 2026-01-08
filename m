Return-Path: <stable+bounces-206318-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B14B4D03726
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 15:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0BBC3076807
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 14:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463C83E959E;
	Thu,  8 Jan 2026 11:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bJ59cGVN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E492461DB4;
	Thu,  8 Jan 2026 11:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767870562; cv=none; b=P8z13aI9wuqOmlfSkx+mhIYdjLTykIrbbUWsv+wfRm5sHO8Tc5IRqKZYqNCtI3yC7YDR0zRyBR2qJ70BFhQKnGT/VTugqTH9FGynCEFk2Z0OSLxnt3cMbXwXZORqPQnWl//+rES1ocEouu3Bgz18mdC8W62GGEcdcmHKWx8SJT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767870562; c=relaxed/simple;
	bh=kLYfke0AcCP2+2DvJYkhVcnP4RH/6tNOCokA1Afzviw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKU90hbMF7EgNuyJ0IDhmYcJor5Oi28T8cjLNiuFLxLpXnbmHsrDKuD+5QDa8iGJNNThX/2YQ3o/IV4oLVH7k7Nr/ell4fUVclD/qsYQUiJzKHttB5IBZcCBYDXqkUv2nf752DLJZ0Q6xKPbiIQeQLUNuvKM4l6FhcpYN71IyuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bJ59cGVN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25837C19422;
	Thu,  8 Jan 2026 11:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767870560;
	bh=kLYfke0AcCP2+2DvJYkhVcnP4RH/6tNOCokA1Afzviw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bJ59cGVN9wRIHKome+jonjXHHrKad6x7LtB7JVnfu3ykCPcGmx+C270y9bLPBfODh
	 O4s8fOXmqge4avbAoXnNbLRIswRmdp/+EIH6NWh/6YRF4ef42udtJKPFsxPDSMw/vK
	 K8ZJJnFt+AjJocaBfJIdZGpJuNcr4SR9x5lDaUn8=
Date: Thu, 8 Jan 2026 12:09:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Rahul Sharma <black.hawk@163.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH v6.6] net: stmmac: make sure that ptp_rate is not 0
 before configuring EST
Message-ID: <2026010804-evidence-cheek-430a@gregkh>
References: <20251229003117.1918863-1-black.hawk@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251229003117.1918863-1-black.hawk@163.com>

On Mon, Dec 29, 2025 at 08:31:17AM +0800, Rahul Sharma wrote:
> From: Alexis Lothoré <alexis.lothore@bootlin.com>
> 
> If the ptp_rate recorded earlier in the driver happens to be 0, this
> bogus value will propagate up to EST configuration, where it will
> trigger a division by 0.
> 
> Prevent this division by 0 by adding the corresponding check and error
> code.
> 
> Suggested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
> Fixes: 8572aec3d0dc ("net: stmmac: Add basic EST support for XGMAC")
> Link: https://patch.msgid.link/20250529-stmmac_tstamp_div-v4-2-d73340a794d5@bootlin.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> [ The context change is due to the commit c3f3b97238f6
> ("net: stmmac: Refactor EST implementation")
> which is irrelevant to the logic of this patch. ]
> Signed-off-by: Rahul Sharma <black.hawk@163.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac5.c        | 5 +++++
>  drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 5 +++++
>  2 files changed, 10 insertions(+)

What is the git id of this commit in Linus's tree?

thanks,

greg k-h

