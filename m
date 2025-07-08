Return-Path: <stable+bounces-160517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 182D1AFCF51
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 17:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC1B656736B
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 15:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D702DAFCE;
	Tue,  8 Jul 2025 15:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="nmqEZTF/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OObDc50Q"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4032E1C58;
	Tue,  8 Jul 2025 15:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751988813; cv=none; b=otbepMoz8eTEXeNWvgoWOE4NcigW8p16ci/prY93yjY0pz933sjS6qY9RpbrpHLYd6A5dxh6PaS597tdZXz0YqyqHxgJ2gFKJtTR5Z82P1IXuOL9kTpmfOsCNBQVLiG3bzRrOwhsJaepMNnIiZ7EU8C2ALV+kmhWbCnub0cVonk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751988813; c=relaxed/simple;
	bh=fpBPFDD4tKpz6ocn/tb8xoYBxYo6yO7grjXcPIJqDjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLwfhnrB+IY19roJTmuAPNgJXMMJt3xaIa7tWfwYtobnDq3gfT29Jc6q0Nlog6dceRaZ21hj3S9+NemevdNi1wbLLdkF/hU3K5xvo0amSQR5hXwg3Pt8r5svb7ImslIuR7bGFWhv7GB04w18pBITNDl2wnoOF7ainioVfJ1CTDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=nmqEZTF/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OObDc50Q; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F2B3F7A00A5;
	Tue,  8 Jul 2025 11:33:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 08 Jul 2025 11:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751988809; x=1752075209; bh=00kuc6Tun/
	Mdeocn4SukWyNJ3adxHVFCwUQHgORSuDU=; b=nmqEZTF/r1Ld592JTIW78I5ebe
	26WEK/Ucq7UeL70blYm0u2sZEc2SMZgUpJt7ifw6uicEsO77wUdWF1/Nsk+zgTo6
	EPXM61Fs+M+UMLW62tDQXtf6xfetrwKavwcT6KUzw399QgB1fVog+WRBZdK7t8qj
	mU1fdACkdWnplhZbtg/TrSAKcICRqJDcZABqTStrDMyjj/cJTWBHJVOOuqnt167X
	lG+ZnNfk5pAyEF53YZXQXsNn5bIyEYq3g9fAJkEocQlUg20J+ayji6I4Zz9ZX+Pg
	0UVYyjMkGx/CapsTW9Yvlb51cbJftwAVKYE+RX6WNNPXaNdULzAK6j9orMjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751988809; x=1752075209; bh=00kuc6Tun/Mdeocn4SukWyNJ3adxHVFCwUQ
	HgORSuDU=; b=OObDc50Qmy7W999e4908/6po5c3sVORRH1R/E1kVUtAWfxt+Z+7
	M5LGZm7xkOrRAalXPxWSOREvY1gdWYRkO/4bzt8SAN9lWH0GKLlpQRu6+hj1KbZ5
	H2XDmxDa2XP2eHjg+8zDH19q1axCw1ifv8YBOHEwr55ew3hH8GKDmwdfBsCxvEnb
	K9Ifp9985oCxyWrbgYCDaOzpGwGUvk+Y2Vzhc+adHDRoQ3fBifwBD4W5OZ4Ly3+J
	cyejpe7k2rp2PTJIyc4Uy/9eKViOI7VpFgBqDQl7p2uHbSBQP8HCV3874f21735m
	kIvju9a1utfO1umRiswuvXdpq2Q5oKe8dpw==
X-ME-Sender: <xms:SDptaLGqjCJ9OF85P45PFUtByQQUUJ9soo3jDSp5aab4EWmnFmMlFg>
    <xme:SDptaI7ZXEBfPxv-fJw1IxrcR393PLKQj63pVL0rjiGO3eAyonFEcLwYV1-T5-YcS
    mQhwHkU9DzKtg>
