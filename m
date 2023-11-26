Return-Path: <stable+bounces-2678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9327F91E0
	for <lists+stable@lfdr.de>; Sun, 26 Nov 2023 09:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADC8A1C20A14
	for <lists+stable@lfdr.de>; Sun, 26 Nov 2023 08:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704C620FA;
	Sun, 26 Nov 2023 08:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="IFeHeI3I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bQNrRvSV"
X-Original-To: stable@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89DFB8
	for <stable@vger.kernel.org>; Sun, 26 Nov 2023 00:48:53 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id A6A693200A4E;
	Sun, 26 Nov 2023 03:48:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 26 Nov 2023 03:48:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1700988532; x=1701074932; bh=AN
	LSh+5b6WXiSBgs3s/R21jNevuj/8+3c92+vAL3M5o=; b=IFeHeI3IWfXG68Geth
	LCsjvkj27YHDqJtSgVU5MLqvFqypexFMWzbm8ySfOzqLZcslDIBVzTHb/mkApBEZ
	jl2EnS5gYSxiUvmOtc+jQ+uDvFwd8Y7LMnxD+PR/8IpHnWcWeEYnPKjdtcp+sAti
	4KR77MUd4u4xVWa9H4vVogsWf2cDjknSqHBWU856BWb7mufdYUJB6w49tDtQSXpa
	RmxQ1Ma8lmGGlnpiu/JK0BsTCSdV3V6CPM82EyL0oZJosBiqdKNndHVBeuTSInJy
	N+ktwiCodIWKmdtzknMW7fok1C+Yumx8bJJe/Y7lx/e5q2AwqaYUs34YZK2Fea7d
	xKxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1700988532; x=1701074932; bh=ANLSh+5b6WXiS
	Bgs3s/R21jNevuj/8+3c92+vAL3M5o=; b=bQNrRvSVH2Iu2XKXakxBlSUr1JBvW
	LvyJ6EcV0KnKvtUtRrJdKZPRaywdh5GIYe3J6Tuii/ZMly46b1ZCrCMVa3Ju3Rjo
	OOUeA0J+AY7+cxcyT/yNwKdTWb4NwH/ReQbgM+nud5wk0FkDVIagrZ64teVD6xF4
	3UkvSnTfM4KXJrLzo2Av/frRYXaV5MC4lhmy04a38Pe4oZZoFEbqvsll+WvxzZvQ
	SCVnPtzUgXTqVClbg7wdq4VJ5uj8O5+VLuzbfEeoyNOT0xYDOz7adn+AHV4OmOY0
	EJT8khOXQSXSvKW07IGwj5kkgpaBcItL7JRqYZAh+/hP5Jb5oAe6lxFDQ==
X-ME-Sender: <xms:cwZjZcO-__qpVizYEfaz6bZxaE9L3Va5Zsi6R_mc-NhSu3hVfFWj6w>
    <xme:cwZjZS-HAeIgBxQWar245jP6TQ3Axg7hc24IJ1xVdoltHp3rJFItt22RNuo8FJzmO
    d9i-ojxla3-7w>
X-ME-Received: <xmr:cwZjZTQhz_K2JlSjx2NCBZ5s8U-Q3yoxEJaDTTmtSXXQgjgeIYPadr6E17-mcVe8ppSLxvV1lHYgdONg3dv9PuJRTCD6ykj2blbTLqya_Ugz9fY1ElPCaUc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehkedguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesth
    dtredttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtgho
    mheqnecuggftrfgrthhtvghrnhepgeevudevuedtgffhgeevtdeludelueevleegteetke
    etudffgfdufefgieeileeinecuffhomhgrihhnpehgihhthhhusgdrtghomhdpphgvrhhl
    mhgrvhgvnhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:dAZjZUtH2XKWrJPhA822qaU-a8JXiQnjMRshV1rGRc6iKXLgt0NoLQ>
    <xmx:dAZjZUeB-Bv15DaKaBCTrKwOQoRnA4tWuoXiZA8N-QSYf3wI7Rglmg>
    <xmx:dAZjZY1xT23RCIX7R1YnXhDqcMdfF2F4taif7ILqT7IA00gfl1mRnw>
    <xmx:dAZjZVrQYXgeLoyGm3KrizFoJFib8ThC0XdzwEHJN1BJl1C9MLL40g>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Nov 2023 03:48:51 -0500 (EST)
Date: Sun, 26 Nov 2023 08:48:50 +0000
From: Greg KH <greg@kroah.com>
To: Dan Jacobson <jidanni@jidanni.org>
Cc: stable@vger.kernel.org
Subject: Re: Say that it was Linux that printed "Out of memory"
Message-ID: <2023112613-decorator-unroasted-500d@gregkh>
References: <9399ce7b9ffa0ff6da062e9f65543362@jidanni.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9399ce7b9ffa0ff6da062e9f65543362@jidanni.org>

On Sun, Nov 26, 2023 at 10:40:36AM +0800, Dan Jacobson wrote:
> In https://github.com/szabgab/perlmaven.com/issues/583 we see to find the
> simple answer to "What printed 'Out of memory', one must consult the
> experts.
> 
> Therefore the "Out of memory" message needs to be prefixed with the name of
> the kernel, or something. Anything. Thanks.

Prefixed exactly where?  The kernel already does report all of this to
the kernel log, saying what program was killed due to out of memory
issues.

thanks,

greg k-h

