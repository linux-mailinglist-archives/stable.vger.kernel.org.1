Return-Path: <stable+bounces-109353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC11A14E5A
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 12:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22C9E3A8340
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 11:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C311FE44A;
	Fri, 17 Jan 2025 11:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LIXiHvhW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0451FCFCA;
	Fri, 17 Jan 2025 11:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737112929; cv=none; b=a9wNG9I0M+8hoWcWMj7uMEEkE6fx+S0yLp+LfGoGqAVKqptEDXKZcqh/ji+MGAZ/btIj2a3ClHVQOCOIzmOhGEM+sKJF7pbLj2uAS8J6Wi4CkGPL1lzOBuhTt2aRWFxt0jK3LhWhfJDUKdDze2+RK0GiSUZqrWwzEty1Hrb5K7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737112929; c=relaxed/simple;
	bh=ChlFzvKNc0Ha/ZcLninVyJ/F0u9LMThy0WMW4/hIloU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pa8uUKDZazGbltjJS5O2IT3P0avgJ/8sSNMzWKS/Xu+GW1xMYGFV17Z3e2FGo1O2fKQS8Za9QHbFJz2+xtpHib6Ru7nAyg57CuI+qHyERYgDwsD65EnzJbPpzPhWvXdVr0YRM2+sva+080E72qzrsgsLyzX0Vps6EYXZjhY6jaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LIXiHvhW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59359C4CEDD;
	Fri, 17 Jan 2025 11:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737112925;
	bh=ChlFzvKNc0Ha/ZcLninVyJ/F0u9LMThy0WMW4/hIloU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LIXiHvhW+Y7ToPqapdcbMOj94KUBYIlHszOdhYPUVYAm99qEF1OPXinLrOQIfo87C
	 UTs2oWbHkHp7O0PPFZfS4X6Wo3w4FP5aF/sCb9SxcVgcLI+U0+fmJoelXOz8cP2oNH
	 XUzusDiTZhWqxeqMwjpvwjHu0xC0a22RtERaBYPs=
Date: Fri, 17 Jan 2025 12:22:02 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Kyle Tso <kyletso@google.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	andre.draszik@linaro.org, rdbabiera@google.com,
	m.felsch@pengutronix.de, xu.yang_2@nxp.com,
	u.kleine-koenig@baylibre.com, emanuele.ghidoli@toradex.com,
	badhri@google.com, amitsd@google.com, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpci: Prevent Sink disconnection before
 vPpsShutdown in SPR PPS
Message-ID: <2025011702-pronto-sequel-7e87@gregkh>
References: <20250114142435.2093857-1-kyletso@google.com>
 <Z4jsp4J6AX0X-uwX@kuha.fi.intel.com>
 <CAGZ6i=3W-WsZ7Hz9T2wEYnFFMmFPpjgnrWQuHo=a_QJn8jzUOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGZ6i=3W-WsZ7Hz9T2wEYnFFMmFPpjgnrWQuHo=a_QJn8jzUOA@mail.gmail.com>

On Thu, Jan 16, 2025 at 07:41:16PM +0800, Kyle Tso wrote:
> On Thu, Jan 16, 2025 at 7:25 PM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > On Tue, Jan 14, 2025 at 10:24:35PM +0800, Kyle Tso wrote:
> > > The Source can drop its output voltage to the minimum of the requested
> > > PPS APDO voltage range when it is in Current Limit Mode. If this voltage
> > > falls within the range of vPpsShutdown, the Source initiates a Hard
> > > Reset and discharges Vbus. However, currently the Sink may disconnect
> > > before the voltage reaches vPpsShutdown, leading to unexpected behavior.
> > >
> > > Prevent premature disconnection by setting the Sink's disconnect
> > > threshold to the minimum vPpsShutdown value. Additionally, consider the
> > > voltage drop due to IR drop when calculating the appropriate threshold.
> > > This ensures a robust and reliable interaction between the Source and
> > > Sink during SPR PPS Current Limit Mode operation.
> > >
> > > Fixes: 4288debeaa4e ("usb: typec: tcpci: Fix up sink disconnect thresholds for PD")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Kyle Tso <kyletso@google.com>
> >
> > You've resend this, right? So is this v2 (or v1)?
> >
> > Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> >
> 
> Hello Heikki,
> 
> Thank you for the review.
> 
> Apologies for the resend. This is indeed the v1 patch. The previous
> email was accidentally sent with an incomplete recipient list.

Our tools play havoc when we have duplicates like this, always increment
the version number when resending as obviously you did the resend for
some reason.  Also, it let's us know which ones to review, what would
you do if you saw both of these in your inbox?

I'll try to fix this up by hand this time..

thanks,

greg k-h

