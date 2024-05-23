Return-Path: <stable+bounces-45659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAEC8CD188
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FA8A1F223D5
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 11:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F9013BC11;
	Thu, 23 May 2024 11:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j69GnM6l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2973E13BAFB;
	Thu, 23 May 2024 11:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716465064; cv=none; b=k8VSuPWnV1BP5u5u8sbxVB/anGxrQQt3944qj5YKJ2nNSUwjVXMs1qdyhJC1O2D91zyklUgVZOVyTz3OjSFwFgOfxz4JmKnOsyxdxsLA+f5qUKzY1KfiP73OKS/TY9ZvS8vZbXLDcJd+1ZuL9zDPCPVc+LgPFnHhoE63yxH86ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716465064; c=relaxed/simple;
	bh=u0YkCFRTcTzKFzBamw33g0wiWbg4CD2Oj29HPPLaiG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MA5XkT1DtEYpRll4ik+VPs7fXrc5VfTpkOYwJleW9Lkau/aQI64YISy1VzOii1P9ssR+xcBdR75MVX4/AYDAQrbHtz64Dm7GYV28nsH+IUu0cyH5Lu75DAhI9ErwNNYna7193zHdUVnK9Bhr/xitsjBQB8oD4xV1gHdOWrfym5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j69GnM6l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F859C2BD10;
	Thu, 23 May 2024 11:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716465064;
	bh=u0YkCFRTcTzKFzBamw33g0wiWbg4CD2Oj29HPPLaiG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j69GnM6lUKEsUvLF6CSUTdJnZUzjyrOfSUiLri50hnx12fMUur5J2bi7ll6TSVuXq
	 v+KPSJ1nwGadce/sXyARB69vMXNmVhEJy62ni9Nqc1+/D2f1fiAzZef+LwDWCgUIWf
	 19ZCntMxQhbtk4FI0wqtRRQe39JmlDVtNGYsizeg=
Date: Thu, 23 May 2024 13:51:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yenchia Chen <yenchia.chen@mediatek.com>
Cc: stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Eric Dumazet <edumazet@google.com>, Sasha Levin <sashal@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Zhengchao Shao <shaozhengchao@huawei.com>,
	Ryosuke Yasuoka <ryasuoka@redhat.com>, Thomas Graf <tgraf@suug.ch>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 5.15 0/2] netlink, fix issues caught by syzbot
Message-ID: <2024052354-cubical-taste-44e8@gregkh>
References: <20240515073644.32503-1-yenchia.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515073644.32503-1-yenchia.chen@mediatek.com>

On Wed, May 15, 2024 at 03:36:36PM +0800, Yenchia Chen wrote:
> From: "yenchia.chen" <yenchia.chen@mediatek.com>
> 
> Hi,
> 
> We think 5.15.y could pick these commits.
> 
> Below is the mainline commit:
> 
> netlink: annotate lockless accesses to nlk->max_recvmsg_len
> [ Upstream commit a1865f2e7d10dde00d35a2122b38d2e469ae67ed ]
> 
> netlink: annotate data-races around sk->sk_err
> [ Upstream commit d0f95894fda7d4f895b29c1097f92d7fee278cb2 ]
> 
> Eric Dumazet (2):
>   netlink: annotate lockless accesses to nlk->max_recvmsg_len
>   netlink: annotate data-races around sk->sk_err
> 
>  net/netlink/af_netlink.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> -- 
> 2.18.0
> 
> 

All now queued up, thanks.

greg k-h

