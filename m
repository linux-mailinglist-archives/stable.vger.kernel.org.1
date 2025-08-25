Return-Path: <stable+bounces-172804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF764B3386A
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 10:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E283F189756A
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 08:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73AC27FB3E;
	Mon, 25 Aug 2025 08:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gzDmK5Nt"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177601FB3;
	Mon, 25 Aug 2025 08:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756109020; cv=none; b=n2ZxVcL1o86RJY7923U5zdhW0esZGStyfrMFPEASEvCO2bOLtwr6YByL+53rCoumUC2C5v3kwv+zkY4+YTq5koWf5dX54JbLCeNkgD/ZGXFK9D12yzkmRbd/GWtrLRmRk0MmjvdLPz7ujUmq0inwhyB+3jj5t+fosVoPEyhiniw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756109020; c=relaxed/simple;
	bh=mvmq5rwqiWBHURNUX+Nja686kD0FUynMAYpWQ7S0jrQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=r5a9PlMZmYCBj09VTyJp+GkRHadP1pTo+ja9gv9asFzFK++KP2FicTsTQL4ekJ4g50GtWiVtPczhVjv5+LIN6jqRC0bG6MCppQXKYAGsVMFwWVa3hFvylV1FyLXIdS3E82SWW0jnkv59RM0CS78eD0I5zdRQxbpnSuEZNFuwJz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gzDmK5Nt; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C2F837A0138;
	Mon, 25 Aug 2025 04:03:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 25 Aug 2025 04:03:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1756109016; x=1756195416; bh=LV8nmb1e2FEh9yr5rX4WxOJTjRfi9VaYMx6
	rSASEwDk=; b=gzDmK5NteI6JjDK2LUeWse+V9cK3gpiz/p22O5LM4/uqzUrd5BU
	LOz9dPpLLWnnAr5MQdayJN9nw7dt2el9/Cqb5Ml5zo9BqnS3RZY5A+1eGcd71B0J
	zIBH4hsLMT4EBuNdVHsyYPABF2RU3vxUFqyYq3gf6qqrNT+ap91sXG9ufHe1kCnF
	Ni0IqV463rC6z6tHc3P5C6j0GBHrDWi0BtM03qahHLf+hc8+/0wMmj6GUW9NVzwu
	iGsrpbeWtBnQ/U5VcN/Vhp4/QVhDIp8SPSthh5fjum+DrLEFEVam4Ev1tkyF8yl9
	SQjngi0bQXaWbJxEO+pdB/XuBvCvleiJ0Vw==
X-ME-Sender: <xms:1xisaBMJervUYei5VBQbqX6tHlujDfXVDMAexO_DhtAI-fegSG9drQ>
    <xme:1xisaOkeIdCy6HXPWgdPOfe5D7e4VfnpJOZVlQMrHSvOED4MtjeerKdog6g7TkHMF
    bRZCbYzGLqKIpPg1Ps>
X-ME-Received: <xmr:1xisaGQ1Tf4xhg92H_kQxRFfdxHIw5in3Tr-UEQwkqHvLRmVe6mq8xHeLVvV10oFS77ToOpPH8EnapncqRopgylGLKXVkMH5Mn4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedukeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeuheeu
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfth
    hhrghinheslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopeelpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdroh
    hrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhg
    pdhrtghpthhtoheplhgrnhgtvgdrhigrnhhgsehlihhnuhigrdguvghvpdhrtghpthhtoh
    epghgvvghrtheslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtohepmhhhihhrrghm
    rghtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehorghksehhvghlshhinhhkihhnvg
    htrdhfihdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    shhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:1xisaNWPDl6CzRt0Ngt7QSjvNgLfmK1qDto-Nwmq11Btm3mTsWJx7Q>
    <xmx:1xisaKKClOeZKju0QkNIMzpMe0uWbY5w0vJNcwpK4k1BCrzWveiZ8Q>
    <xmx:1xisaN1jl2TZv2wuFnJHUzVpDEuWKNw4VshF1SYu8Jut62JYKTNBPw>
    <xmx:1xisaHIUX74C1VurJ1l_qvQI-OqE2k8EqDLKT7vGTw5vsrV2RG5uOw>
    <xmx:2BisaD1twva0Q_oTYCUWBNKyOG030xMSPAay0FI1M-vf6xFM193Qq80C>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Aug 2025 04:03:32 -0400 (EDT)
Date: Mon, 25 Aug 2025 18:03:23 +1000 (AEST)
From: Finn Thain <fthain@linux-m68k.org>
To: Peter Zijlstra <peterz@infradead.org>
cc: Andrew Morton <akpm@linux-foundation.org>, 
    Lance Yang <lance.yang@linux.dev>, 
    Geert Uytterhoeven <geert@linux-m68k.org>, 
    Masami Hiramatsu <mhiramat@kernel.org>, Eero Tamminen <oak@helsinkinet.fi>, 
    Will Deacon <will@kernel.org>, stable@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atomic: Specify natural alignment for atomic_t
In-Reply-To: <20250825071247.GO3245006@noisy.programming.kicks-ass.net>
Message-ID: <58dac4d0-2811-182a-e2c1-4edfe4759759@linux-m68k.org>
References: <7d9554bfe2412ed9427bf71ce38a376e06eb9ec4.1756087385.git.fthain@linux-m68k.org> <20250825071247.GO3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Mon, 25 Aug 2025, Peter Zijlstra wrote:

> 
> And your architecture doesn't trap on unaligned atomic access ?!!?!
> 

Right. This port doesn't do SMP.

