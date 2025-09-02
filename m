Return-Path: <stable+bounces-176987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97939B3FD78
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 13:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5C6D201D2D
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 11:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7B02F6560;
	Tue,  2 Sep 2025 11:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="f+cDZYGH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IrDngGkA"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A883D2F6187;
	Tue,  2 Sep 2025 11:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756811515; cv=none; b=aNA6RmtoP4VrvOH1dpbMiygTs8Jtfn1R/DOidDkYXkV8V8EfuYkTddin11AfdHKt5yvha5ea1CQPxy4E0w6MRVOnOXr3/eyNxXoJkrQ36/ovFJAFY8jgeGEOJM5tt0ONC9Z0kA1VFwEvg062DfHmwVgu0ZMEd/fV6wZ4Fqx/kDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756811515; c=relaxed/simple;
	bh=9371xr+9igGoU+qamnZ5p7uYzS+xpz5LsYdTXD0ZRNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQdBxcXfGhjZjmQSqM5S+dQpY5loPUDM4x1uuFVEP5cmcjikc4HYVxTgdnDFJ1a90RZehxIWUrmcPkcnH7431gJi7qSg9+qkpCtYTy1WNH8PmxNfPmEL7LmKtNqGpiaI4mZ15dEqZd7CnvDSDBRFpPvEjCxYOzxYMFjDQjabCYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=f+cDZYGH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IrDngGkA; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0FFF87A041D;
	Tue,  2 Sep 2025 07:11:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 02 Sep 2025 07:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756811510;
	 x=1756897910; bh=m0Jec9/410OJbhXCj3unRKJggRa0OML7F9IZaa4gnEU=; b=
	f+cDZYGHnAUFzqpRhq25p5/7uuR07XmXeWL3mz6ei/5upg2/GndUmIdHjdQhkifZ
	9xVbGpoB86ZSZ2bjITYi4yxuwYJTxeAR0P9TkCWlruYOtL7bI8GT0FIcpuSzlq1M
	JgRAdlMU3US2watUtfgizaPCDgSlymsPpnjTg+7aEPcEFnjA5vPwneL1RyR/qOLQ
	2RHyz1GgUqYFnrBmcgDqDqaPG2bgIERvOrmdqOl+XSQEyosjNyzh8qqndQnLbBG2
	ILyPB60GACbayBtV8DUCYJAwq11n+cqmAzO0/Bd39qROPdGcoFT17xblw8yUq808
	xX6nqWH0ZdVWPHHfzq87mQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756811510; x=
	1756897910; bh=m0Jec9/410OJbhXCj3unRKJggRa0OML7F9IZaa4gnEU=; b=I
	rDngGkAUZ9iPI9NkjYqwAvMku8xZy6HU3h/RpaGi/uRAx3e/5JTxHVroUVi/lNy/
	hsh7an+a41lR1jPczqO4kpYPZMWnAuoWO6juTxknQc4JxPT3CyOI0SZsC+kUSwdZ
	HOxsX0wNosZThwHxrku6l4I7eLOSy6pOFoUH5KmQkYEqef0+Vk9ZWlW8vVZGxw5B
	sGIdDY7xWWouiAElLrp9PpSXCMmLdh8Yco6EZGDpXHh+gPbSuJmER+CXj0pezHQp
	ZIyV+4bAYNMBgTcUBaH5SdGzmWgUEHy+WZYJyLJtXGCkcv+f9bEYqJ9NMLXAmVHJ
	mkEV6EZ9Fr7my5UqzGUrg==
X-ME-Sender: <xms:9dC2aLYcO5-QLBCu-3Doy9H5OGM2N49xCY5qaZVVK0Fp9n1fxDRsZw>
    <xme:9dC2aPjTYr126EGOZE78vN4ofswEJjQw7fzw0rXoyKn32CIJoEznW1QHwkTekzYtg
    I4xVjLRCmtvxg>
X-ME-Received: <xmr:9dC2aFMa1jVWtLBljERsrJBqJuRvlPk4pUwAMTdtFLW4mq0kFzyX408mS6mkjyYLh5mk5CiWyCYMU1WIk-MeZTDb7Ko8nTj9SuJ4-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    ffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepifhrvghgucfmjfcu
    oehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepveeftdfhieduhe
    eiieettdevieefffejhfdtudeikeefkeevteeugfevtdeugfetnecuffhomhgrihhnpehk
    vghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdpnhgs
    pghrtghpthhtohepvdeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrkh
    hushdrvghlfhhrihhnghesfigvsgdruggvpdhrtghpthhtoheplhhinhhmqhdttdeisehg
    mhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugihpphgtqdguvghvsehlihhsthhsrd
    hoiihlrggsshdrohhrghdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhophhhvgdrlhgvrhhohiestghsghhr
    ohhuphdrvghupdhrtghpthhtohepjhhirhhishhlrggshieskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepmhgrugguhieslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehm
    phgvsegvlhhlvghrmhgrnhdrihgurdgruh
X-ME-Proxy: <xmx:9dC2aJOoAYRtjn3FAOERt__pL7TM8do8FRD-eO_xYSPYgZpfqKV6Vg>
    <xmx:9dC2aNIr0NCnWTGaTmWYh-qlYjZR4RcR9bAfpEtyLtgoHEFOqW_N1g>
    <xmx:9dC2aIs-VFawJQ3jbow6EsZ9ijqJvtKLXcwM2aG7PqhuOpRc14q9ew>
    <xmx:9dC2aPEGfyAZObH9f0tOAUN0CJEZWEmZfOdhf8SHuK1QWMWCB21IiA>
    <xmx:9tC2aJNt41Kj2ffXuJ2DABsguzxbOwi49tXdYdGrpr8ZpB_uVquCJ4_p>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 07:11:48 -0400 (EDT)
Date: Tue, 2 Sep 2025 13:11:46 +0200
From: Greg KH <greg@kroah.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Miaoqian Lin <linmq006@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Jiri Slaby <jirislaby@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Olof Johansson <olof@lixom.net>, Paul Mackerras <paulus@ozlabs.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] pasemi: fix PCI device reference leaks in
 pas_setup_mce_regs
Message-ID: <2025090241-dowry-gloss-1709@gregkh>
References: <20250902072156.2389727-1-linmq006@gmail.com>
 <63be79a4-79e4-47f5-a756-aa55fe0d29ab@web.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63be79a4-79e4-47f5-a756-aa55fe0d29ab@web.de>

On Tue, Sep 02, 2025 at 12:24:11PM +0200, Markus Elfring wrote:
> …
> > Add missing pci_dev_put() calls to ensure all device references
> > are properly released.
> 
> * See also:
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.17-rc4#n658
> 
> * Would you like to increase the application of scope-based resource management?
>   https://elixir.bootlin.com/linux/v6.17-rc4/source/include/linux/device.h#L1180
> 
> * How do you think about to append parentheses to the function name
>   in the summary phrase?


Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot

