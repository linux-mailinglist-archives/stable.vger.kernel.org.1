Return-Path: <stable+bounces-89205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A979B4B1F
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 14:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1F931F23805
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 13:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7008120696B;
	Tue, 29 Oct 2024 13:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7tB+boD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A046206964;
	Tue, 29 Oct 2024 13:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730209497; cv=none; b=gqOZSSb214p8VGBA+/iOQqNLv11VxgIw+dlFQRb6x7pYVEweOB35xkYqYHILMYCJXuhcrdgnVHg1hnukxRtH1kCQDZAzn1dO6lVV/xuzu/p0BR9RALvKvYyp+P6PJ4J54T5eLXtlsjGIn8GlMvdZGho6SO1mw2WeZcI4jkfluxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730209497; c=relaxed/simple;
	bh=pQHEsCEbFi1AN2z1gIf0oXg2/Tu/i0UAAIzrBe5f5TY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtrTj4oqAjKHyRnedfVXe1VMOM7ipViQeOPm58codXdZksF1AkEstn38Mi5Geo/TVCyO0ncmqpEVTbh2hTBWNUahCXlDOfzj/FgnVL2bc9Ofnza5BqUmxfGti7PeANJ5iULSyyNaa0H7M79jM0bcF/J4AdSHrEs77SWSfYRJPJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7tB+boD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DABC4CEE6;
	Tue, 29 Oct 2024 13:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730209496;
	bh=pQHEsCEbFi1AN2z1gIf0oXg2/Tu/i0UAAIzrBe5f5TY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B7tB+boDnrw9L2Q977u1NOCl3LMbfGWMiT4lAcGj8LXUHSJ4ji2FBayaUzrwc9e1t
	 Tg9eef2JjVN+IuAOwIicmBh3lWYtt8iCuohllyQ6a8t1rfia5mUSZKAtedgvAJOUc2
	 mklFwQ/BeN36/aYXEYUfGe8NICAvW9mXIwVWvRPSpAwAAiw/lyn8QhGuMmqajs8NiC
	 rnYxHmHsTIGNFlfpkUjnY8akJ/Se0RcaIcOwa1mZTuAGKVv05A06WEM4We/kDFyPf6
	 qPnjJf1RGSudjJ3v/RVTHOeZzvlNorO+xseZsKn9NBe0dC0gR6yiabNq0odPbF7lYw
	 ie790g6yPPYTA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t5mX6-0000000031G-0m5y;
	Tue, 29 Oct 2024 14:45:16 +0100
Date: Tue, 29 Oct 2024 14:45:16 +0100
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
Subject: Re: [PATCH v2 3/6] phy: core: Fix that API devm_phy_destroy() fails
 to destroy the phy
Message-ID: <ZyDm7IMUBYkiHPyp@hovoldconsulting.com>
References: <20241024-phy_core_fix-v2-0-fc0c63dbfcf3@quicinc.com>
 <20241024-phy_core_fix-v2-3-fc0c63dbfcf3@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024-phy_core_fix-v2-3-fc0c63dbfcf3@quicinc.com>

On Thu, Oct 24, 2024 at 10:39:28PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> For devm_phy_destroy(), its comment says it needs to invoke phy_destroy()
> to destroy the phy, but it does not invoke the function actually since
> devres_destroy() will not call devm_phy_consume() at all which will call
> the function, and the missing phy_destroy() call will case that the phy
> fails to be destroyed.

Here too, split in at least two sentences.
 
> Fixed by using devres_release() instead of devres_destroy() within the API.

And add a comment about there not being any in-tree users of the
interface.

And consider dropping it.

> Fixes: ff764963479a ("drivers: phy: add generic PHY framework")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

Johan

