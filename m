Return-Path: <stable+bounces-40129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 370F38A8EE2
	for <lists+stable@lfdr.de>; Thu, 18 Apr 2024 00:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E256D1F22280
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 22:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C907640D;
	Wed, 17 Apr 2024 22:33:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3812C43ACD;
	Wed, 17 Apr 2024 22:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713393193; cv=none; b=Mpu0nU7xCGleeWZVdz6QZEaCiFe/5Lc099TPDCH/8V9fDy7AhR7WRHADuxHNt01288Zljv2NwYJ3dmcy35n3n5ekuc5fsizuF7bABimJbj/qTaClQU+DWAwVOltE877ruaOliAE0KM+wNH6sStdu0yaWK/ZLOtcSNei1aZ+GNiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713393193; c=relaxed/simple;
	bh=olEtmW1Fdb+ZA6bekXHJ/ecjbAH6rD4LnRBRS5a25K0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwVNTvizER7sUw8OZk/RsY7KAf7q07Md0eK62n8OT6fzGth04BMEQM+A03RqWZ57OO/sawEXIvPMvwPUnLeXiAS8M6VTeJWwAnCj7x7pTpwwIdWwE0m1ZqqTZOq5vu283IkXCe2M7Xc+z0YIm8Ha1G4bFDiMDf9I2CY53C8PItY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id A4B0E3000D926;
	Thu, 18 Apr 2024 00:33:00 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 82D8E1BD02; Thu, 18 Apr 2024 00:33:00 +0200 (CEST)
Date: Thu, 18 Apr 2024 00:33:00 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] r8169: fix LED-related deadlock on module removal
Message-ID: <ZiBOHF24EDoaI9gm@wunner.de>
References: <ded9d793-83f8-4f11-87d9-a218d10c2981@gmail.com>
 <20240416193458.1e2c799d@kernel.org>
 <4b0495fd-fab5-4341-9b06-2f48613ee921@gmail.com>
 <2024041709-prorate-swifter-523d@gregkh>
 <17a3f8cb-26d4-4185-8e8b-0040ed62ae77@gmail.com>
 <2024041746-heritage-annex-3b66@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024041746-heritage-annex-3b66@gregkh>

On Wed, Apr 17, 2024 at 09:43:27AM +0200, Greg KH wrote:
> On Wed, Apr 17, 2024 at 09:16:04AM +0200, Heiner Kallweit wrote:
> > On 17.04.2024 09:04, Greg KH wrote:
> > > On Wed, Apr 17, 2024 at 08:02:31AM +0200, Heiner Kallweit wrote:
> > >> On 17.04.2024 04:34, Jakub Kicinski wrote:
> > >>> On Mon, 15 Apr 2024 13:57:17 +0200 Heiner Kallweit wrote:
> > >>>> Binding devm_led_classdev_register() to the netdev is problematic
> > >>>> because on module removal we get a RTNL-related deadlock. Fix this
> > >>>> by avoiding the device-managed LED functions.
> > >>>>
> > >>>> Note: We can safely call led_classdev_unregister() for a LED even
> > >>>> if registering it failed, because led_classdev_unregister() detects
> > >>>> this and is a no-op in this case.
> > >>>>
> > >>>> Fixes: 18764b883e15 ("r8169: add support for LED's on RTL8168/RTL8101")
> > >>>> Cc: <stable@vger.kernel.org> # 6.8.x
> > >>>> Reported-by: Lukas Wunner <lukas@wunner.de>
> > >>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> > >> 
> > >> This is a version of the fix modified to apply on 6.8.
> > > 
> > > That was not obvious at all :(
> > > 
> > Stating "Cc: <stable@vger.kernel.org> # 6.8.x" isn't sufficient?
> 
> Without showing what commit id this is in Linus's tree, no.

The upstream commit id *is* called out in the patch, but it's buried
below the three dashes:

    The original change was introduced with 6.8, 6.9 added support for
    LEDs on RTL8125. Therefore the first version of the fix applied on
    6.9-rc only. This is the modified version for 6.8.
    Upstream commit: 19fa4f2a85d7
                     ^^^^^^^^^^^^

The proper way to do this is to prominently add ...

    commit 19fa4f2a85d777a8052e869c1b892a2f7556569d upstream.

... or ...

    [ Upstream commit 19fa4f2a85d777a8052e869c1b892a2f7556569d ]

... as the first line of the commit message, as per
Documentation/process/stable-kernel-rules.rst

