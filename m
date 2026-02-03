Return-Path: <stable+bounces-213304-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJFAHltYgmmkSgMAu9opvQ
	(envelope-from <stable+bounces-213304-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 21:19:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A102DE6F6
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 21:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 761913028875
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 20:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3709736B04D;
	Tue,  3 Feb 2026 20:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzPNTFhA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2EA2C234B
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 20:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770149977; cv=none; b=d8/3YQ6OrQd7ZSPZ3ZjezvaS/kd11bzRr39eSqrNyxnOVKWeGhDjeuVyNIOYbAvUP5Wqyc7aM20luZoXPQNCpxy2OxGTBsKFKJaNgLDZMcK0EunO/PzuzsE8VELyl3phk5c4tBH34GEiNMm4jCQReuEbIXSQgts6S83FH936SE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770149977; c=relaxed/simple;
	bh=ESPyrTkY5nECp0xEpdctE4imPIR+r/0MiQx5nu5jg1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jKQsD31wXKQs9IMhLnxXB+6X3pWtfFwtOfXMR+51s1ua7sFTS2S+TpczeTInc2lZJCg1v0a+xsOg0J4DyccSIFxQ5lUDsfddSzsv8MQekE7vqaHU9gP0KqdWbXVX9Iz3n/ve1qlzWys50ZEU1dVvtPwkKfpeWXpXboT3OBcTFnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzPNTFhA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08132C116D0;
	Tue,  3 Feb 2026 20:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770149976;
	bh=ESPyrTkY5nECp0xEpdctE4imPIR+r/0MiQx5nu5jg1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VzPNTFhAj9tWfAtJWsfoecqowLKQ/Cd3XYMJCtCjfglrQPmDfKDL5zsEJ9reRyIZk
	 QagwtNUWyVIssP3PqqV2kOfY5BRiWy8QdMy5IQ+ZjCU0rws3iBDXqTQHqoW1X8nTYC
	 9jL5I6QsgJwWdkzAfH35ICgdvIj2zfzFej+zvow0K9Yenp57uY4SCEcwYFNk+BgwRW
	 sCRKnaOn1HqY5P/ZBZmfrgTVW130nLXDR3fxaiBpE9H9y2CbVGkHIWWwrvearoOpwj
	 X5ZYdG+52BleMdzxWWfPOoPjG2SODOAId70j2s9ez71k8Su1oqTaYzDgJCwIFLiTZf
	 Yn83aLqtLUxiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Laveesh Bansal <laveeshb@laveeshbansal.com>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] writeback: fix 100% CPU usage when dirtytime_expire_interval is 0
Date: Tue,  3 Feb 2026 15:19:34 -0500
Message-ID: <20260203201934.1387179-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026020305-spoils-sandworm-ccc5@gregkh>
References: <2026020305-spoils-sandworm-ccc5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213304-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 1A102DE6F6
X-Rspamd-Action: no action

From: Laveesh Bansal <laveeshb@laveeshbansal.com>

[ Upstream commit 543467d6fe97e27e22a26e367fda972dbefebbff ]

When vm.dirtytime_expire_seconds is set to 0, wakeup_dirtytime_writeback()
schedules delayed work with a delay of 0, causing immediate execution.
The function then reschedules itself with 0 delay again, creating an
infinite busy loop that causes 100% kworker CPU usage.

Fix by:
- Only scheduling delayed work in wakeup_dirtytime_writeback() when
  dirtytime_expire_interval is non-zero
- Cancelling the delayed work in dirtytime_interval_handler() when
  the interval is set to 0
- Adding a guard in start_dirtytime_writeback() for defensive coding

Tested by booting kernel in QEMU with virtme-ng:
- Before fix: kworker CPU spikes to ~73%
- After fix: CPU remains at normal levels
- Setting interval back to non-zero correctly resumes writeback

Fixes: a2f4870697a5 ("fs: make sure the timestamps for lazytime inodes eventually get written")
Cc: stable@vger.kernel.org
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220227
Signed-off-by: Laveesh Bansal <laveeshb@laveeshbansal.com>
Link: https://patch.msgid.link/20260106145059.543282-2-laveeshb@laveeshbansal.com
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
[ adapted system_percpu_wq to system_wq for the workqueue used in dirtytime_interval_handler() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fs-writeback.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 75e8c102c5eef..0a36fc5e1bf2c 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2360,12 +2360,14 @@ static void wakeup_dirtytime_writeback(struct work_struct *w)
 				wb_wakeup(wb);
 	}
 	rcu_read_unlock();
-	schedule_delayed_work(&dirtytime_work, dirtytime_expire_interval * HZ);
+	if (dirtytime_expire_interval)
+		schedule_delayed_work(&dirtytime_work, dirtytime_expire_interval * HZ);
 }
 
 static int __init start_dirtytime_writeback(void)
 {
-	schedule_delayed_work(&dirtytime_work, dirtytime_expire_interval * HZ);
+	if (dirtytime_expire_interval)
+		schedule_delayed_work(&dirtytime_work, dirtytime_expire_interval * HZ);
 	return 0;
 }
 __initcall(start_dirtytime_writeback);
@@ -2376,8 +2378,12 @@ int dirtytime_interval_handler(struct ctl_table *table, int write,
 	int ret;
 
 	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
-	if (ret == 0 && write)
-		mod_delayed_work(system_wq, &dirtytime_work, 0);
+	if (ret == 0 && write) {
+		if (dirtytime_expire_interval)
+			mod_delayed_work(system_wq, &dirtytime_work, 0);
+		else
+			cancel_delayed_work_sync(&dirtytime_work);
+	}
 	return ret;
 }
 
-- 
2.51.0


