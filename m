Return-Path: <stable+bounces-225724-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iH7vLDWfuGnIggEAu9opvQ
	(envelope-from <stable+bounces-225724-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 01:24:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D83B2A23F8
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 01:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67F21301D05B
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 00:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B3A35972;
	Tue, 17 Mar 2026 00:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="Z65J/hZO"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D69A24B28
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 00:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773707048; cv=none; b=Xr+yn7B4ARvKXMMOjZHKTERp4KM8ZUiz6mkOoFamzMpMu66V7fGPZfF1BhmOFdd6MX74v6CLEe8uOYZrBaV1oycxgpxK5e5R/jkYZDwSwMr9pulvda4BOaz/xHP2Xn8zev2ytX9+ai9C8HC+3x5PrLB1cA5ORK4RG5zV41aQq0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773707048; c=relaxed/simple;
	bh=6IRs8tlqiAf4ieBRKO7C5hhLcs5yHFDoucg9tQ3elOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SfDZ25MG0O7gxnWWQ7pYt10ZNIgI4hEs2zLUIEIPN9IU6GV6GV1Ma7w2YhZn4tgqXEIvR8cI5CJbPr4llEBHkxB/kmEf6GsmoAG5KjAavbP48tWjsAvWfICW4vn7KHuYn95YKumtLIRTbt54cGFLDOIOD2AyV8NjWvu8//+yQh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=Z65J/hZO; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cd79e43da3so541668285a.1
        for <stable@vger.kernel.org>; Mon, 16 Mar 2026 17:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1773707046; x=1774311846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tpTXvukljXQ4iNyJC/zaPdjtYHdHgquyGmKXKgxE1Rs=;
        b=Z65J/hZOi7ZtqNfTpn6MIWXfnWXYT98KAARPzKZ/Db/wBKxfDy8qv3+3ou90OMP3hJ
         gZZzSGJfX3vMb09quwzZyOmdq8+pt0gDdpOHrS3e33T1hEH6iFG+15FlN/m1dbA/04Do
         gBPINl9A22CGnOA8bCbaYZf6Pu8pnvnQJ6HEklD+rR7LITfILG4fdLKydvFojj/OtVAS
         vdiL9qYoVhEfQVhMWQHVWheCYtMkt9pVhZO2UJW4T8Tq3iMwmPnWbmKrNk7svfg9ZTnp
         gc+fzhaiVFuuUzqdd4aK50FB1AknodCRWX+v+tHmQ2xlFPIkmdlL0pGef3aOyODup0kR
         nssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773707046; x=1774311846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpTXvukljXQ4iNyJC/zaPdjtYHdHgquyGmKXKgxE1Rs=;
        b=NtY9rNSwbLOc4nrDsZ8zje2gkbUPG0X23H15ZWVN1e8ST5lDvgcx1WLKG6O6K01+pM
         0qtWwLqSOOTUkavC6S8tkOhRXHzy6UWpQ2HhzLkBj7V1VXYP6cEAiUincwaaQRR8vYA+
         sm3OrGMh83hkonZfEkBQ+GALPMhsYsvIMUFaENgLCItDbKWGYrqd/wCcPExlAQQ+sU7V
         DlYulLwozt3F7M3b9K5rK49UlzNbf08s4cdT5les+umQiry2bM+LF82WLGoJT/sUgIRZ
         K+iW9OLTtKRDvoLkhvIH3GoVohf1CqJL46xjY2Zlz7RZyQhuAlSPcu9x06FSMu2z/WDc
         XO+g==
X-Gm-Message-State: AOJu0YzKJ5v38vq7s5lhdjvOeRDnJA03vvA4kxCrBPp5IrTAsmX0etww
	1HT+5RS02dYE5v3nZMUB/61sAhknWWLdo5dbVxPydR6oNLdXLqrd24FTjLgMSRqsZhU=
X-Gm-Gg: ATEYQzyLQ7Df/BiuEbsIj3Uyx3kZ8sQ+n4vnD9Yihy8X1d/IwS8VPaBzwCz4EY2pUkL
	OG6uL0GOeIYxemfimqHoti98/3IxaxkifQhscday3mEn5vSp8xPJUULhP494Q3oTmATg0DgQbWc
	MrIHK8m88c8xKq15gK2jgLJhAMCOMpCtf7pMboyDEmyRiiPQVHjBMOUcJfMxTHCWGnQZW8PwoE9
	djcx7Uc78EkI5/2uIIMo8xkjFYitdF7lbbxJuHU5PYtnaJY0RyeNskbd9ym6gH5dCYlGZ1QDgpV
	x8lHq3sCCuTloRbRaqvkgpOrbw0GcpYZdRq6Idr7W6ePHFTKwBiR5DkDuhD0qCG/PcRj9Uy6RGI
	xbtYSoTRnaGUHwuh7T69fkJPO+Jr9DZH+U7hhHg5jrSSocRv5+Q+z8H/wB40pnfNRYEV5vPuguj
	Y0G4wjv8oToqyIsRrPJkncG+INhA==
X-Received: by 2002:a05:620a:294a:b0:8ca:3d7c:e74a with SMTP id af79cd13be357-8cdb5b6eef9mr1894858485a.56.1773707045762;
        Mon, 16 Mar 2026 17:24:05 -0700 (PDT)
Received: from localhost ([2603:6080:7702:ce00:96ef:dc7e:bb84:bc5a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda211518esm1384850785a.27.2026.03.16.17.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 17:24:05 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] scsi: target: tcm_loop: drain commands in target_reset handler
Date: Mon, 16 Mar 2026 20:23:29 -0400
Message-ID: <27011aa34c8f6b1b94d2e3cf5655b6d037f53428.1773706803.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[toxicpanda.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[toxicpanda.com];
	TAGGED_FROM(0.00)[bounces-225724-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[toxicpanda.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josef@toxicpanda.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toxicpanda.com:dkim,toxicpanda.com:email,toxicpanda.com:mid]
X-Rspamd-Queue-Id: 1D83B2A23F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tcm_loop_target_reset() violates the SCSI EH contract: it returns
SUCCESS without draining any in-flight commands.  The SCSI EH
documentation (scsi_eh.rst) requires that when a reset handler returns
SUCCESS the driver has made lower layers "forget about timed out scmds"
and is ready for new commands.  Every other SCSI LLD (virtio_scsi,
mpt3sas, ipr, scsi_debug, mpi3mr) enforces this by draining or
completing outstanding commands before returning SUCCESS.

Because tcm_loop_target_reset() doesn't drain, the SCSI EH reuses
in-flight scsi_cmnd structures for recovery commands (e.g. TUR) while
the target core still has async completion work queued for the old
se_cmd.  The memset in queuecommand zeroes se_lun and lun_ref_active,
causing transport_lun_remove_cmd() to skip its percpu_ref_put().  The
leaked LUN reference prevents transport_clear_lun_ref() from
completing, hanging configfs LUN unlink forever in D-state:

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

1. Issue TMR_LUN_RESET via tcm_loop_issue_tmr() to drain all commands
   that the target core knows about (those not yet CMD_T_COMPLETE).

2. Use blk_mq_tagset_busy_iter() to iterate all started requests and
   flush_work() on each se_cmd — this drains any deferred completion
   work for commands that already had CMD_T_COMPLETE set before the
   TMR (which the TMR skips via __target_check_io_state()).  This is
   the same pattern used by mpi3mr, scsi_debug, and libsas to drain
   outstanding commands during reset.

Fixes: e0eb5d38b732 ("scsi: target: tcm_loop: Use block cmd allocator for se_cmds")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
- I have a reproducer for this that you can run if you'd like, but it's Claude
  generated so it's a bit special, but definitely triggers the issue every time
  and this patch resolved it. We're hitting it in production quite a bit.

 drivers/target/loopback/tcm_loop.c | 52 ++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/target/loopback/tcm_loop.c b/drivers/target/loopback/tcm_loop.c
index d668bd19fd4a..528883d989b8 100644
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
@@ -269,15 +270,27 @@ static int tcm_loop_device_reset(struct scsi_cmnd *sc)
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
@@ -286,11 +299,38 @@ static int tcm_loop_target_reset(struct scsi_cmnd *sc)
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


