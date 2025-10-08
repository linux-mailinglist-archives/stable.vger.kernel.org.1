Return-Path: <stable+bounces-183580-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BC9BC35B8
	for <lists+stable@lfdr.de>; Wed, 08 Oct 2025 06:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C9631886A55
	for <lists+stable@lfdr.de>; Wed,  8 Oct 2025 04:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239162BFC60;
	Wed,  8 Oct 2025 04:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="14fxT6kY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA68A2BF01D;
	Wed,  8 Oct 2025 04:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759899505; cv=none; b=ruLWXRvUEIepHhMmqe0a+5oXwwcU2DRv4GlWINiVAXvtUCAm63nfY9wD+pUQz30Ym1bDz0MI1CmNSnCKgZNevMz57ypi48HB68h4T8yPC6wxNhYvTZpL+qJnwQyrmec+k+lICXijOwuWuYGc5HIGAFvTvG31sgpkfXj3uZYifZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759899505; c=relaxed/simple;
	bh=Gc5kuSx8Wv53/KioYtvOBgndz3B4AbmBS/aGNh0PRqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJpKwrfN40qxQ2B6UjxyISjqIZKU84bP2tX86ngLBaQeWZGHnafgOPBtJNCAYhbG9fmlciewYqxEPR7ak6H7pa6Xc5WqYML3CvbPK34y2paFJjQ3vGjIBOB69Nvs5pdVmU3Eb6J9JzPRMvO2mhQLbzNWsMm/thMoY8eljxpn/Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=14fxT6kY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D750BC4CEF4;
	Wed,  8 Oct 2025 04:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759899505;
	bh=Gc5kuSx8Wv53/KioYtvOBgndz3B4AbmBS/aGNh0PRqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=14fxT6kYuAAcHKtb95yS3SxdvBzJB5HFzQGhRw1hSPKsAJq/S4xd5sFT/1JdBe3/D
	 93FtypPpm7ZfMJ9PfE2p/oKzByXBYxRGRi9T/uuqzFBeiyQt7Ct+HntVPStrjrL9Bs
	 0FL/gjGRdOp3mp7dqGUUhpQji1p6mugu0qTgMEOY=
Date: Wed, 8 Oct 2025 06:58:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: pip-izony <eeodqql09@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: bfusb: Fix buffer over-read in rx processing
 loop
Message-ID: <2025100813-thicken-snowfall-0d4d@gregkh>
References: <20251007232941.3742133-2-eeodqql09@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007232941.3742133-2-eeodqql09@gmail.com>

On Tue, Oct 07, 2025 at 07:29:42PM -0400, pip-izony wrote:
> From: Seungjin Bae <eeodqql09@gmail.com>
> 
> The bfusb_rx_complete() function parses incoming URB data in while loop.
> The logic does not sufficiently validate the remaining buffer size(count)
> accross loop iterations, which can lead to a buffer over-read.
> 
> For example, with 4-bytes remaining buffer, if the first iteration takes
> the `hdr & 0x4000` branch, 2-bytes are consumed. On the next iteration,
> only 2-bytes remain, but the else branch is trying to access the third
> byte(buf[2]). This causes an out-of-bounds read and a potential kernel panic.
> 
> This patch fixes the vulnerability by adding checks to ensure enough
> data remains in the buffer before it is accessed.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>
> ---
>  drivers/bluetooth/bfusb.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
> index 8df310983bf6..f17eae6dbd7d 100644
> --- a/drivers/bluetooth/bfusb.c
> +++ b/drivers/bluetooth/bfusb.c
> @@ -360,6 +360,10 @@ static void bfusb_rx_complete(struct urb *urb)
>  			count -= 2;
>  			buf   += 2;
>  		} else {
> +            if (count < 3) {
> +                bf_dev_err(data->hdev, "block header is too short");
> +                break;
> +            }
>  			len = (buf[2] == 0) ? 256 : buf[2];
>  			count -= 3;
>  			buf   += 3;
> -- 
> 2.43.0
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

