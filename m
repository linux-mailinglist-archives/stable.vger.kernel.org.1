Return-Path: <stable+bounces-216060-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOD4NsMIj2ltHQEAu9opvQ
	(envelope-from <stable+bounces-216060-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 12:19:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3F3135AD5
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 12:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0317830A5AB2
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 11:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503E63563F1;
	Fri, 13 Feb 2026 11:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DyZE0Pci"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A3621D3D6
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 11:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770981350; cv=none; b=Y2aoEAACG6bp7GW1/pLZwv6pmWIo4jdzInaUG4NQmVYQKD4JH8pr+7ONoz2rfgBVNvHG5JVg3V/LafSrO8ibjUF9V0l+/nNW1oo6AQwIssO8mZeZnQK249DjB+QO6/NPsd0Z1D/7B1Tt6X+aQ5QQP/4uA5m6l719V0sYzOgLUIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770981350; c=relaxed/simple;
	bh=kUoaP2uvhn9+dq28zDhJf+/rhvR2FmTziQ3WkpeTaVg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=muZoffpIh+Brgx2EHFniGVA1lxJFRJHAshRsWWxdB/mC1lT4+vNc2TfF8oHn6rGfkz2/vSsjRfMNeADwsjpvtUJzuXu05VAnbKT11cyWTmUGf20zThOholtqLSlaDYysGxsQBe1AaYPXb9OtwRFBbkDlRm3ZD+Ixq8MZre6KYSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DyZE0Pci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3095CC116C6;
	Fri, 13 Feb 2026 11:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770981349;
	bh=kUoaP2uvhn9+dq28zDhJf+/rhvR2FmTziQ3WkpeTaVg=;
	h=Subject:To:Cc:From:Date:From;
	b=DyZE0Pcixa8Reg4W9VrgcOCe1A3u9laB/Wcwfl7U6gQ/q1k4nswhY0HN9WnyXCOji
	 p4IMLLOJ/D+Yg88Zzs4jCsuGChgFPEIstbuyJMpHnQ2sX8UUr9u+L4szFlJydjZeRi
	 v5j0sSXH0djeHR59X+yeBVmlzLsHTb+JEqvywGRY=
Subject: FAILED: patch "[PATCH] scsi: qla2xxx: Fix bsg_done() causing double free" failed to apply to 6.6-stable tree
To: agurumurthy@marvell.com,hmadhani2024@gmail.com,martin.petersen@oracle.com,njavali@marvell.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 13 Feb 2026 12:15:38 +0100
Message-ID: <2026021338-rotunda-guru-146e@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[marvell.com,gmail.com,oracle.com];
	TAGGED_FROM(0.00)[bounces-216060-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,msgid.link:url,gregkh:email,linuxfoundation.org:dkim,marvell.com:email]
X-Rspamd-Queue-Id: 6D3F3135AD5
X-Rspamd-Action: no action


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x c2c68225b1456f4d0d393b5a8778d51bb0d5b1d0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026021338-rotunda-guru-146e@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c2c68225b1456f4d0d393b5a8778d51bb0d5b1d0 Mon Sep 17 00:00:00 2001
From: Anil Gurumurthy <agurumurthy@marvell.com>
Date: Wed, 10 Dec 2025 15:46:03 +0530
Subject: [PATCH] scsi: qla2xxx: Fix bsg_done() causing double free

Kernel panic observed on system,

[5353358.825191] BUG: unable to handle page fault for address: ff5f5e897b024000
[5353358.825194] #PF: supervisor write access in kernel mode
[5353358.825195] #PF: error_code(0x0002) - not-present page
[5353358.825196] PGD 100006067 P4D 0
[5353358.825198] Oops: 0002 [#1] PREEMPT SMP NOPTI
[5353358.825200] CPU: 5 PID: 2132085 Comm: qlafwupdate.sub Kdump: loaded Tainted: G        W    L    -------  ---  5.14.0-503.34.1.el9_5.x86_64 #1
[5353358.825203] Hardware name: HPE ProLiant DL360 Gen11/ProLiant DL360 Gen11, BIOS 2.44 01/17/2025
[5353358.825204] RIP: 0010:memcpy_erms+0x6/0x10
[5353358.825211] RSP: 0018:ff591da8f4f6b710 EFLAGS: 00010246
[5353358.825212] RAX: ff5f5e897b024000 RBX: 0000000000007090 RCX: 0000000000001000
[5353358.825213] RDX: 0000000000001000 RSI: ff591da8f4fed090 RDI: ff5f5e897b024000
[5353358.825214] RBP: 0000000000010000 R08: ff5f5e897b024000 R09: 0000000000000000
[5353358.825215] R10: ff46cf8c40517000 R11: 0000000000000001 R12: 0000000000008090
[5353358.825216] R13: ff591da8f4f6b720 R14: 0000000000001000 R15: 0000000000000000
[5353358.825218] FS:  00007f1e88d47740(0000) GS:ff46cf935f940000(0000) knlGS:0000000000000000
[5353358.825219] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[5353358.825220] CR2: ff5f5e897b024000 CR3: 0000000231532004 CR4: 0000000000771ef0
[5353358.825221] PKRU: 55555554
[5353358.825222] Call Trace:
[5353358.825223]  <TASK>
[5353358.825224]  ? show_trace_log_lvl+0x1c4/0x2df
[5353358.825229]  ? show_trace_log_lvl+0x1c4/0x2df
[5353358.825232]  ? sg_copy_buffer+0xc8/0x110
[5353358.825236]  ? __die_body.cold+0x8/0xd
[5353358.825238]  ? page_fault_oops+0x134/0x170
[5353358.825242]  ? kernelmode_fixup_or_oops+0x84/0x110
[5353358.825244]  ? exc_page_fault+0xa8/0x150
[5353358.825247]  ? asm_exc_page_fault+0x22/0x30
[5353358.825252]  ? memcpy_erms+0x6/0x10
[5353358.825253]  sg_copy_buffer+0xc8/0x110
[5353358.825259]  qla2x00_process_vendor_specific+0x652/0x1320 [qla2xxx]
[5353358.825317]  qla24xx_bsg_request+0x1b2/0x2d0 [qla2xxx]

Most routines in qla_bsg.c call bsg_done() only for success cases.
However a few invoke it for failure case as well leading to a double
free. Validate before calling bsg_done().

Cc: stable@vger.kernel.org
Signed-off-by: Anil Gurumurthy <agurumurthy@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Reviewed-by: Himanshu Madhani <hmadhani2024@gmail.com>
Link: https://patch.msgid.link/20251210101604.431868-12-njavali@marvell.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/scsi/qla2xxx/qla_bsg.c b/drivers/scsi/qla2xxx/qla_bsg.c
index 8afa8a4b8ccb..2c44a379cb23 100644
--- a/drivers/scsi/qla2xxx/qla_bsg.c
+++ b/drivers/scsi/qla2xxx/qla_bsg.c
@@ -1548,8 +1548,9 @@ qla2x00_update_optrom(struct bsg_job *bsg_job)
 	ha->optrom_buffer = NULL;
 	ha->optrom_state = QLA_SWAITING;
 	mutex_unlock(&ha->optrom_mutex);
-	bsg_job_done(bsg_job, bsg_reply->result,
-		       bsg_reply->reply_payload_rcv_len);
+	if (!rval)
+		bsg_job_done(bsg_job, bsg_reply->result,
+			     bsg_reply->reply_payload_rcv_len);
 	return rval;
 }
 
@@ -2638,8 +2639,9 @@ qla2x00_manage_host_stats(struct bsg_job *bsg_job)
 				    sizeof(struct ql_vnd_mng_host_stats_resp));
 
 	bsg_reply->result = DID_OK;
