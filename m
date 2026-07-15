Return-Path: <stable+bounces-274911-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3jT+EnZyV2rEOAEAu9opvQ
	(envelope-from <stable+bounces-274911-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 13:43:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E86375DA97
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 13:43:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dvipJVjo;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274911-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274911-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87F87303FA90
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 11:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BE643C7DF;
	Wed, 15 Jul 2026 11:40:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8A33B27F4
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 11:40:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784115626; cv=none; b=Gm+x53CR1tf6BK/P1XDJrSFHs63V04GT48QNy9Pn7hAlnDxyNUajl3x69eXXXLv3SmMDaVfn5l+PEnnABipQTsGOP7wn1cW2z/q+U9DSH1yMgXwgtJrWMgeVnPH2dTgpTUoHgvE2fqkKWMBxe3pSjCzlfadQUziHbELgO3JdfRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784115626; c=relaxed/simple;
	bh=XNvPGFgQNmYnfRZWfhVPVyqMhHMMVqa4iyiSbSR7JAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=THQx2QSbj6Bi12uCVUwEkNZC2787xkBDTnZq3LjMsJaXuKUeWJNcMXQegdERLQCNv4WeHfG6MK01QWQVx/zKHG6DL+EdMd2M2FzlVNBxwzXUSBvCMWtOVXQVVmFETwvidrnAZFJxX6prCyJWPGjuL+07dj4xeXj1T8u0LGBQmIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvipJVjo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4801F000E9;
	Wed, 15 Jul 2026 11:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784115625;
	bh=9xWPpSWjPDOcQlieIuc/uGM58t1W+5oN6SJOtUh+8Uw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dvipJVjonIwg7uBh4TI5JAcqj+IutfeloZY8GluTc++m+vtNNilmF7ZuX0R2203/G
	 Fu3ym0GdWlncwMTjAm0yr6NiJ72Hs/OU7ArajOUKcEbjiZOxsEypwSzdNXbO92IH3x
	 vw1g+iGNWvaE1a29xgMYekvzTNdsMMrrpxFQB5m+T5bKp+dlTr8chibPBsieSeC2Zu
	 QBaYJCb8pUGBsggjOkmPywDtLWyiPVnxruDu9RF3DH9ZJug+qFVyiYEClbFuIvh9Kr
	 fT5n1bbJGKk9qbNgR5cxzp7lcYFfh922e+SLmfjO9+T3p3P4QlkeJoFkDe2c2PnQfB
	 9V//HOc61WV3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	John Garry <john.g.garry@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] io_uring/rw: ensure reissue path is correctly handled for IOPOLL
Date: Wed, 15 Jul 2026 07:40:17 -0400
Message-ID: <20260715114018.726395-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071357-gout-canyon-b50f@gregkh>
References: <2026071357-gout-canyon-b50f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:axboe@kernel.dk,m:john.g.garry@oracle.com,m:sashal@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-274911-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,oracle.com:email,kernel.dk:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E86375DA97

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit bcb0fda3c2da9fe4721d3e73d80e778c038e7d27 ]

The IOPOLL path posts CQEs when the io_kiocb is marked as completed,
so it cannot rely on the usual retry that non-IOPOLL requests do for
read/write requests.

If -EAGAIN is received and the request should be retried, go through
the normal completion path and let the normal flush logic catch it and
reissue it, like what is done for !IOPOLL reads or writes.

Fixes: d803d123948f ("io_uring/rw: handle -EAGAIN retry at IO completion time")
Reported-by: John Garry <john.g.garry@oracle.com>
Link: https://lore.kernel.org/io-uring/2b43ccfa-644d-4a09-8f8f-39ad71810f41@oracle.com/
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: c554246ff4c6 ("io_uring/rw: preserve partial result for iopoll")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/rw.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/io_uring/rw.c b/io_uring/rw.c
index ab2c092d82b4b6..0afbb1ae76618f 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -550,11 +550,10 @@ static void io_complete_rw_iopoll(struct kiocb *kiocb, long res)
 	if (kiocb->ki_flags & IOCB_WRITE)
 		io_req_end_write(req);
 	if (unlikely(res != req->cqe.res)) {
-		if (res == -EAGAIN && io_rw_should_reissue(req)) {
+		if (res == -EAGAIN && io_rw_should_reissue(req))
 			req->flags |= REQ_F_REISSUE | REQ_F_BL_NO_RECYCLE;
-			return;
-		}
-		req->cqe.res = res;
+		else
+			req->cqe.res = res;
 	}
 
 	/* order with io_iopoll_complete() checking ->iopoll_completed */
-- 
2.53.0


