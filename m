Return-Path: <stable+bounces-23469-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77729861266
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 14:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B412CB21344
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 13:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4907D417;
	Fri, 23 Feb 2024 13:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="T9EwFl8m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CteNXAUw"
X-Original-To: stable@vger.kernel.org
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD557AE78
	for <stable@vger.kernel.org>; Fri, 23 Feb 2024 13:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708694086; cv=none; b=WX4Oc2zZXPbJIxLyMXEetz0cozMcxYCraxjPf373zo5JwAEdR43ntleq4fPLSdMIsCyBE4eR+RmhmpJpyHz+kLHhCOCcsX6S9ZwjYy/x6pza1WkNlTKinmH96eSzNnGethHjsFVcilpLleCdTN9THC8j4mO/BDN71pZ4/pWd0h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708694086; c=relaxed/simple;
	bh=YycKp8Et+Dz7WdJ96AWWgXwKBVIkgmI26Fq/To22fVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMGPFOvSqXxh/5+o3o1x4FJkmJJC6s59r1TqmTq4iGQnZNi+V26q9rODC3d6+QyoMM0Py9mpq+2/rgimEw/MUwHZUntgK1QOhlxDesmXfecpirXLobYwFwXRnMA1/dSELn39Gr/WnAZ8mVy1ZFNErWvGJHerogEjOCM2bBI7XoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=T9EwFl8m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CteNXAUw; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 6511F11400CC;
	Fri, 23 Feb 2024 08:14:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 23 Feb 2024 08:14:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708694083; x=1708780483; bh=LxHgY56r+U
	pK1C5cJ9BmRTMeu95uMWDHgTXr0QtC+q0=; b=T9EwFl8m3rOhlAkVoiztTnUTXz
	Z1odoGJ/9dTub/gpBVdTcxyE/WQ3+twzVXufj7je5jYT7Qly9pMsX8dUD6LUAQYu
	Qx3cTMjFzVSQtzOktUuNbHUvGeZc6unvHR3MUO2oTfExQ8NyGXhGp6Q6Cu+VWtBH
	9taYtPxK/zQCcDl7Tpj95yrGYO+fLBThKNmd8nIQ/eqAce6yjj+FtzlCKoprJbB6
	RGzvR16nv9BxHI8su9pQeJAoFk9BQGVn/W7r2tucPE4Yh6NlFRG2Uv1xRSDBt0uJ
	i4F1nV1gpFJnRuyK87K4WPKoKXElyv2PP3FM789GK1s8mxpDpo6Lf0BwCdFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708694083; x=1708780483; bh=LxHgY56r+UpK1C5cJ9BmRTMeu95u
	MWDHgTXr0QtC+q0=; b=CteNXAUwTunhdgB2LtgE7XtFJAEKrqJGUz1JF5pPwy7O
	cR2kpvN7vndjKyap7GxBLGaprE/4IFxNfZUMGiw/v7Xn6FPdm9n7hRngCCrVSCSy
	zOzaNpH7OpDvR31jt+O7BMj0bcJqm+cQNtBwWj22Pg+gBOULoXu+7W63IqROAHf7
	aE54lwpqbXSf3lvzI0POu0RfQSyUstIX553RZtSmcMW+pevhMp+QhuWJ+qIcEuTK
	d/s0nHUHV2C/80Y1zJL7GPmsuUaRDgFfAN3b2syQjzh1m44OnQSnNqhZmNNfKY2b
	ujoHTchMfaDdxoRe5jkH71h1+7W+/L5Zce1q0DVafg==
X-ME-Sender: <xms:Q5rYZWB7kt0bpPIlC2hTIqHyCUNsFeHOGmQNZcbdeFgAD4g31Sb4_w>
    <xme:Q5rYZQjkrDb-9N0H5FGbpVPBXWuZtu1IlqfJXgZsaAZ8Y34wggvJtulZFUgA-Dxbe
    8fPCxJWsWtbcw>
X-ME-Received: <xmr:Q5rYZZmfPLtUteCGikTpt6-YLnXG7UtGSJcu171OpI_bQSAZpvYwwdKu8rZBiEy4utv4UoFQA7vsRJ4cxJ7Xf9994IQarS6PuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeigdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuggftrfgrthhtvghrnhepheegvdevvdeljeeugfdtudduhfekledtiefhveejkeejue
    fhtdeufefhgfehkeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:Q5rYZUzWIkSv5WZJ3ZpcWW3gZggS_AfRFoUYyKmemTqYh4RsgYtRaA>
    <xmx:Q5rYZbRKsQH_v9qHF1seo2wvlcotNOzyLtW8qgRFgENvaffhWG6AFQ>
    <xmx:Q5rYZfYicXhNLpwcPuvwSvtYYP-gMryNlamYYJe-wfM9hgm49MEIwQ>
    <xmx:Q5rYZZNLwVHyGRfVo8QJlTuK2ACPes3eRIAxVWVj89gHMKpPJcy9eQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Feb 2024 08:14:42 -0500 (EST)
Date: Fri, 23 Feb 2024 14:14:41 +0100
From: Greg KH <greg@kroah.com>
To: hsimeliere.opensource@witekio.com
Cc: stable@vger.kernel.org
Subject: Re: [PATCH stmmac 4.19 0/2] Fix kernel freeze when probing stmmac
 devices
Message-ID: <2024022334-untruth-helper-3fe5@gregkh>
References: <20240215151527.6098-1-hsimeliere.opensource@witekio.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215151527.6098-1-hsimeliere.opensource@witekio.com>

On Thu, Feb 15, 2024 at 04:15:25PM +0100, hsimeliere.opensource@witekio.com wrote:
> Fix kernel freeze reproduced when probing stmmac devices on kernel 4.19:
> Upstream commit 474a31e13a4e9749fb3ee55794d69d0f17ee0998 to fix freeze and
> upstream commit 8d72ab119f42f25abb393093472ae0ca275088b6 to apply the fix correctly.
> 
> 

All now queued up, thanks.

greg k-h

