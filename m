Return-Path: <stable+bounces-112019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9FFA259B1
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 13:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B7461887A7D
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 12:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9602046B1;
	Mon,  3 Feb 2025 12:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W2HP2M5I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE0984A3E;
	Mon,  3 Feb 2025 12:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738586806; cv=none; b=iSJO4/AR48X63PdUrvNzmem6QMmaK1T51JyrEdWFwjxh6++I2Z0eXMZ9LfhdC2F2VlkXv92uqvo31JwSAtIDM49xUa104eNQApLp4uauJxx6w4ikRFd0X5gAesLu2IOVqjeaJpoC3uTtBCZxkFWQi/H9Rc4WhXHj9ccBCyLPG94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738586806; c=relaxed/simple;
	bh=4/A4rABUwNoaT3T5LF6UGHs9iN2T7Q1WubADJK+Dc28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJ2iem8dzsEgiuiN9YXKzU/Hb+PCsCkF9Zbs8jq0bYL7fnJAwhPoSxCC/wrX8Ogr0mRAC7PFL49l8HhGGTFsSWcT4QVc1TkqNHetd/CK1vyNRHU6RRJFuidHHg6Da34h+MALKUWck5vZgAMivserfQgUa8X8FD3ZWxzP/4mSt4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W2HP2M5I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21950C4CED2;
	Mon,  3 Feb 2025 12:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738586804;
	bh=4/A4rABUwNoaT3T5LF6UGHs9iN2T7Q1WubADJK+Dc28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W2HP2M5IudtzQTELIPqwbLEBFt/9qjO7GN9IZ9uVej5kxCHtM8Qgw6VUB87Fw7Jro
	 P6PLuSH4SDI6ihiDOBt57s8wT133OAtUMAdhLwIAETvIGRk/K9wIEL3+IPpTK06Txc
	 Y9WK+ywresaKCfGrFff/SpEmP1EnwbXehAG9d7Rk=
Date: Mon, 3 Feb 2025 13:46:41 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: nb@tipi-net.de
Cc: Mathias Nyman <mathias.nyman@intel.com>,
	Ben Hutchings <ben@decadent.org.uk>, n.buchwitz@kunbus.com,
	l.sanfilippo@kunbus.com, stable@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: xhci: Restore Renesas uPD72020x support in xhci-pci
Message-ID: <2025020307-charity-snowfield-c975@gregkh>
References: <20250203120026.2010567-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250203120026.2010567-1-nb@tipi-net.de>

On Mon, Feb 03, 2025 at 01:00:26PM +0100, nb@tipi-net.de wrote:
> From: Nicolai Buchwitz <nb@tipi-net.de>
> 
> Before commit 25f51b76f90f1 ("xhci-pci: Make xhci-pci-renesas a proper
> modular driver"), the xhci-pci driver handled the Renesas uPD72020x USB3
> PHY and only utilized features of xhci-pci-renesas when no external
> firmware EEPROM was attached. This allowed devices with a valid firmware
> stored in EEPROM to function without requiring xhci-pci-renesas.
> 
> That commit changed the behavior, making xhci-pci-renesas responsible for
> handling these devices entirely, even when firmware was already present
> in EEPROM. As a result, unnecessary warnings about missing firmware files
> appeared, and more critically, USB functionality broke whens
> CONFIG_USB_XHCI_PCI_RENESAS was not enabled—despite previously workings
> without it.
> 
> Fix this by ensuring that devices are only handed over to xhci-pci-renesas
> if the config option is enabled. Otherwise, restore the original behavior
> and handle them as standard xhci-pci devices.
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> Fixes: 25f51b76f90f ("xhci-pci: Make xhci-pci-renesas a proper modular driver")
> ---
>  drivers/usb/host/xhci-pci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index 2d1e205c14c60..4ce80d8ac603e 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -654,9 +654,11 @@ int xhci_pci_common_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  EXPORT_SYMBOL_NS_GPL(xhci_pci_common_probe, "xhci");
>  
>  static const struct pci_device_id pci_ids_reject[] = {
> +#if IS_ENABLED(CONFIG_USB_XHCI_PCI_RENESAS)
>  	/* handled by xhci-pci-renesas */
>  	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, 0x0014) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, 0x0015) },
> +#endif
>  	{ /* end: all zeroes */ }
>  };

Have you seen:
	https://lore.kernel.org/r/20250128104529.58a79bfc@foxbook
?

Which one is correct?

thanks,

greg k-h

