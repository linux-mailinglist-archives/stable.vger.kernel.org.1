Return-Path: <stable+bounces-38059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B778A09E6
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 09:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59435284D22
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 07:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE8913E40C;
	Thu, 11 Apr 2024 07:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="i4SLKJSy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c6PX6CsF"
X-Original-To: stable@vger.kernel.org
Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6410A13E051;
	Thu, 11 Apr 2024 07:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712820889; cv=none; b=lRr3xp/MG28Z5/uxMmiYALvqZMdXHHMTIzsu/PHkIR1v1sEG9ynvquv1BjhQitPFZTcYhqyoXXAIejzgnsBgGYc+UzYiLnYHJ1duCIXasZWdwaX3jZDeg1Vicq2TS1hysh2FP9nwYBS1e27q7nM8xmgZTMWTsgDBk+PoivEovCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712820889; c=relaxed/simple;
	bh=FCIlykqS4nGQUWYzHKa1BQ22c1g7YOdrq4g3QJ1CV3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUyHALnXsm+a1gnD1haYfP8rc262zLgmrjC0siLjYyXH6ll0rC0dfNDsN3RpAU0PCQ1NXruiLpDb82Vmmeu3rockl7LBQ7RqEJ5zuCT/h/dO4k+nKDs9iP3j/zZUuehgA/PprFBsrepVnMk9eRDsj8PfoQM0l0AfcWoVSgWTk+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=i4SLKJSy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c6PX6CsF; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id B357D1800073;
	Thu, 11 Apr 2024 03:34:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 11 Apr 2024 03:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712820882; x=1712907282; bh=4e17aZLxCZ
	/xmK6TqYtTj729Icc/M1cb6AfMgwOtJCA=; b=i4SLKJSyFXYxRX8ruMU5R8pM0Y
	Rr+BOCWRWXLEhQT1K9Cs7uaJ2bLe1PqfxVxIkrOPR5ogAYAZHdOFpgIG9LpAuVJ3
	h0zcczGQh8FqJj1EOJshLarSCTrF6WvC3B4p9SZtUHtmgkkQHfj+5LUPohcBPPtL
	uEjl2wYjlLaPppEQTy7S+3b2bh4JI54rU/3nLNgxOBOj9dxSM/PVktCwkHVwb3ox
	xDo3mYn1EcPWyAlzriXBZZmhIjGwVlX8TqLLd7PBgpNTXLkr5olYbUA76sQEkErA
	puyxDcr6Xa6VGtAWP8LbSEN/2PFgvsi+CDKmGBA+XiyMNQU2pkZseKXXOqNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712820882; x=1712907282; bh=4e17aZLxCZ/xmK6TqYtTj729Icc/
	M1cb6AfMgwOtJCA=; b=c6PX6CsFIgWxAwy0oNMI/az7N4racBVWkZ2sEWMg8HZt
	1YPs6C+0LohVlfwgjb7K95wsjuHQwLl6sS3LoOXDDK0vmQ2bMlPkvcbhfFZJ4Kk1
	8opTkn/P9ZR2uz+L4US8z3Z1pZ9Zf8F5AhEcskPX4+Rfi+013SaQTyRfCCDtCtJn
	dm254cZ8Vymx3lxpLKJajkrwJAvRkxqmdc+JSlBIUhwu643lf+xpdJMGFveO8FKt
	nh3mvc+4hsqetQvPBnzbNfTFitYoTFUC+numCY7jTPCvpN9LM1K671bRljCX39aa
	Nb8uFnf+HPw7PNP5zEWsZu7NjdZYB2jHqdksF2JPTA==
X-ME-Sender: <xms:kpIXZkYZBZAwT_mFTt8Qbzo8wNvIU8ngw2DsfK6k3OdMeSLvZXxk5w>
    <xme:kpIXZvbCXi8srNjTZ1h0qTlmxEcww1wR7Bg__2Dy28FmEmJUGTPHOXXNkLnEO0ct2
    Yo3fqvBdFaPqw>
