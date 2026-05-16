Return-Path: <stable+bounces-249008-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEImFUKQCGptvQMAu9opvQ
	(envelope-from <stable+bounces-249008-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 17:41:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC66C55C77C
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 17:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2182F3010C31
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 15:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2603E51E2;
	Sat, 16 May 2026 15:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxo2P6ul"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E9A3E51D6
	for <stable@vger.kernel.org>; Sat, 16 May 2026 15:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778946108; cv=pass; b=uCv0vmitCIizzzzeLwB4nX7p61oMyWbBYCbNKjPdLgXqZiGPIWJOBaXn+2Cpdgk12m3lMA84RVoz/6n0EfFlbscREAPJyHiVvna1JhrXKOYCjFjpg9juGxFJTr3NNnFsCEB46fv/gKQ6DI0eE34w2YB3i9KFU3OmNHyurBp8dkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778946108; c=relaxed/simple;
	bh=nogOJo2XqKMVMCFKDKfeIPGj9WZ0MSrszzSuD/Lz+WE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NnRy+oTRF+LHo2+hygxy5XQZOvJEuTJ3LEYe9fibDorJuPP/Lsn5CKjaT3h5Qh1LActa6zGmWZKdf4UROWQzjrrUw8M2u8TT2pLYle+WULnMN0Qj6+jjiu8qWCzZkvADvqWJ/1/nmKh9XIJgrAb9+YCihGJGbvi7LrxG9jdrUxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pxo2P6ul; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-65d8c6e78f0so79111d50.3
        for <stable@vger.kernel.org>; Sat, 16 May 2026 08:41:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778946104; cv=none;
        d=google.com; s=arc-20240605;
        b=gkqlG64eMoA7kJNap37yZcCZ8DJAnu1uxB1mEPff+xntnMraFMaf2QeMgd7zDgh6TZ
         M0X2yL2WutUaudzWoTAGrY4yEKt2rDbYf2akf2zylBVBH2wNXljANLDKmva3YZW8bHdQ
         aNtcUFGgtvjwrgYUeyHLn0OOXp1Tf0LULRX2UcEbEnmvJsvMejoGLU745qBuwfg48Lfy
         OPY9RojN4Y0iJAgKmXhou2a8FUusVzkSLVKGIPreWz292w1vfMxuwZWmcjzDmkIeSVc5
         PANFr45dEVFtgSEXRp0PxHtkmMAp1WmCOC2hEN9J4abXMQVikW/9Ql8SCP8/bKdOZpLw
         wr4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yn0kZZTY7yJemtX4gdL+49yS28i7OmKYEjG5wisL5Lo=;
        fh=AoJ6cWGAzNBfMLDqeSYPFE3Hdn5SE1vWjjmJ0gSveYg=;
        b=L2HN9QFj4IFg5Yu87E4JLwr1oCREKzFZebEgSBM/lBzYkIXBAeoVcupt2FIxW+WYn1
         4N0WwvsWhlk4EcjVM7ifRPjfmgITBX2DqdrHG9bqaYWjj5WQYDIZMQGpFYShDwVyPwIJ
         ob8Dx8WlHH/wyCmO1uRKmYUo2qdAbYZRND3K5EIKvyECdyVG/1LdbkwxJN7Pxd7OUNK7
         BlljNAeCAb/eShqUNRig2zlHyBtolebkff1KSQtACYTisRM0lsKCitaB1zgkqkpe1WH4
         rElvMKDaZaUSqffTFP+4d8CaguU5vkrDacQ35UwgTXPEOEm7J6nQJsVLXc73ruJLJagJ
         a1vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778946104; x=1779550904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yn0kZZTY7yJemtX4gdL+49yS28i7OmKYEjG5wisL5Lo=;
        b=pxo2P6ulC/u0bZ6brD22aCB6CFBPqGOCaFtftjnboo/h0FDpB9RvhPVCMq6pBxZCMq
         r45F8GHfYsOpNH/eDtAp4ebbdm+2TrhUJiegTtTpBXU9+V9FtA56nYMcKFLu0H00/PXU
         7qYIqwHGzYZClGKgYa3jBBBy2mDjhSyk8Kjp/Okp/cxoZ6V1e5lJ5nRzu0gT3ubzvvMh
         SIOBzHY0mEjryZ8rDnh6XIaTzPWgYvrnn2RtbOd+0BcNxyzZa4eKJoXIhl9jbiosmQB6
         r8EJ/IPDdFz10/LIiv+RaLX1QKDHvbyGXoQ4GhqE1Q16utECpn/ppavD+zmE8G6RjBwv
         eYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778946104; x=1779550904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yn0kZZTY7yJemtX4gdL+49yS28i7OmKYEjG5wisL5Lo=;
        b=TcJVZcu2th+55+e7P8sm4MmtFktj32uY4itPEtvuHsrW8VcYdL4Hoxhqv4ae4muALF
         5juGFscYBcJ9zm1JJdkqwRlanJdTG2dJI4nKqFea6UbM3Mvs7132+FQ7PkwLH4HFCUXe
         N/tkIPDzx52Jx9+dmrhzgtbBEu/t0vwcKd+cyo+2KvcVzJt0Go9CdTm726MdsiTdFUQ6
         0UVDvj5xs9Pz9GfNU/0dezJG3j3I0WU1eJ3aYse7kier5uwBhhlFQmUO5ocHwQgNCI8X
         zODZwTBS9yRbTsPG4w2EZE/ywI2Gnkb2fBE2SlHkuTWHtpDhw+udRJpa04Ku3pgfoxyO
         PFXQ==
X-Forwarded-Encrypted: i=1; AFNElJ/yoi7puDxBjdajUJRFiSSOnnem3OFluVAemhh6LDKnrqXnEJo7bJmPhB23aWR1k4DIWqtJaAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLFhWCEjGeLCMQxmtmTZaIMEgj6+oBS8ZNrP8k8Z72Olmk4wEP
	MXhPpEDQk9J8AyujRiMZyOUiii2Fx92BV3mXAvQHnawIoneybrnbZP0Lr7FlRDJlmPrGVuzfdvX
	3Fmx2YqkOCuW8WOM6Jv/aMdCsLcgCbUsbmk5D
X-Gm-Gg: Acq92OEjNOPspHUri5v2iGpp8MKmXVbbl+nYk31G2BwNuuO9VcPqy1+vr1YQzinAB3r
	g2lcBNnea2rweEQ7vgdPCTt9kolcgWE7bTSkzRM6VeU7jHOaapLKMD5dtpvzsxsm1QPl/yZf6Oq
	Cxem3MMfjEKDRtjlXweXojlp1LqeVwdIsITpDJF4YyKqzXdLSxqP/1Awr0fQeQ4dIpDHbYF1HVu
	jzcip1JUH1QXkxzLiE6ymMSznHeXqZkxFduz69vqTN130Ojw29lAWDFOOf+KUtDW2rktQfGQYSw
	JLi1whLq
X-Received: by 2002:a05:690e:169a:b0:650:20d6:7098 with SMTP id
 956f58d0204a3-65e227ec79fmr5563379d50.4.1778946104346; Sat, 16 May 2026
 08:41:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026050720-idealist-crayon-e443@gregkh> <20260510200017.599429-1-sashal@kernel.org>
 <2026051531-decathlon-trance-8b3c@gregkh>
In-Reply-To: <2026051531-decathlon-trance-8b3c@gregkh>
From: CharSyam <charsyam@gmail.com>
Date: Sun, 17 May 2026 00:41:33 +0900
X-Gm-Features: AVHnY4I3JIVDw-U94XcB3UpIcjlC88yS3oCpdev8NCnmp07yzGtetoaLagZZdz4
Message-ID: <CAMrLSE4+ok3FRgPz5ph9MViQcFOq8xecmsq9qSE9oj0E21FnXA@mail.gmail.com>
Subject: Re: [PATCH 6.6.y] ksmbd: rewrite stop_sessions() with restartable iteration
To: Greg KH <greg@kroah.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org, 
	Namjae Jeon <linkinjeon@kernel.org>, Steve French <stfrench@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: AC66C55C77C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249008-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charsyam@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kroah.com:email]
