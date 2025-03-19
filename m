Return-Path: <stable+bounces-124924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1AAA68E95
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A91F7AD155
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D32417A2FA;
	Wed, 19 Mar 2025 14:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="swqQrZcs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DB1134BD;
	Wed, 19 Mar 2025 14:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742393494; cv=none; b=DatnLGoD7MW9kQKJXr1m6+0jXrFjmP/cdBNqSbetV3NmSUXL4M8+MJgnIsh7hFPuLAovlNmwrp7lAhkjB65IMg7d6+1IEDCaaidIUQ0jOsHPEgjjNI7aof8Kn1Z81A1VodWgCcXSO8RSWCSDwdchTqHHoxyg/WyEiNd5I0gaUF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742393494; c=relaxed/simple;
	bh=uDpWQNnyNWRntl18DJzcgXesN73xAgAP80C3z13HN/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p93cZnRK4tWTRcCj93iSlulKTFkEkY7IFUoVQRc/EMhnPdHyIM4XdcFQWb9Zv0Y1LTly2GZ7p7RwJeTi3OfuM3n0wc3CFPIwKbLziUksJoZXO1Tt8qTxwWPJUy0Y3EVKLbhPIMTajox/+I3hCXyZv16QOCqfcEAJHjsSE3sYrV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=swqQrZcs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7FEC4CEE4;
	Wed, 19 Mar 2025 14:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742393493;
	bh=uDpWQNnyNWRntl18DJzcgXesN73xAgAP80C3z13HN/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=swqQrZcsn24BgJAljEX96q9iaD2Djcieux4gV1PAhs+McM3mDbObyXYvdjB9XuJva
	 qrI8wBFDCG5KgajIaoT3RjDMVyATo/XpqBNzGzJLNpvWXC8BfdniysMRSWzE714v45
	 3AZTG9LOCyewCpSX2xE5wE52f3+oQX84WfahqwPI=
Date: Wed, 19 Mar 2025 07:10:14 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Frank Scheiner <frank.scheiner@web.de>
Cc: tzimmermann@suse.de, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: 6.6.84-rc1 build regression on ia64 (and possibly other
 architectures)
Message-ID: <2025031907-occupy-earthworm-9397@gregkh>
References: <68e093fb-556d-4267-9430-ff9fddc1c3d1@web.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68e093fb-556d-4267-9430-ff9fddc1c3d1@web.de>

On Tue, Mar 18, 2025 at 01:47:44PM +0100, Frank Scheiner wrote:
> Dear Greg,
> 
> I see that the review for 6.6.84-rc1 hasn't started yet, but as it was
> already available on [1], our CI has already tried to built it for ia64
> in the morning. Unfortunately that failed - I assume due to the
> following **missing** upstream commit:
> 
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8887086ef2e0047ec321103a15e7d766be3a3874
> 
> [1]: https://web.git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?h=linux-6.6.y

Thanks, now fixed up.

greg k-h

