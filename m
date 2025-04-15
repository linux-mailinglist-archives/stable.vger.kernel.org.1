Return-Path: <stable+bounces-132677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA5DA89146
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 03:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 924D41798F7
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 01:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550AA200B9F;
	Tue, 15 Apr 2025 01:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UYdXo+Jo"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645F713EFE3;
	Tue, 15 Apr 2025 01:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744680540; cv=none; b=pe18JFRM/5z0GRvovR5bopcuA3YgNLW5N+Xpa65jPiMecOAO2btg940LmwDkuuq979pPyXrjtziRmA+BLVuQMbJ9XAZZxbDNmY033bW/uj3nQMBw9RT5TD8Bx2cjhDrEKQYNoeYSqqRCzoVgWOJ8isr0ycrku5BypTT+P6dEQUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744680540; c=relaxed/simple;
	bh=HRa13erYZk9bATzeDQruOcBrjxMgJ3QAfiCWKOzfm18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxpbl4bcpvccTvLNWQHcM1YicBMKEh0SJzU4/XNKVEddCVPpQhJewJuedjptIK6wtZwKM8v47FoiwuxH+uTAn8HbFvJERmVC4jfRBlRSlcJzDbOBbidJKn2Apc0+hMYznviiBf5CRnRn9ImUSvu9XFvf7RKbT9cEJ3wUDyfzzFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UYdXo+Jo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oZSUDClmcrLlpebSEps05boU8vn4SHvF/YKvatAXSzI=; b=UYdXo+JoekmZsTER7TvzE8Elzp
	aMFY3wuSuWdl9XIEX8CLPMtIn+AOjETEevsxYO4NRT9tDOTEp9VbWv3f6pXi8lj8hkHKUGAqVZCCj
	V5oAvi0b1r4f7XQcJpXyplsCQS5C8F2VcYmePWMPIW/re78lcL1vz94O4fm0kl18wRiY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u4V6Y-009Jr8-Hz; Tue, 15 Apr 2025 03:28:50 +0200
Date: Tue, 15 Apr 2025 03:28:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/5] net: ch9200: fix uninitialised access bug during
 mii_nway_restart
Message-ID: <748d2e6c-68c0-43d4-8464-12e4942c7633@lunn.ch>
References: <20250412183829.41342-1-qasdev00@gmail.com>
 <20250412183829.41342-2-qasdev00@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250412183829.41342-2-qasdev00@gmail.com>

On Sat, Apr 12, 2025 at 07:38:25PM +0100, Qasim Ijaz wrote:
> In mii_nway_restart() during the line:
> 
>         bmcr = mii->mdio_read(mii->dev, mii->phy_id, MII_BMCR);
> 
> The code attempts to call mii->mdio_read which is ch9200_mdio_read().
> 
> ch9200_mdio_read() utilises a local buffer, which is initialised
> with control_read():
> 
>         unsigned char buff[2];
> 
> However buff is conditionally initialised inside control_read():
> 
>         if (err == size) {
>                 memcpy(data, buf, size);
>         }
> 
> If the condition of "err == size" is not met, then buff remains
> uninitialised. Once this happens the uninitialised buff is accessed
> and returned during ch9200_mdio_read():
> 
>         return (buff[0] | buff[1] << 8);
> 
> The problem stems from the fact that ch9200_mdio_read() ignores the
> return value of control_read(), leading to uinit-access of buff.
> 
> To fix this we should check the return value of control_read()
> and return early on error. We return 0 on control_read() failure here 
> because returning a negative may trigger the "bmcr & BMCR_ANENABLE" 
> check within mii_nway_restart.
> 
> Reported-by: syzbot <syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com>
> Closes: https://syzkaller.appspot.com/bug?extid=3361c2d6f78a3e0892f9
> Tested-by: syzbot <syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com>
> Fixes: 4a476bd6d1d9 ("usbnet: New driver for QinHeng CH9200 devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

