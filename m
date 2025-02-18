Return-Path: <stable+bounces-116634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F9BA3902E
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 02:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50003168029
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 01:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8282A3A1B6;
	Tue, 18 Feb 2025 01:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lj3ovUrV"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C8484D34;
	Tue, 18 Feb 2025 01:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739841028; cv=none; b=HP54uh/5pSfn9yfYxz5JcQRGMa50yy8OaqLVZlX0L9XCFQd4TQ7XxVCgHPNPJmJv+6/WOL0szHcNJRxO0C3WxMidh9ZJDJkzt1VitOCXnN2PMFBxTtFgQfMj9cGxJCI4//Jj9g5k30OWZ94Bsn/+LQl+EDMAy1fLs511L0zsphQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739841028; c=relaxed/simple;
	bh=mp41Y2E+0Yi5ho4XyG2Vk8jU5I+itfdLIQ/z4tHFpHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzC2FUgNmzCyC5fdMzRIZCLqxhZ/3lpoLqs17vsny22ZvZi3T2bQZ8CMd54SH1qGk69kyKVTOnt4EGQvD/csVAB9i65Fd1AngWrxLFjmDILEHNNRn2upO1fvKSZy9Jkh8lIq6uu+FoGj+KGF1fiPzpswz1lh1DK0Vb5T4c1YKVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lj3ovUrV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hQf6BQmTrhmN5xM7XWiDSR55b1HKStYnTUiapIt/KYM=; b=lj3ovUrVNBrgmFnmw6mSqZ6L/1
	hyFv5scaXARlvfmV69IzrWj3xM31BmASongb3cFpc43edLuIsBw0X8FNeHNlZMn1OCWyyMU9GAyOe
	qluzF6PRSDAkKtNGdKjjTElXbsnH+imoUtLL5X44MyiNXaxII8SCdMJ7GkRK1zrCBphY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tkC7k-00F8VR-PI; Tue, 18 Feb 2025 02:10:08 +0100
Date: Tue, 18 Feb 2025 02:10:08 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	syzbot <syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: fix uninitialised access in mii_nway_restart()
Message-ID: <cf0d2929-d854-48ce-97eb-69747f0833f2@lunn.ch>
References: <20250218002443.11731-1-qasdev00@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218002443.11731-1-qasdev00@gmail.com>

On Tue, Feb 18, 2025 at 12:24:43AM +0000, Qasim Ijaz wrote:
> In mii_nway_restart() during the line:
> 
> 	bmcr = mii->mdio_read(mii->dev, mii->phy_id, MII_BMCR);
> 
> The code attempts to call mii->mdio_read which is ch9200_mdio_read().
> 
> ch9200_mdio_read() utilises a local buffer, which is initialised 
> with control_read():
> 
> 	unsigned char buff[2];
> 	
> However buff is conditionally initialised inside control_read():
> 
> 	if (err == size) {
> 		memcpy(data, buf, size);
> 	}
> 
> If the condition of "err == size" is not met, then buff remains 
> uninitialised. Once this happens the uninitialised buff is accessed 
> and returned during ch9200_mdio_read():
> 
> 	return (buff[0] | buff[1] << 8);
> 	
> The problem stems from the fact that ch9200_mdio_read() ignores the
> return value of control_read(), leading to uinit-access of buff.
> 
> To fix this we should check the return value of control_read()
> and return early on error.

What about get_mac_address()?

If you find a bug, it is a good idea to look around and see if there
are any more instances of the same bug. I could be wrong, but it seems
like get_mac_address() suffers from the same problem?

	Andrew

