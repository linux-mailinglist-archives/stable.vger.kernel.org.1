Return-Path: <stable+bounces-40163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9688A96D0
	for <lists+stable@lfdr.de>; Thu, 18 Apr 2024 11:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B9FA1C220C7
	for <lists+stable@lfdr.de>; Thu, 18 Apr 2024 09:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AA115B56C;
	Thu, 18 Apr 2024 09:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wc+B+Gir"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D08115B560;
	Thu, 18 Apr 2024 09:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713434132; cv=none; b=QKZ0lMzN+SFnVRkzZFTpHYXNnpu5upcvncy9hRG3FKQAD8CiS5TYiGHde7a6wLoIfs18pXtvezunZh1aHZNHnyi4Exhv4RCKShrDAJj/yMczPooTShnSxcKQZ/jFXJD8v1KFun4hqcAHckGCovcJkDuaqk5TjuCRxc4I155zMlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713434132; c=relaxed/simple;
	bh=LrXF4D9a2RuVo+KC6g1JpGjfzY+/Tjn+DEq6UXzA2HE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHR7jpmwaZOZzwj9qiR8T/LIwsjDcZDI7O97G+XdgTS0ww/3TdCzZKKqiERGD9yV2D+Sgo53RlPAbzd2zzDNsI0Kb794azR8RX6VkFIyi9ZVRO/TR+bEr9tgIio6i7HVAtyGHUNABjhp9AtvcErdZOLWe+mNxUyrhxWZddHrXtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wc+B+Gir; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948EBC2BD11;
	Thu, 18 Apr 2024 09:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713434132;
	bh=LrXF4D9a2RuVo+KC6g1JpGjfzY+/Tjn+DEq6UXzA2HE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wc+B+Girs96VFUX1J441sPdPgHeUXHRnLQKoL2mGnZZkE7tgo7Yu+vp6ge2aYi6or
	 fPtMQsbcbrzn4EOxx2E8kZeHaHLSjyiM8jSiTikV1+tDOXc5lpPChGnH1J7Vbz7i03
	 7bgCoUO2lXUuK/p8ij0efHh6hNrV4IhtsTXomBBc=
Date: Thu, 18 Apr 2024 11:55:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] r8169: fix LED-related deadlock on module removal
Message-ID: <2024041800-yelp-grimy-1819@gregkh>
References: <ded9d793-83f8-4f11-87d9-a218d10c2981@gmail.com>
 <20240416193458.1e2c799d@kernel.org>
 <4b0495fd-fab5-4341-9b06-2f48613ee921@gmail.com>
 <2024041709-prorate-swifter-523d@gregkh>
 <17a3f8cb-26d4-4185-8e8b-0040ed62ae77@gmail.com>
 <2024041746-heritage-annex-3b66@gregkh>
 <ZiBOHF24EDoaI9gm@wunner.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiBOHF24EDoaI9gm@wunner.de>

On Thu, Apr 18, 2024 at 12:33:00AM +0200, Lukas Wunner wrote:
> On Wed, Apr 17, 2024 at 09:43:27AM +0200, Greg KH wrote:
> > On Wed, Apr 17, 2024 at 09:16:04AM +0200, Heiner Kallweit wrote:
> > > On 17.04.2024 09:04, Greg KH wrote:
> > > > On Wed, Apr 17, 2024 at 08:02:31AM +0200, Heiner Kallweit wrote:
> > > >> On 17.04.2024 04:34, Jakub Kicinski wrote:
> > > >>> On Mon, 15 Apr 2024 13:57:17 +0200 Heiner Kallweit wrote:
> > > >>>> Binding devm_led_classdev_register() to the netdev is problematic
> > > >>>> because on module removal we get a RTNL-related deadlock. Fix this
> > > >>>> by avoiding the device-managed LED functions.
> > > >>>>
> > > >>>> Note: We can safely call led_classdev_unregister() for a LED even
> > > >>>> if registering it failed, because led_classdev_unregister() detects
> > > >>>> this and is a no-op in this case.
> > > >>>>
> > > >>>> Fixes: 18764b883e15 ("r8169: add support for LED's on RTL8168/RTL8101")
> > > >>>> Cc: <stable@vger.kernel.org> # 6.8.x
> > > >>>> Reported-by: Lukas Wunner <lukas@wunner.de>
> > > >>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> > > >> 
> > > >> This is a version of the fix modified to apply on 6.8.
> > > > 
> > > > That was not obvious at all :(
> > > > 
> > > Stating "Cc: <stable@vger.kernel.org> # 6.8.x" isn't sufficient?
> > 
> > Without showing what commit id this is in Linus's tree, no.
> 
> The upstream commit id *is* called out in the patch, but it's buried
> below the three dashes:
> 
>     The original change was introduced with 6.8, 6.9 added support for
>     LEDs on RTL8125. Therefore the first version of the fix applied on
>     6.9-rc only. This is the modified version for 6.8.
>     Upstream commit: 19fa4f2a85d7
>                      ^^^^^^^^^^^^
> 
> The proper way to do this is to prominently add ...
> 
>     commit 19fa4f2a85d777a8052e869c1b892a2f7556569d upstream.
> 
> ... or ...
> 
>     [ Upstream commit 19fa4f2a85d777a8052e869c1b892a2f7556569d ]
> 
> ... as the first line of the commit message, as per
> Documentation/process/stable-kernel-rules.rst
> 

Yes, Heiner, please resubmit this, AND submit the fix-for-this-fix as
well, so that if we take this patch, it is not broken.

thanks,

greg k-hj

