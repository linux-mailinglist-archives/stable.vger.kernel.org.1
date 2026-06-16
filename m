Return-Path: <stable+bounces-265334-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sJACKNWGMWrKlgUAu9opvQ
	(envelope-from <stable+bounces-265334-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:24:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B30CF69318B
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:24:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=fE9qwLPb;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265334-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265334-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2ED2230327D2
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4F7478E26;
	Tue, 16 Jun 2026 17:24:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFE144BCBE;
	Tue, 16 Jun 2026 17:24:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781630674; cv=none; b=KzKeVpOhY8H28A8n3GDjCEKLCbTlFS9j9MFlvpi0l7+19XzkgZhpe/rme78iezMaTph5kX9RklVoLEZOzmJ/dJ2ci6aKSm0zSDUcJ/H8aY7dHtLBhP2is/h3g0iVBoaE2oxAiHgqb9OHC2ns+5rGRlASJZn/s63Oo4GHtZzbFHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781630674; c=relaxed/simple;
	bh=rplYRk9SrtFo55R0HWnFk28i73jeOFNqUYERgJfZH4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXAkaCQej0kyW+Mb7IL6rpVNTyxlclj8FfDsyFC7e1Z5vkA47NwSBYEMwrRt+5+pfhoZfv676M5b9t2+V9CGh8l52pgTc3dz9f+2Wnp8ZPcoOmGEXI7CpzyolNJpvSzmL1X95ds9ne32peWR421M/JBYpzVZb3sTZIWtyqn92gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fE9qwLPb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F4F1F000E9;
	Tue, 16 Jun 2026 17:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781630673;
	bh=ADhCGIOwe0U+4EXcYWekSQVcTTf6AZKVQn40BZrCYwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fE9qwLPbo5JRjT1FYUW10VeuSpsUdyeDZ9LMzoVKpNmwhb2+iTibdPsHjBKO5x2ya
	 xrGvRZa1QLqjr0Y/+UyaqLowURnWzgGqxnW92VM151TDJE0IrOWH9lyYoIjY7FPJR8
	 NcGZJSMMy6fHoyNIVvNQHl11H22hhQlzn5VB4UpE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>,
	Zhu Yanjun <yanjun.Zhu@linux.dev>,
	Leon Romanovsky <leon@kernel.org>,
	Ben Hutchings <benh@debian.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 075/522] RDMA/rxe: Fix double free in rxe_srq_from_init
Date: Tue, 16 Jun 2026 20:23:42 +0530
Message-ID: <20260616145129.353735934@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,linux.dev,kernel.org,debian.org];
	TAGGED_FROM(0.00)[bounces-265334-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:jiashengjiangcool@gmail.com,m:yanjun.Zhu@linux.dev,m:leon@kernel.org,m:benh@debian.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linux.dev:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B30CF69318B

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiasheng Jiang <jiashengjiangcool@gmail.com>

commit 0beefd0e15d962f497aad750b2d5e9c3570b66d1 upstream.

In rxe_srq_from_init(), the queue pointer 'q' is assigned to
'srq->rq.queue' before copying the SRQ number to user space.
If copy_to_user() fails, the function calls rxe_queue_cleanup()
to free the queue, but leaves the now-invalid pointer in
'srq->rq.queue'.

The caller of rxe_srq_from_init() (rxe_create_srq) eventually
calls rxe_srq_cleanup() upon receiving the error, which triggers
a second rxe_queue_cleanup() on the same memory, leading to a
double free.

The call trace looks like this:
   kmem_cache_free+0x.../0x...
   rxe_queue_cleanup+0x1a/0x30 [rdma_rxe]
   rxe_srq_cleanup+0x42/0x60 [rdma_rxe]
   rxe_elem_release+0x31/0x70 [rdma_rxe]
   rxe_create_srq+0x12b/0x1a0 [rdma_rxe]
   ib_create_srq_user+0x9a/0x150 [ib_core]

Fix this by moving 'srq->rq.queue = q' after copy_to_user.

Fixes: aae0484e15f0 ("IB/rxe: avoid srq memory leak")
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Link: https://patch.msgid.link/20260112015412.29458-1-jiashengjiangcool@gmail.com
Reviewed-by: Zhu Yanjun <yanjun.Zhu@linux.dev>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
[bwh: Backported to 6.1: There was no assignment to init->attr.max_wr
 here; don't add it]
Signed-off-by: Ben Hutchings <benh@debian.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/sw/rxe/rxe_srq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c b/drivers/infiniband/sw/rxe/rxe_srq.c
index 02b39498c370d2..038a9cd55413e0 100644
--- a/drivers/infiniband/sw/rxe/rxe_srq.c
+++ b/drivers/infiniband/sw/rxe/rxe_srq.c
@@ -69,8 +69,6 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq *srq,
 		return -ENOMEM;
 	}
 
-	srq->rq.queue = q;
-
 	err = do_mmap_info(rxe, uresp ? &uresp->mi : NULL, udata, q->buf,
 			   q->buf_size, &q->ip);
 	if (err) {
@@ -87,6 +85,8 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq *srq,
 		}
 	}
 
+	srq->rq.queue = q;
+
 	return 0;
 }
 
-- 
2.53.0




