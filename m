Return-Path: <stable+bounces-225205-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMe/GsAjs2nMSgAAu9opvQ
	(envelope-from <stable+bounces-225205-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:36:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFAE279518
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EF1732A9A39
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8933803EF;
	Thu, 12 Mar 2026 20:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mcJq3mlY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18533783BD;
	Thu, 12 Mar 2026 20:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347352; cv=none; b=HYaUM/lAIc4kgRn7mYzZ5cLidv0pavr8JesMKIl3HvH5As52rQFKwiSGQWnfk8eLcJf95i728ijpmMBmTwKlJGieLgiizP6qw7R3zCCcX1a1Q1zke3OzCa/2fXtwrfJCC9gHluinxx3Uv2E8Ch3iBySMQqyBZwUQ60cvn65HnrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347352; c=relaxed/simple;
	bh=6zFi47qk76G4k1ca1eAb9tZVFmgg6QcN8EssFUI+pIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dOdE3LAZFIsS8BhZwS+GhGrr6kQdWPxDgHF2CI0ijaLXEsIbpLd4bWfwZbHSGv4FUr6J82UH8dxrEsonkp94tPDmeei0GtaS6tHZvQETzUORQ9Wi+p5Had8Pk6alVjngdPM+2DyGLsTqTIMUkZi1MS7O3I0I8IkuCSLz14Dz98I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mcJq3mlY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36261C4CEF7;
	Thu, 12 Mar 2026 20:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773347352;
	bh=6zFi47qk76G4k1ca1eAb9tZVFmgg6QcN8EssFUI+pIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mcJq3mlY9tWG3xkA49R5BxI9rU3Ch7FxTR6mmhqJzhbv1K29T/LIr/I3ATkx4LN9K
	 nBSciBEfbB53CI6YDrSlrG6c5Mh+VrxzX6A7oX55o214WcLd/fggZC5pziNOzcO1Z5
	 8KOMkR9mOpjpA8c1PSTgltPScmaPc6l7XaeoMp2w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Igor Pylypiv <ipylypiv@google.com>
Subject: [PATCH 6.12 262/265] ata: libata-core: fix cancellation of a port deferred qc work
Date: Thu, 12 Mar 2026 21:10:49 +0100
Message-ID: <20260312201027.815009788@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312201018.128816016@linuxfoundation.org>
References: <20260312201018.128816016@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-225205-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: CAFAE279518
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Damien Le Moal <dlemoal@kernel.org>

commit 55db009926634b20955bd8abbee921adbc8d2cb4 upstream.

cancel_work_sync() is a sleeping function so it cannot be called with
the spin lock of a port being held. Move the call to this function in
ata_port_detach() after EH completes, with the port lock released,
together with other work cancellation calls.

Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Igor Pylypiv <ipylypiv@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ata/libata-core.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6132,10 +6132,6 @@ static void ata_port_detach(struct ata_p
 		}
 	}
 
-	/* Make sure the deferred qc work finished. */
-	cancel_work_sync(&ap->deferred_qc_work);
-	WARN_ON(ap->deferred_qc);
-
 	/* Tell EH to disable all devices */
 	ap->pflags |= ATA_PFLAG_UNLOADING;
 	ata_port_schedule_eh(ap);
@@ -6146,9 +6142,11 @@ static void ata_port_detach(struct ata_p
 	/* wait till EH commits suicide */
 	ata_port_wait_eh(ap);
 
-	/* it better be dead now */
+	/* It better be dead now and not have any remaining deferred qc. */
 	WARN_ON(!(ap->pflags & ATA_PFLAG_UNLOADED));
+	WARN_ON(ap->deferred_qc);
 
+	cancel_work_sync(&ap->deferred_qc_work);
 	cancel_delayed_work_sync(&ap->hotplug_task);
 	cancel_delayed_work_sync(&ap->scsi_rescan_task);
 



