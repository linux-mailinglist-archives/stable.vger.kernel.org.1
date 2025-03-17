Return-Path: <stable+bounces-124564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF017A63AC3
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 02:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFC243AB466
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 01:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A509B78F43;
	Mon, 17 Mar 2025 01:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXGVIMnZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56299199BC;
	Mon, 17 Mar 2025 01:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742176443; cv=none; b=iyKr2I4YOxpTvTWvMLeyV4pOVsrhFtrQIfN5uUSO3JmCX2v45sGZlVZRJclYOjx+lW/g9JcIu+lxU0XolleTkIf+B4D47Qc6nLjdvCsFFVhEDeRvbJeUsqOZyyfDXfqdIQk4e8kMTjJVOp83+/tlqrVkKVd4NYDI/5QDL/u/j3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742176443; c=relaxed/simple;
	bh=NrSoCCK1NOd0oAcJL5EcEkPkW3Rredkc6BKA7Ayr8kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgspTofKnsVzoMyMluB/UHAAFWSgJhuaOBekFh7XlPqCwsmSppyNNhCxyCCiPYxI8WaVNO2d44F41ZsNliA3TYILufky4laLpvJgBvwWDFuhav4qoQnBczUwai4bfnS+2jO15y+WEZ/zpb0E5XRZ/AU7rYGIhvQ80CRZBq79ebY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXGVIMnZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE1DC4CEDD;
	Mon, 17 Mar 2025 01:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742176442;
	bh=NrSoCCK1NOd0oAcJL5EcEkPkW3Rredkc6BKA7Ayr8kM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JXGVIMnZ3XkUx+cvH2hEXwshiydvkt14xEy07irr0XVvt8LfOxEp/KWYTFnyioQLP
	 IID4vpGjQ2M/2yOJDIaSYuijJCOxfEPz98CgfEKGSqrF/iloGz2WCdbCJl+yY51iE8
	 iHlZw6+MxuSpvsHyBUlV0VjuSn9j6L6oUHBr68PlJvWFw/UzjC7Si/3UfRXTH8hMK+
	 nJuH9mOGjpGEhpLCX2PuCeW2OC693BDALe/rsWo5wpX6hhH4GTZNUHhj478J6ZVxrr
	 rRAePlyWcjf79a9po2Uo6fUqfs0xwIMNjNAYAn9H2t5n7QTpj8Nv29LJOhuyXRMULa
	 kE6nU2yzxC1fw==
Date: Mon, 17 Mar 2025 09:53:52 +0800
From: "Peter Chen (CIX)" <peter.chen@kernel.org>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Frank Li <Frank.li@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Sebastian Reichel <sre@kernel.org>,
	Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>,
	linux-usb@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] usb: chipidea: ci_hdrc_imx: fix usbmisc handling
Message-ID: <20250317015352.GA218167@nchen-desktop>
References: <20250316102658.490340-1-pchelkin@ispras.ru>
 <20250316102658.490340-2-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250316102658.490340-2-pchelkin@ispras.ru>

On 25-03-16 13:26:54, Fedor Pchelkin wrote:
> usbmisc is an optional device property so it is totally valid for the
> corresponding data->usbmisc_data to have a NULL value.
> 
> Check that before dereferencing the pointer.
> 
> Found by Linux Verification Center (linuxtesting.org) with Svace static
> analysis tool.
> 
> Fixes: 74adad500346 ("usb: chipidea: ci_hdrc_imx: decrement device's refcount in .remove() and in the error path of .probe()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

Acked-by: Peter Chen <peter.chen@kernel.org>

Peter
> ---
>  drivers/usb/chipidea/ci_hdrc_imx.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
> index 1a7fc638213e..619779eef333 100644
> --- a/drivers/usb/chipidea/ci_hdrc_imx.c
> +++ b/drivers/usb/chipidea/ci_hdrc_imx.c
> @@ -534,7 +534,8 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
>  		cpu_latency_qos_remove_request(&data->pm_qos_req);
>  	data->ci_pdev = NULL;
>  err_put:
> -	put_device(data->usbmisc_data->dev);
> +	if (data->usbmisc_data)
> +		put_device(data->usbmisc_data->dev);
>  	return ret;
>  }
>  
> @@ -559,7 +560,8 @@ static void ci_hdrc_imx_remove(struct platform_device *pdev)
>  		if (data->hsic_pad_regulator)
>  			regulator_disable(data->hsic_pad_regulator);
>  	}
> -	put_device(data->usbmisc_data->dev);
> +	if (data->usbmisc_data)
> +		put_device(data->usbmisc_data->dev);
>  }
>  
>  static void ci_hdrc_imx_shutdown(struct platform_device *pdev)
> -- 
> 2.48.1
> 

-- 

Best regards,
Peter

