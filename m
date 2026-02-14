Return-Path: <stable+bounces-216493-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6J0UKV6wkGkUcQEAu9opvQ
	(envelope-from <stable+bounces-216493-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 18:26:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B076313C9D5
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 18:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 92C1A30011A8
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 17:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD262DCBF4;
	Sat, 14 Feb 2026 17:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBPiI+Vf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408AA405F7
	for <stable@vger.kernel.org>; Sat, 14 Feb 2026 17:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771090009; cv=none; b=CYvYDlvko79nVmvkiZ0xieNLc+SJ+xWWLXPQ4i04KJmDlIzo2asiylNY8eAR2kOD9di+ralMY2DxVxCb1hoelteWLV/PccbEIfy0oI4lXMnkThaPZITB2Rnh0T4Zz36I3gqg5v1rbsDRwzYKqOYxxYOHvEmvWMA5y2Lr8c0mwEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771090009; c=relaxed/simple;
	bh=JmgrEbFXF3iirx+fHtUdii6WOI5aA1OhnHy+MB7423c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JCWzvXh1gwZwuAfMyP5mYqdTyrwxsqXSAEpAZEuLg+7wmdLXlcb/DdGnDAZ57Jbqc07CmHlsqCaH1B8Dngpdcs9icEag9KYTlZWyzoMFVeYHz7ufl6kB/hM+DQuZV6zQTRkv6XR5TaNWNmyEicV0im0ljt3ob55sKJU4HDlTK/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBPiI+Vf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C41C16AAE;
	Sat, 14 Feb 2026 17:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771090008;
	bh=JmgrEbFXF3iirx+fHtUdii6WOI5aA1OhnHy+MB7423c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RBPiI+VfiexHNXmCAGeiTp0Et7a22VefA1E1d/Kk2KJR1vmyOMdjC7CKw5IctjXj0
	 jHUIYID6jfD6KVp2YaItX3OroH+Gauh+5weU6wVpmzw7bZKHZFLT/H/rlm3+/LhY2h
	 f5U2UldE1JFCBRtjdMDN0wkkroVOxBvU7BIGtk4iXHNsfFKr0/gGrWTssFF7B+NMBE
	 iio9pLXoB1kHeUkcfL9juR50wl+HCV1/kz9V3HNx2w1lY1fR2h9VaG9z6bAlq+mBJd
	 3zZCUFQIeArEvlag6HgdSl70wBEAkrYSW6ADcfHLcJxCF6vyBifqygxX1wCDVpsPZt
	 /fRDMl5OfBSjQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anil Gurumurthy <agurumurthy@marvell.com>,
	Nilesh Javali <njavali@marvell.com>,
	Himanshu Madhani <hmadhani2024@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] scsi: qla2xxx: Fix bsg_done() causing double free
Date: Sat, 14 Feb 2026 12:26:46 -0500
Message-ID: <20260214172646.638487-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026021341-remarry-footsore-fd7e@gregkh>
References: <2026021341-remarry-footsore-fd7e@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[marvell.com,gmail.com,oracle.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-216493-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: B076313C9D5
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
[ applied only to qla2x00_update_optrom() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_bsg.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_bsg.c b/drivers/scsi/qla2xxx/qla_bsg.c
index 4324f4643e834..c37945ac9eca7 100644
--- a/drivers/scsi/qla2xxx/qla_bsg.c
+++ b/drivers/scsi/qla2xxx/qla_bsg.c
@@ -1523,8 +1523,9 @@ qla2x00_update_optrom(struct bsg_job *bsg_job)
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
 
-- 
2.51.0


