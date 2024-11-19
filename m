Return-Path: <stable+bounces-93996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B6B9D26B0
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 14:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B67A0282AF5
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 13:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AD41CC894;
	Tue, 19 Nov 2024 13:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="cXu1GDTw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jpx0bHhF"
X-Original-To: stable@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E25212B93;
	Tue, 19 Nov 2024 13:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732022242; cv=none; b=C0qtDQLK86Tp4AIkePRlFbWToff0TIaaI2ZevCByecP1aneabj7ZX1VCfXx6hmEUpXwUkjkyps3eV7GRI/fvB/wAqAGXZf/3yCt/SRCy4ypiD4DYER5MN3qsvDEV6CZ+TlHCGrIRjqZ3C4jidXWR4iKJO9XH8/QADdT5liL588I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732022242; c=relaxed/simple;
	bh=E454GamzLTfhki+MnpQ9dGwuoIX5586ObjUZk2BVNYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iH8QBPprhRkCtXFrlDhflZxHOzAiGbANjTF7MkOCz7S6SM9USFz1/izfPIcBK9AagTTtq/0GKg8UQ4LZ/AIEG7ZKk1odBsurEeGgZ3Z/1QondX3pjUngV5rVR/UrSR+SXgAlBJLIdF9XJIIZBUbun0H33ZOtU8h1MdkBQR7PX5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=cXu1GDTw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jpx0bHhF; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 5ACFA1140181;
	Tue, 19 Nov 2024 08:17:18 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 19 Nov 2024 08:17:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1732022238; x=1732108638; bh=E454GamzLT
	fhki+MnpQ9dGwuoIX5586ObjUZk2BVNYc=; b=cXu1GDTwBYQNdXaRC8VjNWGyoZ
	IWmQzP01Fn+NgL4PrH8drFK1CtkSDKo6dwR3zhTMMIs0ku+2ZKgF9uQWgKnvO5jY
	dhmK95Idl0VV2asENa+pmfpDhS8N/j7tTAE0T/EyhVW2i138poElbKJh6C4wa1dI
	LssGpEr7mtKP66FYfnZfPgiokJ9qGYlqoth8XN6T1AGAI5RIkWz0W5gbrCR9DHl/
	CEaxWSR0+i+cA6b88YrQ3rA5POvZkQLBu87hXl1QLUQVL8Xb+INeo9N0ENMZgLTT
	DYTI/EzoAqS52xnZW3RBGcG96esmn7vqnROB9SiKqXjOM9gnPXTNMmZeLgtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1732022238; x=1732108638; bh=E454GamzLTfhki+MnpQ9dGwuoIX5586ObjU
	Zk2BVNYc=; b=jpx0bHhFM1T5a3AnGzxIde7wYgQ6igmYU6GkE2MmFc2oysqrSGY
	HEp1c99PfWYCEyQPZ1KFbkgKCw1kUjloYW4fIfV0bb6/poplC2z8GotQ2H9OJMqz
	ammcTD+22Rl/E3Z8gVSJyAh2qfTeeUia8OG3k8t9rhW6j68a0o//UjdY4hS2NmXU
	wzWkVWt//qvvNiWqtc10BzFXKRdDVQl8oE0fdKyfkzXdq1vo/BYrkfqpVwXN4sBl
	A0CQ549oSqU1kh19Iao28I//VIYyztL9BKqLoqIPraaudIc04L5bVuOSs64Uiz+p
	E9hUFcRzybfv/tPJ4uwCAFaYPSJKZQLe1qw==
X-ME-Sender: <xms:3Y88ZyMhQ86W4f4La3I2kCQ7t9cdOWBeqwDarrZYzqv1EZG2E67f7w>
    <xme:3Y88Zw-qlFCzMtFEWklWVlXzShntukBubTD1vMV0BmFO3WopMl8X-03Y51gJuutB1
    kcKDTpG1HZP6g>
X-ME-Received: <xmr:3Y88Z5Q6Sp8yP6lT0mL7msWE5CuTEQfZVQ2JZX-ebO_ddUu_U2LTyUOtRMM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedvgdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehgedvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffg
    heekteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgrhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepfeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehlohhrvghniihordhsthhorghkvghssehorhgrtghlvg
    drtghomhdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtg
    hpthhtoheplhhirghmrdhhohiflhgvthhtsehorhgrtghlvgdrtghomhdprhgtphhtthho
    pehvsggrsghkrgesshhushgvrdgtiidprhgtphhtthhopehjrghnnhhhsehgohhoghhlvg
    drtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtph
    htthhopehtohhrvhgrlhgusheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhg
X-ME-Proxy: <xmx:3Y88ZytVjyBhOtrnmttKdtUz5sISkaZ8NMxouxf_XSu733R7qo8UOw>
    <xmx:3Y88Z6epc61dqT7E27bO3k-Z6pR9ygSF3UentuxjzPUdUmbpzSZg1w>
    <xmx:3Y88Z23ihX0hWKPbZ-tfD2vgedubkq3J0SxppSz0kUSm01MPSWesfA>
    <xmx:3Y88Z-_niHDle7LLYaNWkWfet3H_5a_5bVNte9Q3S5PHPuUiPIU4ZA>
    <xmx:3o88Z4-fJHhj5shHA7mAVWNVFJkPuTvn_eVVq_9n14fcv5cp1d4m-DUG>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Nov 2024 08:17:16 -0500 (EST)
Date: Tue, 19 Nov 2024 14:16:52 +0100
From: Greg KH <greg@kroah.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 6.6.y 0/5] fix error handling in mmap_region() and
 refactor (hotfixes)
Message-ID: <2024111932-fondue-preorder-0c6f@gregkh>
References: <cover.1731672733.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1731672733.git.lorenzo.stoakes@oracle.com>

On Fri, Nov 15, 2024 at 12:41:53PM +0000, Lorenzo Stoakes wrote:
> Critical fixes for mmap_region(), backported to 6.6.y.

Did I miss the 6.11.y and 6.1.y versions of this series somewhere?

thanks,

greg k-h

