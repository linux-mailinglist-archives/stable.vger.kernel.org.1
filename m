Return-Path: <stable+bounces-200940-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DA8CB9A12
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 20:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 134E53082379
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 19:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5BC3002A7;
	Fri, 12 Dec 2025 19:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="girQEc5o"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C2A23BCFF
	for <stable@vger.kernel.org>; Fri, 12 Dec 2025 19:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765567162; cv=none; b=iQqF2VlGaSP0DcNxZR8HHxkUbXz+e8x74Zy6k7adYK3C345LiSgU366qiycKZ30ypv/zGvb5sO6zpDV072mKyWfHD8p7WRFvs0CrEJsp4y01YVJekGwnWuywRs42IQVbk7umjvj9oaOYpzIlMQzIXNzCCg9OoKwBpPPJjbmAO5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765567162; c=relaxed/simple;
	bh=kAJEIijw1h39dwP0oiHddBkEtMnWkioxlFQC1ujPckI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pIlANrbaA4L5FlNm4sfgYU5Ln819rH+/HeCvijNgT6+EkwobvxJdNzttEcDnhIkIkU7f7iH7Q15hkaxv8B3JMu/oDxNKz+TOlK+MczpVRNyOMPiLcDX7GQy+SJhUsV2H68jnqpLfzcRSDe3dOsT2syHR686a+GiQ/wt40gW+qmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=girQEc5o; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5957ac0efc2so1922504e87.1
        for <stable@vger.kernel.org>; Fri, 12 Dec 2025 11:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765567159; x=1766171959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iAGiWGntUzRzKLCpTz264YmDdwQESuNb3m83qNK0Aw=;
        b=girQEc5oaDZ3Z2HYVKRKS/ne982qU8tOvhRZQUXgHyd3jZ86IHhqplsIpu8of8pWyY
         KoisYprCksA9zHzjfC24l/NVBS+UuGX7FJHuQcDgsrIUyvd38DAwq6ucE45bNbWRk5jS
         uZN8h0gSWzSbwOVa61hw/OCsHByTiZky9coeFj2mVVoQG/5WTNdgcs9AsIkqZ8ruMsi0
         91NUFTqDKYcAZrFlh1S0YaWg9FQKhvU4AKEaw8/rkBB976uBemRQMi1XyDZilzjZrytv
         +tbHKEErrdDlQS1E5McT/CdiDi9hEwB1uCYcuWKvHbjF0tM/dnU9craQAPbVJn2MOuFL
         5tpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765567159; x=1766171959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+iAGiWGntUzRzKLCpTz264YmDdwQESuNb3m83qNK0Aw=;
        b=eY3nMxXrE6KPzwhJLNg7Wkxp49Zt8cRPsNybR23e3fhrbP0l4fsypYNNukbRe7oXgu
         PjgM2YUJSWBUVUKGedz98FSlr83MTO6FGPuQ1uKqZ0nj3Yxc6sgXB94OPPaUXFqQd30V
         SgHCDKKINIomnt4O9RHv6GslPn6PhmtDEGt8RtQ7fclUbClgY27TlANLok4zSxIn22M/
         a8OKIjp6iLIpglryZKnIDXkDOhwEG5KQVLuuM4T1SdwOe9uLWfRP4ohmHez8TVKW3yXn
         z69vTdCxG6unawRBA2Zc8jPoAYZb+BTD/ZYkosWgvzzKbUeYU07CGvrqgKdWVWjnQdvR
         56Ew==
X-Forwarded-Encrypted: i=1; AJvYcCUziITWKY7onFD5xUmID5kErB5XywcUwXJRAIuPm6VUIP5FIJF+mruVPB1WNWpJ/7A4U2Pv3QE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMWw4ZCmooK7xTuBOAH+2P/T2wBCY0Qnix4QOQSTZErVRglFl1
	oskQgZU7GcJan8ORP1egzGXJ/W8pM1aiEg95IcOn7dz9QWorSo3jE9/0gqK+oA==
