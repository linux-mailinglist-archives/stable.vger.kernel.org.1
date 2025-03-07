Return-Path: <stable+bounces-121434-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB95A56FC8
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 18:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7664188E7FC
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 17:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BCE23E227;
	Fri,  7 Mar 2025 17:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bTsACDhY"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB891607A4;
	Fri,  7 Mar 2025 17:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741370190; cv=none; b=EKZRH/Q3Cg56Dv+zjr+GWx07HFTL2eagMN9eU0hC1meJpwEbLjiCB+t5/mjT7JO+aQ6mHTjwkBu6Jeo+TrOiJhb5Jx5ERN8+zUWXD+E376VYco0AsMqCEcibP7DuscycRqx8kwTyxQ6SLkxOP+3zJ75rvwK+bYQEVfLEVycIaGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741370190; c=relaxed/simple;
	bh=ZqLvbEehtnYAVsSUHOluInzXVRcSuXHKIFUm4k719OI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpnpElPn+7ySV5FAxE91JNr528c85wH1QTnIxTfxm6bUM6Y371L0Bw5reOUeP4Hc+4fp20V9XII5I9huIvJ0+p/DtAi6qo0cjiK4V15DvWiEtPAOs1o+T0trsctEnFQwkaK84KJoG9glC6OD88fNLRmmb1OLNWytqwVKyj/rmQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bTsACDhY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rdRzk+Is7as6cRJ5/VfyB20BcRDF79VzQLmXma/JgDc=; b=bTsACDhYwgWDz3srbPJqNNYNQZ
	1S1+4QGONJ30W29wz6XdFZv215awFsMqBZo8ZvEa8AXWCGp1AL4jnO+E5Ds1SgOjcEqCM2uYdBFBe
	MxCDccdbdQdUtaYcdsyzii8/wuHDqNmoDzFqS5UBTdunEc2SxYGdIKyPAkT2/Pim6hl4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tqbvo-003DHR-DH; Fri, 07 Mar 2025 18:56:20 +0100
Date: Fri, 7 Mar 2025 18:56:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: fix uninitialised access in mii_nway_restart()
Message-ID: <9242fedf-3450-4d6e-b08d-846956f2cb9d@lunn.ch>
References: <Z7R6uet1dJ1UJsJ1@qasdev.system>
 <418ddcf6-e7c9-4a8e-ba1a-38a83cb2b5f8@lunn.ch>
 <Z8sywbV8B3Nm3BKR@qasdev.system>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8sywbV8B3Nm3BKR@qasdev.system>

> Hi Andrew,
> 
> Just following up on my patch regarding the uninitialized access fix in mii_nway_restart(). 
> As I mentioned in my previous message, how about an approach similar to the patch for ch9200_mdio_read() 
> for get_mac_address() where we immediately check the return value of each control_read() call and return 
> an error if any call fails? This way we don't continue if failure occurs. If you're good with this approach, 
> should I submit a patch v2?

Yes, this would be good.

Thanks
	Andrew

