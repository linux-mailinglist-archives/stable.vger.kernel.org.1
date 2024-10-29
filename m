Return-Path: <stable+bounces-89207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCEB9B4B32
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 14:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B0F21F229E1
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 13:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5096520606C;
	Tue, 29 Oct 2024 13:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+1qhOct"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1EC205E3F;
	Tue, 29 Oct 2024 13:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730209684; cv=none; b=sZHAaf7uMY45TCeQxNXbKJge2yKbYTVlMeJpgr1eC3IoLCYLIZO8CeOFr7lXyBlL5VUg4DZF2k1a8p08COUFnOpKxq8UDSVcYSdUxDA3HmulyHPD4LmFzuU/oNhHothbfwqMV4/g8n0jgJweiXIlOlXYkrOfDgCEK9OZvcIvPC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730209684; c=relaxed/simple;
	bh=/1IAglxa+62OGTxwPnjJEUICAB7kkHqquFY8NIy20NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sehKRM3icOs4Y/19loeTUhRyMSf+0zlchZhMfXhVJTyfDZyGs2QxALlM5XTXtyuLxnn65mwHFonguulJVnJxPpKsdmDFaEq8DoF3KJAXxT22WrdouO2hSVxUFlAX2Maw5aAWFKLVGY7OJMi5I42AuI/X3rHBp3i90MjrdJw2LXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+1qhOct; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4DCC4CECD;
	Tue, 29 Oct 2024 13:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730209683;
	bh=/1IAglxa+62OGTxwPnjJEUICAB7kkHqquFY8NIy20NE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b+1qhOctluYSPhYTvPktKtBzQzbC6kci6oX+GexD6cBLzFYIT14D20Pqe1nOmGPOe
	 /BSu78+33G3aZWOz72nror1XVSvskacqM2zmyW+T5dLH6ceCYmrx+P+IMUl9fh8B43
	 NGAKEjmgDKdlZMnJe+awWj+2K5JwDHj20IdaCVsCqvzRWMfzgsbYzmepi/7Kd0LE4e
	 yEGnLmhoaHbq5hh7USRsUt3VeESiWqFzvUTykTNiZgA+QdS3mFiY9EPHU/sd0+6rK9
	 v1zt6ILOiBXPjyAFT4TTo1IXpZREPrqblAip8J1huSzDBi1r2vj70JyGWwcSxpYzPG
	 yVJz4Ni/CP8vw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t5ma7-0000000035Z-02Ot;
	Tue, 29 Oct 2024 14:48:23 +0100
Date: Tue, 29 Oct 2024 14:48:23 +0100
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
Subject: Re: [PATCH v2 5/6] phy: core: Fix an OF node refcount leakage in
 of_phy_provider_lookup()
Message-ID: <ZyDnp5hAii6rAu7a@hovoldconsulting.com>
References: <20241024-phy_core_fix-v2-0-fc0c63dbfcf3@quicinc.com>
 <20241024-phy_core_fix-v2-5-fc0c63dbfcf3@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024-phy_core_fix-v2-5-fc0c63dbfcf3@quicinc.com>

On Thu, Oct 24, 2024 at 10:39:30PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> For macro for_each_child_of_node(parent, child), refcount of @child has
> been increased before entering its loop body, so normally needs to call
> of_node_put(@child) before returning from the loop body to avoid refcount
> leakage.
> 
> of_phy_provider_lookup() has such usage but does not call of_node_put()
> before returning, so cause leakage of the OF node refcount.
> 
> Fixed by simply calling of_node_put() before returning from the loop body.
> 
> The APIs affected by this issue are shown below since they indirectly
> invoke problematic of_phy_provider_lookup().
> phy_get()
> of_phy_get()
> devm_phy_get()
> devm_of_phy_get()
> devm_of_phy_get_by_index()
> 
> Fixes: 2a4c37016ca9 ("phy: core: Fix of_phy_provider_lookup to return PHY provider for sub node")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

Looks good.

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

