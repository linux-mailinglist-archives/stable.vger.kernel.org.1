Return-Path: <stable+bounces-191758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D903C2184F
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 18:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37F964E2B69
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 17:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E3736B982;
	Thu, 30 Oct 2025 17:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tdJNHn9r"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB6D24BBEE;
	Thu, 30 Oct 2025 17:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761845890; cv=none; b=s62bJhORWpWzr9xXPV3z0sC9ZJSd6vcw/S4gYkYXOK9YdQ0Q5102nkJsPEWCLreCP7ml6iM+OWifBDC0BO+wZagu0d9lGJxYgM1CTlgyPC6tTpxmnu/XOkYjo2mINK3oCJ7SxCzzeE7TPdloe4ThwncQLLrULkHgXT9R81sCYa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761845890; c=relaxed/simple;
	bh=n+E2FDQMzyue9+MdBENohOQ4Hy7t5K7MNazW9zFdZ30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GF0mB5IlxYhEUst0rrBPWc6roI3FXY60/Z0d1kfY3Kv4Oeloi17+/nIMQ8jJwEaVbB9enso8pUs7zmLzWhHncgQ0EMTvjNrQI8tNZ2kNSFVwBQb3LjGTXAsOiE/wr9rVZRje9EiydcmR3SGmxeCKbhgpFjikKn0p7ZUnYnP5ibs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tdJNHn9r; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1skhUG0vBEhCXLwn0Npbuxg9kdPLx5DwATtJQ8dFMTg=; b=tdJNHn9rOe0S+1GB8M+UuknrHx
	9QhQySt5tWqCBZ5TX58LkvfVpWru/dcPEc/KXPi55HzTOF/AgMivnWM0zgqbEBFkOjeYwfkC1gpu0
	Rqun9PZRs5Uyu9YvDZUTiMwFb6AYyr5eMh34GiMLVM1yLk2XPEMtILGP4mQxKlr+SQM8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vEWax-00CX37-SN; Thu, 30 Oct 2025 18:37:55 +0100
Date: Thu, 30 Oct 2025 18:37:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Rasesh Mody <rmody@marvell.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] bna: prevent bad user input in bnad_debugfs_write_regrd()
Message-ID: <75e4c931-3e17-430a-a902-60f9d8161bc3@lunn.ch>
References: <20251030053411.710-1-linmq006@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030053411.710-1-linmq006@gmail.com>

On Thu, Oct 30, 2025 at 01:34:10PM +0800, Miaoqian Lin wrote:
> A malicious user could pass an arbitrarily bad value
> to memdup_user_nul(), potentially causing kernel crash.

How would it crash the kernel? I would expect memdup_user_nul() to
either succeed or fail and return a NULL.

However, adding a range check does make sense.

> This follows the same pattern as commit ee76746387f6
> ("netdevsim: prevent bad user input in nsim_dev_health_break_write()")
> and commit 7ef4c19d245f
> ("smackfs: restrict bytes count in smackfs write functions")
> 
> Found via static analysis and code review.
> 
> Fixes: d0e6a8064c42 ("bna: use memdup_user to copy userspace buffers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/net/ethernet/brocade/bna/bnad_debugfs.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/brocade/bna/bnad_debugfs.c b/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
> index 8f0972e6737c..ad33ab1d266d 100644
> --- a/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
> +++ b/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
> @@ -311,6 +311,9 @@ bnad_debugfs_write_regrd(struct file *file, const char __user *buf,
>  	unsigned long flags;
>  	void *kern_buf;
>  
> +	if (nbytes == 0 || nbytes > PAGE_SIZE)
> +		return -EINVAL;
> +
>  	/* Copy the user space buf */
>  	kern_buf = memdup_user_nul(buf, nbytes);
>  	if (IS_ERR(kern_buf))

Look at what it does next:

rc = sscanf(kern_buf, "%x:%x", &addr, &len);

What is the maximum length of "%x:%x" ? A lot less than PAGE_SIZE. So
you can make the range check much smaller.

Also, what about bnad_debugfs_write_regwr()? If you find a bug, look
around, the same bug might be repeated close by. You might also want
to look at your static analysis tool and find out why it did not
report that function.

    Andrew

---
pw-bot: cr

