Return-Path: <stable+bounces-132320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C01DA86DFC
	for <lists+stable@lfdr.de>; Sat, 12 Apr 2025 17:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 829D4442853
	for <lists+stable@lfdr.de>; Sat, 12 Apr 2025 15:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1F01F874E;
	Sat, 12 Apr 2025 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QRFNPxH3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488131DF73A
	for <stable@vger.kernel.org>; Sat, 12 Apr 2025 15:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744472683; cv=none; b=pE6oy4VXTYy+GT/UZZKRRfDbz4UFnsK2vEohZ27vAVx1k0nfB1+f6E4AF1jg7rWbV8ce5OgySbm3PFXv0NAHzSpzKOdKH87LgSR4hPEDdKlpA9gLRjnngAq0K4YGtGdf7bjWDfqEhgkGJB8vexpvB4ITMDgFRCHYued5vahJITo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744472683; c=relaxed/simple;
	bh=KK10ORL61LOKXGJ2UbbrjAKvgpUVfCFCA0lY82MzUB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqyJveByeG25L0qM4RYjgZMNS8wTbWaTpITxAyO5o3flQbmwJJPqKWVjdnJ4MyqAn6fFLiRdx1i4bvPQQfFmpqZSWD3kbHioVuOoNLISaCnC4lD/nh1xMEhMq8HVjKRHy0WDOxwX/qPnvGHUJeqiMv+6y60Xl8VqH4JkPrP1dzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QRFNPxH3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38EC4C4CEE3;
	Sat, 12 Apr 2025 15:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744472682;
	bh=KK10ORL61LOKXGJ2UbbrjAKvgpUVfCFCA0lY82MzUB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QRFNPxH3o61fpeActJLm3QqJdaW8VxRHl/L7PrCLLnaKYmw+rSGA4WpcC9PK9FfrA
	 WsBcWUXB7a+JFS/z6tpYI8vypXDsJv/JHNAeOKRzl7SW1RjINVZWfxlsdTDIdYFLBm
	 2hkj0XJ676jm/3Zo0IwpO+N44qIyYL72u23rmmOU=
Date: Sat, 12 Apr 2025 17:43:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Miguel =?iso-8859-1?Q?Garc=EDa?= <miguelgarciaroman8@gmail.com>
Cc: stable@vger.kernel.org, skhan@linuxfoundation.org,
	Christoph Hellwig <hch@lst.de>,
	syzbot+2aca91e1d3ae43aef10c@syzkaller.appspotmail.com,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 6.1.y] block: make bio_check_eod work for zero sized
 devices
Message-ID: <2025041215-grudge-rearrange-7123@gregkh>
References: <20250412102424.56383-1-miguelgarciaroman8@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250412102424.56383-1-miguelgarciaroman8@gmail.com>

On Sat, Apr 12, 2025 at 12:24:24PM +0200, Miguel García wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> commit 3eb96946f0be6bf447cbdf219aba22bc42672f92 upstream.
> 
> This patch is a backport.

Why?  What requires this change?  I don't see the justification for
this, especially:

> Fixes: 9fe95babc742 ("zram: remove valid_io_request")

That commit is in 6.4, NOT 6.1.y, so why does 6.1.y need this?

thanks,

greg k-h

