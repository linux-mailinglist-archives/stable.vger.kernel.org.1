Return-Path: <stable+bounces-176539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74219B38F57
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 01:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F1A15E8084
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 23:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA556310627;
	Wed, 27 Aug 2025 23:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OczyYYnq"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EA227E07E;
	Wed, 27 Aug 2025 23:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756338238; cv=none; b=FrbDFrlW5aVocTM1WWSizRJcdl6Q/QbOHS6Zh96guNCxZ+hZKztagyUbeKijQ13yRhXIo1dlKamXXIpCrOsEM8p+74fUx1Xaj4Y1wbcriZ+oDOi5fo0Fz6ex7Sic+4dDROIi4aqIBokzY30fyACIySrXuc0pSgrsOh2UjzAYnos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756338238; c=relaxed/simple;
	bh=RFxDLtb7LP/7u5S1O1TG891X0C4JHenuzF2zFGe5WAs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WsWjhQBGOUEpViMIch1ZqGfB8OaSeJ6/U8aAquBjRhi0QrkT9bFy40kTeWUlxRspu6wixAFA9Wp8piAO7sTocFFz/z3i6hThKRmZo6NBCWUfXBrcJI5oFw7xo0EnQu1jxMHjH2FWfzAy8uiyU6o+EeYBVoizpkMVuH6DOb//trc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OczyYYnq; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8746614000D4;
	Wed, 27 Aug 2025 19:43:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 27 Aug 2025 19:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756338235; x=1756424635; bh=OSG7MgYlnUUnUG1Thtmyq2oRhoYgB9Jct0L
	D+xiHCZ8=; b=OczyYYnqnaPm5VzjXcG10BgHPB+4Be+Jixh9sUHtNXmNzUHM2pA
	5wriW+LwidH/YCEq9RGMhQ37fqNPma3IyNGGi41ffFThWIoFGbGUF2bC+r12YCVw
	J50k8zB5+kBUqJ5oJCDbLgqbpsYNRmOL5CYcCLU8sT8jfxsb5MKlvaJFCv4K0HG3
	FOn3ky4p7dPXfSGYo5LZJDcadbFKNqirHjb8QUV9AedY0wdm57tB1SNBTyD0GTK4
	hQaq2jbkZWBioktDPiZrUyC+a4BrROBJFG4DwpHkJDnU5ar09wKSYlwEJVRjImn7
	2ecqZe4xu3K2nKYmF17Vrl5C/rvVDkPqrDw==
X-ME-Sender: <xms:OpivaD7sTYKNlUEwI-vOrs9uQHx2s3uCSf-U_ztEqP6sEGqaUZGENA>
    <xme:OpivaIFlYNrgiQn5Yruo2QEasmalEp_tvWwf7y9LkBVAAx5IX2TA8wdbhdd1-bZ9D
    V1NIpHTNzF_SYWXRM8>
X-ME-Received: <xmr:OpivaNKIWsR7a-NaCieNVCGztiR4GeMEwdJhoRwIRlQW5ms8WVM4D452NMIGZDCrnQsVnHSOmX3Vid2A2MS-5eobzGZ-ZDPb4yQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeelhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeuheeu
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfth
    hhrghinheslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopeduuddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheplhgrnhgtvgdrhigrnhhgsehlihhnuhigrd
    guvghvpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhr
    ghdprhgtphhtthhopehgvggvrhhtsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtth
    hopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehmhhhirhgrmhgrtheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohgrkheshh
    gvlhhsihhnkhhinhgvthdrfhhipdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggv
    rggurdhorhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:OpivaNgmYvf6gayrdO6qhamBnfLcFAWxgrWWqs7CIGYwkpwBpPGmew>
    <xmx:OpivaDnXftWRyhf5qIIsSXtTF7chC0CY7UAd23eYFM5TdZ1q_q-T2A>
    <xmx:OpivaMVvdfkVsA7e5tGo0JrjR_C6-F3KMRcw16Nn_sU4mGrz23JQqA>
    <xmx:OpivaItmBsTi77MbFmpyMtBQ1STjZ2pPwhwF8qfo3kpxxiExWXbn4A>
    <xmx:O5ivaDGI_I_SjwT4qwv69EVoot6Z6OBKT5D0PV3m7uWIL2s-X-hKDpQ3>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Aug 2025 19:43:51 -0400 (EDT)
Date: Thu, 28 Aug 2025 09:43:49 +1000 (AEST)
From: Finn Thain <fthain@linux-m68k.org>
To: Lance Yang <lance.yang@linux.dev>
cc: akpm@linux-foundation.org, geert@linux-m68k.org, 
    linux-kernel@vger.kernel.org, mhiramat@kernel.org, oak@helsinkinet.fi, 
    peterz@infradead.org, stable@vger.kernel.org, will@kernel.org, 
    Lance Yang <ioworker0@gmail.com>, linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH] atomic: Specify natural alignment for atomic_t
In-Reply-To: <30a55f56-93c2-4408-b1a5-5574984fb45f@linux.dev>
Message-ID: <4405ee5a-becc-7375-61a9-01304b3e0b20@linux-m68k.org>
References: <7d9554bfe2412ed9427bf71ce38a376e06eb9ec4.1756087385.git.fthain@linux-m68k.org> <20250825032743.80641-1-ioworker0@gmail.com> <c8851682-25f1-f594-e30f-5b62e019d37b@linux-m68k.org> <96ae7afc-c882-4c3d-9dea-3e2ae2789caf@linux.dev>
 <5a44c60b-650a-1f8a-d5cb-abf9f0716817@linux-m68k.org> <4e7e7292-338d-4a57-84ec-ae7427f6ad7c@linux.dev> <d07778f8-8990-226b-5171-4a36e6e18f32@linux-m68k.org> <d95592ec-f51e-4d80-b633-7440b4e69944@linux.dev> <30a55f56-93c2-4408-b1a5-5574984fb45f@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Mon, 25 Aug 2025, Lance Yang wrote:

> 
> Same here, using a global static variable instead of a local one. The 
> result is consistently misaligned.
> 
> ```
> #include <linux/module.h>
> #include <linux/init.h>
> 
> static struct __attribute__((packed)) test_container {
>     char padding[49];
>     struct mutex io_lock;
> } cont;
> 
> static int __init alignment_init(void)
> {
>     pr_info("Container base address      : %px\n", &cont);
>     pr_info("io_lock member address      : %px\n", &cont.io_lock);
>     pr_info("io_lock address offset mod 4: %lu\n", (unsigned long)&cont.io_lock % 4);
>     return 0;
> }
> 
> static void __exit alignment_exit(void)
> {
>     pr_info("Module unloaded\n");
> }
> 
> module_init(alignment_init);
> module_exit(alignment_exit);
> MODULE_LICENSE("GPL");
> MODULE_AUTHOR("x");
> MODULE_DESCRIPTION("x");
> ```
> 
> Result from dmesg:
> 
> ```
> [Mon Aug 25 19:33:28 2025] Container base address      : ffffffffc28f0940
> [Mon Aug 25 19:33:28 2025] io_lock member address      : ffffffffc28f0971
> [Mon Aug 25 19:33:28 2025] io_lock address offset mod 4: 1
> ```
> 

FTR, I was able to reproduce that result (i.e. static storage):

[    0.320000] Container base address      : 0055d9d0
[    0.320000] io_lock member address      : 0055da01
[    0.320000] io_lock address offset mod 4: 1

I think the experiments you sent previously would have demonstrated the 
same result, except for the unpredictable base address that you sensibly 
logged in this version.

