Return-Path: <stable+bounces-221504-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOHuCHuYo2neHgUAu9opvQ
	(envelope-from <stable+bounces-221504-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:38:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A64D61CB2FD
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3989830F7581
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA6D72631;
	Sun,  1 Mar 2026 01:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="reuBBxFN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B0D284898;
	Sun,  1 Mar 2026 01:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328432; cv=none; b=KS9h4n1KrIRHIEWAV/c4BEwubQ+JiBudYSUCmqw4v8n2aoj6LfcSS6FtB/5Hc62L2LVoXdmaj8dbXviclcBbtBpZgmSvVI3ePir5A0aLNhmkV+V+o9Ag4Ph7xcTcXed8nEpxAhwHgE69CBw4ImOQC69F0oMSgtRsyt6P/ruCsXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328432; c=relaxed/simple;
	bh=/WNxmb8x4abbxIMxISGqArrJAcBX5SX4Bph+wCGK82A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mrjj4OHRch3Bxhg85ygHhnoYlAo1lsGOCdY5lJiJ0Xh3MLNFJ0XDvKHWXU9Z/euaSb10J6IzvXkEUjUIVuypJgqgJO7e7+IKDfL7SvWJC7kljzUzNNj0K+/OgfA5kQ1r3YDlS/ctyhGPVAJCvPMJmquOoVlKoLiyJRQGa1yVads=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=reuBBxFN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD43C19421;
	Sun,  1 Mar 2026 01:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328432;
	bh=/WNxmb8x4abbxIMxISGqArrJAcBX5SX4Bph+wCGK82A=;
	h=From:To:Cc:Subject:Date:From;
	b=reuBBxFNtU2Mt9T0kRjKzIa5oc8KcivhJwN820kEXAoVi9WDQAHSkG8bzUL598d/I
	 5FP4FurjdzY3nYhTNPz/6lVidABh7BE71wXEqgUI11mD9Fp4euXcvE62e6N4Dfv87y
	 KsmfKfBX8GaE+XV3JUUPDxSnFhL0TSEvo4j7ZLeydHpK6RZxesc18UWTxZ4Paz+O1c
	 XPkW+QZ89VngbU/s7pHri/68lEVn+HsmnLYmKA5jhYxqLdGrt9IocG7Sw9yRFK7hCP
	 0LgIlSHLisToAE1BvjcsV1RE++PLZBxoZfYITroKTUq4OsLMy5tZKnYR26T08G+/+p
	 dGJKoHZB5MguQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	metze@samba.org
Cc: Steve French <smfrench@gmail.com>,
	Tom Talpey <tom@talpey.com>,
	Long Li <longli@microsoft.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	Steve French <stfrench@microsoft.com>
Subject: FAILED: Patch "smb: client: make use of smbdirect_socket.send_io.bcredits" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:27:10 -0500
Message-ID: <20260301012710.1684640-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [8.84 / 15.00];
	URIBL_BLACK(7.50)[talpey.com:email];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,talpey.com,microsoft.com,kernel.org,vger.kernel.org,lists.samba.org];
	TAGGED_FROM(0.00)[bounces-221504-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_SPAM(0.00)[0.348];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A64D61CB2FD
X-Rspamd-Action: add header
X-Spam: Yes

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 21538121efe6c8c5b51c742fa02cbe820bc48714 Mon Sep 17 00:00:00 2001
From: Stefan Metzmacher <metze@samba.org>
Date: Thu, 22 Jan 2026 18:16:57 +0100
Subject: [PATCH] smb: client: make use of smbdirect_socket.send_io.bcredits

It turns out that our code will corrupt the stream of
reassabled data transfer messages when we trigger an
immendiate (empty) send.

In order to fix this we'll have a single 'batch' credit per
connection. And code getting that credit is free to use
as much messages until remaining_length reaches 0, then
the batch credit it given back and the next logical send can
happen.

Cc: <stable@vger.kernel.org> # 6.18.x
Cc: Steve French <smfrench@gmail.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Long Li <longli@microsoft.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/client/smbdirect.c | 58 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 3 deletions(-)

diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index ef3b237bccc13..dbb2d939bc44d 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -657,6 +657,7 @@ static bool process_negotiation_response(
 			sp->max_frmr_depth * PAGE_SIZE);
 	sp->max_frmr_depth = sp->max_read_write_size / PAGE_SIZE;
 
+	atomic_set(&sc->send_io.bcredits.count, 1);
 	sc->recv_io.expected = SMBDIRECT_EXPECT_DATA_TRANSFER;
 	return true;
 }
