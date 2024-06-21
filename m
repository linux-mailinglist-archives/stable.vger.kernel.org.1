Return-Path: <stable+bounces-54787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1D8911A3C
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 07:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D72A31F21A1E
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 05:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A02A12CDA5;
	Fri, 21 Jun 2024 05:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sH2vOVkL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C583A47;
	Fri, 21 Jun 2024 05:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718947166; cv=none; b=FnKlvVYHUUazY8O0uOPCY7KJkGbqYkhb29MPUTkPbrWxJiHLzs9ayViUuroGc61Hguv2UidnzomVyGhbICRZpswvt4PDG6ldMyvT1Phu5QsBKbrOuaxQ0kypF5/R6kvVNAjzj6X70cE3VH4VLcpMWbf5/dAQIdHWyCvJZAeEdY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718947166; c=relaxed/simple;
	bh=3YVVhjYCZUSLoGVGGclFToYzmDKI4sYqBF5KsrWEuHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMwyQyWcBATLZA4HVcOlbJiemdAvDQuCS32phqVC0VtLERstUOFZNeyPB26VvVKfmfYYG5GYiMCDgEvaTh+C7WEAjeR3URf8CQQ7TtsgRaOI5eqvafBO89ntKCh4cuFrN6HlqrhEQXFVqZj6iqfq1boAKVfNAiVPaiPXd1ssggA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sH2vOVkL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CDBDC2BBFC;
	Fri, 21 Jun 2024 05:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718947166;
	bh=3YVVhjYCZUSLoGVGGclFToYzmDKI4sYqBF5KsrWEuHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sH2vOVkL9TgTwRs4rSm12dKDCZ713pDLld/GD17/A+GIs40d/Efw62sjD7CWMnKRy
	 dge28+4vqLN8cZWX2hT/pyeYxngovy52kwAwzEGjuKDV6lCtl9mziMk307/bnG5MIC
	 qEAFnThBN9PZ2Rhdx6wsRZvHVLBA8ZZ1nYdQ8cXg=
Date: Fri, 21 Jun 2024 07:19:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: joswang <joswang1221@gmail.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jos Wang <joswang@lenovo.com>
Subject: Re: [PATCH v7] usb: dwc3: core: Workaround for CSR read timeout
Message-ID: <2024062151-professor-squeak-a4a7@gregkh>
References: <20240619114529.3441-1-joswang1221@gmail.com>
 <2024062051-washtub-sufferer-d756@gregkh>
 <CAMtoTm06MTJ_Gc4NvenycvWRxhLSaPptT1DLvBRs4RWVZO9Y_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMtoTm06MTJ_Gc4NvenycvWRxhLSaPptT1DLvBRs4RWVZO9Y_g@mail.gmail.com>

On Fri, Jun 21, 2024 at 09:40:10AM +0800, joswang wrote:
> On Fri, Jun 21, 2024 at 1:16 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jun 19, 2024 at 07:45:29PM +0800, joswang wrote:
> > > From: Jos Wang <joswang@lenovo.com>
> > >
> > > This is a workaround for STAR 4846132, which only affects
> > > DWC_usb31 version2.00a operating in host mode.
> > >
> > > There is a problem in DWC_usb31 version 2.00a operating
> > > in host mode that would cause a CSR read timeout When CSR
> > > read coincides with RAM Clock Gating Entry. By disable
> > > Clock Gating, sacrificing power consumption for normal
> > > operation.
> > >
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Jos Wang <joswang@lenovo.com>
> >
> > What commit id does this fix?  How far back should it be backported in
> > the stable releases?
> >
> > thanks,
> >
> > greg k-h
> 
> Hello Greg Thinh
> 
> It seems first begin from the commit 1e43c86d84fb ("usb: dwc3: core:
> Add DWC31 version 2.00a controller")
> in 6.8.0-rc6 branch ?

That commit showed up in 6.9, not 6.8.  And if so, please resend with a
proper "Fixes:" tag.

thanks,

greg k-h