-	bsg_job_done(bsg_job, bsg_reply->result,
-		     bsg_reply->reply_payload_rcv_len);
+	if (!ret)
+		bsg_job_done(bsg_job, bsg_reply->result,
+			     bsg_reply->reply_payload_rcv_len);
 
 	return ret;
 }
@@ -2728,8 +2730,9 @@ qla2x00_get_host_stats(struct bsg_job *bsg_job)
 							       bsg_job->reply_payload.sg_cnt,
 							       data, response_len);
 	bsg_reply->result = DID_OK;
-	bsg_job_done(bsg_job, bsg_reply->result,
-		     bsg_reply->reply_payload_rcv_len);
+	if (!ret)
+		bsg_job_done(bsg_job, bsg_reply->result,
+			     bsg_reply->reply_payload_rcv_len);
 
 	kfree(data);
 host_stat_out:
@@ -2828,8 +2831,9 @@ qla2x00_get_tgt_stats(struct bsg_job *bsg_job)
 				    bsg_job->reply_payload.sg_cnt, data,
 				    response_len);
 	bsg_reply->result = DID_OK;
-	bsg_job_done(bsg_job, bsg_reply->result,
-		     bsg_reply->reply_payload_rcv_len);
+	if (!ret)
+		bsg_job_done(bsg_job, bsg_reply->result,
+			     bsg_reply->reply_payload_rcv_len);
 
 tgt_stat_out:
 	kfree(data);
@@ -2890,8 +2894,9 @@ qla2x00_manage_host_port(struct bsg_job *bsg_job)
 				    bsg_job->reply_payload.sg_cnt, &rsp_data,
 				    sizeof(struct ql_vnd_mng_host_port_resp));
 	bsg_reply->result = DID_OK;
-	bsg_job_done(bsg_job, bsg_reply->result,
-		     bsg_reply->reply_payload_rcv_len);
+	if (!ret)
+		bsg_job_done(bsg_job, bsg_reply->result,
+			     bsg_reply->reply_payload_rcv_len);
 
 	return ret;
 }
@@ -3272,7 +3277,8 @@ int qla2x00_mailbox_passthru(struct bsg_job *bsg_job)
 
 	bsg_job->reply_len = sizeof(*bsg_job->reply);
 	bsg_reply->result = DID_OK << 16;
-	bsg_job_done(bsg_job, bsg_reply->result, bsg_reply->reply_payload_rcv_len);
+	if (!ret)
+		bsg_job_done(bsg_job, bsg_reply->result, bsg_reply->reply_payload_rcv_len);
 
 	kfree(req_data);
 
@@ -3359,8 +3365,9 @@ static int qla28xx_validate_flash_image(struct bsg_job *bsg_job)
 	bsg_reply->result = DID_OK << 16;
 	bsg_reply->reply_payload_rcv_len = 0;
 	bsg_job->reply_len = sizeof(struct fc_bsg_reply);
-	bsg_job_done(bsg_job, bsg_reply->result,
-			bsg_reply->reply_payload_rcv_len);
+	if (!rval)
+		bsg_job_done(bsg_job, bsg_reply->result,
+			     bsg_reply->reply_payload_rcv_len);
 
 	return QLA_SUCCESS;
 }


