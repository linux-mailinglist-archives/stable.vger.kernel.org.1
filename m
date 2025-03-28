Return-Path: <stable+bounces-126912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C5EA7446B
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 08:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59AA417B956
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 07:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98F621171F;
	Fri, 28 Mar 2025 07:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="goTTTOQ0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SxrUfOHW"
X-Original-To: stable@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FE918871F
	for <stable@vger.kernel.org>; Fri, 28 Mar 2025 07:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743147797; cv=none; b=UdJNxSjoPjLTHxX6zv2ybGy3g7QBJdwSp7QbYD7XvinfELiHhEya/bXc9dkr/JATAjc27LoiGWbcxNp498t/nQJOFqug/fhMvBU8iKOsLABi1P0MsZfc7cO9fSAmgZJFVnGt7XhYHnj0Za9P2DYBJoMmwW24ukVNdvUCGBFrLT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743147797; c=relaxed/simple;
	bh=b/viEq97jcdvMBR3yQRpuWRBRYuA924NYKTuRO1lGhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jg8TOH/s8aGE2GPsbVaJpj52yGQfx9jE94lmE12PTcCkqvlbd+4IckZrmXeRLOOOubpxnqf/mbvrfxS9+mqkm5dWt+P4ZIXY2ounNKYGA60riwVAwC68iBPK96VvYRaYm5HDn4LDq3pyVdTMKyE5x9uvsJy03R5EWYSXx4aQfLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=goTTTOQ0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SxrUfOHW; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 1945C1382C97;
	Fri, 28 Mar 2025 03:43:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 28 Mar 2025 03:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743147794; x=1743234194; bh=qf1DxZ8MTM
	JC3aQWwL67qTQb3Ac1N9CwbfaoxbwdtT4=; b=goTTTOQ0tQzsIJ+ylJRoTgqeg3
	24xCnp0S+0wUJwwIyK5oK8enzS4q4U5C8Ewh6Z4hG07pNhWUDoOUIMQXMgMegW24
	pwuaFrYq6EjDkHQJshxu8B3tGt0KBaAtkCLciUL1d+O/hzTlXJdPxS8uQpTuKnPj
	tlWexpfY/UK/0LgcRJZUGAxSzm+jNmEDefW6Orp6qbdlCrDtc4FI95LK7xIXdnfJ
	muJEGfA7IWkaooXVwckC6qj6C61FmgjyZivEAb1T4amNQck9xAd3k1GN8cUuYQ5G
	4wFe2LFyqKjETe3m0hREYk56CDldizaJsmu5smiulv5z1EL4AXHRxdk90XXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743147794; x=1743234194; bh=qf1DxZ8MTMJC3aQWwL67qTQb3Ac1N9Cwbfa
	oxbwdtT4=; b=SxrUfOHWAvo+7eMM8uVLTewQ5PxKkYVremm5+KIQSxl3fOCxb34
	Lk3r6YnXWHcwHF61pjhYa/On+wlv10wdzZ6JBBZf/li1qsJ27tLJpkH0rafSeIGr
	AbKpe3WSrKXPpiq8N24pUqzmYkp52deqnSa4vB4UmJzy0uOD5XQ/9+JggoICHRLG
	uYCDFnUyeyW3b4Pw/rzIfD5lYlAhFmPx6Bo9dMxAledsZRcr760k6/kEyPdInmj/
	8Fo1ojz4MiFwXtsm30eEjQWORLvqT0TWR8UQ/DWSydJeU8u6CNxpYkwFF97tYJVJ
	E69qILJZYCEepkIvoHRcsrjCJvc/mH3ObBg==
X-ME-Sender: <xms:EVPmZ8pJHA3jzvKRGpKMW1oFq-z8REg7ddT-dI_HDUeNFy9CgcGL1A>
    <xme:EVPmZyoDhXmwlNpRk0E2V6oPMGwLcTZwMq-o6A0MOxUweVvJMfwDQcV70sREXfrvB
    7MRC_3c8iOpww>
X-ME-Received: <xmr:EVPmZxNtkoxilOwkJpXv-b3HAl0rqPRA0BJltZP8zDs6NHcB77b5nsX2E71kmZ2LOoOpmWZtbzfGydxJ81FnEqpY_bTFpF8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedtjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecugg
    ftrfgrthhtvghrnhepgeehueehgfdtledutdelkeefgeejteegieekheefudeiffdvudef
    feelvedttddvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtgho
    mhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hlvggrhhdrrhhumhgrnhgtihhksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtrggs
    lhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgihfshdqshhtrggslh
    gvsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepughjfihonhhgsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegutghhihhnnhgvrhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:EVPmZz7vvrQxnCUiRGBLwilCN4BNv2g7mA97NHt1VdZMMTmTdgxAng>
    <xmx:EVPmZ75VqQ27PSMN2O7qngadH1xptuf1fAY6NdDtUCZCnI5Kq7jYXw>
    <xmx:EVPmZzjSMESB8ta4exntmmzDDl-8zg024pKzacwQg-Q8WWBD58C7Xg>
    <xmx:EVPmZ15j5bOZ_Y1U2WHrsVNpujJMPEWyOrwNcOWWzavadq5LV91B8Q>
    <xmx:ElPmZ4zTKHWGk6bTANMaDg2u6HCv6Ui2BV_vCtHvAMxI1rjTUkM2w9Od>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Mar 2025 03:43:13 -0400 (EDT)
Date: Fri, 28 Mar 2025 08:41:49 +0100
From: Greg KH <greg@kroah.com>
To: Leah Rumancik <leah.rumancik@gmail.com>
Cc: stable@vger.kernel.org, xfs-stable@lists.linux.dev,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH 6.1] xfs: give xfs_extfree_intent its own perag reference
Message-ID: <2025032842-enamel-tarot-6b5e@gregkh>
References: <20250327215925.3423507-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327215925.3423507-1-leah.rumancik@gmail.com>

On Thu, Mar 27, 2025 at 02:59:24PM -0700, Leah Rumancik wrote:
> From: "Darrick J. Wong" <djwong@kernel.org>
> 
> [ Upstream commit f6b384631e1e3482c24e35b53adbd3da50e47e8f ]
> 
> Give the xfs_extfree_intent an passive reference to the perag structure
> data.  This reference will be used to enable scrub intent draining
> functionality in subsequent patches.  The space being freed must already
> be allocated, so we need to able to run even if the AG is being offlined
> or shrunk.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> Reviewed-by: Dave Chinner <dchinner@redhat.com>
> Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> Acked-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
> 
> This is to fix build fialure noted here:
> https://lore.kernel.org/stable/8c6125d7-363c-42b3-bdbb-f802cb8b4408@web.de/
> 
> Tested on auto group x 9 configs with no regressions seen.
> 
> Already ack'd on xfs-stable list.

Now queued up, thanks.

greg k-h

