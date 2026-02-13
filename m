Return-Path: <stable+bounces-216177-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oD22EaQtj2nTLgEAu9opvQ
	(envelope-from <stable+bounces-216177-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:56:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F34136C47
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 860523069D15
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 13:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9E735FF49;
	Fri, 13 Feb 2026 13:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2RZYE701"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AC654723;
	Fri, 13 Feb 2026 13:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770990891; cv=none; b=XRae34e1xqqEizvw9rcuPnNVPmj4hBLq4ZqM0lcLhfyr9xepWUBfWhAkN7MkIylZFzuAS5bWEXNeVi7Mnjs5uQHrHWqVDHG9Ou/+RIe48Jpjv1tczdRJpAW/6HZrB7d3rRryS+5wrXMPAZVaKL+g5FcFtQY+kcnBnAFE/skqQgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770990891; c=relaxed/simple;
	bh=gjlCkz4zcy6LY26eTj6pP61v9iBOkEPA/MSBo6shhNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S8HqvZFp9/uuzZWVpaCFmp3beKeqIYqaY+k/mFso+JIckaxb79y73Je5s7U4mM6zFo3/4l2nGlbmrdP1+TujzLpiX+dFm3immJ5fQQiJZKBZIWFM6ewNQ3uqdsP1KA2nuTR6gsB34+whoH4pxKmdi4LDcwCVb5ECUTiFStfDCSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2RZYE701; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55BFC116C6;
	Fri, 13 Feb 2026 13:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770990891;
	bh=gjlCkz4zcy6LY26eTj6pP61v9iBOkEPA/MSBo6shhNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2RZYE701MmRJtwMar8bzrVBTH1honSJozZjxpTMV7DGyWmjSNx88VadH/erzNwPml
	 Fsk3hmrscms3TlwyMV1IQueDYNy5s0/EBKchEbaXJppgo18rP+wtp4rSmhlZdF7lNA
	 0WFeTYOw1PvI4U8beRPcSqrTCjmal27gvUA/afks=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Anil Gurumurthy <agurumurthy@marvell.com>,
	Nilesh Javali <njavali@marvell.com>,
	Himanshu Madhani <hmadhani2024@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.18 42/49] scsi: qla2xxx: Query FW again before proceeding with login
Date: Fri, 13 Feb 2026 14:48:26 +0100
Message-ID: <20260213134710.406555836@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260213134708.885500854@linuxfoundation.org>
References: <20260213134708.885500854@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216177-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,marvell.com,gmail.com,oracle.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,marvell.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 83F34136C47
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anil Gurumurthy <agurumurthy@marvell.com>

commit 42b2dab4340d39b71334151e10c6d7d9b0040ffa upstream.

Issue occurred during a continuous reboot test of several thousand
iterations specific to a fabric topo with dual mode target where it
sends a PLOGI/PRLI and then sends a LOGO. The initiator was also in the
process of discovery and sent a PLOGI to the switch. It then queried a
list of ports logged in via mbx 75h and the GPDB response indicated that
the target was logged in. This caused a mismatch in the states between
the driver and FW.  Requery the FW for the state and proceed with the
rest of discovery process.

Fixes: a4239945b8ad ("scsi: qla2xxx: Add switch command to simplify fabric discovery")
Cc: stable@vger.kernel.org
Signed-off-by: Anil Gurumurthy <agurumurthy@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Reviewed-by: Himanshu Madhani <hmadhani2024@gmail.com>
Link: https://patch.msgid.link/20251210101604.431868-11-njavali@marvell.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_init.c |   19 +++++++++++++++++--
 drivers/scsi/qla2xxx/qla_isr.c  |   19 +++++++++++++++++--
 2 files changed, 34 insertions(+), 4 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -2462,8 +2462,23 @@ qla24xx_handle_plogi_done_event(struct s
 	    ea->sp->gen1, fcport->rscn_gen,
 	    ea->data[0], ea->data[1], ea->iop[0], ea->iop[1]);
 
-	if ((fcport->fw_login_state == DSC_LS_PLOGI_PEND) ||
-	    (fcport->fw_login_state == DSC_LS_PRLI_PEND)) {
+	if (fcport->fw_login_state == DSC_LS_PLOGI_PEND) {
+		ql_dbg(ql_dbg_disc, vha, 0x20ea,
+		    "%s %d %8phC Remote is trying to login\n",
+		    __func__, __LINE__, fcport->port_name);
+		/*
+		 * If we get here, there is port thats already logged in,
+		 * but it's state has not moved ahead. Recheck with FW on
+		 * what state it is in and proceed ahead
+		 */
+		if (!N2N_TOPO(vha->hw)) {
+			fcport->fw_login_state = DSC_LS_PRLI_COMP;
+			qla24xx_post_gpdb_work(vha, fcport, 0);
+		}
+		return;
+	}
+
+	if (fcport->fw_login_state == DSC_LS_PRLI_PEND) {
 		ql_dbg(ql_dbg_disc, vha, 0x20ea,
 		    "%s %d %8phC Remote is trying to login\n",
 		    __func__, __LINE__, fcport->port_name);
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -1676,13 +1676,28 @@ skip_rio:
 
 			/* Port logout */
 			fcport = qla2x00_find_fcport_by_loopid(vha, mb[1]);
-			if (!fcport)
+			if (!fcport) {
+				ql_dbg(ql_dbg_async, vha, 0x5011,
+					"Could not find fcport:%04x %04x %04x\n",
+					mb[1], mb[2], mb[3]);
 				break;
-			if (atomic_read(&fcport->state) != FCS_ONLINE)
+			}
+
+			if (atomic_read(&fcport->state) != FCS_ONLINE) {
+				ql_dbg(ql_dbg_async, vha, 0x5012,
+					"Port state is not online State:0x%x \n",
+					atomic_read(&fcport->state));
+				ql_dbg(ql_dbg_async, vha, 0x5012,
+					"Scheduling session for deletion \n");
+				fcport->logout_on_delete = 0;
+				qlt_schedule_sess_for_deletion(fcport);
 				break;
+			}
+
 			ql_dbg(ql_dbg_async, vha, 0x508a,
 			    "Marking port lost loopid=%04x portid=%06x.\n",
 			    fcport->loop_id, fcport->d_id.b24);
+
 			if (qla_ini_mode_enabled(vha)) {
 				fcport->logout_on_delete = 0;
 				qlt_schedule_sess_for_deletion(fcport);



