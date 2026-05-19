Return-Path: <stable+bounces-249439-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIg5NQ/CC2qWMQUAu9opvQ
	(envelope-from <stable+bounces-249439-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 03:51:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AFB5762D1
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 03:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB12F302BCE0
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 01:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51F32EFDA6;
	Tue, 19 May 2026 01:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=senarytech.com header.i=@senarytech.com header.b="NOWK4btJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-m15571.qiye.163.com (mail-m15571.qiye.163.com [101.71.155.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F094F28727D
	for <stable@vger.kernel.org>; Tue, 19 May 2026 01:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779155466; cv=none; b=qRK0jji1mQ94tsnR1N0vZFHmF/hz5e0uWHMQbd9KLZoHOE9SqD8awdK64GJ46GaMm55gq4p9xGo+/BNqho0Nc1uo9W/NTAY6o8medegabncsqEsioA4Xs6oba0QB7bmqp4BtTjWsCZgNf4YiieAlbmLL3lfwno1uHdW5c8Su2x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779155466; c=relaxed/simple;
	bh=XMHmCIpx0UnQDSjerejScAS9qmpys3C3vCwvEjhNq/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pCiVkBqOEIPns9Eh3EpCahJePqIKdOgMe4DfMgGRx8KUjXNyv2sX5IK6H0fREEeLl9f8EsFhcD7em1UJDISR4vl/MEfAuw+GmZUN8nwpgt5STDrasHVl9DJxAEQNE8+RyrI8Y2SCKvr5KDMLC4XzcUdOWYBkDQ6qDoyyBR8t4Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=senarytech.com; spf=pass smtp.mailfrom=senarytech.com; dkim=pass (1024-bit key) header.d=senarytech.com header.i=@senarytech.com header.b=NOWK4btJ; arc=none smtp.client-ip=101.71.155.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=senarytech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=senarytech.com
Received: from localhost.localdomain (unknown [112.95.78.112])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3ee86b46f;
	Tue, 19 May 2026 09:45:41 +0800 (GMT+08:00)
From: Mao Weiming <alex.mao@senarytech.com>
To: alex.mao@senarytech.com
Cc: stable@vger.kernel.org
Subject: [PATCH v2] cpuidle: coupled: Fix use-after-free on device unregister
Date: Tue, 19 May 2026 01:45:33 +0000
Message-Id: <20260519014533.37-1-alex.mao@senarytech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518064324.<v1-msgid>-1-alex.mao@senarytech.com>
References: <20260518064324.<v1-msgid>-1-alex.mao@senarytech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e3de9040509d1kunmd55619983a71c6
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSB1PVkMYTElOT0hPSUJKH1YVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlKSklVQk5VTENVSkpJWVdZFhoPEhUdFFlBWU9LSFVKT0
	1MTk9MVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=NOWK4btJd26V6JaBAlywvQt1Kg/iSPRkBg207rtvhzZhHvgF6OMjAAMUjGMk1qaIA3nTHR2Vb6ZbJHdKO1XlcK24CKneQDmmn3Lr+z7PFNSmegz3ioTlRJ+DAaHNeYwtYaDOEANMtRCM9l9zzfjkqS9mFujuiy+jdBnscQlk27M=; c=relaxed/relaxed; s=default; d=senarytech.com; v=1;
	bh=NtpIfGfp7Zep09C5MBG8n8u+2XAw+1BZqdy5wKDEbBw=;
	h=date:mime-version:subject:message-id:from;
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[senarytech.com,quarantine];
	R_DKIM_ALLOW(-0.20)[senarytech.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-249439-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex.mao@senarytech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[senarytech.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 44AFB5762D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This issue was found by code review of drivers/cpuidle/coupled.c, not
from a crash report.

cpuidle_coupled_unregister_device() has had its refcount check inverted
ever since the function was added:

	if (--coupled->refcnt)
		kfree(coupled);
	dev->coupled = NULL;

A struct cpuidle_coupled is shared by every CPU in a coupled set.
cpuidle_coupled_register_device() either allocates a new instance with
refcnt = 1, or reuses an existing one and bumps refcnt. The struct must
therefore only be freed once refcnt drops back to zero. The current
code does the exact opposite:

  - With N >= 2 CPUs in the set, the first CPU to unregister decrements
    refcnt from N to N-1, the condition becomes true, and the struct is
    kfree()'d while the remaining N-1 CPUs still hold dev->coupled
    pointers to that memory.

  - When the last CPU finally unregisters, refcnt becomes 0, the
    condition is false, and the struct is leaked.

Subsequent unregister calls in the same loop then dereference and
decrement coupled->refcnt on the freed object, and any CPU hotplug
callback racing into coupled_cpu_online() / coupled_cpu_up_prepare()
between the kfree() and the final dev->coupled = NULL assignment will
also touch the dangling pointer.

Fix it by freeing the struct only when refcnt reaches zero, matching
the kerneldoc above the function and the symmetric increment in
cpuidle_coupled_register_device().

Fixes: 4126c0197bc8 ("cpuidle: add support for states that affect multiple cpus")
Cc: stable@vger.kernel.org
Signed-off-by: Mao Weiming <alex.mao@senarytech.com>
---
Changes since v1:
  - Use full name "Mao Weiming" in the patch's From: and Signed-off-by:
    trailers to match the email's From: header.
  - No code or commit-message changes.

v1: https://lore.kernel.org/all/20260518064324.3240-1-alex.mao@senarytech.com/

 drivers/cpuidle/coupled.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/coupled.c b/drivers/cpuidle/coupled.c
index fb91a9e0e3c2..25d8a6b27a51 100644
--- a/drivers/cpuidle/coupled.c
+++ b/drivers/cpuidle/coupled.c
@@ -687,7 +687,7 @@ void cpuidle_coupled_unregister_device(struct cpuidle_device *dev)
 	if (cpumask_empty(&dev->coupled_cpus))
 		return;
 
-	if (--coupled->refcnt)
+	if (!--coupled->refcnt)
 		kfree(coupled);
 	dev->coupled = NULL;
 }
-- 
2.25.1


