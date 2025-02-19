Return-Path: <stable+bounces-116960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AAFA3B11D
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 06:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D383D3B2818
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 05:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394391B85D6;
	Wed, 19 Feb 2025 05:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BNH0P87+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD7B1B4154
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 05:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739944439; cv=none; b=KNZ793ZqKE/LOVuBV8pZiB2BnGIJYMmMndtICMpHcDjvWAuFfO3l+QwY0Nq3k9R1NXAj9+NUUNHrcS9uzqsviI4k1lvqbDmrH/xPHc4DDSlzCvXcU7zBBv+CnKaZhMXGz0hZfg+sJLfAZBEgiA9ZPB2vusWZdy9QttqNRuZc3xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739944439; c=relaxed/simple;
	bh=dlPhDmOiwSkCpQkWWsWWgF8wD9ADoOjnMmKYdJd5KYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqZ0d5YwzYp9TyiI1OtRu1aKtOGzcVPEe3LDOKiohBlpljETLRV0pVoQwfKnzLIoSom59wgdYkv5jSukZgBig4FYVEacLS8q+839vmvZfTPeFSLA/fm0XkS7vvgdNZ0+N8pxDWuGtR8UCFxNGQAm3c2YZBNFp587qf84hsSQWHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BNH0P87+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2FEC4CED1;
	Wed, 19 Feb 2025 05:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739944438;
	bh=dlPhDmOiwSkCpQkWWsWWgF8wD9ADoOjnMmKYdJd5KYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BNH0P87+y9NH+hlVR8y6O7Y/ex9l525OJTBOXm8iYkeTcicwBVeQGJ6u6FHZIEECp
	 jwx0x7/FhM5XpNyUD/1DtDzS9SibeKgD4vp02jOEgC0WrvhJulQuMK6cW4uQm6GlJj
	 ub34uNAZfV85fX3wQug9rpu/+iAclF/JrnEKksD8=
Date: Wed, 19 Feb 2025 06:53:55 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Pumpkin Chang <pumpkin@devco.re>
Subject: Re: [PATCH 6.12.y 6.13.y] io_uring/kbuf: reallocate buf lists on
 upgrade
Message-ID: <2025021941-getaway-polish-00a9@gregkh>
References: <2025021855-snugly-hacked-a8fa@gregkh>
 <df02f3ce337d92947f14bdd4617b769265098e29.1739926925.git.asml.silence@gmail.com>
 <de75fce7-a3ba-4bf9-bd06-c5713eb84fcb@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de75fce7-a3ba-4bf9-bd06-c5713eb84fcb@gmail.com>

On Wed, Feb 19, 2025 at 01:30:04AM +0000, Pavel Begunkov wrote:
> On 2/19/25 01:28, Pavel Begunkov wrote:
> > [ upstream commit 8802766324e1f5d414a81ac43365c20142e85603 ]
> > 
> > IORING_REGISTER_PBUF_RING can reuse an old struct io_buffer_list if it
> > was created for legacy selected buffer and has been emptied. It violates
> > the requirement that most of the field should stay stable after publish.
> > Always reallocate it instead.
> 
> Just a note that it should apply to 6.13 and 6.12, can you
> pick it for both of them?

Now done, thanks!

greg k-h

