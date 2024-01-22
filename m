Return-Path: <stable+bounces-12368-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5743083648A
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 14:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D87B51F24966
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 13:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C9A3CF75;
	Mon, 22 Jan 2024 13:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="G0n4x4fA"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FC61E49E;
	Mon, 22 Jan 2024 13:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705930763; cv=none; b=RUdWrISvdoLElGsi5TS5VDlDow2s6fmCMQmGepGg/p7euSF8uRmHrm5wGzEncJmewZVA28T+kgF/pVE99aFpbTLFBSrFjVSyO7bUJTGNYcJeJiQNc0iGWWwzeA1sM3xDT75oV/4GnomP2IFqSjDFK0796nhAEUbuEcAF7tC2D7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705930763; c=relaxed/simple;
	bh=H8OS1k4imiYRFLvrosMPOBgiK5Ei2luCvZdO4IfnyKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iac2nQ5ay9jQ+uBhUeJWFBtlpFYs1Mjb/46aFyD8NtutxPTsF3rjbJGnfmE4oUgp9bX8exfYu0+VEOsOB/yFn8L22Bs3DnElecY4BSh5K8xf3ni4d7ayBpAY0c1w8TAqUgNy/Sm8UZeCnWOR3DTsDOyMLr9Y9JAPkG6DbcHXrJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=G0n4x4fA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=inkNdkzIOZpYrPiu0QHK8Yv6PrPbJv7H52H4x2uRAXI=; b=G0n4x4fAWBrYFQjC2lBudUg4c5
	BROF3FzV+vAZWUXzRsiLFecofiwpwRqxYT5eR33nVN+bD2VGz7nYTv3JD1trJAZt+NaML4lltHOwo
	HzfyFpA/BnZK7ZtkoKMNoMl1VnHmTNihwduOKQU6Yca5ZjYMEnF0UbmI5h3QKsVPkfSs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rRuW6-005jDH-34; Mon, 22 Jan 2024 14:39:10 +0100
Date: Mon, 22 Jan 2024 14:39:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev-maintainers <edumazet@google.com>, kuba@kernel.org,
	pabeni@redhat.com, davem@davemloft.net,
	netdev <netdev@vger.kernel.org>, stable@vger.kernel.org,
	Tim Menninger <tmenninger@purestorage.com>
Subject: Re: [PATCH net v1] net: dsa: mv88e6xxx: Make unsupported C45 reads
 return 0xffff
Message-ID: <0d9e0412-6ca3-407a-b2a1-b18ab4c20714@lunn.ch>
References: <20240120192125.1340857-1-andrew@lunn.ch>
 <20240122122457.jt6xgvbiffhmmksr@skbuf>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122122457.jt6xgvbiffhmmksr@skbuf>

On Mon, Jan 22, 2024 at 02:24:57PM +0200, Vladimir Oltean wrote:
> Hi Andrew,
> 
> On Sat, Jan 20, 2024 at 08:21:25PM +0100, Andrew Lunn wrote:
> > When there is no device on the bus for a given address, the pull up
> > resistor on the data line results in the read returning 0xffff. The
> > phylib core code understands this when scanning for devices on the
> > bus, and a number of MDIO bus masters make use of this as a way to
> > indicate they cannot perform the read.
> > 
> > Make us of this as a minimal fix for stable where the mv88e6xxx
> 
> s/us/use/
> 
> Also, what is the "proper" fix if this is the minimal one for stable?

Hi Vladimir

I have a patchset for net-next, once it opens. I looked at how C22 and
C45 differ in handling error codes. C22 allows the MDIO bus driver to
return -ENODEV to indicate its impossible for a device to be at a
given address. The scan code then skips that address and continues to
the next address. Current C45 code would turn that -ENODEV into an
-EIO and consider it fatal. So i change the C45 code to allow for
-ENODEV in the same way, and change the mv88e6xxx driver to return
-ENODEV if there are is no C45 read op.

Since making the handling of the error codes uniform is more than a
simple fix, i decided on a minimal fix for net.

Thanks for the comments on the commit message, i will address them
soon.

	Andrew