X-Gm-Gg: AY/fxX6yf3yztIE0Tbc5djHXJFstoxXmMqUtgfkc269wgYuyoUuVjG3GfdvNMobzB9c
	dR46t5HfVFXeAlpTD383/Pih6gcIuRuso2NXsgeG22h0Vba0xUFi4lcH1t00DdrYoxd+j3TRpPC
	ns+GYVlX6w2uVZCcB1tq6ObOny/SRrTJQciUtvi7WplfsV6kb38ezo905pNvuBrzVhgSKhObyv6
	kcHKE3Y/AzKn0vcHzRnYSRmGVoqEhwIgSSX0mslTMDqDgpWCuHSU0aeOdDmuyCyOchcFcThqCB2
	oHXy8BUE5FGnYoriDpWHI1O84TkHCr8HBA8ZiCXH2HotWlMAqPdNAQbpRYwkR69Yyi1ceDUyW9K
	QhvhCHkwHMuXDf5Wl2J0ITHw0aCbqiVqXlYRlmyan59I1kiNZQUNoM1dzKphzpIM4ig5Xz9WFko
	e7fCI6JDaW4A5J0tUqUbDkMoiFyT/1fr1GZFUIbfxJsb4qYUOQVYC0
X-Google-Smtp-Source: AGHT+IE4SzG9SEUo36H+/RajRuGXQKEqi8PEHCvRAZiuCC+tFu11I+7qLmwsFCnbEjl5dXnaqDhnFA==
X-Received: by 2002:a05:600c:4451:b0:477:9fcf:3ff9 with SMTP id 5b1f17b1804b1-47a8f90f54bmr26022385e9.27.1765560968089;
        Fri, 12 Dec 2025 09:36:08 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f7676ffsm43676465e9.4.2025.12.12.09.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 09:36:07 -0800 (PST)
Date: Fri, 12 Dec 2025 17:36:03 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: kernel test robot <lkp@intel.com>, Ilya Krutskih <devsec@tpz.ru>, Andrew
 Lunn <andrew+netdev@lunn.ch>, oe-kbuild-all@lists.linux.dev, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] net: fealnx: fix possible 'card_idx' integer
 overflow in
Message-ID: <20251212173603.46f27e9b@pumpkin>
In-Reply-To: <aTwqqxPgMWG9CqJL@horms.kernel.org>
References: <20251211173035.852756-1-devsec@tpz.ru>
	<202512121907.n3Bzh2zF-lkp@intel.com>
	<aTwqqxPgMWG9CqJL@horms.kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Dec 2025 14:46:03 +0000
Simon Horman <horms@kernel.org> wrote:

> On Fri, Dec 12, 2025 at 07:30:04PM +0800, kernel test robot wrote:
> > Hi Ilya,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > [auto build test WARNING on net-next/main]
> > [also build test WARNING on net/main linus/master v6.18 next-20251212]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Ilya-Krutskih/net-fealnx-fix-possible-card_idx-integer-overflow-in/20251212-013335
> > base:   net-next/main
> > patch link:    https://lore.kernel.org/r/20251211173035.852756-1-devsec%40tpz.ru
> > patch subject: [PATCH v2] net: fealnx: fix possible 'card_idx' integer overflow in
> > config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20251212/202512121907.n3Bzh2zF-lkp@intel.com/config)
> > compiler: alpha-linux-gcc (GCC) 15.1.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251212/202512121907.n3Bzh2zF-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202512121907.n3Bzh2zF-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> >    drivers/net/ethernet/fealnx.c: In function 'fealnx_init_one':  
> > >> drivers/net/ethernet/fealnx.c:496:35: warning: '%d' directive writing between 1 and 11 bytes into a region of size 6 [-Wformat-overflow=]  
> >      496 |         sprintf(boardname, "fealnx%d", card_idx);
> >          |                                   ^~
> >    drivers/net/ethernet/fealnx.c:496:28: note: directive argument in the range [-2147483647, 2147483647]
> >      496 |         sprintf(boardname, "fealnx%d", card_idx);
> >          |                            ^~~~~~~~~~
> >    drivers/net/ethernet/fealnx.c:496:9: note: 'sprintf' output between 8 and 18 bytes into a destination of size 12
> >      496 |         sprintf(boardname, "fealnx%d", card_idx);
> >          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
> 
> Although I think these new warnings are not strictly for problems
> introduced by this patch. They do make me wonder
> if it would be best to cap card_index MAX_UNITS and
> return an error if that limit is exceeded.

The code seems to be written allowing for more than MAX_UNITS 'units'.

Actually it all looks pretty broken to me...
'card_idx' is incremented by every call to fealnx_init_one().
That is the pci_driver.probe() function.
So every card remove and rescan will increment it.
(Is the .probe() even serialised? I can't remember...)

Then there is the MODULE_PARAM_DESC() that states that bit 17 of 'options'
is the 'full duplex' flag, but the code checks 'options & 0x200'.

And I just don't understand the assignment: option = dev->mem_start;

The code was like this when Linux created git.

	David

