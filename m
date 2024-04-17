Return-Path: <stable+bounces-40073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC728A7D52
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 09:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFC1A1C2103E
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 07:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF116BFA9;
	Wed, 17 Apr 2024 07:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="efUVN4ur"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1765D184D;
	Wed, 17 Apr 2024 07:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713339811; cv=none; b=iDQBdvoytyxkYiz9oB/7EK+qQjfiXrLpV8MZPwlFFcZC+Xc9l2S7ePEdH9XUblbGbkwrNaSLIZDcFc7A0H29FNKcWEoUgqVtS0ru3ZqlkOc8V4sl/rXmJ3vkTpwcVovMjauTPVrAjwNjO3hkrfwTcYglfTShaO7GRR3x30/V2p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713339811; c=relaxed/simple;
	bh=t03L1s42OcwhscuOshzmRA4k+Qv058R/Bk9bmgwqgF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sym7yIFm66sx+KeN/xzkYwOj1rtGhbr+RsTjCsQchN3z9YD7aCbOPz/mL1JNvJS4XflRTHG+4Pw0aRQjqI/uLUqWoLOmryfYaC1t8YRxF8UFoae02UGV6hVeYbY6pmeQrQSvYHX/Hk+ZpFOEmyeV16pVduQxaoPIc0jQ7yr3mH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=efUVN4ur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13AF2C072AA;
	Wed, 17 Apr 2024 07:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713339810;
	bh=t03L1s42OcwhscuOshzmRA4k+Qv058R/Bk9bmgwqgF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=efUVN4ur3E7W/z7JXB6G523ZEcUK6tUrUzfQdiQ6D84Uu4EkrKzb1SGCgyfAayZ6l
	 ga6RWLGSYcJL5cShhE/g42cQuKaFTn45pzB4drMR+TPCJShHGO3QBRzC0EnHp6IAz1
	 OZcG8rRgc6khrH7cuGICt4AsXpTd/nskqraobJ60=
Date: Wed, 17 Apr 2024 09:43:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] r8169: fix LED-related deadlock on module removal
Message-ID: <2024041746-heritage-annex-3b66@gregkh>
References: <ded9d793-83f8-4f11-87d9-a218d10c2981@gmail.com>
 <20240416193458.1e2c799d@kernel.org>
 <4b0495fd-fab5-4341-9b06-2f48613ee921@gmail.com>
 <2024041709-prorate-swifter-523d@gregkh>
 <17a3f8cb-26d4-4185-8e8b-0040ed62ae77@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17a3f8cb-26d4-4185-8e8b-0040ed62ae77@gmail.com>

On Wed, Apr 17, 2024 at 09:16:04AM +0200, Heiner Kallweit wrote:
> On 17.04.2024 09:04, Greg KH wrote:
> > On Wed, Apr 17, 2024 at 08:02:31AM +0200, Heiner Kallweit wrote:
> >> On 17.04.2024 04:34, Jakub Kicinski wrote:
> >>> On Mon, 15 Apr 2024 13:57:17 +0200 Heiner Kallweit wrote:
> >>>> Binding devm_led_classdev_register() to the netdev is problematic
> >>>> because on module removal we get a RTNL-related deadlock. Fix this
> >>>> by avoiding the device-managed LED functions.
> >>>>
> >>>> Note: We can safely call led_classdev_unregister() for a LED even
> >>>> if registering it failed, because led_classdev_unregister() detects
> >>>> this and is a no-op in this case.
> >>>>
> >>>> Fixes: 18764b883e15 ("r8169: add support for LED's on RTL8168/RTL8101")
> >>>> Cc: <stable@vger.kernel.org> # 6.8.x
> >>>> Reported-by: Lukas Wunner <lukas@wunner.de>
> >>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> >>>
> >>> Looks like I already applied one chunk of this as commit 97e176fcbbf3
> >>> ("r8169: add missing conditional compiling for call to r8169_remove_leds")
> >>> Is it worth throwing that in as a Fixes tag?
> >>
> >> This is a version of the fix modified to apply on 6.8.
> > 
> > That was not obvious at all :(
> > 
> Stating "Cc: <stable@vger.kernel.org> # 6.8.x" isn't sufficient?

Without showing what commit id this is in Linus's tree, no.

> >> It's not supposed to be applied on net / net-next.
> >> Should I have sent it to stable@vger.kernel.org only?
> > 
> > Why woudlu a commit only be relevent for older kernels and not the
> > latest one?
> > 
> The fix version for 6.9-rc and next has been applied already.

Then a hint as to what the git id of that commit is would help out a lot
here.

Thanks,

greg k-h

