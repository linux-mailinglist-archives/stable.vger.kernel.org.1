Return-Path: <stable+bounces-53799-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4BB90E715
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 11:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 266961F22F2F
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 09:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFFD77106;
	Wed, 19 Jun 2024 09:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="D9oY3AON";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SR8z3tw+"
X-Original-To: stable@vger.kernel.org
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB357E58F
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 09:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718789409; cv=none; b=u5oXhFm0BOsFn6MNTJ7iAKjfo8PGb/vu2pmB2S28mrYWjyCt0bSghIw5vAlRFlb82gPQ650OnVr587BGEb27KfuapOm5WiaEnqBMFKJdyo6FCDlsKQa0xlhQpTrUPGA5lPKqXXi/tKoE+cOLLoDE0sChwZqtHmGIctMSbfGDMFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718789409; c=relaxed/simple;
	bh=hNHcBif2YH+bifXw2RHyud9q77Kk7oakdFhIQFTP7v8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7+L8tG/Hk28feJZafZXspyvoZrBQ3TNKrV0vXfFurbnHuRmjpPyFBCYk2AUerXxzdg9TNGt9zD1yQgi7NK2GfEesxclNhlsd2vPxzZq4HkzB8c0KMrn2j8RH+weBIi8XC1ype9Zql5ftxCb3waxo8eJ3TCDGpKS+ppOPhnOTKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=D9oY3AON; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SR8z3tw+; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C49A111403B9;
	Wed, 19 Jun 2024 05:30:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 19 Jun 2024 05:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1718789406; x=1718875806; bh=kEPoEffS2C
	Dh8fexHrh1e1lJF7LCd2va187FJwZetro=; b=D9oY3AONBjyEygOPE80ZMKnoyr
	/aF3Bv2IxaHTS+1K/UzCrmbaiAlPG1JajkaNEVju+cidYr5LFYUvrRc7p9ErW1hv
	HCCZAdUbf7U8dDd49J0YqOSfVcoZj4258ZJXUFHbtw5BebzLoS7i0b4dsA/O47a0
	jeMARsihtw/FsNGPtAK9Wx7U+GEpzxx1T5JYJZ55GDOpZgLn64UhmVFWP/WiQnht
	9Ns2P1PJp54OXfuV4q8nspOZdj8FH6MeoLBp83RWoG26FIcAxMY656KTfCWNFQBR
	BVhdMgZ198P9Gpy9mbfuWRe9No3UAuk5Xk4F4ztNfAl2hcI5evAIJZUx4VWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1718789406; x=1718875806; bh=kEPoEffS2CDh8fexHrh1e1lJF7LC
	d2va187FJwZetro=; b=SR8z3tw+Y/hUn6PDAnaT5jF4ffBVDRlhiwBiOvtUkaLP
	F/QRHADSpt8rOSBhVqjCJ9pIuNvcaZ1CqRNmOT8RJdNMy9bMt1b7XniKHeBQHy85
	VY97UZEdwMMrV2ZRSnT0dC3hBJiVKIzozNwy2XwkD8SWVy/YkJtuRsqYpwFgY+2U
	1UUovyM01eknbDT/jlsaae6wpD2CZ4hva8eDJW60PvH7qFdbNQXSMAbroMKyPW+1
	CdhGGIAhsQAokYfX9OnHrQb+CwBVtfz/WuxqQFhc3/jUugNzhfAGGnA71t1Lkc50
	GloMONziOjGROLKJp4T9Suxo2CPjpUQFdqJWCG+o9A==
X-ME-Sender: <xms:HqVyZhavxNrtxAQEM7HunxL3E7KGRboNyG07c7auOZ0rJyscMAFriw>
    <xme:HqVyZoZsSp8dw9av7Gkt0vmF00GApFihsShFx0aAJuIuBo1p10uWytbuWd9c6_aTy
    rXPv3JGK8dThQ>
X-ME-Received: <xmr:HqVyZj_xGOexAmqgvncnPK_YKPV5EqerQxJ-x563NV_KSEF5siHWiIO9oBij6gDa3K6h-4QVSTDPkls93wRHdnS_lEDj0EYLDaa39Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeftddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehue
    ehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:HqVyZvq9VBt_m0VuWBw1ASKZKMWkdETKRbE_97eAR9wR7EUR2t0YCQ>
    <xmx:HqVyZspDf_AOjFnmqEpOybI0iYPR1PpcDXeK2cjW0B3UxF8DYlZ4gg>
    <xmx:HqVyZlT1NehjKOQhB3bj18REtFcRKGKIwqOV0OlFT1L_7qe2sXJLCQ>
    <xmx:HqVyZkp-cM1wYQ2utLfbmzm7GjNBUSYd8xzZcSL8k8HDUsCziBorfA>
    <xmx:HqVyZphcxhYVfWpTNUqCuobnH_PTq-Mw_Ia0DNozqJsGRam8kOknB2ok>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Jun 2024 05:30:05 -0400 (EDT)
Date: Wed, 19 Jun 2024 11:30:02 +0200
From: Greg KH <greg@kroah.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: stable@vger.kernel.org, mhklinux@outlook.com,
	Vineeth Pillai <viremana@linux.microsoft.com>,
	Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH 5.4.y] hv_utils: drain the timesync packets on
 onchannelcallback
Message-ID: <2024061955-dance-civic-048d@gregkh>
References: <20240617232507.488-1-decui@microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617232507.488-1-decui@microsoft.com>

On Mon, Jun 17, 2024 at 04:25:07PM -0700, Dexuan Cui wrote:
> From: Vineeth Pillai <viremana@linux.microsoft.com>
> 
> commit b46b4a8a57c377b72a98c7930a9f6969d2d4784e
> 
> There could be instances where a system stall prevents the timesync
> packets to be consumed. And this might lead to more than one packet
> pending in the ring buffer. Current code empties one packet per callback
> and it might be a stale one. So drain all the packets from ring buffer
> on each callback.
> 
> Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> Link: https://lore.kernel.org/r/20200821152849.99517-1-viremana@linux.microsoft.com
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> 
> The old code in the upstream commit uses HV_HYP_PAGE_SIZE, but
> the old code in 5.4.y sitll uses PAGE_SIZE. Fixed this manually for 5.4.y.
> Note: 5.4.y already has the define HV_HYP_PAGE_SIZE, so the new code in
> in the upstream commit works for 5.4.y.
> 
> If there are multiple messages in the host-to-guest ringbuffer of the TimeSync
> device, 5.4.y only handles 1 message, and later the host puts new messages
> into the ringbuffer without signaling the guest because the ringbuffer is not
> empty, causing a "hung" ringbuffer. Backported the mainline fix for this issue.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

Both now queued up, thanks.

greg k-h

