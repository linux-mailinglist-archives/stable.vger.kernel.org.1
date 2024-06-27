Return-Path: <stable+bounces-55953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB7B91A594
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 13:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1B71C216C4
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 11:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEB314AD0E;
	Thu, 27 Jun 2024 11:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="c0zN5d+z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oaWRz6rB"
X-Original-To: stable@vger.kernel.org
Received: from flow7-smtp.messagingengine.com (flow7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA7A13F441;
	Thu, 27 Jun 2024 11:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719488686; cv=none; b=uZdwBCjl+dZfhZtD47QJACoPWQ1eakJ7bVP4YR9BOKIAdY/b1fQRuiELzWs49hGjGUlC6DVxHWftpmysylYUFeqXeGdFUdtfe9nO8WgzJxmEVCrkyNoOv/5zGv2TWClDEpwXK+XBLQZYvrTyBduiGFZlzS8N5fUgD6vtAom0jYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719488686; c=relaxed/simple;
	bh=TLewCmcpPHqhY5A39cMHTKFtfml4dT4GwihqEz2HF4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HalNEutzBbCjtWV4oJ+TY3JBDbeUXXcZwLG18OMICl/8FtStoGiuzvGaAmEvVg73lXhHkpfa29kP/DM5J1vSHZLVvH7ZdBG8YMTCdK5WC5X9/H4gzHpc1RIq8KHxM1pQCQQ4XtDOKi0hZfkOkAX14cEF5ogv/bsBbiuHff5eD+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=c0zN5d+z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oaWRz6rB; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailflow.nyi.internal (Postfix) with ESMTP id 595F72001CD;
	Thu, 27 Jun 2024 07:44:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 27 Jun 2024 07:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1719488683;
	 x=1719495883; bh=9gyG7wlh1QIEKIg/21vyG7suAQH24Dus6aNn+hOYVKQ=; b=
	c0zN5d+z41HjhLHCz3GMS1+j0P3dLOpI4X0+ceFBjKPmHQ+13zaSe3A8q/Nk31+V
	kXJY4Tuh5SsqZdflY1R9uf7LvRwWDShRG0WuA2vmZKx01m7ZjPYPKg9LT3BdJzlf
	GpJLQa8jz50AHhL47EewIftyhztxwZFpt01J2MYsY+yocKj5R7qwrPy67VKEAXTE
	nf1lR204RyvLcOKcqT3+Lom5BppR8euQMR7LT6VH6U9Odfy0CfEfwoePVplfnYtt
	0EgeggADlwG9NTPgK32WEV16BiciO+oECRs1+bhAtt1avUAZAfZ2HHKhZwyBu/sU
	o7e5mqIXwst/Q1Huq21Mgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1719488683; x=
	1719495883; bh=9gyG7wlh1QIEKIg/21vyG7suAQH24Dus6aNn+hOYVKQ=; b=o
	aWRz6rBl7EGWhipAHW+lA9o3LGvqgCVuFhfhXgn79PPqBak/JNZRqicZHPHvv4N/
	DtvY99yRSkE1PRtL3PHz0/WyekR+COZ9vBlOX/mbdhSi3/utq4EWZybxhzCAuWCZ
	N0AjiZqhJ/3e+cbALsA6X1nf+MMLMaTDxByR2pm0s55baSQwMTE6EBoEHtSdGibc
	fLbzFrJ3eetyVLpMUSuf1hS9eS7JUQmjlRwSNb+RQjEC/7inuRJvA6O6Pszq3HS0
	dPQ/YJy/vv5TgHMDktbqlN1Hr5X2eBKNGiFx8tqRGi4LqsJ0Ll2aJD8SHB2Zn2RQ
	OiGxBpK4Ncek5zuEOzEfQ==
X-ME-Sender: <xms:qlB9ZgBdCSKDTxjvmcDSlRzwl_9Yu9mlqeq7VnmKz-thf3JuDpWeTQ>
    <xme:qlB9Zii1gOs3JWgPenYHxj7hDI9usHN5aurjMTTdGVMhoqWdRLd5WSeSG4xxmYhnJ
    jpK89VQ66sw5A>
X-ME-Received: <xmr:qlB9Zjlqz5Ac79XXWqSq7DO6O_fX-F8o4fM6aXRy9XFdNoPCYlGrat55twI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtdeggdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgfekff
    eifeeiveekleetjedvtedvtdeludfgvdfhteejjeeiudeltdefffefvdeinecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:qlB9ZmzcLqEahwr1ZbRC5tq9LdUPgPwk0xFdD7O7XG3NXIW_pXn5Ew>
    <xmx:qlB9ZlSm0NIXE5e_BYzyfwzLpUQI4A2eHiw55yEJd7ZC5k3rQzRC8g>
    <xmx:qlB9ZhbmnOZV6XAQSvNswxxCu2HTNJwvKGWQ_skDyUjTazx8ID_msQ>
    <xmx:qlB9ZuRMa8rSuMX35sUcagpVRIFHxdKIfUUuZkjltL9eoAu_sMjZ_A>
    <xmx:q1B9ZhIxZbaPOdGXA0xz68p0gLtDcgQn20N-yvK-JUSMZoHjA8mxmhAK>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Jun 2024 07:44:41 -0400 (EDT)
Date: Thu, 27 Jun 2024 13:44:39 +0200
From: Greg KH <greg@kroah.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Ma Ke <make24@iscas.ac.cn>, dri-devel@lists.freedesktop.org,
	Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	David Airlie <airlied@gmail.com>
Subject: Re: [PATCH v2] drm/gma500: fix null pointer dereference in
 cdv_intel_lvds_get_modes
Message-ID: <2024062731-left-cackle-4fc4@gregkh>
References: <20240627063220.3013568-1-make24@iscas.ac.cn>
 <eb14ae3b-7a4f-4802-b9a7-9ffec3b951f9@web.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb14ae3b-7a4f-4802-b9a7-9ffec3b951f9@web.de>

On Thu, Jun 27, 2024 at 01:33:40PM +0200, Markus Elfring wrote:
> > In cdv_intel_lvds_get_modes(), the return value of drm_mode_duplicate()
> > is assigned to mode, which will lead to a NULL pointer dereference on
> > failure of drm_mode_duplicate(). Add a check to avoid npd.
> 
> A) Can a wording approach (like the following) be a better change description?
> 
>    A null pointer is stored in the local variable “mode” after a call
>    of the function “drm_mode_duplicate” failed. This pointer was passed to
>    a subsequent call of the function “drm_mode_probed_add” where an undesirable
>    dereference will be performed then.
>    Thus add a corresponding return value check.
> 
> 
> B) Would you like to append parentheses to the function name
>    in the summary phrase?
> 
> 
> C) How do you think about to put similar results from static source code
>    analyses into corresponding patch series?
> 

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot

