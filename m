Return-Path: <stable+bounces-189909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA2DC0BBD5
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 04:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1604B3490F4
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 03:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AEE2D4B5A;
	Mon, 27 Oct 2025 03:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJtwWuhA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3E8F9C1;
	Mon, 27 Oct 2025 03:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761535476; cv=none; b=JYyP5j6xZpgehfKZoytelJMdp7hqiMY5tVeiOSEo41S28I5HWlcBbf/8n3XCNSqfgd0OnEcgcIU4TUoMUyhkVkOp1nHyJxr2iBX3YKGYShhndvrJRsi1P9iYvXULMLrHcD5EVjiv9pVtpmqWqXZiiEjHi6kdw3OkQRjFIqfNmU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761535476; c=relaxed/simple;
	bh=7cM3Cn6JKYuasEzBXvIvxBu+D5+1UWzNLsU5dSsAaVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gc1gBG3nFa8Rej+t3IZ0G9qtYSKHsRYg/T7kLWHYaWz7Xabiyj4EWZ1QILXyM5BMFPuvHGOmJ5RJM6gyVfE7FIq07XgNDYKETSYfQwe4cSBSWD4uuzOrg5ZDb0I0I2E8pI2gMx46PwSyZZIZynwGbAkr9dpDwqWNTjBpKQYpeUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJtwWuhA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B6CC4CEE7;
	Mon, 27 Oct 2025 03:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761535476;
	bh=7cM3Cn6JKYuasEzBXvIvxBu+D5+1UWzNLsU5dSsAaVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WJtwWuhAaQ+p+vO8QK9rkQ7BwmTxLfja33rTGfRntbAgY0tJpkD/ASs6zl15kbDsX
	 YUjtREUaZnMkq3xM5lvRRAwjFbJ4esctyOTkAMlGF8g+xQYYqSjInMhcVPftZRpAVt
	 eG5RO9IQwRd1DlSyxg3p6wxpS3NU3b3AdpGoK2xzGnl12yskC8P5+dbGiGncnHeguS
	 zjdSuULGARY3Q035d1d7/yyZBrxrq5LVHomUGw1gHY/7h2FLSkIcIYMXuctRCiNm02
	 9lRmYhDzXs2O/z9ZlQ8SSYSqiOZ/ReId2kICBrO8ing8d6C5LgYBuThJ9kr09fecqQ
	 RfCt91nmQo3/w==
Date: Mon, 27 Oct 2025 11:24:32 +0800
From: "Peter Chen (CIX)" <peter.chen@kernel.org>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Pawel Laszczak <pawell@cadence.com>, Roger Quadros <rogerq@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: cdns3: Fix double resource release in
 cdns3_pci_probe
Message-ID: <aP7l8FG_B1OimEnB@nchen-desktop>
References: <20251026090859.33107-1-linmq006@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026090859.33107-1-linmq006@gmail.com>

On 25-10-26 17:08:59, Miaoqian Lin wrote:
> The driver uses pcim_enable_device() to enable the PCI device,
> the device will be automatically disabled on driver detach through
> the managed device framework. The manual pci_disable_device() calls
> in the error paths are therefore redundant and should be removed.
> 
> Found via static anlaysis and this is similar to commit 99ca0b57e49f
> ("thermal: intel: int340x: processor: Fix warning during module unload").
> 
> Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Acked-by: Peter Chen <peter.chen@kernel.org>

Peter
> ---
>  drivers/usb/cdns3/cdns3-pci-wrap.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-pci-wrap.c b/drivers/usb/cdns3/cdns3-pci-wrap.c
> index 3b3b3dc75f35..57f57c24c663 100644
> --- a/drivers/usb/cdns3/cdns3-pci-wrap.c
> +++ b/drivers/usb/cdns3/cdns3-pci-wrap.c
> @@ -98,10 +98,8 @@ static int cdns3_pci_probe(struct pci_dev *pdev,
>  		wrap = pci_get_drvdata(func);
>  	} else {
>  		wrap = kzalloc(sizeof(*wrap), GFP_KERNEL);
> -		if (!wrap) {
> -			pci_disable_device(pdev);
> +		if (!wrap)
>  			return -ENOMEM;
> -		}
>  	}
>  
>  	res = wrap->dev_res;
> @@ -160,7 +158,6 @@ static int cdns3_pci_probe(struct pci_dev *pdev,
>  		/* register platform device */
>  		wrap->plat_dev = platform_device_register_full(&plat_info);
>  		if (IS_ERR(wrap->plat_dev)) {
> -			pci_disable_device(pdev);
>  			err = PTR_ERR(wrap->plat_dev);
>  			kfree(wrap);
>  			return err;
> -- 
> 2.39.5 (Apple Git-154)
> 

-- 

Best regards,
Peter

