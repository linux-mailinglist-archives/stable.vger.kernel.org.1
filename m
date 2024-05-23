Return-Path: <stable+bounces-45967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 778398CD864
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 18:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 972181C20DF0
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 16:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6E8B65D;
	Thu, 23 May 2024 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="yPwGgC1t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kk5B4uKn"
X-Original-To: stable@vger.kernel.org
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7F418643
	for <stable@vger.kernel.org>; Thu, 23 May 2024 16:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716481805; cv=none; b=gm2blvR8MC80MBV9aRP61Q1gL7SAe5ouc0gghv1IkDbot/caLLjTz8+WxjLhLcsO/haLBQy9VWGl7rdJLISHwixlgdonzi81YvDO/N4Tnhm3Zodux1lgkVAmqq6ru2IZagmNIeOkKMG4COrTwZ0zbl5kdCtX78VdpD0ePJGVfew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716481805; c=relaxed/simple;
	bh=q2w4JfRGibQy5v2KYGnx96mdVxtsoPKb/gpEZNB/Nn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnNcYDzzVTsYth8Tuo1nicSma0h5SXeMd/gH2R6a/FO0Li5BgRx0/hWZKOkJotjJpQNTEVk/lyeRJLy5Y8Ebd3ASDtlArsUggS7SUjYXoce5EbNQtN2Q6t4zhYThF38fDMSbxsi2G+5CaVDuEjF/p1lStkWrrmU0ASh76PzajdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=yPwGgC1t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kk5B4uKn; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 9C7AE1140165;
	Thu, 23 May 2024 12:30:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 23 May 2024 12:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1716481802;
	 x=1716568202; bh=0rtgH1k/GZ8ZzTPeUqIg0pYzXgjqHH6dowOaWTTT9qM=; b=
	yPwGgC1tEShZcPvVD73ZEDburC7gwDZUI6P5w0RippXcGdZmfuPC0+19xSDajN/J
	hUSpE/v9/Yav44A1rqf7Lm9/V9EdMzt3ZKcKfEqCRnpW3H9QNa0T9eDmcQX//ZOF
	O1g+rBAtiKjYVjG6YbxPir6qb19gM3CS4yo7IRs6pBM89Mx9j5QqUPqmRiWE8pok
	52oapbn6OTdLGXahKKh5m42Ud2BBO9e0H89OR2Qj5mV8X2ZDpaU6Z9lkVv8l+z54
	afEQ4oKn1VXGHZ1DZd/x5GOnmnEovpB5myAHBYZWzpxP1aOu2Y3YI6w34rm80Ro6
	IGCq6YCfmZw67A+Bz71Rxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716481802; x=
	1716568202; bh=0rtgH1k/GZ8ZzTPeUqIg0pYzXgjqHH6dowOaWTTT9qM=; b=k
	k5B4uKnSVwD+M1Um13gWHRQrgwxuRbO4Whsw/CahTsgOBbL3Elt3iTHK0K2FIGvY
	2waTFftvr5sPQ+N6XLfuGsf+7r3DDut34SKbMb4t4/bhhed08QjxS1lZhGoDhjZg
	NreQQaty7NhWW/kOkz3Fl8Zj8ivx9+crIDMg7hSEQZwuo3ynFxzMPd9YpiEOCagS
	zEUJXxY30Ka6UN0et+sh15mgZApilfPMT3YY0LiriFckMaxeunKGhuW3jeMrJ+9L
	A7sMF7yo0M7Lgvy7G64X6szNbkG/AQGWtgMJM+Gim6pdGK8vh6jrzFTBdb0BnQFx
	UjY1UrOAR30TJ7Oj8zbig==
X-ME-Sender: <xms:Cm9PZmAnyHyu7EEuv-6VZiGgTa_5Av_wx4vPFVql-GXZIc5lXNHP6w>
    <xme:Cm9PZgggD8n_F471LAmfOwJRM7ZVFayz2iBD-2q4zpsS_y0PfjHcpExDSqvhCGwl1
    X3MQS7FMUDz5w>
X-ME-Received: <xmr:Cm9PZpkr-KDHcHdld1oH4CHL_OmILTWoWFIATcpafaCPOHTI7sqVjTU1OpRhux3IehShXQidh-Xi9IvftnVBCWVSqiIKjZHxn1s6Sg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiiedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepifhr
    vghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgf
    ekffeifeeiveekleetjedvtedvtdeludfgvdfhteejjeeiudeltdefffefvdeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrh
    horghhrdgtohhm
X-ME-Proxy: <xmx:Cm9PZkxyxaROPbkaVf_3wygNhFkPVnkTuQ0_DfbHeTUpkzgx_iU9-g>
    <xmx:Cm9PZrS2FQ9O9zCfsDeoSSCm_tmG0zefFUk3VXqVkrrPegs25NmsGw>
    <xmx:Cm9PZvYeO_W4J8fG7QDXiijUfok6U8oGrQ5WTXvrro8cGvF5WW5oFA>
    <xmx:Cm9PZkTEYtlaDabZcuRBdFp_Nlp8e-s6g-C9bpqevXRV9iYsn2AwRQ>
    <xmx:Cm9PZsBhPh2ixU81MJvT2Oe0gPHZ33zEbVyaomcE0qd_lA2x9K3oCelv>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 May 2024 12:30:01 -0400 (EDT)
