Return-Path: <stable+bounces-4816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BFE8067EA
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 08:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63ADA1F215CA
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 07:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFF412E6E;
	Wed,  6 Dec 2023 07:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=anarazel.de header.i=@anarazel.de header.b="ZSeN5jG9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dtShI6lf"
X-Original-To: stable@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7101A2;
	Tue,  5 Dec 2023 23:04:25 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id E69295C01CE;
	Wed,  6 Dec 2023 02:04:24 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 06 Dec 2023 02:04:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701846264; x=1701932664; bh=Qw
	mC/TeQGACNvmSZEvlJstCySOilTI3WVWB/NqvOWao=; b=ZSeN5jG9zzzGFuZYqb
	hfcGQ/x3tj82jM0IrN8wFoG/WSpPWnmbkWooAQmP9ISwE/PMZm8GrR9XjZJ8CcDJ
	tksKx8rblF8kj6um2UlN2fmw+DO7gKS40vXUEM2VAQufOJj70K3lScxOtWsc0yPm
	B/qH2exi53Soq/ttS7H763TteOuUXmMaxZXeEHb66YOUszgw8HgG9ETzP/jQr/66
	mwAI4MGu0GOlQ/GY5h9ebOGdxk0O/h3hNcb5A68PbN0ZmK/RtKKeCqy+S3szmi/k
	zlnK0SO0Q8pt0lBcpGAEFd1Ayp6mwycRiTqMwLr/ngvS4yRfpjSTuPhH53dTbdqO
	4H8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701846264; x=1701932664; bh=QwmC/TeQGACNv
	mSZEvlJstCySOilTI3WVWB/NqvOWao=; b=dtShI6lf4r1MY/o9Ve57miONw1MBD
	ZO5HDZLr89Y2xQsW8mtOJLgukiFWPzgiRmyah5ZZLn/7WGO/6WX1XAYB5W7EbEyY
	CxpHTlwSpKyMt5gjGX1mss3hJXSQ/V9xfdNtq1tiUoEzJZjkOFAYb/xjTnMBvdcR
	YARN5/+DeeYM256Y342h9rfhW3cJSsqzC3qag9QRQG93JPMt8e/Q3sKar9LQq+0Y
	NKHJ6bQgqMx62SbTI87wdXzpSPtKegPFXLrLHFGoCi0OO3w6Ab9dtu2TYhPOk8fL
	u3C76tSmvMxqrJJrdcch6PfkNxJ4QL3SjqVS96/IsfBMGwnNW0cSzUg9w==
X-ME-Sender: <xms:-BxwZdL93FIY6XLGxu0nlHGfJjSHsna-cKTLEpCZ90zorR595ciPWA>
    <xme:-BxwZZLasDXzqiZJInlmzTVcXJMHXi0pS-Z3yxfHpd0R-jGhX60f9HKgGX8Uf58UM
    uS6JLvnN-pIbqmvGA>
X-ME-Received: <xmr:-BxwZVuUpNJSEoiAvtXFqNFX-9kT-bXkbmKCVTIrtsLBaftrVaMvUWKwl3ZufiFKT2hu1-oL8KbuNuFaJFqELxE1GWgvvLuB_wAFjGoiuByBMnnaNRiD7CP57cm6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejledgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehnughr
    vghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrf
    grthhtvghrnhepueelhedvkeehvddvgeevleektefhteefueefhefhteeigffgtdegkeek
    geeigeeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvshesrghnrghrrgiivghl
    rdguvg
X-ME-Proxy: <xmx:-BxwZeZYJIDQd2QfIBYOOnMdGw0dwr_JY0cZhyBr0bUbQx_EDBHXxQ>
    <xmx:-BxwZUZCpNsFXKlNDt77kh_rdbutaQxZePMn6Ii0uYNZpc5qvB5XvA>
    <xmx:-BxwZSC46WX0bbY4c4SNhOFxm2GY3p5LAioEXCPI8oBCJO7C8w_BaQ>
    <xmx:-BxwZRTyV-UojM1umyKzgUb96XdvWpNCI0VH71laYjP7mzjNqLrVXA>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Dec 2023 02:04:24 -0500 (EST)
Date: Tue, 5 Dec 2023 23:04:23 -0800
From: Andres Freund <andres@anarazel.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Zhang Rui <rui.zhang@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, rafael@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.6 02/17] x86/acpi: Ignore invalid x2APIC entries
Message-ID: <20231206070423.wp7cxxnwfe3lidm3@awork3.anarazel.de>
References: <20231122153212.852040-1-sashal@kernel.org>
 <20231122153212.852040-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122153212.852040-2-sashal@kernel.org>

Hi,

On 2023-11-22 10:31:31 -0500, Sasha Levin wrote:
> From: Zhang Rui <rui.zhang@intel.com>
>
> [ Upstream commit ec9aedb2aa1ab7ac420c00b31f5edc5be15ec167 ]
>
> Currently, the kernel enumerates the possible CPUs by parsing both ACPI
> MADT Local APIC entries and x2APIC entries. So CPUs with "valid" APIC IDs,
> even if they have duplicated APIC IDs in Local APIC and x2APIC, are always
> enumerated.

As just described in
https://lore.kernel.org/all/20231206065850.hs7k554v6wym7gw5@awork3.anarazel.de/
and also previously described by John Sperbeck
https://lore.kernel.org/all/20231122221947.781812-1-jsperbeck@google.com/

this patch causes some machines to "loose" cpus. All but one in my case.


Even if the commit didn't have these unintended consequences, it seems like a
commit like this hardly is -stable material?

- Andres

