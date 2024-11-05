Return-Path: <stable+bounces-89901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B362E9BD326
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 18:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 781E6283597
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 17:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FDE176AAF;
	Tue,  5 Nov 2024 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1ORN88v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5803B1E1A18;
	Tue,  5 Nov 2024 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730826905; cv=none; b=SxQBlo+BbGARcpakcMO8Zz9vXhL4LAA440J/i1u4TOVQkAqjg308DTRAf47LjA1z0ED3dkzlkLNfkRTvGKQtk4gFHPl+uFUsATGl07eYqtOcl9hY0m1aSRBMv8ZIm3xLnzWFj1LrMP3xgDM1P3RrWHuKP1W0qds4+6mOWHXbClg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730826905; c=relaxed/simple;
	bh=yPytFdz6f1L1SYg6SCEa40uxUwZxSLiELY6Dcv785F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arlgmiz1TG6q8sQMasvsr4996js5U3vnjds0b8LtgDoTppYEitheJEgUG2P0vsKZ1v8KTLG233B0LrUV0bmg/eXXEvwNq9zrxfrvud2J75c44zYwBbfomDrZq+5wJKDH36DGFxKcQ6cbk4ZgGb9AdOIl9GpoiET+4fTZJ0j3Pdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1ORN88v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4CFC4CECF;
	Tue,  5 Nov 2024 17:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730826904;
	bh=yPytFdz6f1L1SYg6SCEa40uxUwZxSLiELY6Dcv785F8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t1ORN88vKrpnA073v9R8XZmFatwTb3I9dLnCneq8cdHEkB8ZdUgWShCLp6cRD7Pio
	 4U9ZcDlj7zlWqOQRA2NFoylpDLXdC2hqTJDKaOVCwhfXJtzNcqGBnaKnQ9JoAiJ7TG
	 wwSq0w+zQcJX3IXxXKJKjheLaD4QPA4Tn761O2VzPSCVUrhr3phLmY79T72Sgjeu4k
	 c4gUMA0pptapaqlDGMf5+sZ2VbBCH9Vw6YXmk8K0BJPWZpuwLLtXFSHea7xjvHQIfu
	 f8fiPjGY81cJFNa1Uye+5FMG6JgFd+pkbm+WMOD4hw0dYq410+QArx4Jlp5xhBUP1X
	 DRIEB/98L5Y0A==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t8N8y-000000008W9-3TZl;
	Tue, 05 Nov 2024 18:15:04 +0100
Date: Tue, 5 Nov 2024 18:15:04 +0100
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
Subject: Re: [PATCH v4 2/6] phy: core: Fix that API
 devm_of_phy_provider_unregister() fails to unregister the phy provider
Message-ID: <ZypSmAiJhimXbC3Y@hovoldconsulting.com>
References: <20241102-phy_core_fix-v4-0-4f06439f61b1@quicinc.com>
 <20241102-phy_core_fix-v4-2-4f06439f61b1@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241102-phy_core_fix-v4-2-4f06439f61b1@quicinc.com>

On Sat, Nov 02, 2024 at 11:53:44AM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> For devm_of_phy_provider_unregister(), its comment says it needs to invoke
> of_phy_provider_unregister() to unregister the phy provider, but it will
> not actually invoke the function since devres_destroy() does not call
> devm_phy_provider_release(), and the missing of_phy_provider_unregister()
> call will case:
> 
> - The phy provider fails to be unregistered.
> - Leak both memory and the OF node refcount.
> 
> Fortunately, the faulty API has not been used by current kernel tree.
> Fixed by using devres_release() instead of devres_destroy() within the API.
> 
> Fixes: ff764963479a ("drivers: phy: add generic PHY framework")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

