Return-Path: <stable+bounces-237481-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EBCAFQl3WlcaQkAu9opvQ
	(envelope-from <stable+bounces-237481-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:18:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1189D3F1224
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A1C14301F27E
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511EB326D44;
	Mon, 13 Apr 2026 16:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yoxq7NoF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BFE3203B6;
	Mon, 13 Apr 2026 16:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099568; cv=none; b=Q6pWAKC5JWRRhptWKZvDvnE4Gz2a8TM1504nfdI0HWfR/ptuCTJIULxI4Y6iQkXtt3U9tcWdaQtfnhkVfcOlHLPge1TTjPna2zZtIQlq+OTKfV49L548eOnHAVZtgRWhdO+YZANZ2o56uQqFp4Umus2bhAsKpjEoPkZdqANlC0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099568; c=relaxed/simple;
	bh=+S+qCoUBjQGErdO6QVEWqbM3nYgo5VvshJiyDKF65fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NuPRO8IxEttd5sHFyT632t1jnhxqY9MRByoCsvwmCPpDDSktdYPDUvbW58DOL+P/GTVpM88FLNS06Gn1Xti4Tua4JJn8UTkjW8POxRiY4N3D1fBqBHPwy2ovrliRGD2OHZiWd38QmEN7V9MfRVbi+Y5fKm+VjB1L+qofZqwxmqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yoxq7NoF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7DDC2BCAF;
	Mon, 13 Apr 2026 16:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099565;
	bh=+S+qCoUBjQGErdO6QVEWqbM3nYgo5VvshJiyDKF65fw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yoxq7NoFqg3ARB8Vbh3DsY+CVQj3CMYchcrXlKxlxWFL4lytiuckFab6uImGDnTJP
	 Wlpdjr1zfRZqp0OKANU2/X+5L/iQ/6Yza5aPM42HoLQh63Uc5hZyOGLF0ydjAta8HM
	 ED7aDEzkr8i8sj7VvVH7COOql5ZMGxIbDHvMpmIo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 357/491] Revert "scsi: core: Wake up the error handler when final completions race against each other"
Date: Mon, 13 Apr 2026 18:00:02 +0200
Message-ID: <20260413155832.402764140@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237481-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1189D3F1224
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

This reverts commit cc872e35c0df80062abc71268d690a2f749e542e.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/scsi_error.c | 11 +----------
 drivers/scsi/scsi_lib.c   |  8 --------
 2 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 4e9114f069832..ffc6f3031e82b 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -241,20 +241,11 @@ static void scsi_eh_inc_host_failed(struct rcu_head *head)
 {
 	struct scsi_cmnd *scmd = container_of(head, typeof(*scmd), rcu);
 	struct Scsi_Host *shost = scmd->device->host;
-	unsigned int busy;
+	unsigned int busy = scsi_host_busy(shost);
 	unsigned long flags;
 
 	spin_lock_irqsave(shost->host_lock, flags);
 	shost->host_failed++;
-	spin_unlock_irqrestore(shost->host_lock, flags);
-	/*
-	 * The counting of busy requests needs to occur after adding to
-	 * host_failed or after the lock acquire for adding to host_failed
-	 * to prevent a race with host unbusy and missing an eh wakeup.
-	 */
-	busy = scsi_host_busy(shost);
-
-	spin_lock_irqsave(shost->host_lock, flags);
 	scsi_eh_wakeup(shost, busy);
 	spin_unlock_irqrestore(shost->host_lock, flags);
 }
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 8d570632982f3..fb48d47e9183e 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -310,14 +310,6 @@ static void scsi_dec_host_busy(struct Scsi_Host *shost, struct scsi_cmnd *cmd)
 	rcu_read_lock();
 	__clear_bit(SCMD_STATE_INFLIGHT, &cmd->state);
 	if (unlikely(scsi_host_in_recovery(shost))) {
-		/*
-		 * Ensure the clear of SCMD_STATE_INFLIGHT is visible to
-		 * other CPUs before counting busy requests. Otherwise,
-		 * reordering can cause CPUs to race and miss an eh wakeup
-		 * when no CPU sees all busy requests as done or timed out.
-		 */
-		smp_mb();
-
 		unsigned int busy = scsi_host_busy(shost);
 
 		spin_lock_irqsave(shost->host_lock, flags);
-- 
2.53.0




