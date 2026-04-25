Return-Path: <stable+bounces-241115-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HldCaSL7GmtZgAAu9opvQ
	(envelope-from <stable+bounces-241115-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 11:38:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29505465B89
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 11:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 24ABC3006205
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 09:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD44638B142;
	Sat, 25 Apr 2026 09:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+Rpb6eW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4640B3876AC
	for <stable@vger.kernel.org>; Sat, 25 Apr 2026 09:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777109917; cv=none; b=haD2oUi7IaEm7ibAe5pOnMbHJ+E+i2vtEdFY+EwLKnjgQRukziXCV4GZuj9ET8l3wpg3V+dbzQqqRX01VO7GBkme4Bxo4Xik+eaVQz/I++YcPa/FX2P40noIrxq1YVEfCa8tKQA5nYg4GslF3WXzUxXK2VC4eO3N8Tprw+aONak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777109917; c=relaxed/simple;
	bh=aNXbkmBeYe7bkZ0ITtRcL7RZi7xiKD8Vu5jVT74b7mY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fNp1Fy30nRQfWhn4HSSRyBigMu/soditd9WLYhmF5D+IzOlewkYU+PBJgZMwMKmMx+KJimgy19eZcuZHuGWdE0WL+ptNxaBbIzWYKfurxu0edFb0omb4Cljm7Y+/dx64VoculTLCnN5ZlqiTi5ydU6WX4BXAetwEmcFND8DXhmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n+Rpb6eW; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ae3a007bd1so8657745ad.2
        for <stable@vger.kernel.org>; Sat, 25 Apr 2026 02:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777109915; x=1777714715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mbVqeApfmb1SRG7yXWeR8Jma0vOyucMXXKmHaiUnCs8=;
        b=n+Rpb6eWA7oIiMaKqYi9Klmkhr+GVy2K6z0CAkncXStNozW1De3Ie7pTAPj8H1tpvt
         aFgIk3A6nbF8bnyzi4i7uPujmAeSESIWB80dW2fm7qqmy3GBdE1NxAbTk+5hFY2YYX6y
         KS4AHQwvM3iq80b01B0zjw3Cp/whCs7t2fUHGKQ//7b2mhQKYAI3qiLp5vE8JDCT27NE
         FtyiGIxmU8WZZa5wtGg/zocV82qfiVL7RTOco9rf4p/+OK2vwylSNSD65lZBzr0amsGr
         TnV6O4K3PdYnHCrRSuPpF8yJbU1lf0wB7dMAebxNTVsUxTgXnIwuxNa8BzZ+Ni2n5RYJ
         jsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777109915; x=1777714715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbVqeApfmb1SRG7yXWeR8Jma0vOyucMXXKmHaiUnCs8=;
        b=DeqLVtSGM1n3rSRiJe0DLarowoZM0q7E2UHHv86ZxYvCo8+zDh4q9/qqJEAuX5Cs6V
         ztEjZxNI4Ir3GA2TF2cUV4xI5Ekh4HrCVHW+2te7L8kMCD4l4I6RK8R662IAN08rTj5+
         aSpLibZeRT8Zf2sC3Fq4cfn/Gc3kYiHAiMz8H5VrU6gS9aZDQdnsvRewCe9CeUQO2g97
         P9xsIqqkiELxgp67IAumiW7a5KALJeP4H3PNmNqh6sfmZteIyGZFYIWJiMFCvimO1eRK
         pWu/gFbSveuxyb50ODd0C6Rc2trJIaWom5huYlZt2oQq7tf6hr95VduWAoc/4NxkgeWE
         G28w==
X-Forwarded-Encrypted: i=1; AFNElJ/wwx72wc6ALAktls2+naiLSGguDM+wmuNma6uOusRDtxqA7aj5yrsbxR8QsPMZE0y8QsUG3nA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEGkaJTDurpsfKNMinKzD8YtJf5DloU72i54GCWJYnJEeAfAEH
	AeU7PbOkGSF6y8WjPWMqTovwcvgAoTLQ5Gy9M641WLflQZx5rcXqnlfU
X-Gm-Gg: AeBDiesAa42Smigvq3iuY8vJNnXjAUUDl1bO+nI6xI+xU51dpiZBnUdVpAF2Rv35EL4
	mehAMUJJS2McVCwKU6KuDto2GPnEvvWlMqGD8qz8uNoY00P72v0fL09ZyzqI7keMPLgycW/aLaL
	RrDhwrP0biq6kxj0nLMiqnMlUchMu5noOivNsWfxtQNfXq0LjwsI2vXOvizEYBGpNjA+hDno7mI
	vxK48QuALEWv6/hDxbei0yMdJbac0hEGxJeGVQo7M5vwzJiT7hJhV94pJHrF4SzTWkx3pKOEvVu
	BEx9O1ay0lfwak336UjX8t07F4I/h2QRmienMItlVK3mMMEtx9yhd4xxoZ7MIwa1HRRRMQqKjid
	E7acLwBRZyq4K0EyV4eC0Zq3FZzOS4YQXjs3PxBqTECu5AjdWgGYQXsaZX/LhjQqqjumRVXoS+T
	+rI1dvNdILAqm2QHJx7u7E/WCEtGX7O7FppGOy2g==
X-Received: by 2002:a17:903:1b26:b0:2b2:49b9:c063 with SMTP id d9443c01a7336-2b5f9ff619cmr194963735ad.6.1777109915446;
        Sat, 25 Apr 2026 02:38:35 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b606ce9891sm206791725ad.83.2026.04.25.02.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 02:38:35 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Ronnie Sahlberg <lsahlber@redhat.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH 0/2] ksmbd: fix stop_sessions() iteration and centralize ksmbd_conn release
