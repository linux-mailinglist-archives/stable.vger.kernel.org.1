Return-Path: <stable+bounces-118858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD53EA41CF3
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 116DE188F0AE
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406A026B2AE;
	Mon, 24 Feb 2025 11:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6arpPlc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9D826B0B8;
	Mon, 24 Feb 2025 11:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395991; cv=none; b=nVPhD5IJQVT2shmXnV2EauNrQlSWo/mSsH5MSrMaG3xiQWHO//okz9jKzfvny8PjX877/oH4jIrsaf8zxe4edex/0T0OeKCOmb6coDyh9HKCHgws6J8YijAh6zD/PMp3SwXIakiFYOsYnsq/QPXcj3lZNgtTLZOxiOkwAGsNVw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395991; c=relaxed/simple;
	bh=doGjVE1V8FGTN6ddb5N6EDVRC6NyPZhLn2QjD3Qu4yw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ABQpU7he4yBGCsY8ARt7SxVUP+nPyogoTMSVGdSUVYtDOaSJ89PcOVZlqsrhbaLdkNvrkxKalw0M6m4nKeJZpUkHeUZ6ueOaGS3k73WjBeK6yFUSmaQQbnFCb4JThUaAOfx8KMtpT1kkuBy2RmFXA2p8y3KTbjifBTzH1Gz6fGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6arpPlc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC5AC4CED6;
	Mon, 24 Feb 2025 11:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395990;
	bh=doGjVE1V8FGTN6ddb5N6EDVRC6NyPZhLn2QjD3Qu4yw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P6arpPlczI142FI/4lWTnk7pWkhs3wJB2nDo/w0uwtiT2rfnRAYEaLXVCrtgIux8E
	 tbN0WWDRa+nJWroHfbDWH9VTE/8ZODD1P/kMW2npMOAlQf8fYj1SHzbe+UnY4pO1my
	 ruXmfIbdGuOxHzFh3pz2oO4ZKUsb+FXEsOy5blfjMaZPZH/3CuNDIAp1sulHP/zdN6
	 OzyqeVTwaFMYzDzEDS6dD/iBP6I3dpWxF5kD3aTJ/DO2QzsDosnDk1W2x0JyliYmPy
	 td5dPTy/uDe3AWzZdu5vhaYNAGjBZtUkL4AAB60hCH7rujJJI06adpHexgTT7/G9KX
	 yKwrZ8Oj3I/pQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maurizio Lombardi <mlombard@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 14/20] nvme-tcp: add basic support for the C2HTermReq PDU
Date: Mon, 24 Feb 2025 06:19:07 -0500
Message-Id: <20250224111914.2214326-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111914.2214326-1-sashal@kernel.org>
References: <20250224111914.2214326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.79
Content-Transfer-Encoding: 8bit

From: Maurizio Lombardi <mlombard@redhat.com>

[ Upstream commit 84e009042d0f3dfe91bec60bcd208ee3f866cbcd ]

Previously, the NVMe/TCP host driver did not handle the C2HTermReq PDU,
instead printing "unsupported pdu type (3)" when received. This patch adds
support for processing the C2HTermReq PDU, allowing the driver
to print the Fatal Error Status field.

Example of output:
nvme nvme4: Received C2HTermReq (FES = Invalid PDU Header Field)

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/tcp.c  | 43 ++++++++++++++++++++++++++++++++++++++++
 include/linux/nvme-tcp.h |  2 ++
 2 files changed, 45 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index be04c5f3856d2..83366a8f0f916 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -707,6 +707,40 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 	return 0;
 }
 
+static void nvme_tcp_handle_c2h_term(struct nvme_tcp_queue *queue,
+		struct nvme_tcp_term_pdu *pdu)
+{
+	u16 fes;
+	const char *msg;
+	u32 plen = le32_to_cpu(pdu->hdr.plen);
+
+	static const char * const msg_table[] = {
+		[NVME_TCP_FES_INVALID_PDU_HDR] = "Invalid PDU Header Field",
+		[NVME_TCP_FES_PDU_SEQ_ERR] = "PDU Sequence Error",
+		[NVME_TCP_FES_HDR_DIGEST_ERR] = "Header Digest Error",
+		[NVME_TCP_FES_DATA_OUT_OF_RANGE] = "Data Transfer Out Of Range",
+		[NVME_TCP_FES_R2T_LIMIT_EXCEEDED] = "R2T Limit Exceeded",
+		[NVME_TCP_FES_UNSUPPORTED_PARAM] = "Unsupported Parameter",
+	};
+
+	if (plen < NVME_TCP_MIN_C2HTERM_PLEN ||
+	    plen > NVME_TCP_MAX_C2HTERM_PLEN) {
+		dev_err(queue->ctrl->ctrl.device,
+			"Received a malformed C2HTermReq PDU (plen = %u)\n",
+			plen);
+		return;
+	}
+
+	fes = le16_to_cpu(pdu->fes);
+	if (fes && fes < ARRAY_SIZE(msg_table))
+		msg = msg_table[fes];
+	else
+		msg = "Unknown";
+
+	dev_err(queue->ctrl->ctrl.device,
+		"Received C2HTermReq (FES = %s)\n", msg);
+}
+
 static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		unsigned int *offset, size_t *len)
 {
@@ -728,6 +762,15 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		return 0;
 
 	hdr = queue->pdu;
+	if (unlikely(hdr->type == nvme_tcp_c2h_term)) {
+		/*
+		 * C2HTermReq never includes Header or Data digests.
+		 * Skip the checks.
+		 */
+		nvme_tcp_handle_c2h_term(queue, (void *)queue->pdu);
+		return -EINVAL;
+	}
+
 	if (queue->hdr_digest) {
 		ret = nvme_tcp_verify_hdgst(queue, queue->pdu, hdr->hlen);
 		if (unlikely(ret))
diff --git a/include/linux/nvme-tcp.h b/include/linux/nvme-tcp.h
index e07e8978d691b..e435250fcb4d0 100644
--- a/include/linux/nvme-tcp.h
+++ b/include/linux/nvme-tcp.h
@@ -13,6 +13,8 @@
 #define NVME_TCP_ADMIN_CCSZ	SZ_8K
 #define NVME_TCP_DIGEST_LENGTH	4
 #define NVME_TCP_MIN_MAXH2CDATA 4096
+#define NVME_TCP_MIN_C2HTERM_PLEN	24
+#define NVME_TCP_MAX_C2HTERM_PLEN	152
 
 enum nvme_tcp_pfv {
 	NVME_TCP_PFV_1_0 = 0x0,
-- 
2.39.5


