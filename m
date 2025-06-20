Return-Path: <stable+bounces-154930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8B5AE1446
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 08:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 304F84A0402
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 06:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAA02248BF;
	Fri, 20 Jun 2025 06:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="krS1Fkw4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1442040BF
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 06:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750402442; cv=none; b=P3ktkiju+GO500C4TnO1Pb9PYbrkbNJQiuTKHtS/718BPe0/L/EG2mG9E6Ggq8D7gVbXkJPJLF7ovV67hw0UndvADiR63dlGAnyVLDk0hMxR6PA2SWmHQ+lcrR5Yx5oFYTHUHdUwFOZ6twB+B9l6YLtMkReQNTcEtDLwRAyr9t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750402442; c=relaxed/simple;
	bh=8ar2PMI3rSaobENJ+1eFSNHgyn5vRhn0arFwaDwcFfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yh+Xmv4IVM+bC6xY6Zd6+fsbZrCWQfwIccc54RSlrqI4CNjLN/akX3HH9pOTnYQUQTJ1/kPl5XqYZOZx3rOcgLzw2uEyiA0BDNOSi5nrnl4NwOBWFn7tjRtfb9aicHCIOyNfypt/80AKm8vEgMWsmaIaXddXX8WZDcqQDnOBzLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=krS1Fkw4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88462C4CEE3;
	Fri, 20 Jun 2025 06:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750402442;
	bh=8ar2PMI3rSaobENJ+1eFSNHgyn5vRhn0arFwaDwcFfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=krS1Fkw4sXVLE2XHQ+aTeL49F8KIRl+Pw++UYcnx2tpXNgwiM4ywYJCh18M2WoBFv
	 U8tXkRoFKGKjwc76Q/mpdnV1R+KPsn/EEMebRvHT7WyL2zyX52f1z4D39t56k2TGmA
	 N8C5L31W8ya9Q+b6R9unWj6ryzRlasCvLCu0R+mc=
Date: Fri, 20 Jun 2025 08:53:59 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Sebastian Priebe <sebastian.priebe@konplan.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: AW: BLOCK_LEGACY_AUTOLOAD not default y in Linux 5.15.179+
Message-ID: <2025062047-matchless-jalapeno-41fc@gregkh>
References: <ZR0P278MB097497EF6CFD85E72819447E9F70A@ZR0P278MB0974.CHEP278.PROD.OUTLOOK.COM>
 <ZR0P278MB097420DCEF0AC969D89C37979F7CA@ZR0P278MB0974.CHEP278.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZR0P278MB097420DCEF0AC969D89C37979F7CA@ZR0P278MB0974.CHEP278.PROD.OUTLOOK.COM>

On Fri, Jun 20, 2025 at 06:47:58AM +0000, Sebastian Priebe wrote:
> Hello,
> 
> Could somebody please have a look to this request?

It's only been 4 days, please give us a chance to catch up on things.
There hasn't even been a new 5.15.y release since you made this request.

Also, please do not top-post.

thanks,

greg k-h

