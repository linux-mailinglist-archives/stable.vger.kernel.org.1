Return-Path: <stable+bounces-70297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6209600F3
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 07:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B70891C21DC1
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 05:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6411C39FC5;
	Tue, 27 Aug 2024 05:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wOcB5lJy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADAE6EB7C
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 05:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724735664; cv=none; b=WHPzJU/oJYnZus8mjcKskDCjyAVMyl1R26CrkaJP8qV0lC/scUBhTFddmXkF+NVIk8agX79I95XXfvtFUZbJCj+MxwlwDClsYsL6LAp6+135o+1x6L+43BZ/WFiw89tIj1FdP9m7WAUH/Xwo1dqDnmeX2cvCqCOYL1V66nsuc0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724735664; c=relaxed/simple;
	bh=NBVuIprllsGaT4F4YdtnqEmRuFtz4FUE40TPrlPHTy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvkOTy/xKkvX5mAvPQjwmpSS47TMHK75xukfER2H5FMBlvAGtXoLsJYYE6t2imryzxU1tPF+rYNZA0kcC7OjB+DC6J0W2Gx6aMXsoSSN6Jpm2mqC+9kSWeAa/KCQtVtvT3Nerzc2rnJwLEC/GA8tpbNhLYpPquQBu17rtNp07gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wOcB5lJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBA6C8B7A3;
	Tue, 27 Aug 2024 05:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724735663;
	bh=NBVuIprllsGaT4F4YdtnqEmRuFtz4FUE40TPrlPHTy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wOcB5lJy6ZuKuXpj6E6WUlcRHLfnlyfdkwvWSYlMPCpDbDyerEd5CzBQeyuv5lNsf
	 trggGUgmsufuBuu2NJava42LvM2cAH1kZVIQylUZJ7dm8Vxxa5TgeuyvOjfb7F9uqT
	 6VOWOOc2DANQqJNbRdILRMMjAALoSoxyfXdgYwnA=
Date: Tue, 27 Aug 2024 07:14:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: stfrench@microsoft.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] ksmbd: the buffer of smb2 query dir
 response has at least 1" failed to apply to 5.15-stable tree
Message-ID: <2024082730-squire-entire-f488@gregkh>
References: <2024082604-depose-iphone-7d55@gregkh>
 <CAKYAXd_KPR0FAsx+6DrEfU3J-ahnMtfA64gqyxHCOMHS3ZZejA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKYAXd_KPR0FAsx+6DrEfU3J-ahnMtfA64gqyxHCOMHS3ZZejA@mail.gmail.com>

On Tue, Aug 27, 2024 at 11:54:56AM +0900, Namjae Jeon wrote:
> On Mon, Aug 26, 2024 at 8:38 PM <gregkh@linuxfoundation.org> wrote:
> >
> >
> > The patch below does not apply to the 5.15-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> As follows, I have marked stable tag(v6.1+) in patch to apply to 6.1
> kernel versions or later.
> 
>  Cc: stable@vger.kernel.org # v6.1+

Yes, but you also say:

	Fixes: eb3e28c1e89b ("smb3: Replace smb2pdu 1-element arrays with flex-arrays")

Which has been backported to the 5.10.y and 5.15.y kernel trees, so this
is why the FAILED email was triggered.

> This patch does not need to be applied to 5.15 or 5.10.

Are you sure?  If so, why is that the Fixes: tag?

thanks,

greg k-h

