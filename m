Return-Path: <stable+bounces-178038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A241CB47B33
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 14:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98B6F189A64A
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 12:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2020025D540;
	Sun,  7 Sep 2025 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ls4oxy4n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AE721C9EA
	for <stable@vger.kernel.org>; Sun,  7 Sep 2025 12:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757247059; cv=none; b=UILHpCBUqfID1JxdBRpLih1rSatsMfiG2e66SGxeC94R//t1miOcl9kft4xaRsTik5qiEb0oLN+R5N5sHyCwNf2PvlLyTfcvr0Vum+xAKHirDNFOXYflYRD/Rvc6NOVl+Gxznv9UsKgepFP5uglV/RMRyEZrqaA220xmbnLsCFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757247059; c=relaxed/simple;
	bh=WG7AhbdZMm8SOpmKKP4nk6rqmCaJcdWj6HTZT3QG2es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzVHNuejhBuDOZvemqY2rpHgPssu5c+CFcJZWnOAnlL4OMGTHLKkE2B6szpvP8Hw2NJ6YCPjvJnpD2bXUSb2OuDBSWkT/dxTYbY7v3YIbUO7T3LiYfxYxOsgnBtJ/G6FbL1B5cdrHJ4g9esG12dLubDTKyIcn+NYeOF6gNn42vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ls4oxy4n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67B8C4CEF0;
	Sun,  7 Sep 2025 12:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757247059;
	bh=WG7AhbdZMm8SOpmKKP4nk6rqmCaJcdWj6HTZT3QG2es=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ls4oxy4nTp/rKWYMEYWQXxJiZHgSmcPRJ/sqnpFRL2ou+k7opgUCJjDALsK3lg2Ox
	 5LqYaBuvf9vysd5dRtRfbNrxNCCI2qtYllnowPZ+sDO5KMLlxXYGfM9cY3Yzxh5y8h
	 U4SWxV9/PcOROP8CdQeGE6utm3tSTnLhn0uN8zB8=
Date: Sun, 7 Sep 2025 14:09:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: Apply 8851e27d2cb9 for 6.12.y and later
Message-ID: <2025090738-rearview-retry-9626@gregkh>
References: <CANiq72mp-t40F0scCVT1ew_xRdaG=8x-0xx1qQabUrEjS1mQvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72mp-t40F0scCVT1ew_xRdaG=8x-0xx1qQabUrEjS1mQvw@mail.gmail.com>

On Sun, Sep 07, 2025 at 01:08:03PM +0200, Miguel Ojeda wrote:
> Hi Greg, Sasha,
> 
> Please consider applying the following commit for 6.12.y and later:
> 
>     8851e27d2cb9 ("rust: support Rust >= 1.91.0 target spec")
> 
> It should apply cleanly.
> 
> It is not urgent, but will be needed in some weeks to support the
> upcoming Rust compiler versions.

Now queued up, thanks.

greg k-h

