Return-Path: <stable+bounces-88222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 342D59B1C40
	for <lists+stable@lfdr.de>; Sun, 27 Oct 2024 06:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5423B213B2
	for <lists+stable@lfdr.de>; Sun, 27 Oct 2024 05:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACC636AF5;
	Sun, 27 Oct 2024 05:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="dVFt2rXw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BWUILe5f"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B56018C31;
	Sun, 27 Oct 2024 05:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730007439; cv=none; b=r0IoZAVdzCByasWAB4leaowDdm5SI+9bKcmUdEVgeLnx7C9AZ0Sf8CcRkZQRq2e17OQHaSApws6nePECSYNhWPUIO8WTzjy9vDmDs7cp9i6+N0treZXG34JKfUloOdq1a9Qxl0elByC0BjjQBycMSFUkOSvfBVZ5cLLcuZcVBIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730007439; c=relaxed/simple;
	bh=NyI+cahmWBF+67+Z9gJ54gxEAPQka7WtsrLQszLd+V4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQcpOR2zU20+mrFxQmjNg85e8qLmJtqwxbvbunoDCGY53CFD7MxW27dtkBSdgbGgolM1Qr48iy7wOD4YwXIa+GNBlMyKumKotk+V55g5dk5Zeny7w5XjN2cIdHKjC7iU7avDo0V+kdyOEoR+3DxglSa+rvhUgMvFXlOmNlxzzvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=dVFt2rXw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BWUILe5f; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4AFAC11400E4;
	Sun, 27 Oct 2024 01:37:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sun, 27 Oct 2024 01:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1730007434; x=
	1730093834; bh=k2/aIs939sA9Ai/RPM8rerCD3QxcglmtmmyoHMu3KKM=; b=d
	VFt2rXw331EEbOJeCryCT82YvMQIFiyPffuTDb7s/pn+Q0f7eSsqKhu0fo8w2arH
	nONiamoKLRuBcjsztzhVZd/4DULQ/Q7r4F77R/Yx3+kxR3KDlCsp3Q5pC22er1+B
	+mqO6bR0CIG37GF4gSD9vuowlUR3roRyOXH5RsG7AWDQhCvce4KEuD2t9RQuBQq8
	nZRDe+PtKvZzM6BfjSKHC6Cmmy1/3RiT5L5shlk1cJ9bAbGsP2oMkvWtd/I8VxD1
	ApMfePLTxyAX7JSCTItBBeXpNRJRHhN4eecO9xHQ+ALzko+HoVoHJOb6XZpNAzJ5
	RlTa3Y4BxpviaeDPb1e3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1730007434; x=1730093834; bh=k2/aIs939sA9Ai/RPM8rerCD3Qxc
	glmtmmyoHMu3KKM=; b=BWUILe5fYrmMLBlEcMkA7oDb5LFIZt+AKCotj7cehvKx
	hahVVdivekiyQYIss6CLhuQowroaMd2E1QRTUvYJ4btUC9upyex67GJVnSN8qGo4
	ZKsC424EXH5Xwz3PgV72ipFhoeppQbDwNRc4Vj7vHff1RPCIi5/ZrnPJi0pTjoTA
	3P5+zPKGX7LleMOE+TauvE2eQMq8tCB+z1ia1iCxd1/UMSKDR0ybQDLygt9YLjsq
	Z5dREgkMS6y1w0M3E8FtsR5Hld+Xjy/lbid13oMTH2/cpM4TAAfo5tHpAahE+LkE
	30eTu2Uf9+oYzxIakan41iwBaQxZPugq9xQCqcYKbw==
X-ME-Sender: <xms:idEdZ-osFFx5SDJkBFjzVS0ElakvtrZnAAFmLt8i2OgTa3kskDFIyA>
    <xme:idEdZ8p3n_DjWC2-Wc5yxr9Obgn0iJTNQaMynp1z3OFc1y-F2PmbrpH5qDg_DCcXK
    crp42T59AfXYSAhUd8>
X-ME-Received: <xmr:idEdZzPVHUtC2x9BpSuxyNmMjzF3BxaiDcmO4XKacNRfk0DZ0EM-iFaHncotcA0xYePQ4Iugurqc8C2v6JRPstGfX9Y1d6Jcsd8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejhedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveeilefhudekffehkeff
    udduvedvfeduleelfeegieeljeehjeeuvdeghfetvedvnecuffhomhgrihhnpehkvghrnh
    gvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhppdhnsggprhgtphhtth
    hopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigudefleegqdgu
    vghvvghlsehlihhsthhsrdhsohhurhgtvghfohhrghgvrdhnvghtpdhrtghpthhtohepvg
    gumhhunhgurdhrrghilhgvsehprhhothhonhdrmhgvpdhrtghpthhtoheplhhinhhugidq
    khgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtrggslh
    gvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:idEdZ94EJ9PbtVLtxHr0XqysrMni6JB-bs2JwD-HCd03Gx3YTQ1VkA>
    <xmx:idEdZ95K6DLisPe0RP1zG9LXK3bBhZnnZXscGDX7XE_AQWx1jtwq9g>
    <xmx:idEdZ9jwuWmqtHzKzf87QgRel2zRY4XXXVc3GrnLD_5S8TXwqSg3cA>
    <xmx:idEdZ34tS9w9bPCkNBQO1rousObveiBJ_qXnjgtYUxp1FP-rjkfhLg>
    <xmx:itEdZw2uGUFMcF7jxu3C2DLRQBUqi9oes3eSkaVmdu2AZti_97O1BTxy>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Oct 2024 01:37:12 -0400 (EDT)
Date: Sun, 27 Oct 2024 14:37:09 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: Edmund Raile <edmund.raile@proton.me>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] firewire: core: fix invalid port index for parent device
Message-ID: <20241027053709.GA122484@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	Edmund Raile <edmund.raile@proton.me>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
References: <20241025034137.99317-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025034137.99317-1-o-takashi@sakamocchi.jp>

On Fri, Oct 25, 2024 at 12:41:37PM +0900, Takashi Sakamoto wrote:
> In a commit 24b7f8e5cd65 ("firewire: core: use helper functions for self
> ID sequence"), the enumeration over self ID sequence was refactored with
> some helper functions with KUnit tests. These helper functions are
> guaranteed to work expectedly by the KUnit tests, however their application
> includes a mistake to assign invalid value to the index of port connected
> to parent device.
> 
> This bug affects the case that any extra node devices which has three or
> more ports are connected to 1394 OHCI controller. In the case, the path
> to update the tree cache could hits WARN_ON(), and gets general protection
> fault due to the access to invalid address computed by the invalid value.
> 
> This commit fixes the bug to assign correct port index.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Edmund Raile <edmund.raile@proton.me>
> Closes: https://lore.kernel.org/lkml/8a9902a4ece9329af1e1e42f5fea76861f0bf0e8.camel@proton.me/
> Fixes: 24b7f8e5cd65 ("firewire: core: use helper functions for self ID sequence")
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  drivers/firewire/core-topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-linus branch.


Regards

Takashi Sakamoto

