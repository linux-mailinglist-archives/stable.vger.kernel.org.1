Return-Path: <stable+bounces-158511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16211AE7ADF
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 10:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B90BD18839AF
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 08:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C320327991E;
	Wed, 25 Jun 2025 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaKLbpx9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF08272812;
	Wed, 25 Jun 2025 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750841528; cv=none; b=EhD5G7G95Xg7dyR8bOYprDMc+bVOdo811FOF7J8BgrVbymUA7tE6/tdwCNmZ72D8/tpZVsEDSmXr5bh+5YDqta+AnkmgFY4XRKO2SGF9KH12rNjyWc+vK+7nHorPo4uPi+5tJK2Uaf5TCn4RMqgA36sfOz6jhn4jiDG6msx4EQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750841528; c=relaxed/simple;
	bh=M1EaWqs7ZEJIPNmfIYJ8HPYPuf1hmnmjEWwJ3k3bSeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqeIe9GOdm1e3ETHecYWabyEkiC1HKh9X9q1Lr5WNCol6WVBRScz0TZvCUyin3qwDxAI18YKd8uWLfMy2nbbSmc86JOoul3WceP2KmSXh7TuLvCO3ouw86zNwf+ibIT+nTV3eE3G5Ydyz3fjjD51eCnuvy3gmx3GEH89dpnphMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jaKLbpx9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD4EC4CEEA;
	Wed, 25 Jun 2025 08:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750841528;
	bh=M1EaWqs7ZEJIPNmfIYJ8HPYPuf1hmnmjEWwJ3k3bSeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jaKLbpx9drFPneXP/+DWu2J9m6SA4uhxmY3zOHlV6ycdpaDiKOCCVv4j0u9NFQb3P
	 XFGmIt/1Hh/95o5mO75zIa8O6fNtE/NQ26ZA/LBSla1Le1K27FEbMC1e3Z6rqd6Zum
	 yS12/5BvaCnw+7I9NbhHvFovvkkRny5I4cymWcSCYHKwGhAAnxvfwvm6da0nmttjVc
	 QnblRwoI4Q3l2yUDbplIV767MEDnlPSgxhdIRjbVmhz5TBYS1YVxS56P+AKrOINkP2
	 yzRTH05NvoM9VXqwbf3vheHXiy3LHRwkXSZV3YHJzxnnU0gOPheY5rckH0JJzEHvmS
	 UCdHNsW0jDtbA==
Date: Wed, 25 Jun 2025 10:52:04 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Andy Yang <andyybtc79@gmail.com>
Cc: Hans de Goede <hansg@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	dlemoal@kernel.org
Subject: Re: [PATCH v2] ata: ahci: Use correct DMI identifier for
 ASUSPRO-D840SA LPM quirk
Message-ID: <aFu4tO4Wk1CyeJ9h@ryzen>
References: <20250624074029.963028-2-cassel@kernel.org>
 <78c03f67-7677-430b-8c47-c1338797ff0d@kernel.org>
 <CAGEiHrCWnC9BDi3DFDiAnoJxB_pFJpv-vcRU9jTmwb3Pxsg_Hw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGEiHrCWnC9BDi3DFDiAnoJxB_pFJpv-vcRU9jTmwb3Pxsg_Hw@mail.gmail.com>

On Wed, Jun 25, 2025 at 06:29:58AM +0000, Andy Yang wrote:
> On Tuesday, June 24, 2025, Damien Le Moal <dlemoal@kernel.org> wrote:
> > On 6/24/25 4:40 PM, Niklas Cassel wrote:
> >> ASUS store the board name in DMI_PRODUCT_NAME rather than
> >> DMI_PRODUCT_VERSION. (Apparently it is only Lenovo that stores the
> >> model-name in DMI_PRODUCT_VERSION.)
> >>
> >> Use the correct DMI identifier, DMI_PRODUCT_NAME, to match the
> >> ASUSPRO-D840SA board, such that the quirk actually gets applied.
> >>
> >> Cc: stable@vger.kernel.org
> >> Reported-by: Andy Yang <andyybtc79@gmail.com>
> >> Closes: https://lore.kernel.org/linux-ide/aFb3wXAwJSSJUB7o@ryzen/
> >> Fixes: b5acc3628898 ("ata: ahci: Disallow LPM for ASUSPRO-D840SA
> motherboard")
> >> Reviewed-by: Hans de Goede <hansg@kernel.org>
> >> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> >
> > Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> >
> >
> > --
> > Damien Le Moal
> > Western Digital Research
> >
> 
> LGTM. This patch is tested work correctly.

Thank you, I will add your Tested-by tag.


> 
> Again, not sure if its model specific or motherboard specific, if its
> consider motherboard specific we should use (DMI_BOARD_NAME, D840MB)
> instead to match the board.

I don't know if it is model specific or motherboard specific.

Considering how bad this bug is (causing artifacts on the iGPU),
I guess we should hope that it is only the BIOS for your system,
and not for all D840MB boards.

So personally, I would go with the narrowest possible match (which
this patch currently does).

But, I would not be surprised if they actually managed to mess this
up for all boards. But until someone else reports the same problem,
I guess we should give them the benefit of the doubt.


Kind regards,
Niklas

