Return-Path: <stable+bounces-139634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3E9AA8E4E
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 10:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4818F172260
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 08:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FEA1BD9D2;
	Mon,  5 May 2025 08:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="Dp4fY8G+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y8Dgu/8K"
X-Original-To: stable@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5435217A5BD
	for <stable@vger.kernel.org>; Mon,  5 May 2025 08:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746434055; cv=none; b=DUGRhx5ow1PhSQSj8s9yoAubhcHmnhLg0VC5Czd4mbQ3t+Vfol9L79KvEBjFIB6E6HSamBxITOFdt41ffvo8NT7LVRNhZVkiHfswtp0za204+gK7c/LW2H6qB+u3o8YW9hpdxmKGd0k9UogqCGLP71jieR3pLzsj0eqqnlgJRNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746434055; c=relaxed/simple;
	bh=0G3A3jqEQx5PkzYSqJ91n/xyx3IERuJTr5IaHQRt3EM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=heUr8m6L7IJ7Oyz1uEBE4aeCaGhrX7VHVr2vEsXXNDje4yK5Gl4uB079wvo2R4ryXAfZ7dKOW73GLqdq91YXeLMUr21+lltQ14Jbvchgkx6MFJ5AWn5rCBmZihigt8KM3ZJEJAzAGdUgeHK6KXbBSYy0mjAbj5ayEjy8mIgnb4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=Dp4fY8G+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y8Dgu/8K; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 5461D13801FF;
	Mon,  5 May 2025 04:34:11 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-01.internal (MEProxy); Mon, 05 May 2025 04:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1746434051;
	 x=1746520451; bh=0G3A3jqEQx5PkzYSqJ91n/xyx3IERuJTr5IaHQRt3EM=; b=
	Dp4fY8G+Ql9adsCZuK/PBH7Ph8MFSUQsvwxaSN9UcF2DFp2dqcJ4M08NVo7ZNWB3
	s7vhdD1ERAiuBvGfymPGYlddals57Tj0Sl85186cV+v7opvoTP1FCQy3bjDCLBfd
	upJUqULI+a2PX3OY6kz+QxF2TiGqFT5GQvL5VfQx7YMfds/fJcv+chIkdo+LkcTl
	gUE2aK332TdtgoBeBToHEEYr+HzNCHbhZThBed40GhnD3jt5uSXpWGWYt9yqTAnp
	hy7FSNeenzMMAXFAAg+Vl2GhoHBRYmsjuZC7Zmmuukyyc3UyVc7X8wg0ZH8T53GV
	Gfv0yt+aM/G/jRWS0DkQ2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746434051; x=
	1746520451; bh=0G3A3jqEQx5PkzYSqJ91n/xyx3IERuJTr5IaHQRt3EM=; b=Y
	8Dgu/8K5gxCjue/6bTqHYffW2uSZzZ8ps233HVdR7ukVS814ZXzL6eZ+7EYRdbuS
	gAZpXpljB8Lt/wVwFxE7TaBsJOm0RkLvAjGvU48eD/WElb5Q8/tMymumK2N0ROuO
	EvUtV1VzUXfO55ZvkpgYMZoLYQkML/dI+9X4xXjl9Vj2vBuPXqyaB8bQbG0dwGP8
	1gvLUDrj0SNYKOOqQ5Li8MlXwI1wXs0MnkL72wj208k3CRzV4/qihy8Ixga92QIc
	hIQ42Zv3yyPn3OgReQWRLy6HLvVZNcbJUj0Sd/U0AQApOolbCpqKKXHQFeCBIM+R
	vQ5Lgah4/zQES98lvfENQ==
X-ME-Sender: <xms:AngYaN8vas-SUFOvPhU_hoVkJqBnonRNw20KgmonLi62B0ozIBG2fg>
    <xme:AngYaBvYwoIAeuMzqpMljbIYxNQ5Lp18a2Xf8vDHAARyeHuZfngpGsALEFqsZk_8L
    ZZcjIDlKvWRnJZT1p0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedtiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedflfgrnhhnvgcuifhruhhnrghufdcuoehjsehjrghnnhgruhdrnh
    gvtheqnecuggftrfgrthhtvghrnhephefhvdeljeegfeevgedtjeegleelieetfeehffeg
    gfehueekieetgeekueetfedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpuddtrd
    hsohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehj
    sehjrghnnhgruhdrnhgvthdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhg
    pdhrtghpthhtoheprghlhihsshgrsehrohhsvghniiifvghighdrihhopdhrtghpthhtoh
    epthiiihhmmhgvrhhmrghnnhesshhushgvrdguvgdprhgtphhtthhopehsthgrsghlvges
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:AngYaLCdYlVn1snHIxmY0U5z_fHoVeRmPF91GYZRea8RbiLtDKlQzw>
    <xmx:AngYaBewzDcgmfDn8ClOkVcPdGI9d8N26N9U4veZlPPOp6tBK92GWg>
    <xmx:AngYaCNo0yv2VRZt014Nf6uqhynZ3liUpz1mDgXvzZeaaxG9jEvPcA>
    <xmx:AngYaDllvXPqm01dCaTxfDpuDpa5a_4OCouSKL0MYVzv6opTky7E0g>
    <xmx:A3gYaKYczwHK_9pbuXaVZl1sRFDJJmeVkQ91Yc90218VyhluKiuKArNn>
Feedback-ID: i47b949f6:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9EA5C1C20069; Mon,  5 May 2025 04:34:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T3ebf7c1616c89bf4
Date: Mon, 05 May 2025 10:33:49 +0200
From: "Janne Grunau" <j@jannau.net>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
 "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Message-Id: <7cb8c3e1-52c3-498f-92af-b8b61a2ce8e8@app.fastmail.com>
In-Reply-To: <2025050504-placate-iodize-9693@gregkh>
References: <2025050504-placate-iodize-9693@gregkh>
Subject: Re: FAILED: patch "[PATCH] drm: Select DRM_KMS_HELPER from" failed to apply to
 6.6-stable tree
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hej,

On Mon, May 5, 2025, at 09:53, gregkh@linuxfoundation.org wrote:
> The patch below does not apply to the 6.6-stable tree. If someone
> wants it applied there, or to any other stable or longterm tree, then
> please email the backport, including the original git commit id to
> <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following
> commands:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> git checkout FETCH_HEAD
> git cherry-pick -x 32dce6b1949a696dc7abddc04de8cbe35c260217

This works for me without conflicts. Are there git configs which might
influence this? The only noticeable thing is that the position of the
DRM_DEBUG_DP_MST_TOPOLOGY_REFS entry shifted 82 lines down. I looked
at the history of drivers/gpu/drm/Kconfig and the config
DRM_DEBUG_DP_MST_TOPOLOGY_REFS block hasn't changed since v5.10. So I
would expect the cherry-pick to work.

Having said all that I don't know how important it is to have this in
older stable releases when nobody noticed it before. The issue presents
itself only with out-of-tree rust DRM drivers. I don't expect that
anyone will try to backport those to old stable releases.

I'm fine with skipping this commit for stable releases for 6.6 and older
and won't post backports.

Janne

