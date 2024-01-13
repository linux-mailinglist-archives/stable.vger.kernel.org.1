Return-Path: <stable+bounces-10626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD8B82CAD3
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 10:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E2751F2200A
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 09:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87CFA38;
	Sat, 13 Jan 2024 09:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="kZiRSHLn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PrdBAIpT"
X-Original-To: stable@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA25A2A
	for <stable@vger.kernel.org>; Sat, 13 Jan 2024 09:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 0E3655C00BC;
	Sat, 13 Jan 2024 04:32:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 13 Jan 2024 04:32:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1705138338; x=1705224738; bh=LLpwHdoPu/
	QWvZcURcg/VaRWvmPEgafBeQEhdAXohNk=; b=kZiRSHLnoIY/WzHRRHJHpuvTHu
	SPZ1RJJcHSr5o8/vFV4Dg71xlk3TQtioewc8V78iQnciuYeuI/Xh/ewr4GSztjBQ
	KA6NbSnFtXlMyuYSroo8jsgCnoVpdVE/VQHviEP54VzWiNmx7WMULmSZfcepxXIp
	dbGs2qYj2U1+lMyWsYTaJ44X3+WIRWJwyvXPTLYI7ThfK26luIwuPTbmWDCngsuU
	/Axv2uJnaeAFUSyqRHCo3UF1Xiuof/ROvSX/TOO3DW7KLQ2yHzsSlbsgy2tHKFpf
	cS9vMldo5+014YK8emOYl+Vi5JC9X5cn4W2CMi+hBsa+ywaZ8feaTPZaXYBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1705138338; x=1705224738; bh=LLpwHdoPu/QWvZcURcg/VaRWvmPE
	gafBeQEhdAXohNk=; b=PrdBAIpTHV63DdbTB62b0HfmnKNZnrc2Hk3Z/y0ybtYG
	ErGobp9ZK+iw0qUT1hQxDssRh/ZDkqUx/7ZiCZvxueHaoLQm2mQp18OcJmDqpThz
	kAi/v6a4V/Mqrop+Zo16s0VCtOMgGxSqf8HH9Day7hkA4HU7jY/L2bRC7JK9VTcQ
	Vo8Fa9Tc2OrkF+D0VCn4LWEEUryOhDKRTmV3hzhdbkdVcGJvj2xjQR/K9yT6IfwT
	Nd9D5XuzG944KAoB7t+qwzPkkZnJ4kxBfF8r0hG0Yk2Xt6JGLLMEFk/jBkhJrwLQ
	DI5PpMFRKZisKy/ZjBnUfAQqOljSOocJf569UNc2dQ==
X-ME-Sender: <xms:oViiZT3bYDXgFW72rfaTfK1X7iMXdpSJk7iqkxm1OTv9e1gphkWpig>
    <xme:oViiZSFDaAmhsFPJn3Abg9YTLlJ9a0YkiBHPVX4mRBFoUE4XBzUFdscm1IVPaNn9h
    Gkqblj9fd4jwQ>
X-ME-Received: <xmr:oViiZT6TgCXes6rTLJ3sUfmy88FrU1GbDo1WboCb33WREC2iS0rL_7U_yfDcJfgjCnhfxmEY044bej3yZ0pzMpd3XLJdPslZ0_SduU7Hy3E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeijedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:oViiZY3RE0KzpjRPH4MDUSZsj04VBYAnr8JBapA2IRi2ZG128ewtEg>
    <xmx:oViiZWGr9KDfnDek91dxNbcOEYpHyn_KjBRKxQ-Uhsu0IVE0yNIYbg>
    <xmx:oViiZZ-6ePajxb1ALvcGqr82Oxveq-14sAzKzeTomZlYXC4NBiiPIw>
    <xmx:oliiZbRjy3ai270RBzhmo8lqbz769LSElNfFoLxt9Bj_l9XJEMpD0A>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Jan 2024 04:32:17 -0500 (EST)
Date: Sat, 13 Jan 2024 10:32:15 +0100
From: Greg KH <greg@kroah.com>
To: Markus Boehme <markubo@amazon.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.15 0/2] tracing/kprobes: Fix symbol counting logic by
 looking at modules as well
Message-ID: <2024011309-lantern-daughter-c717@gregkh>
References: <20240111214354.369299-1-markubo@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111214354.369299-1-markubo@amazon.com>

On Thu, Jan 11, 2024 at 10:43:52PM +0100, Markus Boehme wrote:
> This backports the fix to the kprobe_events interface allowing to create
> kprobes on symbols defined in loadable modules again. The backport is
> simpler than ones for later kernels, since the backport of the commit
> introducing the bug already brought along much of the code needed to fix
> it.
> 
> Andrii Nakryiko (1):
>   tracing/kprobes: Fix symbol counting logic by looking at modules as
>     well
> 
> Jiri Olsa (1):
>   kallsyms: Make module_kallsyms_on_each_symbol generally available
> 
>  include/linux/module.h      | 9 +++++++++
>  kernel/module.c             | 2 --
>  kernel/trace/trace_kprobe.c | 2 ++
>  3 files changed, 11 insertions(+), 2 deletions(-)
> 
> -- 
> 2.40.1
> 
> 

Now queued up, thanks.

greg k-h

