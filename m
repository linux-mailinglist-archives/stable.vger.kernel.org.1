Return-Path: <stable+bounces-265444-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id siuIKXqKMWphmAUAu9opvQ
	(envelope-from <stable+bounces-265444-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:40:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1274B693594
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:40:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=zPeLffE3;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265444-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-265444-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA661323AF24
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126934611CF;
	Tue, 16 Jun 2026 17:33:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C99332EC1;
	Tue, 16 Jun 2026 17:33:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781631230; cv=none; b=tOLVgnMcDW1YhkOUCCEIObS88dKDSIu+TTRNmVClimnUJ4B4sa/Uxu6oIsxBn1TS9IMTZVhKDDIo14cJDjJzn5CHXnxIPlS/lwBMwvv4CXuHbGG1xwuGtpfevva/9VmUXlYEbADb6Z6xHLJd7h2KsN8smlxno/uFxsl8sgJvfBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781631230; c=relaxed/simple;
	bh=+4VhhhTLToDWz6/TOUFRJFUBIgvUYmM9Mzku437V2/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J5s7u8F2wmGY8LYdoBa5WRXgYljkxCnLw7P4b1NUalTCMJHqvQxvLuxtgJUKeW5MpVwv8wMsVu17sQJ3K0Z9DJLA6TQ9TYMFEz/TwPKQWEulAzpN9Y4a7PSSst7FtyY6z6bgXoJp0buzr4NNtwimBTykHYK2cNva/vJqoOBhrOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zPeLffE3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A601F000E9;
	Tue, 16 Jun 2026 17:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781631229;
	bh=JoZO61y+Bm8EslaEnYnOItnv1L6uGH7QfIHztHM7l4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zPeLffE3HrbpcBvQCvoSvo2x+Q1yRvYpiczXzsrCvxr7C9imQg7EN7j7/9mClt7Wz
	 ikBE2aRB3FW7AD5Ow9up5edLYlPbI69B/Ch5wn0OdXQaBsJ1EJ7VaCHe0KOrTVh054
	 RXcE7cVJvYoGHWJlF0UmotAqmZ2dGxLxqI/+BPug=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vladislav Nikolaev <vlad102nikolaev@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 182/522] RDMA/rxe: Complete the rxe_cleanup_task backport
Date: Tue, 16 Jun 2026 20:25:29 +0530
Message-ID: <20260616145134.640955607@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-265444-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:vlad102nikolaev@gmail.com,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1274B693594

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladislav Nikolaev <vlad102nikolaev@gmail.com>

No upstream commit exists for this patch.

The issue was introduced with backporting upstream commit b2b1ddc45745
("RDMA/rxe: Fix the error "trying to register non-static key in
rxe_cleanup_task"") to the 6.1 stable tree as commit 3236221bb8e4
("RDMA/rxe: Fix the error "trying to register non-static key in
rxe_cleanup_task"").

The 6.1 backport guarded qp->req.task and qp->comp.task before calling
rxe_cleanup_task(), but left qp->resp.task unguarded. It also kept the
responder task cleanup before deleting the RC timers, while upstream had
already moved it after the timer shutdown by commit 960ebe97e523
("RDMA/rxe: Remove __rxe_do_task()").

In the 6.1 tree, rxe_qp_from_init() calls rxe_qp_init_req() before
rxe_qp_init_resp(). Therefore, if rxe_qp_init_req() fails, cleanup can
run before qp->resp.task has been initialized by rxe_init_task(), and the
unconditional rxe_cleanup_task(&qp->resp.task) can still hit the same
uninitialized task lock problem that upstream commit b2b1ddc45745 fixed.

Move responder task cleanup after deleting the RC timers, matching the
upstream cleanup order, and guard it with qp->resp.task.func like the
requester and completer tasks.

Fixes: 3236221bb8e4 ("RDMA/rxe: Fix the error "trying to register non-static key in rxe_cleanup_task"")
Signed-off-by: Vladislav Nikolaev <vlad102nikolaev@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/sw/rxe/rxe_qp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 709c63e9773c5f..171c0f4dcbecfc 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -781,13 +781,15 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
 
 	qp->valid = 0;
 	qp->qp_timeout_jiffies = 0;
-	rxe_cleanup_task(&qp->resp.task);
 
 	if (qp_type(qp) == IB_QPT_RC) {
 		del_timer_sync(&qp->retrans_timer);
 		del_timer_sync(&qp->rnr_nak_timer);
 	}
 
+	if (qp->resp.task.func)
+		rxe_cleanup_task(&qp->resp.task);
+
 	if (qp->req.task.func)
 		rxe_cleanup_task(&qp->req.task);
 
-- 
2.53.0




