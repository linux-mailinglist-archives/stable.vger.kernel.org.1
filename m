Return-Path: <stable+bounces-214831-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIXZJ6qch2nUagQAu9opvQ
	(envelope-from <stable+bounces-214831-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 21:12:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB50107063
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 21:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C47030041F3
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 20:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EB02F39C7;
	Sat,  7 Feb 2026 20:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYLVmu2d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFF01482E8
	for <stable@vger.kernel.org>; Sat,  7 Feb 2026 20:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770495141; cv=none; b=W6xlse2Fvm9/U2N901w1vRL1/9ASWj6d9SvOvEA2ONWH8mjTXbnA69ac9dTAMsG3wR+XN1bAI9sEyy3lYUMrgpKwXOt8uo4U2x7jTl0w7w/Rq3vIUGpABCXnTR3YDLzT54gYASLrGR0ZD/FSf2y9XrpFohvnAQ6RSVSSyU9iEzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770495141; c=relaxed/simple;
	bh=1a1tVCwT6w3uGaxjRSdS6wBCeHjJ+9bg/4lJI1qXZG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mvVJ4XkL9O219SKIsmbylECgAbJ+Crj0EQmWr+gjaiwlKsa9/KZRF8rvl+QTthVrZVqnLhY0LfzlyFUnd8czKHFMR7jByeptT/0iXjm8Nl88218wBShuAeWQvldx0MmUepBSm1I+qqtoODB4ioMsCkUM09B/BqjyYmsb6F5YUDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYLVmu2d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4FC4C116D0;
	Sat,  7 Feb 2026 20:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770495141;
	bh=1a1tVCwT6w3uGaxjRSdS6wBCeHjJ+9bg/4lJI1qXZG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MYLVmu2dXpm3dlv2qy92pA16epiPgpTBWkLEvjztLLKtbH5mwlatL3Q139ZBo6KMS
	 ZwOI8doVP6HOpxjfFFaoj/bPfR8kfj84VfggzKt8Fq9G/Zi7sf7drY3ysLpA5n+3gZ
	 nbM9weuRYgK51tzYuq7Q+FhIFma7CSGpQBK21tRxmThHKRFezMSPkmtgJYa5RUhny6
	 jjLY+JUuWMlgyPkpH7DGl0L9P+HpXZsGweQTI1DxU8JRjBgqn0yegogLieDKm4bIse
	 8CfBLoBaPWRHujf0bZ2TK98JgTAvWK9fHmVs2HJQjeIz+UmE3O6XYsPAA1BI5k51LU
	 JLL6qAfibPhAg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Maurizio Lombardi <mlombard@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	John Meneghini <jmeneghi@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/5] nvmet-tcp: add an helper to free the cmd buffers
Date: Sat,  7 Feb 2026 15:12:15 -0500
Message-ID: <20260207201219.540631-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026020741-chitchat-symphonic-a96f@gregkh>
References: <2026020741-chitchat-symphonic-a96f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214831-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,grimberg.me:email]
X-Rspamd-Queue-Id: 2CB50107063
X-Rspamd-Action: no action

From: Maurizio Lombardi <mlombard@redhat.com>

[ Upstream commit 69b85e1f1d1d1e49601ec3e85d2031188657cca2 ]

Makes the code easier to read and to debug.

Sets the freed pointers to NULL, it will be useful
when destroying the queues to understand if the commands'
buffers have been released already or not.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: John Meneghini <jmeneghi@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Stable-dep-of: 52a0a9854934 ("nvmet-tcp: add bounds checks in nvmet_tcp_build_pdu_iovec")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/tcp.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 94ed4b5b725c7..3c0769d40edd3 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -155,6 +155,8 @@ static struct workqueue_struct *nvmet_tcp_wq;
 static const struct nvmet_fabrics_ops nvmet_tcp_ops;
 static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
 static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd);
+static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd);
+static void nvmet_tcp_unmap_pdu_iovec(struct nvmet_tcp_cmd *cmd);
 
 static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
 		struct nvmet_tcp_cmd *cmd)
@@ -286,6 +288,16 @@ static int nvmet_tcp_check_ddgst(struct nvmet_tcp_queue *queue, void *pdu)
 	return 0;
 }
 
+static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd)
+{
+	WARN_ON(unlikely(cmd->nr_mapped > 0));
+
+	kfree(cmd->iov);
+	sgl_free(cmd->req.sg);
+	cmd->iov = NULL;
+	cmd->req.sg = NULL;
+}
+
 static void nvmet_tcp_unmap_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 {
 	struct scatterlist *sg;
@@ -295,6 +307,8 @@ static void nvmet_tcp_unmap_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 
 	for (i = 0; i < cmd->nr_mapped; i++)
 		kunmap(sg_page(&sg[i]));
+
+	cmd->nr_mapped = 0;
 }
 
 static void nvmet_tcp_map_pdu_iovec(struct nvmet_tcp_cmd *cmd)
@@ -377,7 +391,7 @@ static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *cmd)
 
 	return 0;
 err:
-	sgl_free(cmd->req.sg);
+	nvmet_tcp_free_cmd_buffers(cmd);
 	return NVME_SC_INTERNAL;
 }
 
@@ -628,10 +642,8 @@ static int nvmet_try_send_data(struct nvmet_tcp_cmd *cmd, bool last_in_batch)
 		}
 	}
 
-	if (queue->nvme_sq.sqhd_disabled) {
-		kfree(cmd->iov);
-		sgl_free(cmd->req.sg);
-	}
+	if (queue->nvme_sq.sqhd_disabled)
+		nvmet_tcp_free_cmd_buffers(cmd);
 
 	return 1;
 
@@ -660,8 +672,7 @@ static int nvmet_try_send_response(struct nvmet_tcp_cmd *cmd,
 	if (left)
 		return -EAGAIN;
 
-	kfree(cmd->iov);
-	sgl_free(cmd->req.sg);
+	nvmet_tcp_free_cmd_buffers(cmd);
 	cmd->queue->snd_cmd = NULL;
 	nvmet_tcp_put_cmd(cmd);
 	return 1;
@@ -1422,8 +1433,7 @@ static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd)
 {
 	nvmet_req_uninit(&cmd->req);
 	nvmet_tcp_unmap_pdu_iovec(cmd);
-	kfree(cmd->iov);
-	sgl_free(cmd->req.sg);
+	nvmet_tcp_free_cmd_buffers(cmd);
 }
 
 static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
-- 
2.51.0


