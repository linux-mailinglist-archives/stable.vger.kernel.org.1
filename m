Return-Path: <stable+bounces-135107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE3BA968B1
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 14:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80B443BA9B0
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 12:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83C822F164;
	Tue, 22 Apr 2025 12:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="peFdmKde";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jI//vRv4"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682104A3C
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 12:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745324123; cv=none; b=kJO/5cxNTGzevSjcNjzn2VhdmmfZmeieqmgIey15pnteVPE+OnNq0sUh9wgsFd7YfKR10SxQCYhLZFcGPpckQMkVgAWZq8Nl313D+5wID8jHyz8fwyjPEILdj58dvcBRgiLb5dBez7ZuJeB6RdPpipVV2ZKsD31tCOdn87UFtGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745324123; c=relaxed/simple;
	bh=elxCKPHRoIy2h+VfKA6x6tixjd2RrZCpMo0TF7rjyMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkVVHTa3/jfZSvn+EcSauY/6iuCXMxKGBFkmiSBVddvDCGmpHbgtIMm8rBXpXltFlDuDKiIIRN+u9Wj0PErfo9EqoOXD1nKemYc0uQa+MVbQeo82DWa0LdB8pdBMCPzF6EPG5VodRHdhYeIXsssOe1gJgHEopY5Ghjm7im1Y914=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=peFdmKde; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jI//vRv4; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 172F52540249;
	Tue, 22 Apr 2025 08:15:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 22 Apr 2025 08:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745324118; x=1745410518; bh=lJrTQwhZ2z
	9bEerCZiQ70HsUyrbxf8YW6QODwwGqEQE=; b=peFdmKdeBOsvF//mwIKP1q/P5n
	rwAMLsFSLPNZzVM6RPGkfWz0n183U7ng6Jnlp5x0Z+70BCmLKtz9UrsiuXWwCCMf
	6kAOf3cLhXNApEnQIJaZ7/xMI47scm2mAl+49HyIkYOS4TK1g3SfM3TufQBv4T7Y
	BZJDtaHr5zWVPZjMJyXG3ccK+mBxpBphCLeHqIf3W6yVy9MEHjrBYSv7knykB0ej
	1WeVS+RK6eyp3bNO7S22T/4hRoVxKx+8dY01pGejZoj/wsSi/5uWJpDEjOqNGp4/
	igeQvW5D7WNOmQUDy1iQq/AexJwsanMcs9pzu6tiURa9Jlxw+QRLBEZif7HA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745324118; x=1745410518; bh=lJrTQwhZ2z9bEerCZiQ70HsUyrbxf8YW6QO
	DwwGqEQE=; b=jI//vRv4JhpCaJvKBm2NMNSQ72eFOgKfnZXTW0RLwLIAKSplHli
	Mt/7PF3iTkNIZl5Sgc0MWEH7LPo8qqwqY3gTW2/HAlwTgRfd+XJH+DIfgpMxKtdL
	has+L5Gf5t1chdDG4S+Zmuk9dd9tYFD9TtsbnK1XW6CNU0+L9m0ZmUK1ZlMO68y9
	eCN4sI+jOoG3JeJ+rG1//SzM3ZCIoWduMquMldVVxbzcP/PjXH9sqvFZxVQ1Xd/Z
	nxNkiyEGdxriMhvhQI/kVPrN7vDI//r4s+tEhwrZpeyaZtUICjTviZx2NREjmkex
	AahJ0P69/eQZiSxCAVBcjYhTkrzAao+vgsw==
X-ME-Sender: <xms:VogHaO9Z9Gy4t6fuTMyyxtoKX3XvrYn9wrx80PG5sYWfc-1RPLKhLg>
    <xme:VogHaOsgIV8zUflQHGZqgm6R-HiRIgZ_VUTRZatgWSYLZyH-JyEq-NzkIBh-DwKyO
    jL5o0L34qjR7w>
