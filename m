Return-Path: <stable+bounces-132405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 945C8A87931
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 09:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39435171552
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 07:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8577F2638B5;
	Mon, 14 Apr 2025 07:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aQomknKC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3B9259CAA;
	Mon, 14 Apr 2025 07:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744616403; cv=none; b=YtbZmlGFobvZ7HgNrSVa6TmgkMXd+2mYAWRVR/lO3ILLSN8euqs0DRqT98HhvCyTclN1YtLNtEsO+TKPjInhXlFbHl7CQGs8Nj56KbJgsdhAVhBkisYhdJCqLHkiLVMiTmUHmBxyFb2vwC1r5y/hxXsO8atFYxZGF8Yk4emLdIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744616403; c=relaxed/simple;
	bh=Jdc3Sdb+T3hXBHxMM/PZuX2CtZ5zxQDWZN9YLSsJ0KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKWpzwBicqeAJxEd7rJ55SZJ/pqvjGkNa548YLLXwRfvuc/ghSS6WgajWaYe/fDiu5zZH4tSeci2ie3UsxQiGppWfEpPbYhz8djimpW+3gu+2MPCLGTD9gMLGbHOxqn/2ngbrntJGFfffsjyt5MuRyfSlEz8sqXSvPJ4nkcLmcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aQomknKC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C7CC4CEE2;
	Mon, 14 Apr 2025 07:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744616402;
	bh=Jdc3Sdb+T3hXBHxMM/PZuX2CtZ5zxQDWZN9YLSsJ0KQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aQomknKCl97AYUIgr39dKENVM6QSDfZGeLyenv/pZEM1TcKi1GRd4rFRn7xeX3I+S
	 LQwO5PeLE0C1wnWPmFPzbyRJRP6zJXmxNGLGmqGgNmX+I/TrIf8Q8W9O3HKJ5sqvex
	 DpX7ZYvuTukPdlJcyoS4UlD2uf4wb0yPocJPbMYo=
Date: Mon, 14 Apr 2025 09:38:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH RESEND] usb: renesas_usbhs: Add error handling for
 usbhsf_fifo_select()
Message-ID: <2025041410-module-egotistic-6857@gregkh>
References: <20250414072501.2259-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414072501.2259-1-vulab@iscas.ac.cn>

On Mon, Apr 14, 2025 at 03:25:01PM +0800, Wentao Liang wrote:
> In usbhsf_dcp_data_stage_prepare_pop(), the return value of
> usbhsf_fifo_select() needs to be checked. A proper implementation
> can be found in usbhsf_dma_try_pop_with_rx_irq().
> 
> Add an error check and jump to PIO pop when FIFO selection fails.
> 
> Fixes: 9e74d601de8a ("usb: gadget: renesas_usbhs: add data/status stage handler")
> Cc: stable@vger.kernel.org # v3.2+
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/usb/renesas_usbhs/fifo.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Why is this RESEND?  What happened to the first one?

thanks,

greg k-h

