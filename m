Return-Path: <stable+bounces-217016-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eK/+LnTTlGmfIAIAu9opvQ
	(envelope-from <stable+bounces-217016-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:45:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E621D150398
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 76CE23005170
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31652261B70;
	Tue, 17 Feb 2026 20:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TnniRhIP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E949E7A13A;
	Tue, 17 Feb 2026 20:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771361136; cv=none; b=lXfdnduhxKEk/jtKZ3pflkkrmPTuksDSztvsyQxEZssOrmRiPdWrOkC4RQ/mMn+JSyFlc3y2O1iVDeTSffmoL3wMat+HTgbG2yXF+BplPDfi+HkHQajSclLr9VnUYMy4FKP1OAdZjyPUeFUnBvPbI6cVNe8FmOQe7W64Rx2eP4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771361136; c=relaxed/simple;
	bh=b1NhZMrLuNg1doMimwMKk5H/+TgAy4buh75FmQ9tg7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mAfga/NEpAsRw6pBpmrhiYhKs+DQyW0fla6NGmmIKIiyQ3Hd9ZFioyX5im6k70I84o+a2viWRfckPSQgOXhW4yP07uGp/aKwIFdlC5C31AWEg28psPLm9qfBLRSFyj5GI8qreqWLT9ehykKnzFxrjHxEmOF7n+4RybIyNn0+l/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TnniRhIP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC1AC4CEF7;
	Tue, 17 Feb 2026 20:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771361135;
	bh=b1NhZMrLuNg1doMimwMKk5H/+TgAy4buh75FmQ9tg7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TnniRhIPQWXcIBwINcEoccbNVK6ZE4TbzJ3+rrI/7zv3SbnYzNq5bRKenfHQX8bhc
	 M7m84BXr21TA7Mmon1RcTb5PWLfkpvFhgQ+Y6NedyAOy1fKc74qk8tKyBtj3zpw0W9
	 O1BwQnZ7E+U+3q+W63UwjGpLXCD0Kv3SaXdfCcvs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Anil Gurumurthy <agurumurthy@marvell.com>,
	Nilesh Javali <njavali@marvell.com>,
	Himanshu Madhani <hmadhani2024@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.1 12/64] scsi: qla2xxx: Query FW again before proceeding with login
Date: Tue, 17 Feb 2026 21:31:08 +0100
Message-ID: <20260217200007.973756588@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217200007.505931165@linuxfoundation.org>
References: <20260217200007.505931165@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217016-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,marvell.com:email,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,oracle.com:email]
X-Rspamd-Queue-Id: E621D150398
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2463,8 +2463,23 @@ qla24xx_handle_plogi_done_event(struct s
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
@@ -1524,13 +1524,28 @@ skip_rio:
 
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



