Return-Path: <stable+bounces-231435-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uB8UCjXby2lHMAYAu9opvQ
	(envelope-from <stable+bounces-231435-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:33:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA20A36B059
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51451304023F
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 14:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C513FB7D3;
	Tue, 31 Mar 2026 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jy2z2PY+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1D53FB7D6
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 14:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774967492; cv=none; b=ERM1WPhYyFoDgv78lG95zXr4bnc3pshUJTBwJZsQ5+EUDiDp2zsO0oQDhUSNHSU+TJJ+39o0KIg0/EqYlG/hOSEf7quCj79xHsX9sbeD+C7bx6M7oPoY0Btd3HrOsSZnhzPsmwzTiQP2/+VdeGWE/DQbmESaEOvoB96MY7YqPlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774967492; c=relaxed/simple;
	bh=vtMeWO1wnH9OBnXZkkGK63LtEHGZBKYWVPd+4AvWkTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TwMheVg3Ml2CqFr+CgoSRq7jnkm69SmTRSi6kTKlctBzYwwGLusG4YmEoSmRSeslw4n/xLmJ8ezJKBeSF0oOua29bOMnK2JB/71/i5vRZGYbSpELLzxaFl3Hu6Z/3hAUn8EC9/u5Wl3qnnsde3hknLPDoBZu7EiiFXiORQBNzBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jy2z2PY+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BADC2BCB1;
	Tue, 31 Mar 2026 14:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774967492;
	bh=vtMeWO1wnH9OBnXZkkGK63LtEHGZBKYWVPd+4AvWkTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jy2z2PY+ZAr0oRFmSnkmWFdDaVVZRmrs+XR/Gl5/+W1G959oo71a8WQ6p/1YCz2wm
	 rmvPrbMkhOoxbx0Z2o/Ll/CaXBJ2HEArAd+fQczu72/sosfqKGwXDn/bfbVc5v/z/6
	 QATkHUS8k+W6k/50DFFGoLG4glkqb+1YKS0BvEmyIg3MX8Kp14D1/Dhz7uY1iuHC7x
	 wHS8MbA6J1jrVVYSi1ZhkKbHNxwSQso49/qEBmvKVlOTA/MV9IvDfZs6gGOWC8nlGj
	 zgzMe8crmFGtbUncGNtlu+afIMM+0c17XDIEKwOiXB0USKpPpZ3FqfltHz8/EB9bPX
	 KoFt3UIT90Xvw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19.y] scsi: target: tcm_loop: Drain commands in target_reset handler
Date: Tue, 31 Mar 2026 10:31:29 -0400
Message-ID: <20260331143129.2479621-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026033009-gusty-fax-ff6f@gregkh>
References: <2026033009-gusty-fax-ff6f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231435-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[stable.vger.kernel.org:query timed out];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,toxicpanda.com:email]
X-Rspamd-Queue-Id: CA20A36B059
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 1333eee56cdf3f0cf67c6ab4114c2c9e0a952026 ]

tcm_loop_target_reset() violates the SCSI EH contract: it returns SUCCESS
without draining any in-flight commands.  The SCSI EH documentation
(scsi_eh.rst) requires that when a reset handler returns SUCCESS the driver
has made lower layers "forget about timed out scmds" and is ready for new
commands.  Every other SCSI LLD (virtio_scsi, mpt3sas, ipr, scsi_debug,
mpi3mr) enforces this by draining or completing outstanding commands before
returning SUCCESS.

Because tcm_loop_target_reset() doesn't drain, the SCSI EH reuses in-flight
scsi_cmnd structures for recovery commands (e.g. TUR) while the target core
still has async completion work queued for the old se_cmd.  The memset in
queuecommand zeroes se_lun and lun_ref_active, causing
transport_lun_remove_cmd() to skip its percpu_ref_put().  The leaked LUN
reference prevents transport_clear_lun_ref() from completing, hanging
configfs LUN unlink forever in D-state:

  INFO: task rm:264 blocked for more than 122 seconds.
  rm              D    0   264    258 0x00004000
  Call Trace:
   __schedule+0x3d0/0x8e0
   schedule+0x36/0xf0
   transport_clear_lun_ref+0x78/0x90 [target_core_mod]
   core_tpg_remove_lun+0x28/0xb0 [target_core_mod]
   target_fabric_port_unlink+0x50/0x60 [target_core_mod]
   configfs_unlink+0x156/0x1f0 [configfs]
   vfs_unlink+0x109/0x290
   do_unlinkat+0x1d5/0x2d0

