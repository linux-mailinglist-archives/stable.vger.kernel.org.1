Return-Path: <stable+bounces-113951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 713DCA297C0
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 18:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28A8C3A4FE2
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 17:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448841FCD07;
	Wed,  5 Feb 2025 17:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsLyFODU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF381FC0EE;
	Wed,  5 Feb 2025 17:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738777110; cv=none; b=IHQxqtlxG0DEUx02c5iz1DiuKknSDlyskRTxmOecBloK8f0ySxccEbPZTCTx8h5+TfDYCLRm4Vewig0Ol5cLNE5bB4d297aK8boT0y2Z/T5DDEBi/6zBXLBM+Uf+fetT1u3Q+H0ySx48Z44JNaMc4ynoEgOKAtRvRXeqG6Umias=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738777110; c=relaxed/simple;
	bh=6QJJPtO3WlYPPGSP0H8aWwAJg0ctvHWUXT0e2WNEeHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIiiJNwxpbEbFANDnYGl/pBzMjVvVeKENRVcJhLIj4Asrwvu9taCzwdnVjs0a1SNxHymOWyAjo0z5+7baHFkCsa1oQ7WWi9aXw1BuOHJ/YhY3UVOV3HZgyeNTHBO4OPmCUQRZHJJM/XPgs6AGj/lylamEZaT3b+49eyl5b9ffT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsLyFODU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9547EC4CEE2;
	Wed,  5 Feb 2025 17:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738777109;
	bh=6QJJPtO3WlYPPGSP0H8aWwAJg0ctvHWUXT0e2WNEeHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MsLyFODUcEFb8uO9sgi4xZpO9PYRDdZOES/lZgiqBuN8wK0rpYCZyyFUZPsRV/815
	 eVszkZ84dPOVH3oi7rt+AbIWKXy03058S4pFxx7l5DQ6Z1/aI1g+IVpQn6g+cxDIl9
	 QOWiN0BSBHDQPpDQV2dp7S8V+JJQ0tqEreVR/ejFgVrEBi2Hq+i8UV5e3i8elKKxMy
	 3Qgndet8XKwPQTJJutsYvw441+bty+yDxo5KIBzoW3wbIaIspA/f+NL7dZuOf89MPr
	 a6l+h/rNIdMjTWZXDTh2TVMGC4DGBrLzpraW+eHCTJqhl6aVLcGhtxSEM1mV8dmDyy
	 1VNweqr9a9gzA==
Date: Wed, 5 Feb 2025 17:38:24 +0000
From: Simon Horman <horms@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Heiko Stuebner <heiko@sntech.de>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Steven Price <steven.price@arm.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: [PATCH netdev] net: stmmac: dwmac-rk: Provide FIFO sizes for
 DWMAC 1000
Message-ID: <20250205173824.GJ554665@kernel.org>
References: <20250204161359.3335241-1-wens@kernel.org>
 <20250204134331.270d5c4e@kernel.org>
 <CAGb2v641vvtVKv8QbiEfHnMWngcKYTJZAgfH5k+G_nOvZcbC9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGb2v641vvtVKv8QbiEfHnMWngcKYTJZAgfH5k+G_nOvZcbC9g@mail.gmail.com>

On Wed, Feb 05, 2025 at 11:45:17AM +0800, Chen-Yu Tsai wrote:
> On Wed, Feb 5, 2025 at 5:43 AM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Wed,  5 Feb 2025 00:13:59 +0800 Chen-Yu Tsai wrote:
> > > Since a fix for stmmac in general has already been sent [1] and a revert
> > > was also proposed [2], I'll refrain from sending mine.
> >
> > No, no, please do. You need to _submit_ the revert like a normal patch.
> > With all the usual details in the commit message.
> 
> Mine isn't a revert, but simply downgrading the error to a warning.
> So... yet another workaround approach.

I think the point is that someone needs to formally
submit the revert. And I assume it should target the net tree.

