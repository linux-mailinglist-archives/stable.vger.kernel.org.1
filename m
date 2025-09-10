Return-Path: <stable+bounces-179146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C464AB509F5
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 02:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C0163B7E1D
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 00:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808241BCA0E;
	Wed, 10 Sep 2025 00:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sqjf8hUE"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE24E2033A;
	Wed, 10 Sep 2025 00:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757465129; cv=none; b=QDmttcDsvwc2Jvgja/1275H5zWH+kCJMGG9Hns6rBvMqqgunM7GxG1zj/h7gm6rYO6trVTUVq13tOmoDe0ouEmh7pQ/FF6qu8vWPpW84xVLwAWaI/j5akJzWZuIJOqLvIEM9JGAFLBA9qqkJfPl0gHNnTaT/rNJgpj6z2R5fN90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757465129; c=relaxed/simple;
	bh=Gqn/3fVgulPCD+mTY/274v5+FDLdPoYZYdQ5zz1r2TA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UNSAPM0s86CEDYz76P/jPd/n5nJPYBjbrQA376Vvf483mS9m6xAfKiHRy2JJqcWtJrOiNNbaKMeNdU5SesSQ628+PqFHI4ZgZEJw/UGl5e9g8NaalPy91k4crZgZIe+Yikp6uT9LvN4mF3h0lNObi2jDJLVjCvxg1k5clXak7IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sqjf8hUE; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EDA8E140019C;
	Tue,  9 Sep 2025 20:45:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 09 Sep 2025 20:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757465125; x=1757551525; bh=iWsr2kImsDaUmYNz/Af1Y+/PPsAmVjK/7kk
	TLWems/A=; b=Sqjf8hUEZP6mM9mXNkKIv1U/cnpSaFdHbLltmf19IyPTSePZ9+Q
	ybPb+KR3WX3EueeEhNnqZO2pgrNNgW1iDbOETseiIyG+ndHGRYEtmDtnjui7jTcR
	Hq1mkoEhcgupuKfDtQ0mRxBu/Y5NPWd8wMlzuRQMgPqf6nNsGgDcAuJ9EbgR88qL
	6/iyr4W1LzHj1MB4PXdhtQ4rlbSx16UCpMio2aC4Fg4iHWUPCz4cjuPwG0RhtIGK
	ZMksakloC+2zNHS9B9t4NGfgCvbWmPzkmKz8bL0FNU7LY3QUSt/gZpObyikOvTLS
	3H0B504sugm4M3wdxLhhWXsbNWirLi7Sd+Q==
X-ME-Sender: <xms:I8rAaMP3ulbwaz5t8iS4XAADJVPycpPFo_4tPHwzb9ZAqKBsZsJ4Pw>
    <xme:I8rAaFv8QpIckWvo1CthHm9_z8Uz2shYTlK9jc2jrGum5yxVKYeCVWvC8MfCghj6d
    a5rTqRzOxqv3i4KRkE>
X-ME-Received: <xmr:I8rAaALQf5ZZPnxWC1WJQogW3T3D4KDQC4XVfabCQdiyzWyv3BYAkDy0hzoZ2YdVYWkFB1pciJUYOBYV2mD1d67UFIZv15-p8u4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfvhhgr
    ihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepgffhiefhgedvffeukeffteettdejudduledukeduuefhfefhjeeivdeggfdutdev
    necuffhomhgrihhnpeguvggsihgrnhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrghinheslhhinhhugidqmheikehkrdho
    rhhgpdhnsggprhgtphhtthhopedvhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epghhlrghusghithiisehphhihshhikhdrfhhuqdgsvghrlhhinhdruggvpdhrtghpthht
    ohepkhgvnhhtrdhovhgvrhhsthhrvggvtheslhhinhhugidruggvvhdprhgtphhtthhope
    hlrghntggvrdihrghngheslhhinhhugidruggvvhdprhgtphhtthhopegrkhhpmheslhhi
    nhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprghmrghinhguvgigse
    houhhtlhhoohhkrdgtohhmpdhrtghpthhtoheprghnnhgrrdhstghhuhhmrghkvghrseho
    rhgrtghlvgdrtghomhdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtg
    homhdprhgtphhtthhopehgvggvrhhtsehlihhnuhigqdhmieekkhdrohhrghdprhgtphht
    thhopehiohifohhrkhgvrhdtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:I8rAaMMNJGQ2yP3bBwoBCdQYElVKnW-aRFs9CqQDewjp3oO4szeKTg>
    <xmx:I8rAaMAD6ip1_y1H45THOeH_bttiBvdjYkyms5FFN5zAZay0O0AAbw>
    <xmx:I8rAaMV1bn4-SzJiDdaZ_mht5VlfD8tMDtIE2zsTa_aIvUbgCdToBA>
    <xmx:I8rAaAeiVZt9U_ipQ_XAOvkt9eVPPnq9tpk52V6krO7Y20K_fP0rFA>
    <xmx:JcrAaFd86-jDq3eO5zuCzj5B2XrUzbEfBHJcRsYrbluXjKCsNsRYJjvK>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 20:45:22 -0400 (EDT)
Date: Wed, 10 Sep 2025 10:45:35 +1000 (AEST)
From: Finn Thain <fthain@linux-m68k.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Kent Overstreet <kent.overstreet@linux.dev>, 
    Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org, 
    amaindex@outlook.com, anna.schumaker@oracle.com, boqun.feng@gmail.com, 
    geert@linux-m68k.org, ioworker0@gmail.com, joel.granados@kernel.org, 
    jstultz@google.com, leonylgao@tencent.com, linux-kernel@vger.kernel.org, 
    linux-m68k@lists.linux-m68k.org, longman@redhat.com, mhiramat@kernel.org, 
    mingo@redhat.com, mingzhe.yang@ly.com, oak@helsinkinet.fi, 
    peterz@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org, 
    tfiga@chromium.org, will@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] hung_task: fix warnings caused by unaligned lock
 pointers
In-Reply-To: <b7db49106e6e7985ea949594f2e43cd53050d839.camel@physik.fu-berlin.de>
Message-ID: <4d270f51-d724-ecea-a9c4-7e6b3c20fcaf@linux-m68k.org>
References: <20250909145243.17119-1-lance.yang@linux.dev>  <yqjkjxg25gh4bdtftsdngj5suturft2b4hjbfxwe6hehbg4ctq@6i55py3jaiov> <b7db49106e6e7985ea949594f2e43cd53050d839.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Tue, 9 Sep 2025, John Paul Adrian Glaubitz wrote:

> I have been trying to change it upstream though 

That ship sailed decades ago.

> as the official SysV ELF ABI for m68k requires a 4-byte natural 
> alignment [1] ...
> 
> [1] https://people.debian.org/~glaubitz/m68k-sysv-abi.pdf (p. 29)
> 

GNU/Linux is not AT&T Unix and was never intended to be that. 
Hence, your old System V (trademark) binaries are not going to work, 
unfortunately.