Fix this by making tcm_loop_target_reset() actually drain commands:

 1. Issue TMR_LUN_RESET via tcm_loop_issue_tmr() to drain all commands that
    the target core knows about (those not yet CMD_T_COMPLETE).

 2. Use blk_mq_tagset_busy_iter() to iterate all started requests and
    flush_work() on each se_cmd — this drains any deferred completion work
    for commands that already had CMD_T_COMPLETE set before the TMR (which
    the TMR skips via __target_check_io_state()).  This is the same pattern
    used by mpi3mr, scsi_debug, and libsas to drain outstanding commands
    during reset.

Fixes: e0eb5d38b732 ("scsi: target: tcm_loop: Use block cmd allocator for se_cmds")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Link: https://patch.msgid.link/27011aa34c8f6b1b94d2e3cf5655b6d037f53428.1773706803.git.josef@toxicpanda.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/loopback/tcm_loop.c | 52 ++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/target/loopback/tcm_loop.c b/drivers/target/loopback/tcm_loop.c
index 01a8e349dc4d1..156f934049f19 100644
--- a/drivers/target/loopback/tcm_loop.c
+++ b/drivers/target/loopback/tcm_loop.c
@@ -26,6 +26,7 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/configfs.h>
+#include <linux/blk-mq.h>
 #include <scsi/scsi.h>
 #include <scsi/scsi_tcq.h>
 #include <scsi/scsi_host.h>
@@ -268,15 +269,27 @@ static int tcm_loop_device_reset(struct scsi_cmnd *sc)
 	return (ret == TMR_FUNCTION_COMPLETE) ? SUCCESS : FAILED;
 }
 
+static bool tcm_loop_flush_work_iter(struct request *rq, void *data)
+{
+	struct scsi_cmnd *sc = blk_mq_rq_to_pdu(rq);
+	struct tcm_loop_cmd *tl_cmd = scsi_cmd_priv(sc);
+	struct se_cmd *se_cmd = &tl_cmd->tl_se_cmd;
+
+	flush_work(&se_cmd->work);
+	return true;
+}
+
 static int tcm_loop_target_reset(struct scsi_cmnd *sc)
 {
 	struct tcm_loop_hba *tl_hba;
 	struct tcm_loop_tpg *tl_tpg;
+	struct Scsi_Host *sh = sc->device->host;
+	int ret;
 
 	/*
 	 * Locate the tcm_loop_hba_t pointer
 	 */
-	tl_hba = *(struct tcm_loop_hba **)shost_priv(sc->device->host);
+	tl_hba = *(struct tcm_loop_hba **)shost_priv(sh);
 	if (!tl_hba) {
 		pr_err("Unable to perform device reset without active I_T Nexus\n");
 		return FAILED;
@@ -285,11 +298,38 @@ static int tcm_loop_target_reset(struct scsi_cmnd *sc)
 	 * Locate the tl_tpg pointer from TargetID in sc->device->id
 	 */
 	tl_tpg = &tl_hba->tl_hba_tpgs[sc->device->id];
-	if (tl_tpg) {
-		tl_tpg->tl_transport_status = TCM_TRANSPORT_ONLINE;
-		return SUCCESS;
-	}
-	return FAILED;
+	if (!tl_tpg)
+		return FAILED;
+
+	/*
+	 * Issue a LUN_RESET to drain all commands that the target core
+	 * knows about.  This handles commands not yet marked CMD_T_COMPLETE.
+	 */
+	ret = tcm_loop_issue_tmr(tl_tpg, sc->device->lun, 0, TMR_LUN_RESET);
+	if (ret != TMR_FUNCTION_COMPLETE)
+		return FAILED;
+
+	/*
+	 * Flush any deferred target core completion work that may still be
+	 * queued.  Commands that already had CMD_T_COMPLETE set before the TMR
+	 * are skipped by the TMR drain, but their async completion work
+	 * (transport_lun_remove_cmd → percpu_ref_put, release_cmd → scsi_done)
+	 * may still be pending in target_completion_wq.
+	 *
+	 * The SCSI EH will reuse in-flight scsi_cmnd structures for recovery
+	 * commands (e.g. TUR) immediately after this handler returns SUCCESS —
+	 * if deferred work is still pending, the memset in queuecommand would
+	 * zero the se_cmd while the work accesses it, leaking the LUN
+	 * percpu_ref and hanging configfs unlink forever.
+	 *
+	 * Use blk_mq_tagset_busy_iter() to find all started requests and
+	 * flush_work() on each — the same pattern used by mpi3mr, scsi_debug,
+	 * and other SCSI drivers to drain outstanding commands during reset.
+	 */
+	blk_mq_tagset_busy_iter(&sh->tag_set, tcm_loop_flush_work_iter, NULL);
+
+	tl_tpg->tl_transport_status = TCM_TRANSPORT_ONLINE;
+	return SUCCESS;
 }
 
 static const struct scsi_host_template tcm_loop_driver_template = {
-- 
2.53.0


