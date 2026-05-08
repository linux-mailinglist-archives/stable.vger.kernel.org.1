Return-Path: <stable+bounces-244653-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGYzCy0r/WkJYgAAu9opvQ
	(envelope-from <stable+bounces-244653-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 02:15:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B764F0713
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 02:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EE263033FB2
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 00:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C671A6836;
	Fri,  8 May 2026 00:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n9qgO/B4"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305382AD00
	for <stable@vger.kernel.org>; Fri,  8 May 2026 00:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778199325; cv=none; b=JT4h8VmA0mB762bO5thop53kevKnn5rSX+ppCiNt/91wv3vHMbKefpP4/pd43zxyWeA9OErpPjvHqo9F4v3vVShkOLtrgLvofkjcCpMjdAupjWuy29mEynJ867M9xfN5xE7BA0Cfr6mHofJy2SiJqZnnpo38iQxiERiP+u9m8EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778199325; c=relaxed/simple;
	bh=SKEeViFbp1uXUSYeHb372Uw+KJNAO1yOkAXwhXCVyQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e0akM+iXWZcoQCMptsS7O82NuPd2wtSHzg5liHy8SPBygRj/kx/ljzOsR5pL9gzYyz07oxXZ95Ww7mBjoDlX33Z2EAZ/J3AMBs2wdGEXsJ0+Awvm0QJ+jWnPYx0JDc84v/iD8CxHfRWazOP0r9h5P6xCKSz4r27BO2Cxvmlir+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n9qgO/B4; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2f7ca62a3c4so882750eec.0
        for <stable@vger.kernel.org>; Thu, 07 May 2026 17:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778199323; x=1778804123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7LQCxTjl/7QlKwFcwi4/FESx78z4DYB8yBxbbODWZwc=;
        b=n9qgO/B4xR/jX45b67IAoPWeP6O8vPd3ZC3fn0rtRW/Cn4hailsG1MIWMeDH32+cqV
         VvDB/4WQBRHVQl7YmuiQNa9pI9033C7Ax4n4vxO1RD3YNwejSFZcRLtGLHDBz23k1zM8
         6bGjewXsaYPUeT/P6CwDZC4GnNn2heEZWAyGhFlKTm4EZcGRtYSIrRdzirI4jrlg6ij7
         SXNPKahH7sykQmgYsL3Yau0DTEznYS+pH/V4TqZZp846h5pljX29MCBqP+2Ut1D8kGTv
         Vm0cjK5GLZtUj7ef8/kKp1i0oDXa5v7CU/Jsx4nadhNJEin1j7JRgopiFxfiiY1EQA7e
         OSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778199323; x=1778804123;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LQCxTjl/7QlKwFcwi4/FESx78z4DYB8yBxbbODWZwc=;
        b=RRCYr1x9O9mfYG14CONs9NKCbPpcf8/b+uIFtuM6FhG/+93HLYaWlRYwDieBnrWm1b
         2efznrC6NcFHKP0Kcw/MOqwMG2LRhw8furnIDH7BI+s7s+Yi5jPhxnNoWm9raPAG9SfT
         vljg2eXxsvsFJ6ezVPsronMImMHrQlqW2KlYkJDaZs2M65fo33StvyQTYZct03ID/r1S
         wZDf2c2qph3/Qeun9YQWmT4rQ6vcXydYOVyi8Kuwn9ybLe5KUrrFbRqsM//6s4lEIag1
         8dcod7M68WU4k/bp9opsrPPQz2HsC9H4Iv9ZRm+wGFAY1eSVmRHiRQYGSwq51V69e2MC
         6hGg==
X-Forwarded-Encrypted: i=1; AFNElJ9ADzDBUy/eJA1kLjpErZSXeVpkZv3clrt/8hsDW3SWrKN07EB0H8Q94W1LWlKx0IujloXCwpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YztPYSSs5IclJwSgvR3IiHKhIaAoBAYbH2jL18idpMrceGwSlKf
	98K11njkIXHYU+0pQ1iR1Gbzdn9WqoFkcqO/2jOvyakq16cGV3a/QDC5
X-Gm-Gg: Acq92OHjZOpAHOBeEfC7iwIZoxIzML7fFVcEnN8vrYxEKgyOkwaZ9x7lcnoczGVbbxg
	x096VP1BbydEFhs+xn4hiupDGH4KK9X1O2SmyRUUNFWSKWCvN8kYBlbJHEeTnl4gLqWDWYUk+0w
	vwe7Hb1bsRLKHEdDVzNAhuuezKu2PXGVoYFytxYOWpXnfhbximeK2e5ynMihWArOlyfFcHK/jVn
	9trWPvT9Kb1lcOGMCpODjIjr4Dx8Ec+/xIZAjEMWss6XkGqKW2epJupTX5oH34WlbwF4oRvr6DF
	sD81JuUebk7QPx+UmnAjq995jZhyYIvlIqyc3EU7KY7whPOqQuroUGRZ/SJI/7dynH2JANHo2kD
	ZJopgj4kWzJJNdBJYjLqqngEnywLO3Gn6G3rBcEr70O8GCS0ce2r+MGeVu7QWJZeTy3q8N3gvM6
	hH5TnLDJEyHKoPKhwWq+Qj9N7b+mEqpY+OWqgrxmbbXj4yQog7
X-Received: by 2002:a05:7300:e82b:b0:2ca:7eb4:3e0f with SMTP id 5a478bee46e88-2f54b897f52mr5070659eec.5.1778199322328;
        Thu, 07 May 2026 17:15:22 -0700 (PDT)
Received: from bmorris-M3Y3522M42 ([136.24.56.26])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eafc2sm103309eec.4.2026.05.07.17.15.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 May 2026 17:15:21 -0700 (PDT)
From: joycathacker@gmail.com
To: marcelo.leitner@gmail.com,
	lucien.xin@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	security@kernel.org,
	Ben Morris <bmorris@anthropic.com>,
	stable@vger.kernel.org
Subject: [PATCH net] sctp: revalidate list cursor after sctp_sendmsg_to_asoc() in SCTP_SENDALL
Date: Thu,  7 May 2026 17:14:55 -0700
Message-ID: <20260508001455.3137-1-joycathacker@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C1B764F0713
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244653-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joycathacker@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[anthropic.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,base.sk:url]
X-Rspamd-Action: no action

From: Ben Morris <bmorris@anthropic.com>

The SCTP_SENDALL path in sctp_sendmsg() iterates ep->asocs with
list_for_each_entry_safe(), which caches the next entry in @tmp before
the loop body runs.  The body calls sctp_sendmsg_to_asoc(), which may
drop the socket lock inside sctp_wait_for_sndbuf().

While the lock is dropped, another thread can SCTP_SOCKOPT_PEELOFF the
association cached in @tmp, migrating it to a new endpoint via
sctp_sock_migrate() (list_del_init() + list_add_tail() to
newep->asocs), and optionally close the new socket which frees the
association via kfree_rcu().  The cached @tmp can also be freed by a
network ABORT for that association, processed in softirq while the
lock is dropped.

sctp_wait_for_sndbuf() revalidates @asoc (the current entry) on re-lock
via the "sk != asoc->base.sk" and "asoc->base.dead" checks, but nothing
revalidates @tmp.  After a successful return, the iterator advances to
the stale @tmp, yielding either a use-after-free (if the peeled socket
was closed) or a list-walk onto the new endpoint's list head (type
confusion of &newep->asocs as a struct sctp_association *).

