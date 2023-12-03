Return-Path: <stable+bounces-3731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E378023D6
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 13:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 728901F204E1
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 12:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F6EDDC9;
	Sun,  3 Dec 2023 12:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="RgM2IiZH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sCRwjC1F"
X-Original-To: stable@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE109C2
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 04:50:19 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 2F0E65C0099;
	Sun,  3 Dec 2023 07:50:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 03 Dec 2023 07:50:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701607819; x=1701694219; bh=I3
	ucwdrspbk0VS5Nt5+RUiMLnCZcI7XGOrNj/XfP4MA=; b=RgM2IiZHrMBZCye5z2
	SZ3yaBCWMk42Q6a/yN85CGu47GLGN0NGHHcHiaOh/wvfxDAvScTEry0z2xVKtRSP
	JT+RUYQlfVfBy+21IBTP5CApkgYEPU5UorPQeDVWQLrHtO/QCCwoiT0utUi2Cla+
	6QC3qABnYWYPaS85DubUijsZcwipuw928yOCkCrTq870YWuSW/NcwqO2uBIB2Vmj
	U9IFav2F3W37ye05L8+/RoCp2t+nx7/ZCoshjzUkPXxmn8bhnEAuUks/gm9/19eE
	qDpCrYaTXFtfvn+NA6AvvPW7Zi7PYdML80g7eIDbRsFy5dYfGZnWbnLP7Lbt45At
	9cBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701607819; x=1701694219; bh=I3ucwdrspbk0V
	S5Nt5+RUiMLnCZcI7XGOrNj/XfP4MA=; b=sCRwjC1FTtNbDaFOYmI9p/SwVL94h
	9MHg91cJunV5GAl/1kjaw9uw4Gig9pCa31eQl58KuQe+JGdTx8yifYD1dxpXouwY
	Js1AK4H3eea1TNt+FhCqI+Ai2NbdsL6G3Z16iIVeWvTMBA0Q2PSsLJFLAtCyCXnL
	CksCt5DPKJu2onWJCy+/7HD05BrOEFUBCLxq2eQzqxYkTDouVXdKNGNSG2pfSZD9
	thc6fE81/ygGQYMo2QkoTt/rXh6axWm6IbBIW7kd3Q6XWuPoLJYcKyjlR8GB9yiw
	wwnjv6kLu0KJOFLndVPL3vT6eTB4ld43B6K0PBBsafTR65QfeJXuob9dg==
X-ME-Sender: <xms:inlsZWkDbczucoJ-5mdy3_gQv2rG1HW_BND1VD0Yd3heBlaFsNeP3Q>
    <xme:inlsZd3lPHZfAwudxNSBSUfTuQmYvRoN5QgAI9qepkPxax-tMdlSvvC06t50Uo-YB
    ajRxUv0VBN1xw>
X-ME-Received: <xmr:inlsZUrFjpPCrnsOf6nZD9FYVh4RjvtSTHVG8ajg7k19QPxhJVh94l8sa3qS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejgedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:inlsZanoJWr6ZhQiJmhNcMQHODQQUiztGJzXChlOBVOSBhTZXxZEQw>
    <xmx:inlsZU2qO4frjXRIWwZSKEKSqYJbC_UNYVsVZ81dpZGpsiaIFAM1DQ>
    <xmx:inlsZRtNS3VEFxAf0HnA7x_bNxPCvg2DkxyoG2jyhoIdAA5e1IcsYQ>
    <xmx:i3lsZVKUAfJ-Se7WAXRKiWK0ZM82aFHkeGClTy2orVny5oisiUvODw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Dec 2023 07:50:18 -0500 (EST)
Date: Sun, 3 Dec 2023 13:50:15 +0100
From: Greg KH <greg@kroah.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: stable@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Pablo Galindo Salgado <pablogsal@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: 5.x-stable backport request
Message-ID: <2023120309-veal-kinship-06f0@gregkh>
References: <CAM9d7chJ8kP5VP+SbQzFfhvRD49X5qccnzysY6hJHgWG2KSLbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chJ8kP5VP+SbQzFfhvRD49X5qccnzysY6hJHgWG2KSLbw@mail.gmail.com>

On Thu, Nov 30, 2023 at 09:29:53PM -0800, Namhyung Kim wrote:
> Hello,
> 
> Please queue up this commit for the v5.x long-term stable
> series (and v4.19 too).
> 
>  * commit: 89b15d00527b7825ff19130ed83478e80e3fae99
>    ("perf inject: Fix GEN_ELF_TEXT_OFFSET for jit")
>  * Author: Adrian Hunter <adrian.hunter@intel.com>
> 
> The 5.x stable series has the commit babd04386b1df8c3
> ("perf jit: Include program header in ELF files") to include an
> ELF program header for the JIT binaries but it misses this fix
> to update the offset of the text section and the symbol.
> 
> This resulted in failures of symbolizing jit code properly.
> The above commit should be applied to fix it.

Now queued up, thanks.

greg k-h

