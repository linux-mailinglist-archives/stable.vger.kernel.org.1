Return-Path: <stable+bounces-40067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB378A7CB9
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 09:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7976C282227
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 07:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816536A330;
	Wed, 17 Apr 2024 07:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1/sFUbpF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396D46A029;
	Wed, 17 Apr 2024 07:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713337484; cv=none; b=aC0a8R4k6zB2/yrpeOqxmlEAJyRYPtwREq5O+dTLxGxNfZfM3J/K6SV3XD/Vz13b77AASVnQPfyZBlcnT2YbEVziVQLIRNRiU4uNumqOdEqWVIe8ATN25VcAsqCF90/LBBpziVDp+uufW6T3yO3biTCke5B4lGHgPQzSfa5AAXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713337484; c=relaxed/simple;
	bh=JntNrUuBI71qpmKPHc06pvx67zMCg9zCVkgvlqlWBfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gE5uYbYn/Sl4ExeL1CCW6b+u9XvY+Cis63yfZ9j0larZVFiI0BcTBoUHxVU9Jsv8YCcH8EJJtNKNm8y6mKuiN3EkVg8ChNnb2nIHZ91+QOv6g0uz5DW4zxsIZbQi1E2Cdzdx+gsNuWaWFHKtpr3m18QArAxdVy3D4qheXX/8k4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1/sFUbpF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45507C32783;
	Wed, 17 Apr 2024 07:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713337483;
	bh=JntNrUuBI71qpmKPHc06pvx67zMCg9zCVkgvlqlWBfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1/sFUbpFsrItYshTyLzMfOm5AE8Mk42nIwqNLcStTrkZeMPy2xPm8KTyPf6cjG0hj
	 PWO5Q3IbQvLC3k71YVwtZVQ+/4CGQCeOr/22fl5l+Ug5da3AR1i7gx/0p7eY8qX0KU
	 lE45Kv2ZkjRN3CdyKzI6CiovFtPx0U9ncIXK1msk=
Date: Wed, 17 Apr 2024 09:04:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] r8169: fix LED-related deadlock on module removal
Message-ID: <2024041709-prorate-swifter-523d@gregkh>
References: <ded9d793-83f8-4f11-87d9-a218d10c2981@gmail.com>
 <20240416193458.1e2c799d@kernel.org>
 <4b0495fd-fab5-4341-9b06-2f48613ee921@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b0495fd-fab5-4341-9b06-2f48613ee921@gmail.com>

On Wed, Apr 17, 2024 at 08:02:31AM +0200, Heiner Kallweit wrote:
> On 17.04.2024 04:34, Jakub Kicinski wrote:
> > On Mon, 15 Apr 2024 13:57:17 +0200 Heiner Kallweit wrote:
> >> Binding devm_led_classdev_register() to the netdev is problematic
> >> because on module removal we get a RTNL-related deadlock. Fix this
> >> by avoiding the device-managed LED functions.
> >>
> >> Note: We can safely call led_classdev_unregister() for a LED even
> >> if registering it failed, because led_classdev_unregister() detects
> >> this and is a no-op in this case.
> >>
> >> Fixes: 18764b883e15 ("r8169: add support for LED's on RTL8168/RTL8101")
> >> Cc: <stable@vger.kernel.org> # 6.8.x
> >> Reported-by: Lukas Wunner <lukas@wunner.de>
> >> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> > 
> > Looks like I already applied one chunk of this as commit 97e176fcbbf3
> > ("r8169: add missing conditional compiling for call to r8169_remove_leds")
> > Is it worth throwing that in as a Fixes tag?
> 
> This is a version of the fix modified to apply on 6.8.

That was not obvious at all :(

> It's not supposed to be applied on net / net-next.
> Should I have sent it to stable@vger.kernel.org only?

Why woudlu a commit only be relevent for older kernels and not the
latest one?

thanks,

greg k-h

