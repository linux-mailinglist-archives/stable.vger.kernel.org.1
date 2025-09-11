Return-Path: <stable+bounces-179314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D35B53EAD
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 00:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A275B1BC334E
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 22:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471DA2EDD44;
	Thu, 11 Sep 2025 22:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Jb9QYNSY"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EDE2D7806
	for <stable@vger.kernel.org>; Thu, 11 Sep 2025 22:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757629659; cv=none; b=mqe3TyidPIst/G9SSJbWZZ9ykXucZvB+G+d+Uf24/Zhq98Snm6Lfv4uGE7rsVsmaKViIRBB686jNApPefPeK52App0S9vnVoJcgRBhWqyp5aeeQvrgxWMkI6YlJyFpfj63x6x54XtaUfNlgDyvI2v8GNOm/LVff81qMEssDxjj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757629659; c=relaxed/simple;
	bh=TYhHFAWWDZpL2+gXDsEZ5TiDudm3bWWFNrx7RJGh8Sg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=FIU+1ivp8DmkMp5TqnwlIGFr6m7oxhGUXUFGnTlc1iThjpIe0CW2PjIjIlbxG4SjbNKI58sZ2gnN9K3IfPC/y43596VN84tXrkNFpIkx+Wi1hfsW5sUk9emrah+RlW/zuMSZDZPg/cIgtgbReA5EXaVYcBq86l6/AC0045ByO9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Jb9QYNSY; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b04ba58a84fso180609666b.2
        for <stable@vger.kernel.org>; Thu, 11 Sep 2025 15:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1757629654; x=1758234454; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXOFYebBJBCD1dv4SnFvk4++LNKwmhVr0GmbHlWJtPk=;
        b=Jb9QYNSYGhEmcZLhyzhkbp+ZSUuvc2cXDnUp09ybT8WtAcZ+3zd/ZkWqDWcictIY4t
         fwx70XHlapRYcqs1HQ4B73OR7lWUie21Gn0/5pZAOpbnq9G/y1wuFVJNFUnyeFome+P9
         wjFiPo4Vt8X7PUiZ771treRMric25N7Q+ZJLg2Rai4gkpbQtsQ6y/qFlLJ3goGi1M9JV
         d6DyEG67t+umxOmob2DawrxZsFT9uZ8dEiZODfKeSyeCWjSxunmVG2flqnHGrzebY/P7
         qABsCWegv3zOs7tL4g4mCP03S7IglMJXNDp+gh/Jp7a7bmVKYHfUshUiMFKiT3kc2Z0A
         jiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757629654; x=1758234454;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rXOFYebBJBCD1dv4SnFvk4++LNKwmhVr0GmbHlWJtPk=;
        b=eidsW1NrPQhA8k+Ppfzfpn7uIPhtQyq6L6J8VuyCM03/GwZsHMj+E179tbogvUf1Ab
         OnHzKHI0W61Bk60cojGga+Ihgtuo+RlUVbiYHi5YvHO5Bfi8DRQn/CX+vtxkqCP4R9hN
         iAhByjAi4/gpZuLUBJQKS8fdLyCcmFl/c553ZcjZwKgvLnRHSmuiw8hz1DZIFpNwP31a
         YrW5NC0/U/2B+HVyCJG4KdzfW4lORsJ3BEpt7+TEQ/4JcWI3BUU6zIIqK3/jQN2DJBCi
         y865zdoX7G901GoF9tFIw1Zeg766p6wzKDgXAr8rqrk2ZfeZ6FBX/Bci8YQN2WCKBulE
         bR/w==
X-Gm-Message-State: AOJu0Yz1dG1eAAM0zag6J3bxOJ/XcmOoyYjJK2kgKsF5FG+pvPLQOX2m
	kHdPnAJcnkK3nEXYvBvUkC+tHPvbRyw/O5YVMMoqzEJ4zEv/cW9yqCXhDq5NS/JHasw1jT0Et9m
	VBMyeo70krp9KrfXjaSN8b+P+IbrXpfVBDPSMdF5/OytlZY96o/3PeJ0=
X-Gm-Gg: ASbGncuckuHJ+cLkWU5qBQLMQebQvKhnikq51sAJiSujnQ3hIJaJRkT3tu9cIB8bJyh
	l58YVxH0x59jKbLXwI7H/Vgsc/kjPT49pFc6oThTjUJmv45C5DkDd7chBbM37REeu5muFhZ4wMg
	9feOA9QG4ekBmZIBc0KopJx08PaFsiIWCpixvF9catw/opl94mUZLyLxsIXs08LuaxU/YPVIO4s
	EUTSdoqMsbTjuXdC6ldFtCwvLVUwwqVB1kw
