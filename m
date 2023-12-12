Return-Path: <stable+bounces-6488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D6280F5A8
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 19:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D6381F2153A
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 18:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167A27F547;
	Tue, 12 Dec 2023 18:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="DHfb1WO0"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04387CE
	for <stable@vger.kernel.org>; Tue, 12 Dec 2023 10:47:50 -0800 (PST)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BCDAM8k023234;
	Tue, 12 Dec 2023 10:47:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=43JsUU8i6mtwtN3FaUnznCAcO11v0NbB2UOT7Xz5CYA=; b=
	DHfb1WO0qq3tmrBdWaFsDcIsTTzKIuDBLDHJdnjkSm9KgB6H1BAijG9/VL2uko2e
	+E9YGvIbVdlnSlRLr8IQytbl1TNHWHWkqxNrz0Qgeek37Z5ljhCeNWja1ebKqUlr
	2F3m8DRnsWyBG5UUxpEaPOdUV+nXCcilMFsArrycW4JPMMh+hahxCsE6/h3fQMCM
	aYwG94lNTegVQq2hQYZ/U83fPWDF/0rupTh5nsuFzBBbQpZWNe2dYkRP2f1+TAQ1
	ZYy2hC3JfqeCRCdCcTq/vdE5yDUBPjKIBh5pu07cngB/vXqH6+WDBOF7clUml9TO
	0l7Lvh0CkCQBXrr2FQYFyw==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3uwyxj9mj0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 12 Dec 2023 10:47:47 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 10:47:51 -0800
Received: from yow-lpggp3.wrs.com (128.224.137.13) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 12 Dec 2023 10:47:51 -0800
From: <paul.gortmaker@windriver.com>
To: Namjae Jeon <linkinjeon@kernel.org>, Steve French <stfrench@microsoft.com>
CC: <stable@vger.kernel.org>
Subject: [PATCH 1/1] ksmbd: check the validation of pdu_size in ksmbd_conn_handler_loop
Date: Tue, 12 Dec 2023 13:47:45 -0500
Message-ID: <20231212184745.2245187-2-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231212184745.2245187-1-paul.gortmaker@windriver.com>
References: <20231212184745.2245187-1-paul.gortmaker@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: N7UKn4dmEQod5MbVFuam7qluF3VPcWpb
X-Proofpoint-GUID: N7UKn4dmEQod5MbVFuam7qluF3VPcWpb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=950 adultscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312120143

From: Namjae Jeon <linkinjeon@kernel.org>

commit 368ba06881c395f1c9a7ba22203cf8d78b4addc0 upstream.

The length field of netbios header must be greater than the SMB header
sizes(smb1 or smb2 header), otherwise the packet is an invalid SMB packet.

If `pdu_size` is 0, ksmbd allocates a 4 bytes chunk to `conn->request_buf`.
In the function `get_smb2_cmd_val` ksmbd will read cmd from
`rcv_hdr->Command`, which is `conn->request_buf + 12`, causing the KASAN
detector to print the following error message:

[    7.205018] BUG: KASAN: slab-out-of-bounds in get_smb2_cmd_val+0x45/0x60
[    7.205423] Read of size 2 at addr ffff8880062d8b50 by task ksmbd:42632/248
...
[    7.207125]  <TASK>
[    7.209191]  get_smb2_cmd_val+0x45/0x60
[    7.209426]  ksmbd_conn_enqueue_request+0x3a/0x100
[    7.209712]  ksmbd_server_process_request+0x72/0x160
[    7.210295]  ksmbd_conn_handler_loop+0x30c/0x550
[    7.212280]  kthread+0x160/0x190
[    7.212762]  ret_from_fork+0x1f/0x30
[    7.212981]  </TASK>

Cc: stable@vger.kernel.org
Reported-by: Chih-Yen Chang <cc85nod@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
[PG: fs/smb/server/connection.c --> fs/ksmbd/connection.c for v5.15.
 Also no smb2_get_msg() as no +4 from cb4517201b8a in v5.15 baseline.]
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 fs/ksmbd/connection.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/ksmbd/connection.c b/fs/ksmbd/connection.c
index cab274b77727..7f6fdafa240d 100644
--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
@@ -263,6 +263,9 @@ bool ksmbd_conn_alive(struct ksmbd_conn *conn)
 	return true;
 }
 
+#define SMB1_MIN_SUPPORTED_HEADER_SIZE (sizeof(struct smb_hdr))
+#define SMB2_MIN_SUPPORTED_HEADER_SIZE (sizeof(struct smb2_hdr))
+
 /**
  * ksmbd_conn_handler_loop() - session thread to listen on new smb requests
  * @p:		connection instance
@@ -319,6 +322,9 @@ int ksmbd_conn_handler_loop(void *p)
 		if (pdu_size > MAX_STREAM_PROT_LEN)
 			break;
 
+		if (pdu_size < SMB1_MIN_SUPPORTED_HEADER_SIZE)
+			break;
+
 		/* 4 for rfc1002 length field */
 		/* 1 for implied bcc[0] */
 		size = pdu_size + 4 + 1;
@@ -346,6 +352,12 @@ int ksmbd_conn_handler_loop(void *p)
 			continue;
 		}
 
+		if (((struct smb2_hdr *)(conn->request_buf))->ProtocolId ==
+		    SMB2_PROTO_NUMBER) {
+			if (pdu_size < SMB2_MIN_SUPPORTED_HEADER_SIZE)
+				break;
+		}
+
 		if (!default_conn_ops.process_fn) {
 			pr_err("No connection request callback\n");
 			break;
-- 
2.40.0


