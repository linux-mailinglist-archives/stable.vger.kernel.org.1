Return-Path: <stable+bounces-154744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA6EADFF1F
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 09:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 437433ABB14
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 07:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E19D22D79F;
	Thu, 19 Jun 2025 07:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duY+R24O"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1AC230BF2
	for <stable@vger.kernel.org>; Thu, 19 Jun 2025 07:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750319441; cv=none; b=P7tbUAzHjhkVZ8BiFDGAJ2a1jQRPK22y3eFRoJjt9LKXUcDdJRW5OXhJoGdO3Yx+nEe+rlk+HWuthwlwfyCMuxGUblR9EgUeVmYeAqTUCVSWv0tlhsPs9zmRSZECdNWIEs3HCeg8kydEcYl5YrCmlPWDm3sH+mZ3ibu+CaWYwo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750319441; c=relaxed/simple;
	bh=gq5eDXOTnkSJzD3MGEoM1mzFkjXA3EdT8EWxfNUexmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8EPAYzMjWlQFwsDb7pSXRkYkePjXdeToCBqeZsnI4gKvu3ytNGP12XVKVka01rUI8vcxQDiM9dMtEchpmQDAwm89s4C+X/9jNKG9hIvNUE29i0Lu8eGeccKEV+QjdsKL5UIE2vnkzX9v+Sej4Uo641pZzNx4csC3Ooelg8eI4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duY+R24O; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6097d144923so983634a12.1
        for <stable@vger.kernel.org>; Thu, 19 Jun 2025 00:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750319438; x=1750924238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FfRJBeVSCQ45B7cfuHD53KdrQZJh4p4JHS2sfk8xrRU=;
        b=duY+R24OZQB2xcXtW90g0DAzGql2KDc2eoB4Lkepo4seyB+Zg6933NyMoIZPQJ3TiI
         KrCaePwtnQTdU5rIGmU9VN6Ts9MBiC9xQkGK8HSoTyw+mkP1HKwetJK9zpfe/dNEvKZo
         oo25U/JALzzoM7kJLbWmAUW4LHWbZU/tIBqKHdgbS4m0dr3vJB85ly1zl6WYJnK2bj2D
         /HJs7+cLK+x5SIBO2mzpP0/PuuCHEaMLJp916kSR3IIal+e66TjQJLtX2YrC2P6lsC73
         wl7UZBnt90reifDaNsvDYHdSNL9byVfi9oQ7MeP5DlBZlbJuwtv6RVVOk2iujdjhiJ/t
         Isag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750319438; x=1750924238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FfRJBeVSCQ45B7cfuHD53KdrQZJh4p4JHS2sfk8xrRU=;
        b=LG/ZrqAZXCYDHXginU0w7SNOSbnsVHBJvuG0edTxOr6vm4H62PPletJsr8GrJhW/u8
         9XUEMIQrMdfyDc7O8lnVFLfXtbyuAiMP00ipjjsxtuC07bJ1ZsZXmWLiQ0No1pARK39N
         bUb599iR29PH3G/P6PiIt+iaZNxkSyJVXpwnykKtxr/2G+BjPwcgDSkIy4TM1ZimR5ks
         Mr4lTqnKmajvz0kSkRP/c5RKwr9WJFjG5K7+sMIsV0QezywViyGzHTpO794tJjqZUjVz
         gQX6jl0B3kDYQZVkWKpojpdjmQOBAjs073/6TTfn1ZusU/rvaHIz+SACyxFUiYjNOv0x
         z8ww==
X-Gm-Message-State: AOJu0YyshM0Bda/2njGy1Lmhqc2xizfrnwzKTnkTpePy8J4Z/YMyC+9r
	g09LZuAj+RKXpKh3tu33EKZWd30xMysfqxE91QNlhUAympd2b92D46fk
X-Gm-Gg: ASbGncuLO5ZMpvUZwKr8HHFi2NBVajFWQAxTyu+gBMXgDNaVtOWtrZqXwQpPsbFeS4u
	qLY7SmfTN6jO+fKvoRvcE/vWec+5XlWS8XtuXsK+50NrJOK4VGN7lkfz4EADAaWCc9gaO5uw308
	tsvd9JX6py/nkGQMWUspMjXLOPC127ZaabqFWRDVLBV6EpimAk70ZQaYqER4C9zqi5zLashxyjb
	eAhvUCzrudr3JzJmEUpkCXsN8XjuUy985LC+dVetMAsQU+S6u9jaPJNzvFPjm1qEF2wwqa1VDAD
	CKgP7e6wAB/lLHMulLEzJCQ6oOm2EmuKIyR3hpW4VSVs5bebhLYarrujnpc=
X-Google-Smtp-Source: AGHT+IHgjfrbbxOvJ9sWlAlCmW0tX2gmZ6K9b6h6wOrrFiX3PrgTJ/1ROFNYKmY3yy7i+yS8s7dH4g==
X-Received: by 2002:a05:6402:13c9:b0:601:470b:6d47 with SMTP id 4fb4d7f45d1cf-609e3fb75f7mr1867518a12.1.1750319437397;
        Thu, 19 Jun 2025 00:50:37 -0700 (PDT)
Received: from Tunnel ([173.38.220.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-609b8b941bbsm2741987a12.34.2025.06.19.00.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 00:50:36 -0700 (PDT)
Date: Thu, 19 Jun 2025 09:50:34 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 257/356] net: Fix checksum update for ILA
 adj-transport
Message-ID: <aFPBSlRDsNv4ZT2l@Tunnel>
References: <20250617152338.212798615@linuxfoundation.org>
 <20250617152348.550981340@linuxfoundation.org>
 <aFLv9Ea6Sh2eXjed@Tunnel>
 <2025061915-uninstall-subtotal-23a7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025061915-uninstall-subtotal-23a7@gregkh>

On Thu, Jun 19, 2025 at 06:22:39AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jun 18, 2025 at 06:57:24PM +0200, Paul Chaignon wrote:
> > On Tue, Jun 17, 2025 at 05:26:12PM +0200, Greg Kroah-Hartman wrote:
> > > 6.6-stable review patch.  If anyone has any objections, please let me know.
> > 
> > Not an objection per se, but I've sent the same backport at
> > https://lore.kernel.org/stable/6520b247c2d367849f41689f71961e9741b1b7eb.1750168920.git.paul.chaignon@gmail.com/
> > The only difference is that I also backported the second patch in the
> > series, which had a conflict. The backported patchset should apply on
> > 6.1, 6.6, and 6.12. I hope that was the correct way to proceed :)
> 
> Ah, that is nicer, I'll drop this and then queue those up for the next
> round of stable releases, thanks!

Great, thanks! There's the same for the 6.12 round of course:
https://lore.kernel.org/stable/20250617152434.326263517@linuxfoundation.org/
The 6.15 round does have both patches from the series.

> 
> greg k-h