X-ME-Received: <xmr:SDptaGBkiN5OhKfgUGxYV1kPFkbv3mhNrRtJI6ydHZ1iShEgdmKFlUIp3vOj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefhedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcumffj
    uceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeegheeuhefgtd
    eluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopedvvddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvggsihhgghgvrhhssehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehsthgrsghlvgdqtghomhhmihhtshesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehjrghsohhnseiigidvtgegrdgtohhmpdhrtghpthhtoheprghr
    uggssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhvghrsggvrhhtsehgohhnughorh
    drrghprghnrgdrohhrghdrrghupdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhf
    thdrnhgvthdprhgtphhtthhopehmrgguugihsehlihhnuhigrdhisghmrdgtohhmpdhrtg
    hpthhtohepmhhpvgesvghllhgvrhhmrghnrdhiugdrrghu
X-ME-Proxy: <xmx:SDptaDRJCzthlDxH_D58O_otia-1o9gr-t7nAjVTRxm0WexwOu6rbw>
    <xmx:SDptaGd-3260jvs9uI6yiKlWiBo9WcPA7Af4GKFtMMDm8Z2uP7d-ew>
    <xmx:SDptaMQMrNZNXdFf9MTE4apCg5CBhZ8sWorGVCNLyLsVNwlnvgjwoA>
    <xmx:SDptaC192BBYOnKugByFKwpbaUQY4I_Tiw5rd-iKbVDklVfKrJIwDQ>
    <xmx:STptaOMywC8LGp7-fSu0ITCvxwx3sDkRWc4Igj9WUShQ4tfZNy5N2I2g>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 11:33:27 -0400 (EDT)
Date: Tue, 8 Jul 2025 17:33:25 +0200
From: Greg KH <greg@kroah.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: Patch "crypto: powerpc/poly1305 - add depends on BROKEN for now"
 has been added to the 6.12-stable tree
Message-ID: <2025070819-drivable-rhyme-eb49@gregkh>
References: <20250707043445.484247-1-sashal@kernel.org>
 <20250707172944.GA3116681@google.com>
 <20250707213740.GB3178810@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707213740.GB3178810@google.com>

On Mon, Jul 07, 2025 at 09:37:40PM +0000, Eric Biggers wrote:
> On Mon, Jul 07, 2025 at 05:29:47PM +0000, Eric Biggers wrote:
> > On Mon, Jul 07, 2025 at 12:34:45AM -0400, Sasha Levin wrote:
> > > This is a note to let you know that I've just added the patch titled
> > > 
> > >     crypto: powerpc/poly1305 - add depends on BROKEN for now
> > > 
> > > to the 6.12-stable tree which can be found at:
> > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > You forgot to Cc the relevant mailing lists.
> > 
> > > diff --git a/arch/powerpc/lib/crypto/Kconfig b/arch/powerpc/lib/crypto/Kconfig
> > > new file mode 100644
> > > index 0000000000000..3f9e1bbd9905b
> > > --- /dev/null
> > > +++ b/arch/powerpc/lib/crypto/Kconfig
> > > @@ -0,0 +1,22 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only
> > > +
> > > +config CRYPTO_CHACHA20_P10
> > > +	tristate
> > > +	depends on PPC64 && CPU_LITTLE_ENDIAN && VSX
> > > +	default CRYPTO_LIB_CHACHA
> > > +	select CRYPTO_LIB_CHACHA_GENERIC
> > > +	select CRYPTO_ARCH_HAVE_LIB_CHACHA
> > > +
> > > +config CRYPTO_POLY1305_P10
> > > +	tristate
> > > +	depends on PPC64 && CPU_LITTLE_ENDIAN && VSX
> > > +	depends on BROKEN # Needs to be fixed to work in softirq context
> > > +	default CRYPTO_LIB_POLY1305
> > > +	select CRYPTO_ARCH_HAVE_LIB_POLY1305
> > > +	select CRYPTO_LIB_POLY1305_GENERIC
> > > +
> > > +config CRYPTO_SHA256_PPC_SPE
> > > +	tristate
> > > +	depends on SPE
> > > +	default CRYPTO_LIB_SHA256
> > > +	select CRYPTO_ARCH_HAVE_LIB_SHA256
> > 
> > Really?
> 
> I see this was already backported correctly for 6.15, so please just
> cherry-pick it from there.

I've dropped it for now, thanks.

greg k-h

