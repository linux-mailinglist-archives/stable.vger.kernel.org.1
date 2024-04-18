Return-Path: <stable+bounces-40194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D81D28A9D61
	for <lists+stable@lfdr.de>; Thu, 18 Apr 2024 16:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DCAEB21B06
	for <lists+stable@lfdr.de>; Thu, 18 Apr 2024 14:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF4F165FC5;
	Thu, 18 Apr 2024 14:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kfmBWZN4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D9A6FB0;
	Thu, 18 Apr 2024 14:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713451466; cv=none; b=sqyky+gPapB7DBIn1dIJ+STn/+TXQkjkoZlnYRkz3yflgUd06fsbnubNu/2UEluk/VlJZ8Npis6k4vk3Ldnq/npCqKleCPn7WwhoyNxiuzH7KxTKXQXaLFtNZMeO718dauQmJQWBDMEvTkbsRpMuc0Z1YO7jIPHGwi/IUHo/d/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713451466; c=relaxed/simple;
	bh=/Y7DW9dwfSXyCEiTNgjV29wz5FEnLdy6VPSi7kaZyvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m02I9sig933YjJke+Vpu3QJicvtV/gMFmQE2mTA8fUXj1OPi4aBPNr83c2PxWBtPeOdsOWd7YBdos/0HLp7SBlHBsUC+uUnAO9oE8N6UdPVdNFIWZL3dNCSeK35H2tOZ/kj5W/DnkFWcklzc5Ug3tBiqkF6x8AxCK93RA6yQxRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kfmBWZN4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B7EC3277B;
	Thu, 18 Apr 2024 14:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713451465;
	bh=/Y7DW9dwfSXyCEiTNgjV29wz5FEnLdy6VPSi7kaZyvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kfmBWZN439diry73VZhXgAsAjR10BBTKbVvmGoo3WI28arfonN44s7+pWd+eauLpS
	 pGoYjx4JJ0GzsP1oWAUGkdRISuhEoA8I5ZFUJyQBkjg1krQbnFYs1vPP/1sFmif+GE
	 g3GWM5Fm48Ej3FHs3R11mDsgwo8O5YEhf7RsAfFI=
Date: Thu, 18 Apr 2024 16:44:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Lukas Wunner <lukas@wunner.de>, Jakub Kicinski <kuba@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] r8169: fix LED-related deadlock on module removal
Message-ID: <2024041830-entertain-platonic-b741@gregkh>
References: <ded9d793-83f8-4f11-87d9-a218d10c2981@gmail.com>
 <20240416193458.1e2c799d@kernel.org>
 <4b0495fd-fab5-4341-9b06-2f48613ee921@gmail.com>
 <2024041709-prorate-swifter-523d@gregkh>
 <17a3f8cb-26d4-4185-8e8b-0040ed62ae77@gmail.com>
 <2024041746-heritage-annex-3b66@gregkh>
 <ZiBOHF24EDoaI9gm@wunner.de>
 <2024041800-yelp-grimy-1819@gregkh>
 <CAFSsGVsYBJdB0-ve_bxFU8Ps-MS69YSadxqPe39X-6ui5ECiWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFSsGVsYBJdB0-ve_bxFU8Ps-MS69YSadxqPe39X-6ui5ECiWw@mail.gmail.com>

On Thu, Apr 18, 2024 at 04:33:37PM +0200, Heiner Kallweit wrote:
> On Thu, Apr 18, 2024 at 11:55 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Apr 18, 2024 at 12:33:00AM +0200, Lukas Wunner wrote:
> > > On Wed, Apr 17, 2024 at 09:43:27AM +0200, Greg KH wrote:
> > > > On Wed, Apr 17, 2024 at 09:16:04AM +0200, Heiner Kallweit wrote:
> > > > > On 17.04.2024 09:04, Greg KH wrote:
> > > > > > On Wed, Apr 17, 2024 at 08:02:31AM +0200, Heiner Kallweit wrote:
> > > > > >> On 17.04.2024 04:34, Jakub Kicinski wrote:
> > > > > >>> On Mon, 15 Apr 2024 13:57:17 +0200 Heiner Kallweit wrote:
> > > > > >>>> Binding devm_led_classdev_register() to the netdev is problematic
> > > > > >>>> because on module removal we get a RTNL-related deadlock. Fix this
> > > > > >>>> by avoiding the device-managed LED functions.
> > > > > >>>>
> > > > > >>>> Note: We can safely call led_classdev_unregister() for a LED even
> > > > > >>>> if registering it failed, because led_classdev_unregister() detects
> > > > > >>>> this and is a no-op in this case.
> > > > > >>>>
> > > > > >>>> Fixes: 18764b883e15 ("r8169: add support for LED's on RTL8168/RTL8101")
> > > > > >>>> Cc: <stable@vger.kernel.org> # 6.8.x
> > > > > >>>> Reported-by: Lukas Wunner <lukas@wunner.de>
> > > > > >>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> > > > > >>
> > > > > >> This is a version of the fix modified to apply on 6.8.
> > > > > >
> > > > > > That was not obvious at all :(
> > > > > >
> > > > > Stating "Cc: <stable@vger.kernel.org> # 6.8.x" isn't sufficient?
> > > >
> > > > Without showing what commit id this is in Linus's tree, no.
> > >
> > > The upstream commit id *is* called out in the patch, but it's buried
> > > below the three dashes:
> > >
> > >     The original change was introduced with 6.8, 6.9 added support for
> > >     LEDs on RTL8125. Therefore the first version of the fix applied on
> > >     6.9-rc only. This is the modified version for 6.8.
> > >     Upstream commit: 19fa4f2a85d7
> > >                      ^^^^^^^^^^^^
> > >
> > > The proper way to do this is to prominently add ...
> > >
> > >     commit 19fa4f2a85d777a8052e869c1b892a2f7556569d upstream.
> > >
> > > ... or ...
> > >
> > >     [ Upstream commit 19fa4f2a85d777a8052e869c1b892a2f7556569d ]
> > >
> > > ... as the first line of the commit message, as per
> > > Documentation/process/stable-kernel-rules.rst
> > >
> >
> > Yes, Heiner, please resubmit this, AND submit the fix-for-this-fix as
> > well, so that if we take this patch, it is not broken.
> >
> OK. The fix-for-the-fix was included already.

Included where?  In this change?  Please do not do that.

> It's trivial and IMO submitting it
> separately would just create overhead.

Not submitting it would cause problems when people look and see that the
"fix" is not also applied and then you would get automated emails
complaining about it.

Mirror what is in Linus's tree whenever possible please, it's simpler
and saves EVERYONE extra work.

thanks,

greg k-h

