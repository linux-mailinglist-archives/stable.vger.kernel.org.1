Return-Path: <stable+bounces-10522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEB882B0EA
	for <lists+stable@lfdr.de>; Thu, 11 Jan 2024 15:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A0CF2870F0
	for <lists+stable@lfdr.de>; Thu, 11 Jan 2024 14:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739BF4BA8C;
	Thu, 11 Jan 2024 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RbrjROd/"
X-Original-To: stable@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8862A33072;
	Thu, 11 Jan 2024 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1C7ACFF802;
	Thu, 11 Jan 2024 14:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704984337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vkrVHLxEwhTSNjxCZbhrusosakXdhKYEMgVhXIlbl0c=;
	b=RbrjROd/PFakx6mn3Jxbv84GBMC2jbmUIGPxirbv7E30zRpTYwhAHH9J5yozCBRRHmlES7
	jtC1yLPThNPoRo1FNdvLSZqHn6Pt2hyRdA3DQUp4eKUNdIJmPaCoLKZG2npkH6t1W55Edt
	kv3T8S57sKg8xC7Gons4wrPZtb3R0xCPs9us32C1vBDyQLGTEuq/Z0SzdkNgYPwEBil9qo
	5i9yecZ9rCWHY/3o3hwnkhAYkFGczdNkINhy3uK7inerwtjzQIqh5iQpIznTreYvjEb6mz
	4FCpkKwt7hEfzA5vuKzFf2QZ/9n7LJUX1PWWaU6tc00vvHR0iEQkiEhkaRIiZQ==
Date: Thu, 11 Jan 2024 15:45:58 +0100 (CET)
From: Romain Gantois <romain.gantois@bootlin.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: Romain Gantois <romain.gantois@bootlin.com>, 
    Alexandre Torgue <alexandre.torgue@foss.st.com>, 
    Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
    Miquel Raynal <miquel.raynal@bootlin.com>, 
    Maxime Chevallier <maxime.chevallier@bootlin.com>, 
    Sylvain Girard <sylvain.girard@se.com>, 
    Pascal EBERHARD <pascal.eberhard@se.com>, 
    Richard Tresidder <rtresidd@electromag.com.au>, 
    Linus Walleij <linus.walleij@linaro.org>, 
    Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
    Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
    linux-stm32@st-md-mailman.stormreply.com, 
    linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
    Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH v4] net: stmmac: Prevent DSA tags from breaking COE
In-Reply-To: <99289be4aa940932acbf728ba6a926c67eb5484a.camel@redhat.com>
Message-ID: <5dff8608-f1b2-1edb-00a5-9b0d56afd7f8@bootlin.com>
References: <20240109-prevent_dsa_tags-v4-1-f888771fa2f6@bootlin.com> <99289be4aa940932acbf728ba6a926c67eb5484a.camel@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-GND-Sasl: romain.gantois@bootlin.com

Hi Paolo,

On Thu, 11 Jan 2024, Paolo Abeni wrote:
> 
> Unfortunately, you dropped the target tree tag ('net') from the
> subject, and did not allow our CI to trigger properly.
> 
> Since we can't merge this patch ATM ('net' is currently frozen since we
> merge back the net-next PR), I think it's better if you resubmit with a
> proper tag. You can retain all Vladimir Rb tag.

Alright I'll do that right away, sorry for the hassle.

Best Regards,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