X-Google-Smtp-Source: AGHT+IGu/b6tPjt7Mwtj7NJ+qJ4ddnk5bQhvncLU/kBY5u6Qqrgf1c78M0eKDq77mKuPIN8uoXQ/41n+fdyR1Y/iJew=
X-Received: by 2002:a17:907:8688:b0:afe:c099:aeb3 with SMTP id
 a640c23a62f3a-b07c357aa15mr77632766b.25.1757629654484; Thu, 11 Sep 2025
 15:27:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911222501.1417765-1-max.kellermann@ionos.com>
In-Reply-To: <20250911222501.1417765-1-max.kellermann@ionos.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 12 Sep 2025 00:27:23 +0200
X-Gm-Features: AS18NWBxiQp3k48DEhbUDHQ3zK_8hZPx3ygGElpBqFvvto0WcgiIti1pc66EiFc
Message-ID: <CAKPOu+9CjL-=xsT48k+PfQme2zCr1HnoWh5jcJgpp-BzPhqoDw@mail.gmail.com>
Subject: Fwd: [PATCH] fs/netfs: fix reference leak
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg, sorry I mistyped the "stable" email address, so I'm
forwarding this patch to you.
Here's the original email:
https://lore.kernel.org/lkml/20250911222501.1417765-1-max.kellermann@ionos.=
com/

---------- Forwarded message ---------
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, Sep 12, 2025 at 12:25=E2=80=AFAM
Subject: [PATCH] fs/netfs: fix reference leak
To: David Howells <dhowells@redhat.com>, Paulo Alcantara
<pc@manguebit.org>, Christian Brauner <brauner@kernel.org>,
<netfs@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
<linux-kernel@vger.kernel.org>
Cc: Max Kellermann <max.kellermann@ionos.com>, <linux-stable@vger.kernel.or=
g>


