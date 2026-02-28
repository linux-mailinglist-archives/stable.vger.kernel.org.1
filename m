Return-Path: <stable+bounces-220530-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8P0LOD48o2nv+gQAu9opvQ
	(envelope-from <stable+bounces-220530-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:04:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 517AF1C691B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2C4B308753A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27513CF36D;
	Sat, 28 Feb 2026 17:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcfVUVws"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E053CF365;
	Sat, 28 Feb 2026 17:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300413; cv=none; b=TPsPAswounpnyyT46wim6N8t5tt5s9mOPPLkOnIwTnErboU3dewbDFjFBafA15DVe6m4QrtQ16D6GMwe2oZPcMv1KoNzTnaoqab4yT8qtwAAQMlglrHOvju3jyZLQnabR1So9OiPCgAjPSki+aWb8AAqLyAx4z0iiyFlHIBgSwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300413; c=relaxed/simple;
	bh=CHIQ8RFlYm6XssHKC0qEZNneuTPqhYyW6GTW/jhvNzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XvG0Rcge6vsZQGm+nHmuHwNiZRkw04Eq4ccl96azMzBNfwmmfMfFAn0XmGvFhYRGkLUUgIdzgKhgHOXeyhcmlRm12XUUGUduzG1MFYBBWGpwc0PECshluior+K+QP5P3+yOAsYXdYJwsK7qJnG0ErN810AmcNJ5aphh9YQD+4Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tcfVUVws; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB35C116D0;
	Sat, 28 Feb 2026 17:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300413;
	bh=CHIQ8RFlYm6XssHKC0qEZNneuTPqhYyW6GTW/jhvNzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tcfVUVwsKhsMksy0DGoRl+BccbjaLRkRCy/Y7EcZMlNJpBYqCznBv9SVsOcK2wdPk
	 AV+7+VPj0cr/9VWivfTmWUcbuCV5XiPa9xv+65ODKjNltz6ZpDhsPHHk8/qnhjDxxe
	 8pzMSa8PtUBDS9ZCDPVPsJ5pUKLHT/ESfjsDGjlgU/Ec/RNXyNaeadQpnnEdK5yINZ
	 fa9sWYoJFxZRtztvJReZoiVy+OL4KDwwy2Dq2NryUUPQju30wLEilxNgxhEthqlIt7
	 7wJ5W5xVQsCHUaDdpNM+TnCdOkS2E8zXKeBdxBOKIE3MFkV93Z8pfahlfrauWNlj/Q
	 CfJ3N0R4EAbjw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 451/844] writeback: Fix wakeup and logging timeouts for !DETECT_HUNG_TASK
Date: Sat, 28 Feb 2026 12:26:04 -0500
Message-ID: <20260228173244.1509663-452-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-220530-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.cz:email]
X-Rspamd-Queue-Id: 517AF1C691B
X-Rspamd-Action: no action

From: Huacai Chen <chenhuacai@loongson.cn>

[ Upstream commit 9eed043d10f17301c1b5141e16bb98a85a8fd07e ]

Recent changes of fs-writeback cause such warnings if DETECT_HUNG_TASK
is not enabled:

INFO: The task sync:1342 has been waiting for writeback completion for more than 1 seconds.

The reason is sysctl_hung_task_timeout_secs is 0 when DETECT_HUNG_TASK
is not enabled, then it causes the warning message even if the writeback
lasts for only one second.

Guard the wakeup and logging with "#ifdef CONFIG_DETECT_HUNG_TASK" can
eliminate the warning messages. But on the other hand, it is possible
that sysctl_hung_task_timeout_secs be also 0 when DETECT_HUNG_TASK is
enabled. So let's just check the value of sysctl_hung_task_timeout_secs
to decide whether do wakeup and logging.

Fixes: 1888635532fb ("writeback: Wake up waiting tasks when finishing the writeback of a chunk.")
Fixes: d6e621590764 ("writeback: Add logging for slow writeback (exceeds sysctl_hung_task_timeout_secs)")
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Link: https://patch.msgid.link/20260203094014.2273240-1-chenhuacai@loongson.cn
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fs-writeback.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 5444fc706ac7d..79b02ac66ac6d 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -198,10 +198,11 @@ static void wb_queue_work(struct bdi_writeback *wb,
 
 static bool wb_wait_for_completion_cb(struct wb_completion *done)
 {
+	unsigned long timeout = sysctl_hung_task_timeout_secs;
 	unsigned long waited_secs = (jiffies - done->wait_start) / HZ;
 
 	done->progress_stamp = jiffies;
-	if (waited_secs > sysctl_hung_task_timeout_secs)
+	if (timeout && (waited_secs > timeout))
 		pr_info("INFO: The task %s:%d has been waiting for writeback "
 			"completion for more than %lu seconds.",
 			current->comm, current->pid, waited_secs);
@@ -1944,6 +1945,7 @@ static long writeback_sb_inodes(struct super_block *sb,
 		.range_end		= LLONG_MAX,
 	};
 	unsigned long start_time = jiffies;
+	unsigned long timeout = sysctl_hung_task_timeout_secs;
 	long write_chunk;
 	long total_wrote = 0;  /* count both pages and inodes */
 	unsigned long dirtied_before = jiffies;
@@ -2030,9 +2032,8 @@ static long writeback_sb_inodes(struct super_block *sb,
 		__writeback_single_inode(inode, &wbc);
 
 		/* Report progress to inform the hung task detector of the progress. */
-		if (work->done && work->done->progress_stamp &&
-		   (jiffies - work->done->progress_stamp) > HZ *
-		   sysctl_hung_task_timeout_secs / 2)
+		if (work->done && work->done->progress_stamp && timeout &&
+		   (jiffies - work->done->progress_stamp) > HZ * timeout / 2)
 			wake_up_all(work->done->waitq);
 
 		wbc_detach_inode(&wbc);
-- 
2.51.0


