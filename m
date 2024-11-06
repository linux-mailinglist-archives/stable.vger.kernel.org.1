Return-Path: <stable+bounces-90077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEF09BDF6E
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 08:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73D14B22DB1
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 07:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C43F1CCB22;
	Wed,  6 Nov 2024 07:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DwHmDtrV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC2E14F9D9;
	Wed,  6 Nov 2024 07:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730878202; cv=none; b=ifQMMEEH1NG/3nYD68jb6i7X1ajuUh6CUNl9AKPM3gIamZLPk3+tNAljemh1FuMUQcJJ2l5ZxUjQp6/5okW8Q7AdMFQZ1HRUtfYy9/874zd33QCRc2TVGq8Io71EJIkHUjr0BUrkcFthOH2N/fOuVW97YZbuASmOq5mwB1wyGS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730878202; c=relaxed/simple;
	bh=7GRmNx3Va4GlS9zyhhx0lrxhtai6IKUW+/cBfSlxqzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRerRyuwBnFj/L2DIAzEMeFfOwcp4WjBVCo0CAKF7W56Nwqu++gP4iN2R4pQS/MWYsMjZ5SotQWz256vUhC7c006b/hR29IaXulsIeBbsjlaA+PPa5QHXKa+kz0x3ES66afwmapduejFK8ZePullXUKnD+nAQuuuzFHAQd07ZhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DwHmDtrV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF3CC4CECD;
	Wed,  6 Nov 2024 07:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730878201;
	bh=7GRmNx3Va4GlS9zyhhx0lrxhtai6IKUW+/cBfSlxqzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DwHmDtrVR9i1KIwFeXVDkl1u1W+q/2vhIZy4dG7l/kp/BLmPTYG+iCzh84o9qIvQE
	 DY0ZxWjGpARrU99AIwbAt205vnyAF/M88gwcDGF/54DXIJrB/tbcyo1+8zqe+s710H
	 Dc/qU4jeBez5nsrpZcErXR1VZx3kZb03NmXTJl0c=
Date: Wed, 6 Nov 2024 08:29:43 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hardik Gohil <hgohil@mvista.com>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org,
	Kenton Groombridge <concord@gentoo.org>,
	Kees Cook <kees@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Xiangyu Chen <xiangyu.chen@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v5.10.277] wifi: mac80211: Avoid address calculations via
 out of bounds array indexing
Message-ID: <2024110634-reformed-frightful-990d@gregkh>
References: <1729316200-15234-1-git-send-email-hgohil@mvista.com>
 <2024102147-paralyses-roast-0cec@gregkh>
 <CAH+zgeGXXQOqg5aZnvCXfBhd4ONG25oGoukYJL5-uHYJAo11gQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH+zgeGXXQOqg5aZnvCXfBhd4ONG25oGoukYJL5-uHYJAo11gQ@mail.gmail.com>

On Mon, Oct 28, 2024 at 05:00:02PM +0530, Hardik Gohil wrote:
> On Mon, Oct 21, 2024 at 3:10 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Sat, Oct 19, 2024 at 11:06:40AM +0530, Hardik Gohil wrote:
> > > From: Kenton Groombridge <concord@gentoo.org>
> > >
> > > [ Upstream commit 2663d0462eb32ae7c9b035300ab6b1523886c718 ]
> >
> > We can't take patches for 5.10 that are not already in 5.15.  Please fix
> > up and resend for ALL relevent trees.
> >
> > thanks,
> >
> > greg k-h
> 
> I have just confirmed those are applicable to v5.15 and v5.10.
> 
> Request to add those patches.

Please send tested backports.

thanks,

greg k-h

