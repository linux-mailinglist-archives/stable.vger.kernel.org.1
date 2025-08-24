Return-Path: <stable+bounces-172695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B90B32DED
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 09:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 586F45E29B5
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 07:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D644C248863;
	Sun, 24 Aug 2025 07:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YIi5NMDE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1BA246777
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 07:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756019722; cv=none; b=jUwwmEsS3m/W+fxstxI8RQVSHNhhwbI+ISo+OiajQNbBl5TfKQl1ZMFf+yw1ZjgK3HiINBv5J9KGIO7mnbIsW5jOiY07z0Lo8FzD5AYhf4iboklj4JpChnwoXz1TnDqmbkIGffPGvvM3XGYYx+VazytEZLuoCV899noVJU/caNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756019722; c=relaxed/simple;
	bh=7N/HHraWMbReoAgRWgm19kvSzjTiSiBvJQjRTHIIvhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eD2iTsIO09MIn7myh9n2NZOJxYVMf3jbg80PEGAYwC+i+1S9p3P4Phe+UWbMuoHtzyeIZn0lxEUZRY53saX572xCYL+qV8jhrUt1+sV/5CMr/3i8orqftAPWc6PEneClYc+Skaz8eXZQjM8BJpUPNfUMjnXVyWTrwE5K40efSMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YIi5NMDE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04C7C4CEEB;
	Sun, 24 Aug 2025 07:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756019721;
	bh=7N/HHraWMbReoAgRWgm19kvSzjTiSiBvJQjRTHIIvhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YIi5NMDE/TA9GcYww+fHgyHyf7irSv1ZMiuJMEDRgbjgCc1cAoQ4aXkX0cJDIzoWa
	 d7rb7Te3gD1nSHR6vlLIWCU48FqYtcJJRkucG1OsyM0FJt5suqgog72dRgKd5cw9Jr
	 swwM1oac0N1BYVYSKpifU6qQU4EbFHvmJioj1gy8=
Date: Sun, 24 Aug 2025 09:15:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Geliang Tang <geliang@kernel.org>,
	Geliang Tang <tanggeliang@kylinos.cn>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.1.y] mptcp: remove duplicate sk_reset_timer call
Message-ID: <2025082408-ascent-transfer-2883@gregkh>
References: <2025082230-overlay-latitude-1a75@gregkh>
 <20250823143406.2247894-1-sashal@kernel.org>
 <2025082442-relatable-obstinate-7f10@gregkh>
 <e39b9a56-90c5-4379-bc6a-22a719c67848@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e39b9a56-90c5-4379-bc6a-22a719c67848@kernel.org>

On Sun, Aug 24, 2025 at 09:08:06AM +0200, Matthieu Baerts wrote:
> Hi Greg, Sasha,
> 
> 24 Aug 2025 09:02:56 Greg KH <gregkh@linuxfoundation.org>:
> 
> > On Sat, Aug 23, 2025 at 10:34:06AM -0400, Sasha Levin wrote:
> >> From: Geliang Tang <geliang@kernel.org>
> >>
> >> [ Upstream commit 5d13349472ac8abcbcb94407969aa0fdc2e1f1be ]
> >>
> >> sk_reset_timer() was called twice in mptcp_pm_alloc_anno_list.
> >>
> >> Simplify the code by using a 'goto' statement to eliminate the
> >> duplication.
> >>
> >> Note that this is not a fix, but it will help backporting the following
> >> patch. The same "Fixes" tag has been added for this reason.
> >>
> >> Fixes: 93f323b9cccc ("mptcp: add a new sysctl add_addr_timeout")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> >> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> >> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> >> Link: https://patch.msgid.link/20250815-net-mptcp-misc-fixes-6-17-rc2-v1-4-521fe9957892@kernel.org
> >> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> >> [ adjusted function location from pm.c to pm_netlink.c ]
> >> Signed-off-by: Sasha Levin <sashal@kernel.org>
> >> ---
> >> net/mptcp/pm_netlink.c | 5 ++---
> >> 1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > Didn't apply cleanly :(
> 
> I don't know if it is the reason, but I sent the same patches on Friday:
> 
> https://lore.kernel.org/20250822141124.49727-5-matttbe@kernel.org/T

And it didn't apply either?

I'm confused...

