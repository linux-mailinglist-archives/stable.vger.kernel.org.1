Return-Path: <stable+bounces-190006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E604BC0E8FD
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 15:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 95A2E4FCD90
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 14:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4516E2C0F95;
	Mon, 27 Oct 2025 14:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kxwSkzWF"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFD01990D9;
	Mon, 27 Oct 2025 14:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761576105; cv=none; b=OaAi8/ykXy51CKpnRRKviA2QVHbXncYxc9p8T6cWGmUX4CVPCy6ScbQfTDTa2ISx1M8pKlbUrJ1Jrxn+PqKVgBr7LBeYJCSppL1KrLhAjeqgBTlESLLWkWcce2Dvof9YnvYljDpWF+YjX0l6o/s412ADk6Q1+4ZaskGnmAn1OWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761576105; c=relaxed/simple;
	bh=vhHN2CWlz68ehyr1Y2hDojwu9+Vue88/Z0ZxYv7WECM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgZ7moBIetzX0+utJy7wexxg8b8lQad9QDrf3K5vRoIV2+rHj9VHlWAQ6aB1VaTydHOkyJ8w8TgdKzNoDSQ3+dddp3j/HS/yrYOc0tFosku/Zzn5+D+4vpNYrBCccyYQprHk0wU2Eqe2KHJkH8xrOC3aBIeYcAAlK4rLSTHkEPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kxwSkzWF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sgneSpTtmkYD7aVSON0HmkCfsNXMfkSDiuyU+kka0Ww=; b=kxwSkzWFmWtZhEHJ0UgnvuvjhV
	qPy/NTHigiOoD3XebU6/1WMXTxbJdsxzbDmnVDqT58uivysQ+lMtLy1D87iPDdyZGBTbBE9FLcIfl
	CVy+snMTfmeO2KGPVz+ODvUC244Qmmz+YBV2R9QkfbEbRwmFBFF8HpXyq9/IvtQlza/E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vDOPU-00CCd4-G7; Mon, 27 Oct 2025 15:41:24 +0100
Date: Mon, 27 Oct 2025 15:41:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Russell King <linux@armlinux.org.uk>,
	Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] net: phy: dp83867: Disable EEE support as not
 implemented
Message-ID: <539795a1-2a69-4fcb-88e7-ca4e3b13ad7c@lunn.ch>
References: <20251023144857.529566-1-ghidoliemanuele@gmail.com>
 <ae723e7c-f876-45ef-bc41-3b39dc1dc76b@lunn.ch>
 <664ef58b-d7e6-4f08-b88f-e7c2cf08c83c@gmail.com>
 <df3aac25-e8e9-46cb-bd92-637822665080@lunn.ch>
 <20251027143522.GA57409@francesco-nb>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027143522.GA57409@francesco-nb>

> I was talking together with Emanuele on this topic and we are confused
> on how to proceed.
> 
> >From the various comments and tests in this thread, to me the actual
> code change is correct, the dp83867 does not support EEE and we have to
> explicitly disable it in the dp83867 driver.
> 
> As of now we do not have a clear shared understanding on what is going
> on in the stmmac driver. And the commit message is not correct on this
> regard.
> 
> This patch is already merged [1] in netdev tree, should we send a series
> reverting this commit and another commit with just the same change and a
> different commit message? 

No, if its merged, its merged. What should come out of this is a
learning, please be precise with commit messages, more detail rather
than less, and provide as much supporting evidence as you can for any
claims you make.

> In parallel, unrelated to the dp83867 topic, Emanuele is trying to help
> figuring out why the actual behavior of the stmmac changed after Russell
> refactoring. And it's clear that this change in behavior is not expected.

Great.

	Andrew

