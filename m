Return-Path: <stable+bounces-220591-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOGKFCdPo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220591-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:25:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAD91C8536
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A658D306E179
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C5748A2DE;
	Sat, 28 Feb 2026 17:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="raU7AH67"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA093DFC77;
	Sat, 28 Feb 2026 17:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300474; cv=none; b=Uy59xACCQo/RLccuNIWeXVBBcY3ejonTY0KG/iCk37ACcFsa9I2bYNIegZaHj6LMNFqoZobXBlPNGldjapGonYV/o7zbTUGV1R5gSk62+KnSrul9q+WDzuO2PiqZDfNNShjl3yqCqTnHyvFTP5qhtI6VUEWqX0fMhZgQWQfMGZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300474; c=relaxed/simple;
	bh=9XEM5KECmNQtwp7tgi+FFNvVL4pDMPVGmBujC3r2VIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rmlSPMOdDEZfC4Znj1E5fuLvoet97iX+Xn56p9JqV/TpT2L1PPQH3jxD1yV0OAZb1LpLC5rR9BlQdRzG/E6gb8Z0BFoH1PgU8EmR0VQZzD+Q3wvr0UI+QO76odj2PoGUlmXskntp7I2MU6rUR6QOi+wf24ADdXUCl2BYZci4elA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=raU7AH67; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0437CC2BC87;
	Sat, 28 Feb 2026 17:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300473;
	bh=9XEM5KECmNQtwp7tgi+FFNvVL4pDMPVGmBujC3r2VIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=raU7AH67VPvWjb7YfXcsc/Mk1GF5cNLJkNfbYef+z3xwgPpVxBicNu678RecclFwE
	 UkmqAiC+31cNwcnFSsqh5Xs0Tj8/nSGDlTXEfkajOHVT6UWFou5sN+A4yy8cvP1WXl
	 WNEYD1NOxZLFl06QADbh4oaFryYw1iC5SiparVHrxzQr3OV+hHrErWAveyetUnQATf
	 jBiI9yVjvMiwMAHVi3sg3KxGvuMxq1k8gnxkE0zEu6XEmXviL/Tnc0axv/KF19tpPC
	 Xbb0YB5KVSnq/CtJ+wIbFYdmtMk6PuBE4VGX9kWfqLU02JkqEGqft0SO1gUcJzwUdZ
	 YvxLlhyQVVLJw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chia-I Wu <olvaffe@gmail.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Steven Price <steven.price@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 512/844] drm/panthor: fix for dma-fence safe access rules
Date: Sat, 28 Feb 2026 12:27:05 -0500
Message-ID: <20260228173244.1509663-513-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,collabora.com,arm.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220591-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,collabora.com:email,arm.com:email]
X-Rspamd-Queue-Id: 6DAD91C8536
X-Rspamd-Action: no action

From: Chia-I Wu <olvaffe@gmail.com>

[ Upstream commit efe24898485c5c831e629d9c6fb9350c35cb576f ]

Commit 506aa8b02a8d6 ("dma-fence: Add safe access helpers and document
the rules") details the dma-fence safe access rules. The most common
culprit is that drm_sched_fence_get_timeline_name may race with
group_free_queue.

Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Cc: stable@vger.kernel.org # v6.17+
Signed-off-by: Steven Price <steven.price@arm.com>
Link: https://patch.msgid.link/20251204174545.399059-1-olvaffe@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index bd397d773d72b..5c55ba593b244 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -23,6 +23,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/rcupdate.h>
 
 #include "panthor_devfreq.h"
 #include "panthor_device.h"
@@ -939,6 +940,9 @@ static void group_release_work(struct work_struct *work)
 						   release_work);
 	u32 i;
 
+	/* dma-fences may still be accessing group->queues under rcu lock. */
+	synchronize_rcu();
+
 	for (i = 0; i < group->queue_count; i++)
 		group_free_queue(group, group->queues[i]);
 
-- 
2.51.0


