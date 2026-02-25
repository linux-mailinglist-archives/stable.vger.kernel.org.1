Return-Path: <stable+bounces-218998-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEO8IHJVnmnyUgQAu9opvQ
	(envelope-from <stable+bounces-218998-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:50:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CD7190034
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2DA2830FFBEA
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764EA2652B7;
	Wed, 25 Feb 2026 01:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i0ofhgMd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA2420C012;
	Wed, 25 Feb 2026 01:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983907; cv=none; b=RE8EIke523RV1pXrym4yN8ZRBZIevrAxBpFW9a9O1mk/c6uQs/iSNeJVCBS2bzkMdoJZetFdapRZm8+TySIsZlpUVMWr3ekdN9e6I1cuAxGFi3VeAs63uMHbRpHIJP+SKrFvBVzJdLlEfxd5aJFiIGzc9FsIzwE1ZtILvjghUbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983907; c=relaxed/simple;
	bh=WLMMpkcjKz6fcYFfCBafRzHT1HPa44bgmgMp0GMfnOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JayFL6yXmgz1gJLG8NCTIQDMaqJZjC0Vw4iAir0RtLqU7egJs9qDpXeMPTAVnrs+syC5ySz19tfoPYO4OMAqu93zixOibCRJ8DPin4Ug+hIVZY/HIvCGeDx7FV2Tc3EkepjXyiFXLKnZlvIR5wvKLLVw3b1XdTgEXnlmUHP260M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i0ofhgMd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E623CC116D0;
	Wed, 25 Feb 2026 01:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983907;
	bh=WLMMpkcjKz6fcYFfCBafRzHT1HPa44bgmgMp0GMfnOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i0ofhgMdCyoTyX7bSGmFfNQ4hmE2CWCPRHE5PRBME0CG6/LwLAF6/t1uZZpp9vR1h
	 ZF2+9Uj65pmt8Yqhz4E2CkmhcJ8jdiiNfIeGiDrVvky0YE8ebrSZ5BMhNngWrWOjuZ
	 l9RfTR3sWaM+khATi4KeZlHfkjWj8rXgwmxQPr1w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 174/641] workqueue: Factor out assign_rescuer_work()
Date: Tue, 24 Feb 2026 17:18:20 -0800
Message-ID: <20260225012353.253976892@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-218998-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,antgroup.com:email]
X-Rspamd-Queue-Id: 20CD7190034
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

[ Upstream commit 99ed6f62a46e91dc796b785618d646eeded1b230 ]

Move the code to assign work to rescuer and assign_rescuer_work().

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Stable-dep-of: e5a30c303b07 ("workqueue: Process rescuer work items one-by-one using a cursor")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/workqueue.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 45320e27a16c4..2fa3187101725 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3443,6 +3443,23 @@ static int worker_thread(void *__worker)
 	goto woke_up;
 }
 
+static bool assign_rescuer_work(struct pool_workqueue *pwq, struct worker *rescuer)
+{
+	struct worker_pool *pool = pwq->pool;
+	struct work_struct *work, *n;
+
+	/*
+	 * Slurp in all works issued via this workqueue and
+	 * process'em.
+	 */
+	list_for_each_entry_safe(work, n, &pool->worklist, entry) {
+		if (get_work_pwq(work) == pwq && assign_work(work, rescuer, &n))
+			pwq->stats[PWQ_STAT_RESCUED]++;
+	}
+
+	return !list_empty(&rescuer->scheduled);
+}
+
 /**
  * rescuer_thread - the rescuer thread function
  * @__rescuer: self
@@ -3497,7 +3514,6 @@ static int rescuer_thread(void *__rescuer)
 		struct pool_workqueue *pwq = list_first_entry(&wq->maydays,
 					struct pool_workqueue, mayday_node);
 		struct worker_pool *pool = pwq->pool;
-		struct work_struct *work, *n;
 
 		__set_current_state(TASK_RUNNING);
 		list_del_init(&pwq->mayday_node);
@@ -3508,18 +3524,9 @@ static int rescuer_thread(void *__rescuer)
 
 		raw_spin_lock_irq(&pool->lock);
 
-		/*
-		 * Slurp in all works issued via this workqueue and
-		 * process'em.
-		 */
 		WARN_ON_ONCE(!list_empty(&rescuer->scheduled));
-		list_for_each_entry_safe(work, n, &pool->worklist, entry) {
-			if (get_work_pwq(work) == pwq &&
-			    assign_work(work, rescuer, &n))
-				pwq->stats[PWQ_STAT_RESCUED]++;
-		}
 
-		if (!list_empty(&rescuer->scheduled)) {
+		if (assign_rescuer_work(pwq, rescuer)) {
 			process_scheduled_works(rescuer);
 
 			/*
-- 
2.51.0




