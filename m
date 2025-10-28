Return-Path: <stable+bounces-191460-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 761B9C1493F
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 13:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B09294ED9DA
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 12:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8FA32B9A5;
	Tue, 28 Oct 2025 12:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PVJ+5bHE"
X-Original-To: stable@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E12526ED57;
	Tue, 28 Oct 2025 12:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761653993; cv=none; b=l6mIUCPb7v9RZBaroTC0c9vwJDCiEAKk5MGILNAgkUkZwAeWRMDpH482OMZmM/WiN772ZV4A2/h22PfjtqTN0OWk8LqKi7YMw4mgw4waxJvlW4wAex728ZxBAZnNd5f4QJBce4Kkq2KO0qyg8QG8VswvRNXO+F/Y1/VV+N/5gzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761653993; c=relaxed/simple;
	bh=QKHpKLl44uwhzX0yR8l8NyNpX/dvwMMWUn48o9hqBmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLHErzDLny7SuV2I8leX8GBfGBgn60m5aEabS4iI6NbydNBdexLzMsl5+GElvJX7UgDxQAO2JhfVy2UH8TsTHZrSd0pJJeK76sEOsbzxxl7qYJNNkyzMKnX/Eosl2im1eBKWVRrfV98rx1KphDMpDEbZVOxQDwXhN91OZ2j4GD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=PVJ+5bHE; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iAcTB0pexrytfdjO3k8iLmGtnWGjntECalzhziLvSqc=; b=PVJ+5bHEgyfW3CMkystoei5+mQ
	aG7fyM/0Bef3t4MGKcVPHcyMU9R0hmQ58ruj8uppd3By7GyACdoA0y/NzOXEismdi7gEKUTIsQFGs
	T3eDkDsgJ18b/TcNKo3FpY8ZEeqDlhDh+I7Dqvpbr6AIIIyeNZzdRHB9xNBhsr3KyJWlpaBdYbCVC
	k5Ou/P16w2Th+q0W3RYBiwW2ayffU3vMl/YMjHbLHdYy1CoGGbEESd1LYMVNTkfA8K0OqYsKX+PbD
	XewYf726Q0v0vrb9gNTuaWPWQq+glvrHn38MX2N+YbSt9TEMQThrAk+RriY2kJIzY4fD3YnigZYzV
	jUBY4qmw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40962)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vDifr-0000000039t-1vkF;
	Tue, 28 Oct 2025 12:19:39 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vDifl-000000006YC-09gl;
	Tue, 28 Oct 2025 12:19:33 +0000
Date: Tue, 28 Oct 2025 12:19:32 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Yi Cong <cong.yi@linux.dev>, Frank.Sae@motor-comm.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, hkallweit1@gmail.com,
	kuba@kernel.org, netdev@vger.kernel.org, stable@vger.kernel.org,
	yicong@kylinos.cn
Subject: Re: [PATCH] net: phy: motorcomm: Fix the issue in the code regarding
 the incorrect use of time units
Message-ID: <aQC01GDPr-WclcZS@shell.armlinux.org.uk>
References: <e1311746-9882-4063-84af-3939466096e9@lunn.ch>
 <20251028062110.296530-1-cong.yi@linux.dev>
 <2610bc26-44e6-48a3-87c6-acfa30f60dad@lunn.ch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2610bc26-44e6-48a3-87c6-acfa30f60dad@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Oct 28, 2025 at 01:07:34PM +0100, Andrew Lunn wrote:
> > > >  #define YT8521_CCR_RXC_DLY_EN			BIT(8)
> > > > -#define YT8521_CCR_RXC_DLY_1_900_NS		1900
> > > > +#define YT8521_CCR_RXC_DLY_1_900_PS		1900
> > >
> > > This could be down to interpretation.
> > >
> > > #define YT8521_CCR_RXC_DLY_1.900_NS		1900
> > >
> > > would be technically correct, but not valid for cpp(1). So the . is
> > > replaced with a _ .
> > >
> > > #define YT8521_CCR_RXC_DLY_1900_PS		1900
> > >
> > > would also be correct, but that is not what you have in your patch,
> > > you leave the _ in place.
> > 
> > Alright, I didn't realize that 1_950 represents 1.950;
> > I thought the underscores were used for code neatness,
> > making numbers like 900 and 1050 the same length, for example:
> > #define YT8521_RC1R_RGMII_0_900_PS
> > #define YT8521_RC1R_RGMII_1_050_PS
> > 
> > In that case, is my patch still necessary?
> 
> I think it is unnecessary.
> 
> If you want, you could add a comment which explains that the _ should
> be read as a .  However, this does appear elsewhere in Linux, it is
> one of those things you learn with time.

Hang on.

Is the "1900" 1.9ns or 1.9ps ?

If YT8521_CCR_RXC_DLY_1_900_NS means 1.9ns, and the value is in ps,
then surely if it's being renamed to _PS, then it _must_ become
YT8521_CCR_RXC_DLY_1900_NS, because 1.900ps is wrong?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

