Return-Path: <stable+bounces-38055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7036A8A0995
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 09:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F84D1C21730
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 07:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0137313DDC3;
	Thu, 11 Apr 2024 07:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="G0LLsOuD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S+5dC8Yg"
X-Original-To: stable@vger.kernel.org
Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BD92032C;
	Thu, 11 Apr 2024 07:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712820183; cv=none; b=qAkEks+JYTHNs+/PTIveeNftgdKShk0QIsB36f/YYTIuWsvE6pIgmpVJeRzVHafYQ+zcYuN+eApUnMlD77WLV0qVprjLDFfat2dg4ZcdKwaE+VerEaXuidUhBOGS3JCPiShzsKcn5HiBr03+bcuKNgmqR8Sjt9ZimpJtc6vOWZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712820183; c=relaxed/simple;
	bh=FekxP3XMMWUEe+1OnUrmm6zzOpSUJAc8ES8FUyDH8dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVm/Dm6O1FmkVmHk5w0yL4WW6ou4fogqC7sb9Knl3LyegsP6OzzO9Ok/XK0jKzI1+bhK7ZWn5G+UugyiAxqurXy5mAL1yrKD/gGti9V/hdhgvwxqYP8L1XxWecHsQVk6QANs5KHFh0qEGJ7e5ArWDSZhJMxfZgtRKrQBULc6g6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=G0LLsOuD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S+5dC8Yg; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id C82F01C00122;
	Thu, 11 Apr 2024 03:22:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 11 Apr 2024 03:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712820178; x=1712906578; bh=qfRKm/pzZH
	kDyMFo8j/aZK+Y6GwYgeAsxHcjxxaIFlE=; b=G0LLsOuDNJeTEQko/CtLlU1SWP
	fukbnwdmUdGRNeNNiVz7oqBfBpP7clezufU4VZG7GKGPhbF0JoCT/CNnAkdQ6Ndl
	97SOTKeYRklUYKyoMPWyjS1g++8ezNoNr+Wb2F8Zd30158j1lzh14MOKWuyChDjY
	BHAJAZkqjT9QWW+P2uMvvyrQgxiWIdQPaNI/xsNBx3lazPOxNa+fdT1NexbtSS2v
	7NdYx0AqKslEiQk7kiqbZXmeIEQGLXrW+/6OgwsbdlSFwPSQXp+jNo7qj1Jqc/CV
	DFjeaU18OFMTvx0j0Xp8QMA1OupdTz2z/myBWDosbsxNpJDqS8a16E00V/qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712820178; x=1712906578; bh=qfRKm/pzZHkDyMFo8j/aZK+Y6GwY
	geAsxHcjxxaIFlE=; b=S+5dC8YgjMdw/s50TGLUcMA1SdVEp9Ki2BEHST7W0JR2
	6vBJvMPJ7+his4dOqAuIf371ehJ6iKf1IYtKuSVhSYGWSqM4foM6w5slyvDcBlBw
	xdoMNzEggbERb37uCclsyAyIU1JjRbwT/ds6Q+9yqpO6Zr7IRphkvrp/aDIwoMOi
	b15N+h1YuoN4y8g39AaNEm40zwVa63yqKNq9oz5//OtL+++KF8GEwppwnBs+xRDy
	wG0qB2icSDxI7z0R9mSF319c/WeQFNlTOSK7s7bbU8W0RzFUacDyZNwrYrJqiG1A
	4dbxc96qJ7EqoOeer6t8YK6ozclkt8mmyzLtYYdy2A==
X-ME-Sender: <xms:0o8XZnpCoK8aoTO_9fvBxFcxSAQELbJ735NJI0EL7oVPJTTT5-cb_w>
    <xme:0o8XZhoGZB_eGZs_RthHBMqSZrP-NQsCCVc5SUbifvg4zuglnGiHHm3Ane_cmA7uU
    9L-vPp4BjI77Q>
