Return-Path: <stable+bounces-5119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8D480B426
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 13:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 951B8281097
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 12:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DFE14282;
	Sat,  9 Dec 2023 12:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Y36OvVre";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RB8oYVKs"
X-Original-To: stable@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3EB10C4
	for <stable@vger.kernel.org>; Sat,  9 Dec 2023 04:20:13 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 05BE73200C9F;
	Sat,  9 Dec 2023 07:20:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 09 Dec 2023 07:20:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm1; t=
	1702124411; x=1702210811; bh=AUdI2/H3TJofTowYr1gIaAWbIWHtgQ1LSy6
	E4A9WJwA=; b=Y36OvVreWzqi2aClkPAOhko+mCMpZCmEotNJGsKyf0JFpsjs1Yg
	3qu5pokjpkj9SGlWVWxVuJe4X+XSiDcCznxKlFE/a37VnuOvi64cH22T4vsgIRnw
	3b5elZqWevZJmG4k4vu6uB/qg9yPRYaS4eyI/HNSVcfze9sPbNgrLwKgp5Hx7FyB
	uxQUHB8lAd1PLlojMa6UNM+wmLYKKu7u8lQSHhXfbLAfutuWe1WVqKgzY9XSFzWT
	PoLnBqyaHoc/Y0yokvNEeV926QEqW1k+wKzO3PmY4M0LK0IpYPL0s4l1BPsRQrxW
	LwB0rbNCSl0MnIzestHULyfJFvrAy+l3Pag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1702124411; x=1702210811; bh=AUdI2/H3TJofTowYr1gIaAWbIWHtgQ1LSy6
	E4A9WJwA=; b=RB8oYVKsuUpnMdUMGtL62uMHtV30/bQiUMulPrMd8RZkpZP/zqW
	rJA+eKMuyOeMCxQnOqVGqP8uspsUYxQTKUHygijd7OZIJ3DL/FJ5Ciq8Po1nzBTz
	gwmfRurMnlFx678Z5GUO2Faq59mH8X5idoFhUt4u24uewI/D+dO6oUldUNccDE5W
	dh0ryxo/eV84DunMtrMwYMnj2V/AGhCmpQcgepGhBWvKWd/EcQmY1zEETGh71p4+
	3i0wlxLxC0pQ2m0B82tgFylggdhHR6xX+27+NouIZvtZn28x5CReo3T30W7hLYX2
	8vwZbRfg3vzZNDd0aOo1x6EOcgjwXB+VTFg==
X-ME-Sender: <xms:e1t0ZaqoAnGXTjrQAP-sNTAYgO8-PkP9WKH156lbAcuojaxW21aapg>
    <xme:e1t0ZYqoWLI7pONQmY7mFFJJmRtqrB5bC5tSC4wJaSk52luGXpl5zVvu5ks1VmLnt
    bAcqjFbD8Kl0w>
X-ME-Received: <xmr:e1t0ZfMWxJl76Zy1sE4fGNo_A1QN5-DXtfWDaeGy_-6ovt8serOu3aSOTuv89oFjbL9Fz0Cx85Db38p3u5Hg9F_Gg_ruo61Kuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekkedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesth
    ekredttddtjeenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtgho
    mheqnecuggftrfgrthhtvghrnhepleekheejjeeiheejvdetheejveekudegueeigfefud
    efgfffhfefteeuieekudefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:e1t0ZZ6DA8x8QoSw66B8QxVTt_1mcOgSbMxaze83F7tvRpxkTSVPew>
    <xmx:e1t0ZZ7Cqps1Nit89X5e7HI9IramkIaUPVB6ypg-3ElafR255NYtKA>
    <xmx:e1t0ZZhtHaEoDxHNb6GODBt-Zxf-S_lurS11qLjzOhY55wCMbG6yng>
    <xmx:e1t0Zc1DWMbBjehlkrnb2KL7G-bUarJicccw4SlLh7ulrtr9CIe9FQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Dec 2023 07:20:10 -0500 (EST)
Date: Sat, 9 Dec 2023 13:20:09 +0100
From: Greg KH <greg@kroah.com>
To: mhiramat@kernel.org
Cc: stable@vger.kernel.org, JP Kobryn <inwardvessel@gmail.com>
Subject: Re: [PATCH 6.6.y] kprobes: consistent rcu api usage for kretprobe
 holder
Message-ID: <2023120932-follow-willow-32f3@gregkh>
References: <2023120316-seduce-vehicular-9e78@gregkh>
 <20231206015711.39492-1-mhiramat@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231206015711.39492-1-mhiramat@kernel.org>

On Wed, Dec 06, 2023 at 10:57:11AM +0900, mhiramat@kernel.org wrote:
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
>  include/linux/kprobes.h | 8 +++-----
>  kernel/kprobes.c        | 4 ++--
>  2 files changed, 5 insertions(+), 7 deletions(-)

Did you build this?  It breaks the build in 6.6.y in horrible ways:

./include/linux/kprobes.h:145:33: error: field ‘pool’ has incomplete type
  145 |         struct objpool_head     pool;
      |                                 ^~~~


I'll drop this, can you please provide a working version?

thanks,

greg k-h

