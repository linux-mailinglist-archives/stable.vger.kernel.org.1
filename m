Return-Path: <stable+bounces-120440-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD0FA50178
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 15:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E17353A8569
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 14:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF51420C499;
	Wed,  5 Mar 2025 14:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cDBrB/5B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FAE24A075;
	Wed,  5 Mar 2025 14:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741183709; cv=none; b=DI0f7/BwedMRo6aL/OPDKAyJWv3ZXe435wBZWz7mG44rvSImAB1xwNNtA96zlJyux4D3x4SU/KLPO7/dg2s5y63Ubu27sEBgN6AsLzTIrIgdPGzxNfLIlvixdzyYUNet/9MZEquSDOd2xDR1ibWhUv4UydGFWz8/hlN5TnPQidQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741183709; c=relaxed/simple;
	bh=3+GR7BVtAhPX5hvMW1vQnMXqYLElXQwwk1OW9oK0rFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PoRAdwrewv6j8VwUCMe/oc+e79QsOBbi5Rn8ve0tXUja4ZEjo347JbbpTWpCVsY/UyNeniipel1x47gsgJQlKUrWTde5Wl1VdAdQF008pMNhUnUvc1zEpFYxn5xm3mHaTnzSoQ6zQkGI+YY3S61yTDWic970iTOWunxCp4Fj6kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cDBrB/5B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876A8C4CED1;
	Wed,  5 Mar 2025 14:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741183708;
	bh=3+GR7BVtAhPX5hvMW1vQnMXqYLElXQwwk1OW9oK0rFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cDBrB/5BKZp4XaMi6WEfw+FrIJ8rpM51n1dV/6MpDCP0anlp5ZzAlclI2oofX9M9r
	 SkPQqU32ve2yv/VhrUakVTz4cIUeuv8x13VNaIHbwvHs6BFD7s9Oc1ybB/bodIzYI1
	 KrWrIk36QzglptukJR/7M1cJv7oGoK1vhieieeQ8=
Date: Wed, 5 Mar 2025 15:08:26 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Sasha Levin <sashal@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	stable@vger.kernel.org, netdev@vger.kernel.org,
	Lei Lu <llfamsec@gmail.com>
Subject: Re: [PATCH stable 5.15/6.1/6.6] af_unix: Clear oob_skb in
 scan_inflight().
Message-ID: <2025030543-banker-impale-9c08@gregkh>
References: <20250304030149.82265-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304030149.82265-1-kuniyu@amazon.com>

On Mon, Mar 03, 2025 at 07:01:49PM -0800, Kuniyuki Iwashima wrote:
> Embryo socket is not queued in gc_candidates, so we can't drop
> a reference held by its oob_skb.
> 
> Let's say we create listener and embryo sockets, send the
> listener's fd to the embryo as OOB data, and close() them
> without recv()ing the OOB data.
> 
> There is a self-reference cycle like
> 
>   listener -> embryo.oob_skb -> listener
> 
> , so this must be cleaned up by GC.  Otherwise, the listener's
> refcnt is not released and sockets are leaked:
> 
>   # unshare -n
>   # cat /proc/net/protocols | grep UNIX-STREAM
>   UNIX-STREAM 1024      0      -1   NI       0   yes  kernel ...
> 
>   # python3
>   >>> from array import array
>   >>> from socket import *
>   >>>
>   >>> s = socket(AF_UNIX, SOCK_STREAM)
>   >>> s.bind('\0test\0')
>   >>> s.listen()
>   >>>
>   >>> c = socket(AF_UNIX, SOCK_STREAM)
>   >>> c.connect(s.getsockname())
>   >>> c.sendmsg([b'x'], [(SOL_SOCKET, SCM_RIGHTS, array('i', [s.fileno()]))], MSG_OOB)
>   1
>   >>> quit()
> 
>   # cat /proc/net/protocols | grep UNIX-STREAM
>   UNIX-STREAM 1024      3      -1   NI       0   yes  kernel ...
>                         ^^^
>                         3 sockets still in use after FDs are close()d
> 
> Let's drop the embryo socket's oob_skb ref in scan_inflight().
> 
> This also fixes a racy access to oob_skb that commit 9841991a446c
> ("af_unix: Update unix_sk(sk)->oob_skb under sk_receive_queue
> lock.") fixed for the new Tarjan's algo-based GC.
> 
> Fixes: 314001f0bf92 ("af_unix: Add OOB support")
> Reported-by: Lei Lu <llfamsec@gmail.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
> This has no upstream commit because I replaced the entire GC in
> 6.10 and the new GC does not have this bug, and this fix is only
> applicable to the old GC (<= 6.9), thus for 5.15/6.1/6.6.

You need to get the networking maintainers to review and agree that this
is ok for us to take, as we really don't want to take "custom" stuff
like thi s at all.  Why not just take the commits that are in newer
kernels instead?

thanks,

greg k-h

