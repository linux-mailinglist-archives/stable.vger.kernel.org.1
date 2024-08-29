Return-Path: <stable+bounces-71537-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DECC964BBF
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 18:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62F9E1C22C86
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 16:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35BE1B151F;
	Thu, 29 Aug 2024 16:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="oRuZMxPS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fHwf7CZg"
X-Original-To: stable@vger.kernel.org
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FCA1B5EAF
	for <stable@vger.kernel.org>; Thu, 29 Aug 2024 16:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724949234; cv=none; b=PMlyzJkb9pkeq2FzN3fqiIF8YOpQxAT5l6vSYkwY010vFLgDcy0bstQPtGgPbnMVhIqHXngBOzh41UFtpJP0+JB4KDZNhljLiJp4MSMGDL57vyom82fQZYJUOynI/u0Kw+fmzX8j0sYsZ5bJZpeHe7kahdwqixNlazc9RltD/N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724949234; c=relaxed/simple;
	bh=D/55fTAf2DNzDRIm/rKQTqy1CrGLaI0blh6NABtN5C0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onBIsQO28rGodNpufFwILfci+eNIRM03i6DNUVbWGRPYbPjqvcnsWV/xW9qCIYalei+j9yzhKQDaDrVYYzwkERrJne7g2ylEzKW14QNqUyUvXA05FUwq0fxTOqohR3Yxr2+ef5sNF8FJNGz7tEpKYzliyT7gM+c0ke9liSNMSdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=oRuZMxPS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fHwf7CZg; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 169711145481;
	Thu, 29 Aug 2024 12:33:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 29 Aug 2024 12:33:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724949231; x=1725035631; bh=yp5/P2W3it
	wxqEFAslKtYKulI74BmJFpPUR/swurgR8=; b=oRuZMxPSJoR+CdD/fsOqaAq/VR
	kR48jHQ2+7X3UDOkW4gqDjqd42biH2cjYgoUUKSJEB2sfJ2C/doOI9j6+svYyZ3M
	Yb7Olh1LFF6Femkbht2+yfAvdBCnOxeNEOHjZ0VenfpwuzpewU8h70ME5bsJiBRN
	NgzyIz+nI31G7Kq0W1YS3BksUBWNRFOvGqoA+62oVJX2S77TQqTrWbM7VLu2p8C0
	gsHZEKD8nVoIvp0dghq8gvscdLKH/GPhPKbYgNx/mZB1PlMfwn6AhiBmdyPI/STm
	BGX1p+8aHD/skkQlwlqjFnmpQvbBM8J3iyHuiw2sep/iLRG8SDgjIb7EjuVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724949231; x=1725035631; bh=yp5/P2W3itwxqEFAslKtYKulI74B
	mJFpPUR/swurgR8=; b=fHwf7CZgMiVomKbB18R+x8QMnnZLNRtW2W0s9bCiFjtL
	328+3AJkbAEYto8emLL2jpVK6mnKYvuQeBwhSgTbEtPW4bVKzMnDiicQ/a14cxm/
	7lYf3LaILni3UTCwub0a4B9msb8xI4TACrNHdgoPo0d5CsxYAxgHX7YE4D3q+VdY
	qSwXcz/mtxHg97NNYvyJZNQpt3Qua1hENKKTrWuxCY+ScefeBMt+Ibbf1g0I/92B
	colWUHN9ppDKHgbu3GXxqc3/h8sQG0ryj5Plf2H7yvXbZFXvM4+jRwXQtEVicDys
	nOp5styBFHBuSH70ijukMW7bRCAV4Mz9Odyhs+YFXw==
X-ME-Sender: <xms:7qLQZgEW_7t-bV1gKMprRG8wWvPbsYVHeUSONYIGBHPF6yGGd2bDEQ>
    <xme:7qLQZpVgQ6jQE6wh2Ze0LMEKXv0rnS9BhQDTou-13vYbDIbA4FtDxCJ53Mss-ZdL5
    w3U0HiPFKboAg>
X-ME-Received: <xmr:7qLQZqJVMmQ0BRggwJQfrhC2IUIDndD-5fe1jttXVXhRm2uDtQQQW05m_4vQVgAfyqLOsIg07MQN1Z69m0-WKtMAY7WEK-6dTGBcdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtf
    frrghtthgvrhhnpeehgedvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueef
    hffgheekteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehgrhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohephhhsihhmvghlihgvrhgvrdhophgvnhhsohhurhgtvg
    esfihithgvkhhiohdrtghomhdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehmshiivghrvgguihesrhgvughhrghtrdgtohhmpd
    hrtghpthhtohepjhgrmhhorhhrihhssehlihhnuhigrdhmihgtrhhoshhofhhtrdgtohhm
X-ME-Proxy: <xmx:7qLQZiFumZT9gIRmXZ42_CykzDVy_DcxNDz1IN4Rksfrr9t0m5aDTA>
    <xmx:7qLQZmVO9X4y3MAIbGRO93RGtyVk069QsMDh6e08lz7WVVBNgTYH_A>
    <xmx:7qLQZlO7485Ocn-5zBkyLbbXNfVbhSKRdDPeXQbtpx-dtqfv0IQP8w>
    <xmx:7qLQZt3lZM4-sGsHGcRHSKVYPSB--sEw284HisqaXjPfH_nBIfxf6g>
    <xmx:76LQZqrqiZpt0kGLoIaAJ8h4i08WuF1NB7fYsIVFArW_W310pnGk6gOf>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Aug 2024 12:33:50 -0400 (EDT)
Date: Thu, 29 Aug 2024 18:33:47 +0200
From: Greg KH <greg@kroah.com>
To: hsimeliere.opensource@witekio.com
Cc: stable@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
	James Morris <jamorris@linux.microsoft.com>
Subject: Re: [PATCH 4.19 1/1] vfs: move cap_convert_nscap() call into
 vfs_setxattr()
Message-ID: <2024082914-relay-climatic-95c7@gregkh>
References: <20240829162631.19391-1-hsimeliere.opensource@witekio.com>
 <20240829162631.19391-2-hsimeliere.opensource@witekio.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829162631.19391-2-hsimeliere.opensource@witekio.com>

On Thu, Aug 29, 2024 at 06:26:21PM +0200, hsimeliere.opensource@witekio.com wrote:
> From: Miklos Szeredi <mszeredi@redhat.com>
> 
> commit 7c03e2cda4a584cadc398e8f6641ca9988a39d52 upstream.
> 
> cap_convert_nscap() does permission checking as well as conversion of the
> xattr value conditionally based on fs's user-ns.
> 
> This is needed by overlayfs and probably other layered fs (ecryptfs) and is
> what vfs_foo() is supposed to do anyway.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> Acked-by: James Morris <jamorris@linux.microsoft.com>
> Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
> ---
>  fs/xattr.c                 | 17 +++++++++++------
>  include/linux/capability.h |  2 +-
>  security/commoncap.c       |  3 +--
>  3 files changed, 13 insertions(+), 9 deletions(-)

Again, we can not take chagnes for only older kernels and not newer
ones.  Please resend for all applicable releases.

thanks,

greg k-h

