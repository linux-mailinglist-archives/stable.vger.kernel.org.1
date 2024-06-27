Return-Path: <stable+bounces-55969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1301791A92B
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 16:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 444E41C20A56
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 14:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89902195FEC;
	Thu, 27 Jun 2024 14:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xaqUc5y+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431EC195803;
	Thu, 27 Jun 2024 14:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719498387; cv=none; b=hOYgNveTdfzypr63IHQ0XivzYFdbH54WaFImEbcLHaAo6WGFQ0M4KP6ZCVP1VIbk9+qDP3kI+M6JQcxCsvLhnOtZwEMIT/nKXXKflCmz6XpFNe+zkInAUUSOJYO+bMl9xKWhk1Du7xG3CoAMoLKyqCVjmkyKZkugGtnhL1i3TZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719498387; c=relaxed/simple;
	bh=DhqFc95C//XVpJ9zlU8ndrs03k8vJqiZ9FcjaqlUuRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpltPVjgVG6CLK0KjotaWgwiU0tPuvQCxFEM1SkEhXKHdKjDKUS/pqVCejGK0TaGtSPPvQDo2fOB4xNlliaIO0IlcoHoizBEy5HOWqxLbJx7/RbZVG649pzjOTeM8upBrRDCwrEgW0KOk+S5+G70CVMknGzcoGx7Zr23Kd1QDs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xaqUc5y+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75EB1C2BBFC;
	Thu, 27 Jun 2024 14:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719498387;
	bh=DhqFc95C//XVpJ9zlU8ndrs03k8vJqiZ9FcjaqlUuRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xaqUc5y+aCGR1PMgVEr8BLTd6rXnI6krPHbQYvxa4dYyON76p3VrFr5sXwvlmRkdW
	 lQsj4U9TIFTkrf1yGWCTaYrEa5qffyI/YcugtKfwRPHTb8K/ugtxmHnsSz6/Av5xdf
	 0gSrx3pDKi96oYR/kfc/9SrkOVnmBBMON9rclg3s=
Date: Thu, 27 Jun 2024 16:26:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: joswang <joswang1221@gmail.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Jos Wang <joswang@lenovo.com>
Subject: Re: [PATCH v7] usb: dwc3: core: Workaround for CSR read timeout
Message-ID: <2024062709-germproof-reveler-f2f0@gregkh>
References: <2024062051-washtub-sufferer-d756@gregkh>
 <CAMtoTm06MTJ_Gc4NvenycvWRxhLSaPptT1DLvBRs4RWVZO9Y_g@mail.gmail.com>
 <2024062151-professor-squeak-a4a7@gregkh>
 <20240621054239.mskjqbuhovydvmu4@synopsys.com>
 <2024062150-justify-skillet-e80e@gregkh>
 <20240621062036.2rhksldny7dzijv2@synopsys.com>
 <2024062126-whacky-employee-74a4@gregkh>
 <20240621230846.izl447eymxqxi5p2@synopsys.com>
 <CAMtoTm2UE31gcM7dGxvz_CbFoKotOJ1p7PeQwgBuTDE9nq7CJw@mail.gmail.com>
 <20240626013710.dxqa6r4mjuc6on4w@synopsys.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240626013710.dxqa6r4mjuc6on4w@synopsys.com>

On Wed, Jun 26, 2024 at 01:37:14AM +0000, Thinh Nguyen wrote:
> On Tue, Jun 25, 2024, joswang wrote:
> > On Sat, Jun 22, 2024 at 7:09 AM Thinh Nguyen <Thinh.Nguyen@synopsys.com> wrote:
> > >
> > > Ok. I may have misunderstood what can go into rc2 and beyond then. If we
> > > don't have to wait for the next rc1 for it to be picked up for stable,
> > > then can we add it to "usb-linus" branch?
> > >
> > > There won't be a Fixes tag, but we can backport it up to 5.10.x:
> > >
> > > Cc: <stable@vger.kernel.org> # 5.10.x: 1e43c86d: usb: dwc3: core: Add DWC31 version 2.00a controller
> > > Cc: <stable@vger.kernel.org> # 5.10.x
> > >
> > > This can go after the versioning scheme in dwc3 in the 5.10.x lts. I did
> > > not check what other dependencies are needed in addition to the change
> > > above.
> > >
> > > Thanks,
> > > Thinh
> > 
> > Is there anything else I need to modify for this patch?
> > 
> 
> Hi Greg,
> 
> Will a simple tag "Cc: <stable@vger.kernel.org>" sufficient? Or would
> you prefer using the tags above?
> 
> For either case:
> 
> Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

I fixed this up by hand, thanks for the ack!

greg k-h

