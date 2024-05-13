Return-Path: <stable+bounces-43617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F378C4111
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 14:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D767281896
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 12:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0976B14F9CB;
	Mon, 13 May 2024 12:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wufik23w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9AD14C5A3;
	Mon, 13 May 2024 12:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715604873; cv=none; b=YSm/+0Uiyvprh8W0HTrxFm76dhsxKhCa4/5C2Thmj6Jyexwmnb+l0BqikgZrEpL5D7Nk3N5tKGnKsSP0X7GqQAVmopKk7UHLSKzOIb5C0MIjQbPqoDrvqvUyM1LTqDcNNzgUQABn/qyAndaBAa0OxP1NHCHsnPZ9d63EKNiz/hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715604873; c=relaxed/simple;
	bh=KMpHYhXrCAwNxS4eKBq53GsKdPe0uG5hEBHoW0IrnOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdWXRR5AEOTiNNufeuUVuBlRkcpVGbe4ifXbgNoNAZGD63Tw3nXTq3X8WT9wWrfkYIkjmEdS0zSoxb17VWW89g0vFjtauyw/Xu+d0ISgMg3v4OREQ/h5AcDBKZQeNIf9iFtyzZWQ1qrF/7H+Vh5KSW+PD7PxSV5izp9hVX2AVqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wufik23w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86DBCC113CC;
	Mon, 13 May 2024 12:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715604873;
	bh=KMpHYhXrCAwNxS4eKBq53GsKdPe0uG5hEBHoW0IrnOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wufik23wA59SyeC3i7dUQdyf+Ak6hyvMnuBHXK1cDpKCpPTB+DeFkvKgTDfuYfryS
	 DZ/LIm96KAsz5eYn3+gkjTiEOPa7+0P6UgkDzY6olZNatWKXcT5MSk6uSLaI+UDwY9
	 h+Aq4KLJSzSe+HSdjATGnNSEZmJETRmT71OM5XAY=
Date: Mon, 13 May 2024 14:54:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: David Lechner <dlechner@baylibre.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Mark Brown <broonie@kernel.org>
Subject: Re: Patch "spi: axi-spi-engine: fix version format string" has been
 added to the 6.1-stable tree
Message-ID: <2024051357-jimmy-smasher-0359@gregkh>
References: <20240506193025.272042-1-sashal@kernel.org>
 <ff1189d7-afb3-4567-a8ce-627cf57f3690@baylibre.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff1189d7-afb3-4567-a8ce-627cf57f3690@baylibre.com>

On Mon, May 06, 2024 at 03:47:02PM -0500, David Lechner wrote:
> On 5/6/24 2:30 PM, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     spi: axi-spi-engine: fix version format string
> > 
> > to the 6.1-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      spi-axi-spi-engine-fix-version-format-string.patch
> > and it can be found in the queue-6.1 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> > 
> > 
> 
> Does not meet the criteria for stable.
> 
> (only fixes theoretical problem, not actual documented problem)

It fixes a real problem, incorrect data to userspace, why wouldn't you
want it applied?

greg k-h