Date: Sat, 25 Apr 2026 18:38:27 +0900
Message-ID: <20260425093829.4004785-1-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 29505465B89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FREEMAIL_CC(0.00)[chromium.org,talpey.com,gmail.com,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-241115-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[charsyam@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Two independent fixes around ksmbd connection teardown.

Patch 1 ("ksmbd: rewrite stop_sessions() with restartable iteration")
fixes a stale-iterator bug in stop_sessions().  The current loop drops
conn_list_lock around transport->shutdown() and re-acquires it to
continue the same hash_for_each() walk; a concurrent ksmbd_conn_free()
in the unlocked window can make the iterator revisit or skip
connections.  The rewrite pins one connection at a time, marks it via
a new conn->stop_called flag, runs shutdown outside the lock, and
restarts from the top.  The "is the hash drained?" check is moved
into the locked walk so it no longer races hash_del() from a handler
thread.  Patch 1 carries Cc: stable@vger.kernel.org.

  Teardown wall time, ksmbd.control --shutdown + rmmod ksmbd with
  N concurrent nosharesock cifs connections (3-run mean):

      N        before        after
      10       4.93s         5.34s
      30       7.34s         7.03s
      50       7.25s         7.04s
      100      6.98s         6.78s
      200      6.77s         6.89s

  Performance is unchanged; teardown is dominated by the msleep(100)
  outer retry, not by the iteration.  The number of ->shutdown()
  calls equals the number of live connections on both paths when the
  race is not artificially widened.

Patch 2 ("ksmbd: centralize ksmbd_conn final release to plug transport
leak") routes the three bare-kfree final-put sites
(ksmbd_conn_r_count_dec, __free_opinfo, session_fd_check) through a
new ksmbd_conn_put() that defers the once-per-struct cleanup
(ida_destroy, free_transport, kfree) onto a dedicated workqueue.
Those sites previously skipped transport cleanup whenever they
happened to be the last putter, leaking struct tcp_transport and the
iov kvec (TCP) and the embedded async_ida.  The workqueue bounce is
needed because the centralized release reaches lock_sock_nested()
through tcp_close(), which sleeps; __free_opinfo() can be a final
putter from an RCU softirq callback (free_opinfo_rcu).

  A/B leak validation, QEMU/virtme guest with ksmbd server and CIFS
  client in the same guest, debug kernel (CONFIG_DEBUG_KMEMLEAK +
  CONFIG_PROVE_LOCKING + CONFIG_DEBUG_ATOMIC_SLEEP +
  CONFIG_DEBUG_OBJECTS + CONFIG_FAILSLAB):

  Reproducer per iteration: hold 8 fds open via sleep processes,
  force-close TCP with `ss -K sport = :445`, kill holders,
  lazy-umount; 10 iterations, then ksmbd shutdown + kmemleak scan.
  Pre-patch is HEAD with only patch 1 of this series applied:

      state         conn_alloc  conn_free  tcp_free  opi_rcu  kmemleak
      ----------    ----------  ---------  --------  -------  --------
      pre-patch         20          20        10       160        7
      with patch        20          20        20       160        0

  Pre-patch conn_free=20 with tcp_free=10 directly demonstrates the
  bare-kfree paths skipping transport cleanup; kmemleak reports 7
  unreferenced struct tcp_transport / t->iov objects.  With patch 2
  tcp_free matches conn_free at 20/20 and kmemleak is clean across
  two independent post-patch runs.  opi_rcu=160 confirms the RCU
  opinfo release path that motivates the fix is exercised.

Patch 2 also addresses two adjacent issues exposed by the new
debugging context:

  * __close_file_table_ids() refactor.  session_fd_check() already
    sleeps in kstrdup(GFP_KERNEL) and down_write(m_lock) before this
    patch, but the existing code calls it under write_lock(&ft->lock)
    (an rwlock_t).  Refactor so skip() runs outside ft->lock with a
    transient reference on fp; idr_remove(), fp->volatile_id clear
    and the m_fp_list unlink happen unconditionally so a deferred
    final putter (atomic_sub_and_test(2) returning false) cannot be
    left to do them via __ksmbd_remove_fd() with a stale
    volatile_id.

    Validated on an additional debug kernel built with
    CONFIG_DEBUG_LIST + CONFIG_DEBUG_OBJECTS_WORK using a
    same-session two-tcon storm: one tcon drives an open/write
    storm while the other tcon repeats 50 tree disconnects on the
    same session.  Trace counts: 52 __close_file_table_ids
    invocations, 4793 __ksmbd_close_fd, 30337 __put_fd_final, 9578
    ksmbd_conn_put, 1 __ksmbd_conn_release_work.  No
    list-corruption, work_struct ODEBUG, sleep-in-atomic, lockdep
    or kmemleak reports observed.  This stress validates the
    file-table/id/list rewrite under DEBUG_LIST/DEBUG_OBJECTS_WORK,
    not the transport leak (which the A/B above already covered).

  * fp owns a strong reference on fp->conn.  fp used to hold a
    borrowed pointer to its connection, leaving a window where the
    conn could be freed while a still-live fp held a stale
    fp->conn.  Make fp own a refcount on fp->conn from
    ksmbd_open_fd() / ksmbd_reopen_durable_fd() until __ksmbd_close_fd()
    or session_fd_check().  ksmbd_reopen_durable_fd() is also
    reordered so fp->conn / fp->tcon are set before __open_id()
    publishes fp into the session's file table, so a concurrent
    teardown cannot observe a valid volatile_id with fp->conn ==
    NULL.

The two patches are independent.  Either can be reviewed, applied,
or reverted without pulling the other.  Patch 2 references patch 1
only to explain why stop_sessions() is left on its open-coded local
cleanup and not converted to ksmbd_conn_put() in this series; if
patch 2 is applied alone, stop_sessions() retains its bare-kfree
leak that patch 1 separately addresses.

Based on ksmbd-for-next-next.

DaeMyung Kang (2):
  ksmbd: rewrite stop_sessions() with restartable iteration
  ksmbd: centralize ksmbd_conn final release to plug transport leak

 fs/smb/server/connection.c | 120 ++++++++++++++++++-----
 fs/smb/server/connection.h |   6 ++
 fs/smb/server/oplock.c     |   4 +-
 fs/smb/server/server.c     |  12 +++
 fs/smb/server/vfs_cache.c  | 189 ++++++++++++++++++++++++++++++++-----
 5 files changed, 285 insertions(+), 46 deletions(-)

--
2.43.0


