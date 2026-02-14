Return-Path: <stable+bounces-216314-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNNLO6nHj2lVTgEAu9opvQ
	(envelope-from <stable+bounces-216314-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 01:54:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8236013A309
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 01:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50440301CDAA
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 00:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B831DEFE0;
	Sat, 14 Feb 2026 00:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9OfUjP0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F201DE887
	for <stable@vger.kernel.org>; Sat, 14 Feb 2026 00:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771030439; cv=none; b=hKZh3UPQh0PAXk2USjkI+ogyjtPeBdIJZuwz2NeLqYikBgpAMbvoBmORis1ghHEMzfiArqqFWeMmw6MHXkNKSMigGAbkyW4RSnNRe92s5tLhN8c4pXn+IxPiLwSiOjEeTtoNz5spdHfzkdhhrLqhXV/jJEVF+fYCV2OF8BPdzhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771030439; c=relaxed/simple;
	bh=VVIxGS2Ll6x0YYt0DsHqkMf0zOzOkPiYOtxQOsF9+/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HmB4tniCbF0ackmSGNOuRbFZMr0hby2h3fOrssR/iJQQKvE1joz+dIx/D28SVL+d5j0TF9XE3m71xC0GAJgaLBXnGOnKCBPVGUWExP/nVMDpZM8oYQ4RjrwskQ+ObDeW+bJfFYHK+QVEBdlT8nhqA0lIFPcA7TZaftBfad4ntjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9OfUjP0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F109BC116C6;
	Sat, 14 Feb 2026 00:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771030438;
	bh=VVIxGS2Ll6x0YYt0DsHqkMf0zOzOkPiYOtxQOsF9+/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a9OfUjP0Z1Q0RAZ1MnJjGX1m6bZ51C/BktlW7A6wnx4hwYtrTzMYG/BZKyz2kA+2W
	 QbFmbYLOjL0/r6siQrkQfGiorvnLXnDj0+iU2dpcqbeDsBwCDwGcVZx7uMpprnodBC
	 tPKrGsbiTFQKyHxH8ZDzfJthrYq3LF/yhBSVE9R88tI6l2hYratW0/OEvykRWzFBE9
	 px/Fr+OZhMmuSdMr9nt1DQ1ErwOIBjP5J7+gQ+kdMR4c0PXc0PhdTcN8RW7SmiJgNp
	 aWuwWhbEV0R/yISnGfFfwhSYVkMZDB/L61pZoj3/Qms/fsPaLfETyFjgfrdsiccwaX
	 LR4IWKCD1EyVg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anil Gurumurthy <agurumurthy@marvell.com>,
	Nilesh Javali <njavali@marvell.com>,
	Himanshu Madhani <hmadhani2024@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] scsi: qla2xxx: Fix bsg_done() causing double free
Date: Fri, 13 Feb 2026 19:53:55 -0500
Message-ID: <20260214005355.3652664-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026021337-sedate-comfort-cef2@gregkh>
References: <2026021337-sedate-comfort-cef2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[marvell.com,gmail.com,oracle.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-216314-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,marvell.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 8236013A309
X-Rspamd-Action: no action

From: Anil Gurumurthy <agurumurthy@marvell.com>

[ Upstream commit c2c68225b1456f4d0d393b5a8778d51bb0d5b1d0 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_bsg.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_bsg.c b/drivers/scsi/qla2xxx/qla_bsg.c
index 10431a67d202b..f43969ed87bf9 100644
--- a/drivers/scsi/qla2xxx/qla_bsg.c
+++ b/drivers/scsi/qla2xxx/qla_bsg.c
@@ -1546,8 +1546,9 @@ qla2x00_update_optrom(struct bsg_job *bsg_job)
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
 
@@ -2612,8 +2613,9 @@ qla2x00_manage_host_stats(struct bsg_job *bsg_job)
 				    sizeof(struct ql_vnd_mng_host_stats_resp));
 
 	bsg_reply->result = DID_OK;
-	bsg_job_done(bsg_job, bsg_reply->result,
-		     bsg_reply->reply_payload_rcv_len);
+	if (!ret)
+		bsg_job_done(bsg_job, bsg_reply->result,
+			     bsg_reply->reply_payload_rcv_len);
 
 	return ret;
 }
@@ -2702,8 +2704,9 @@ qla2x00_get_host_stats(struct bsg_job *bsg_job)
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
@@ -2802,8 +2805,9 @@ qla2x00_get_tgt_stats(struct bsg_job *bsg_job)
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
@@ -2864,8 +2868,9 @@ qla2x00_manage_host_port(struct bsg_job *bsg_job)
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
@@ -3240,7 +3245,8 @@ int qla2x00_mailbox_passthru(struct bsg_job *bsg_job)
 
 	bsg_job->reply_len = sizeof(*bsg_job->reply);
 	bsg_reply->result = DID_OK << 16;
-	bsg_job_done(bsg_job, bsg_reply->result, bsg_reply->reply_payload_rcv_len);
+	if (!ret)
+		bsg_job_done(bsg_job, bsg_reply->result, bsg_reply->reply_payload_rcv_len);
 
 	kfree(req_data);
 
-- 
2.51.0


