Return-Path: <stable+bounces-244918-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEKLAjLh/mlpyQAAu9opvQ
	(envelope-from <stable+bounces-244918-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 09:24:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 954A64FE72C
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 09:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74691301C90B
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 07:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8772837AA88;
	Sat,  9 May 2026 07:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jVHNbdKd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E4E2E7F0A;
	Sat,  9 May 2026 07:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778311097; cv=none; b=TQYvB9um68LULBi8UcpRkwUytdavyNqqySMvTydYZhs/jAYzMlW+gdrgI31GAeiKjeA34bMvRHQscUyoReseh6bHw5nQ02lzbfLXNdIYkAonPNu2YVGRTsevHi1F61YBOPCWB7C/N05ZjT6+svlq1/mW0ORFFdxwsYQeIDOxF8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778311097; c=relaxed/simple;
	bh=CfaQizb78de1n+N5YUP8CfRQSYNCVrk0yL+FyZH0XzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUJC8RdznR1bc/bDpnYVdHNVk5NKHKF/qBjsi+kaL3Bp/4mBAOfzrqF1pYd1OcH74qpVdfB3CYSeIE1FZHlu+pX9jENnAisOXZcaFLtipHpFgLXKLWk2iw2cT1Yujf57pQayPPXpOX6xDMHZ0hX/HnUxrngd+c4oTGK8+J7bgqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jVHNbdKd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85978C2BCB2;
	Sat,  9 May 2026 07:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778311096;
	bh=CfaQizb78de1n+N5YUP8CfRQSYNCVrk0yL+FyZH0XzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jVHNbdKdUjeI8wvlqs43aFkdN8mVvVFMmfHgl+DtJGMWjPOINWJPPbDIZmCvk9ZHp
	 W2Sv/PQu5n85y8qnVtb9EtQogv00BFiFuD+N+H108Lys/+VVDishN7OeJidbCY7MS8
	 3/ITJTdyFqCskwDEzdDbGvLgsWvUQXFFa9N0Zk6s=
Date: Sat, 9 May 2026 09:17:33 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: =?utf-8?B?5pyo5Y+j55KD6Z+z?= <kiguchi.r.sec@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, security@kernel.org
Subject: Re: [PATCH] staging: vme_user: validate slave window size against
 buffer size
Message-ID: <2026050919-gerbil-audience-3895@gregkh>
References: <CAKs+XO1WXrv4jvNuEyMxu-iP9E-fifJLwOZ1nJynDjpvfn2n=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKs+XO1WXrv4jvNuEyMxu-iP9E-fifJLwOZ1nJynDjpvfn2n=g@mail.gmail.com>
X-Rspamd-Queue-Id: 954A64FE72C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	FROM_DN_EQ_ADDR(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-244918-lists,stable=lfdr.de];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sat, May 09, 2026 at 03:58:45PM +0900, 木口璃音 wrote:
> diff --git a/drivers/staging/vme_user/vme_user.c
> b/drivers/staging/vme_user/vme_user.c
> index 11e25c2f6..41b8d5b51 100644
> --- a/drivers/staging/vme_user/vme_user.c
> +++ b/drivers/staging/vme_user/vme_user.c
> @@ -156,6 +156,11 @@ static ssize_t buffer_to_user(unsigned int minor,
> char __user *buf,
>  {
>   void *image_ptr;
> 
> + if (*ppos < 0 || (u64)*ppos >= image[minor].size_buf ||
> +     count > image[minor].size_buf - (u64)*ppos) {
> + pr_warn_ratelimited("%s: out-of-bounds access\n", __func__);
> + return -EINVAL;
> + }

Also the patch is corrupted :(


