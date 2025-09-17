Return-Path: <stable+bounces-179825-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13203B7E513
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49B253B4772
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 11:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6994C2E0923;
	Wed, 17 Sep 2025 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WRpkJFId"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBFF29A33E;
	Wed, 17 Sep 2025 11:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758107724; cv=none; b=rye5YN3Z8hIaaNKtRe7jknBP6GxZAzHl6hoVwxl+SEgk0Vm/trHtbWC1oySKhhFxXSUOrknyOLfcYnKrno+WVgWC03Xfw5+M3bEpqSalEOSFxDVdRmXG5yVESTob1wrI+oBtv8zFJJpFbXesSvYg2GkDHCWkEQSoFm8uPT5pKYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758107724; c=relaxed/simple;
	bh=uDP2b4S2SvL1JYH08JdqWPZeiRysWaiCHsC50RoU31c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DsqNqLaGUFNXHiUeSzCqFXAGSmUtWWdLq2drVZvhdX9lfqHwfKPR8M/vTTxce9vqgaQ5J0RPLKS7df2qlE2wQuxIiuWGmhtXhu2Y7uEwSoJjZbR0kT/tB60wmdOSuTihGAhtAt29tLCXwuCCzH+fgoSX9n1wHG89BHQTLdcQ6QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WRpkJFId; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2979C4CEF0;
	Wed, 17 Sep 2025 11:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758107723;
	bh=uDP2b4S2SvL1JYH08JdqWPZeiRysWaiCHsC50RoU31c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WRpkJFIdt7CuYVdA8DMIS++lYnxY0qO6qgWdE+SIfzL4CK9n9KpAcgG2qL9p2LQd2
	 26XQ2PU86QOv2Z/mlz6cwK+2oIWTG60dRtY8C1A8Ip9lFflv0m42XFp8gwkRugaKaP
	 VrmcilsloCORSwqN0srBU1TtzB/M17dP3WU5cE7M=
Date: Wed, 17 Sep 2025 13:15:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Anup Kulkarni <anup.kulkarni@oss.qualcomm.com>
Cc: jirislaby@kernel.org, johan+linaro@kernel.org, dianders@chromium.org,
	quic_ptalari@quicinc.com, bryan.odonoghue@linaro.org,
	quic_zongjian@quicinc.com, quic_jseerapu@quicinc.com,
	quic_vdadhani@quicinc.com, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	mukesh.savaliya@oss.qualcomm.com, viken.dadhaniya@oss.qualcomm.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] tty: serial: qcom_geni_serial: Fix error handling for
 RS485 mode
Message-ID: <2025091701-glamorous-financial-b649@gregkh>
References: <20250916093957.4058328-1-anup.kulkarni@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916093957.4058328-1-anup.kulkarni@oss.qualcomm.com>

On Tue, Sep 16, 2025 at 03:09:57PM +0530, Anup Kulkarni wrote:
> If uart_get_rs485() fails, the driver returns without detaching
> the PM domain list.
> 
> Fix the error handling path in uart_get_rs485_mode() to ensure the
> PM domain list is detached before exiting.
> 
> Fixes: 86fa39dd6fb7 ("serial: qcom-geni: Enable Serial on SA8255p Qualcomm platforms")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anup Kulkarni <anup.kulkarni@oss.qualcomm.com>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I've taken
https://lore.kernel.org/r/20250917010437.129912-2-krzysztof.kozlowski@linaro.org
instead, so this shouldn't be needed anymore.

thanks,

greg k-h

