Return-Path: <stable+bounces-89204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE149B4B18
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 14:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F6431C2209B
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 13:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60458206063;
	Tue, 29 Oct 2024 13:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ci9/aR4C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B80B205143;
	Tue, 29 Oct 2024 13:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730209379; cv=none; b=me2QOcNSynr2v3sW87jh94idZ310Z3cOID2J3DerFpDmMWvhRPF6hlMEcoOGJBkH/2umbhwu6a4qGrMXe+6GrZ6ECE2wGVz0Jb/4dd9JF5Uk6d/rYkuqm0Bv+leUc+KWux5LeZAA7vn3DqYQ6v5IqOBV3DkFP1nrnemC1NPt9g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730209379; c=relaxed/simple;
	bh=GGo7JHb+1UoYyHCQmJ7gS6Ek7kWmrbPkx4ADQlZSt5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IP6Fey6c3rV6IJW1Wcgt7NZmwidQbNH+MmlwUJbL1QUJbHfpMklcXX0+aaQNr+TMDbQBxewb7xPnXqruppgsBU128F7KGZLr1eRwjBemznEO9hBlvkKkcFG1eQ//RSzuL2wwIy5OZmEjSMxWNeZS5FnFSGQM7wxAZnXkCFZ/eWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ci9/aR4C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A44C4CECD;
	Tue, 29 Oct 2024 13:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730209378;
	bh=GGo7JHb+1UoYyHCQmJ7gS6Ek7kWmrbPkx4ADQlZSt5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ci9/aR4CiLwWNI2+uWJd05AQEdtpYjazJW0jiEE1dyReiXTgVauL/nDNB+HbZxEs1
	 wiUntxD9vF87WRUKvJBXcS0mxGdDIfkW5AkHgHDmbxm9B58y2jo4Bj5xFlzR6L5qrH
	 F7m0HI8NYvXMZFe+o25MVf1Nq8obwV+sLUMqnLaRvFljLviXKGoe3Ceiag7JNL+m/Y
	 NM3/iCi5cqGHbgPyeKcetqTVgOQWgmdxiIuUEO/7aNQkfCvhzBSsb2KgMEIn2+k7uR
	 O6QSwnkkW7NFJGA4CULlsNUWgTnTxvguZ8NuAqNguH12HbN4BzSr0TdQINKPE0BJkK
	 eb6zno7z4lrKQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t5mVC-000000002y1-1gGK;
	Tue, 29 Oct 2024 14:43:18 +0100
Date: Tue, 29 Oct 2024 14:43:18 +0100
From: Johan Hovold <johan@kernel.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Felipe Balbi <balbi@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Lee Jones <lee@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	stable@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v2 2/6] phy: core: Fix that API
 devm_of_phy_provider_unregister() fails to unregister the phy provider
Message-ID: <ZyDmdsHtxo-gFIFH@hovoldconsulting.com>
References: <20241024-phy_core_fix-v2-0-fc0c63dbfcf3@quicinc.com>
 <20241024-phy_core_fix-v2-2-fc0c63dbfcf3@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024-phy_core_fix-v2-2-fc0c63dbfcf3@quicinc.com>

On Thu, Oct 24, 2024 at 10:39:27PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> For devm_of_phy_provider_unregister(), its comment says it needs to invoke
> of_phy_provider_unregister() to unregister the phy provider, but it does
> not invoke the function actually since devres_destroy() will not call
> devm_phy_provider_release() at all which will call the function, and the
> missing of_phy_provider_unregister() call will case:

Please split this up in two sentences as well.

> - The phy provider fails to be unregistered.
> - Leak both memory and the OF node refcount.

Perhaps a comment about there not being any in-tree users of this API is
in place here?

And you could consider dropping the function altogether as well.

> Fixed by using devres_release() instead of devres_destroy() within the API.
> 
> Fixes: ff764963479a ("drivers: phy: add generic PHY framework")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

Looks good otherwise.

Johan

