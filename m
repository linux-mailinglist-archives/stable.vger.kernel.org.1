Return-Path: <stable+bounces-106295-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5A49FE778
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 16:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56B541626A5
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 15:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E362C1AA1D2;
	Mon, 30 Dec 2024 15:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dyfaOcUR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09B7CA5A
	for <stable@vger.kernel.org>; Mon, 30 Dec 2024 15:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735571617; cv=none; b=SqsFc9DNpxwq2E5tx6CRBJhcbkRnCqujLRavei6mIQbnHJcFw4vlSOVjNSQANGbzSVnINoE0zVUiG+2+Z7IrPPekwkVJd74fhdOL53lvoaAibsHb/koir5GT5sH/R38gAyKHMfAX+7YBFYXnnGmTefrleaDehIHzzjUfFwt4ehA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735571617; c=relaxed/simple;
	bh=TKcWgmi9bvP1naOdZb75qO5DNpdAnmYocKGFzRi0u2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TK1DVTxfM4tk+rK59RUlvl/By0pDC3V9r5Dic0I+F+/R2WcRcanO6TiK+l448MIEVtuRpSr5rr1fkyF05QjE6fFxLFphESb5PkLnZ5aKdKc4Dx84qETkx+yDROH8CRo6KomMA4EwV2J1Kwu0wb33qicGzFrhSdJW6L6FihgHwR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dyfaOcUR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3582C4CED2;
	Mon, 30 Dec 2024 15:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735571617;
	bh=TKcWgmi9bvP1naOdZb75qO5DNpdAnmYocKGFzRi0u2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dyfaOcUR8zS4yyoazJF+304YdiuzngaVOgJ9RNiGkjVSTUdJADDLnCyJc1f7K4cjs
	 5nJKY5dKCl3RlgTjHTfnfrTcDnGBswo9VwTrVjRMFtjSn9SgwKM8D9hONlEuye7gV+
	 QZ/NxrkDKtQLhD7hNeDDzAdgMXFKXfPIvQz7wZkQ=
Date: Mon, 30 Dec 2024 16:13:34 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: heiko@sntech.de, stable@vger.kernel.org
Subject: Re: Patch "phy: rockchip: naneng-combphy: fix phy reset" has been
 added to the 6.12-stable tree
Message-ID: <2024123058-emphases-eligibly-39f1@gregkh>
References: <2024123026-founder-sporty-a9c7@gregkh>
 <20241230150009.173286-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241230150009.173286-1-amadeus@jmu.edu.cn>

On Mon, Dec 30, 2024 at 11:00:09PM +0800, Chukun Pan wrote:
> Hi,
> >> Please backport this commit together:
> >> arm64: dts: rockchip: add reset-names for combphy on rk3568
> >> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=8b9c12757f919157752646faf3821abf2b7d2a64
> >
> > That is not in Linus's tree yet :(
> 
> These two patches are in one series. I suggest waiting for
> the above patches to be merged before backport this one.
> Same for the 6.1 and 6.6 stable kernel.

What "two patches"?

This commit, fbcbffbac994 ("phy: rockchip: naneng-combphy: fix phy
reset"), is in 6.13-rc5.  The one you reference here, is not in any
released kernel yet, so how could they be in the same series?

confused,

greg k-h

