Return-Path: <stable+bounces-196533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F496C7AF0A
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 17:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 135D5345841
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 16:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9DA2F0C6E;
	Fri, 21 Nov 2025 16:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e0x6nNeO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880D02ED15D;
	Fri, 21 Nov 2025 16:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763743737; cv=none; b=vEXMlNtyb6Hv4PkGVClJRD/Pl0SnD/qz8ixK3RozuVAO9W07kJeWNaKrBalBF6XTC6tS5YeketRasV4PXvTkTe+n4sGYxtN/7E+WYY5dT8/+LMtcB8J0p2oEvzb1PqjS9crXvQzAauD4ciG2XvyxMOGwoqYiK66ZSPEoAPjhCBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763743737; c=relaxed/simple;
	bh=xJ8rgo/lJ+lwIvMrtcU3CLwjnSKag8Ssy4/PS0HVMbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVyyFk6gK4/apicU6P4PzVoh2o3+yC6moMSOr73FqPdIo1iF813nagpQXfLB9i6kJVDgw/eV7UIIpancKG01HkUdEd6H6ZI2CndAt324/Z+HTEANHlYIsM06Pkhix1JSmRK2PB8zZIxoWXFpLZUCE2bmeiugwBg+5UnFFdlMtgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e0x6nNeO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB9BC4CEF1;
	Fri, 21 Nov 2025 16:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763743737;
	bh=xJ8rgo/lJ+lwIvMrtcU3CLwjnSKag8Ssy4/PS0HVMbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e0x6nNeONjEiuP4DWuQJdmBo8Qa0SraqviPHpfkPuhVpQejL3JArsXZTMCSt/9o5q
	 2byC+g+WS1YOaSgjC9C5AtxT2gHyJkTnEHM8xTX4Ry4rs/7RUVyRZlyRrGqBV9UQpo
	 W7DoAOJ/6uAB7wrlP1LnQkTPSbKkL9ovy7I9A4e0=
Date: Fri, 21 Nov 2025 17:48:49 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: phy: Initialize struct usb_phy list_head
Message-ID: <2025112111-impotency-unguarded-5e07@gregkh>
References: <20251113-diogo-smaug_typec-v1-1-f1aa3b48620d@tecnico.ulisboa.pt>
 <2025112139-resale-upward-3366@gregkh>
 <8837bf19-dd98-40f9-b2ff-192a511c357c@tecnico.ulisboa.pt>
 <2025112100-backstage-wager-0d5a@gregkh>
 <44e00ee1-401d-41e8-b5c7-8070ce6d514e@tecnico.ulisboa.pt>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44e00ee1-401d-41e8-b5c7-8070ce6d514e@tecnico.ulisboa.pt>

On Fri, Nov 21, 2025 at 04:39:58PM +0000, Diogo Ivo wrote:
> 
> 
> On 11/21/25 15:03, Greg Kroah-Hartman wrote:
> > On Fri, Nov 21, 2025 at 02:55:35PM +0000, Diogo Ivo wrote:
> > > 
> > > 
> > > On 11/21/25 14:09, Greg Kroah-Hartman wrote:
> > > > On Thu, Nov 13, 2025 at 02:59:06PM +0000, Diogo Ivo wrote:
> > > > > When executing usb_add_phy() and usb_add_phy_dev() it is possible that
> > > > > usb_add_extcon() fails (for example with -EPROBE_DEFER), in which case
> > > > > the usb_phy does not get added to phy_list via
> > > > > list_add_tail(&x->head, phy_list).
> > > > > 
> > > > > Then, when the driver that tried to add the phy receives the error
> > > > > propagated from usb_add_extcon() and calls into usb_remove_phy() to
> > > > > undo the partial registration there will be an unconditional call to
> > > > > list_del(&x->head) which is notinitialized and leads to a NULL pointer
> > > > > dereference.
> > > > > 
> > > > > Fix this by initializing x->head before usb_add_extcon() has a chance to
> > > > > fail.
> > > > > 
> > > > > Fixes: 7d21114dc6a2d53 ("usb: phy: Introduce one extcon device into usb phy")
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
> > > > > ---
> > > > >    drivers/usb/phy/phy.c | 4 ++++
> > > > >    1 file changed, 4 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/usb/phy/phy.c b/drivers/usb/phy/phy.c
> > > > > index e1435bc59662..5a9b9353f343 100644
> > > > > --- a/drivers/usb/phy/phy.c
> > > > > +++ b/drivers/usb/phy/phy.c
> > > > > @@ -646,6 +646,8 @@ int usb_add_phy(struct usb_phy *x, enum usb_phy_type type)
> > > > >    		return -EINVAL;
> > > > >    	}
> > > > > +	INIT_LIST_HEAD(&x->head);
> > > > > +
> > > > >    	usb_charger_init(x);
> > > > >    	ret = usb_add_extcon(x);
> > > > >    	if (ret)
> > > > > @@ -696,6 +698,8 @@ int usb_add_phy_dev(struct usb_phy *x)
> > > > >    		return -EINVAL;
> > > > >    	}
> > > > > +	INIT_LIST_HEAD(&x->head);
> > > > > +
> > > > >    	usb_charger_init(x);
> > > > >    	ret = usb_add_extcon(x);
> > > > >    	if (ret)
> > > > > 
> > > > 
> > > > Shouldn't you be also removing an existing call to INIT_LIST_HEAD()
> > > > somewhere?  This is not "moving" the code, it is adding it.
> > > 
> > >  From my understanding that's exactly the problem, currently there is no
> > > call to INIT_LIST_HEAD() anywhere on these code paths, meaning that if
> > > we do not reach the point of calling list_add_tail() at the end of
> > > usb_add_phy() and usb_phy_add_dev() then x->head will remain uninitialized
> > > and fault when running usb_remove_phy().
> > 
> > Then how does this work at all if the list is never initialized?
> 
> In this case in drivers/usb/phy/phy.c a static LIST_HEAD(phy_list) is
> declared and then for each new 'struct usb_phy *x' the x->head entry
> will get added to this list by calling list_add_tail(&x->head, &phy_list).

Great, can you document this in the changelog text so that it makes more
sense (and properly quote the fixes: sha1, I think you have too many
digits there...) and resend a v2.

thanks,

greg k-h

