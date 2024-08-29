Return-Path: <stable+bounces-71542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B509C964C46
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 18:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69A391F231E6
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 16:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748801B5EBF;
	Thu, 29 Aug 2024 16:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="oB8/Zc9m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dWjs2KM/"
X-Original-To: stable@vger.kernel.org
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CBA1B6544
	for <stable@vger.kernel.org>; Thu, 29 Aug 2024 16:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724950648; cv=none; b=H5t+AuG+y4voCc9C4I2jzNxNoxq2N4xCOlIADueYDAfhZTMPjrL6RNU8l28zxla6YpbIXdux8exgV7dIrkPznisCtjA8Lejw28/NZzhlaql3yCxBv4Mn5oN/sOyZH4VG8o+skKpWWnbTLN7iZ8L/bXzp+JtZuplFXkTWxYkuvOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724950648; c=relaxed/simple;
	bh=T/GDZlK1KPwK6grJcn9auW1lRRXmLLyRqZMbIdgvVMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J86oLr1gRMi+WJf7XqrDb47p1SPovu50Xfp3jiS139qsMXTRkvFiBrgGd6UaQtdcd89sg1BzxQkdUfrPNySLs2wIaDOTtF6+FeOem+2q4B7bgeqj4Y0txNMEzVNy/hwrM7qs6W96ZNjKn530I+aZcPaYAFov6dCbpbSATRbaDwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=oB8/Zc9m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dWjs2KM/; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 765EE11481AC;
	Thu, 29 Aug 2024 12:57:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 29 Aug 2024 12:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724950645; x=1725037045; bh=T/GDZlK1KP
	wK6grJcn9auW1lRRXmLLyRqZMbIdgvVMI=; b=oB8/Zc9mG70RHgi7URxy5deghM
	qxtOAsUwe4jitzVHdo1eowvbxBjGP6w/TUm+koyVNnstCzymxG7xnVNmmC69PVq/
	qXckexIr3bK/zFH9yI8tIa8qnGK8n/22UhyIdemXE8gbdYSiXXqQYZ0qoBSrI0Bz
	OY7bEbe+tChBtdUDYQBagmmkHLBJmw1ergk5eqHVD9M30d2Q15VD7hw53eJvSWYm
	qntpkIxbGgTRzk5JvZMkwfDYPht4h9h7QEWK2fazwlJrw424OxXrHKcJmZvCZVEn
	/ZCOUJ/C7kAwDQJCrLLTeLLd9gDkJXQ1sySxQspIhAGtJGWy9f0IBiz48Lbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724950645; x=1725037045; bh=T/GDZlK1KPwK6grJcn9auW1lRRXm
	LLyRqZMbIdgvVMI=; b=dWjs2KM/CojJSTawPozRWNlRRkdbWX6M6JTtFxoL+j4d
	EW/NgiePNNNMjLq+4CGsjtzYuTbmFOO4naYBFcjusPHgHr9E0S0Pr22Whps88MqI
	rj7OXaZFY2nQB6AVpHyuPBHOiNg6yhVZ54aN2DjHlgfLZJm0IM9jRTcfS6SIKdwr
	r/O6j0vesFxDCwXfSFvtkERpBu9wx77rkngfS8UtU8fIyUtdiyo3++DXa3ZYvuJ+
	RH65897CPwnyppcO28n9JOmmMUXbQpu3Hnr8FpjZDZnJdWA5POmVyJN49dwkTYH/
	/ZUTez9O1jVn5kYJA9kXNUtlYc7BFCNYcaqAqdzxyg==
X-ME-Sender: <xms:dajQZnuwnYYcpSkUmcWiUIM5an2dln0qAOFoEQGRxR6HvKW8nEdvsQ>
    <xme:dajQZofCDKF_-7_8pBrFlCYd2Zksmcso3pZY1M_PlvuQHlkV2cHth1it_HyZIdFwF
    o4T7Q5FFbx-Kg>
X-ME-Received: <xmr:dajQZqx1CGdCcL4tgGnpn0GTRgHp6myI0PMu9pPmF7NEt8iWfm4G4iRuYJJGf5eG8gs879qs3tu5fqvgdjiE6q1uf7ZNn6Mhuo1sbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgv
    gheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvdevvdeljeeugfdtud
    duhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmpdhnsg
    gprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehhshhimhgv
    lhhivghrvgdrohhpvghnshhouhhrtggvseifihhtvghkihhordgtohhmpdhrtghpthhtoh
    epjhgrmhhorhhrihhssehlihhnuhigrdhmihgtrhhoshhofhhtrdgtohhmpdhrtghpthht
    ohepmhhsiigvrhgvughisehrvgguhhgrthdrtghomhdprhgtphhtthhopehsthgrsghlvg
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:dajQZmMOxl943pYM0-5-5IkKoi3Mtnhh1AEAJx0plvSsfSZweGe2eg>
    <xmx:dajQZn_WyBFdc8D7J1QA2IFJXvkWLcWz3EIJ0f4s_HpbcPclmMSSZg>
    <xmx:dajQZmUKNGNwwVlxjLsYNUhPCsduTUwgRcIOZl-lrDft9t12pBri_A>
    <xmx:dajQZoe8OJzdYYNGikmiXwIGC8uSyIUUEtsuN9_81bZFelzcB8P3yw>
    <xmx:dajQZjQhsENb7ExWF53JdCxTcG-SIWrP9pQMXpRHHOYW6no2YB8Lujg->
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Aug 2024 12:57:24 -0400 (EDT)
Date: Thu, 29 Aug 2024 18:57:22 +0200
From: Greg KH <greg@kroah.com>
To: hsimeliere.opensource@witekio.com
Cc: jamorris@linux.microsoft.com, mszeredi@redhat.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 4.19 1/1] vfs: move cap_convert_nscap() call into
 vfs_setxattr()
Message-ID: <2024082959-outsource-candied-2b64@gregkh>
References: <2024082914-relay-climatic-95c7@gregkh>
 <20240829165312.20532-1-hsimeliere.opensource@witekio.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829165312.20532-1-hsimeliere.opensource@witekio.com>

On Thu, Aug 29, 2024 at 06:53:12PM +0200, hsimeliere.opensource@witekio.com wrote:
> Ok so if a bug is fixed in version 5.15, we have to send the
> correction patches for version 5.10, 5.4 and 4.19 for it to be taken
> into account for version 4.19?

Yes.

> I'm sorry for the scope error on this bug, I'll be more attentive on
> the next ones. In order to send only corrections related to this
> kernel tree

No problem, thanks for doing this work.

greg k-h

