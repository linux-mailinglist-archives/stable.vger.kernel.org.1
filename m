Return-Path: <stable+bounces-41770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1648B65F3
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 00:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A8F1F21E98
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 22:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FA438DF2;
	Mon, 29 Apr 2024 22:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="Fypz/9Js";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gKpafJve"
X-Original-To: stable@vger.kernel.org
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21761E886
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 22:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714431578; cv=none; b=XOVCrSprFMkXtEu+Y+/Wy8/kS020Au4KsxQpy0tKAUpH0fXxy0pvyE/jDjiISLMDn/zLNcIYmqmhJRGzAhnTmKLUJ3KiXjiaIjxABa5/CDlPcJFEQ36GLJFYFrgISu36Imv9SvZPvX/lDtSBdjOzC72Vd98ZpBwIdQhL0/CHtSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714431578; c=relaxed/simple;
	bh=b7PuDTfZzum8/mOGBQEB7kq2YuRHeGNR1tSITz++qpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRi/PflVboTrDDTOFBtGCO2nwO8ddCUKkZS7sELlCYDzX5TkJ6tUiFyUWlaY8lO+lyC/5ZLMEtHLY1ijU/fwORfCHBJTmfs8I4+L68o0Nb/Utsk2M0umQ09ZqAGTPo63dV+Ay31Q7Nqx04E03xDldjl9Jk7SHeMweaXr3CGOEEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=Fypz/9Js; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gKpafJve; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id D035D138037F;
	Mon, 29 Apr 2024 18:59:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 29 Apr 2024 18:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1714431574; x=
	1714517974; bh=ow7pbetPiD769eRr/jvSgAEgZbwWNOQZgRPag4f9+U0=; b=F
	ypz/9JsjCxZUPjCMEw7UanvhgGP5OEoyCsIiZfdBy1w+XA4f0KsUQ1wI95Z86nOo
	pGLyt4yov/BeMJ/4E9kDY4QWYtQWkF+cnSDClKnUIQzC8HtL3yrEoGZqQE/nbeSk
	TLx1l266ZTaL9SYeBwVxLUjVal7kiXZSbrvvIceRU0EgHWVxr/tfOywrsNyEtqS5
	IYXQnIjdeB/l/6enJ/d4qq7kJyR6JTtnft/6vCjPf6zMQOjJmSvFnx4woafvs5/G
	0st1MNG4rRKXbu8Omp5fDqXSHj2ZHQ7piTXKXllyBtdF48Bml5ZeChjXEJ6farvF
	ikB+UFaKOFVDEUlAZ7eKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714431574; x=1714517974; bh=ow7pbetPiD769eRr/jvSgAEgZbwW
	NOQZgRPag4f9+U0=; b=gKpafJvezhc91yZCFmMuiQ5Rg4xchKN+mT6dlsIdMISM
	rZa7+Pd/kKKpdioreIDEMye7k5Z/4/evfmpaXBFz1/1/6GwN5FHXiOAlD0qAzgJH
	Tp2lEu2nvgG5YNKrs/qFP4WEcE0sPmvd9JIarBMSkAl6tMioZRATdjC2lfVvjOz0
	jLAAM33OejnQpVQK6zd/+BA9WpDPZBdXF5kP9YGbrmNzUpt9DY/WksO/yHVEVMu5
	59eWeCGPVmKfkvWbvCUcWMGPNULzWAch/2mDK79pfXv3EkVe6mzS8p/oFgT10t92
	iKK6WrI2FVyyDe6tT9vhwY0Pp/ymzKHi4gfCIL2AgQ==
X-ME-Sender: <xms:ViYwZv7DBGA6D9sPleS-NSTCVRTpGitaGoyyJt1Efmub9JvJb7LZWw>
    <xme:ViYwZk7DO2TujUlowfA9LLMd7scUNQLrnkFgSo4NOZDhywnSr7FIlSfrFS5Y5WeII
    xsO2RZgP96RCTgBjXU>
X-ME-Received: <xmr:ViYwZmeUMga2dm_lTdeXYZmqPOfRay0fKTaX0SjoFADnYTH4YgaeEFFs6lT8VOGGoi1pvxL5dSGZea2-oWZwDONQF2XDYXCao3c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduvddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeehhffhte
    etgfekvdeiueffveevueeftdelhfejieeitedvleeftdfgfeeuudekueenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:ViYwZgImtXr2hLn2Nyzbc0NuCIdyh13HLulYsDjvRpvBQe-EGdsLyA>
    <xmx:ViYwZjK_YgHnt3j2FKNNaBBpUtxnUEaw7oX8fTt5ch5aLmUcxafyXw>
    <xmx:ViYwZpzw0G0fSuEyskLbaGo36E9U5BiSogFIUYjIn8SQPUTOU3kTog>
    <xmx:ViYwZvIrkASSTIdigZsRqFWzaVD4zfkVit5mCnVmSx66YZUCtfdEiw>
    <xmx:ViYwZqXAf--Rg8PhT9QNE-6QuFVjIDonrEz0PUHKYwgGHw0boXGe-mAF>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 18:59:33 -0400 (EDT)
Date: Tue, 30 Apr 2024 07:59:31 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] firewire: ohci: fulfill timestamp for some local
 asynchronous transaction
Message-ID: <20240429225931.GA714896@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	stable@vger.kernel.org
References: <20240429084709.707473-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429084709.707473-1-o-takashi@sakamocchi.jp>

On Mon, Apr 29, 2024 at 05:47:08PM +0900, Takashi Sakamoto wrote:
> 1394 OHCI driver generates packet data for the response subaction to the
> request subaction to some local registers. In the case, the driver should
> assign timestamp to them by itself.
> 
> This commit fulfills the timestamp for the subaction.
> 
> Cc: stable@vger.kernel.org
> Fixes: dcadfd7f7c74 ("firewire: core: use union for callback of transaction completion")
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  drivers/firewire/ohci.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Applied to for-linus branch. I'll send it to mainline as the fix for
v6.9-rc7 kernel.


Regards

Takashi Sakamoto

