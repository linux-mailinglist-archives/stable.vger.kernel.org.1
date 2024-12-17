Return-Path: <stable+bounces-104458-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9B39F4618
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 09:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC8BD165565
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 08:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965B01DBB24;
	Tue, 17 Dec 2024 08:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rwyHU1Fv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51089156227;
	Tue, 17 Dec 2024 08:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734424280; cv=none; b=NvFKQ+J8fhFgQaWIbiT3iMdstPb5hY3jis/Vghqu+9JcE9tD1ygBQ8I55Qo+tf5S4fdCeIWCGZsqAqyV3A3Ca+JAQfRdkdUwkj6Rckewfj8msxNbXW6OEFbM753388bxAS2ALToWy72zNZw7+tVAUxm15vxHnUQNS591pW9Ehvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734424280; c=relaxed/simple;
	bh=RxWIwAuyfljwVTWA+mFDK3kTAPH9OHez4pe2+qHvX/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5TlOOE5R2uTiA4r1fJBTtIMC55KyRw7CdPuFmlSpxxu8sQhCjpSm7n0XGLDkOQ6JZKE2+A2BAoCpcvtF7oshEURLBUHn+mJBeKR0wcyCbedtnukf1foELWEaG4F69BtQz16yX1iQ9+JtLedkzf2Ds97dFnIgbn1dSfinhR5Z/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rwyHU1Fv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CF0C4CED3;
	Tue, 17 Dec 2024 08:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734424279;
	bh=RxWIwAuyfljwVTWA+mFDK3kTAPH9OHez4pe2+qHvX/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rwyHU1FvDDPr32ifb6OaOdsV4T1Vw0X+KLLt8hUWkEcqhEQoXjijDrXvPMgVQN2hp
	 ONVcWSXuxH6sLi9zvGi2tJzgx9/HrOVPksswBO7UKwA5ZaTJ/N7guIuFphQYO+LgRw
	 56lTHaGy2ZArX2mpKA7WaA+LaGPSbCAmxcNN2GSE=
Date: Tue, 17 Dec 2024 09:31:16 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	masahiroy@kernel.org, Matthias Maennich <maennich@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Federico Vaga <federico.vaga@vaga.pv.it>,
	Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Kristen Accardi <kristen.c.accardi@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	William Breathitt Gray <wbg@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Patch "module: Convert default symbol namespace to string
 literal" has been added to the 6.12-stable tree
Message-ID: <2024121705-krypton-preformed-d7a5@gregkh>
References: <20241215165452.418957-1-sashal@kernel.org>
 <Z19E7xNsk6IMUvp3@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z19E7xNsk6IMUvp3@smile.fi.intel.com>

On Sun, Dec 15, 2024 at 11:06:55PM +0200, Andy Shevchenko wrote:
> On Sun, Dec 15, 2024 at 11:54:50AM -0500, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     module: Convert default symbol namespace to string literal
> > 
> > to the 6.12-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      module-convert-default-symbol-namespace-to-string-li.patch
> > and it can be found in the queue-6.12 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> IIUC if you take this one, you would want to take more that are fixing
> documentation generation and other noticed regressions.

I've dropped this now, it wasn't needed.

thanks
greg k-h

