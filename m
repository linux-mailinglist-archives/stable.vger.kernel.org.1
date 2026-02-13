Return-Path: <stable+bounces-216052-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAsaJuIIj2ltHQEAu9opvQ
	(envelope-from <stable+bounces-216052-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 12:20:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B1C135B07
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 12:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A7343077CD0
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 11:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D86234F461;
	Fri, 13 Feb 2026 11:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zr/fy8lJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4139734DB5F
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 11:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770981282; cv=none; b=KGooxhKu5XqU41kAO4Tco8AWRM7c85npR4egGfffl5lQ0JUQbBnhRGbLkImaSzfxnt1gayeVDpeODHnpniKq4JkjlOiy7dkOXGeDIdvVtTwRyYtgRGu7vqB9Chgl+pVOpd7s+5lxxCNpVoPXcUqE2uVyNOedUtcOrIbtNQDcjNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770981282; c=relaxed/simple;
	bh=1d/1nRUlxo+YnAMhtuDmuGc2giJTJXenS3vrtGIgjz0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=u5/LCz2htkzS66c1cZGX+DhNTq/auxNj6KBZU1nyFyB74DwiuQM8DYnhtAFOq6KwWMwcN9GmFAFbwNiQjAtL5V/9Ydh1nT0U3aY7ADPqpYOtIbaQbgrWEV17W0yNmdylsAK761CwIKV6H0KBzL83j2kQ4NAR/67k3/xeTBrTxtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zr/fy8lJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D6CC116C6;
	Fri, 13 Feb 2026 11:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770981282;
	bh=1d/1nRUlxo+YnAMhtuDmuGc2giJTJXenS3vrtGIgjz0=;
	h=Subject:To:Cc:From:Date:From;
	b=Zr/fy8lJJp8kFbTwQASXZAP6fB1GYHP7ZRvS+iH0JLL18LbY2EjwvcawjR7wdN3cQ
	 oehF9UeFd1PJadJoFrVXUq7FiaJ5GlkE711LCWU7dwEmuFuk1h133IeaQx60NaC/JI
	 dhF/cM0bWx8NAKmNbDocuFLNHbW/Ygus+lsCUknA=
Subject: FAILED: patch "[PATCH] scsi: qla2xxx: Allow recovery for tape devices" failed to apply to 5.15-stable tree
To: sdeodhar@marvell.com,hmadhani2024@gmail.com,martin.petersen@oracle.com,njavali@marvell.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 13 Feb 2026 12:14:38 +0100
Message-ID: <2026021338-undergo-banking-e95c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[marvell.com,gmail.com,oracle.com];
	TAGGED_FROM(0.00)[bounces-216052-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,marvell.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,oracle.com:email]
X-Rspamd-Queue-Id: E7B1C135B07
X-Rspamd-Action: no action


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x b0335ee4fb94832a4ef68774ca7e7b33b473c7a6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026021338-undergo-banking-e95c@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b0335ee4fb94832a4ef68774ca7e7b33b473c7a6 Mon Sep 17 00:00:00 2001
From: Shreyas Deodhar <sdeodhar@marvell.com>
Date: Wed, 10 Dec 2025 15:45:58 +0530
Subject: [PATCH] scsi: qla2xxx: Allow recovery for tape devices

Tape device doesn't show up after RSCNs.  To fix this, remove tape
device specific checks which allows recovery of tape devices.

Fixes: 44c57f205876 ("scsi: qla2xxx: Changes to support FCP2 Target")
Cc: stable@vger.kernel.org
Signed-off-by: Shreyas Deodhar <sdeodhar@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Reviewed-by: Himanshu Madhani <hmadhani2024@gmail.com>
Link: https://patch.msgid.link/20251210101604.431868-7-njavali@marvell.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index 51c7cea71f90..02a52c215797 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -3266,9 +3266,6 @@ void qla_fab_scan_finish(scsi_qla_host_t *vha, srb_t *sp)
 			    atomic_read(&fcport->state) == FCS_ONLINE) ||
 				do_delete) {
 				if (fcport->loop_id != FC_NO_LOOP_ID) {
-					if (fcport->flags & FCF_FCP2_DEVICE)
-						continue;
-
 					ql_log(ql_log_warn, vha, 0x20f0,
 					       "%s %d %8phC post del sess\n",
 					       __func__, __LINE__,
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 9729e32012aa..6ce3a492ad6f 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -1859,15 +1859,6 @@ void qla2x00_handle_rscn(scsi_qla_host_t *vha, struct event_arg *ea)
 	case RSCN_PORT_ADDR:
 		fcport = qla2x00_find_fcport_by_nportid(vha, &ea->id, 1);
 		if (fcport) {
-			if (ql2xfc2target &&
-			    fcport->flags & FCF_FCP2_DEVICE &&
-			    atomic_read(&fcport->state) == FCS_ONLINE) {
-				ql_dbg(ql_dbg_disc, vha, 0x2115,
-				       "Delaying session delete for FCP2 portid=%06x %8phC ",
-					fcport->d_id.b24, fcport->port_name);
-				return;
-			}
-
 			if (vha->hw->flags.edif_enabled && DBELL_ACTIVE(vha)) {
 				/*
 				 * On ipsec start by remote port, Target port


