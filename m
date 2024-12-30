Return-Path: <stable+bounces-106289-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E97889FE726
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 15:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA89816038D
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 14:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBF31AAA37;
	Mon, 30 Dec 2024 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sK0rHTzd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEAB42AA6
	for <stable@vger.kernel.org>; Mon, 30 Dec 2024 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735569103; cv=none; b=l57ULnAkgrBPi+hqHKkXK+ek7TByUXA/YcOoH8cxzTVLc0+mZiP5AxhaDKEck9fNrEk4Dpg73ER7X3bHcvoS3ujY7tiV+doVpbtl6F5zABSvDFQhGVXBqEnQ+TUfmTUeNkQzxHbU4iEZWmXJupPeIHCEh0JmEoJXPq65plWp2Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735569103; c=relaxed/simple;
	bh=jJjUizaZXfSw1ZsogQ8lBMueMqhxwYO9sRiE+y3umwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=an3QgOA1uPDdXLmRTaoPqu5BrfUeABytEA7zY/YRuEXo8yYc9NvmUFM+SwTXuqHKGegFsDKZfytynveo2S4eK3Iy+i8/GJTzyHdiZ1PRdBvoSjh6l7L/hbflBeqI9cZg8HONKl1Wd6Cn21QhwNNjNyJS97NfqXl858ZBArkvVPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sK0rHTzd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C959BC4CED2;
	Mon, 30 Dec 2024 14:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735569103;
	bh=jJjUizaZXfSw1ZsogQ8lBMueMqhxwYO9sRiE+y3umwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sK0rHTzd5cuK2WUW1RPl7V3c1LBA1Szohu6cQIZcFPoPzMmyHav3yQprJg3Rv1m8U
	 WKmL2OoJ2j0rP0o+9uT6pmpmdsj/syfLQ3KH+Ew6398r5zKtzlcuUXBDBTQ+2i7VIf
	 R1WrrnKCzOjXGsQTJ12Of8BBX+c+VqwXQUkmgm/E=
Date: Mon, 30 Dec 2024 15:31:40 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: heiko@sntech.de, stable@vger.kernel.org
Subject: Re: Patch "phy: rockchip: naneng-combphy: fix phy reset" has been
 added to the 6.12-stable tree
Message-ID: <2024123026-founder-sporty-a9c7@gregkh>
References: <20241228092502.544093-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241228092502.544093-1-amadeus@jmu.edu.cn>

On Sat, Dec 28, 2024 at 05:25:02PM +0800, Chukun Pan wrote:
> Hi,
> > This is a note to let you know that I've just added the patch titled
> >
> >    phy: rockchip: naneng-combphy: fix phy reset
> >
> > to the 6.12-stable tree which can be found at:
> >    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> >
> > The filename of the patch is:
> >     phy-rockchip-naneng-combphy-fix-phy-reset.patch
> > and it can be found in the queue-6.12 subdirectory.
> >
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> Please backport this commit together:
> arm64: dts: rockchip: add reset-names for combphy on rk3568
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=8b9c12757f919157752646faf3821abf2b7d2a64

That is not in Linus's tree yet :(

thanks,

greg k-h

