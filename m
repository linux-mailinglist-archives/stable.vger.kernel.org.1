Return-Path: <stable+bounces-10629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EED82CADC
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 10:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED1BA1F22CC6
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 09:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5390A139F;
	Sat, 13 Jan 2024 09:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="VlDQSWQA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f77i6E/8"
X-Original-To: stable@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4107FF;
	Sat, 13 Jan 2024 09:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id D2F365C00DF;
	Sat, 13 Jan 2024 04:36:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 13 Jan 2024 04:36:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1705138597;
	 x=1705224997; bh=G/8vzDoHJJe5FmlpmYScJm7AYOddcrC0mCxZjU6lhIo=; b=
	VlDQSWQARUFGITc3SUtZdcYBPaequO7HZg3iOpK0Yj++0fRVz8eF8P5dEOHo0IW2
	DLaf6+vHCdKXshTfZQ2aX5wcqx9o4pQXk7wUTeLAmf44dr4u2ONFzN+awB5enPX/
	kLIOAo5fewk5Cf664nT5AQutbjniMXb0LIAxBx2vhzIOEPx/ILYVns79pn/r4TJv
	M554GZa+2pGlcCzRsWWX8OSjJWudmLkqil8wY3ov8sEevRQZRkxnxRFDif6Xk4Lm
	HrtXaLfQyl98NzYW8uiQ4zU4wnmzt/VlIUglTHKbjs9drwkSDHMzo7BrN/1a/lEE
	WaU4D0IWwoJP5YgwBbH+Gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1705138597; x=
	1705224997; bh=G/8vzDoHJJe5FmlpmYScJm7AYOddcrC0mCxZjU6lhIo=; b=f
	77i6E/81FQwCb87IcI61WDsOU3NwE8LmW5mCoZUsWuWNtgJck2ejBMBCUtt5P11i
	70zoZi0WXzCtzP/QF4rP3YV03NjThHggY+4r2RErZcjNPsjAkTBfAjBRNgum+CkZ
	KWh6CtrSUznDaC76WI6EfbD8Xv6XfEAiedCwo+d55X1ErRJ6as/9xrr6AgOicycO
	hgCk8pkBJ7IbSfumxq0x6IOJfR65Z4SuJpZoc0+KwKoeqNOSrTzOB8a8wVv3aHwk
	SERYUw28iHWVuMLaI2Hrgb9Wp2//lF3LrDTmKDt0T0BojqVLBye/dM2T/P45+l3p
	JtKRGN11/0McwUTKQ59eQ==
X-ME-Sender: <xms:pVmiZZ6iwKlR47_PtzcCQpEVVk2F2zoMvtwoNrzE1KqGSvBsUF78nQ>
    <xme:pVmiZW5NvY7xbgVs20icuZpFDamXJXTOblScjNq3Xa5D16lpLHIJVIGE5NxRHBBLu
    p5dSPJ9Hy_I7w>
X-ME-Received: <xmr:pVmiZQck85bW8aK5eebxPjeeDpPYxfALEr2ZDjhjOmfHaZRZS24SMjEDaoUhttTwg9ml0tDytHVi80D-kWX_rG7RRFib26Ey2ZFeMpTO2Uc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeijedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpefgke
    ffieefieevkeelteejvdetvddtledugfdvhfetjeejieduledtfefffedvieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:pVmiZSINPEV6hgb3Whpy2Lq6QEBeUz2FWIrqwzL4kDer4vuxd9s7yw>
    <xmx:pVmiZdLn-UF8WlHj9IPXwnNBd8sRE5zkg_L_H-d3y3le8A6vW2O2wg>
    <xmx:pVmiZbz8LPBIdSChiaKwSrvVcnKKh4nk1XqI-2w_mt94wzNm55RHIA>
    <xmx:pVmiZaAS0g9z2Nr2pRkxgmi88KPHFwGMVmLWwP9xSRJWi02PFC6sKQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Jan 2024 04:36:37 -0500 (EST)
Date: Sat, 13 Jan 2024 10:36:27 +0100
From: Greg KH <greg@kroah.com>
To: Justin Chen <justinpopo6@gmail.com>
Cc: Jeffery Miller <jefferymiller@google.com>, stable@vger.kernel.org,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	kuba@kernel.org, linux-usb@vger.kernel.org
Subject: Re: [REGRESSION] In v5.15.146 an ax88179_178a USB ethernet adapter
 causes crashes
Message-ID: <2024011321-clamshell-chirping-f5d1@gregkh>
References: <CAAzPG9MU2PfTk2Yn+spJqH6mLVsG1p6L6vhJ4LFG+aiojnN6HQ@mail.gmail.com>
 <CAJx26kVJ=TxxejKACMJOoiEZfwpFJ9A3SGncBtd8QyWM5+ew0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJx26kVJ=TxxejKACMJOoiEZfwpFJ9A3SGncBtd8QyWM5+ew0w@mail.gmail.com>

On Fri, Jan 12, 2024 at 11:32:13AM -0800, Justin Chen wrote:
> On Fri, Jan 12, 2024 at 10:01 AM Jeffery Miller
> <jefferymiller@google.com> wrote:
> >
> > For 5.15 attempting to use an ax88179_178a adapter "0b95:1790 ASIX
> > Electronics Corp. AX88179 Gigabit Ethernet"
> > started causing crashes.
> > This did not reproduce in the 6.6 kernel.
> >
> Looks like my patch set was not fully backported. The patchset didn't
> have a "Fixes" tag, so it looks it was partially pulled for
> d63fafd6cc28 ("net: usb: ax88179_178a: avoid failed operations when
> device is disconnected") which does have a fixes tag. Just looks like
> a bad backport here. Apologies, I should have caught it when I saw the
> stable email, I didn't realize it was only for part of the changeset.
> 

Now queued up, thanks.

greg k-h

