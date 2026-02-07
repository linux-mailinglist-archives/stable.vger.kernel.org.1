Return-Path: <stable+bounces-214828-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHObAoCYh2mraQQAu9opvQ
	(envelope-from <stable+bounces-214828-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 20:54:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDA8106FE3
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 20:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54F563016CA5
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 19:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F012B2E1758;
	Sat,  7 Feb 2026 19:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAYJn7/z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B073D544
	for <stable@vger.kernel.org>; Sat,  7 Feb 2026 19:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770494074; cv=none; b=F2KcND7xjDKcRUo/v354ze4TI5UnNAGI0bW2QpJyQv/a6yEnt9p97Avwt6bOoIyqRl8AV96YX6RRBJeuA+AwzSN7lURsdPQCajBMn1dYU04Z8RhZLVGnU+iNhPnxsW/2PtTDhgpKE7qQY++C2C74w1HV+lXEaBz+AK1PjlyyzRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770494074; c=relaxed/simple;
	bh=nu4gzIj5eauhyq1GXuL05KVL98v15yBjrDqf8KzEsbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QOkk2wGMjCZVE+Nl2iECd03lvGG/AUiMiLIQproPLri5qnvMDaAdbk44pJ2R8jIsdyZySzFhgzSbTAvaHxEVOqp6Lmj46D4FSwYfmYsednfBMEEfGOz9pQ/OOzM32hmmDGqmuF+1lNoaJbUezqBJxoEUxwcFOC0w2HyJAYLzouI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAYJn7/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0372AC16AAE;
	Sat,  7 Feb 2026 19:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770494074;
	bh=nu4gzIj5eauhyq1GXuL05KVL98v15yBjrDqf8KzEsbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IAYJn7/zVP4PE+Fg+PnqggJmWyoylfNnqB/iTYCGRIEoY1fOkvYgG0XfHoUYWETPG
	 MWVI5sNvG1bPAqpQ9H3JffiguRxLTaSU/j2bv2uY/uz7Cmf4/FDbtdK5yuPkcYqYEE
	 nA35Tue/PmUe+E/dFHKzbare1Rja3b6o5peeU5v/Mm7n9PmCC71O2V+N4TlFAoTYr6
	 EqOhWGoVMKdCyFu37YLcUY+tOw6gykwGBVblF+Y06xOd6pLDiIof4f5Hdf15fah3gS
	 AAjpnBqqUm1MOqQYOlIDiyuH2liWd1MhaX0f6hFvoc1ilGndqudlcyqFzxR6kJTLDo
	 /wmzbI8Ojgq1w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/5] nvmet-tcp: fix regression in data_digest calculation
Date: Sat,  7 Feb 2026 14:54:21 -0500
Message-ID: <20260207195423.535763-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260207195423.535763-1-sashal@kernel.org>
References: <2026020740-kiln-galvanize-65e4@gregkh>
 <20260207195423.535763-1-sashal@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214828-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[grimberg.me:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9EDA8106FE3
X-Rspamd-Action: no action

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit ed0691cf55140ce0f3fb100225645d902cce904b ]

Data digest calculation iterates over command mapped iovec. However
since commit bac04454ef9f we unmap the iovec before we handle the data
digest, and since commit 69b85e1f1d1d we clear nr_mapped when we unmap
the iov.

Instead of open-coding the command iov traversal, simply call
crypto_ahash_digest with the command sg that is already allocated (we
already do that for the send path). Rename nvmet_tcp_send_ddgst to
nvmet_tcp_calc_ddgst and call it from send and recv paths.

Fixes: 69b85e1f1d1d ("nvmet-tcp: add an helper to free the cmd buffers")
Fixes: bac04454ef9f ("nvmet-tcp: fix kmap leak when data digest in use")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Stable-dep-of: 52a0a9854934 ("nvmet-tcp: add bounds checks in nvmet_tcp_build_pdu_iovec")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/tcp.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index bf3585652c681..3b32f1e9c18c6 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -407,7 +407,7 @@ static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *cmd)
 	return NVME_SC_INTERNAL;
 }
 
-static void nvmet_tcp_send_ddgst(struct ahash_request *hash,
+static void nvmet_tcp_calc_ddgst(struct ahash_request *hash,
 		struct nvmet_tcp_cmd *cmd)
 {
 	ahash_request_set_crypt(hash, cmd->req.sg,
@@ -415,23 +415,6 @@ static void nvmet_tcp_send_ddgst(struct ahash_request *hash,
 	crypto_ahash_digest(hash);
 }
 
-static void nvmet_tcp_recv_ddgst(struct ahash_request *hash,
-		struct nvmet_tcp_cmd *cmd)
-{
-	struct scatterlist sg;
-	struct kvec *iov;
-	int i;
-
-	crypto_ahash_init(hash);
-	for (i = 0, iov = cmd->iov; i < cmd->nr_mapped; i++, iov++) {
-		sg_init_one(&sg, iov->iov_base, iov->iov_len);
-		ahash_request_set_crypt(hash, &sg, NULL, iov->iov_len);
-		crypto_ahash_update(hash);
-	}
-	ahash_request_set_crypt(hash, NULL, (void *)&cmd->exp_ddgst, 0);
-	crypto_ahash_final(hash);
-}
-
 static void nvmet_setup_c2h_data_pdu(struct nvmet_tcp_cmd *cmd)
 {
 	struct nvme_tcp_data_pdu *pdu = cmd->data_pdu;
@@ -456,7 +439,7 @@ static void nvmet_setup_c2h_data_pdu(struct nvmet_tcp_cmd *cmd)
 
 	if (queue->data_digest) {
 		pdu->hdr.flags |= NVME_TCP_F_DDGST;
-		nvmet_tcp_send_ddgst(queue->snd_hash, cmd);
+		nvmet_tcp_calc_ddgst(queue->snd_hash, cmd);
 	}
 
 	if (cmd->queue->hdr_digest) {
@@ -1168,7 +1151,7 @@ static void nvmet_tcp_prep_recv_ddgst(struct nvmet_tcp_cmd *cmd)
 {
 	struct nvmet_tcp_queue *queue = cmd->queue;
 
-	nvmet_tcp_recv_ddgst(queue->rcv_hash, cmd);
+	nvmet_tcp_calc_ddgst(queue->rcv_hash, cmd);
 	queue->offset = 0;
 	queue->left = NVME_TCP_DIGEST_LENGTH;
 	queue->rcv_state = NVMET_TCP_RECV_DDGST;
-- 
2.51.0


