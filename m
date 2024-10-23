Return-Path: <stable+bounces-87818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C959AC84B
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 12:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15D41281D6D
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 10:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3151A2C29;
	Wed, 23 Oct 2024 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXIO8vPh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0AC1BDDF;
	Wed, 23 Oct 2024 10:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729680962; cv=none; b=DLQAn68WsavngjlMYjzH4gh/WOho9t0hQphp4HhGFtK+qBjObv/vwVgROmpf2OFXSuZh/s9fSh5ihNjxjsgGBiZKGlPIS0qC9s2Tvk4x636gYnN8b0tyGGaL1AWY2EXdgR42EEoRu3u8/DUDcXnp6w5IyrE4rSeddGEo5lYXeZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729680962; c=relaxed/simple;
	bh=fC2catyz7cbZkwaC1w48J9i0xFFtTIHz/wPLMMNszBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jN0+Fwh2fZbgtGPHLBHW/7hGBLl3vyQJrWhC0fUt7QkyBIAHHgsKUI1EvKJR5SLNHDmAMj44GOpwFD7J9c2DshbAeipaRXVzI8h7PMojcGba6PJBZ0eOln1IGC/Dx5+wtVjkdy1VX0zhNh8U0tZqYe33AeTgmo53JBWD8dEiz6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXIO8vPh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20B1C4CEC6;
	Wed, 23 Oct 2024 10:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729680962;
	bh=fC2catyz7cbZkwaC1w48J9i0xFFtTIHz/wPLMMNszBU=;
	h=From:To:Cc:Subject:Date:From;
	b=OXIO8vPhIlxz5TtyZ3G1g/LIJX8FkqTjpzHzcQVTMZRMazPvywqHCiNRUVIMy3C8v
	 /nKpTc5+iVzWEdcdP4joDe4Kydyq2UBMnj+EnczoiKUYNGnvWdieYt4zqc20yAuaId
	 fp/n/hMNxmGHW73fnPB7tqLPVMVyCdge++FAA/JZoFruQ7rs2dVIdZX3vcuciuyTgS
	 S/2h2ZJBh5y00SdANwnXUy9wbMLxfQN+GCSf6kKALks5X9u40e+/v41xV7Fo1mjD34
	 O8HRvCMq3UfHnz7/QEeQav2Rf2GSxfW0ZEBqcXR28lG40+1pXUI7ai7hxq3WegCDAu
	 CNWj6msFEoQxQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Hannes Reinecke <hare@suse.de>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	Igor Pylypiv <ipylypiv@google.com>,
	stable@vger.kernel.org,
	"Lai, Yi" <yi1.lai@linux.intel.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH] ata: libata: Set DID_TIME_OUT for commands that actually timed out
Date: Wed, 23 Oct 2024 12:55:41 +0200
Message-ID: <20241023105540.1070012-2-cassel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2839; i=cassel@kernel.org; h=from:subject; bh=fC2catyz7cbZkwaC1w48J9i0xFFtTIHz/wPLMMNszBU=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNIlrumc2XL5YEaE5ONTD39GVMuHzQ9NbnaVDj1xd1pC2 D+DmfmaHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZjI235GhvNhxVNeLewRbP5s qWr/f1oN99Uj17/M003cFHx0VmfpwzhGhlt7P7wUmM4UcfDKtcXrVv7ot5jMMjevL+64xtruvb+ +sLABAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

When ata_qc_complete() schedules a command for EH using
ata_qc_schedule_eh(), blk_abort_request() will be called, which leads to
req->q->mq_ops->timeout() / scsi_timeout() being called.

scsi_timeout(), if the LLDD has no abort handler (libata has no abort
handler), will set host byte to DID_TIME_OUT, and then call
scsi_eh_scmd_add() to add the command to EH.

Thus, when commands first enter libata's EH strategy_handler, all the
commands that have been added to EH will have DID_TIME_OUT set.

Commit e5dd410acb34 ("ata: libata: Clear DID_TIME_OUT for ATA PT commands
with sense data") clears this bogus DID_TIME_OUT flag for all commands
that reached libata's EH strategy_handler.

libata has its own flag (AC_ERR_TIMEOUT), that it sets for commands that
have not received a completion at the time of entering EH.

ata_eh_worth_retry() has no special handling for AC_ERR_TIMEOUT, so by
default timed out commands will get flag ATA_QCFLAG_RETRY set and will be
retried after the port has been reset (ata_eh_link_autopsy() always
triggers a port reset if any command has AC_ERR_TIMEOUT set).

For commands that have ATA_QCFLAG_RETRY set, but also has an error flag
set (e.g. AC_ERR_TIMEOUT), ata_eh_finish() will not increment
scmd->allowed, so the command will at most be retried (scmd->allowed
number of times, which by default is set to 3).

However, scsi_eh_flush_done_q() will only retry commands for which
scsi_noretry_cmd() returns false.

For commands that has DID_TIME_OUT set, if the command is either
has FAILFAST or if the command is a passthrough command, scsi_noretry_cmd()
will return true. Thus, such commands will never be retried.

Thus, make sure that libata sets SCSI's DID_TIME_OUT flag for commands that
actually timed out (libata's AC_ERR_TIMEOUT flag), such that timed out
commands will once again not be retried if they are also a FAILFAST or
passthrough command.

Cc: stable@vger.kernel.org
Fixes: e5dd410acb34 ("ata: libata: Clear DID_TIME_OUT for ATA PT commands with sense data")
Reported-by: Lai, Yi <yi1.lai@linux.intel.com>
Closes: https://lore.kernel.org/linux-ide/ZxYz871I3Blsi30F@ly-workstation/
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-eh.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index fa41ea57a978..3b303d4ae37a 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -651,6 +651,7 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
 			/* the scmd has an associated qc */
 			if (!(qc->flags & ATA_QCFLAG_EH)) {
 				/* which hasn't failed yet, timeout */
+				set_host_byte(scmd, DID_TIME_OUT);
 				qc->err_mask |= AC_ERR_TIMEOUT;
 				qc->flags |= ATA_QCFLAG_EH;
 				nr_timedout++;
-- 
2.47.0