Date: Thu, 23 May 2024 18:29:58 +0200
From: Greg KH <greg@kroah.com>
To: Armin Wolf <W_Armin@gmx.de>
Cc: Barry Kauler <bkauler@gmail.com>, Alex Deucher <alexdeucher@gmail.com>,
	Yifan Zhang <yifan1.zhang@amd.com>,
	Prike Liang <Prike.Liang@amd.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: Kernel 5.15.150 black screen with AMD Raven/Picasso GPU
Message-ID: <2024052321-revolver-timid-3056@gregkh>
References: <CABWT5yiejGABNXicsS7u-daKnBBjK6YTDVgaQOqwGYn8P20D8Q@mail.gmail.com>
 <6580c2d4-b084-470f-80a0-aa09f1ab880d@gmx.de>
 <CABWT5yiD110qmJcRsoGVMevULAVmYpyiW4w9MtmNjp7E0rDQ8A@mail.gmail.com>
 <CABWT5yg5jG7eMiDp7QN2yhFj6983qF9zN7eHOprH4eEjwQJLBQ@mail.gmail.com>
 <c3205455-7ad2-487e-8954-52102754e154@gmx.de>
 <CADnq5_PM_FuBE4913Z4bxiMTDYtRS+VJgLW6gfDU1qnQQ=FDzA@mail.gmail.com>
 <d04105ea-0f8a-4f0b-b4f2-bc8407d37c73@gmx.de>
 <CABWT5yibc52CTUWeCWxYQb4ooi4dsbvBWxJAJCDrG+8405RPTg@mail.gmail.com>
 <7ec6faf8-d9c1-436b-98c8-473e7ff395b3@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ec6faf8-d9c1-436b-98c8-473e7ff395b3@gmx.de>

On Thu, May 23, 2024 at 05:59:39PM +0200, Armin Wolf wrote:
> Am 23.05.24 um 15:13 schrieb Barry Kauler:
> 
> > On Wed, May 22, 2024 at 12:58 AM Armin Wolf <W_Armin@gmx.de> wrote:
> > > Am 20.05.24 um 18:22 schrieb Alex Deucher:
> > > 
> > > > On Sat, May 18, 2024 at 8:17 PM Armin Wolf <W_Armin@gmx.de> wrote:
> > > > > Am 17.05.24 um 03:30 schrieb Barry Kauler:
> > > > > 
> > > > > > Armin, Yifan, Prike,
> > > > > > I will top-post, so you don't have to scroll down.
> > > > > > After identifying the commit that causes black screen with my gpu, I
> > > > > > posted the result to you guys, on May 9.
> > > > > > It is now May 17 and no reply.
> > > > > > OK, I have now created a patch that reverts Yifan's commit, compiled
> > > > > > 5.15.158, and my gpu now works.
> > > > > > Note, the radeon module is not loaded, so it is not a factor.
> > > > > > I'm not a kernel developer. I have identified the culprit and it is up
> > > > > > to you guys to fix it, Yifan especially, as you are the person who has
> > > > > > created the regression.
> > > > > > I will attach my patch.
> > > > > > Regards,
> > > > > > Barry Kauler
> > > > > Hi,
> > > > > 
> > > > > sorry for not responding to your findings. I normally do not work with GPU drivers,
> > > > > so i hoped one of the amdgpu developers would handle this.
> > > > > 
> > > > > I CCeddri-devel@lists.freedesktop.org  and amd-gfx@lists.freedesktop.org so that other
> > > > > amdgpu developers hear from this issue.
> > > > > 
> > > > > Thanks you for you persistence in finding the offending commit.
> > > > Likely this patch should not have been ported to 5.15 in the first
> > > > place.  The IOMMU requirements have been dropped from the driver for
> > > > the last few kernel versions so it is no longer relevant on newer
> > > > kernels.
> > > > 
> > > > Alex
> > > Barry, can you verify that the latest upstream kernel works on you device?
> > > If yes, then the commit itself is ok and just the backporting itself was wrong.
> > > 
> > > Thanks,
> > > Armin Wolf
> > Armin,
> > The unmodified 6.8.1 kernel works ok.
> > I presume that patch was applied long before 6.8.1 got released and
> > only got backported to 5.15.x recently.
> > 
> > Regards,
> > Barry
> > 
> Great to hear, that means we only have to revert commit 56b522f46681 ("drm/amdgpu: init iommu after amdkfd device init")
> from the 5.15.y series.
> 
> I CCed the stable mailing list so that they can revert the offending commit.

Please submit the patch/revert that you wish to have applied to the tree
so we can have the correct information in it.  I have no idea what to do
here with this deep response thread as-is, sorry.

thanks,

greg k-h

