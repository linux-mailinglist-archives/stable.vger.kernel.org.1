Return-Path: <stable+bounces-58197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A57929EFC
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 11:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0C5F28543A
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 09:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538323D0AD;
	Mon,  8 Jul 2024 09:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="GNQraPS3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TjObk1Ig"
X-Original-To: stable@vger.kernel.org
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF8D433CA;
	Mon,  8 Jul 2024 09:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720430504; cv=none; b=HVAg54h1fDNqY+J2kZ3Aq60E1n6c5bJEP19CBPLvyovaIiIvteZOO3NW8hj914Q6DrLiUUAIDDk4BvTPP3yBweJ0Z6ySJ4VpxmytB5lF20t5781HbnCzuv9/BPz9Y7Mq+3m/SLIMahsei3a9nq9rkVzyFIuqvKaajOoGElfn4po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720430504; c=relaxed/simple;
	bh=qZJ59XvbRg5aoqXE9vnJQ9Ccp2taJuSk/E8rPNANfr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YerriwXSDauF6auKCAKC5hH8PAsGSwKiMZjpDpzTkuAU9cdkkm5XFJ4/KSQBdtriMoYuJVb9MAZWrGUZKJ6GlXf7v/pW7KxfUAh6YbanxMCGj6of1y/6mcrV74KJsYjeVTRAhjVXjDz/YZZLphGAtK6W1tzlOYNOO70h0sM6gO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=GNQraPS3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TjObk1Ig; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id D2B7B1380A6C;
	Mon,  8 Jul 2024 05:21:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 08 Jul 2024 05:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1720430500; x=1720516900; bh=ALXtPAyPFG
	RfDCNbB9ATLXG5/hOXvdJ/sfU/cWdACq8=; b=GNQraPS3HDUvf2LpfV/8q5V477
	IG2pz6JWN5++ihxlaZju0dpOHgtqh2ewyn5qtxCgv9JZidzV+Ijuy4xsNEMx+78k
	yz3ZhCwVtp9s4NJnX1z/H0kWTmQTMiT+syVcnf+bmuK8paGoPGZXGRutnRkHKQCr
	DDRPJyqcwyHhKsmxPf1EJj5nUGWGgDhlmW/CmPfJkhuxS98jgRUkESoNaFzLcbHy
	/yFNQKcfk846hOy2CJUhL34JsjivG2ibsXeHhIz3kqbwrFBcUlliZFY8SVpQHf1j
	kOsXgIy0g7v4PxdsPqG8lZgMCqZ/JIga2djEThM7yuKH8ew3A3p9qzAs1BFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720430500; x=1720516900; bh=ALXtPAyPFGRfDCNbB9ATLXG5/hOX
	vdJ/sfU/cWdACq8=; b=TjObk1IgHPhmiCGeHTgP4Gyx06uacV7zB/5kAU+tMd7J
	iBwaFRqQ7oS4vJh9q2h6hWMNs0grC7iLZo63ssxfh8HfL8YtdWOr8fUFJxWXIWYL
	Lb2IqGqYFri1QsXvoU9Pjzn+GnK1rPAYHtU7t2LVUhvHJBagwSUclqoEIGxbe+8y
	wmxTmpFLouiCSjzwMcxI0lCRFdGTetr7GTZCNl59fyksKZoJnrp4cpFEaGh4hTDa
	JAEEGppkPuHkreg2ZbNKeDKgeAXoMj11oUFdTaD+bAEOTw+VuBJ5MFXDZAMJmA1C
	+vqaNj/8EkbHrynEr7fre5PRFDg9pB1mRFVRzcfohw==
X-ME-Sender: <xms:o6-LZsftImV-gYyBzlTzoHA9KQ1MeBymI-gM6ynhUQiQgIg0uNbtBA>
    <xme:o6-LZuMj6n6laF5vlyu7vA-MgLN_0gNh0FnvfBdG1pDwH7VDl3UCtJWb-TEc627s_
    5l797kVLYCaRw>
X-ME-Received: <xmr:o6-LZtiRk0xSqLCLalPEoI-SK5w843yW5XwxAcLintnUE7T6Qh1vlzcgzI67VKIpQzzX5H0VNgH0iZjm_zmW342-_fQjpI6IjexyVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejgddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeegheeuhe
    fgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:o6-LZh-V4DezbyDbm0_OfeIDq4OBpfLqJE7ZJXeAtbRlGchADKUh9w>
    <xmx:o6-LZosccSfgiPF4Qoj6oh53iZEVEers9J1sTc8AaVx8ZQf6PZ-K7A>
    <xmx:o6-LZoGl2MUnTTBwBl2IpKqTIiIh_EMR6V9QuBo2YasLF9XRkQsv_g>
    <xmx:o6-LZnPvecWb78LybZPjvooTApfxBZOXC_6x-IQMe4Sql3zTzPecTg>
    <xmx:pK-LZp-2oFQ8EpgDx007JainApx-iNplpLbqLvG7943ZrRahI7Rr_qYC>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jul 2024 05:21:39 -0400 (EDT)
Date: Mon, 8 Jul 2024 11:21:37 +0200
From: Greg KH <greg@kroah.com>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, jesse.zhang@amd.com,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: Patch "drm/amdgpu: fix the warning about the expression
 (int)size - len" has been added to the 6.1-stable tree
Message-ID: <2024070814-handpick-android-43bd@gregkh>
References: <20240705193405.3523811-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705193405.3523811-1-sashal@kernel.org>

On Fri, Jul 05, 2024 at 03:34:04PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     drm/amdgpu: fix the warning about the expression (int)size - len
> 
> to the 6.1-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      drm-amdgpu-fix-the-warning-about-the-expression-int-.patch
> and it can be found in the queue-6.1 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit c71e1d31c7d6735e32dcfd0043970d9fadb00b82
> Author: Jesse Zhang <jesse.zhang@amd.com>
> Date:   Thu Apr 25 15:16:40 2024 +0800
> 
>     drm/amdgpu: fix the warning about the expression (int)size - len
>     
>     [ Upstream commit ea686fef5489ef7a2450a9fdbcc732b837fb46a8 ]
>     
>     Converting size from size_t to int may overflow.
>     v2: keep reverse xmas tree order (Christian)
>     
>     Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
>     Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>

Nope, this breaks the build on 6.1, which is kind of worse than fixing a
build warning :(

I'll go drop this now.

thanks,

greg k-h

