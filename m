Return-Path: <stable+bounces-89902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6649BD32F
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 18:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C452F283E13
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 17:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306C31DD0D5;
	Tue,  5 Nov 2024 17:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ghlbq7B9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF878166F1A;
	Tue,  5 Nov 2024 17:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730827054; cv=none; b=sRO5IMltWpNf+GKC7o82M2mF2JxykwD2a5q3L+kubQIFxSJWXmsPh/gXlc31CMTWVRcbRj3/voMy/kCiie5SJs5H9bsL3oBdDJOx1SzRiv/WPnaiUuEL7YqSq3sSFnRCTVDqUsDcNs/DgRdcq4Un9Q/mLIpz05quMYCvQcJmUTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730827054; c=relaxed/simple;
	bh=Xmw0hDI7VZHL4OmECHg/7HK3WckZ0xRvAV6zKnKQaW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWsD74Z+16T2atJlLj3RWhuIiSrbPV5ICjaEwXU4IeKZ6gkoHMWWUR++3GXuvYOnw44IZd8LRPGqiYkPmIrfmSDUnBO+vMiktEUigXCRwt1L+GShvtfXgNode7K/Dsf7dPtqqgSRDQf98xn/v8e4gg8FgXQrQdYPxPsswfQ/dlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ghlbq7B9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA1AC4CECF;
	Tue,  5 Nov 2024 17:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730827053;
	bh=Xmw0hDI7VZHL4OmECHg/7HK3WckZ0xRvAV6zKnKQaW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ghlbq7B9Q6xP29BaMU2BBxJ9SluoySMXwCsQ1PFFtbilr/X2AuRNzGzFu8dL1UBcy
	 P0tvjy22ghyU8YRP67rGAdfLmD/q5wseUyV/aTn1TC7T1dSNXSo5Wz65zx9rGCGnFW
	 c7fdkPnSLcvHNnuQj8OPuxlClbZ3vh/rirgJj1mh4SEgWA/5ailNC4Gv9UqqkHbx7Y
	 2R64IYVTQ2gp034yjdg10YRENUNG7DW8qc05kdMHjQFqI2OjSYakbBEoxYfG8N+Rrs
	 3yOMQkak21O1B9xFEWoWp9R+HWNmo7PKpBq59unkz+2l4BdfzF8xZh4iHS3IBIfU3j
	 ZTzOVpl6uEivg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t8NBN-0000000008l-0rAM;
	Tue, 05 Nov 2024 18:17:33 +0100
Date: Tue, 5 Nov 2024 18:17:33 +0100
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
Subject: Re: [PATCH v4 3/6] phy: core: Fix that API devm_phy_destroy() fails
 to destroy the phy
Message-ID: <ZypTLe-3QeXatcup@hovoldconsulting.com>
References: <20241102-phy_core_fix-v4-0-4f06439f61b1@quicinc.com>
 <20241102-phy_core_fix-v4-3-4f06439f61b1@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241102-phy_core_fix-v4-3-4f06439f61b1@quicinc.com>

On Sat, Nov 02, 2024 at 11:53:45AM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> For devm_phy_destroy(), its comment says it needs to invoke phy_destroy()
> to destroy the phy, but it will not actually invoke the function since
> devres_destroy() does not call devm_phy_consume(), and the missing
> phy_destroy() call will case that the phy fails to be destroyed.

Should also have been split in two sentences, but this also works. 

typo: s/case/cause/ 

> Fortunately, the faulty API has not been used by current kernel tree.
> Fixed by using devres_release() instead of devres_destroy() within the API.
> 
> Fixes: ff764963479a ("drivers: phy: add generic PHY framework")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

