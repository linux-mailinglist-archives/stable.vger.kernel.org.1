Return-Path: <stable+bounces-124431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA80A61106
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 13:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66EEC1B61C36
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 12:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87A91FF612;
	Fri, 14 Mar 2025 12:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EZWiAqfO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06B71F4275;
	Fri, 14 Mar 2025 12:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741955069; cv=none; b=FhQI5vFCVgfiKvjfedOEaOhJCTkAPOGBh8Eq4h6am9uioECoJKXyvt+PevR9VhXIF9T5+JSZjvkedCFfFvfoTVQfhAK36xupWqotql2wtrZnC2au1xMTWpUrcujTBeOQpcXkYNtKSlAp3D0GD0kPRvvaGtAik4c9yspOUC7Ynzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741955069; c=relaxed/simple;
	bh=pJdBopXdi+N/T36m5KJSu3OJYdxfIe3aWP95D1vzBjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nH+vfddECHCAcuPEso+zhjs4r5lQCVzrZb0Mjd3PtQxbNey8bz++kQ365WrJed+E3nGjA53gOnSp6H6kS+9QB5vm1X59HnkYi8v+2OmCT6Tbnfw+k9gxaiJrkMfa8Sr0SrIWdhGtMBdJA5Yt88N7rk2xfIHk7Az2OAweSQcVrF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EZWiAqfO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972B3C4CEE3;
	Fri, 14 Mar 2025 12:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741955069;
	bh=pJdBopXdi+N/T36m5KJSu3OJYdxfIe3aWP95D1vzBjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EZWiAqfO5gYlPuOrEAtNoZx6yEjE6L41ZqyU6ebYiYILBDetpyvha42GhBEik3OE8
	 FS/dqHix0mqEpZAaQ76zW1XkuBTTajlNT5BiwHcJHE69N4f93WBWsCRN7hKUISAhuc
	 emrg54Ve1N465lxzXO5JqYFp4dXruXyxByg8mKpc=
Date: Fri, 14 Mar 2025 13:24:26 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Youngmin Nam <youngmin.nam@samsung.com>
Cc: stable@vger.kernel.org, ncardwell@google.com, edumazet@google.com,
	kuba@kernel.org, davem@davemloft.net, dsahern@kernel.org,
	pabeni@redhat.com, horms@kernel.org, guo88.liu@samsung.com,
	yiwang.cai@samsung.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, joonki.min@samsung.com,
	hajun.sung@samsung.com, d7271.choe@samsung.com, sw.ju@samsung.com,
	dujeong.lee@samsung.com, ycheng@google.com, yyd@google.com,
	kuro@kuroa.me, cmllamas@google.com, willdeacon@google.com,
	maennich@google.com, gregkh@google.com,
	Lorenzo Colitti <lorenzo@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: Re: [PATCH 2/2] tcp: fix forever orphan socket caused by tcp_abort
Message-ID: <2025031411-sandbag-scabby-eb1c@gregkh>
References: <20250314092446.852230-1-youngmin.nam@samsung.com>
 <CGME20250314092130epcas2p34e60b23ff983fe03195820a38fb376c5@epcas2p3.samsung.com>
 <20250314092446.852230-2-youngmin.nam@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314092446.852230-2-youngmin.nam@samsung.com>

On Fri, Mar 14, 2025 at 06:24:46PM +0900, Youngmin Nam wrote:
> From: Xueming Feng <kuro@kuroa.me>
> 
> commit bac76cf89816bff06c4ec2f3df97dc34e150a1c4 upstream.
> 
> We have some problem closing zero-window fin-wait-1 tcp sockets in our
> environment. This patch come from the investigation.
> 
> Previously tcp_abort only sends out reset and calls tcp_done when the
> socket is not SOCK_DEAD, aka orphan. For orphan socket, it will only
> purging the write queue, but not close the socket and left it to the
> timer.
> 
> While purging the write queue, tp->packets_out and sk->sk_write_queue
> is cleared along the way. However tcp_retransmit_timer have early
> return based on !tp->packets_out and tcp_probe_timer have early
> return based on !sk->sk_write_queue.
> 
> This caused ICSK_TIME_RETRANS and ICSK_TIME_PROBE0 not being resched
> and socket not being killed by the timers, converting a zero-windowed
> orphan into a forever orphan.
> 
> This patch removes the SOCK_DEAD check in tcp_abort, making it send
> reset to peer and close the socket accordingly. Preventing the
> timer-less orphan from happening.
> 
> According to Lorenzo's email in the v1 thread, the check was there to
> prevent force-closing the same socket twice. That situation is handled
> by testing for TCP_CLOSE inside lock, and returning -ENOENT if it is
> already closed.
> 
> The -ENOENT code comes from the associate patch Lorenzo made for
> iproute2-ss; link attached below, which also conform to RFC 9293.
> 
> At the end of the patch, tcp_write_queue_purge(sk) is removed because it
> was already called in tcp_done_with_error().
> 
> p.s. This is the same patch with v2. Resent due to mis-labeled "changes
> requested" on patchwork.kernel.org.
> 
> Link: https://patchwork.ozlabs.org/project/netdev/patch/1450773094-7978-3-git-send-email-lorenzo@google.com/
> Fixes: c1e64e298b8c ("net: diag: Support destroying TCP sockets.")
> Signed-off-by: Xueming Feng <kuro@kuroa.me>
> Tested-by: Lorenzo Colitti <lorenzo@google.com>
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Link: https://patch.msgid.link/20240826102327.1461482-1-kuro@kuroa.me
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Cc: <stable@vger.kernel.org> # v5.10+

Does not apply to 6.1.y or older, what did you want this applied to?

thanks,

greg k-h

