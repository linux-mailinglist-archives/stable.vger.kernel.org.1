Return-Path: <stable+bounces-172698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F4FB32E12
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 09:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5810A24131F
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 07:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD07253355;
	Sun, 24 Aug 2025 07:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OA6sWYE+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBD0393DCF
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 07:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756022337; cv=none; b=b7nejzmDNrYZB/Hkmy3/+FxoxrEe1hDmqNDbhgERrCcOV/Ew8PZHXz/tlynISHLBoGNoliElOfewdBPISr9JHUXSgpi3MzEmwIWCagEX5BPTlq0lIU0MrHNORfbC4XYLJIkyeB9jXPNmzkJ/gBa/xB7OFd68ZtZ9//XRA4jhew0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756022337; c=relaxed/simple;
	bh=Jvo+hTdgbXQxjfvnWvJBMD5i29CjVGEkfH04rwBSmGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSSYz6bUtuLfrQ+2NOsQLvfM4KNy/6bzDegzCfndy3A6CG5pugFJYukbUgnamniM9zfTHyQmtmrpRIHNjLewGWJ2Dw/w0EfHBA9f3CSf5oGT6EbYFukOKg0XvYhxt65YXjK72HvWZ9LfTK6IQmiLp6zxGAZ3a19qumk7jTVDBT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OA6sWYE+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC6AC4CEEB;
	Sun, 24 Aug 2025 07:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756022337;
	bh=Jvo+hTdgbXQxjfvnWvJBMD5i29CjVGEkfH04rwBSmGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OA6sWYE++VtU0pGpmgdU2pX5tBHT8//4mygbgX+Yr5KKLQY9WbJbV4czf8xT4gM0q
	 UwNycmjnlSTkLZvC4ihJF78nO+ldvYc4E/ZjIsu2lqjDhVXGzDJ8LslXuEgGnZFg8w
	 6jq6VvzJ0vJSFxExfJ6ER9OfGmHhB7X3McsTY0xw=
Date: Sun, 24 Aug 2025 09:58:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Geliang Tang <geliang@kernel.org>,
	Geliang Tang <tanggeliang@kylinos.cn>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.1.y] mptcp: remove duplicate sk_reset_timer call
Message-ID: <2025082431-retouch-overnight-5a1c@gregkh>
References: <2025082230-overlay-latitude-1a75@gregkh>
 <20250823143406.2247894-1-sashal@kernel.org>
 <2025082442-relatable-obstinate-7f10@gregkh>
 <e39b9a56-90c5-4379-bc6a-22a719c67848@kernel.org>
 <2025082408-ascent-transfer-2883@gregkh>
 <49616650-6430-480b-99ee-0adf5cc30c77@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49616650-6430-480b-99ee-0adf5cc30c77@kernel.org>

On Sun, Aug 24, 2025 at 09:45:09AM +0200, Matthieu Baerts wrote:
> Hi Greg,
> 
> 24 Aug 2025 09:15:22 Greg KH <gregkh@linuxfoundation.org>:
> 
> > On Sun, Aug 24, 2025 at 09:08:06AM +0200, Matthieu Baerts wrote:
> >> Hi Greg, Sasha,
> >>
> >> 24 Aug 2025 09:02:56 Greg KH <gregkh@linuxfoundation.org>:
> >>
> >>> On Sat, Aug 23, 2025 at 10:34:06AM -0400, Sasha Levin wrote:
> >>>> From: Geliang Tang <geliang@kernel.org>
> >>>>
> >>>> [ Upstream commit 5d13349472ac8abcbcb94407969aa0fdc2e1f1be ]
> >>>>
> >>>> sk_reset_timer() was called twice in mptcp_pm_alloc_anno_list.
> >>>>
> >>>> Simplify the code by using a 'goto' statement to eliminate the
> >>>> duplication.
> >>>>
> >>>> Note that this is not a fix, but it will help backporting the following
> >>>> patch. The same "Fixes" tag has been added for this reason.
> >>>>
> >>>> Fixes: 93f323b9cccc ("mptcp: add a new sysctl add_addr_timeout")
> >>>> Cc: stable@vger.kernel.org
> >>>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> >>>> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> >>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> >>>> Link: https://patch.msgid.link/20250815-net-mptcp-misc-fixes-6-17-rc2-v1-4-521fe9957892@kernel.org
> >>>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> >>>> [ adjusted function location from pm.c to pm_netlink.c ]
> >>>> Signed-off-by: Sasha Levin <sashal@kernel.org>
> >>>> ---
> >>>> net/mptcp/pm_netlink.c | 5 ++---
> >>>> 1 file changed, 2 insertions(+), 3 deletions(-)
> >>>
> >>> Didn't apply cleanly :(
> >>
> >> I don't know if it is the reason, but I sent the same patches on Friday:
> >>
> >> https://lore.kernel.org/20250822141124.49727-5-matttbe@kernel.org/T
> >
> > And it didn't apply either?
> >
> > I'm confused...
> 
> It looks like you first applied this other patch from Sasha for 6.1.y:
> 
> https://lore.kernel.org/20250823145534.2259284-1-sashal@kernel.org
> 
> But this patch includes the one here you are trying to apply, instead of
> depending on it.
> 
> In terms of code, the result is the same, but there is now one commit
> instead of 2. (Which is fine for me)

Ah, thanks for figuring it out, I'll leave it as-is for now, as
unwinding it will be a mess :)

greg "too many stable trees" k-h

