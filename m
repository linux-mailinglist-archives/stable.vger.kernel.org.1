Return-Path: <stable+bounces-80695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3903798FA06
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 00:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9CD91F22FA2
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 22:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0481CDFA8;
	Thu,  3 Oct 2024 22:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wsOEB1NT"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8304713A89A;
	Thu,  3 Oct 2024 22:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727995525; cv=none; b=r1HgppggmRdZk8x9A4K1j9gAylB1RnjbbBPK8xirgB5Nt3TeO5OMvOCxK3E3//cWdo0sM7ixsB7BL93TJgjQ0cZWdZk38MuqI+nFtYj8VLakB9Rc4eUAXTO/xwJUaqQBvlkBXQHn3lhSxFcpR0FDBaBgSZauOe6E29KeJEtPRcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727995525; c=relaxed/simple;
	bh=lMgtSMZ2KqjnHCvyM6XBcKxO11FvCQkElxOjlkv/ry0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWopdTD1RRkAQlGRVTa4FcMqEPN28lkxsbIQ8X0Qcm+SjqNFablIiiA+GxGjg8hfcLZgN4LhrNxbxuBQUkNDEnoT9Noes1qsDf84V712JaN12K6B5DweRreCgC2+kdn9JyGyVW0vyLkQFDPj0bo0Pncqgb9vmvGA90NhgmnHEAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wsOEB1NT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QKXVFJJYcYqOryY7Uh3pAIQGSHvjYipApaiTYye82uc=; b=wsOEB1NTR1B2cbxGBeSLF/MRuu
	cz+LZ8xyLLmw8VJ3kW5Put4cHyxf+pWw/oIGrkNWPDXCi9btR8fuxL1guq1gddc6qFZv2odidx8rz
	OwFqKYy36Q88RGLOdjmGWBPEs0f8f/m0kZe3g0yxZmvNWqa9IfwUtvotM4dkxjTKbwHI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1swUZK-008zMU-57; Fri, 04 Oct 2024 00:45:10 +0200
Date: Fri, 4 Oct 2024 00:45:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>,
	stable@vger.kernel.org
Subject: Re: [net PATCH 1/2] net: phy: Remove LED entry from LEDs list on
 unregister
Message-ID: <f6e1eaf5-4d49-4394-a2e7-d739d7991d2f@lunn.ch>
References: <20241003221006.4568-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003221006.4568-1-ansuelsmth@gmail.com>

On Fri, Oct 04, 2024 at 12:10:04AM +0200, Christian Marangi wrote:
> Commit c938ab4da0eb ("net: phy: Manual remove LEDs to ensure correct
> ordering") correctly fixed a problem with using devm_ but missed
> removing the LED entry from the LEDs list.
> 
> This cause kernel panic on specific scenario where the port for the PHY
> is torn down and up and the kmod for the PHY is removed.
> 
> On setting the port down the first time, the assosiacted LEDs are
> correctly unregistered. The associated kmod for the PHY is now removed.
> The kmod is now added again and the port is now put up, the associated LED
> are registered again.
> On putting the port down again for the second time after these step, the
> LED list now have 4 elements. With the first 2 already unregistered
> previously and the 2 new one registered again.
> 
> This cause a kernel panic as the first 2 element should have been
> removed.
> 
> Fix this by correctly removing the element when LED is unregistered.
> 
> Reported-by: Daniel Golle <daniel@makrotopia.org>
> Tested-by: Daniel Golle <daniel@makrotopia.org>
> Cc: stable@vger.kernel.org
> Fixes: c938ab4da0eb ("net: phy: Manual remove LEDs to ensure correct ordering")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

