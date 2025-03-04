Return-Path: <stable+bounces-120201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0632FA4D2F9
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 06:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AF1B189736B
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 05:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42A51F4611;
	Tue,  4 Mar 2025 05:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xpmFtpN9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484D9186E26;
	Tue,  4 Mar 2025 05:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741065982; cv=none; b=fSBFZdkCGJ/tgkFeJry524hGiTTepShhmx8qZjjCrZNDkhOWdccn1aMFmlxV0pjwsKGU5ToyMCS1c1GZziFtmNLvn/9O6PzID8jItY0LhzqiTVrNQwjY5c0zxoRFEVwjnNPBUnYudtMI54GPxe2pUjQf+YKyYCGb9qUSFwY2ZOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741065982; c=relaxed/simple;
	bh=fomfybpAZCIekiHAArI106hF+X2YJ2tj5d6mshgMMIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4OUBTvGWWkLCY+p0xa0Xua0XgY4175QDI6cgxVB1grDDuiX3u8RibbSuA2qcUkc6JgC4jpOGTE5lmztglrCY/0tjY+DWI0PlUdoih7Aabg0NjlwxptgYzMtgztYlTj8Er94P8n0v66p679tB1mb3SJV2/xZXecA4i233dBR0xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xpmFtpN9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643C3C4CEE5;
	Tue,  4 Mar 2025 05:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741065981;
	bh=fomfybpAZCIekiHAArI106hF+X2YJ2tj5d6mshgMMIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xpmFtpN9X4J7DSInOx04KB0UphkG56mnGEPcKc2Gjf+YTPL7wDDxarWCvb/lVe9Xa
	 H0evui4uquATSzddRls9A0o8E2L/7wnHXHqZQMEQMbLJzGurYaxrJQvRNlk/lNu24w
	 OQk1axn63MP45/SGEb05WgqRjPVoVGmQpwNViPRI=
Date: Tue, 4 Mar 2025 06:26:18 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: John Youn <John.Youn@synopsys.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: Set SUSPENDENABLE soon after phy init
Message-ID: <2025030405-worst-strenuous-ca31@gregkh>
References: <633aef0afee7d56d2316f7cc3e1b2a6d518a8cc9.1738280911.git.Thinh.Nguyen@synopsys.com>
 <20250303224706.wzvsf4nw2swzelaw@synopsys.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303224706.wzvsf4nw2swzelaw@synopsys.com>

On Mon, Mar 03, 2025 at 10:47:19PM +0000, Thinh Nguyen wrote:
> Hi Greg,
> 
> On Thu, Jan 30, 2025, Thinh Nguyen wrote:
> > After phy initialization, some phy operations can only be executed while
> > in lower P states. Ensure GUSB3PIPECTL.SUSPENDENABLE and
> > GUSB2PHYCFG.SUSPHY are set soon after initialization to avoid blocking
> > phy ops.
> > 
> > Previously the SUSPENDENABLE bits are only set after the controller
> > initialization, which may not happen right away if there's no gadget
> > driver or xhci driver bound. Revise this to clear SUSPENDENABLE bits
> > only when there's mode switching (change in GCTL.PRTCAPDIR).
> > 
> > Fixes: 6d735722063a ("usb: dwc3: core: Prevent phy suspend during init")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> > ---
> >  drivers/usb/dwc3/core.c | 69 +++++++++++++++++++++++++----------------
> >  drivers/usb/dwc3/core.h |  2 +-
> >  drivers/usb/dwc3/drd.c  |  4 +--
> >  3 files changed, 45 insertions(+), 30 deletions(-)
> > 
> 
> 
> Just checking, I hope this patch isn't lost in your inbox. If not, then
> you can ignore this message.

Odd, yes, this did get lost, sorry.

I'll go queue this up right now...

greg k-h

