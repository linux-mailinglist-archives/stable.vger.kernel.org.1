Return-Path: <stable+bounces-216080-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CU1Evcrj2kPKwEAu9opvQ
	(envelope-from <stable+bounces-216080-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:49:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 841531367AB
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B1D0305C48B
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 13:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F4C35EDAB;
	Fri, 13 Feb 2026 13:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YXZMpH45"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225FF34E754;
	Fri, 13 Feb 2026 13:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770990567; cv=none; b=Bb56HqDRh8ulPl4kREeplkS/fnL35lTt2AGB47b6uzSQ0d3nbPGhLkUslVHVAdWfSOjmfyxY6lhI7+y7G5sHYyHplROi8t4ZeNDbIxjUUtqrrGquf2to6nGZcEdICMf5VUlNdUY0C8ZcunEqn6nLPuXA5lbj2RAS+Y4pZ5h4eA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770990567; c=relaxed/simple;
	bh=WTdLZDphwNMDJoYDpfIIwJObAom4p7l7JUIRFejqWlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4Go+lTPjypdkgNjgNfPhHLGGAKazRa62nvBTLK7ottkcsXfzC/7IEikiqFY6PPagIaxCXB2E88A+OIRi71PVgMyp4YCPy1PYMs4x9BqEWkLK2rgQkz1O+dsP8i2xLxPB8TCCLKA7AhNjQ8p4Sh6easG6rZaycrvRkUcYNQXEUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YXZMpH45; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA89C116C6;
	Fri, 13 Feb 2026 13:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770990566;
	bh=WTdLZDphwNMDJoYDpfIIwJObAom4p7l7JUIRFejqWlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YXZMpH457L+va3Ffe4md1/ZjExP1h/VaWablEtUw1qIMlfDKSTK9SH3kKsrrmTzBn
	 Hl8CR8dHAAmbO3tELvRbu45NhZsC9gnlFETjfWyNKEGwAQKrTUElD4HJMKCB8mUnJa
	 wa4cHhQFO4dPtz931ZEhCCRiTgwGWfYySCnh5IY8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Li Chen <me@linux.beauty>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.19 01/49] io_uring/io-wq: add exit-on-idle state
Date: Fri, 13 Feb 2026 14:47:20 +0100
Message-ID: <20260213134708.780411035@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260213134708.713126210@linuxfoundation.org>
References: <20260213134708.713126210@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-216080-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,linux.beauty:email]
X-Rspamd-Queue-Id: 841531367AB
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Li Chen <me@linux.beauty>

commit 38aa434ab9335ce2d178b7538cdf01d60b2014c3 upstream.

io-wq uses an idle timeout to shrink the pool, but keeps the last worker
around indefinitely to avoid churn.

For tasks that used io_uring for file I/O and then stop using io_uring,
this can leave an iou-wrk-* thread behind even after all io_uring
instances are gone. This is unnecessary overhead and also gets in the
way of process checkpoint/restore.

Add an exit-on-idle state that makes all io-wq workers exit as soon as
they become idle, and provide io_wq_set_exit_on_idle() to toggle it.

Signed-off-by: Li Chen <me@linux.beauty>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/io-wq.c |   27 +++++++++++++++++++++++++--
 io_uring/io-wq.h |    1 +
 2 files changed, 26 insertions(+), 2 deletions(-)

--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -34,6 +34,7 @@ enum {
 
 enum {
 	IO_WQ_BIT_EXIT		= 0,	/* wq exiting */
+	IO_WQ_BIT_EXIT_ON_IDLE	= 1,	/* allow all workers to exit on idle */
 };
 
 enum {
@@ -706,9 +707,13 @@ static int io_wq_worker(void *data)
 		raw_spin_lock(&acct->workers_lock);
 		/*
 		 * Last sleep timed out. Exit if we're not the last worker,
-		 * or if someone modified our affinity.
+		 * or if someone modified our affinity. If wq is marked
+		 * idle-exit, drop the worker as well. This is used to avoid
+		 * keeping io-wq workers around for tasks that no longer have
+		 * any active io_uring instances.
 		 */
-		if (last_timeout && (exit_mask || acct->nr_workers > 1)) {
+		if ((last_timeout && (exit_mask || acct->nr_workers > 1)) ||
+		    test_bit(IO_WQ_BIT_EXIT_ON_IDLE, &wq->state)) {
 			acct->nr_workers--;
 			raw_spin_unlock(&acct->workers_lock);
 			__set_current_state(TASK_RUNNING);
@@ -963,6 +968,24 @@ static bool io_wq_worker_wake(struct io_
 	return false;
 }
 
+void io_wq_set_exit_on_idle(struct io_wq *wq, bool enable)
+{
+	if (!wq->task)
+		return;
+
+	if (!enable) {
+		clear_bit(IO_WQ_BIT_EXIT_ON_IDLE, &wq->state);
+		return;
+	}
+
+	if (test_and_set_bit(IO_WQ_BIT_EXIT_ON_IDLE, &wq->state))
+		return;
+
+	rcu_read_lock();
+	io_wq_for_each_worker(wq, io_wq_worker_wake, NULL);
+	rcu_read_unlock();
+}
+
 static void io_run_cancel(struct io_wq_work *work, struct io_wq *wq)
 {
 	do {
--- a/io_uring/io-wq.h
+++ b/io_uring/io-wq.h
@@ -41,6 +41,7 @@ struct io_wq_data {
 struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data);
 void io_wq_exit_start(struct io_wq *wq);
 void io_wq_put_and_exit(struct io_wq *wq);
+void io_wq_set_exit_on_idle(struct io_wq *wq, bool enable);
 
 void io_wq_enqueue(struct io_wq *wq, struct io_wq_work *work);
 void io_wq_hash_work(struct io_wq_work *work, void *val);



