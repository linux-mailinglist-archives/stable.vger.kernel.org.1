Return-Path: <stable+bounces-220153-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHiQJZsso2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220153-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:57:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCF61C545E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EBD6431B0656
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476F6492504;
	Sat, 28 Feb 2026 17:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYjHnJZ7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0510733EAEA;
	Sat, 28 Feb 2026 17:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300062; cv=none; b=BFf3JnblGZ9+PKkZnkGyXdQU2vbhWBgU6YHRETvaJrylFwPYQCdcjzmGq9+GeAHcR5MvD9PXP6aJsUJrBTppCSeBW/jxO6E+5TnpKoMJFlvxrmtnKt8dCzvcqWbLEen0bBzZfBmDxSTeOvpclWayysRSCuc0zLnvtfpYLWVlluA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300062; c=relaxed/simple;
	bh=sUj53CCzyRZ+Nl+bD3YaS0/JzC1/MC3O53QNnmpsXGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jMd5AqqE2Jh+u7RcjcCDsfnFBJT/lWsRbyODNKVUH+91U98NI02tEAqRM0DP4r94ar1er4sOIU5ulKddTMSd4jNOkHTN9/JkksS3zcacb/ogjEWslzSEf2VlItKPiCTd9qKS8hHhqCr7P7Afmar9eb9IX5wrlxTIsWVuwLoSSoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYjHnJZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03DE4C116D0;
	Sat, 28 Feb 2026 17:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300061;
	bh=sUj53CCzyRZ+Nl+bD3YaS0/JzC1/MC3O53QNnmpsXGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rYjHnJZ7sRuv4STALOj1YTLTJWPUEK7JZr/3UCgWg1XXGHbpfUO1Kqd6AtSock5Kb
	 U+yn0vnYAz1CdXemZUNVsU9u3GHscGYxLynXLwXC7ByxIVTEwqtHGmRYoi1gdnzL1B
	 8lx7hAGmELZF81WsqkSkTb1lRxgDZBMPgCcZJDcQIZmPr1hGhH6wp54Sa/7cslnM85
	 0GP7JsOdaYlTKlexlkE3yOVkbvrh+d6Kpq9H4CP/LCF79XYjM0GUV434Ucyl/cYMXi
	 3nK3Sj+1SLR+z0oaqOOj7iIK/Ai2eR1/0JoKMdjeH+3T+KEfQh9Wb8LCF8gz018emI
	 V+C17JwTP7Jkg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiasheng Jiang <jiashengjiangcool@gmail.com>,
	Yu Kuai <yukuai@fnnas.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 075/844] md-cluster: fix NULL pointer dereference in process_metadata_update
Date: Sat, 28 Feb 2026 12:19:48 -0500
Message-ID: <20260228173244.1509663-76-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,fnnas.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220153-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fnnas.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2FCF61C545E
X-Rspamd-Action: no action

From: Jiasheng Jiang <jiashengjiangcool@gmail.com>

[ Upstream commit f150e753cb8dd756085f46e86f2c35ce472e0a3c ]

The function process_metadata_update() blindly dereferences the 'thread'
pointer (acquired via rcu_dereference_protected) within the wait_event()
macro.

While the code comment states "daemon thread must exist", there is a valid
race condition window during the MD array startup sequence (md_run):

1. bitmap_load() is called, which invokes md_cluster_ops->join().
2. join() starts the "cluster_recv" thread (recv_daemon).
3. At this point, recv_daemon is active and processing messages.
4. However, mddev->thread (the main MD thread) is not initialized until
   later in md_run().

If a METADATA_UPDATED message is received from a remote node during this
specific window, process_metadata_update() will be called while
mddev->thread is still NULL, leading to a kernel panic.

To fix this, we must validate the 'thread' pointer. If it is NULL, we
release the held lock (no_new_dev_lockres) and return early, safely
ignoring the update request as the array is not yet fully ready to
process it.

Link: https://lore.kernel.org/linux-raid/20260117145903.28921-1-jiashengjiangcool@gmail.com
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Signed-off-by: Yu Kuai <yukuai@fnnas.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md-cluster.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
index 11f1e91d387d8..896279988dfd5 100644
--- a/drivers/md/md-cluster.c
+++ b/drivers/md/md-cluster.c
@@ -549,8 +549,13 @@ static void process_metadata_update(struct mddev *mddev, struct cluster_msg *msg
 
 	dlm_lock_sync(cinfo->no_new_dev_lockres, DLM_LOCK_CR);
 
-	/* daemaon thread must exist */
 	thread = rcu_dereference_protected(mddev->thread, true);
+	if (!thread) {
+		pr_warn("md-cluster: Received metadata update but MD thread is not ready\n");
+		dlm_unlock_sync(cinfo->no_new_dev_lockres);
+		return;
+	}
+
 	wait_event(thread->wqueue,
 		   (got_lock = mddev_trylock(mddev)) ||
 		    test_bit(MD_CLUSTER_HOLDING_MUTEX_FOR_RECVD, &cinfo->state));
-- 
2.51.0