X-Rspamd-Action: no action

Hi Greg, Sasha

The AUTOSEL backport no longer matches the current 6.6.y queue because
the queue already contains the two commits that c444139cb747 is based on
in mainline:

    f75f8bdd4ff4 ("ksmbd: use msleep instaed of
                   schedule_timeout_interruptible()")
    0bcc831be535 ("ksmbd: replace connection list with hash table")

In the queue I checked, these are queue-6.6/series entries 367 and 368.

With those two patches applied, 6.6.y stop_sessions() matches the
upstream preimage of c444139cb747, so no list-based backport adaptation
is needed anymore. I verified that git am of the unmodified upstream
patch for c444139cb747 on top of v6.6.139 plus those two queued patches
applies cleanly.

So the list-adapted AUTOSEL version can be dropped. Please queue
upstream commit c444139cb747 for 6.6.y after 0bcc831be535 instead.

Thanks,
DaeMyung

2026=EB=85=84 5=EC=9B=94 15=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 7:31, G=
reg KH <greg@kroah.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Sun, May 10, 2026 at 04:00:16PM -0400, Sasha Levin wrote:
> > From: DaeMyung Kang <charsyam@gmail.com>
> >
> > [ Upstream commit c444139cb747bf6de1922b39900fdf02281490f4 ]
> >
> > stop_sessions() walks conn_list with hash_for_each() and, for every
> > entry, drops conn_list_lock across the transport ->shutdown() call
> > before re-acquiring the read lock to continue the loop.  The hash
> > walk relies on cross-iteration state (the current bucket and the
> > hlist position), which is not preserved across unlock/relock: if
> > another thread performs a list mutation during the unlocked window,
> > the ongoing iteration becomes unreliable and can re-visit
> > connections that have already been handled or skip connections that
> > have not.  The outer `if (!hash_empty(conn_list)) goto again;` retry
> > masks the symptom in the common case but does not address the
> > unsafe iteration itself.
> >
> > Reframe the loop so it never relies on iterator state across
> > unlock/relock.  Under conn_list_lock held for read, pick the first
> > connection whose ->shutdown() has not yet been issued by this path,
> > pin it by taking an extra reference, record that fact on the
> > connection and mark it EXITING while still inside the locked walk,
> > then drop the lock.  Then call ->shutdown() outside the lock, drop
> > the pin (freeing the connection if the handler already released its
> > reference), and restart from the top.
> >
> > Use a new per-connection flag, conn->stop_called, as the "shutdown
> > issued from stop_sessions()" marker rather than reusing the status
> > state.  ksmbd_conn_set_exiting() is also invoked by
> > ksmbd_sessions_deregister() on sibling channels of a multichannel
> > session without issuing a transport shutdown, so treating
> > KSMBD_SESS_EXITING as "already handled here" would skip connections
> > that still need shutdown() to wake their handler out of recv(),
> > leaving the outer retry waiting indefinitely for the hash to drain.
> > stop_sessions() is serialised by init_lock in
> > ksmbd_conn_transport_destroy(), so writing stop_called under the
> > read lock has no other writer.
> >
> > Set EXITING inside the locked walk so the selection, the stop_called
> > marker, and the status transition all happen together, and guard
> > against regressing a connection that has already advanced to
> > KSMBD_SESS_RELEASING on its own (for example, if the handler exited
> > its receive loop for an unrelated reason between teardown steps).
> >
> > When the pin drop is the last put, release the transport and pair
> > ida_destroy(&target->async_ida) with the ida_init() done in
> > ksmbd_conn_alloc(), so stop_sessions() retiring a connection on its
> > own does not leak the xarray backing of the embedded async_ida.
> >
> > The outer retry with msleep() is kept to wait for handler threads to
> > reach ksmbd_conn_free() and drain the hash.
> >
> > Observed with an instrumented build that logs one line per visit and
> > widens the unlocked window before ->shutdown() by 200 ms, under
> > five concurrent cifs mounts (nosharesock, one connection each):
> >
> >   * Current code: the same connection address is revisited many
> >     times during a single stop_sessions() call and ->shutdown() is
> >     invoked well beyond the number of live connections before the
> >     hash finally drains.
> >
> >   * Rewritten code: each live connection produces exactly one
> >     ->shutdown() call; the function returns as soon as the hash is
> >     empty.
> >
> > Functional teardown via `ksmbd.control --shutdown` with the same
> > five mounts completes cleanly on the rewritten path.
> >
> > Performance is observably unchanged.  Tearing down N concurrent
> > nosharesock cifs connections with `ksmbd.control --shutdown` +
> > `rmmod ksmbd` takes essentially the same wall time before and after
> > the rewrite:
> >
> >     N        before        after
> >     10       4.93s         5.34s
> >     30       7.34s         7.03s
> >     50       7.31s         7.01s     (3-run avg: 7.04s vs 7.25s)
> >    100       6.98s         6.78s
> >    200       6.77s         6.89s
> >
> > and the number of ->shutdown() calls equals the number of live
> > connections on both paths when the race is not widened.  The
> > teardown is dominated by the msleep(100)-based outer retry waiting
> > for handler threads to run ksmbd_conn_free(), not by the iteration
> > itself; the restartable loop's worst-case O(N^2) visit cost is in
> > the microseconds even at N=3D200 and sits far below the msleep(100)
> > granularity.
> >
> > Applied alone on top of ksmbd-for-next-next, this patch does not
> > introduce a new leak site.  Under the same reproducer (10x
> > concurrent-holders + ss -K + ksmbd.control --shutdown + rmmod), the
> > tree still shows the pre-existing per-connection transport leak
> > count that arises when the last refcount drop lands in one of
> > ksmbd_conn_r_count_dec(), __free_opinfo() or session_fd_check() -
> > all of which end with a bare kfree() today.  kmemleak backtraces
> > for the unreferenced objects point into the TCP accept path
> > (sk_clone -> inet_csk_clone_lock, sock_alloc_inode) and none
> > involve stop_sessions().  Plugging those bare-kfree sites is the
> > responsibility of the follow-up patch.
> >
> > Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
> > Acked-by: Namjae Jeon <linkinjeon@kernel.org>
> > Signed-off-by: Steve French <stfrench@microsoft.com>
> > [ kept list_for_each_entry iteration and schedule_timeout_interruptible=
(HZ/10) ]
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> >  fs/smb/server/connection.c | 46 +++++++++++++++++++++++++++++++-------
> >  fs/smb/server/connection.h |  1 +
> >  2 files changed, 39 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
> > index 907ddfc2c2c1d..51e7e7042fb05 100644
> > --- a/fs/smb/server/connection.c
> > +++ b/fs/smb/server/connection.c
> > @@ -478,23 +478,53 @@ int ksmbd_conn_transport_init(void)
> >
> >  static void stop_sessions(void)
> >  {
> > -     struct ksmbd_conn *conn;
> > +     struct ksmbd_conn *conn, *target;
> >       struct ksmbd_transport *t;
> > +     bool any;
> >
> > +     /*
> > +      * Serialised via init_lock; no concurrent stop_sessions() can
> > +      * touch conn->stop_called, so writing it under the read lock is
> > +      * safe.
> > +      */
> >  again:
> > +     target =3D NULL;
> > +     any =3D false;
> >       down_read(&conn_list_lock);
> >       list_for_each_entry(conn, &conn_list, conns_list) {
> > -             t =3D conn->transport;
> > -             ksmbd_conn_set_exiting(conn);
> > -             if (t->ops->shutdown) {
> > -                     up_read(&conn_list_lock);
> > +             any =3D true;
> > +             if (conn->stop_called)
> > +                     continue;
> > +             atomic_inc(&conn->refcnt);
> > +             conn->stop_called =3D true;
> > +             /*
> > +              * Mark the connection EXITING while still holding the
> > +              * read lock so the selection and the status transition
> > +              * happen together.  Do not regress a connection that has
> > +              * already advanced to RELEASING on its own (e.g. the
> > +              * handler exited its receive loop for an unrelated
> > +              * reason).
> > +              */
> > +             if (READ_ONCE(conn->status) !=3D KSMBD_SESS_RELEASING)
> > +                     ksmbd_conn_set_exiting(conn);
> > +             target =3D conn;
> > +             break;
> > +     }
> > +     up_read(&conn_list_lock);
> > +
> > +     if (target) {
> > +             t =3D target->transport;
> > +             if (t->ops->shutdown)
> >                       t->ops->shutdown(t);
> > -                     down_read(&conn_list_lock);
> > +             if (atomic_dec_and_test(&target->refcnt)) {
> > +                     ida_destroy(&target->async_ida);
> > +                     t->ops->free_transport(t);
> > +                     kfree(target);
> >               }
> > +             goto again;
> >       }
> > -     up_read(&conn_list_lock);
> >
> > -     if (!list_empty(&conn_list)) {
> > +     if (any) {
> >               schedule_timeout_interruptible(HZ / 10); /* 100ms */
> >               goto again;
> >       }
> > diff --git a/fs/smb/server/connection.h b/fs/smb/server/connection.h
> > index 45421269ddd88..e196f723358ef 100644
> > --- a/fs/smb/server/connection.h
> > +++ b/fs/smb/server/connection.h
> > @@ -46,6 +46,7 @@ struct ksmbd_conn {
> >       struct mutex                    srv_mutex;
> >       int                             status;
> >       unsigned int                    cli_cap;
> > +     bool                            stop_called;
> >       union {
> >               __be32                  inet_addr;
> >  #if IS_ENABLED(CONFIG_IPV6)
> > --
> > 2.53.0
> >
> >
>
> Does not apply :(

