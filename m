Return-Path: <stable+bounces-17787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD54847E2C
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 02:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28A58B27BB7
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 01:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF4E1877;
	Sat,  3 Feb 2024 01:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="jqIJVptu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dyr0hKbr"
X-Original-To: stable@vger.kernel.org
Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B116D3D62
	for <stable@vger.kernel.org>; Sat,  3 Feb 2024 01:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706923888; cv=none; b=aMHRNr5OOJPl+3sy+hQMNroP1cDP4HNRZYQQ9ogBfNO1YTg/ahzauTIO4K9f4VE/R4Je/FUBjTEBwxMxXwHa0r6e3egBqjYFkvu5W4bIyzIUO7fECyuWEP1tghzvJTchaFYqd6DePSPVaypiqj+TNTMUPk80OL9qIwTCWFcWEu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706923888; c=relaxed/simple;
	bh=Sn+5pnIuAcEh5G7/OPKObR2P8NIDU95JVLz9nxGQGH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQo0AyOy3R76TmI9uCxKVUm3/TEPXl/xaOSYF0ByEpAai+8hNkzRZNpY3tjxTsHdpmQDdVWrgI5T3IQd2zF7gXee5qLP1kdlT6/MG2r6fgE0J/BXdIjoCxClbOfo4FgoWZMWuAmPHK7zDymXqCk3+toRP4nbYdQwkhBnfAHgTFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=jqIJVptu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dyr0hKbr; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.west.internal (Postfix) with ESMTP id B61991C00069;
	Fri,  2 Feb 2024 20:31:24 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 02 Feb 2024 20:31:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706923884; x=1707010284; bh=PIAUW04NCw
	jAx6odyc5IdPiwZp8Qkpxdk8jCeNh/ll0=; b=jqIJVptuXiDdv+NUEslsy7upTT
	SQ1FcHZ7PmLE1YNaaBAJGz8tyZYjgj0GFPvMOoREMCFMz3IWXJ8xdmb0sRioEdpU
	0N0CkhbrMzFiAGEeat8VT4Xzch72pB0hW3Hjc43GCKVi9wFzfebdjTk3OSs5LmPa
	6tpK2KQzIkBR++4MNq/ruckWHaNuMbgVoXuJT6ZLwt4LlFPCAK+moLN63s2KyLaK
	tbIpcZxhJQtpDs69M7IYbYnCflnVpllBBUS6mukIJvAVBkbrKcnbpFdpT9x7yV0U
	Uk4OsSTBHE8u11TysK8a1OB2UMLXHAkO6/dYMOOTOXuh2BeN7p0RNbAsco5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706923884; x=1707010284; bh=PIAUW04NCwjAx6odyc5IdPiwZp8Q
	kpxdk8jCeNh/ll0=; b=dyr0hKbr9/b+yLzVgAL9ddGIK495rjaXZbs73UpXGdma
	ou/Z3E2kIFGTwX+EeIvDA25pxlTWgPJtRsYQT6r1VXB0WCgkoueBUGQTHvvfsO5i
	KmiAg8ihI/2r7TMPzSqRnHJT9ZwUCisOrYdEl1aZRRx19S1SNIJrEeJSl07D4aIq
	VJQKKKnz+qBBtd1pdpEwu7BO1i5QkGCIwQmMZnZ/ZemQfY/WKIa1mQkk3sDBRWcn
	kXpMVD2DdfvyrxOQ4BUufB/bxmT0kFs9P/0//nepeoe3PjflzxP65+vajjF++Z7L
	c60oPfq9TxlrH3AuijZwGJ6W76ke4tiXe06E4+RugA==
X-ME-Sender: <xms:a5e9ZfRqJ2tDuotmTVSPTu9UqEIOlQ7VeuQ4qYl4891tbzCSJNmvZA>
    <xme:a5e9ZQzexYKZLcZtc3CQsboZXEpvmAGwoFD72ILFs7b1RITyk7e-wNvr8neDiUF65
    LGZ9kADSeDgyw>
X-ME-Received: <xmr:a5e9ZU2rLoZxfMMZJVQpUpGawv2cT517lMeGVH1e1l2V7fH7EHln02IMzEMa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduhedgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehue
    ehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:a5e9ZfCJpQXWtdkj0bfDtAAvDqgf9pzGQi-7tqFko34EhVEjK4jdNQ>
    <xmx:a5e9ZYgf7aYroME-hHFcIGISu8ClJ1jT7pfQANFnBHXkw-FYPD6iWQ>
    <xmx:a5e9ZTo5kZ8ZDhDFikrHom06dQl8umMKesqCdKIfFVm59plO5YOfWw>
    <xmx:bJe9ZdajehaZ-AklpKJ70hxNwVDKtHYgNb0cnq56oATygdVaRzzhKpCOISs>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Feb 2024 20:31:23 -0500 (EST)
Date: Fri, 2 Feb 2024 17:31:22 -0800
From: Greg KH <greg@kroah.com>
To: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
Cc: stable@vger.kernel.org, harshit.m.mogalapalli@oracle.com,
	yonghong.song@linux.dev, ast@kernel.org
Subject: Re: [PATCH  6.6.y] selftests/bpf: Remove flaky test_btf_id test
Message-ID: <2024020204-enchilada-come-ded2@gregkh>
References: <20240202034545.3143734-1-samasth.norway.ananda@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202034545.3143734-1-samasth.norway.ananda@oracle.com>

On Thu, Feb 01, 2024 at 07:45:45PM -0800, Samasth Norway Ananda wrote:
> From: Yonghong Song <yonghong.song@linux.dev>
> 
> [ Upstream commit 56925f389e152dcb8d093435d43b78a310539c23 ]
> 
> With previous patch, one of subtests in test_btf_id becomes
> flaky and may fail. The following is a failing example:
> 
>   Error: #26 btf
>   Error: #26/174 btf/BTF ID
>     Error: #26/174 btf/BTF ID
>     btf_raw_create:PASS:check 0 nsec
>     btf_raw_create:PASS:check 0 nsec
>     test_btf_id:PASS:check 0 nsec
>     ...
>     test_btf_id:PASS:check 0 nsec
>     test_btf_id:FAIL:check BTF lingersdo_test_get_info:FAIL:check failed: -1
> 
> The test tries to prove a btf_id not available after the map is closed.
> But btf_id is freed only after workqueue and a rcu grace period, compared
> to previous case just after a rcu grade period.
> Depending on system workload, workqueue could take quite some time
> to execute function bpf_map_free_deferred() which may cause the test failure.
> Instead of adding arbitrary delays, let us remove the logic to
> check btf_id availability after map is closed.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> Link: https://lore.kernel.org/r/20231214203820.1469402-1-yonghong.song@linux.dev
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> [Samasth: backport for 6.6.y]
> Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
> ---
> Above patch is a fix for 59e5791f59dd ("bpf: Fix a race condition between 
> btf_put() and map_free()"). While the commit causing the error is
> present in 6.6.y the fix is not present. 
> ---
>  tools/testing/selftests/bpf/prog_tests/btf.c | 5 -----
>  1 file changed, 5 deletions(-)

What about 6.7 as well?  Shouldn't this change be there too?

thanks,

greg k-h