X-ME-Received: <xmr:kpIXZu9eqlTOkQc-aTbLGZdpxrPQpAozlFwdZ9wCx7l7QVAbdaGkOWj9aFpnTxn_u95SXw3ZqYIHA4SzmwCfCWuoyWtCz0MWyjWZDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehjedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeekje
    ejtdeutdejuedvleeggeevveehieegudefueektdevieetuddtgfegueegveenucffohhm
    rghinhepughtshdrnhhofienucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:kpIXZuqRDCkr1yiiGU-sN1kHPE7RNB3-on3GZLKlYk8INqnio0q12g>
    <xmx:kpIXZvogbnEgGL-fbi7v-GPCF38iUW8LDsfwBKRp3cPixZpwrOuH_g>
    <xmx:kpIXZsRC4_CwDKAcjrawuVzHp6PjC6quz4YwxuJdT3Lj1iEflsunuw>
    <xmx:kpIXZvoWDbZTWaGSZNjZ73uwIv0H9UgS3rKuuxf4O1WSIHRSWTG1qw>
    <xmx:kpIXZrq_20fZBhzVx79U-UyZq1gSwNDF7qoDML-RopHMuLSmGRJpW59M>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Apr 2024 03:34:41 -0400 (EDT)
Date: Thu, 11 Apr 2024 09:34:39 +0200
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
Message-ID: <2024041112-shank-winking-0b54@gregkh>
References: <20240410155728.1729320-1-sashal@kernel.org>
 <e06402a9-584f-4f0c-a61e-d415a8b0c441@linaro.org>
 <2024041016-scope-unfair-2b6a@gregkh>
 <addf37ca-f495-4531-86af-6baf1f3709c3@linaro.org>
 <2024041132-heaviness-jasmine-d2d5@gregkh>
 <641eb906-4539-4487-9ea4-4f93a9b7e3cc@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <641eb906-4539-4487-9ea4-4f93a9b7e3cc@linaro.org>

On Thu, Apr 11, 2024 at 09:27:28AM +0200, Krzysztof Kozlowski wrote:
> On 11/04/2024 09:22, Greg KH wrote:
> > On Wed, Apr 10, 2024 at 08:24:49PM +0200, Krzysztof Kozlowski wrote:
> >> On 10/04/2024 20:02, Greg KH wrote:
> >>> On Wed, Apr 10, 2024 at 07:58:40PM +0200, Konrad Dybcio wrote:
> >>>>
> >>>>
> >>>> On 4/10/24 17:57, Sasha Levin wrote:
> >>>>> This is a note to let you know that I've just added the patch titled
> >>>>>
> >>>>>      arm64: dts: qcom: Add support for Xiaomi Redmi Note 9S
> >>>>
> >>>> autosel has been reeaaaaaly going over the top lately, particularly
> >>>> with dts patches.. I'm not sure adding support for a device is
> >>>> something that should go to stable
> >>>
> >>> Simple device ids and quirks have always been stable material.
> >>>
> >>
> >> That's true, but maybe DTS should have an exception. I guess you think
> >> this is trivial device ID, because the patch contents is small. But it
> >> is or it can be misleading. The patch adds new small DTS file which
> >> includes another file:
> >>
> >> 	#include "sm7125-xiaomi-common.dtsi"
> >>
> >> Which includes another 7 files:
> >>
> >> 	#include <dt-bindings/arm/qcom,ids.h>
> >> 	#include <dt-bindings/firmware/qcom,scm.h>
> >> 	#include <dt-bindings/gpio/gpio.h>
> >> 	#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> >> 	#include "sm7125.dtsi"
> >> 	#include "pm6150.dtsi"
> >> 	#include "pm6150l.dtsi"
> >>
> >> Out of which last three are likely to be changing as well.
> >>
> >> This means that following workflow is reasonable and likely:
> >> 1. Add sm7125.dtsi (or pm6150.dtsi or pm6150l.dtsi)
> >> 2. Add some sm7125 board (out of scope here).
> >> 3. Release new kernel, e.g. v6.7.
> >> 4. Make more changes to sm7125.dtsi
> >> 5. The patch discussed here, so one adding sm7125-xiaomi-curtana.dts.
> >>
> >> Now if you backport only (5) above, without (4), it won't work. Might
> >> compile, might not. Even if it compiles, might not work.
> >>
> >> The step (4) here might be small, but might be big as well.
> > 
> > Fair enough.  So should we drop this change?
> 
> I vote for dropping. Also, I think such DTS patches should not be picked
> automatically via AUTOSEL. Manual backports or targetted Cc-stable,
> assuming that backporter investigated it, seem ok.

Sasha now dropped this, thanks.

Sasha, want to add dts changes to the AUTOSEL "deny-list"?

thanks,

greg k-h

