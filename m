Return-Path: <stable+bounces-19766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A090A8535C8
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 17:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 289E5B296BC
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 16:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5651B5F57E;
	Tue, 13 Feb 2024 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="r1S/rt+n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PR4A++XQ"
X-Original-To: stable@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0045D91C
	for <stable@vger.kernel.org>; Tue, 13 Feb 2024 16:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707841004; cv=none; b=d+HM5D5Jn9PYG/UIGUYQkNKWJULmWjDYw1JOn8qWkLt8OPxLte8wC0AO7D/jjpS8UxiAxav3JwIqJAaQ5hGwtnEEAwjHeclX6Hf32+lMSxNvlO8FAMfEvieN+aV/JmdhvKR5yy1L8bfCvWTKBijzxHEajQzccl7OWTMkV1bYalg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707841004; c=relaxed/simple;
	bh=Lb3H5K/WCGFk3Yt+9NS0WUd1oWmI4vkJZFWnOp19FmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdrJDtpBgnvmKwSeUBUlG1kUYE4mJV/nuibM8kG4GZoEyTwIG+vGS4SRzDFnuAjmWVP8+TR7dT7w/M9dTl5LU3/OB0NOKoZmOk7FCfFU39iQm3ktHFacxuIwqHlAjNacoHgiBtogDKJ0ddRzA9BOEOHu9kLx9y+iJk6MTMAfzN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=r1S/rt+n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PR4A++XQ; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id C50675C010C;
	Tue, 13 Feb 2024 11:16:40 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 13 Feb 2024 11:16:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1707841000;
	 x=1707927400; bh=y0mFfNBCNC0LIC86g9r3yn6KcOxFnPMqV4ImjNXHxM8=; b=
	r1S/rt+naWpsKB3/PjYMf/npOgk914M1X/h3sygiWtUh6KKCBQKnfoDepm1uZZAA
	SraUyUtminHHMCgTvRI+OJYUmFlSEbtqCcGdDIxwOoFs93OwRdBW1F25uUhLK2O1
	uI4L1HIeNN0fCBRe9MT1rOkabKbRa6upHFrmw+0jFONNFCUen/vGgxT5XThZUOnB
	kwqTQimNeGkqijFb+Dc2ZePfRPJ158ddyxPRgv21qXkxFC5O2ce+L4Lzr5wwDN44
	dOld1ZueWITy7eq4v+VmONKsLlELExmkSr5L5liRMxbwy/4lJUpqMjAPsEhVtfEI
	QKzqUHOVqHT/8cBdlXlNLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707841000; x=
	1707927400; bh=y0mFfNBCNC0LIC86g9r3yn6KcOxFnPMqV4ImjNXHxM8=; b=P
	R4A++XQIFtUQgvy+QbvDB2SEJhFPkRHUtT5JqYEI418P1IwID9RCE0NlcY6VQr2k
	JzLB03jSDH7+U2WISsizwVpHjWm/70JipZ5pIU+0xm5KeS4hbx5/dBgPXXF1QAeW
	XNaiPXVSc4cWyNSxmBGFIJhs8m/36URldrBh3xqUeqSSyW+0aVcbf5V2qMnvlsEx
	giMhIYHHpIIKQk0ui+jgFz8rDfK+Yni4Vy+Y5g9LJT6ctKot3nRXuP4sc8xluvmg
	VeKBQw8hSZQ3iCXzhwOFItk+g0Kz50nN6POv9H1vN7tgfIF7X/DQP9z72E6ZwkGf
	ipoxr9iah/9NvZD7fxdlw==
X-ME-Sender: <xms:6JXLZa2_6SXWll39U7zDtX1tmKYwfIGQ3NAHxpdXAKrco5A1e1mE7Q>
    <xme:6JXLZdEmLigABEsRQHwO5k827KD-X_RiEMS7RGle5tXJLgBQPhj6j0RQ5-qORpCDE
    hu5krBnW3Jf7Q>
X-ME-Received: <xmr:6JXLZS6lkpB-bHIH5Aj3mzQ8zot8LE9nHxUITIRt4vU-g3LY07pYmBu-XSVwu5jDrAVzqbGPCsFYpqdGFGdi6wkoJ5UUNs2AAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehgdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtudenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepleehhe
    duudeugeegjefgheeuudffheevueekgfekueefledtjeetieeutdekkeelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:6JXLZb0UI74D1278IJ_S1KVRvHBXCgmS0ckSQY6Js2b2Cq2oqn4N2A>
    <xmx:6JXLZdFmEbqYRxpUnvUcC2gKbF8_80NDGNxZgysH8yeezz-cJbAz2w>
    <xmx:6JXLZU8pW2NbS1tK9BuqaUgrzHM4c845nYcK_kaVdOv2NxkW9fvYPw>
    <xmx:6JXLZWP5f8AewIEPejTXyw-hSjT571UQN_O4booT0i_npTMeil2xPw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Feb 2024 11:16:40 -0500 (EST)
Date: Tue, 13 Feb 2024 17:16:38 +0100
From: Greg KH <greg@kroah.com>
To: Jeffrey E Altman <jaltman@auristor.com>
Cc: stable@vger.kernel.org, Michael Lass <bevan@bi-co.net>
Subject: Re: Backport request: commit fe92f874f091 ("net: Fix from address in
 memcpy_to_iter_csum()")
Message-ID: <2024021329-gains-slouchy-142b@gregkh>
References: <20240131155220.82641-1-bevan@bi-co.net>
 <33391482-8c4d-4c27-8be7-f2d014c3ca9a@auristor.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33391482-8c4d-4c27-8be7-f2d014c3ca9a@auristor.com>

On Tue, Feb 13, 2024 at 10:53:44AM -0500, Jeffrey E Altman wrote:
> Please backport to stable 6.7 the following patch which was merged upstream
> as
> 
> commit fe92f874f09145a6951deacaa4961390238bbe0d
> Author: Michael Lass <bevan@bi-co.net>
> Date:   Wed Jan 31 16:52:20 2024 +0100
> 
>     net: Fix from address in memcpy_to_iter_csum()
> 
>     While inlining csum_and_memcpy() into memcpy_to_iter_csum(), the from
>     address passed to csum_partial_copy_nocheck() was accidentally changed.
>     This causes a regression in applications using UDP, as for example
>     OpenAFS, causing loss of datagrams.
> 
>     Fixes: dc32bff195b4 ("iov_iter, net: Fold in csum_and_memcpy()")
>     Cc: David Howells <dhowells@redhat.com>
>     Cc: stable@vger.kernel.org
>     Cc: regressions@lists.linux.dev
>     Signed-off-by: Michael Lass <bevan@bi-co.net>
>     Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
>     Acked-by: David Howells <dhowells@redhat.com>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
> 

Now queued up, thanks.

greg k-h

