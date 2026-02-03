Return-Path: <stable+bounces-213301-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4L4LD6xWgmntSQMAu9opvQ
	(envelope-from <stable+bounces-213301-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 21:12:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AC020DE61B
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 21:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6DD230A7086
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 20:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7D436827B;
	Tue,  3 Feb 2026 20:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xt8v0wI8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25247261C
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 20:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770149545; cv=none; b=Xi2YvvY9/oNQcMt0b4oArpuy0PfIzNJZLbC2LEFXAceizrlXJ5031GQMNxeWeN6XqLilUSsphXgz/5gbPBZkMDV1qx37YC+L6XmyiCHiSDHtAD9RX0/64Nyri+xLkCpR/8ljGgGxIArjZFEIJGCM+sBrAWMl9HWXVW5wjR3HB18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770149545; c=relaxed/simple;
	bh=hORQ2tSu5Qyy/LHl+SSpXBEVfJAR8+kTYpImm80YGhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JgYVru2PnBzzw1AP94tDinH+hbkPVmyV3+tEJZjeqHVa5jmpbAgVyJyieKVIvkIH3EHg9IhfSeGs/bMPJ/kCHSXI3OHxRfC0pQ+tXUMVVSAedEiR9MJxOoRJXz1fabY8NxPYhMEWcSbxsFNz1cUeJqTdqJ7vRroequ+fWV5ffVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xt8v0wI8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB39C116D0;
	Tue,  3 Feb 2026 20:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770149545;
	bh=hORQ2tSu5Qyy/LHl+SSpXBEVfJAR8+kTYpImm80YGhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xt8v0wI8LZvMpgmzBKIJhdrYc1SQucX40vfBE90icsj7Dk4UpV1DxuGvzS7BZMbDU
	 b7f8kutPCPF2nhVwS3zR5Na2z9t5DwoZKdUEI6+gKAvg27BvTVNQDI/8+MdbKpB2YN
	 3gmSH9wx2tHgXcHwMOy/g6Bi5lenDkvCwyZWUbQRvcRsvzIg4mOteXtVd1zhiXY68B
	 ZypIXnVgqWWGeH3xvkTvWKrVe8bWRuZlvIZIZsucxHXPQy08fQfBFQxFUL7W/I20HJ
	 cmp20IAuEJpO7Ic9veGNHPQNc0rbi1zu3GjjWRkzSeYlIC0a5w5jFM2Vhy146a7JC0
	 V4P1QeN8+wg/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Laveesh Bansal <laveeshb@laveeshbansal.com>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] writeback: fix 100% CPU usage when dirtytime_expire_interval is 0
Date: Tue,  3 Feb 2026 15:12:22 -0500
Message-ID: <20260203201222.1381303-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026020304-plated-overshoot-86c8@gregkh>
References: <2026020304-plated-overshoot-86c8@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213301-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: AC020DE61B
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
index 274fae88b498e..a1236a178a7b6 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2382,12 +2382,14 @@ static void wakeup_dirtytime_writeback(struct work_struct *w)
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
@@ -2398,8 +2400,12 @@ int dirtytime_interval_handler(struct ctl_table *table, int write,
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


