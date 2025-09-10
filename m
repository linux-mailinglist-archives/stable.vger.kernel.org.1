Return-Path: <stable+bounces-179175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A05CB51095
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 10:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B90A176E1E
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 08:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CFF30F550;
	Wed, 10 Sep 2025 08:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jHnyPBoy"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031A830F548;
	Wed, 10 Sep 2025 08:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491359; cv=none; b=AB8nZz7mOPsxwSCeZQFQMxEWs8IPx60ZY23MAtx/pAPvx3bxSCMW3POZ4fM/XMdku/GKnP/QCs9GE7Mpsp+BJeQkvlDUro6jwbUOvxECJixInkZhuCnNV9WRIyvEh1VvFTtz4W7iA6Yr5NfJu7pf0n2QY+MvJPgoc5Pvzs4LMoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491359; c=relaxed/simple;
	bh=2Qs0PjLdKIL4vHUJW8CVZIk4BYyaMYnRnOSwZdAOHpc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qEVm1StKqwdjko1FK1AsRWcFfiFHCN49OFVKSowPoml+xFbmf5fsH/WJpftNgFXYLvHKzTdDb9ZIxYAZUVMWv7/ebSkcdjDyQl/fRJnFCgiFDhvAE4OvF0MJ2Q1m1ezTRkcQx3DnL4X2OEKwo2Pxetqs2ElezCNxiL8bEGj0t5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jHnyPBoy; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 395D814001E4;
	Wed, 10 Sep 2025 04:02:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 10 Sep 2025 04:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757491357; x=1757577757; bh=QnEHEbf4gQgWVUJkCTbojMh3ocIvXTr36C3
	XOEu4rCk=; b=jHnyPBoyeRrcIRjBpohki3O+Q0Bh54mCIOg3xPk7iQMMnZGBnW4
	Wa9ZPwVA/jYtSaR9pq2m+Lcp62BTz6z7w4rPkFjp/gNHbnye/q6Vg+NM4nNspE/m
	kqFaQIMUdOHYEpqxNPkCgsatpL47R8mWX/C1SvHzvz3KHD+7FFeWf0HiGmMRGBEU
	morbfxF6tHn447u2PGnT0TDNzw250ZEnMnwY3Lg5Sna+cOZ+UVQ0Kni7lP3wRP09
	VK2j/KNYpUYX+g3v2SKKuHuJcihWZms6/y2MiCPVCURcJf37volIKyPtrxpr+0ev
	V2IrMDn/QgIIXauh6Dh91hWoA5yBx3aKgEw==
X-ME-Sender: <xms:mzDBaIUz7w2FpB2UKpinfGCVu4J5cyg31nFWN8caDVtsw0d6grpxWA>
    <xme:mzDBaNKTr_vMul39T5Pc9yPj-k_OzYLWSxLvSa_fU3ysamEpw0ofk8gIa7f7qbx1x
    toZCaF8RMUeOfXYrCA>
X-ME-Received: <xmr:mzDBaFTLyqLCnD6wBLk8ZHPhWgbl8SOc_AhqQ-tZoB0GfM3yoykC0GcO0DOjvEoulLGvKlzHSdbFIydGbSI_tNjuy9zQp9pyvp4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdejhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfvhhgr
    ihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepleeuheelheekgfeuvedtveetjeekhfffkeeffffftdfgjeevkeegfedvueehueel
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhthh
    grihhnsehlihhnuhigqdhmieekkhdrohhrghdpnhgspghrtghpthhtohepvdehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehstghhfigrsgeslhhinhhugidqmheikehkrd
    horhhgpdhrtghpthhtohepkhgvnhhtrdhovhgvrhhsthhrvggvtheslhhinhhugidruggv
    vhdprhgtphhtthhopehlrghntggvrdihrghngheslhhinhhugidruggvvhdprhgtphhtth
    hopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohep
    rghmrghinhguvgigsehouhhtlhhoohhkrdgtohhmpdhrtghpthhtoheprghnnhgrrdhstg
    hhuhhmrghkvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopegsohhquhhnrdhfvghn
    ghesghhmrghilhdrtghomhdprhgtphhtthhopehgvggvrhhtsehlihhnuhigqdhmieekkh
    drohhrghdprhgtphhtthhopehiohifohhrkhgvrhdtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:mzDBaBhXwPQVseb1--gu2aj0vdJYhq0GVdJniWqeAzH-rp5wrwK7QQ>
    <xmx:mzDBaHtAobGYZRM6USPnCtP2f6_BTvBCN87d4Xr5Qo5XyUiPFUotsg>
    <xmx:mzDBaEin-ZnIFznx-A1VLWADF5HYTsrywiFrQfg4I2O24F-oUsQ8YQ>
    <xmx:mzDBaGHfZdu8RvjK9C3vwVEGVlN_91a9MpV1DO1kt3TiTesuNPXiRw>
    <xmx:nTDBaDzuOBd163gG6EWzZQKHrcsAD0tHbT5CgrzW6y4CViEHMvYfO8Uf>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 04:02:33 -0400 (EDT)
Date: Wed, 10 Sep 2025 18:02:43 +1000 (AEST)
From: Finn Thain <fthain@linux-m68k.org>
To: Andreas Schwab <schwab@linux-m68k.org>
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
In-Reply-To: <875xdqsssz.fsf@igel.home>
Message-ID: <cd9d62b4-addf-49c2-731c-ec7c89cbebc5@linux-m68k.org>
References: <20250909145243.17119-1-lance.yang@linux.dev> <yqjkjxg25gh4bdtftsdngj5suturft2b4hjbfxwe6hehbg4ctq@6i55py3jaiov> <99410857-0e72-23e4-c60f-dea96427b85a@linux-m68k.org> <875xdqsssz.fsf@igel.home>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Wed, 10 Sep 2025, Andreas Schwab wrote:

> On Sep 10 2025, Finn Thain wrote:
> 
> > Linux is probably the only non-trivial program that could be feasibly 
> > rebuilt with -malign-int without ill effect (i.e. without breaking 
> > userland)
> 
> No, you can't.  It would change the layout of basic user-level
> structures, breaking the syscall ABI.
> 

So you'd have to patch the uapi headers at the same time. I think that's 
"feasible", no?

