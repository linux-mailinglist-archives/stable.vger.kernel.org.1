Return-Path: <stable+bounces-22342-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D94AA85DB8D
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78BA21F20FEE
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 13:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1DF77A03;
	Wed, 21 Feb 2024 13:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e3CySzgK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F2E2A1D7;
	Wed, 21 Feb 2024 13:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708522949; cv=none; b=ZMXuABil9ELgaLskiErN+1UbJrW7IhMGVSGypQEMVJNk6oe0K4Gk/DHKOex3CSbOeSGdaMDqWc4ShsitV9gfA1/yHqX5t3OFCPe2lcIshgQzlsj+NrCaoeTzF3Z6FHsexzwuUThgg7C1KJn6sAoavQ+zMjQAVrtK2XHsnkX7i0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708522949; c=relaxed/simple;
	bh=+5vmFQhY8GF0xnHnwTK9d2G1V9sqhbCJcnWkq7uH8S0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VY4DjiUqco3Xsz43X5aIfNSzYoI08nX53ScCKMGTXIbcgtgF0Xo1QGlrr2fl1FTLxoa/Vl2dVAso0PhJw77v0Y/k8agLMXnjIN0hr55uQLvuTagauU1znLrqKGhNn6g0ozSH8lvSMfrpKubkGkBRB0bnj/iDYZyQm+WSsvy79nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e3CySzgK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B83C433F1;
	Wed, 21 Feb 2024 13:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708522948;
	bh=+5vmFQhY8GF0xnHnwTK9d2G1V9sqhbCJcnWkq7uH8S0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e3CySzgK+QgKEfUeWUaFG8d22f7aRpdBmmVo96w4Wvp63pahBQf2Uf2KGWrspvUpZ
	 nI9byBCkMSQe3N7L9/3NufnEcw27ffTXxamnVvqErl8vXqD6vjVwlL5XwzBf0qoaNW
	 DJFDa/zv3l+FFFwovl+KoxeLs/hA6VsLX1eIHY7Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ewan Milne <emilne@redhat.com>,
	Ming Lei <ming.lei@redhat.com>,
	Sathya Prakash Veerichetty <safhya.prakash@broadcom.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 271/476] scsi: core: Move scsi_host_busy() out of host lock for waking up EH handler
Date: Wed, 21 Feb 2024 14:05:22 +0100
Message-ID: <20240221130017.991583574@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221130007.738356493@linuxfoundation.org>
References: <20240221130007.738356493@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 4373534a9850627a2695317944898eb1283a2db0 ]

Inside scsi_eh_wakeup(), scsi_host_busy() is called & checked with host
lock every time for deciding if error handler kthread needs to be waken up.

This can be too heavy in case of recovery, such as:

 - N hardware queues

 - queue depth is M for each hardware queue

 - each scsi_host_busy() iterates over (N * M) tag/requests

If recovery is triggered in case that all requests are in-flight, each
scsi_eh_wakeup() is strictly serialized, when scsi_eh_wakeup() is called
for the last in-flight request, scsi_host_busy() has been run for (N * M -
1) times, and request has been iterated for (N*M - 1) * (N * M) times.

If both N and M are big enough, hard lockup can be triggered on acquiring
host lock, and it is observed on mpi3mr(128 hw queues, queue depth 8169).

Fix the issue by calling scsi_host_busy() outside the host lock. We don't
need the host lock for getting busy count because host the lock never
covers that.

[mkp: Drop unnecessary 'busy' variables pointed out by Bart]

Cc: Ewan Milne <emilne@redhat.com>
Fixes: 6eb045e092ef ("scsi: core: avoid host-wide host_busy counter for scsi_mq")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20240112070000.4161982-1-ming.lei@redhat.com
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Reviewed-by: Sathya Prakash Veerichetty <safhya.prakash@broadcom.com>
Tested-by: Sathya Prakash Veerichetty <safhya.prakash@broadcom.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/scsi_error.c | 8 ++++----
 drivers/scsi/scsi_lib.c   | 2 +-
 drivers/scsi/scsi_priv.h  | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index f79cfd1cb3e7..ffd3d8df3d82 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -61,11 +61,11 @@ static int scsi_eh_try_stu(struct scsi_cmnd *scmd);
 static enum scsi_disposition scsi_try_to_abort_cmd(struct scsi_host_template *,
 						   struct scsi_cmnd *);
 
-void scsi_eh_wakeup(struct Scsi_Host *shost)
+void scsi_eh_wakeup(struct Scsi_Host *shost, unsigned int busy)
 {
 	lockdep_assert_held(shost->host_lock);
 
-	if (scsi_host_busy(shost) == shost->host_failed) {
+	if (busy == shost->host_failed) {
 		trace_scsi_eh_wakeup(shost);
 		wake_up_process(shost->ehandler);
 		SCSI_LOG_ERROR_RECOVERY(5, shost_printk(KERN_INFO, shost,
@@ -88,7 +88,7 @@ void scsi_schedule_eh(struct Scsi_Host *shost)
 	if (scsi_host_set_state(shost, SHOST_RECOVERY) == 0 ||
 	    scsi_host_set_state(shost, SHOST_CANCEL_RECOVERY) == 0) {
 		shost->host_eh_scheduled++;
-		scsi_eh_wakeup(shost);
+		scsi_eh_wakeup(shost, scsi_host_busy(shost));
 	}
 
 	spin_unlock_irqrestore(shost->host_lock, flags);
@@ -280,7 +280,7 @@ static void scsi_eh_inc_host_failed(struct rcu_head *head)
 
 	spin_lock_irqsave(shost->host_lock, flags);
 	shost->host_failed++;
-	scsi_eh_wakeup(shost);
+	scsi_eh_wakeup(shost, scsi_host_busy(shost));
 	spin_unlock_irqrestore(shost->host_lock, flags);
 }
 
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 3dbfd15e6fe7..e9ab87335115 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -283,7 +283,7 @@ static void scsi_dec_host_busy(struct Scsi_Host *shost, struct scsi_cmnd *cmd)
 	if (unlikely(scsi_host_in_recovery(shost))) {
 		spin_lock_irqsave(shost->host_lock, flags);
 		if (shost->host_failed || shost->host_eh_scheduled)
-			scsi_eh_wakeup(shost);
+			scsi_eh_wakeup(shost, scsi_host_busy(shost));
 		spin_unlock_irqrestore(shost->host_lock, flags);
 	}
 	rcu_read_unlock();
diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index b7f963149352..b650407690a8 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -76,7 +76,7 @@ extern void scmd_eh_abort_handler(struct work_struct *work);
 extern enum blk_eh_timer_return scsi_times_out(struct request *req);
 extern int scsi_error_handler(void *host);
 extern enum scsi_disposition scsi_decide_disposition(struct scsi_cmnd *cmd);
-extern void scsi_eh_wakeup(struct Scsi_Host *shost);
+extern void scsi_eh_wakeup(struct Scsi_Host *shost, unsigned int busy);
 extern void scsi_eh_scmd_add(struct scsi_cmnd *);
 void scsi_eh_ready_devs(struct Scsi_Host *shost,
 			struct list_head *work_q,
-- 
2.43.0




