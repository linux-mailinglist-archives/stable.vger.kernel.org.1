Return-Path: <stable+bounces-52201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34001908D14
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 16:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34D091C25655
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 14:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19379441;
	Fri, 14 Jun 2024 14:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fPPscUx9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05F37464
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 14:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374476; cv=none; b=KwcgaoHbbi8fOjS2Mc2IwsSFSmZy5ajA3rvqMUQ2ydtjfKuIh3ijMcWRjFGL3m+qUY/WZLwyzi/y8Y+wpLf/2MPVgFkDDQPeT8xBsFmvjeKaTsTHKt3WUqXEXBWbGa7TUJI08JaLdzuTY1uIX9stMX2nr4P/rTmyCZ/0nCLr/Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374476; c=relaxed/simple;
	bh=QvM6AiLxXHwd+MTKu7emfVI/crem08NTejujxmd+2tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2Dm2So/vv5V+JpkuBVWGKx40SPrncypPnN12FpWaYBnn+YdytBqH7gCIbvuzh89/ug+20k0IA0G1pdy0Ae2xO82FcgR57JoD9GBZY56N7GluPJMFto+NPyrXTUYUZiihrvHbZeGjND4HpgBDhXLTeoELtWjiLfdF/wUCocTRw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fPPscUx9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE957C2BD10;
	Fri, 14 Jun 2024 14:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718374476;
	bh=QvM6AiLxXHwd+MTKu7emfVI/crem08NTejujxmd+2tw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fPPscUx9It4zjfO2x/hpJIIwW07iIO9lzkYPQNZrkK/FKpghbgb1zPTE9Cy/KW3/g
	 10lj3mV/v2qjhfco3YDryIYt0P1mFq3hybUoiJ1yRXUtSIgWC6iG7YPMDtlsFTJeWY
	 phSG8GJgRuquZPwUOEXaqZS3GWi/+j4fZ7Qv1ECo=
Date: Fri, 14 Jun 2024 16:14:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i3c@lists.infradead.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] i3c: mipi-i3c-hci: Fix number of DAT/DCT entries for HCI
 versions < 1.1
Message-ID: <2024061426-kilowatt-scorpion-efd4@gregkh>
References: <20240614140208.1100914-1-jarkko.nikula@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614140208.1100914-1-jarkko.nikula@linux.intel.com>

On Fri, Jun 14, 2024 at 05:02:08PM +0300, Jarkko Nikula wrote:
> I was wrong about the TABLE_SIZE field description in the
> commit 0676bfebf576 ("i3c: mipi-i3c-hci: Fix DAT/DCT entry sizes").
> 
> For the MIPI I3C HCI versions 1.0 and earlier the TABLE_SIZE field in
> the registers DAT_SECTION_OFFSET and DCT_SECTION_OFFSET is indeed defined
> in DWORDs and not number of entries like it is defined in later versions.
> 
> Where above fix allowed driver initialization to continue the wrongly
> interpreted TABLE_SIZE field leads variables DAT_entries being twice and
> DCT_entries four times as big as they really are.
> 
> That in turn leads clearing the DAT table over the boundary in the
> dat_v1.c: hci_dat_v1_init().
> 
> So interprete the TABLE_SIZE field in DWORDs for HCI versions < 1.1 and
> fix number of DAT/DCT entries accordingly.
> 
> Fixes: 0676bfebf576 ("i3c: mipi-i3c-hci: Fix DAT/DCT entry sizes")
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
>  drivers/i3c/master/mipi-i3c-hci/core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

