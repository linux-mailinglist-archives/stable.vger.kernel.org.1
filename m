Return-Path: <stable+bounces-172673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DC2B32CBE
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 02:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5739C241425
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 00:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955A43398B;
	Sun, 24 Aug 2025 00:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H6OSqoDq"
X-Original-To: stable@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD8C35979;
	Sun, 24 Aug 2025 00:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755996477; cv=none; b=CkZ9a1FDD0Q5d2RU2r3X/hxNMZQ3OThUk64qBKOZP3SdehNl6hei2QX6JPMotCEpwH1+Rntl0Mzu/stUbqtdDkBHtxRFXsHOlvmy9QtlMMv56MeRlAMTX/yst3Mx+Lzv7KGj6li0DWmuGbi42pyPrTYczoBMSa9pclgL6qIe5/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755996477; c=relaxed/simple;
	bh=xuziBNnie5ysUoLtEvcYwCBlbrBMWsV4Kgchzge+dzw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ebtn0okMg07VctmJ3TravH99M4l1qNlLNHjAfMQbqIMXfjhL3eMzYcyS9/StzEhJTaeMaw+EC4X7FcuSPIfqI9IyQQrHGms7udv81ih001sJxcVbvkGxlQ7Md5JiGLrmd1sJSDArnImhxCOkGUwn2dudM3cNeLRtiJHkjEj9Ox8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H6OSqoDq; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id B16161D00058;
	Sat, 23 Aug 2025 20:47:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sat, 23 Aug 2025 20:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755996473; x=1756082873; bh=K9+5HFtQoSlLWA05xKrNFkVtPjshle8xz2R
	oDrH7qqw=; b=H6OSqoDqn0f5f56RTJE1davNYSkFNdjq6EsNs8+j8FJVcjLjwsQ
	qyzJM6MFR52H1SMMk7booEPiSEJmSHfIykHbupGfnce5We+RQgYp9Q1mTpuX0EWh
	n9kfZ6EhjmnQ28cSS20faecxQDKeMSeUAu34VH2d2YMsn3Qvse8StIDEeMUi/6SX
	atUG2FD5gWhazXI3vYLGwyiI8DWSPKauctAtNX1Wx/40SCEZbDbBBrQoW9hoA0lX
	GffGOBLvGAMuVv6KVSUiR5gZwleoExAYVNDqL3m4RRLchByDZHovFFfiisIs6vBf
	q1/6CpFnblGlIs+0OS3hZS2X0uK8mOzs5kw==
X-ME-Sender: <xms:N2GqaI2_gjPKjn3kbIlU-XthtqRduRD0SuAJCLzNrmmEjtA2y4vBOQ>
    <xme:N2GqaEzYHNaPMkd6kj0WsMxP0Uz0_3WxBVPmS-ZFy3CStA4TYhaak-KVRoYq6lQPK
    AsP9o74B5wsRTy-TZo>
X-ME-Received: <xmr:N2GqaEURq1-gbDivz9hBV5Sor30hze0bjYu5B_hBbJ5UquvytqMejPX9_lbVOf3bQ65XoVGlqHvyi5Px9ZjnU1Uz1y4b8bYtRnE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieekudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeuheeu
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfth
    hhrghinheslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopedvhedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheplhgrnhgtvgdrhigrnhhgsehlihhnuhigrd
    guvghvpdhrtghpthhtoheplhhkphesihhnthgvlhdrtghomhdprhgtphhtthhopegrkhhp
    mheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepghgvvghrth
    eslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtohepmhhhihhrrghmrghtsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehsvghnohiihhgrthhskhihsegthhhrohhmihhumh
    drohhrghdprhgtphhtthhopehovgdqkhgsuhhilhguqdgrlhhlsehlihhsthhsrdhlihhn
    uhigrdguvghvpdhrtghpthhtoheprghmrghinhguvgigsehouhhtlhhoohhkrdgtohhmpd
    hrtghpthhtoheprghnnhgrrdhstghhuhhmrghkvghrsehorhgrtghlvgdrtghomh
X-ME-Proxy: <xmx:N2GqaBpOZYglFui0EcyXP4m2ZlwBg_VcFUylNyLblJoVMYzokceriw>
    <xmx:N2GqaBf6sadZesdCD3THfvgjucDbU1NYOfW0aKDU2lbFgIxNWBvulw>
    <xmx:N2GqaPGkju3b2tuzqBpc043uXH8WFFG1NPtqD307ax55BXlTZT_SVw>
    <xmx:N2GqaH3H8LC98VX9T0kBNvsrVrjXgZ4inLJE4Gxszraoti0Xi_QsYw>
    <xmx:OWGqaFYFZ9DRuli5EtF7eM0QsoYHPE0fnw2EIhtHxquh5xRDrsTU6ljl>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 23 Aug 2025 20:47:49 -0400 (EDT)
Date: Sun, 24 Aug 2025 10:47:43 +1000 (AEST)
From: Finn Thain <fthain@linux-m68k.org>
To: Lance Yang <lance.yang@linux.dev>
cc: kernel test robot <lkp@intel.com>, akpm@linux-foundation.org, 
    geert@linux-m68k.org, mhiramat@kernel.org, senozhatsky@chromium.org, 
    oe-kbuild-all@lists.linux.dev, amaindex@outlook.com, 
    anna.schumaker@oracle.com, boqun.feng@gmail.com, ioworker0@gmail.com, 
    joel.granados@kernel.org, jstultz@google.com, kent.overstreet@linux.dev, 
    leonylgao@tencent.com, linux-kernel@vger.kernel.org, 
    linux-m68k@lists.linux-m68k.org, longman@redhat.com, mingo@redhat.com, 
    mingzhe.yang@ly.com, oak@helsinkinet.fi, rostedt@goodmis.org, 
    tfiga@chromium.org, will@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] hung_task: fix warnings by enforcing alignment on
 lock structures
In-Reply-To: <202508240539.ARmC1Umu-lkp@intel.com>
Message-ID: <29f4f58e-2f14-99c8-3899-3b0be79382c2@linux-m68k.org>
References: <20250823074048.92498-1-lance.yang@linux.dev> <202508240539.ARmC1Umu-lkp@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Sun, 24 Aug 2025, kernel test robot wrote:

> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from sound/soc/codecs/mt6660.c:15:
> >> sound/soc/codecs/mt6660.h:28:1: warning: alignment 1 of 'struct mt6660_chip' is less than 8 [-Wpacked-not-aligned]
>       28 | };
>          | ^
> >> sound/soc/codecs/mt6660.h:25:22: warning: 'io_lock' offset 49 in 'struct mt6660_chip' isn't aligned to 8 [-Wpacked-not-aligned]
>       25 |         struct mutex io_lock;
>          |                      ^~~~~~~
> 

Misalignment warnings like this one won't work if you just pick an 
alignment arbitrarily i.e. to suit whatever bitfield you happen to need.

Instead, I think I would naturally align the actual locks, that is, 
arch_spinlock_t and arch_rwlock_t in include/linux/spinlock_types*.h.

