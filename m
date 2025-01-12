Return-Path: <stable+bounces-108324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F050A0A8C9
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 12:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17B033A1168
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 11:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C183E1ACEAC;
	Sun, 12 Jan 2025 11:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="ZDI/ePa+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vOMByzPR"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19BF1A4F2F
	for <stable@vger.kernel.org>; Sun, 12 Jan 2025 11:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736682716; cv=none; b=NfRtiM+46/PfPc2CkVoX3Q6UbvUEcEPm9l70B78eWJ2fNIwtH5Hqmo70O9PD18BgEae6r4wXrGe+xGHw4tPvwhflN1Xdy4As19CcfkqRTLvTRF7X8APrd4Ex2hDfTxPZkNDLjVeNkph276uDUL0PyF3rjjPncuOu+aqAKD8BW78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736682716; c=relaxed/simple;
	bh=Ip6b5GMBpEzVq7MJRWOCXs8i2fAN27YBJLCJjtkCCkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rM2vxtmPsCTyfRySQ8gc+mXB/t6/rX6vKA3MoFFhMgavg/Ze0GhTRKvigJoGkZmJBy7HaeYKDuoISnm5tgEzF1Fvcj8VQ3W3xUFqvetecl2DvpFMBVlkIlcugtJXTDwHq/AUeQQwCpNx0gMUWkAHzj18xfszcff1cCAQPd3VE8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=ZDI/ePa+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vOMByzPR; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A90F0114011F;
	Sun, 12 Jan 2025 06:51:52 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 12 Jan 2025 06:51:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736682712; x=1736769112; bh=yUSnLcqPTt
	wWuktufO308IfpFOR2v7ir57sXmfepeng=; b=ZDI/ePa++bbvMsyXfMpCVSvDzI
	Rbkwm2L1+joQawejHv9GVEkKyg6xqiTSpqNbJNVwPa4b2xY17sQ9DD7GUWjzIYaE
	uZZiFZ09FLCzofvk3O4LWb3ZtLAm9neHPBhUnvZQQmbfYFlU1tctJoyohLMeZFwl
	tVbPEQQw3GswlngB6suh9odPWsHN9RpaVLuf4c2RMCfVWX+0HgamK6suCmAMrSwW
	gEmjNgc6GgYD75y1XxkaT3TJvo1L3bOK7gtpNTEnCQvdvzZO5bSBc4MpHnh9SP1Q
	1XXgDKEsywcfsOkW9/AfI4ksN6mwcuS4GD/BVabN/gs8HCDob0kjLUcTeMLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736682712; x=1736769112; bh=yUSnLcqPTtwWuktufO308IfpFOR2v7ir57s
	Xmfepeng=; b=vOMByzPRZC6E4amajpWmk46AuZl9kiO0YGju14/Zh487Khkn3Ib
	/p9PcagY5+Ia/rACm1U8kZSgb1rcMVKTvcHl1pfnonSbdvynx3vwTQb6JutCkxAN
	b/UPFFTM80aD8go9ZXiKnng2NjjRRSdXrXzVVy6nz/Tkoc9cbYEUPLqB27Awk1XS
	nYyT8ScUSPF/d/Xs3HHqvrP87OcvKaYunc2dz6X/CLN4aW1eDpcO4c38zorWMPFI
	h4/0TH9h31R5Ss9yCfQYW9h4Zodlpo4RfrITHC6ygGk0NHYEGh0knLxGIupu/l+w
	pxt4fjayyhe+iQIp5nxcwu4OM3GKEWOnx5A==
X-ME-Sender: <xms:2KyDZ0cAnbE5BcFaTBz-hXvaUJJTEYUBnRRcg9W2S0pUmL-cugTMNg>
    <xme:2KyDZ2MEg8kUjQ8O530m4vT0_D9uL255flO3dK3pUNAkNd572XQffW0noC_XXg2So
    PFQaxHECfmKkg>
