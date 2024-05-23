Return-Path: <stable+bounces-45667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4D58CD1A9
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 14:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C05331C2136C
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 12:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C390313B5B2;
	Thu, 23 May 2024 12:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="3H2BMva0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PWrVn0wG"
X-Original-To: stable@vger.kernel.org
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBE613B5B0;
	Thu, 23 May 2024 12:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716465778; cv=none; b=A0x4zUo/tHpSoUNkdDM4K5EnLfNeq5ojFMEYVU2ZGaKBOJLmhlioULVplLymhrSdMxNmvQaJ6YZU32BliYtbdk7B8CHgmekxuXr8+jCbnSE3Cqz9U5D6P/YAumcYf6M7BMU64obgxaI58xjWIo7qOChiPi2T4+GWCfMulka4oSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716465778; c=relaxed/simple;
	bh=nYZprggjxE4CUUa9PfBQ45lBhEUGET+BjzQKIVfwyGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYmGpWoD/NtqG7QgBsaYeQXV3XF/dnz4c5IMjMQW1jN4YwBgApwx9P0LDQdWMxyqzfwqNPSk8cjEegYY4jN22n51CuvBR3UqPWSAihllbMU9h5wUz9VzF+uRExb/PMwTnKlXAWyQTFXWAA5u80vIpZwCiSbGR6pkmFrX7Slb7I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=3H2BMva0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PWrVn0wG; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 250C21380093;
	Thu, 23 May 2024 08:02:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 23 May 2024 08:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1716465776;
	 x=1716552176; bh=qKyuOLiauclZKSvY0U0cBP+tApBNI1A9K/xKic2gjA8=; b=
	3H2BMva08qhi1up0zP2r6QKEn9KrGPUaD08hwnpkzbe9qd9iJn29PGr/+dX7QJyw
	uq24holSdCMGymWYKvP8EVaV4tjjDxACrLqOm0i4xFoYcl6ayJG6whjmQ9Fsupiv
	quGop3/6oqJRcGLUXPUH346ECIC8W3VpsWuI13H0rMVHNhHVlrMPFiHkfbmNEmJD
	nl+qgVuvq41GxYBdbD39uzNxUG/2VqCo9EXyB9TVyddltZFqnq7x6A0CuiSzSsQm
	M+TkSOKdinBo0S7QRbAd8lMchsRy005FXELjUsARCb4qq1Q9fbryu8SfKW+oeBFf
	1sQXwuUnJX/ugbBY4POUNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716465776; x=
	1716552176; bh=qKyuOLiauclZKSvY0U0cBP+tApBNI1A9K/xKic2gjA8=; b=P
	WrVn0wGkBpSYXfYYVoNjbkZHxocYVCoDutMPCHkrnTp338BK00J+yEc013nFLWlL
	cHFUCBcKK4y/hrmFixSSdlz+qQC0HncwjBg9A8CsgRhTMi2E0MkCq9+TE4NTnL4M
	8ZPiR+vxWMDaYc0kqN+A2yBCNxOM03+eRjX1CUED+qxWlzHbk5tuMw20rc66AlDq
	f2+GrPqANnRSF7NTBtSkaUg6vOM8zGha7nOUtmVke5SfRJtf3sXtLPf5V2uAMq+S
	pr4t1KkTmBqr2K6iGV5sf1iifl2S0B5sJMHa7gfO077BQR3eN5ysKDvyhiNacMVO
	Gj747wqBIIv72C0G/7xhg==
X-ME-Sender: <xms:bzBPZmWJ2Xf1zkP3DzNXdrR8OBxLEqqtrjzbpKzJ3LDaMlAqXBn_AQ>
    <xme:bzBPZilaIgB-8TaC_3EOM0wMqkeL99zE-8HVcgrmaFVgu_wqrh-2Cz5l-jhjCVuIM
    G64gr8Datpm0g>
X-ME-Received: <xmr:bzBPZqaRzY6YyLGllswpIwxFHpOFJl3y5gjyxyMjQIgfwAfQuQ-xynLQGRDGsMb5Q_ylhv-QrxWUXHS2PWOrxJrlAmaoEY60qoZH5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiiedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpefgud
    efuddtuedvvedutdefhfekffduffdvleffteekffdtkedtvdfhhffhgfekudenucffohhm
    rghinhepmhhsghhiugdrlhhinhhkpdhgihhthhhusgdrtghomhenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtgho
    mh
X-ME-Proxy: <xmx:bzBPZtWTTfxN_-oU7d3VredH6mNcQunPy3xgS7Y5fLcak3ssNRh6Fg>
    <xmx:bzBPZgkUeVpDbuua1S3sI0yGB-onH4x0RfVzHERAI4QOTUq8M2dpMg>
    <xmx:bzBPZic6wBQ8qEvEDy1DCKfd3wzU6mzVOjmZEpV6Yj5_orFuxl9gFA>
    <xmx:bzBPZiFeqWpxleHrjjM18QcNzyKr8bVdUVJ6ItPL6Jm8xs6IYvzikw>
    <xmx:cDBPZvfH8xDULpACbiF64ZImLtWayQYvBuHeVKCLdtmePTP6nUkoAed1>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 May 2024 08:02:55 -0400 (EDT)
Date: Thu, 23 May 2024 14:02:53 +0200
From: Greg KH <greg@kroah.com>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com, stable@vger.kernel.org,
	yung-chuan.liao@linux.intel.com
Subject: Re: [PATCH stable-6.9.y] ASoC: Intel: sof_sdw: use generic rtd_init
 function for Realtek SDW DMICs
Message-ID: <2024052345-manhood-overrate-6b7d@gregkh>
References: <20240521072451.5488-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240521072451.5488-1-peter.ujfalusi@linux.intel.com>

On Tue, May 21, 2024 at 10:24:51AM +0300, Peter Ujfalusi wrote:
> From: Bard Liao <yung-chuan.liao@linux.intel.com>
> 
> commit bee2fe44679f1e6a5332d7f78587ccca4109919f upstream.
> 
> The only thing that the rt_xxx_rtd_init() functions do is to set
> card->components. And we can set card->components with name_prefix
> as rt712_sdca_dmic_rtd_init() does.
> And sof_sdw_rtd_init() will always select the first dai with the
> given dai->name from codec_info_list[]. Unfortunately, we have
> different codecs with the same dai name. For example, dai name of
> rt715 and rt715-sdca are both "rt715-aif2". Using a generic rtd_init
> allow sof_sdw_rtd_init() run the rtd_init() callback from a similar
> codec dai.
> 
> Fixes: 8266c73126b7 ("ASoC: Intel: sof_sdw: add common sdw dai link init")
> Reviewed-by: Chao Song <chao.song@linux.intel.com>
> Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Link: https://msgid.link/r/20240326160429.13560-25-pierre-louis.bossart@linux.intel.com
> Link: https://github.com/thesofproject/linux/issues/4999 # 6.9.y stable report
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Cc: stable@vger.kernel.org # 6.9
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> ---
> Hi,
> 
> Regression reported in 6.9 by a user:
> https://github.com/thesofproject/linux/issues/4999
> 
> The fix for the issue somehow dodged the 6.9 cycle and only landed mainline
> for 6.10, before -rc1 tag.
> 
> Our trust in machines shaken a bit, so just to make sure that this patch is
> picked for stable 6.9, I have cherry-picked it and tested on a device that
> it is working without any side-effect.

Now queued up, thanks.

greg k-h

