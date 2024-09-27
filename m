Return-Path: <stable+bounces-77883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E0298801A
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 10:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A33771C22540
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 08:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA42189534;
	Fri, 27 Sep 2024 08:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="wAbGdt+N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YW9lt3lp"
X-Original-To: stable@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6C0189506
	for <stable@vger.kernel.org>; Fri, 27 Sep 2024 08:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727424789; cv=none; b=r9Wu0dG/zG6+3ECZbH/75FcZT1C2BBa4NbiUxZmpDf7soiCXDqHkEZo/Yr6cnqn5IRBf3syE1qAoghGdSwEw4RfaCgbbgQ0e63fF/w8HBh1vI59PyOYg3CvOGXEZPxzBTh9q93HEhWW2d8DFiQ4okICLWhPUyv/Zr2UNnvl5Crg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727424789; c=relaxed/simple;
	bh=ZvYb2Qrsay/vOiQhBbRp3DGEFt0Jrm6ZXWKA5jWipqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnMUSOQ9PmTntL9iL0ha6lUjSLeDpyeDrm9d8qqCmRMaqCxAJILoR9h1CTgJ/Lc+cLDFQi0/3UyGPiIl5ICwLDxK1ATdcPcF0jsjK2FGcWTmd8gONhi17RVfDD4AHhcuUuVEgMEZRYJinlJd+L/wslGafNoQPwSmWbvkic89UBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=wAbGdt+N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YW9lt3lp; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 011D6138043B;
	Fri, 27 Sep 2024 04:13:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 27 Sep 2024 04:13:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727424786; x=1727511186; bh=JD6R2Q5Jto
	/SVhQqTbtizDJw/Ai6eGwPmZuIXWDN60U=; b=wAbGdt+NXAB7WXMyleieUFY3Rk
	TZ/0x9PoGqOe4ijIXRZviYrQCvYNg0l36bN0uPLDRblzmQR0IGhiPWhGf+KAG78f
	ibr5bDzjJRVPh4gmSMAZ6RYFwGF/BVBjtq2zVflLD0xAOA7Tk7tkCDp+d1otuavc
	NnD1RnRHJApNOgdx4ydhJExj4XzUaSSXqLHE6pjjbFk3Cu61gSch7fN92dUFgnla
	ZbLt/dpLYbn6KU3pVSFz7MdL9Ob+prNO2JWnD1+ANzh1nJbFigmw6W1nr3g8IaEp
	Afbze2z4SjcsYLDlzi2OCOZldpya/cDl/1QNnlJEZmNerz0JA0tf0KwaUsKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727424786; x=1727511186; bh=JD6R2Q5Jto/SVhQqTbtizDJw/Ai6
	eGwPmZuIXWDN60U=; b=YW9lt3lpMuLjBMAHW5LhYkhI7aNODBGbTJLv1k+/xqXT
	kOia+TWTPKJ1Ltvn2CPjP+iE86dD9P+s9g+A7kHuYrUsh9616vXMuQc1OyLSLR4W
	XXgQ3TXErA5ot8t/0o2FqBm2S7WVqJqK9onXqNFmNaZnycN0e5/05bfMcE/8GXdt
	HA/BE84rysTofPUiW2bEcPwOie/MWp0a4oK7U6KvL9NqDaKS2o84fiACSyEOXCI/
	dKplmHMEL8KpXYEYU7y6OowCEXZJiUGptO3Hj2YdHbU03q2qdMKxGgrgN9fk53WT
	QRwEBJi7oi7AULxHfcaubhKfPodexJo8wr6KsZl/3w==
X-ME-Sender: <xms:Emn2ZmjoBLlhb8uiUZs6PEwFj_uQMrotMRLfxZvPUbrG1l3znlrc6Q>
    <xme:Emn2ZnCAuudVvSKH5a-V7eE9DPvy8QpTVwcMbNYcc4YqwNIekfqmgUWjsYjAMX420
    tlmy1Niq39emA>
