Return-Path: <stable+bounces-247653-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPF0Dhb9BmoeqgIAu9opvQ
	(envelope-from <stable+bounces-247653-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:01:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA11954DF63
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2467E3108BCA
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A2B3A453E;
	Fri, 15 May 2026 10:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="ilzXHJ0J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hD/fiOA/"
X-Original-To: stable@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B2038D3FD
	for <stable@vger.kernel.org>; Fri, 15 May 2026 10:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778841094; cv=none; b=I9le5FEQRI3NEV6ErweT/pYqBfUZT84hhnBhOQB5/RTM7mJJhWtycl8aJmj52vXE3VcBJIAuAhhhYUcqGlG0FPdkr8JAS/Hzk6c9LUznRGQsMygb/MKdQriTpJ4kox7NrlTcQzeZ677oq+Og50fBntCOH9q0yHx+J8H8oOPU2WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778841094; c=relaxed/simple;
	bh=W62WbtKJMcbTz+ogIs4HZOiX2AoiZnBxGcygCqFmw9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ML6oi3WxZIKgVNpHbRNwzTJodju5fRbFyURqWQHyNfzuxu47CPDhGg4bkvdr+0e2VzxF7a6vpoaAscDv9j+zt93J5CFHEVwKm/6KamrgZyuyjMciz1NZiEnvt6XRI+0L01esYS9B8gfsAqCe5qLBwxbpT9O3Vlw+WFajN6BLYNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=ilzXHJ0J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hD/fiOA/; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 01F31EC0016;
	Fri, 15 May 2026 06:31:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 15 May 2026 06:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1778841091; x=1778927491; bh=bPm7vNrige
	HBB2lGTwbbKFs/b63QPPbr+rJNM4YF1CQ=; b=ilzXHJ0JEaN+VtKHVJZC/Ywt0x
	okx3snydBP0+L3H/N6bLA9dvb807JUAZNYCNupLcEA6mBTYvidXSTnw8GLkGi40+
	SUsA0K+2DMR9ZRuI9nEPuB407CL2UmNGxKeEZabPTN8B5a69+OtDyLCKl/+CGpDi
	zcb7mo+nhVxxcrcKeybC00dK13A5dPDvewP0YJ42/Nysmhp5+n/x+9a0iISLBMzP
	VsTmdxtFcEGnoxP/0XuzSt7GWSYI7MOlAH/5BIWhWw+zATvE0QL0qTzEzWw7+eHG
	bwGpEt3gsi1bf+mDyqOqhUSbjRf6kv6XJNO7S1uyk8/xsrwuluxVIbPHU2gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778841091; x=1778927491; bh=bPm7vNrigeHBB2lGTwbbKFs/b63QPPbr+rJ
	NM4YF1CQ=; b=hD/fiOA/gpxUOGxLw4GUvQeWdSW/PXIE3LIbGcTvVb7g0guNi6q
	rEVVbi3QLCp680Nz8jRJUdUzG7hlI7kXyzhpXAcA0DBgsMiFN2FhYsFuMQYz4eZ3
	CCk1lbWvthzdc1TPjbJh4aGznhgkRLpINAKoYAhj8/uIgRolzlN/WI9XDeGL/Csx
	lYGECetYRRSL7P3YCQJM1SioAfO2c/pq+q+PKNYiUxk8DCZN+8z2/60Yj80hgfwS
	9ba/aNNZnIWIsBYmNag/qxuHodnHVU++wcC3E/QEVvkN6MLFrHHX8Ofu5HuWf61k
	zRLpl6uV+FWuZSs6lPV6nEp0BnOwxLxEbFw==
X-ME-Sender: <xms:A_YGahMI4us_l_LMqjMUfHT5FiVQVNqowm1a_VjsEbmeDLmVHOzOYw>
    <xme:A_YGanCDd57DUnj7Chj-n5jkd2K5cOClSlUwd-9M1U10nmv632ak6zwrPxbVwX7Od
    BWM1qTBYDG0qwTsZMV-N3pKtN_qcKhNhepe_s1OcGqnyxl8>
X-ME-Received: <xmr:A_YGaq5uV4DBq8k4CEZBxSuPO9wHKMqlasywLeY4EKTOiSqZ-SBRzeiZ-OE3Ryp7jbUGmv4F3Wbc0HyGxRnCm9OL6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufedtudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvdevvd
    eljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrd
    gtohhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshgrshhhrghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgrsghlvgesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhgrrhhshigrmhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehlihhnkhhinhhjvghonheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepshhtfhhrvghntghhsehmihgtrhhoshhofhhtrdgtohhm
X-ME-Proxy: <xmx:A_YGap7rFPil8K2lsgDkRcUQhb1hLmFZDMNJR9LST-ThtaKQmwra4g>
    <xmx:A_YGakSvADp3cGSokwMlNc5fhkQvH6SZ2AfnE6XrMlNxffZBtwQT1g>
    <xmx:A_YGap_I45xANPseLnwAn05gbJWdcHjFbmqQFoU8FtDE-KPcOxUMJA>
    <xmx:A_YGatYHStFCLctGJfaQ-BCgtH3RtTzBwaeVAysyqLBtqN60gmbETw>
    <xmx:A_YGamdt5XwX1dpUkqptiROjUgm-6IX8f3XqwVwfDURJwYmPl14-4ODx>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 May 2026 06:31:31 -0400 (EDT)
Date: Fri, 15 May 2026 12:31:37 +0200
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, DaeMyung Kang <charsyam@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: Re: [PATCH 6.6.y] ksmbd: rewrite stop_sessions() with restartable
 iteration
Message-ID: <2026051531-decathlon-trance-8b3c@gregkh>
References: <2026050720-idealist-crayon-e443@gregkh>
 <20260510200017.599429-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510200017.599429-1-sashal@kernel.org>
X-Rspamd-Queue-Id: BA11954DF63
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kroah.com,none];
	R_DKIM_ALLOW(-0.20)[kroah.com:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247653-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,microsoft.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kroah.com:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greg@kroah.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Action: no action

On Sun, May 10, 2026 at 04:00:16PM -0400, Sasha Levin wrote:
> From: DaeMyung Kang <charsyam@gmail.com>
> 
> [ Upstream commit c444139cb747bf6de1922b39900fdf02281490f4 ]
> 
> stop_sessions() walks conn_list with hash_for_each() and, for every
> entry, drops conn_list_lock across the transport ->shutdown() call
> before re-acquiring the read lock to continue the loop.  The hash
> walk relies on cross-iteration state (the current bucket and the
> hlist position), which is not preserved across unlock/relock: if
> another thread performs a list mutation during the unlocked window,
> the ongoing iteration becomes unreliable and can re-visit
> connections that have already been handled or skip connections that
> have not.  The outer `if (!hash_empty(conn_list)) goto again;` retry
> masks the symptom in the common case but does not address the
> unsafe iteration itself.
> 
> Reframe the loop so it never relies on iterator state across
> unlock/relock.  Under conn_list_lock held for read, pick the first
> connection whose ->shutdown() has not yet been issued by this path,
> pin it by taking an extra reference, record that fact on the
> connection and mark it EXITING while still inside the locked walk,
> then drop the lock.  Then call ->shutdown() outside the lock, drop
> the pin (freeing the connection if the handler already released its
> reference), and restart from the top.
> 
> Use a new per-connection flag, conn->stop_called, as the "shutdown
> issued from stop_sessions()" marker rather than reusing the status
> state.  ksmbd_conn_set_exiting() is also invoked by
> ksmbd_sessions_deregister() on sibling channels of a multichannel
> session without issuing a transport shutdown, so treating
> KSMBD_SESS_EXITING as "already handled here" would skip connections
> that still need shutdown() to wake their handler out of recv(),
> leaving the outer retry waiting indefinitely for the hash to drain.
> stop_sessions() is serialised by init_lock in
> ksmbd_conn_transport_destroy(), so writing stop_called under the
> read lock has no other writer.
> 
> Set EXITING inside the locked walk so the selection, the stop_called
> marker, and the status transition all happen together, and guard
> against regressing a connection that has already advanced to
> KSMBD_SESS_RELEASING on its own (for example, if the handler exited
> its receive loop for an unrelated reason between teardown steps).
> 
> When the pin drop is the last put, release the transport and pair
> ida_destroy(&target->async_ida) with the ida_init() done in
> ksmbd_conn_alloc(), so stop_sessions() retiring a connection on its
> own does not leak the xarray backing of the embedded async_ida.
> 
> The outer retry with msleep() is kept to wait for handler threads to
> reach ksmbd_conn_free() and drain the hash.
> 
> Observed with an instrumented build that logs one line per visit and
> widens the unlocked window before ->shutdown() by 200 ms, under
> five concurrent cifs mounts (nosharesock, one connection each):
> 
>   * Current code: the same connection address is revisited many
>     times during a single stop_sessions() call and ->shutdown() is
>     invoked well beyond the number of live connections before the
>     hash finally drains.
> 
>   * Rewritten code: each live connection produces exactly one
>     ->shutdown() call; the function returns as soon as the hash is
>     empty.
> 
> Functional teardown via `ksmbd.control --shutdown` with the same
> five mounts completes cleanly on the rewritten path.
> 
> Performance is observably unchanged.  Tearing down N concurrent
> nosharesock cifs connections with `ksmbd.control --shutdown` +
> `rmmod ksmbd` takes essentially the same wall time before and after
> the rewrite:
> 
>     N        before        after
>     10       4.93s         5.34s
>     30       7.34s         7.03s
>     50       7.31s         7.01s     (3-run avg: 7.04s vs 7.25s)
>    100       6.98s         6.78s
>    200       6.77s         6.89s
> 
> and the number of ->shutdown() calls equals the number of live
> connections on both paths when the race is not widened.  The
> teardown is dominated by the msleep(100)-based outer retry waiting
> for handler threads to run ksmbd_conn_free(), not by the iteration
> itself; the restartable loop's worst-case O(N^2) visit cost is in
> the microseconds even at N=200 and sits far below the msleep(100)
> granularity.
> 
> Applied alone on top of ksmbd-for-next-next, this patch does not
> introduce a new leak site.  Under the same reproducer (10x
> concurrent-holders + ss -K + ksmbd.control --shutdown + rmmod), the
> tree still shows the pre-existing per-connection transport leak
> count that arises when the last refcount drop lands in one of
> ksmbd_conn_r_count_dec(), __free_opinfo() or session_fd_check() -
> all of which end with a bare kfree() today.  kmemleak backtraces
> for the unreferenced objects point into the TCP accept path
> (sk_clone -> inet_csk_clone_lock, sock_alloc_inode) and none
> involve stop_sessions().  Plugging those bare-kfree sites is the
> responsibility of the follow-up patch.
> 
> Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
> Cc: stable@vger.kernel.org
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
> Acked-by: Namjae Jeon <linkinjeon@kernel.org>
> Signed-off-by: Steve French <stfrench@microsoft.com>
> [ kept list_for_each_entry iteration and schedule_timeout_interruptible(HZ/10) ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/smb/server/connection.c | 46 +++++++++++++++++++++++++++++++-------
>  fs/smb/server/connection.h |  1 +
>  2 files changed, 39 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
> index 907ddfc2c2c1d..51e7e7042fb05 100644
> --- a/fs/smb/server/connection.c
> +++ b/fs/smb/server/connection.c
> @@ -478,23 +478,53 @@ int ksmbd_conn_transport_init(void)
>  
>  static void stop_sessions(void)
>  {
> -	struct ksmbd_conn *conn;
> +	struct ksmbd_conn *conn, *target;
>  	struct ksmbd_transport *t;
> +	bool any;
>  
> +	/*
> +	 * Serialised via init_lock; no concurrent stop_sessions() can
> +	 * touch conn->stop_called, so writing it under the read lock is
> +	 * safe.
> +	 */
>  again:
> +	target = NULL;
> +	any = false;
>  	down_read(&conn_list_lock);
>  	list_for_each_entry(conn, &conn_list, conns_list) {
> -		t = conn->transport;
> -		ksmbd_conn_set_exiting(conn);
> -		if (t->ops->shutdown) {
> -			up_read(&conn_list_lock);
> +		any = true;
> +		if (conn->stop_called)
> +			continue;
> +		atomic_inc(&conn->refcnt);
> +		conn->stop_called = true;
> +		/*
> +		 * Mark the connection EXITING while still holding the
> +		 * read lock so the selection and the status transition
> +		 * happen together.  Do not regress a connection that has
> +		 * already advanced to RELEASING on its own (e.g. the
> +		 * handler exited its receive loop for an unrelated
> +		 * reason).
> +		 */
> +		if (READ_ONCE(conn->status) != KSMBD_SESS_RELEASING)
> +			ksmbd_conn_set_exiting(conn);
> +		target = conn;
> +		break;
> +	}
> +	up_read(&conn_list_lock);
> +
> +	if (target) {
> +		t = target->transport;
> +		if (t->ops->shutdown)
>  			t->ops->shutdown(t);
> -			down_read(&conn_list_lock);
> +		if (atomic_dec_and_test(&target->refcnt)) {
> +			ida_destroy(&target->async_ida);
> +			t->ops->free_transport(t);
> +			kfree(target);
>  		}
> +		goto again;
>  	}
> -	up_read(&conn_list_lock);
>  
> -	if (!list_empty(&conn_list)) {
> +	if (any) {
>  		schedule_timeout_interruptible(HZ / 10); /* 100ms */
>  		goto again;
>  	}
> diff --git a/fs/smb/server/connection.h b/fs/smb/server/connection.h
> index 45421269ddd88..e196f723358ef 100644
> --- a/fs/smb/server/connection.h
> +++ b/fs/smb/server/connection.h
> @@ -46,6 +46,7 @@ struct ksmbd_conn {
>  	struct mutex			srv_mutex;
>  	int				status;
>  	unsigned int			cli_cap;
> +	bool				stop_called;
>  	union {
>  		__be32			inet_addr;
>  #if IS_ENABLED(CONFIG_IPV6)
> -- 
> 2.53.0
> 
> 

Does not apply :(

