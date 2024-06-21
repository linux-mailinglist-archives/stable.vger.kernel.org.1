Return-Path: <stable+bounces-54790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B41A911AA1
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 07:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 509FB1F25FCB
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 05:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11464137775;
	Fri, 21 Jun 2024 05:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jr1Hn7Bl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7560FBF3;
	Fri, 21 Jun 2024 05:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718948978; cv=none; b=JbJUJhgVdWykjJ//X7McADbgrh5FKOkrtlyEumRcG0iiAsbqw9bzQes3bqSGH/++kv44nshSjwVkVbWtlbQ9JjNu6nestc7Rut0S0/tEMEzmPq0M3sbbxUHzi/evcIl80RVsZbvZqrMlHbU1xK53bWTs/JsM5u8vpzu3XLsZjzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718948978; c=relaxed/simple;
	bh=ALp1fh1/2Wru2SLYgT/Kja0Ly1+GVV327a7a9kMnmjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gFB/sYrUzGFN7rpn3rVAB0aAZupeNu2eq31RvlUS9D1dZwyHkZskc++/gAt9gWEgYtxo+23Ra+WRpdVNiZMHmcE8DzBMqEcwtGD2PLBuF11KqzNlr51o4137NQ8+nXYKolrauWISEATfVf6omIXiZcVp+xwIeN0pTtP5hbHL4II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jr1Hn7Bl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDB1C2BBFC;
	Fri, 21 Jun 2024 05:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718948978;
	bh=ALp1fh1/2Wru2SLYgT/Kja0Ly1+GVV327a7a9kMnmjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jr1Hn7BlE7F3YMnL62fQ0K9PvNRZ3S5ysQFn18pr7v4+3B42O97/DQJ4B+8lLQZvQ
	 cBVo/dMgIhaccfRMc4Zyba9ZnHqumpqlcwgYyFG2j2Nll7BwUHuuy/b7CUeX8Ccj3Y
	 dmjNhCBjCvO1m3IyxhDcWo/jSiTDtfkrNt2/Hmpw=
Date: Fri, 21 Jun 2024 07:49:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: joswang <joswang1221@gmail.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Jos Wang <joswang@lenovo.com>
Subject: Re: [PATCH v7] usb: dwc3: core: Workaround for CSR read timeout
Message-ID: <2024062150-justify-skillet-e80e@gregkh>
References: <20240619114529.3441-1-joswang1221@gmail.com>
 <2024062051-washtub-sufferer-d756@gregkh>
 <CAMtoTm06MTJ_Gc4NvenycvWRxhLSaPptT1DLvBRs4RWVZO9Y_g@mail.gmail.com>
 <2024062151-professor-squeak-a4a7@gregkh>
 <20240621054239.mskjqbuhovydvmu4@synopsys.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240621054239.mskjqbuhovydvmu4@synopsys.com>

On Fri, Jun 21, 2024 at 05:42:42AM +0000, Thinh Nguyen wrote:
> On Fri, Jun 21, 2024, Greg KH wrote:
> > On Fri, Jun 21, 2024 at 09:40:10AM +0800, joswang wrote:
> > > On Fri, Jun 21, 2024 at 1:16 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Wed, Jun 19, 2024 at 07:45:29PM +0800, joswang wrote:
> > > > > From: Jos Wang <joswang@lenovo.com>
> > > > >
> > > > > This is a workaround for STAR 4846132, which only affects
> > > > > DWC_usb31 version2.00a operating in host mode.
> > > > >
> > > > > There is a problem in DWC_usb31 version 2.00a operating
> > > > > in host mode that would cause a CSR read timeout When CSR
> > > > > read coincides with RAM Clock Gating Entry. By disable
> > > > > Clock Gating, sacrificing power consumption for normal
> > > > > operation.
> > > > >
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Jos Wang <joswang@lenovo.com>
> > > >
> > > > What commit id does this fix?  How far back should it be backported in
> > > > the stable releases?
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > > 
> > > Hello Greg Thinh
> > > 
> > > It seems first begin from the commit 1e43c86d84fb ("usb: dwc3: core:
> > > Add DWC31 version 2.00a controller")
> > > in 6.8.0-rc6 branch ?
> > 
> > That commit showed up in 6.9, not 6.8.  And if so, please resend with a
> > proper "Fixes:" tag.
> > 
> 
> This patch workarounds the controller's issue.

So it fixes a bug?  Or does not fix a bug?  I'm confused.

> It doesn't resolve any
> particular commit that requires a "Fixes" tag. So, this should go on
> "next". It can be backported as needed.

Who would do the backporting and when?

> If it's to be backported, it can
> probably go back to as far as v4.3, to commit 690fb3718a70 ("usb: dwc3:
> Support Synopsys USB 3.1 IP"). But you'd need to collect all the
> dependencies including the commit mention above.

I don't understand, sorry.  Is this just a normal "evolve the driver to
work better" change, or is it a "fix broken code" change, or is it
something else?

In other words, what do you want to see happen to this?  What tree(s)
would you want it applied to?

thanks,

greg k-h

