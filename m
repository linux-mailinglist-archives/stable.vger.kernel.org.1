Return-Path: <stable+bounces-106682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BEDA004D2
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 08:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4744C3A3A25
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 07:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807961C07E2;
	Fri,  3 Jan 2025 07:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="de1imjf4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB22101E6;
	Fri,  3 Jan 2025 07:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735888352; cv=none; b=IOkDhWcM2rZUVMg5gApbKMtfyDNvg+dxVqToqiduV23peT14dLh7l8PiEkQMvQQYrNm6csanrO0MsCGaYV5gf3ZCT0QOBGTVyQQKI21dldm0cujqehLjO1XtbVerzHkdTnwtOslfxSbuZtMLC7pcNpN78HH10ak7GHIELADxee8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735888352; c=relaxed/simple;
	bh=WCTkoiFAsihIiho3cchhcz+XjjexNfZMUI/HlDUbGc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMfADAE2VUTG2558KjvoSUbLw/rg+6kupHR58lo0B4IPUJLqaUchgm0c+0kRqKVL5kcr3gzAf0Cx8k+80MPWJZOcn/RmYUlLGlC63BinU3c5msLOIagzxuooMLPGryAODxWwfDx+dwzPcRouF8+2K9VYUL2OSdmwXaHnNPp/OBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=de1imjf4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76027C4CECE;
	Fri,  3 Jan 2025 07:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735888351;
	bh=WCTkoiFAsihIiho3cchhcz+XjjexNfZMUI/HlDUbGc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=de1imjf4z510Pg/GtmKsL3/Fucyfe4mbseAasyXoyjh5nJSDP3F+/j0ebBcODcvhL
	 rvVONYV6FFIITsW8DxHYbDdnobK8zAT7UncDD7ZC31HOBFkTwhYQgFUE5bvRULzdXL
	 IZqrTP0Unmlua3C8DWrHmteZVVCFkfX4lF8Plzyo=
Date: Fri, 3 Jan 2025 08:12:28 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Lubomir Rintel <lrintel@redhat.com>,
	usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
	Lubomir Rintel <lkundrak@v3.sk>, stable@vger.kernel.org
Subject: Re: [PATCH] usb-storage: Add max sectors quirk for Nokia 208
Message-ID: <2025010302-entering-paltry-bac5@gregkh>
References: <20250101212206.2386207-1-lkundrak@v3.sk>
 <729d6c93-a794-4102-a191-494bf86df219@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <729d6c93-a794-4102-a191-494bf86df219@rowland.harvard.edu>

On Thu, Jan 02, 2025 at 11:22:00AM -0500, Alan Stern wrote:
> On Wed, Jan 01, 2025 at 10:22:06PM +0100, Lubomir Rintel wrote:
> > This fixes data corruption when accessing the internal SD card in mass
> > storage mode.
> > 
> > I am actually not too sure why. I didn't figure a straightforward way to
> > reproduce the issue, but i seem to get garbage when issuing a lot (over 50)
> > of large reads (over 120 sectors) are done in a quick succession. That is,
> > time seems to matter here -- larger reads are fine if they are done with
> > some delay between them.
> > 
> > But I'm not great at understanding this sort of things, so I'll assume
> > the issue other, smarter, folks were seeing with similar phones is the
> > same problem and I'll just put my quirk next to theirs.
> > 
> > The "Software details" screen on the phone is as follows:
> > 
> >   V 04.06
> >   07-08-13
> >   RM-849
> >   (c) Nokia
> > 
> > TL;DR version of the device descriptor:
> > 
> >   idVendor           0x0421 Nokia Mobile Phones
> >   idProduct          0x06c2
> >   bcdDevice            4.06
> >   iManufacturer           1 Nokia
> >   iProduct                2 Nokia 208
> > 
> > The patch assumes older firmwares are broken too (I'm unable to test, but
> > no biggie if they aren't I guess), and I have no idea if newer firmware
> > exists.
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > Cc: <stable@vger.kernel.org>
> > ---
> 
> Hmmm, maybe we should automatically set this flag for all Nokia devices.  
> In any case,
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> 
> However, Greg's patch bot is going to ask why you didn't include a 
> Fixes: tag.

No need for a Fixes: tag for a new quirk, what is odd is that this
didn't go through the linux-usb mailing list :(

I'll queue it up soon.

thanks,

greg k-h

