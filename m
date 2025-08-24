Return-Path: <stable+bounces-172692-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 019CFB32DDF
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 09:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5E7D1B64226
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 07:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46541E8338;
	Sun, 24 Aug 2025 07:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tKRSteK3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FE023D286
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 07:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756018975; cv=none; b=aBmIxtipHuz2S/wHX3oOJBmwUtcPAGcoQNfPDKcmh+0IkgHQphuSrskeTyFsDIj+/OUqdP34m62QBuV3YOHhkXOFv9/OCzotZfSNk/Bmhk775HwnRNLJe0+6RJ/LbD8a3rxD+cu9UCVWTwhtaMaClGS/HqtbQYHFj4we8W/g3bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756018975; c=relaxed/simple;
	bh=524Xl0IUrWbFAvZkMUzjk0jk03nprufUtgun/YnfXnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UY+//jwOPxEDf3s7vjxTgLRLsF2GFrTm+SVYh3xQdvC0Yo+DgBmE8fczDAA+C5P37om5o74hL+kFMMCZGrbo/VSDWYtaxWpaEuBslD15DJrGNskYLEuHHv2qad68pFVnuVgrseM+PjP1Nj6QF+YmhItuqe/fPssBtSUkSrd2pdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tKRSteK3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B922C4CEEB;
	Sun, 24 Aug 2025 07:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756018975;
	bh=524Xl0IUrWbFAvZkMUzjk0jk03nprufUtgun/YnfXnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tKRSteK3xLs8MIwmp78wtXlcXsPd4mRn/et52l2BrlaVQiKs1nzIfN7bKCq4BSTQA
	 GyWCcp2UkuExiCHtjFE8CseTV2thlGK7GJUg0sYuCBx868ESyQ24XY4NywdG8ED+9n
	 nldAWisWlEBytw3o/ATwteO9zx1caLJ/B2RC/8wE=
Date: Sun, 24 Aug 2025 09:02:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Geliang Tang <geliang@kernel.org>,
	Geliang Tang <tanggeliang@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.1.y] mptcp: remove duplicate sk_reset_timer call
Message-ID: <2025082442-relatable-obstinate-7f10@gregkh>
References: <2025082230-overlay-latitude-1a75@gregkh>
 <20250823143406.2247894-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250823143406.2247894-1-sashal@kernel.org>

On Sat, Aug 23, 2025 at 10:34:06AM -0400, Sasha Levin wrote:
> From: Geliang Tang <geliang@kernel.org>
> 
> [ Upstream commit 5d13349472ac8abcbcb94407969aa0fdc2e1f1be ]
> 
> sk_reset_timer() was called twice in mptcp_pm_alloc_anno_list.
> 
> Simplify the code by using a 'goto' statement to eliminate the
> duplication.
> 
> Note that this is not a fix, but it will help backporting the following
> patch. The same "Fixes" tag has been added for this reason.
> 
> Fixes: 93f323b9cccc ("mptcp: add a new sysctl add_addr_timeout")
> Cc: stable@vger.kernel.org
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Link: https://patch.msgid.link/20250815-net-mptcp-misc-fixes-6-17-rc2-v1-4-521fe9957892@kernel.org
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> [ adjusted function location from pm.c to pm_netlink.c ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  net/mptcp/pm_netlink.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Didn't apply cleanly :(