@@ -1214,6 +1215,7 @@ static void smbd_send_batch_init(struct smbdirect_send_batch *batch,
 	batch->wr_cnt = 0;
 	batch->need_invalidate_rkey = need_invalidate_rkey;
 	batch->remote_key = remote_key;
+	batch->credit = 0;
 }
 
 static int smbd_send_batch_flush(struct smbdirect_socket *sc,
@@ -1224,7 +1226,7 @@ static int smbd_send_batch_flush(struct smbdirect_socket *sc,
 	int ret = 0;
 
 	if (list_empty(&batch->msg_list))
-		return 0;
+		goto release_credit;
 
 	first = list_first_entry(&batch->msg_list,
 				 struct smbdirect_send_io,
@@ -1266,6 +1268,13 @@ static int smbd_send_batch_flush(struct smbdirect_socket *sc,
 		smbd_free_send_io(last);
 	}
 
+release_credit:
+	if (is_last && !ret && batch->credit) {
+		atomic_add(batch->credit, &sc->send_io.bcredits.count);
+		batch->credit = 0;
+		wake_up(&sc->send_io.bcredits.wait_queue);
+	}
+
 	return ret;
 }
 
@@ -1291,6 +1300,25 @@ static int wait_for_credits(struct smbdirect_socket *sc,
 	} while (true);
 }
 
+static int wait_for_send_bcredit(struct smbdirect_socket *sc,
+				 struct smbdirect_send_batch *batch)
+{
+	int ret;
+
+	if (batch->credit)
+		return 0;
+
+	ret = wait_for_credits(sc,
+			       &sc->send_io.bcredits.wait_queue,
+			       &sc->send_io.bcredits.count,
+			       1);
+	if (ret)
+		return ret;
+
+	batch->credit = 1;
+	return 0;
+}
+
 static int wait_for_send_lcredit(struct smbdirect_socket *sc,
 				 struct smbdirect_send_batch *batch)
 {
@@ -1338,6 +1366,19 @@ static int smbd_post_send_iter(struct smbdirect_socket *sc,
 	struct smbdirect_send_io *request;
 	struct smbdirect_data_transfer *packet;
 	int new_credits = 0;
+	struct smbdirect_send_batch _batch;
+
+	if (!batch) {
+		smbd_send_batch_init(&_batch, false, 0);
+		batch = &_batch;
+	}
+
+	rc = wait_for_send_bcredit(sc, batch);
+	if (rc) {
+		log_outgoing(ERR, "disconnected not sending on wait_bcredit\n");
+		rc = -EAGAIN;
+		goto err_wait_bcredit;
+	}
 
 	rc = wait_for_send_lcredit(sc, batch);
 	if (rc) {
@@ -1432,8 +1473,14 @@ static int smbd_post_send_iter(struct smbdirect_socket *sc,
 		     le32_to_cpu(packet->remaining_data_length));
 
 	rc = smbd_post_send(sc, batch, request);
-	if (!rc)
-		return 0;
+	if (!rc) {
+		if (batch != &_batch)
+			return 0;
+
+		rc = smbd_send_batch_flush(sc, batch, true);
+		if (!rc)
+			return 0;
+	}
 
 err_dma:
 	smbd_free_send_io(request);
@@ -1447,6 +1494,11 @@ static int smbd_post_send_iter(struct smbdirect_socket *sc,
 	wake_up(&sc->send_io.lcredits.wait_queue);
 
 err_wait_lcredit:
+	atomic_add(batch->credit, &sc->send_io.bcredits.count);
+	batch->credit = 0;
+	wake_up(&sc->send_io.bcredits.wait_queue);
+
+err_wait_bcredit:
 	return rc;
 }
 
-- 
2.51.0





