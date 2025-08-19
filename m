Return-Path: <stable+bounces-171762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D60CB2BFC2
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 13:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C37F189B6B4
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 11:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD22B31197C;
	Tue, 19 Aug 2025 11:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CA/FK1n1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A94427A12C
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 11:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755601352; cv=none; b=MYoCd5ip9DAlWrBIGtZ9AzyJfz/1qrXT7bgiOJGMriOQdpGjwy3UjwVWnkTzNfT/QuZaBkj3DKtopCpTHT1kOQ5SmUmB6M/q9YSawjz1YkEPYgA3jwf+OEcAKRU4slXYrckNohk+RKyXrSYwG1QUToc/DTzxdo6p6ZF/Omv7CEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755601352; c=relaxed/simple;
	bh=tc1F44b5CbupAjW1mDWs22b5LQd7sMtrHA7BJ47Svbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTGjQnT4utXVzEKn1MLCt9Aa+eRluv9qh93Dr+2yycYi9G+aVeFxLEq/k/CGBvMFgmaH6ZEuhSMbPP7hPrC7HuogIK1/XI353ijLb3vhpmEMuh/gIkFLRMnvZcjcSkNgg/M9K/8gwFAxpIfMJcFj0RRO+C0UwROspF2ls+5LxMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CA/FK1n1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F69C4CEF1;
	Tue, 19 Aug 2025 11:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755601352;
	bh=tc1F44b5CbupAjW1mDWs22b5LQd7sMtrHA7BJ47Svbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CA/FK1n1qP5/AntbWgsCYMtBaT4lYObaaiuq9EsZn8aHxcNfYTL8cM9RqYVfL00ie
	 gA7KNtzdQLt7UE1rqI5nTwEapyJdP8gKrJ2D7fvW9sa1dyytohf+Wafq5DIo5hNgvr
	 xm8gezbz04iWD7ScO4Z3RvTxtC+eo0ShInZOJCgY=
Date: Tue, 19 Aug 2025 13:02:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Anup Kulkarni <quic_anupkulk@quicinc.com>
Cc: kernel@oss.qualcomm.com, periph.upstream.reviewers@quicinc.com,
	quic_msavaliy@quicinc.com, quic_vdadhani@quicinc.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] tty: serial: qcom_geni_serial: Improve error handling
 for RS485 mode
Message-ID: <2025081912-exerciser-universal-f920@gregkh>
References: <20250818105918.1012694-1-quic_anupkulk@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818105918.1012694-1-quic_anupkulk@quicinc.com>

On Mon, Aug 18, 2025 at 04:29:18PM +0530, Anup Kulkarni wrote:
> Fix  error handling issues of  `uart_get_rs485_mode()` function by
> reordering resources_init() to occur after uart_get_rs485_mode.

What exactly is wrong with the current code?

> Remove multiple goto paths and use dev_err_probe to simplify error
> paths.

Don't mix fixes with cleanups please.  Shouldn't this be 2 patches?


> 
> Fixes: 4fcc287f3c69 ("serial: qcom-geni: Enable support for half-duplex mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anup Kulkarni <quic_anupkulk@quicinc.com>
> ---
> v3->v4
> - Added Fixes and Cc tag.
> 
> v2->v3
> - Reordered the function resources_init.
> - Removed goto.
> - Added dev_err_probe.
> 
> v1->v2
> - Updated commit message.
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 38 ++++++++++-----------------
>  1 file changed, 14 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 32ec632fd080..be998dd45968 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1882,15 +1882,9 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>  	port->se.dev = &pdev->dev;
>  	port->se.wrapper = dev_get_drvdata(pdev->dev.parent);
>  
> -	ret = port->dev_data->resources_init(uport);
> -	if (ret)
> -		return ret;
> -
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res) {
> -		ret = -EINVAL;
> -		goto error;
> -	}
> +	if (!res)
> +		return -EINVAL;

But now you are not calling the stuff that was previously at error:, are
you sure that is ok?  If so, why?

>  
>  	uport->mapbase = res->start;
>  
> @@ -1903,25 +1897,19 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>  	if (!data->console) {
>  		port->rx_buf = devm_kzalloc(uport->dev,
>  					    DMA_RX_BUF_SIZE, GFP_KERNEL);
> -		if (!port->rx_buf) {
> -			ret = -ENOMEM;
> -			goto error;
> -		}
> +		if (!port->rx_buf)
> +			return -ENOMEM;

Same here.

As you are mixing different things in the same patch, it's hard to find
the original "bug" you are attempting to solve here.  I can't see it...

Please redo this as a patch series.

thanks,

greg k-h

