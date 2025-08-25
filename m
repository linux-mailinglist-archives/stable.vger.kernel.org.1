Return-Path: <stable+bounces-172783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8792BB3364A
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 08:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D459C481675
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 06:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620CA27A919;
	Mon, 25 Aug 2025 06:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KRnecT8q"
X-Original-To: stable@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3711A240604;
	Mon, 25 Aug 2025 06:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756102665; cv=none; b=EYJDwuIn90OyPXTmyKK85P7BPDkp4Tki4O10JnIf15lKKBpO6T4PviAVCmR6gfHFjIHAuvWh+hodPNo4XwM/pWi95LrZjhbZT95bxnz9nAYrT68N0O5iyOEz4ey5yZnGbXILp0058mi1yHly0t66FNtHJpQwb0rv15e2N/u0fKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756102665; c=relaxed/simple;
	bh=oCBpslRqIpmahNFVF1UF3Za7uggzJOtaYbcAIB5p/iU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YLC0Rkeyj025f2jjpYKX/5B9bJwOdGUSrTN3n/3DsHmwdUUabMo4EEhzhvAjWufeXaDvzVW7KHkeyQSfcqJ6WrT3+5bJ4F6x8HWU8XPR4QLT+Xg+KDM4a+ApQ5FZrcrFxU5GEEQuqLKjGroViev10TTn4MzVN9xHVY2t/8aCa/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KRnecT8q; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id B229B1D00096;
	Mon, 25 Aug 2025 02:17:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 25 Aug 2025 02:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1756102660; x=1756189060; bh=tBF/bB5a4v4TgXX2+3hn0N/6OdTRc98xXU+
	CKqXBDoA=; b=KRnecT8qaAgIBfMQv+olGB30nl9yM1xg0KeT4PLvv8foe9J7oox
	JuiaN+X4kfXb0FMzo0KPb1JoAFH5VmtLGUfWQ6YQ+u/NL9nGVMqoWU6mJ20cD1+5
	lC2aQcZO2W/REMpdt0mQYyP22EYf9qef14JyXhjxxkiksLGIGsNDOruxhLG6uLkJ
	Cp+Y3uiDAcT2RCh5LlmgR8D7H6OoB/93Wnzh6pibQE47lTOSK+wXguPuWY7wdKof
	UCxh5roVxRWXQG3c/7M43d6ltjEhMY9GmzONY1lNlNrpD45lt9eFz3/1xHmONN3n
	8+bX4OJSxhvtDkQkzvwJv98GY61RpYdwuHw==
X-ME-Sender: <xms:AwCsaA_rz14XUiU_scpabCNHnmUBlDv__o0aPoJqbh_19YCofi3pNw>
    <xme:AwCsaGFnqDs4GfcPOqswJK3N21VU3N4_ewpebvPCIIaPbd72gptIS4UYJ5QOUQGti
    WWDpuYYHSzG_JnxqTY>
X-ME-Received: <xmr:AwCsaNWhA_id9cndJKQEX8z8kBulDSGXZxxjiBY3YycuPz7k1UyUkn_O6SEXjwcdceN6BJP_n4E1atP1uYYZVPC0Kcjeg5QCa4M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeduieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeuheeu
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfth
    hhrghinheslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopedutddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheplhgrnhgtvgdrhigrnhhgsehlihhnuhigrd
    guvghvpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhr
    ghdprhgtphhtthhopehgvggvrhhtsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtth
    hopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehmhhhirhgrmhgrtheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohgrkheshh
    gvlhhsihhnkhhinhgvthdrfhhipdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggv
    rggurdhorhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:AwCsaK-uDVds0s_uA9h4fSO4D1M_xbbwenGp6kICFAllRKBhS9zZ3g>
    <xmx:AwCsaC6riun0Qi0Bmpsr-lqAc0h64erCj7YfLu86gfoAl2IlY-pN3Q>
    <xmx:AwCsaLn4uEGktFMdq_GcHWGkfdS0n_1kXXkuoaWb97YQoXixPUGkWw>
    <xmx:AwCsaNGiPEZkDX1cbpwW7VaBwn6rf0n-L6Mc5cDgYNTAbfIEysdegQ>
    <xmx:BACsaG3-hOKGThYjVNoa0wPIwonyvx-y9_EVi6mC_w6WA09JUdCXvY8p>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Aug 2025 02:17:37 -0400 (EDT)
Date: Mon, 25 Aug 2025 16:17:31 +1000 (AEST)
From: Finn Thain <fthain@linux-m68k.org>
To: Lance Yang <lance.yang@linux.dev>
cc: akpm@linux-foundation.org, geert@linux-m68k.org, 
    linux-kernel@vger.kernel.org, mhiramat@kernel.org, oak@helsinkinet.fi, 
    peterz@infradead.org, stable@vger.kernel.org, will@kernel.org, 
    Lance Yang <ioworker0@gmail.com>
Subject: Re: [PATCH] atomic: Specify natural alignment for atomic_t
In-Reply-To: <96ae7afc-c882-4c3d-9dea-3e2ae2789caf@linux.dev>
Message-ID: <5a44c60b-650a-1f8a-d5cb-abf9f0716817@linux-m68k.org>
References: <7d9554bfe2412ed9427bf71ce38a376e06eb9ec4.1756087385.git.fthain@linux-m68k.org> <20250825032743.80641-1-ioworker0@gmail.com> <c8851682-25f1-f594-e30f-5b62e019d37b@linux-m68k.org> <96ae7afc-c882-4c3d-9dea-3e2ae2789caf@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Mon, 25 Aug 2025, Lance Yang wrote:

> 
> What if we squash the runtime check fix into your patch? 

Did my patch not solve the problem?

