Return-Path: <stable+bounces-54762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A339F910E40
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 19:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4016BB25DD4
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 17:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61A81B3754;
	Thu, 20 Jun 2024 17:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nfy4McdF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EA51AB8F0;
	Thu, 20 Jun 2024 17:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718903775; cv=none; b=pVcKgHbapiLd4cZ/gQ7EDiB/zN0WHReow6h007mZxqHHLelGHUu0+MJKoqBGz1VbFASrl6T262h+P6puUdfNAJuK/MABM2Iv7uNPZ/RW5QyMRjKAr6dCxw2BZHOxxR2+QlXETlnPu+3T/IO6pUrn9mrRFd3I9JZB7LPbqaFgWYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718903775; c=relaxed/simple;
	bh=nTUjyvPJwsjHGiR5ySPNqFmwFDArPcRIv7+YmkcFFU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fY1v2zv4YeiBzKkqmocRUBiVS278+e75Gv7Z59Czk7YairUjHxEXnLbHJnd2QA4V2c/qIT65mYJoWZopJaBlv0wXPkruhgGGWIEVg92ykPH+ePSMbpF3udIudnSncXhgaIl1rSWvvmmaawI5bSjjJY5iR8ElxO+LcA+6s5lA0Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nfy4McdF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83661C2BD10;
	Thu, 20 Jun 2024 17:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718903774;
	bh=nTUjyvPJwsjHGiR5ySPNqFmwFDArPcRIv7+YmkcFFU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nfy4McdF386W/gXzEyZ1mJEuc3YaDXHDojaIAbWNI66xGKUkCTx8dGqwzj1fP+Xgt
	 zX9gmQnLf+m5SJXfZa1lty5JuVhZdZh8Bn8Re6+zKZ//1CziFcwaaiNynNH4FwgZb4
	 Zh5ut+a0k+bKp1lIfiKzYKE75F77VqLCTUOoU2xg=
Date: Thu, 20 Jun 2024 19:16:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: joswang <joswang1221@gmail.com>
Cc: Thinh.Nguyen@synopsys.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jos Wang <joswang@lenovo.com>
Subject: Re: [PATCH v7] usb: dwc3: core: Workaround for CSR read timeout
Message-ID: <2024062051-washtub-sufferer-d756@gregkh>
References: <20240619114529.3441-1-joswang1221@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619114529.3441-1-joswang1221@gmail.com>

On Wed, Jun 19, 2024 at 07:45:29PM +0800, joswang wrote:
> From: Jos Wang <joswang@lenovo.com>
> 
> This is a workaround for STAR 4846132, which only affects
> DWC_usb31 version2.00a operating in host mode.
> 
> There is a problem in DWC_usb31 version 2.00a operating
> in host mode that would cause a CSR read timeout When CSR
> read coincides with RAM Clock Gating Entry. By disable
> Clock Gating, sacrificing power consumption for normal
> operation.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Jos Wang <joswang@lenovo.com>

What commit id does this fix?  How far back should it be backported in
the stable releases?

thanks,

greg k-h

