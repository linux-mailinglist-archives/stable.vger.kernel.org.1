Return-Path: <stable+bounces-210260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A169D39E9C
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 07:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0A11300EF61
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 06:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76006270ED2;
	Mon, 19 Jan 2026 06:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N2/BxeaP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32872741B5;
	Mon, 19 Jan 2026 06:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768804577; cv=none; b=Ulcts0f2KPRvnsznScOeT36WHdJa+xdcU0ZUYGEYx+nvjBAammIY1G8LP2X41gJ5U+rbPgMV3MTIXMzEqfMIcd6InjaYResstvXA29Kxj2sGBoJIAfVaWa7NLeVqaT49l5PxbUj9UkC8zMLJzflM2uBMMcS/6pCCgyw5WdnHhLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768804577; c=relaxed/simple;
	bh=5dtS4ga/Ke+/MmRChzMAycuj4CPnSmMhUgaeOvlfUpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0oBbtucAXWduKQAHVUGoPPAc5DCvhJksm6m5noqAz3EJIqVFTXaP8C2zNn5oQsx7+WG6vPRu+c7OFI/QRWEWUbcnZnjehG+Cfq1s7OlO+WruW6GKOXlEdVrgCkmQ+aHxMq5UK2msac3d0UzpSgXi5p7VgrngOsvZUcjm1OqrW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N2/BxeaP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E4DC116C6;
	Mon, 19 Jan 2026 06:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768804577;
	bh=5dtS4ga/Ke+/MmRChzMAycuj4CPnSmMhUgaeOvlfUpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N2/BxeaPXR7cSw4oy0ewzGwWvwHHCZ4a+mUgyXD3psF+QKYceNz3cUJ95PPdpJPGb
	 puJssOwDrwgFQEBsTapttUPMy+UcUmlC+dm1EuCV0zpcEbeYgorhzxHrVbMmVzSSpK
	 HZkgTYzsjsPcBY60d7knpoxD7MVn+h/JZ6TuTghU=
Date: Mon, 19 Jan 2026 07:36:12 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Sjur Braendeland <sjur.brandeland@stericsson.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+f9d847b2b84164fa69f3@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] net: caif: fix memory leak in ldisc_receive
Message-ID: <2026011910-jubilance-supervise-00a0@gregkh>
References: <20260118174422.10257-1-osama.abdelkader@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260118174422.10257-1-osama.abdelkader@gmail.com>

On Sun, Jan 18, 2026 at 06:44:16PM +0100, Osama Abdelkader wrote:
> Add NULL pointer checks for ser and ser->dev in ldisc_receive() to
> prevent memory leaks when the function is called during device close
> or in race conditions where tty->disc_data or ser->dev may be NULL.
> 
> The memory leak occurred because ser->dev was accessed before checking
> if ser or ser->dev was NULL, which could cause a NULL pointer
> dereference or use of freed memory. Additionally, set tty->disc_data
> to NULL in ldisc_close() to prevent receive_buf() from using a freed
> ser pointer after the line discipline is closed.
> 
> Reported-by: syzbot+f9d847b2b84164fa69f3@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=f9d847b2b84164fa69f3
> Fixes: 9b27105b4a44 ("net-caif-driver: add CAIF serial driver (ldisc)")
> CC: stable@vger.kernel.org
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
> v2:
> 1.Combine NULL pointer checks for ser and ser->dev in ldisc_receive()
> 2.Set tty->disc_data = NULL in ldisc_close() to prevent receive_buf()
> from using a freed ser pointer after close.
> 3.Add NULL pointer check for ser in ldisc_close()

I see no locking fixes, so I don't see how this will really work.

How do the other ldisc drivers handle this same issue?

thanks,

greg k-h

