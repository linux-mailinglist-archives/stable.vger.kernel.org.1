Return-Path: <stable+bounces-191457-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 53859C14863
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 13:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0135E352982
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 12:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24023329C6A;
	Tue, 28 Oct 2025 12:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gn8t0AYS"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A893328617;
	Tue, 28 Oct 2025 12:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761653274; cv=none; b=a8puJqZuKpSkwSv1aZBlOq6gCUwdBJh8LmDMl1sm2C7sWu0N6HPmJwiHo6gGS/5Xe093JE+2ETOTju4aHVTqtjKfDXUEoN3ONW222suMkwXGVum87AFpz1gZU3eDut2Ucv9fZj4id1CupbnpmEbsQtTdwdnrNF2C2YKbJVbRRqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761653274; c=relaxed/simple;
	bh=u1SunBnJBpR3XIC+GQFPqQVA2buWUe167n+DlUNaLiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6fGP3v7tC651/B3T3Le2nJsXqCcrJ2IpL/VbyVajZ0lN3jf4V0MBMTBEDwEX7Al+AXZdi4ou01+ZEZFpLwJ7Y+arXV1xmn1jxLmwwxxDmKVYucNTiKRew+kCN4otMLD576PeFFbAGqd/WrIXTns+IyFhxPqbxxrFU1g6W22qSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gn8t0AYS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=X5pj/Ju4W3WzXkRM3dEkWqpDn5kaHUpFK+0+QS6hL58=; b=gn8t0AYSHyyAmvUzFAEQMJxmsj
	dOSwzv5Fuey/AAKEJmS6XptbjgxYc2wv5dQYw3C3riwGSOrqrA0vrOBdQsdjg22hybrVmZY6fHVYQ
	ctzTFq5nZUQ+z2QiJNh/4y/TB46t9P+V0/MPN0fpJjpJjcCmoqpM9hFqbicTGBOW5g/U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vDiUB-00CIBi-03; Tue, 28 Oct 2025 13:07:35 +0100
Date: Tue, 28 Oct 2025 13:07:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yi Cong <cong.yi@linux.dev>
Cc: Frank.Sae@motor-comm.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	hkallweit1@gmail.com, kuba@kernel.org, linux@armlinux.org.uk,
	netdev@vger.kernel.org, stable@vger.kernel.org, yicong@kylinos.cn
Subject: Re: [PATCH] net: phy: motorcomm: Fix the issue in the code regarding
 the incorrect use of time units
Message-ID: <2610bc26-44e6-48a3-87c6-acfa30f60dad@lunn.ch>
References: <e1311746-9882-4063-84af-3939466096e9@lunn.ch>
 <20251028062110.296530-1-cong.yi@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028062110.296530-1-cong.yi@linux.dev>

> > >  #define YT8521_CCR_RXC_DLY_EN			BIT(8)
> > > -#define YT8521_CCR_RXC_DLY_1_900_NS		1900
> > > +#define YT8521_CCR_RXC_DLY_1_900_PS		1900
> >
> > This could be down to interpretation.
> >
> > #define YT8521_CCR_RXC_DLY_1.900_NS		1900
> >
> > would be technically correct, but not valid for cpp(1). So the . is
> > replaced with a _ .
> >
> > #define YT8521_CCR_RXC_DLY_1900_PS		1900
> >
> > would also be correct, but that is not what you have in your patch,
> > you leave the _ in place.
> 
> Alright, I didn't realize that 1_950 represents 1.950;
> I thought the underscores were used for code neatness,
> making numbers like 900 and 1050 the same length, for example:
> #define YT8521_RC1R_RGMII_0_900_PS
> #define YT8521_RC1R_RGMII_1_050_PS
> 
> In that case, is my patch still necessary?

I think it is unnecessary.

If you want, you could add a comment which explains that the _ should
be read as a .  However, this does appear elsewhere in Linux, it is
one of those things you learn with time.

    Andrew

---
pw-bot: cr

