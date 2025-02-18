Return-Path: <stable+bounces-116800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C05A3A0F0
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 16:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F42F3A399F
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 15:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58D726B2CF;
	Tue, 18 Feb 2025 15:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="pt3IBLb8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BHJpKG4a"
X-Original-To: stable@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC0B13DBA0;
	Tue, 18 Feb 2025 15:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739891949; cv=none; b=uCYPAC5ps7O0mxGabE6mluEJqgPQVzsFqlGi6knlQ6R9D0LWsYczPYP7fMRJC/tgNMY2ImTLPL6+oXwcEj6w33/C3Oehg6u+VsvzJ6c6Oq9LYH13eVQgvmrEJqvm4UGShAKyDN1PCO57SI/3TSbhOSiJ59YPsMGYTr7XcUxgPx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739891949; c=relaxed/simple;
	bh=TCW0psUT7N8t+b4lYWVTCuGmfY2P+ajfO1BNdhMN6lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOIFFmgcT1zAQCxShfcGvbSaXxIbiH2NxHi3FBoTxhKK/2RSTO2fYAvloC9D2QUvWapdKMamN3sa9BUvhVt2+jbYMxKQY7Dq8i6DZ3z9R3VxG1kRnxvU9ZvgFn96nk3EOyNNJYxi7bzq87OcreUgzNtisG8hdf2hE93H1bNqvnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=pt3IBLb8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BHJpKG4a; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 86B4811401AF;
	Tue, 18 Feb 2025 10:19:05 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 18 Feb 2025 10:19:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1739891945; x=1739978345; bh=CX9LyfREWw
	AgfdEvHMYbCa/CdIQlA2LoqSpWJnays60=; b=pt3IBLb8xxQ8wQXa3+fnFeAdys
	3EQi1upEogGKFF/9Wq3dliO+kqkHEtJWoZjDuZdti3bvS+tIj2b4/Uvezk0Xe9rt
	1vkkZ1tBhoDj9U+a49JaEoFFQwDcvzPxeQKgQPnz34ER1voIoFzSuOfj11qz7KV5
	H4vH9PozaRiWfjo6KDsNdVPcJ7tAWASijZNrASHBek2Q8ms9vi3OWJS0+36WFefE
	CJfeniINdhveiMGn0QCHq1jSj0EeY90y3P1JYXf5gtnnjfk6/60qcET5wBzCW8x/
	bwpBEM99QASR8SKAcFf+WCtMfwvr9PVJmfq85D6Qavl6ucZmDXcSJGNo7UZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739891945; x=1739978345; bh=CX9LyfREWwAgfdEvHMYbCa/CdIQlA2LoqSp
	WJnays60=; b=BHJpKG4a6068A1WAHwhpUX0t/rsO/+0vRtJEXLhk4coSrW20Mb2
	DxyTS8TulKy4a5uOdBvo/ynSA7IoWsNCgtpJOAXmOLRkgnCXP0FmIF/jfORQ1doe
	/qXSMOVv43NvST+k+y0yKTRgqwMwRsHYq0dMtWWvv+HXnC2vUZ4NxyPDvWkdBa4T
	Qu4ZpXliVTK4nOczh1XZS9YNUUSQgiNP5Bmp/w/9QmcjdGILF/w0ICfkQ0WCSQED
	rOO7v/RJeimGxhv9q33l9xeilymBtAEKsqMbW1r9Ep5oNioedjYPTmongrjA10ix
	2hvRD1X3DXa8BrNuYi9PVtrfN0nxqbmtgew==
X-ME-Sender: <xms:6aS0Z5nZnzB-DtgeGmqSKQnJXJMRrTYvcWB_0t0aop4KJdnowgBufw>
    <xme:6aS0Z004keDFUz35K9AvZKesqEY5CFQPW0Eq6RLp4-TCi0DUjkkboEfmiCaYS_o8Q
    V1uj1vFFNRRcw>
X-ME-Received: <xmr:6aS0Z_p-xrpTJTqiFpuntS00iaZfKNrabLWyChZczOczLRneNWKlKhyoffTbP2dBbDBxUFp1P-KFlu7MZ2iaaU1OAKY_QWQSw29cjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiudeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtf
    frrghtthgvrhhnpefgueffveeugfefuddtvddtfeeivefgveduteetfeegieehtddvteev
    feetfedtkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpddugedqrhgtuddrshhone
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghg
    sehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopedukedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepfihinhhtvghrrgeslhhinhhugidrihgsmhdrtghomhdprhgtphht
    thhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsth
    grsghlvgdqtghomhhmihhtshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehtfihinhhklhgvrheslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehhtggrse
    hlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtohepghhorheslhhinhhugidrihgsmhdr
    tghomhdprhgtphhtthhopegrghhorhguvggvvheslhhinhhugidrihgsmhdrtghomhdprh
    gtphhtthhopegsohhrnhhtrhgrvghgvghrsehlihhnuhigrdhisghmrdgtohhmpdhrtghp
    thhtohepshhvvghnsheslhhinhhugidrihgsmhdrtghomh
X-ME-Proxy: <xmx:6aS0Z5kY9Pvs3hVD7dCY5i-BqLmRdmg489JdsxRoywk6vpebDG8llw>
    <xmx:6aS0Z32zVyxPReR33cHulhXyvve_HVPgfs_3naFxEwXPvC61D1a3tg>
    <xmx:6aS0Z4tWvApQy-nfN8NxFPAopEfEg6VT_J6zxDqGdcKLqrMZMcsZow>
    <xmx:6aS0Z7VMs4yvBB_0vmbxCDzBXxgm6dNcMVSsXXPgt4a0zTCfqgvEzQ>
    <xmx:6aS0Z84JSj7FCyf4WxaoNwe1bL_W-VURKL5zXYylZUB5_6lS-bZH7wk4>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 10:19:04 -0500 (EST)
Date: Tue, 18 Feb 2025 16:19:03 +0100
From: Greg KH <greg@kroah.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: Re: Patch "s390/qeth: move netif_napi_add_tx() and napi_enable()
 from under BH" has been added to the 6.13-stable tree
Message-ID: <2025021828-pond-matador-38d9@gregkh>
References: <20250218123639.3271098-1-sashal@kernel.org>
 <b01c840b-55fb-455d-88fa-69848d2dcebf@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b01c840b-55fb-455d-88fa-69848d2dcebf@linux.ibm.com>

On Tue, Feb 18, 2025 at 04:08:25PM +0100, Alexandra Winter wrote:
> 
> 
> On 18.02.25 13:36, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     s390/qeth: move netif_napi_add_tx() and napi_enable() from under BH
> > 
> > to the 6.13-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      s390-qeth-move-netif_napi_add_tx-and-napi_enable-fro.patch
> > and it can be found in the queue-6.13 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> > 
> 
> Hello Sasha,
> this is a fix for a regression that was introduced with v6.14-rc1.
> So I do not think it needs to go into 6.13 stable tree.
> But it does not hurt either.

It fixes a commit that is already in the 6.13 stable queue:

> >     Fixes: 1b23cdbd2bbc ("net: protect netdev->napi_list with netdev_lock()")

So for that reason, this commit should be applied, right?

thanks,

greg k-h