Both are reachable from CapEff=0; the type-confusion path gives
controlled indirect call via the outqueue.sched->init_sid pointer.

Fix by re-deriving @tmp from @asoc after sctp_sendmsg_to_asoc()
returns.  @asoc is known to still be on ep->asocs at that point: the
only callers that list_del an association from ep->asocs are
sctp_association_free() (which sets asoc->base.dead) and
sctp_assoc_migrate() (which changes asoc->base.sk), and
sctp_wait_for_sndbuf() checks both under the lock before any
successful return; a tripped check propagates as err < 0 and the loop
bails before the re-derive.

The SCTP_ABORT path in sctp_sendmsg_check_sflags() returns 0 and the
loop hits 'continue' before sctp_sendmsg_to_asoc() is ever called, so
the @tmp cached by list_for_each_entry_safe() still covers the
lock-held free that ba59fb027307 ("sctp: walk the list of asoc
safely") was added for.

Fixes: 4910280503f3 ("sctp: add support for snd flag SCTP_SENDALL process in sendmsg")
Cc: stable@vger.kernel.org
Assisted-by: claude:mythos
Signed-off-by: Ben Morris <bmorris@anthropic.com>
---
 net/sctp/socket.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 58d0d9747f0b..1d2568bb6bc2 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -1986,6 +1986,15 @@ static int sctp_sendmsg(struct sock *sk, struct msghdr *msg, size_t msg_len)
 				goto out_unlock;

 			iov_iter_revert(&msg->msg_iter, err);
+
+			/* sctp_sendmsg_to_asoc() may have released the socket
+			 * lock (sctp_wait_for_sndbuf), during which other
+			 * associations on ep->asocs could have been peeled
+			 * off or freed.  @asoc itself is revalidated by the
+			 * base.dead and base.sk checks in sctp_wait_for_sndbuf,
+			 * so re-derive the cached cursor from it.
+			 */
+			tmp = list_next_entry(asoc, asocs);
 		}

 		goto out_unlock;
--
2.43.0

