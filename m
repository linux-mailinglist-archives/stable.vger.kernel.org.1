Return-Path: <stable+bounces-196497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9420C7A686
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 16:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3624D3A1A74
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 15:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F4C2D877A;
	Fri, 21 Nov 2025 15:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WAR9WgFJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3568287268;
	Fri, 21 Nov 2025 15:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763737404; cv=none; b=tgN7bbaVT2tWwGGI1EOGSNvhRwPa3XiUr1eYu/4wtKaUcJf+V6DqUDD13hoF/8ikHg5L7+MUd+p470VOcHT3BxzT+2nEp6j0RWml/pp6Hes6yMCtB16BXeGDkzYz+afEmTkJ590Mf3g5hDd8t60pdaMdhnIv8KuL7gZehmcXtS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763737404; c=relaxed/simple;
	bh=yv1/yE9ZrOhqlQ97TIqyj69zG5L9BWBNunf0n4Xbwc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TT9m4k1Og7CS7lWnIonZA7GafNhaL+2/qLLPz6dEZ7gFEwAG0ArOfSADcbjaIpeK8nlu9gEODmyhNZ+lDElNoBZ2f9iyNYXBMCUbCFhaGYddd2EYc7+xs4/1zQAAb+gv1fNuqPsEDbqAUCtZ3ZFBJvaLWVoYOXVWDsFrjfLInDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WAR9WgFJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7875C4CEF1;
	Fri, 21 Nov 2025 15:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763737404;
	bh=yv1/yE9ZrOhqlQ97TIqyj69zG5L9BWBNunf0n4Xbwc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WAR9WgFJ5JGMZRduxabcDwu3zUnUM0tMaPgTVK72XqiBhu5PjgTgjwKuu7KkhHH2T
	 kw9N1cg0gJHqLI2dIK2eGAstwtO3yPfIJWTHQHK75OGvzgk/CrP2Aq/lLcWFcEoNv/
	 BLmKG0+iFOCpG1Tj4lEaoMnhaBZdwZ4TOSHsnTms=
Date: Fri, 21 Nov 2025 16:03:14 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: phy: Initialize struct usb_phy list_head
Message-ID: <2025112100-backstage-wager-0d5a@gregkh>
References: <20251113-diogo-smaug_typec-v1-1-f1aa3b48620d@tecnico.ulisboa.pt>
 <2025112139-resale-upward-3366@gregkh>
 <8837bf19-dd98-40f9-b2ff-192a511c357c@tecnico.ulisboa.pt>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8837bf19-dd98-40f9-b2ff-192a511c357c@tecnico.ulisboa.pt>

On Fri, Nov 21, 2025 at 02:55:35PM +0000, Diogo Ivo wrote:
> 
> 
> On 11/21/25 14:09, Greg Kroah-Hartman wrote:
> > On Thu, Nov 13, 2025 at 02:59:06PM +0000, Diogo Ivo wrote:
> > > When executing usb_add_phy() and usb_add_phy_dev() it is possible that
> > > usb_add_extcon() fails (for example with -EPROBE_DEFER), in which case
> > > the usb_phy does not get added to phy_list via
> > > list_add_tail(&x->head, phy_list).
> > > 
> > > Then, when the driver that tried to add the phy receives the error
> > > propagated from usb_add_extcon() and calls into usb_remove_phy() to
> > > undo the partial registration there will be an unconditional call to
> > > list_del(&x->head) which is notinitialized and leads to a NULL pointer
> > > dereference.
> > > 
> > > Fix this by initializing x->head before usb_add_extcon() has a chance to
> > > fail.
> > > 
> > > Fixes: 7d21114dc6a2d53 ("usb: phy: Introduce one extcon device into usb phy")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
> > > ---
> > >   drivers/usb/phy/phy.c | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/usb/phy/phy.c b/drivers/usb/phy/phy.c
> > > index e1435bc59662..5a9b9353f343 100644
> > > --- a/drivers/usb/phy/phy.c
> > > +++ b/drivers/usb/phy/phy.c
> > > @@ -646,6 +646,8 @@ int usb_add_phy(struct usb_phy *x, enum usb_phy_type type)
> > >   		return -EINVAL;
> > >   	}
> > > +	INIT_LIST_HEAD(&x->head);
> > > +
> > >   	usb_charger_init(x);
> > >   	ret = usb_add_extcon(x);
> > >   	if (ret)
> > > @@ -696,6 +698,8 @@ int usb_add_phy_dev(struct usb_phy *x)
> > >   		return -EINVAL;
> > >   	}
> > > +	INIT_LIST_HEAD(&x->head);
> > > +
> > >   	usb_charger_init(x);
> > >   	ret = usb_add_extcon(x);
> > >   	if (ret)
> > > 
> > 
> > Shouldn't you be also removing an existing call to INIT_LIST_HEAD()
> > somewhere?  This is not "moving" the code, it is adding it.
> 
> From my understanding that's exactly the problem, currently there is no
> call to INIT_LIST_HEAD() anywhere on these code paths, meaning that if
> we do not reach the point of calling list_add_tail() at the end of
> usb_add_phy() and usb_phy_add_dev() then x->head will remain uninitialized
> and fault when running usb_remove_phy().

Then how does this work at all if the list is never initialized?

thanks,

greg k-h

