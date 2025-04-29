Return-Path: <stable+bounces-137055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AFAAA0958
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 13:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D69901B64031
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 11:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA522C178C;
	Tue, 29 Apr 2025 11:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glx0RWkF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFD22BEC43;
	Tue, 29 Apr 2025 11:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745925173; cv=none; b=uaDDYT7D7Ngxh6tT7C096wht++rrOrcbKFbYvgsqSG25V9D5BtRWYxX3HqRZbjmdwT3DNsADut96X7uHQuQfplEBtWBpuNZJaWctER+BjJtq9sAG7VGB1GYSKEc9XniykeLIvaKQs5Pk5oKXr3bLaezcUbLtSLMR/8x0vYziwTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745925173; c=relaxed/simple;
	bh=gbagDXiDhv29hsU2kJSrNOrvcjmmOaIpBSD1tfhYSfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlmXLHTUyykQSsNTyfHTEbPYf6wMEdtojZmbaqBDIhOsBQh/E1+J0KCBpiN0XlMhMzLgFD2AvVN79w4zSILZ13O0XekTUdqXBaXXFwKQArN//CyK7HVkVpvBzcjzpiXjkLmyMovg9PUjUAceU6Pe+mTV5xarVgoZuzbpfQNHnGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glx0RWkF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077BAC4CEE3;
	Tue, 29 Apr 2025 11:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745925173;
	bh=gbagDXiDhv29hsU2kJSrNOrvcjmmOaIpBSD1tfhYSfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=glx0RWkFdw8QmEXfShT9CWGf1cd1q7pZAJUFQ+ImP3wrE23G0ULD6CBq3yNlVAS+R
	 /VfzVoJkMv3QwR7l0RYcfS7lDgpByDN28v4icV8yP7Gtu2pIPa1FB5NtLIuf+q0C1t
	 7thN3e1s4RMwbE9Eoi+V67c5Xt7HGMzEnyBKNm+uyX1Ln6X16+LsEF6m40vLztx5c+
	 X1gdLkAqHzvIz3OCuZjlNHRmA4/nxhy4RxRyAN7fBUhzTV63Km9Rkp1irn4wj8TYZG
	 5suIn3V2zOYoujReEFv5IfJ+KF5f37l1yOIv/cBc2GZ6ml0VubpMOfs5m7c7EeXhPn
	 HHWWlsW/C/kvA==
Date: Tue, 29 Apr 2025 12:12:49 +0100
From: Lee Jones <lee@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, stable@vger.kernel.org,
	netdev@vger.kernel.org, Lei Lu <llfamsec@gmail.com>
Subject: Re: [PATCH stable 5.15/6.1/6.6] af_unix: Clear oob_skb in
 scan_inflight().
Message-ID: <20250429111249.GA2619229@google.com>
References: <20250304030149.82265-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250304030149.82265-1-kuniyu@amazon.com>

On Mon, 03 Mar 2025, Kuniyuki Iwashima wrote:

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
> ---
> ---
>  net/unix/garbage.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Tested-by: Lee Jones <lee@kernel.org>

> diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> index 2a758531e102..b3fbdf129944 100644
> --- a/net/unix/garbage.c
> +++ b/net/unix/garbage.c
> @@ -102,13 +102,14 @@ static void scan_inflight(struct sock *x, void (*func)(struct unix_sock *),
>  			/* Process the descriptors of this socket */
>  			int nfd = UNIXCB(skb).fp->count;
>  			struct file **fp = UNIXCB(skb).fp->fp;
> +			struct unix_sock *u;
>  
>  			while (nfd--) {
>  				/* Get the socket the fd matches if it indeed does so */
>  				struct sock *sk = unix_get_socket(*fp++);
>  
>  				if (sk) {
> -					struct unix_sock *u = unix_sk(sk);
> +					u = unix_sk(sk);
>  
>  					/* Ignore non-candidates, they could
>  					 * have been added to the queues after
> @@ -122,6 +123,13 @@ static void scan_inflight(struct sock *x, void (*func)(struct unix_sock *),
>  				}
>  			}
>  			if (hit && hitlist != NULL) {
> +#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
> +				u = unix_sk(x);
> +				if (u->oob_skb) {
> +					WARN_ON_ONCE(skb_unref(u->oob_skb));
> +					u->oob_skb = NULL;
> +				}
> +#endif
>  				__skb_unlink(skb, &x->sk_receive_queue);
>  				__skb_queue_tail(hitlist, skb);
>  			}
> @@ -299,17 +307,9 @@ void unix_gc(void)
>  	 * which are creating the cycle(s).
>  	 */
>  	skb_queue_head_init(&hitlist);
> -	list_for_each_entry(u, &gc_candidates, link) {
> +	list_for_each_entry(u, &gc_candidates, link)
>  		scan_children(&u->sk, inc_inflight, &hitlist);
>  
> -#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
> -		if (u->oob_skb) {
> -			kfree_skb(u->oob_skb);
> -			u->oob_skb = NULL;
> -		}
> -#endif
> -	}
> -
>  	/* not_cycle_list contains those sockets which do not make up a
>  	 * cycle.  Restore these to the inflight list.
>  	 */
> -- 
> 2.39.5 (Apple Git-154)
> 

-- 
Lee Jones [李琼斯]

