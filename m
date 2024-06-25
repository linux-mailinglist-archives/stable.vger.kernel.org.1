Return-Path: <stable+bounces-55772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B5A916A78
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 16:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 481A9B25F4E
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 14:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30743176247;
	Tue, 25 Jun 2024 14:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="h/2JJ2XX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p16LuvBY"
X-Original-To: stable@vger.kernel.org
Received: from flow3-smtp.messagingengine.com (flow3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB73F16C684;
	Tue, 25 Jun 2024 14:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719325848; cv=none; b=KOwiaBetMmzoe3ljN7ys84BcEoLKjDFrfjs9elg6FUj7lTGzmrswTfwpm1ABl0sYN5sRjGTnu6/BSr9DqyxEU2zdQHRVTZkgRNGzj9DIAmfHkeTvvVAEyJi56kIV3u4ecOhPfmTWY3BwZeVFj5ys00oIejgOxwj1BXmSjzQ8HR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719325848; c=relaxed/simple;
	bh=rm3CLFCzMhJqfskxnyAupX5rytUWBY3x7q/xs8yTacY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S69mo2VBMf1tDi0k7JfX6pU6dNduG3G956Wd4pcxfgNWnU3M+S+m21yhfpcYw9tHaXayg6ZCuVJwY0fUKvlfC+kxKwEQU/0iUWwts19kfeSAZJEIykko5db3ZHHtXmGAfjoy1nwxg5VbKIqdXHI9mOF/4HJsmpBTi1XjW1PT+Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=h/2JJ2XX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p16LuvBY; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailflow.nyi.internal (Postfix) with ESMTP id BDBD820045E;
	Tue, 25 Jun 2024 10:30:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 25 Jun 2024 10:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1719325845;
	 x=1719333045; bh=n40rkhfGjzu8AxDo0A/VhYrpxULagui6L3eRoobEu9s=; b=
	h/2JJ2XXSHYRlUkmpcnT1ZYxUEoM6+aze6cr1UQaAOuDFuFFq7+vZwHHjJ5+gA9e
	taFX8BCOJfr9P/3hlGF0KCr4czzK+1CRyL6PEPuzqAQj/hsvPAUG7r9p/mtX1Xie
	4wnUj30g3HssVJe0R/Gt6pQUbHv8pCX+J39cJZFFf0mW0yhotgEeTvLdXVQWGSry
	XvdNPh1t1gUkRzLlMOTOyX/crmFlxhq3xu1n5r5qFkUQx8ao8+NiTyIgmC9nt1kQ
	Yvf8cvzLGee5cjDVEGJVnShhckvCSRwIdSTym+vzBsBnf1J9wZg0PacopLPx2yQG
	FT8o4XUAGI8/0+btZP4cWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1719325845; x=
	1719333045; bh=n40rkhfGjzu8AxDo0A/VhYrpxULagui6L3eRoobEu9s=; b=p
	16LuvBYPifBPtp1l8HXW0WgcAp5qGByADd/cqp/p258PeINNUDIwl64Ivtnd/6jP
	KP2qFgL9nsOXI5jERVMjQCmcgaGb7OqEvy5gyng4MqOZbyFCuzeItKZ52RhTQ04x
	HT+CFMINatNqgVpUGWMR/8TkA10jpY0tKJ5ekhIM5jDwJXKEtlBkV1CX5PYWto/s
	hUq2OkPosmu+IUge0TffWt207BPm7za49vZA/ZjjKWEsaBx2CGn/8yMhBXRbxVlX
	foasR8S9k88K50s/VK6pPcKnfQrGs2gJnk2ItaeLbf4tG4VMVLWpdRS/CwedMIy3
	a1+bRPM/Or4YCy9tUGF1w==
X-ME-Sender: <xms:ldR6ZgBpRWP8mS3VA2Qms6OZM9ckhp2ODlyswd4iLVJMxG4GyYBVhQ>
    <xme:ldR6ZijR2bT4v8GuzSqLgvs_JN-mtU4fg_zEFVmVFTxaVi-xKN2ByhcgWPALxupLf
    W0rIPje73BbIA>
X-ME-Received: <xmr:ldR6ZjlW6CpJaTkmgHMK6qtDoy9t12v8oJoegXoTg_k_o2dozihWVxvTZa79t6Ria-rl3mmM8DVB6iPuo0DPe2x5la9fWRzcJmCfRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtddtgdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgfekff
    eifeeiveekleetjedvtedvtdeludfgvdfhteejjeeiudeltdefffefvdeinecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:ldR6ZmxY0zFwG6pWHsU-y6YkcmngJmKUn9oPpTIHsv4G346eRrdlnA>
    <xmx:ldR6ZlRyQYCTt1DG04kEg57pOpQ8KoojDGl47d9FpoQ1qWgp1cZiBg>
    <xmx:ldR6ZhbC6ybWV8DlIc4L8v9H8l8ZOOnF0r6vJpa9NY3LU5Do76bTkg>
    <xmx:ldR6ZuT4ptUDAasIrsTeXyADiCA_LMQqFynBKgYq7xqX3qlCrbtVCA>
    <xmx:ldR6ZnmM9XBOBtZyCNgYz6zqBuHcXPrEJjuGSn2Hkv78Acq8H7ggnLJC>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Jun 2024 10:30:44 -0400 (EDT)
Date: Tue, 25 Jun 2024 16:30:41 +0200
From: Greg KH <greg@kroah.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Ma Ke <make24@iscas.ac.cn>, nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
	Danilo Krummrich <dakr@redhat.com>,
	David Airlie <airlied@gmail.com>, Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>, stable@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/nouveau/dispnv04: fix null pointer dereference in
 nv17_tv_get_ld_modes
Message-ID: <2024062533-quiver-cacti-b068@gregkh>
References: <20240625081828.2620794-1-make24@iscas.ac.cn>
 <8517da06-3010-4356-b5df-d9a14454feec@web.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8517da06-3010-4356-b5df-d9a14454feec@web.de>

On Tue, Jun 25, 2024 at 03:43:37PM +0200, Markus Elfring wrote:
> > In nv17_tv_get_ld_modes(), the return value of drm_mode_duplicate() is
> > assigned to mode, which will lead to a possible NULL pointer dereference
> > on failure of drm_mode_duplicate(). Add a check to avoid npd.
> 
> Can a wording approach (like the following) be a better change description?
> 
>   A null pointer is stored in the local variable “mode” after a call
>   of the function “drm_mode_duplicate” failed. This pointer was used
>   in a subsequent statement where an undesirable dereference will
>   be performed then.
>   Thus add a corresponding return value check.
> 
> 
> > Cc: stable@vger.kernel.org
> 
> Would you like to add the tag “Fixes” accordingly?
> 
> 
> How do you think about to use a summary phrase like
> “Prevent null pointer dereference in nv17_tv_get_ld_modes()”?
> 
> 
> Regards,
> Markus
> 
Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot

