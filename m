Return-Path: <stable+bounces-104002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 751379F0A8B
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 12:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35C422825E2
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 11:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346AF1D88D0;
	Fri, 13 Dec 2024 11:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GhrM4K+J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AC91D5AC0;
	Fri, 13 Dec 2024 11:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734088383; cv=none; b=LhzW5D/oyRdood51SBbAQeoz1FDScxFIej4FD1voOFEmcwDnh7c6SBYcvTCj6sAXZw2QzHvmFy1IFVG8jvCA5XwkymHDvueMukoo4YwnOQtulfJ/3uiKydrYBiZTqM7ljz0jX07OTNdZ8KgZfiTnUJ4TovRpJKc580cRjO/Yrjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734088383; c=relaxed/simple;
	bh=ghEc1mMw4UknSZAXTzEjzz6QbuWdZS2vAc1pYml5U8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C14tY2JgtV7NZlcEyrFLNxHLaQXgoaCdQrtItHxc+1d/XHEnKGaOdiWhurBgUSDI/FdWxnb2dkeK1o+SBy2jPZmEAPl0JL5NwXeoW0vt2Em5YrkJ033WRX7IAXuKsDZ9MXOM4kF6w5kloQn/HOXoMxnt0Skhw5NYc3q8HW5FxQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GhrM4K+J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF25EC4CED0;
	Fri, 13 Dec 2024 11:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734088382;
	bh=ghEc1mMw4UknSZAXTzEjzz6QbuWdZS2vAc1pYml5U8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GhrM4K+Jbyq121MJ3/fM9WLVZlFEExKouVKa8LzIcd1GgEGKLVUwniDnkhPkzcCgu
	 bhUhMl0w22POtOb3yKPi3F8UpTTYZW+wJARtQq55eSEHtc/YXOKVLuO8a8G2IgEI4Z
	 ytrsVgxIR8ymKB75T1/d4QcQuRVJ1RTVQrpFQvwY=
Date: Fri, 13 Dec 2024 12:12:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hardik Gohil <hgohil@mvista.com>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org,
	Kenton Groombridge <concord@gentoo.org>,
	Kees Cook <kees@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Xiangyu Chen <xiangyu.chen@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v5.10.y v5.4.y] wifi: mac80211: Avoid address
 calculations via out of bounds array indexing
Message-ID: <2024121334-clubbing-sublime-ed44@gregkh>
References: <1729316200-15234-1-git-send-email-hgohil@mvista.com>
 <2024102147-paralyses-roast-0cec@gregkh>
 <CAH+zgeGXXQOqg5aZnvCXfBhd4ONG25oGoukYJL5-uHYJAo11gQ@mail.gmail.com>
 <2024110634-reformed-frightful-990d@gregkh>
 <CAH+zgeGs7Tk+3sP=Bn4=11i5pH3xjZquy-x1ykTXMBE8HcOtew@mail.gmail.com>
 <2024121233-washing-sputter-11f4@gregkh>
 <CAH+zgeEhb2+SmB7ru8uGuNs+QX==QAWxeDgOHUQ_G3stWbMBWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH+zgeEhb2+SmB7ru8uGuNs+QX==QAWxeDgOHUQ_G3stWbMBWg@mail.gmail.com>

On Fri, Dec 13, 2024 at 03:54:58PM +0530, Hardik Gohil wrote:
> >
> > What did you do to change this patch?
> >
> > Also, what about 5.15.y, you can't "skip" a stable tree :(
> >
> > thanks,
> >
> > greg k-h
> 
> I have not done any changes to patch but tested the patch from 6.6.y
> by applying to 5.10.y and 5.4.y versions
> 
> ref:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.6.65&id=26b177ecdd311f20de4c379f0630858a675dfc0c

I have no context here at all, sorry :(

