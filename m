Return-Path: <stable+bounces-55032-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFC391514B
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 17:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16F9D1C23601
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 15:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D667419B3CB;
	Mon, 24 Jun 2024 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="XbVQYQnn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CoEv1afr"
X-Original-To: stable@vger.kernel.org
Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120F119B3DD
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 15:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241424; cv=none; b=uvwpxTlDsNgAlOxuRPaumNXeap4FZjNGQxwhFOejYR2IX4LfanwjxkeozIZBHOMsSXg7cneGrTiHIobYBgzeaztSE0K89wGpnvtp6JU1cxtIh1kxI3BqBj9RX2TSanvvsrecAN7jFBwa9rkIxUiMiPoWff1h9/Rcuebpp60b4zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241424; c=relaxed/simple;
	bh=QvJ0d61aEXA0PMbPQl54ADIEor98DJNgNAXqypA9sFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgivzSNEuyhkZfjIRtEA1Dl8ezUHc235ovaswo6k4utx3myp2pU5HUJP4kHw7P8QT3xGpI3TOY8LUu5mgtsTvHtkqEw4J00qu/+h7Zf81MHAvV9X5scbSfFMtk1TFFctyBjSLF0aakHDXFP3UtbXub7DlP4DrV+7IiinZgl0YzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=XbVQYQnn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CoEv1afr; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.west.internal (Postfix) with ESMTP id AFFE41C0008E;
	Mon, 24 Jun 2024 11:03:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 24 Jun 2024 11:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1719241421; x=1719327821; bh=4pwBuN8hkJ
	qTQI93fLja+eeZn+NqmMdj8TPGI5UsfI8=; b=XbVQYQnn8QUNh3uwa+p/eRvXHD
	2lDEp7LnMCQrt5oQfetHhkpvXF3YUi30ODx0361dnbE46EA5UFbqyoJiahhSXAhM
	PTdM/aBUIvtoa6ytd4lRY6ZDgvZ25L8Vsk4rWVgYXTFICgS1ltI47Mxd4SDOknm6
	iKNScg1D30j2cNBl/Sfh8nJ+gpGt+IF0MA9C2xXx4s6d0Iv1wtES9WsZw+ex9pRR
	X0H0s6J38T4fFAK+/ecGLbZk3mVHjHPQIg4qf1sHcHqLtOtCVldSKmnUCk70wwcb
	Io/N1nOn02XmIId15+T0h4rNYs/y4S4BpLoiK8nnBqmt32plqJrBciie85sA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719241421; x=1719327821; bh=4pwBuN8hkJqTQI93fLja+eeZn+Nq
	mMdj8TPGI5UsfI8=; b=CoEv1afrbpn5T6bnjFtym8yd0ZT/zYCggidQ2B0ETj5D
	eAka61oCz9iw2v93XMmiZMEgrxlpmlv0VUBq3Qow6OqwlHPnZHs2qbBbssafvSxZ
	aDfhQu1AMaqulB+25nnL/QOTSLwtS/7JxQd5IjU8okNw5DCwQF5EgGAwIJDfbeUI
	LJj1X73OdJCR4C+Zn+CJX4gTPlpn/CEM7BDIHgnFDMjxbM7IoLihNZqe73d4CzS7
	Ybseo6Mmg8TkppuahI4RcSN8RSwPvoJ7RtXPTT6uXn1D2vCSVfvVOm7Pi8gd9ow6
	I/ARI0sMSFXFuqbPPwrCcI9i4QKUZVpRk4LG9qqDhQ==
X-ME-Sender: <xms:zIp5Zq7NQTOSwaNCZemvYV0yS3T5V4rVO321XYct6ru7OxW_KRT4Qg>
    <xme:zIp5Zj4DLbo-CRwP6ZFrWBKN3t9gG4XDsE4WoDgJfQ4fbT3cACKXa1Y6LrTD7TW3-
    xBLZ26zxux_gg>
X-ME-Received: <xmr:zIp5ZpdtnG5n93wUkJ3uGx3ZRVd_14G3wYpXoYuHLQbvCu47cuIfTyRC5sCsMu6E1OYeP4tNxCgqzmXlGaXdawjw0Q1PziI70pKdIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeguddgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehue
    ehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:zYp5ZnK_J-GkNEwdOPXxjRiP2QuWTMXQ2-3JruehtLnkVlp__aYk4g>
    <xmx:zYp5ZuKzSCnyGg5pWURdH9UFp6aTXPjrASMgK2uWdEs59gg7xmgZSQ>
    <xmx:zYp5Zow_0DZ8XYoRmKmGoXvc2xJuSogrqzr-fjMf2Bafhql6wZYBJg>
    <xmx:zYp5ZiJocN_CLaY8ZU8TwM80B9EFS1LP0qb3-iT65cBQsBhreA29Qw>
    <xmx:zYp5ZrACrN-3486k2JKXzFgDiTTVkH45njycnVijrNiKkW6ry76jGLWd>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Jun 2024 11:03:40 -0400 (EDT)
Date: Mon, 24 Jun 2024 17:03:26 +0200
From: Greg KH <greg@kroah.com>
To: Carlos Llamas <cmllamas@google.com>
Cc: stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 6.6.y] locking/atomic: scripts: fix
 ${atomic}_sub_and_test() kerneldoc
Message-ID: <2024062416-engine-client-8b0a@gregkh>
References: <2024061810-overflow-president-399a@gregkh>
 <20240620181805.2713680-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620181805.2713680-1-cmllamas@google.com>

On Thu, Jun 20, 2024 at 06:18:05PM +0000, Carlos Llamas wrote:
> commit f92a59f6d12e31ead999fee9585471b95a8ae8a3 upstream.
> 
> For ${atomic}_sub_and_test() the @i parameter is the value to subtract,
> not add. Fix the typo in the kerneldoc template and generate the headers
> with this update.
> 
> Fixes: ad8110706f38 ("locking/atomic: scripts: generate kerneldoc comments")
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Cc: stable@vger.kernel.org
> Link: https://lkml.kernel.org/r/20240515133844.3502360-1-cmllamas@google.com
> [cmllamas: generate headers with gen-atomics.sh]
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---

Now queued up, thanks.

greg k-h

