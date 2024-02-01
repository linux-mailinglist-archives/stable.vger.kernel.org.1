Return-Path: <stable+bounces-17625-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6BE845FAA
	for <lists+stable@lfdr.de>; Thu,  1 Feb 2024 19:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC4B72922D1
	for <lists+stable@lfdr.de>; Thu,  1 Feb 2024 18:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E2685290;
	Thu,  1 Feb 2024 18:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="ID85v3jd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KyPcrmWo"
X-Original-To: stable@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF5E8527D;
	Thu,  1 Feb 2024 18:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706811259; cv=none; b=t15gmtAgryN04t1MXvffRAG4m0SzEYl/zPFtCMIQVW0bMoNNn7NpqIhAxEs+tZQdyz40PW2wv7aOAQOBOGqITz1g89Z+qFLOvjM4EnFEYf6lW5iTnnLZd5mnS4bHC2Wl0zL67HVuzTZyLjWkOzXlqN4zbL4gbQ2EU0245pg/++M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706811259; c=relaxed/simple;
	bh=WR7YYDoIq0rjE7U0kbMWtgF3thGVh/9ExujMEDHSw7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=My+Pb4ZDXjCdV+opBg8cg79ZhHH/ZoQ0W/cO91B5eEJCFGEu5op0gvXQOcQTRyemt3fkPSzDg6+R6Z9+7fHDjiGIGmuL3FT0ZRN9Y5eF0KqxlDW7lEmxZUwNgF30aekPHB9hfwI3FkYqxCmtcjWBuoyBQ74Es6tsRToe2rNXh0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=ID85v3jd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KyPcrmWo; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id F38EE5C01BF;
	Thu,  1 Feb 2024 13:14:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 01 Feb 2024 13:14:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1706811246;
	 x=1706897646; bh=2yCpQpbcoWQth9NFfIA0MCzyuipgh8wup+LBFUKVyQA=; b=
	ID85v3jdK/+jKk4Mmo0JqwFbREMej+sGzMDMwHCe4cMaULw91eMGHL6GVqCQ9pwh
	NBRJrz6YwX3YUMeBh2rSQzsp8MLYbc8iLwHkEzWJwZysuO0CNNdjorbT4PJyP/TF
	Fss2n3DADn1fypj7CUUzfW3fYOPlN++8LJqXsQfOGKeD7lhg2xOAPBpiFcb/valQ
	W14XYxuToDZKfa/d82MK33QcYskAsUsirm0o/4F6l6rApz7r5SGP3tMMzKWpFPFb
	orFXTBYfNkqei3W4fBogz1sZxUff1a7ewgNTBB5f/N7BF4pAV2M+3OToC30Uba5u
	I8vrQUdANXGiQ1R1wRYZMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706811246; x=
	1706897646; bh=2yCpQpbcoWQth9NFfIA0MCzyuipgh8wup+LBFUKVyQA=; b=K
	yPcrmWo6G8jqNXHgLceN88Ir4vEyJnhnU7XVqaK1M9qrC0AKaiRNNGCwD/0TsqiK
	Jd63r46FruFyosv8SrNg1wJByIVD4/GrYqsmqD2yKy5TujbwhCGHpCqqQ6T0bMDn
	sNWR02q0QCb3kiP7LW67VR1a6Px4xp0tc/IwMH4HCLDXaUIv93Na2B5mFSNdh5Eq
	cdibJ6BzjhFPnpXCmSlwRYUSxG2VHckXSlUNRu2CT6Mt9SEs7JofHoLkXVo0jOtI
	WQNu4CKZBvIAKQpoXijm1izEKIFa1bpaPY4NMDTxioyq80LYkUXBLLPExBSDl1t+
	AaZCaxPYXSYy74jV3A6qQ==
X-ME-Sender: <xms:bt-7Zcv0TX2zN-Mwso_FVdv0gNFEonqD-nDSVoe5MYok8h0ClwPc2w>
    <xme:bt-7ZZe4OWGgBBo0-RglaoAdiYDPZDfTJDjzZ-bm3e4x_Adlsy08nPo_BcBp2SfmB
    6E11S0_YtKRWg>
X-ME-Received: <xmr:bt-7ZXya_1VGm-ocRWZHocdzX_zVXnFat9QjZ780Mh3v8kVyBcfrUwYA4mTq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduuddguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepifhr
    vghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnheple
    ekheejjeeiheejvdetheejveekudegueeigfefudefgfffhfefteeuieekudefnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:bt-7ZfOa03k4_ZYqFwpxYxMdGXf3KovgJfFBPTl_v0spqP7yfJT8PQ>
    <xmx:bt-7Zc8Pl8oiFKPRPW-zidYofQFNtKG_Rj_fpcCUXrHgUXlFJTuUdA>
    <xmx:bt-7ZXVRQJAb4eJSvAK5kFrOkcxBXrV_qOc4_6yhUEPA51Rk5257Rw>
    <xmx:bt-7ZXZeIQmFbcC69QximzZgKATZUz-qf04SsQNKWJp-iq9ngsanoQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Feb 2024 13:14:06 -0500 (EST)
Date: Thu, 1 Feb 2024 10:14:04 -0800
From: Greg KH <greg@kroah.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Sasha Levin <sashal@kernel.org>, stable <stable@vger.kernel.org>,
	stable-commits@vger.kernel.org, Brian Cain <bcain@quicinc.com>
Subject: Re: Patch "Hexagon: Make pfn accessors statics inlines" has been
 added to the 6.7-stable tree
Message-ID: <2024020145-saddling-state-4978@gregkh>
References: <20240201165810.64968-1-sashal@kernel.org>
 <CACRpkdZg25-V4geYWyQuCbqnLmd-QKrZDRQhtN07sxf2UU80Og@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZg25-V4geYWyQuCbqnLmd-QKrZDRQhtN07sxf2UU80Og@mail.gmail.com>

On Thu, Feb 01, 2024 at 06:11:22PM +0100, Linus Walleij wrote:
> Hi Sasha,
> 
> On Thu, Feb 1, 2024 at 5:58 PM Sasha Levin <sashal@kernel.org> wrote:
> 
> > This is a note to let you know that I've just added the patch titled
> >
> >     Hexagon: Make pfn accessors statics inlines
> >
> > to the 6.7-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> >
> > The filename of the patch is:
> >      hexagon-make-pfn-accessors-statics-inlines.patch
> > and it can be found in the queue-6.7 subdirectory.
> >
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> Please drop this patch from the stable queue, it is not a regression
> and we found bugs in the patch as well.

Will do, thanks.

greg k-h

