Return-Path: <stable+bounces-4965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CD9809B42
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 06:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CB961F21313
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 05:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62722525D;
	Fri,  8 Dec 2023 05:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="EofmHpNL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0JoNE5lc"
X-Original-To: stable@vger.kernel.org
X-Greylist: delayed 387 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Dec 2023 21:02:54 PST
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6AB10F7;
	Thu,  7 Dec 2023 21:02:54 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailnew.west.internal (Postfix) with ESMTP id 492732B00124;
	Thu,  7 Dec 2023 23:56:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 07 Dec 2023 23:56:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1702011381; x=1702018581; bh=PI
	Y64CBSNt0PPb9bxeilH/4eQNVTuavlLXd+xLtdLt4=; b=EofmHpNL/cIg5AKToO
	umxa3/vm8NffW15CQ/NYWKLTmOntZUlTXzL07BQN9Zzd1qkj/zIQY2BNpeU3NNnE
	DsyuHH3WZaGBzjQorUzlwiFe/4NPCQlENpKqreDBuJVMeLp6sZaNlIXcysHdaNRc
	VEBzwBp21QplxcXEbl27bmgnF5pmLSDH0ONvG3vpQ7j3dFUXRgm6b+dWV4nd4HGl
	SWheN6zX7f77TSnmKwBt69fMkeY7vcpYMbjU7GbnOXep63hQWV1N/LSBPbrYOTRp
	fXLqehXrXtZqsPTcqJbc3tosb+da+i8EQrUzDBVMvjAsRUUs+nAZG0k6OSVXdw8F
	kR8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702011381; x=1702018581; bh=PIY64CBSNt0PP
	b9bxeilH/4eQNVTuavlLXd+xLtdLt4=; b=0JoNE5lcC5CNnZsf0Wrxk0j03GnnD
	jKhNB/IWHt20uvZzwI8UD4N+ZmDmCB7ssaaymo/kcvUG9aTopzcCzQC/kIar85eH
	FF73aIfF48k+sJCT6KDh2qwa4MpjeIS8zono/MVUEsiM/KpsAwbbQDRFyrE7JP6t
	iZ+SdSRt+D8vWJNgNstFf7rxNYiEfRWIO/LXVRKWJEc5rSrblhxPCO3hwsPyJ2MA
	BWB1vtmLc1nS7dNF4hkptHIe+jCQfQKYq6S23Rj84g4b85QqQsisSTFc2aXhhm3q
	lfGZwhLYxEqTogHcPiuVYoVmuQyjsJtiomiXqlN1FbTEortKcfJ3ehxew==
X-ME-Sender: <xms:9aFyZYCQddBddhZLtTdmaCagb1YejJJydeA7lnR9rCFc2q2T68f5Rg>
    <xme:9aFyZaii19_64B-wL9K1uZUjRIE0pAy_5jb714kJnHdyH6bLJuIQ2-8r6Gk8MGV6-
    SmpbysNcrM9zQ>
X-ME-Received: <xmr:9aFyZbmJM6VIeIhwKoz-C4nYvlKCuRI71S6CIsmYX141cRu6ODga5VANakJmYUtEfjoWCeTgzgfOBv2l4u53-EaJGhnT6Spfxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekhedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:9aFyZexFHU7norGA_X7Vuge-0fgLPT5e-anhtsm-yBQXlpEC96Xu2w>
    <xmx:9aFyZdSRHOl3NF57458as0Ve8eZCYGAaF_n1-6gqdF1RZ0r7dlPAHg>
    <xmx:9aFyZZYrhbQQaBlzWULnF1wKDDRQooLtJAJuUYqDs3mhE7PSQ08drQ>
    <xmx:9aFyZeSODrZnAjSz5JEizXuxoWQeQSuK2TXNjmKIflKUcWV2ydV1ReukdwI>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Dec 2023 23:56:21 -0500 (EST)
Date: Fri, 8 Dec 2023 05:56:19 +0100
From: Greg KH <greg@kroah.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	davem@davemloft.net, edumazet@google.com,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, oneukum@suse.com, pabeni@redhat.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v6] net: usb: ax88179_178a: avoid failed operations when
 device is disconnected
Message-ID: <2023120813-yummy-scrubbed-517e@gregkh>
References: <0bd3204e-19f4-48de-b42e-a75640a1b1da@rowland.harvard.edu>
 <20231207175007.263907-1-jtornosm@redhat.com>
 <d8c331dd-deb1-4f12-8e66-295bfac8b1d7@rowland.harvard.edu>
 <20231207123256.337753f9@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207123256.337753f9@kernel.org>

On Thu, Dec 07, 2023 at 12:32:56PM -0800, Jakub Kicinski wrote:
> On Thu, 7 Dec 2023 15:23:23 -0500 Alan Stern wrote:
> > Acked-by: Alan Stern <stern@rowland.harvard.edu>
> 
> FWIW I'm expecting Greg to pick this up for usb.

Sure, will do!



