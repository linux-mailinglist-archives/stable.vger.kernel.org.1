Return-Path: <stable+bounces-121265-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40509A54F62
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 16:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D16AF3A5A16
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 15:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D77320E6F6;
	Thu,  6 Mar 2025 15:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uZd+fYIo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A591148FF5;
	Thu,  6 Mar 2025 15:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741275737; cv=none; b=VLGiuow+Q7nOWPavFct3QnhSjUHPwuiqZ7R8kaP4pMi9p5RH0T2wuN/yUblU0eLbcfld/YfVzOAnlXaA4oPWoeoUlUOPiD74LBgGhwMisIddnOVO82aKS+0xGCx2IayaVgMjVnBzuKzFJ7YN1NdCm+jxby9hKfMw02vBKdChO3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741275737; c=relaxed/simple;
	bh=UUBhF9NhePQ1mVan/otMRee77cWY/IkkhCCKPaz9a6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iI+osrOT86KsIIrrCIlRGp/hHvvMfT21RZKoxkRzAeWUirFxWPj8614xHoNiDdQSInxR0AFMk5xUOS1hh4jpfmlVtTCO+ljfv1A98yznSJht1sBqjwJ1DbD1TNWLyIZQsgue3MUbofi6gkX0rRDynddshiMggW53LiLtGINS39A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uZd+fYIo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CCF9C4CEE0;
	Thu,  6 Mar 2025 15:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741275736;
	bh=UUBhF9NhePQ1mVan/otMRee77cWY/IkkhCCKPaz9a6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uZd+fYIofyzzEfe4sEkk3nTv0MWNzWuQxkEVVw7iOMsV7aJcR1VcDOIJ4Y5YXNg3L
	 FOf6WQ5J2T3TG41C3VZUA4/c2VcR1+2Nvryz3j7fqjdDuuCbofbPVZWCwa/BNaK2te
	 1HLchGAcCyZXprZUN6/IFBdYz9P3XzEES57NVJYw=
Date: Thu, 6 Mar 2025 16:42:13 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: linux-usb@vger.kernel.org, Michal Pecio <michal.pecio@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 03/15] usb: xhci: Don't skip on Stopped - Length Invalid
Message-ID: <2025030650-defiling-grit-869e@gregkh>
References: <20250306144954.3507700-1-mathias.nyman@linux.intel.com>
 <20250306144954.3507700-4-mathias.nyman@linux.intel.com>
 <2025030611-twister-synapse-8a99@gregkh>
 <22876af7-4f9a-40ce-aa9d-2bcab89ce8ae@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22876af7-4f9a-40ce-aa9d-2bcab89ce8ae@linux.intel.com>

On Thu, Mar 06, 2025 at 05:29:30PM +0200, Mathias Nyman wrote:
> On 6.3.2025 16.52, Greg KH wrote:
> > On Thu, Mar 06, 2025 at 04:49:42PM +0200, Mathias Nyman wrote:
> > Why is a patch cc: stable burried here in a series for linux-next?  It
> > will be many many weeks before it gets out to anyone else, is that
> > intentional?
> > 
> > Same for the other commit in this series tagged that way.
> 
> These are both kind of half theoretical issues that have been
> around for years without more complaints. No need to rush them to
> stable. Balance between regression risk vs adding them to stable.
> 
> This patch for example states:
> 
> "I had no luck producing this sequence of completion events so there
>  is no compelling demonstration of any resulting disaster. It may be
>  a very rare, obscure condition. The sole motivation for this patch
>  is that if such unlikely event does occur, I'd rather risk reporting
>  a cancelled partially done isoc frame as empty than gamble with UA"

Ok, fair enough, just seeing patches languish in -next that are tagged
for stable looks odd.

thanks,

greg k-h