X-ME-Received: <xmr:2KyDZ1goXl89dhtSm5SuVdE5R-EBdcC4jEqmwGlIwF11IuqZem-K1aU3sYgzpGsvsnAywRNa50F3kcem6Dbn8r0jIytFE98p4kUWOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehvddgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrf
    grthhtvghrnhepgeehueehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeel
    vedttddvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdp
    nhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehhsh
    himhgvlhhivghrvgdrohhpvghnshhouhhrtggvseifihhtvghkihhordgtohhmpdhrtghp
    thhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgi
    hukhhuohhhrghisehhuhgrfigvihdrtghomhdprhgtphhtthhopegrshhtsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepsghruhhnohdrvhgvrhhnrgihsehsvgdrtghomh
X-ME-Proxy: <xmx:2KyDZ5-pWfnuLkWARXrGHxmONgjcCtmWldwl7E0ElIN2c2HLtqykTA>
    <xmx:2KyDZwvXaTbe80Le8i7BYG4nRhHXbrqnxVv35V2uG63NqsrZvBwnOw>
    <xmx:2KyDZwEOT4sE1O1RJwZEWRcHCbYvrGuBG87eI8ruR2Fot1PYYE8ScQ>
    <xmx:2KyDZ_Ntx5BJmjIzJvfKi-Bj55hgtwix32l2fY2qiRmhqqSS08ZNYg>
    <xmx:2KyDZxHRRupdY3BrYVU2PTCUkmV6cchGWUX7AOqTQaWHOSOXCQBSLofa>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Jan 2025 06:51:51 -0500 (EST)
Date: Sun, 12 Jan 2025 12:51:48 +0100
From: Greg KH <greg@kroah.com>
To: hsimeliere.opensource@witekio.com
Cc: stable@vger.kernel.org, Xu Kuohai <xukuohai@huawei.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	BRUNO VERNAY <bruno.vernay@se.com>
Subject: Re: [PATCH 6.1] bpf: Prevent tail call between progs attached to
 different hooks
Message-ID: <2025011224-liberty-habitable-1332@gregkh>
References: <20250110084000.3208-1-hsimeliere.opensource@witekio.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110084000.3208-1-hsimeliere.opensource@witekio.com>

On Fri, Jan 10, 2025 at 09:40:00AM +0100, hsimeliere.opensource@witekio.com wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
> 
> [ Upstream commit 28ead3eaabc16ecc907cfb71876da028080f6356 ]
> 
> bpf progs can be attached to kernel functions, and the attached functions
> can take different parameters or return different return values. If
> prog attached to one kernel function tail calls prog attached to another
> kernel function, the ctx access or return value verification could be
> bypassed.
> 
> For example, if prog1 is attached to func1 which takes only 1 parameter
> and prog2 is attached to func2 which takes two parameters. Since verifier
> assumes the bpf ctx passed to prog2 is constructed based on func2's
> prototype, verifier allows prog2 to access the second parameter from
> the bpf ctx passed to it. The problem is that verifier does not prevent
> prog1 from passing its bpf ctx to prog2 via tail call. In this case,
> the bpf ctx passed to prog2 is constructed from func1 instead of func2,
> that is, the assumption for ctx access verification is bypassed.
> 
> Another example, if BPF LSM prog1 is attached to hook file_alloc_security,
> and BPF LSM prog2 is attached to hook bpf_lsm_audit_rule_known. Verifier
> knows the return value rules for these two hooks, e.g. it is legal for
> bpf_lsm_audit_rule_known to return positive number 1, and it is illegal
> for file_alloc_security to return positive number. So verifier allows
> prog2 to return positive number 1, but does not allow prog1 to return
> positive number. The problem is that verifier does not prevent prog1
> from calling prog2 via tail call. In this case, prog2's return value 1
> will be used as the return value for prog1's hook file_alloc_security.
> That is, the return value rule is bypassed.
> 
> This patch adds restriction for tail call to prevent such bypasses.
> 
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> Link: https://lore.kernel.org/r/20240719110059.797546-4-xukuohai@huaweicloud.com
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: BRUNO VERNAY <bruno.vernay@se.com>
> Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>

Please document what you are doing here that is needed for the backport
as this does NOT match up with what is upstream (a chunk is missing...)

thanks,

greg k-h