X-ME-Received: <xmr:Emn2ZuGnbbg8Z-DDsKMQ3nmJEoENk9Mzl9t8_wOQoqlwE8zUpdz2ZyUmNJVjl9zqmwKw3EWjrsV4vEKFXBUbA1v-epxK7xjHCO96XQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtledgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrf
    grthhtvghrnhepgeehueehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeel
    vedttddvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdp
    nhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrg
    hmrghsthhhrdhnohhrfigrhidrrghnrghnuggrsehorhgrtghlvgdrtghomhdprhgtphht
    thhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmih
    gthhgrvghlrdgthhgrnhessghrohgruggtohhmrdgtohhmpdhrtghpthhtohepkhhusggr
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsohhmnhgrthhhrdhkohhtuhhrsegsrh
    horggutghomhdrtghomhdprhgtphhtthhopehprghvrghnrdgthhgvsggsihessghrohgr
    uggtohhmrdgtohhm
X-ME-Proxy: <xmx:Emn2ZvQM1DHCb1gG1-8KuNID18Ga5a3aWZ_6maRST4t-MpHToi3PqQ>
    <xmx:Emn2ZjyAIIB4QYFXlVsT_mGwgBLgDw8I9LKcz25EPaOVDkW_q7bL7A>
    <xmx:Emn2Zt4dQ4FRVs-fTtvSW20FfoLAhM8cJT_O3M79M8meN84xDQh2DA>
    <xmx:Emn2Zgy9rtXMEQohsH0ZlAX6JbVn6OmnftJ42Rbs5kaJO7EDZfqrnA>
    <xmx:Emn2ZmoY9G7MG9wj3iOTFqv7T7lWbIIhdKlEkj4uR5g1bbxqMnZDymu3>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Sep 2024 04:13:06 -0400 (EDT)
Date: Fri, 27 Sep 2024 10:13:05 +0200
From: Greg KH <greg@kroah.com>
To: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
Cc: stable@vger.kernel.org, michael.chan@broadcom.com, kuba@kernel.org,
	somnath.kotur@broadcom.com, pavan.chebbi@broadcom.com
Subject: Re: [PATCH 6.6.y] bnxt_en: Cap the size of HWRM_PORT_PHY_QCFG
 forwarded response
Message-ID: <2024092759-civil-manicure-a56b@gregkh>
References: <20240916173102.1973619-1-samasth.norway.ananda@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916173102.1973619-1-samasth.norway.ananda@oracle.com>

On Mon, Sep 16, 2024 at 10:31:02AM -0700, Samasth Norway Ananda wrote:
> From: Michael Chan <michael.chan@broadcom.com>
> 
> commit 7d9df38c9c037ab84502ce7eeae9f1e1e7e72603 upstream.
> 
> Firmware interface 1.10.2.118 has increased the size of
> HWRM_PORT_PHY_QCFG response beyond the maximum size that can be
> forwarded.  When the VF's link state is not the default auto state,
> the PF will need to forward the response back to the VF to indicate
> the forced state.  This regression may cause the VF to fail to
> initialize.
> 
> Fix it by capping the HWRM_PORT_PHY_QCFG response to the maximum
> 96 bytes.  The SPEEDS2_SUPPORTED flag needs to be cleared because the
> new speeds2 fields are beyond the legacy structure.  Also modify
> bnxt_hwrm_fwd_resp() to print a warning if the message size exceeds 96
> bytes to make this failure more obvious.
> 
> Fixes: 84a911db8305 ("bnxt_en: Update firmware interface to 1.10.2.118")
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> Link: https://lore.kernel.org/r/20240612231736.57823-1-michael.chan@broadcom.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> [Samasth: backport to 6.6.y]
> Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h     | 51 +++++++++++++++++++
>  .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   | 12 ++++-
>  2 files changed, 61 insertions(+), 2 deletions(-)
> 

This breaks the build :(

