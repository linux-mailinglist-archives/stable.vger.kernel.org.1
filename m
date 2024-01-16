Return-Path: <stable+bounces-11357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D6682F45C
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 19:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C994D28301B
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 18:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9591CD21;
	Tue, 16 Jan 2024 18:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goRIDPSI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ECB1CD07;
	Tue, 16 Jan 2024 18:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705430199; cv=none; b=sUUxGcl+6/0Z1ynbdduwulJ0p3PvO32qt0dWaJu+k995J91zkCgF5Kf6xp9wHZN1IcF7sngvPNIvMeFOmgkFTRBVCR5OhGklxUUBHq10l/8wFQIabvb0onfF/VrqESkfEhZ6AX4BLGkuO5ielENKRSKBj/mvHYZQj/LSDTIkyoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705430199; c=relaxed/simple;
	bh=I2G0ZiEcqMEXhbfeorisjs31sXqvnsEWf2BYWizY+SI=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=Y+oI/zdP8MilfCKEBZAXedesdszLisVf8YSxUsMQxa9WHE5Ksj/jxy6Okn++Yb4//dL3p1358dQu4QPORmCqe0hhXGO9ddOzZNlvWTuyirAXwO0R7Obi+pZHIClh0b2VDy7tCImPURXgdX5MJEcLJLJ+ITFoeorRw5c1WDrwSmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goRIDPSI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C84C433C7;
	Tue, 16 Jan 2024 18:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705430199;
	bh=I2G0ZiEcqMEXhbfeorisjs31sXqvnsEWf2BYWizY+SI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=goRIDPSIwbL/zs316N/BZQYhs5sVT//+8hgnCuelHawmR8qYlsS2SInXbrd48MgNs
	 cjrcHQtJWIj4G3ccbeHo0Kgu7FhB8ko45BPPt9Dsa11HQhaNmFEZ99hcRYFecSO75G
	 fU2tTSqcAhrI3eT1sphnEHqRmYuD6odsyo66GY5qsF97Fb1rjDkHTdIap+EvceJh45
	 dzJXD1spdNmVxuTzBONGcxpPibsWv870ceQAwOAvYp8PCT1SQRvF2jzWOLksV4mRMX
	 oZPbHyy2+xLvRBqiwAIMIKqOn+hcz4eB1xyP2MWh5Lro0nZe0ywlmmm2auU0OE/qkN
	 6crfKl5Hystug==
Date: Tue, 16 Jan 2024 10:36:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Sylvain Girard <sylvain.girard@se.com>,
 Pascal EBERHARD <pascal.eberhard@se.com>, Richard Tresidder
 <rtresidd@electromag.com.au>, Linus Walleij <linus.walleij@linaro.org>,
 Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, Vladimir
 Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net v5] net: stmmac: Prevent DSA tags from breaking COE
Message-ID: <20240116103637.794811a6@kernel.org>
In-Reply-To: <d844c643-16bd-6f9d-1d39-a4f93b3fcf87@bootlin.com>
References: <20240111-prevent_dsa_tags-v5-1-63e795a4d129@bootlin.com>
	<20240112181327.505b424e@kernel.org>
	<fca39a53-743e-f79d-d2d1-f23d8e919f82@bootlin.com>
	<20240116072300.3a6e0dbe@kernel.org>
	<d844c643-16bd-6f9d-1d39-a4f93b3fcf87@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jan 2024 17:18:30 +0100 (CET) Romain Gantois wrote:
> > which makes it sound like bit 5 will not be set for a Ethernet II frame
> > with unsupported IP payload, or not an IP frame. Does the bit mean other
> > things in different descriptor formats?  
> 
> The description of this bit in my datasheet is:
> 
> ```
> b5 FT Frame Type
> When set, this bit indicates that the Receive Frame is an Ethernet-type frame 
> (the Length/Type field is greater than or equal to 1,536). When this bit is 
> reset, it indicates that the received frame is an IEEE 802.3 frame. This bit is 
> not valid for Runt frames less than 14 bytes
> ```
> 
> There is no mention of a more subtle check to detect non-IP Ethernet II frames. 
> I ran some tests on my hardware and EDSA-tagged packets consistently come in 
> with status 0b100, so the MAC sets the frame type bit even for frames that don't 
> have an IP ethertype.

Boo, who designed this thing :(

v6 is good to go in then, thank you for investigating and testing!