Commit 20d72b00ca81 ("netfs: Fix the request's work item to not
require a ref") modified netfs_alloc_request() to initialize the
reference counter to 2 instead of 1.  The rationale was that the
requet's "work" would release the second reference after completion
(via netfs_{read,write}_collection_worker()).  That works most of the
time if all goes well.

However, it leaks this additional reference if the request is released
before the I/O operation has been submitted: the error code path only
decrements the reference counter once and the work item will never be
queued because there will never be a completion.

This has caused outages of our whole server cluster today because
tasks were blocked in netfs_wait_for_outstanding_io(), leading to
deadlocks in Ceph (another bug that I will address soon in another
patch).  This was caused by a netfs_pgpriv2_begin_copy_to_cache() call
which failed in fscache_begin_write_operation().  The leaked
netfs_io_request was never completed, leaving `netfs_inode.io_count`
with a positive value forever.

All of this is super-fragile code.  Finding out which code paths will
lead to an eventual completion and which do not is hard to see:

- Some functions like netfs_create_write_req() allocate a request, but
  will never submit any I/O.

- netfs_unbuffered_read_iter_locked() calls netfs_unbuffered_read()
  and then netfs_put_request(); however, netfs_unbuffered_read() can
  also fail early before submitting the I/O request, therefore another
  netfs_put_request() call must be added there.

A rule of thumb is that functions that return a `netfs_io_request` do
not submit I/O, and all of their callers must be checked.

For my taste, the whole netfs code needs an overhaul to make reference
counting easier to understand and less fragile & obscure.  But to fix
this bug here and now and produce a patch that is adequate for a
stable backport, I tried a minimal approach that quickly frees the
request object upon early failure.

I decided against adding a second netfs_put_request() each time
because that would cause code duplication which obscures the code
further.  Instead, I added the function netfs_put_failed_request()
which frees such a failed request synchronously under the assumption
that the reference count is exactly 2 (as initially set by
netfs_alloc_request() and never touched), verified by a
WARN_ON_ONCE().  It then deinitializes the request object (without
going through the "cleanup_work" indirection) and frees the allocation
(without the "call_rcu" indirection).  This should be safe because
this is the same context that allocated/initialized the request and
nobody else has a pointer to this object.

All code paths that fail early have been changed to call
netfs_put_failed_request() instead of netfs_put_request().
Additionally, I have added a netfs_put_request() call to
netfs_unbuffered_read() as explained above because the
netfs_put_failed_request() approach does not work there.

Fixes: 20d72b00ca81 ("netfs: Fix the request's work item to not require a r=
ef")
Cc: linux-stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/netfs/buffered_read.c | 10 +++++-----
 fs/netfs/direct_read.c   |  7 ++++++-
 fs/netfs/direct_write.c  |  6 +++++-
 fs/netfs/internal.h      |  1 +
 fs/netfs/objects.c       | 32 +++++++++++++++++++++++++++++---
 fs/netfs/read_pgpriv2.c  |  2 +-
 fs/netfs/read_single.c   |  2 +-
 fs/netfs/write_issue.c   |  3 +--
 8 files changed, 49 insertions(+), 14 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 18b3dc74c70e..37ab6f28b5ad 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -369,7 +369,7 @@ void netfs_readahead(struct readahead_control *ractl)
        return netfs_put_request(rreq, netfs_rreq_trace_put_return);

 cleanup_free:
-       return netfs_put_request(rreq, netfs_rreq_trace_put_failed);
+       return netfs_put_failed_request(rreq);
 }
 EXPORT_SYMBOL(netfs_readahead);

@@ -472,7 +472,7 @@ static int netfs_read_gaps(struct file *file,
struct folio *folio)
        return ret < 0 ? ret : 0;

 discard:
-       netfs_put_request(rreq, netfs_rreq_trace_put_discard);
+       netfs_put_failed_request(rreq);
 alloc_error:
        folio_unlock(folio);
        return ret;
@@ -532,7 +532,7 @@ int netfs_read_folio(struct file *file, struct folio *f=
olio)
        return ret < 0 ? ret : 0;

 discard:
-       netfs_put_request(rreq, netfs_rreq_trace_put_discard);
+       netfs_put_failed_request(rreq);
 alloc_error:
        folio_unlock(folio);
        return ret;
@@ -699,7 +699,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
        return 0;

 error_put:
-       netfs_put_request(rreq, netfs_rreq_trace_put_failed);
+       netfs_put_failed_request(rreq);
 error:
        if (folio) {
                folio_unlock(folio);
@@ -754,7 +754,7 @@ int netfs_prefetch_for_write(struct file *file,
struct folio *folio,
        return ret < 0 ? ret : 0;

 error_put:
-       netfs_put_request(rreq, netfs_rreq_trace_put_discard);
+       netfs_put_failed_request(rreq);
 error:
        _leave(" =3D %d", ret);
        return ret;
diff --git a/fs/netfs/direct_read.c b/fs/netfs/direct_read.c
index a05e13472baf..a498ee8d6674 100644
--- a/fs/netfs/direct_read.c
+++ b/fs/netfs/direct_read.c
@@ -131,6 +131,7 @@ static ssize_t netfs_unbuffered_read(struct
netfs_io_request *rreq, bool sync)

        if (rreq->len =3D=3D 0) {
                pr_err("Zero-sized read [R=3D%x]\n", rreq->debug_id);
+               netfs_put_request(rreq, netfs_rreq_trace_put_discard);
                return -EIO;
        }

@@ -205,7 +206,7 @@ ssize_t netfs_unbuffered_read_iter_locked(struct
kiocb *iocb, struct iov_iter *i
        if (user_backed_iter(iter)) {
                ret =3D netfs_extract_user_iter(iter, rreq->len,
&rreq->buffer.iter, 0);
                if (ret < 0)
-                       goto out;
+                       goto error_put;
                rreq->direct_bv =3D (struct bio_vec *)rreq->buffer.iter.bve=
c;
                rreq->direct_bv_count =3D ret;
                rreq->direct_bv_unpin =3D iov_iter_extract_will_pin(iter);
@@ -238,6 +239,10 @@ ssize_t netfs_unbuffered_read_iter_locked(struct
kiocb *iocb, struct iov_iter *i
        if (ret > 0)
                orig_count -=3D ret;
        return ret;
+
+error_put:
+       netfs_put_failed_request(rreq);
+       return ret;
 }
 EXPORT_SYMBOL(netfs_unbuffered_read_iter_locked);

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index a16660ab7f83..a9d1c3b2c084 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -57,7 +57,7 @@ ssize_t netfs_unbuffered_write_iter_locked(struct
kiocb *iocb, struct iov_iter *
                        n =3D netfs_extract_user_iter(iter, len,
&wreq->buffer.iter, 0);
                        if (n < 0) {
                                ret =3D n;
-                               goto out;
+                               goto error_put;
                        }
                        wreq->direct_bv =3D (struct bio_vec
*)wreq->buffer.iter.bvec;
                        wreq->direct_bv_count =3D n;
@@ -101,6 +101,10 @@ ssize_t netfs_unbuffered_write_iter_locked(struct
kiocb *iocb, struct iov_iter *
 out:
        netfs_put_request(wreq, netfs_rreq_trace_put_return);
        return ret;
+
+error_put:
+       netfs_put_failed_request(wreq);
+       return ret;
 }
 EXPORT_SYMBOL(netfs_unbuffered_write_iter_locked);

diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index d4f16fefd965..4319611f5354 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -87,6 +87,7 @@ struct netfs_io_request *netfs_alloc_request(struct
address_space *mapping,
 void netfs_get_request(struct netfs_io_request *rreq, enum
netfs_rreq_ref_trace what);
 void netfs_clear_subrequests(struct netfs_io_request *rreq);
 void netfs_put_request(struct netfs_io_request *rreq, enum
netfs_rreq_ref_trace what);
+void netfs_put_failed_request(struct netfs_io_request *rreq);
 struct netfs_io_subrequest *netfs_alloc_subrequest(struct
netfs_io_request *rreq);

 static inline void netfs_see_request(struct netfs_io_request *rreq,
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index e8c99738b5bb..9a3fbb73325e 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -116,10 +116,8 @@ static void netfs_free_request_rcu(struct rcu_head *rc=
u)
        netfs_stat_d(&netfs_n_rh_rreq);
 }

-static void netfs_free_request(struct work_struct *work)
+static void netfs_deinit_request(struct netfs_io_request *rreq)
 {
-       struct netfs_io_request *rreq =3D
-               container_of(work, struct netfs_io_request, cleanup_work);
        struct netfs_inode *ictx =3D netfs_inode(rreq->inode);
        unsigned int i;

@@ -149,6 +147,14 @@ static void netfs_free_request(struct work_struct *wor=
k)

        if (atomic_dec_and_test(&ictx->io_count))
                wake_up_var(&ictx->io_count);
+}
+
+static void netfs_free_request(struct work_struct *work)
+{
+       struct netfs_io_request *rreq =3D
+               container_of(work, struct netfs_io_request, cleanup_work);
+
+       netfs_deinit_request(rreq);
        call_rcu(&rreq->rcu, netfs_free_request_rcu);
 }

@@ -167,6 +173,26 @@ void netfs_put_request(struct netfs_io_request
*rreq, enum netfs_rreq_ref_trace
        }
 }

+/*
+ * Free a request (synchronously) that was just allocated but has
+ * failed before it could be submitted.
+ */
+void netfs_put_failed_request(struct netfs_io_request *rreq)
+{
+       /* new requests have two references (see
+        * netfs_alloc_request(), and this function is only allowed on
+        * new request objects
+        */
+       WARN_ON_ONCE(refcount_read(&rreq->ref) !=3D 2);
+
+       trace_netfs_rreq_ref(rreq->debug_id, 0, netfs_rreq_trace_put_failed=
);
+
+       netfs_deinit_request(rreq);
+
+       mempool_free(rreq, rreq->netfs_ops->request_pool ?:
&netfs_request_pool);
+       netfs_stat_d(&netfs_n_rh_rreq);
+}
+
 /*
  * Allocate and partially initialise an I/O request structure.
  */
diff --git a/fs/netfs/read_pgpriv2.c b/fs/netfs/read_pgpriv2.c
index 8097bc069c1d..a1489aa29f78 100644
--- a/fs/netfs/read_pgpriv2.c
+++ b/fs/netfs/read_pgpriv2.c
@@ -118,7 +118,7 @@ static struct netfs_io_request
*netfs_pgpriv2_begin_copy_to_cache(
        return creq;

 cancel_put:
-       netfs_put_request(creq, netfs_rreq_trace_put_return);
+       netfs_put_failed_request(creq);
 cancel:
        rreq->copy_to_cache =3D ERR_PTR(-ENOBUFS);
        clear_bit(NETFS_RREQ_FOLIO_COPY_TO_CACHE, &rreq->flags);
diff --git a/fs/netfs/read_single.c b/fs/netfs/read_single.c
index fa622a6cd56d..5c0dc4efc792 100644
--- a/fs/netfs/read_single.c
+++ b/fs/netfs/read_single.c
@@ -189,7 +189,7 @@ ssize_t netfs_read_single(struct inode *inode,
struct file *file, struct iov_ite
        return ret;

 cleanup_free:
-       netfs_put_request(rreq, netfs_rreq_trace_put_failed);
+       netfs_put_failed_request(rreq);
        return ret;
 }
 EXPORT_SYMBOL(netfs_read_single);
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 0584cba1a043..dd8743bc8d7f 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -133,8 +133,7 @@ struct netfs_io_request
*netfs_create_write_req(struct address_space *mapping,

        return wreq;
 nomem:
-       wreq->error =3D -ENOMEM;
-       netfs_put_request(wreq, netfs_rreq_trace_put_failed);
+       netfs_put_failed_request(wreq);
        return ERR_PTR(-ENOMEM);
 }

--
2.47.3

