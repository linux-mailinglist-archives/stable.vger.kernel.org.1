Return-Path: <stable+bounces-5114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E5980B411
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 12:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D77101F21128
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 11:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB1013FFA;
	Sat,  9 Dec 2023 11:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="NJZUx2z4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IrfRpaos"
X-Original-To: stable@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D6110E6
	for <stable@vger.kernel.org>; Sat,  9 Dec 2023 03:57:40 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 309C75C00F2;
	Sat,  9 Dec 2023 06:57:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 09 Dec 2023 06:57:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1702123057; x=1702209457; bh=Sw
	7ClsskFF3lFl8GT9c/0MgfE2je/WO6pnuL6dokJ2A=; b=NJZUx2z4LYeAyjevRX
	uqsM9q8e0zn1flTnciflnjBlxjZRjPEihqwosxBovGEd1uBzE5v3d0PM0Tr+FiJR
	TPMVbFB7wfeAUHgQuoGflo564fdNz6QVGO4pY30NrIapbJIV5QGI1uHreHbqjunl
	0o6C64Jxoj2lsq1Hr7r1VFlfOcIyIvpyQ5oWuW9mVQWA+tpamJ7PtlUK3wT2hM1G
	By38ogNO2Z/wQzPWvem6Bsch4haBEZ+usdu16IkLcWW1zVNet0gF/oJcj+cxSRIf
	fnlJ1pPyXsesz+yJRnrNfEuwPEzkIpzvpqu/t4k5dHrQNhKSbfNrXiz4nI0j07UU
	dnWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702123057; x=1702209457; bh=Sw7ClsskFF3lF
	l8GT9c/0MgfE2je/WO6pnuL6dokJ2A=; b=IrfRpaosl2YMmoBakuKMxqCEG4TzF
	y7f4kyeDzllaghAF/FBilvHLji9KIstUjVXhIQdb+k6ZvVmVD3uUUQSxX605We3R
	ubjWz+0sIepDw2vzIXVHOw3UtCOrNqemwhuK4DCx45jd6z09aKD21bPHUioO0UYA
	MYnSWpqqBxidCMTaGkw+KBbnCxJlEtECmWJ96cQxkM+ctUSoHydg/SS/GNQu2elB
	idvtQLRushPT1+Jv5E/8pDjllYi4HD5decFmhZlxqO8IiDMJ5WuqlLiLhcRKeu5L
	Q/sW7Xmfp8CZeDoqO71gTOkl+MILeLDMRjsdiY7xbZjAK6tWP4Y4eu/sQ==
X-ME-Sender: <xms:MVZ0ZVqPEmdJ7a_NMj8MGXK6elphqhPjUYHApa4elDydfDAtlYXXSw>
    <xme:MVZ0ZXoBoAp-dmVQ89IS9xiyh_neF6zn946i2C2lCMfAtLywvOyottj2751_H7nGQ
    0IYViW9wnwLYw>
X-ME-Received: <xmr:MVZ0ZSOVTGeMOl6Xrc06C6SrgMiWq7b8gaZzfXOHgJFaykvvltNYfvMjJpZEAERoeDv_63Yb4NHLWRLIDOpfLDlplKVET2ODwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekkedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucggtffrrghtthgvrhhnpeegheeuhefgtdeluddtleekfeegjeetgeeikeehfeduie
    ffvddufeefleevtddtvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:MVZ0ZQ5ewOTG61vHFxt5PFKe4Umc2iN0RadX1ROZHV6m553ACucmhQ>
    <xmx:MVZ0ZU5klE90gSDkIqX-q63EAzyrQ-cPH_tlPRuyEnbp1OJb0MTU6Q>
    <xmx:MVZ0ZYhlG9HrtaUU9rg3TnN7_5IMmeeZEUObqc_R2KmTFA3pR6sOjg>
    <xmx:MVZ0Zf1qfx4_QA2bHv2Nj1QT89bqKbDE2L-mrT64u8GRdClC-oR9Rg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Dec 2023 06:57:36 -0500 (EST)
Date: Sat, 9 Dec 2023 12:57:35 +0100
From: Greg KH <greg@kroah.com>
To: mhiramat@kernel.org
Cc: stable@vger.kernel.org, JP Kobryn <inwardvessel@gmail.com>
Subject: Re: [PATCH 5.15.y] kprobes: consistent rcu api usage for kretprobe
 holder
Message-ID: <2023120926-crayon-boozy-f806@gregkh>
References: <2023120319-failing-aviator-303a@gregkh>
 <20231206021458.90689-1-mhiramat@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206021458.90689-1-mhiramat@kernel.org>

On Wed, Dec 06, 2023 at 11:14:58AM +0900, mhiramat@kernel.org wrote:
> From: JP Kobryn <inwardvessel@gmail.com>
> 
> It seems that the pointer-to-kretprobe "rp" within the kretprobe_holder is
> RCU-managed, based on the (non-rethook) implementation of get_kretprobe().
> The thought behind this patch is to make use of the RCU API where possible
> when accessing this pointer so that the needed barriers are always in place
> and to self-document the code.
> 
> The __rcu annotation to "rp" allows for sparse RCU checking. Plain writes
> done to the "rp" pointer are changed to make use of the RCU macro for
> assignment. For the single read, the implementation of get_kretprobe()
> is simplified by making use of an RCU macro which accomplishes the same,
> but note that the log warning text will be more generic.
> 
> I did find that there is a difference in assembly generated between the
> usage of the RCU macros vs without. For example, on arm64, when using
> rcu_assign_pointer(), the corresponding store instruction is a
> store-release (STLR) which has an implicit barrier. When normal assignment
> is done, a regular store (STR) is found. In the macro case, this seems to
> be a result of rcu_assign_pointer() using smp_store_release() when the
> value to write is not NULL.
> 
> Link: https://lore.kernel.org/all/20231122132058.3359-1-inwardvessel@gmail.com/
> 
> Fixes: d741bf41d7c7 ("kprobes: Remove kretprobe hash")
> Cc: stable@vger.kernel.org
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> (cherry picked from commit d839a656d0f3caca9f96e9bf912fd394ac6a11bc)
> ---
>  include/linux/kprobes.h | 7 ++-----
>  kernel/kprobes.c        | 4 ++--
>  2 files changed, 4 insertions(+), 7 deletions(-)

All backports now queued up, thanks.

greg k-h

