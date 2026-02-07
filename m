Return-Path: <stable+bounces-214826-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Ts7KAnuYh2mraQQAu9opvQ
	(envelope-from <stable+bounces-214826-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 20:54:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDC3106FD5
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 20:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CC87301700F
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 19:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882832E1758;
	Sat,  7 Feb 2026 19:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0daHQj/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB393D544
	for <stable@vger.kernel.org>; Sat,  7 Feb 2026 19:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770494070; cv=none; b=m0raqmC5GGkZguF8RWzOlWwgqOxNkLRkJ7LZaSJtZhdVnCGY17ogC5ftRfjLSSNHi+my01T+xrKD3ov5iX2jGPQ7OTSY6MX43uoPDdDs83b2ioKGrfCZYyCVl6ZU817EO1NnIiqJzQiQlVaoTxSIAD5fj2899PJ2pr/0iil+Dvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770494070; c=relaxed/simple;
	bh=NihzeIaDcCdjEy0sGVfr5bSWgNwN/lew1mwTcVcX1WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r+LR/Trv7TifrI1/5pbnaUlHlgqfcukmDbveUNYSffVd+ijpep1tAwnyDE2fy48g3u+bY+usd+w2H6athkRXlmPo54KeNJPVq5vpS2GC6MzqY+0KNIqP1fEWzKaF3x3mDyAQYSYmQvketOENCizir6UMO0m3FHK2T+lmtyxX5Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0daHQj/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0375C116D0;
	Sat,  7 Feb 2026 19:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770494069;
	bh=NihzeIaDcCdjEy0sGVfr5bSWgNwN/lew1mwTcVcX1WQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z0daHQj/G8Vy9TXHBYLIAQnE+VOi4Mbm+1p/sopjsNS6Df08iuABvAJm+u8OlmGmd
	 aCjNSg7v/Yi+aUldY1cUmO4MxkjSL893lQTZIAB2EckG08geQFVFMm+jwFj70AQ83A
	 oKigodglBowXT7FPcFfMAqnqnuhVp38YouipXsKV31Vbrw0FIw5TLAEd5W/MnrNXKN
	 dXyr9ddm4+gpeE66VztTmq3fL86aL+t7tTUstvakbsa29+Z/rE3wl2yHnE9zK1u14f
	 WktlJiHX4+aAvm2DI71qf43EJg9kwMnVgkerE0zsPw/9McF23NUkahUZK4vAaBrmmE
	 BKvOLv6thWxLg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Maurizio Lombardi <mlombard@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	John Meneghini <jmeneghi@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/5] nvmet-tcp: add an helper to free the cmd buffers
Date: Sat,  7 Feb 2026 14:54:19 -0500
Message-ID: <20260207195423.535763-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026020740-kiln-galvanize-65e4@gregkh>
References: <2026020740-kiln-galvanize-65e4@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214826-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[grimberg.me:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4FDC3106FD5
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
index 051798ef7431c..7eb4d06f12294 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -167,6 +167,8 @@ static struct workqueue_struct *nvmet_tcp_wq;
 static const struct nvmet_fabrics_ops nvmet_tcp_ops;
 static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
 static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd);
+static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd);
+static void nvmet_tcp_unmap_pdu_iovec(struct nvmet_tcp_cmd *cmd);
 
 static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
 		struct nvmet_tcp_cmd *cmd)
@@ -298,6 +300,16 @@ static int nvmet_tcp_check_ddgst(struct nvmet_tcp_queue *queue, void *pdu)
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
@@ -307,6 +319,8 @@ static void nvmet_tcp_unmap_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 
 	for (i = 0; i < cmd->nr_mapped; i++)
 		kunmap(sg_page(&sg[i]));
+
+	cmd->nr_mapped = 0;
 }
 
 static void nvmet_tcp_map_pdu_iovec(struct nvmet_tcp_cmd *cmd)
@@ -389,7 +403,7 @@ static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *cmd)
 
 	return 0;
 err:
-	sgl_free(cmd->req.sg);
+	nvmet_tcp_free_cmd_buffers(cmd);
 	return NVME_SC_INTERNAL;
 }
 
@@ -640,10 +654,8 @@ static int nvmet_try_send_data(struct nvmet_tcp_cmd *cmd, bool last_in_batch)
 		}
 	}
 
-	if (queue->nvme_sq.sqhd_disabled) {
-		kfree(cmd->iov);
-		sgl_free(cmd->req.sg);
-	}
+	if (queue->nvme_sq.sqhd_disabled)
+		nvmet_tcp_free_cmd_buffers(cmd);
 
 	return 1;
 
@@ -672,8 +684,7 @@ static int nvmet_try_send_response(struct nvmet_tcp_cmd *cmd,
 	if (left)
 		return -EAGAIN;
 
-	kfree(cmd->iov);
-	sgl_free(cmd->req.sg);
+	nvmet_tcp_free_cmd_buffers(cmd);
 	cmd->queue->snd_cmd = NULL;
 	nvmet_tcp_put_cmd(cmd);
 	return 1;
@@ -1452,8 +1463,7 @@ static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd)
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


