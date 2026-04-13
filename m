Return-Path: <stable+bounces-237448-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GN8FJqwh3WndaAkAu9opvQ
	(envelope-from <stable+bounces-237448-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:02:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 610BF3F0908
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 68EF53059B36
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F4D3271EA;
	Mon, 13 Apr 2026 16:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sfGMWMRv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D703290A1;
	Mon, 13 Apr 2026 16:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099483; cv=none; b=U4BPYe9ZUK7JSssILK4KzfmR5Uv2zJJas8+JQpdHv9OD3B1eZ6JiHdeZEJmU2H8z0fhR+TaUxR19mromrdxjjS94KE34yXGF+CGFDxkuRERpgGYG+A353HUpvyciEabOapv5IN+yn0BcmyO+NrxvccjO8bvG3hUZmlc7502mZRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099483; c=relaxed/simple;
	bh=gYaGR39Vw+/2ELSXM6FRNTHcL8M1I7w2jms+79OlIyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ieiXcjZLHOikdqJJNYo/DSZj+zDyp7q+DaYO+bicMI80yhwXhimMWVg0Yj/RiNmGsLLKNXTYKVTTdjO2cPI903JHfBG0knMiXRinlEgC0zAfILt4ktsBgVRMf3FH0MYjsN+NBJ025FmLCJN3jEI3QZsxkSsoemtCRYUXBr0np2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sfGMWMRv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1B9C2BCAF;
	Mon, 13 Apr 2026 16:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099483;
	bh=gYaGR39Vw+/2ELSXM6FRNTHcL8M1I7w2jms+79OlIyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sfGMWMRvNZJ56igKUxgfhRDqxDWIYQ7o5BUIzsfOxjmgCyK7a333uR+4vMCaLjElF
	 +UIwPMyClOInM1lcQMYHztm9K+fen9kSr/b577+enHd+OAFU30L+kWOOSKzvUHKuSl
	 2nzDFdfdWxVtErEiQ8pKN4BVnKn4ZXSFYnhn+hlY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Jeffery <djeffery@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 358/491] scsi: core: Wake up the error handler when final completions race against each other
Date: Mon, 13 Apr 2026 18:00:03 +0200
Message-ID: <20260413155832.439449178@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237448-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:email,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 610BF3F0908
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Jeffery <djeffery@redhat.com>

[ Upstream commit fe2f8ad6f0999db3b318359a01ee0108c703a8c3 ]

The fragile ordering between marking commands completed or failed so
that the error handler only wakes when the last running command
completes or times out has race conditions. These race conditions can
cause the SCSI layer to fail to wake the error handler, leaving I/O
through the SCSI host stuck as the error state cannot advance.

First, there is an memory ordering issue within scsi_dec_host_busy().
The write which clears SCMD_STATE_INFLIGHT may be reordered with reads
counting in scsi_host_busy(). While the local CPU will see its own
write, reordering can allow other CPUs in scsi_dec_host_busy() or
scsi_eh_inc_host_failed() to see a raised busy count, causing no CPU to
see a host busy equal to the host_failed count.

This race condition can be prevented with a memory barrier on the error
path to force the write to be visible before counting host busy
commands.

Second, there is a general ordering issue with scsi_eh_inc_host_failed(). By
counting busy commands before incrementing host_failed, it can race with a
final command in scsi_dec_host_busy(), such that scsi_dec_host_busy() does
not see host_failed incremented but scsi_eh_inc_host_failed() counts busy
commands before SCMD_STATE_INFLIGHT is cleared by scsi_dec_host_busy(),
resulting in neither waking the error handler task.

This needs the call to scsi_host_busy() to be moved after host_failed is
incremented to close the race condition.

Fixes: 6eb045e092ef ("scsi: core: avoid host-wide host_busy counter for scsi_mq")
Signed-off-by: David Jeffery <djeffery@redhat.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://patch.msgid.link/20260113161036.6730-1-djeffery@redhat.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/scsi_error.c | 11 ++++++++++-
 drivers/scsi/scsi_lib.c   | 11 ++++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index ffc6f3031e82b..4e9114f069832 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -241,11 +241,20 @@ static void scsi_eh_inc_host_failed(struct rcu_head *head)
 {
 	struct scsi_cmnd *scmd = container_of(head, typeof(*scmd), rcu);
 	struct Scsi_Host *shost = scmd->device->host;
-	unsigned int busy = scsi_host_busy(shost);
+	unsigned int busy;
 	unsigned long flags;
 
 	spin_lock_irqsave(shost->host_lock, flags);
 	shost->host_failed++;
+	spin_unlock_irqrestore(shost->host_lock, flags);
+	/*
+	 * The counting of busy requests needs to occur after adding to
+	 * host_failed or after the lock acquire for adding to host_failed
+	 * to prevent a race with host unbusy and missing an eh wakeup.
+	 */
+	busy = scsi_host_busy(shost);
+
+	spin_lock_irqsave(shost->host_lock, flags);
 	scsi_eh_wakeup(shost, busy);
 	spin_unlock_irqrestore(shost->host_lock, flags);
 }
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index fb48d47e9183e..e69d1c0ea4507 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -310,7 +310,16 @@ static void scsi_dec_host_busy(struct Scsi_Host *shost, struct scsi_cmnd *cmd)
 	rcu_read_lock();
 	__clear_bit(SCMD_STATE_INFLIGHT, &cmd->state);
 	if (unlikely(scsi_host_in_recovery(shost))) {
-		unsigned int busy = scsi_host_busy(shost);
+		unsigned int busy;
+		/*
+		 * Ensure the clear of SCMD_STATE_INFLIGHT is visible to
+		 * other CPUs before counting busy requests. Otherwise,
+		 * reordering can cause CPUs to race and miss an eh wakeup
+		 * when no CPU sees all busy requests as done or timed out.
+		 */
+		smp_mb();
+
+		busy = scsi_host_busy(shost);
 
 		spin_lock_irqsave(shost->host_lock, flags);
 		if (shost->host_failed || shost->host_eh_scheduled)
-- 
2.53.0




