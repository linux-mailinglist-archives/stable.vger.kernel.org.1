Return-Path: <stable+bounces-176863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A71B3E67A
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 16:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDAD03A7F2B
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 14:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DD733CEB8;
	Mon,  1 Sep 2025 13:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RKtWmC8Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EA333A02C
	for <stable@vger.kernel.org>; Mon,  1 Sep 2025 13:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756735146; cv=none; b=QwN94KNFhVMzZy9hmpHIeHmq/RP5UELdRKtJm/FxlpaFUU0Gs7qDQVF7Y2+Th1CxtGDeDxb6I4sJzJADAYZZSJwMHPdT2DV4tWdBhI4seM+lzSPmmj4DhgnTFdXNdZec7InBprI3LzHzrfCbcjqXJar8LutTDqehqpgqX+r9An0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756735146; c=relaxed/simple;
	bh=j1vTDPHEWWtT+oOGS82VbJ7GcK+83wdm3fzFj1JQQcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tx9CGm/D1WzFCRdxah5EWpW19hR0gsVpZgT3MfXCw4izVjWKrCABv71klY5oQwxVu2NT4kN3TNh1J4ebfzG74id9Lwk/mQ4Cm9IqyE66ecuJ4i3zxA4NE5HFZQPEZbKQfsvztqIy5uaQi1mUQ7uANsok1qQcA9bImj4Ypob3zRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RKtWmC8Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5EA9C4CEF0;
	Mon,  1 Sep 2025 13:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756735146;
	bh=j1vTDPHEWWtT+oOGS82VbJ7GcK+83wdm3fzFj1JQQcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RKtWmC8ZPkmHtyFKn6RKxn6zEetYLy2MUpsHD4md0InxCOMezUAQ1lrc3Dp0vcRhV
	 EyDcuygtwuKUjA1HO4ProuASlssl/godN43qoBSArTXYobe/OrRKUVeWtz4HfU7PDh
	 DY1b4jKMo+qQ2rt7ceO4jvu9JzkeV8Y9znkg+8Hw=
Date: Mon, 1 Sep 2025 15:59:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH linux-5.10.y 1/5] ASoC: Intel: bxt_da7219_max98357a:
 shrink platform_id below 20 characters
Message-ID: <2025090144-cosponsor-skilled-0d8f@gregkh>
References: <2025082909-plutonium-freestyle-5283@gregkh>
 <20250901095440.39935-1-mgorny@gentoo.org>
 <2025090101-exert-deceased-3071@gregkh>
 <6369adc8dee031617e5561e56b6e48c5edbe1f03.camel@gentoo.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6369adc8dee031617e5561e56b6e48c5edbe1f03.camel@gentoo.org>

On Mon, Sep 01, 2025 at 03:55:29PM +0200, Michał Górny wrote:
> On Mon, 2025-09-01 at 15:25 +0200, Greg KH wrote:
> > On Mon, Sep 01, 2025 at 11:54:36AM +0200, Michał Górny wrote:
> > > From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > 
> > > commit 24e46fb811e991f56d5694b10ae7ceb8d2b8c846 upstream.
> > > 
> > > The excessive platform id lengths are causing out-of-buffer reads
> > > in depmod, e.g.:
> > > 
> > > depmod: FATAL: Module index: bad character '�'=0x80 - only 7-bit ASCII is supported:
> > > platform:jsl_rt5682_max98360ax�
> > > 
> > > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > Link: https://lore.kernel.org/r/20210511213707.32958-5-pierre-louis.bossart@linux.intel.com
> > > Signed-off-by: Mark Brown <broonie@kernel.org>
> > > Signed-off-by: Michał Górny <mgorny@gentoo.org>
> > 
> > This commit text does not match the upstream commit text at all :(
> > 
> > Same for others in this series, please fix.
> 
> I'm sorry, I've misread the instructions as telling me to describe why I
> believe this deserves to be backported.  It would be really helpful if
> they linked to some good examples.  Should I also keep the original
> Reviewed-by lines?

Yes, keep the original stuff, and if you need extra justification, put
that in a 0/X email header.

thanks,

greg k-h