X-ME-Received: <xmr:0o8XZkNNal6izYRRwPxVnnkIeYkFXZQwrcze2-L4wy2B_KX75zAlKvXTtjox-9UWuJ_2q2JFOiZNp8g6GCtm7BRLHQR9NCF2QB4MbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehjedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeekje
    ejtdeutdejuedvleeggeevveehieegudefueektdevieetuddtgfegueegveenucffohhm
    rghinhepughtshdrnhhofienucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:0o8XZq6DVE2ah2uLwijcVZW6OsooLvEXdMfop7CM1H3b0zDr1TGjBQ>
    <xmx:0o8XZm4p9l-nFJQNjG6sm1oIN1LfIuOkKaMpiZei0roq5iRnnr_Inw>
    <xmx:0o8XZigUVxvF9Z75VLaZt9ufJmH0fP8X1zk6RFjpfc2wwBNbUxC0cg>
    <xmx:0o8XZo4WrZf1wNxIBaHISy6z7lm3-rw0e9bbVP9lrOL5_LYnC09Vtw>
    <xmx:0o8XZs5KoKwypOJkgNHcQ6X6zc-YbCz8UsUDz8FBak3ZdJgSYBGgny2v>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Apr 2024 03:22:57 -0400 (EDT)
Date: Thu, 11 Apr 2024 09:22:54 +0200
From: Greg KH <greg@kroah.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, stable@vger.kernel.org,
	stable-commits@vger.kernel.org, buddyjojo06@outlook.com,
	Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: Patch "arm64: dts: qcom: Add support for Xiaomi Redmi Note 9S"
 has been added to the 6.8-stable tree
Message-ID: <2024041132-heaviness-jasmine-d2d5@gregkh>
References: <20240410155728.1729320-1-sashal@kernel.org>
 <e06402a9-584f-4f0c-a61e-d415a8b0c441@linaro.org>
 <2024041016-scope-unfair-2b6a@gregkh>
 <addf37ca-f495-4531-86af-6baf1f3709c3@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <addf37ca-f495-4531-86af-6baf1f3709c3@linaro.org>

On Wed, Apr 10, 2024 at 08:24:49PM +0200, Krzysztof Kozlowski wrote:
> On 10/04/2024 20:02, Greg KH wrote:
> > On Wed, Apr 10, 2024 at 07:58:40PM +0200, Konrad Dybcio wrote:
> >>
> >>
> >> On 4/10/24 17:57, Sasha Levin wrote:
> >>> This is a note to let you know that I've just added the patch titled
> >>>
> >>>      arm64: dts: qcom: Add support for Xiaomi Redmi Note 9S
> >>
> >> autosel has been reeaaaaaly going over the top lately, particularly
> >> with dts patches.. I'm not sure adding support for a device is
> >> something that should go to stable
> > 
> > Simple device ids and quirks have always been stable material.
> >
> 
> That's true, but maybe DTS should have an exception. I guess you think
> this is trivial device ID, because the patch contents is small. But it
> is or it can be misleading. The patch adds new small DTS file which
> includes another file:
> 
> 	#include "sm7125-xiaomi-common.dtsi"
> 
> Which includes another 7 files:
> 
> 	#include <dt-bindings/arm/qcom,ids.h>
> 	#include <dt-bindings/firmware/qcom,scm.h>
> 	#include <dt-bindings/gpio/gpio.h>
> 	#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> 	#include "sm7125.dtsi"
> 	#include "pm6150.dtsi"
> 	#include "pm6150l.dtsi"
> 
> Out of which last three are likely to be changing as well.
> 
> This means that following workflow is reasonable and likely:
> 1. Add sm7125.dtsi (or pm6150.dtsi or pm6150l.dtsi)
> 2. Add some sm7125 board (out of scope here).
> 3. Release new kernel, e.g. v6.7.
> 4. Make more changes to sm7125.dtsi
> 5. The patch discussed here, so one adding sm7125-xiaomi-curtana.dts.
> 
> Now if you backport only (5) above, without (4), it won't work. Might
> compile, might not. Even if it compiles, might not work.
> 
> The step (4) here might be small, but might be big as well.

Fair enough.  So should we drop this change?

thanks,

greg k-h

