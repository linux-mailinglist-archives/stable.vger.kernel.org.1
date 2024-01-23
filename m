Return-Path: <stable+bounces-14482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 999D1838118
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 396091F23E97
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087EE140786;
	Tue, 23 Jan 2024 01:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SP+LtnVd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB841140781;
	Tue, 23 Jan 2024 01:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705972022; cv=none; b=t6iX0ouRrzAw8oNvDIkvtNvfpYIcfObQPBj5c2AwwRuXOKz4TwmGrQJcvJcZzWzmzW5BGakOEh8mbVKqX4eZ0H4kBsMmJx2dURbh2SwwCaXBiZl5VvS9yHq7GXF4UArj1LheWDJxY/56dZLGFSowYfym1wjF2L8zla0u8+jgEMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705972022; c=relaxed/simple;
	bh=XjTUgQyD6AVcuEBMGIJYoGPtN1UeieSvV8d8Kb5W2I8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b0QabmLq/q8N5DDxxHRLNsJ44aMHWHABL5+9mLZsxQ78Ls41bUI6Gtl5wl0qzcUoZorRb0mUYiuFg+KZ3fUdbjZLX4jLAWcbTsrD43SwRdNvJFo1zrVTDASYON7RwOujt+6nhMwHWg+mhA7M09xqJ6dpNkTZeX/gFaF8mQId10U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SP+LtnVd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3ACC433C7;
	Tue, 23 Jan 2024 01:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705972022;
	bh=XjTUgQyD6AVcuEBMGIJYoGPtN1UeieSvV8d8Kb5W2I8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SP+LtnVdLFylYIeQ9qDF2RoCrrj8sQf4vox76meUj9h6i0QhdudbS4mqNS0Zit7ub
	 ecCoy6oNFu1b66h6NpvhaJ9Dds+iMZRIzrDRiaG9UckM73oyQLbnlQ20zIojeNLLAk
	 Xrq/hVlMXiWn6PX8KgcC5paKDEhwTwmnZJkRiTbU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maurizio Lombardi <mlombard@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 364/417] nvmet-tcp: Fix a kernel panic when host sends an invalid H2C PDU length
Date: Mon, 22 Jan 2024 15:58:52 -0800
Message-ID: <20240122235804.430055801@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235751.480367507@linuxfoundation.org>
References: <20240122235751.480367507@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maurizio Lombardi <mlombard@redhat.com>

[ Upstream commit efa56305908ba20de2104f1b8508c6a7401833be ]

If the host sends an H2CData command with an invalid DATAL,
the kernel may crash in nvmet_tcp_build_pdu_iovec().

Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000000
lr : nvmet_tcp_io_work+0x6ac/0x718 [nvmet_tcp]
Call trace:
  process_one_work+0x174/0x3c8
  worker_thread+0x2d0/0x3e8
  kthread+0x104/0x110

Fix the bug by raising a fatal error if DATAL isn't coherent
with the packet size.
Also, the PDU length should never exceed the MAXH2CDATA parameter which
has been communicated to the host in nvmet_tcp_handle_icreq().

Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/tcp.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 355d80323b83..7310f65af849 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -18,6 +18,7 @@
 #include "nvmet.h"
 
 #define NVMET_TCP_DEF_INLINE_DATA_SIZE	(4 * PAGE_SIZE)
+#define NVMET_TCP_MAXH2CDATA		0x400000 /* 16M arbitrary limit */
 
 /* Define the socket priority to use for connections were it is desirable
  * that the NIC consider performing optimized packet processing or filtering.
@@ -861,7 +862,7 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_queue *queue)
 	icresp->hdr.pdo = 0;
 	icresp->hdr.plen = cpu_to_le32(icresp->hdr.hlen);
 	icresp->pfv = cpu_to_le16(NVME_TCP_PFV_1_0);
-	icresp->maxdata = cpu_to_le32(0x400000); /* 16M arbitrary limit */
+	icresp->maxdata = cpu_to_le32(NVMET_TCP_MAXH2CDATA);
 	icresp->cpda = 0;
 	if (queue->hdr_digest)
 		icresp->digest |= NVME_TCP_HDR_DIGEST_ENABLE;
@@ -914,6 +915,7 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 {
 	struct nvme_tcp_data_pdu *data = &queue->pdu.data;
 	struct nvmet_tcp_cmd *cmd;
+	unsigned int plen;
 
 	if (likely(queue->nr_cmds)) {
 		if (unlikely(data->ttag >= queue->nr_cmds)) {
@@ -937,7 +939,16 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 		return -EPROTO;
 	}
 
+	plen = le32_to_cpu(data->hdr.plen);
 	cmd->pdu_len = le32_to_cpu(data->data_length);
+	if (unlikely(cmd->pdu_len != (plen - sizeof(*data)) ||
+		     cmd->pdu_len == 0 ||
+		     cmd->pdu_len > NVMET_TCP_MAXH2CDATA)) {
+		pr_err("H2CData PDU len %u is invalid\n", cmd->pdu_len);
+		/* FIXME: use proper transport errors */
+		nvmet_tcp_fatal_error(queue);
+		return -EPROTO;
+	}
 	cmd->pdu_recv = 0;
 	nvmet_tcp_build_pdu_iovec(cmd);
 	queue->cmd = cmd;
-- 
2.43.0