X-ME-Received: <xmr:VogHaEB-sl5HB2vfcKEyZcOh2JJBf4b7U7j17YcSwNAeG5hWqpV25_1-qzI1RPbO9vFgyTy8Zbo7ToivRsIE7_GhlgCU0kM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeefjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecugg
    ftrfgrthhtvghrnhepgeehueehgfdtledutdelkeefgeejteegieekheefudeiffdvudef
    feelvedttddvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtgho
    mhdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hhghhohhhilhesmhhvihhsthgrrdgtohhmpdhrtghpthhtohepshhtrggslhgvsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtohhphhgvrdhkvghrvg
    hllhhosehfohhsshdrshhtrdgtohhmpdhrtghpthhtohepshgrshhhrghlsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehulhhfrdhhrghnshhsohhnsehlihhnrghrohdrohhrgh
    dprhgtphhtthhopeihrghnnhdrghgruhhtihgvrhesfhhoshhsrdhsthdrtghomh
X-ME-Proxy: <xmx:VogHaGetUNcTwr2N8yMrOJxdXyoH5lN6IFWzyULcn-tDfM5dWqkd0w>
    <xmx:VogHaDMjXJKr3Ga8cR8SB2iKZEJNjX58DwF5XtVx-zQwvrTLr63yzA>
    <xmx:VogHaAlrxUYoGfRG-y-g5qx49zqPF327NqTIe3E20DPzdNAhwJVJzw>
    <xmx:VogHaFs6Im2qeRqUoxGAg-DIwIBaqMwt-wcNTXCX7yfIKJhSb1p1dg>
    <xmx:VogHaDiaTgESgEsUTMTedyANlXCh6O4OmTDzStVrrZC8oGsUu5mYS00n>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 08:15:18 -0400 (EDT)
Date: Tue, 22 Apr 2025 14:15:17 +0200
From: Greg KH <greg@kroah.com>
To: Hardik Gohil <hgohil@mvista.com>
Cc: stable@vger.kernel.org, christophe.kerello@foss.st.com,
	sashal@kernel.org, ulf.hansson@linaro.org,
	Yann Gautier <yann.gautier@foss.st.com>
Subject: Re: [PATCH 1/2 v5.4.y] mmc: mmci: stm32: use a buffer for unaligned
 DMA requests
Message-ID: <2025042250-difficult-surgery-cb7c@gregkh>
References: <1744115241-28452-1-git-send-email-hgohil@mvista.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1744115241-28452-1-git-send-email-hgohil@mvista.com>

On Tue, Apr 08, 2025 at 05:57:20PM +0530, Hardik Gohil wrote:
> From: Yann Gautier <yann.gautier@foss.st.com>
> 
> [ Upstream commit 970dc9c11a17994ab878016b536612ab00d1441d ]
> 
> In SDIO mode, the sg list for requests can be unaligned with what the
> STM32 SDMMC internal DMA can support. In that case, instead of failing,
> use a temporary bounce buffer to copy from/to the sg list.
> This buffer is limited to 1MB. But for that we need to also limit
> max_req_size to 1MB. It has not shown any throughput penalties for
> SD-cards or eMMC.
> 
> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
> Link: https://lore.kernel.org/r/20220328145114.334577-1-yann.gautier@foss.st.com
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Stable-dep-of: 6b1ba3f9040b ("mmc: mmci: stm32: fix DMA API overlapping mappings warning")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Tested-by: Hardik A Gohil <hgohil@mvista.com>
> ---
> This fix was not backported to v5.4
> 
> Patch 1 and Patch 2 there were only line change.
> 
> Tested build successfully
> 
> dependend patch for this 2 patches
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v5.10.235&id=bdbf9faf5f2e6bb0c0243350428c908ac85c16b2

Then please send the full patch series, not just "prep" patches.

I'm dropping both of these from my review queue now, thanks.

greg k-h

