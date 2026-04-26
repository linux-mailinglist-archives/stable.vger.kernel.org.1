Return-Path: <stable+bounces-241198-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDMuJuOd7mk2wAAAu9opvQ
	(envelope-from <stable+bounces-241198-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 01:21:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5BB46B76B
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 01:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EF2E030028C5
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 23:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951652C0268;
	Sun, 26 Apr 2026 23:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dojPkt8C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5754C31354C
	for <stable@vger.kernel.org>; Sun, 26 Apr 2026 23:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777245641; cv=none; b=TcCQzQrmn280p8Jgk6PLfCmN8DnTrtrnBmFe3XKnbtTZ+pO0pW48g023e9kILiITg26odTzlLTdrZC2cjQFNbBYLYhNzFL9L9ZDpDca0rN2sI3wW/yEFKwxs4JNkgQ5PnP1UWuNX7W2E1mlwsdZTXWstsOE1IMkJpMDFxWRR57Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777245641; c=relaxed/simple;
	bh=nvGVeBtfYsUcgVw17JBTnGRVww7D39S5R1eek3HADJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q/+JdBZ+tNA6a198rHHql9YuWvQhTWgdaggSMY7Sp5KpytqAiUBYMeFNpaL41wBwYHYos08YLaRNETzC+c9ijCs42Agio65Mr+0sX72/CS2HRceH5tfkrywO+61YVgA8Q6trMumD2uzuKFcxDBreuiN++S4xEPhGCyq0B5DHlwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dojPkt8C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313DAC2BCC7
	for <stable@vger.kernel.org>; Sun, 26 Apr 2026 23:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777245641;
	bh=nvGVeBtfYsUcgVw17JBTnGRVww7D39S5R1eek3HADJ8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dojPkt8CccGGCftE76eUDF5rtRdW/sXPJ9GxN6mYTcJWGPWM2ShT0o/v5vzQu2G1r
	 Xk4Y6z/esheZirjq152283SSiJGeyp39vubIWfCVl3iR3EwkLGok8y4jhsZPgCHrP8
	 ZxiK6bxjbGEIpQgjcFvA//I3lz0kYRFoQQMuRJAsKomQtxQytOW9wOy572c88Yk1oV
	 wyfIQfy4+84sRZiS7xXl896cBYtSbwwslNL146olbwNlxkkaZ9MMih3d5TVX1JYeNJ
	 CNDQFoj0mPqo3gCynVX2Ds0XFOV/nmynsF8Zl0+7KETnKKvRTi1C5DF0pdkthiyWV2
	 0dy3pJxOMW1yw==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so1302108666b.2
        for <stable@vger.kernel.org>; Sun, 26 Apr 2026 16:20:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9K3bbk8xSE6Sapabvd4gYlHZ5cZKDrLkOd8tS8U0TSTLINAf8ZrRMv10vFYcKKXm/+FuK+x9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTI4uQVTYABE07N95CtlNGuJQgFFLjt4uaM+rfp7VgHQZR/+aH
	qsTwZ3hosch1rlvfCYzs4Qf5/M2pqNeFqoiMHe+qx3OHjSsUzNOFLPkLg+cZIUNQ96QSKRT2GOZ
	JSOF53c4i/kMcP5RVLTdsKBpI0c80Khs=
X-Received: by 2002:a17:907:9349:b0:ba9:aeaa:fd01 with SMTP id
 a640c23a62f3a-ba9aeab051cmr1285294366b.43.1777245639618; Sun, 26 Apr 2026
 16:20:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260425093829.4004785-1-charsyam@gmail.com> <20260425093829.4004785-2-charsyam@gmail.com>
In-Reply-To: <20260425093829.4004785-2-charsyam@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 27 Apr 2026 08:20:27 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_oxKjy=j0BVZEz9+1Fy6KjqawONNkZYgR4hnJxfOsuDA@mail.gmail.com>
X-Gm-Features: AVHnY4Ixj8jolHA9kxXW5RMLvJ7mOQ0Qe2E80ooXjLu56fQkkSYnsrf2e3HvAFA
Message-ID: <CAKYAXd_oxKjy=j0BVZEz9+1Fy6KjqawONNkZYgR4hnJxfOsuDA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ksmbd: rewrite stop_sessions() with restartable iteration
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Steve French <smfrench@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Tom Talpey <tom@talpey.com>, Hyunchul Lee <hyc.lee@gmail.com>, 
	Ronnie Sahlberg <lsahlber@redhat.com>, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9F5BB46B76B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,chromium.org,talpey.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-241198-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Sat, Apr 25, 2026 at 6:38=E2=80=AFPM DaeMyung Kang <charsyam@gmail.com> =
wrote:
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
> the microseconds even at N=3D200 and sits far below the msleep(100)
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
Applied it to #ksmbd-for-next-next.
Thanks!

