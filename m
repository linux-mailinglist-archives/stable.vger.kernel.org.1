Return-Path: <stable+bounces-152718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB538ADB3A3
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 16:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA4EA1882745
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 14:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69E921B185;
	Mon, 16 Jun 2025 14:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JBx8fsLo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5A41FDE31;
	Mon, 16 Jun 2025 14:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750083454; cv=none; b=oVrlVkcnX7C5WwNhgrU81+e4eg+C+ZwF7s1nEXSjUbNFjVkjtpJoro0ZXWIgQRrHYt9IjTpvZvESneD7Ry4KW6X5d0Ryg+1SXak+lmOw2njCC7GawsV+fXTNHtPcFIozqoyTyNSt13aixYeovcaBg9BqNCtt+81QW8O0iRKRE64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750083454; c=relaxed/simple;
	bh=7vD+jdFcbRODnTyocCRqC2CBnN4fjCfLQDbcXwpnOFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zsvpf4a/h+sG7F9ep7+s7eOiXxGvlMYQxblfqArMD3u6NoUOTFTJurzqaRnV54UWH9nJJofpM0SzfXzy0e/+X71znyhEIpZuLdiC/t11NfB3OfLU9meHVzCkmYIXsOrsLj9Sy7Qnj5Q6C8XWX4lVYVX9JRGhv/XZn52NOm8zwLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JBx8fsLo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E27C4CEEA;
	Mon, 16 Jun 2025 14:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750083454;
	bh=7vD+jdFcbRODnTyocCRqC2CBnN4fjCfLQDbcXwpnOFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JBx8fsLok416/BE/CRF9cIHl1X7u6rcJT9hirMbzyUtEPyE5nP27OqsGSo9d6VcrM
	 rnZk3M53sB+oeNQ815/7F89jqwyJQKRNenNBCsH3tGIn8P9ceUPGhfNFWnwJF1IcLx
	 qQUPXZUK/1AftN5AznCXG0ZbWdTZRICNSZ0IiRdg=
Date: Mon, 16 Jun 2025 16:17:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kuen-Han Tsai <khtsai@google.com>
Cc: prashanth.k@oss.qualcomm.com, hulianqin@vivo.com,
	krzysztof.kozlowski@linaro.org, mwalle@kernel.org,
	jirislaby@kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: gadget: u_serial: Fix race condition in TTY
 wakeup
Message-ID: <2025061634-heavily-outrage-603a@gregkh>
References: <20250616132152.1544096-1-khtsai@google.com>
 <20250616132152.1544096-2-khtsai@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616132152.1544096-2-khtsai@google.com>

On Mon, Jun 16, 2025 at 09:21:47PM +0800, Kuen-Han Tsai wrote:
> A race condition occurs when gs_start_io() calls either gs_start_rx() or
> gs_start_tx(), as those functions briefly drop the port_lock for
> usb_ep_queue(). This allows gs_close() and gserial_disconnect() to clear
> port.tty and port_usb, respectively.
> 
> Use the null-safe TTY Port helper function to wake up TTY.
> 
> Cc: stable@vger.kernel.org
> Fixes: 35f95fd7f234 ("TTY: usb/u_serial, use tty from tty_port")
> Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
> ---
> Explanation:
>     CPU1:                            CPU2:
>     gserial_connect() // lock
>                                      gs_close() // await lock
>     gs_start_rx()     // unlock
>     usb_ep_queue()
>                                      gs_close() // lock, reset port_tty and unlock
>     gs_start_rx()     // lock
>     tty_wakeup()      // dereference

Why isn't this up in the changelog?

> 
> Stack traces:
> [   51.494375][  T278] ttyGS1: shutdown
> [   51.494817][  T269] android_work: sent uevent USB_STATE=DISCONNECTED
> [   52.115792][ T1508] usb: [dm_bind] generic ttyGS1: super speed IN/ep1in OUT/ep1out
> [   52.516288][ T1026] android_work: sent uevent USB_STATE=CONNECTED
> [   52.551667][ T1533] gserial_connect: start ttyGS1
> [   52.565634][ T1533] [khtsai] enter gs_start_io, ttyGS1, port->port.tty=0000000046bd4060
> [   52.565671][ T1533] [khtsai] gs_start_rx, unlock port ttyGS1
> [   52.591552][ T1533] [khtsai] gs_start_rx, lock port ttyGS1
> [   52.619901][ T1533] [khtsai] gs_start_rx, unlock port ttyGS1
> [   52.638659][ T1325] [khtsai] gs_close, lock port ttyGS1
> [   52.656842][ T1325] gs_close: ttyGS1 (0000000046bd4060,00000000be9750a5) ...
> [   52.683005][ T1325] [khtsai] gs_close, clear ttyGS1
> [   52.683007][ T1325] gs_close: ttyGS1 (0000000046bd4060,00000000be9750a5) done!
> [   52.708643][ T1325] [khtsai] gs_close, unlock port ttyGS1
> [   52.747592][ T1533] [khtsai] gs_start_rx, lock port ttyGS1
> [   52.747616][ T1533] [khtsai] gs_start_io, ttyGS1, going to call tty_wakeup(), port->port.tty=0000000000000000
> [   52.747629][ T1533] Unable to handle kernel NULL pointer dereference at virtual address 00000000000001f8

What is [khtsai] from?

thanks,

greg k-h

