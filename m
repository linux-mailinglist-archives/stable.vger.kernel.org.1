Return-Path: <stable+bounces-210667-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iG5HA9lBcGnXXAAAu9opvQ
	(envelope-from <stable+bounces-210667-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 04:02:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA78850303
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 04:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AF1B360BDA1
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 03:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCA8329385;
	Wed, 21 Jan 2026 03:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2uPyxVw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85052D6E71
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 03:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768964561; cv=none; b=YPGYQsI34HUiL7OTrUnv8pQquO7owjXTjfQOtoJpQfOLAMiLShI5QKccM8qn9ZWdP8vD3CMjnt2DuH+PjdbuL3xo+kbt1035mDeRM2YeXqCytNDE0bJo0dSImMrbY5RmH1dyScBJGpjINFZRA/Gn1gGeZhBoMsgoanpbHQ2oUQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768964561; c=relaxed/simple;
	bh=b7K+s21OE6O1qeEgyfwif98PXKaafaMdEIGPnxVYIvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nUfLLIzOFUszDLB+87f1I2h8CRev0Bva7PdfwRWSi8BnAlijGq/UzjQNagVR+/c3nBiE8Cz2fhGXMwjbUEOMpiDYzt7YptbpCVFgXsthZI0ZEvlKUG+a8v3wj1i89HFUnrHotDJuAsxkyn/oboQrH93PYCE1rwFJ9MEpCJpFOZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2uPyxVw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBDF8C19423;
	Wed, 21 Jan 2026 03:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768964561;
	bh=b7K+s21OE6O1qeEgyfwif98PXKaafaMdEIGPnxVYIvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O2uPyxVw+mjv/wMVcYhX4pWnx8ZK4u/VPyfTpEDeYZdmc2JXUZy+YlAOfTKtoxF62
	 0OEvGdF8f9J9+eoHZvSFYobxa9NWq8Byn3hAsNqzbGCTYXSvofHNw3NHa2dMPq4DT8
	 fla5HAGCJY4hCZuxgaQ39AuLOpPtBXqyZzdoYH9ZKelz/esZyshgil2hl6Cwl9ceIg
	 ZGqfz4ZKEryXE5mNpAYgV8IQQoelN2h8MJpMEVTqMTuE/z7/5t30/lBUKCUxKPu/xO
	 +cX5GHUoq9WtNX6PPO9U4UTC5rAQdIJlc/W0gVVDdJGGhvsQ3dIZaoDA0iSbrbOHtN
	 A5XUZN3tuZnXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] nvme-pci: do not directly handle subsys reset fallout
Date: Tue, 20 Jan 2026 22:02:37 -0500
Message-ID: <20260121030238.1163180-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260121030238.1163180-1-sashal@kernel.org>
References: <2026012013-strive-tying-5ac1@gregkh>
 <20260121030238.1163180-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-210667-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: EA78850303
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 210b1f6576e8b367907e7ff51ef425062e1468e4 ]

Scheduling reset_work after a nvme subsystem reset is expected to fail
on pcie, but this also prevents potential handling the platform's pcie
services may provide that might successfully recovering the link without
re-enumeration. Such examples include AER, DPC, and power's EEH.

Provide a pci specific operation that safely initiates a subsystem
reset, and instead of scheduling reset work, read back the status
register to trigger a pcie read error.

Since this only affects pci, the other fabrics drivers subscribe to a
generic nvmf subsystem reset that is exactly the same as before. The
loop fabric doesn't use it because nvmet doesn't support setting that
property anyway.

And since we're using the magic NSSR value in two places now, provide a
symbolic define for it.

Reported-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Stable-dep-of: 0edb475ac0a7 ("nvme: fix PCIe subsystem reset controller state transition")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/fabrics.c | 15 +++++++++++++++
 drivers/nvme/host/fabrics.h |  1 +
 drivers/nvme/host/fc.c      |  1 +
 drivers/nvme/host/nvme.h    | 14 +++-----------
 drivers/nvme/host/pci.c     | 36 ++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/rdma.c    |  1 +
 drivers/nvme/host/tcp.c     |  1 +
 include/linux/nvme.h        |  3 +++
 8 files changed, 61 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 668c6bb7a567f..d4028c669a2bb 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -254,6 +254,21 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 }
 EXPORT_SYMBOL_GPL(nvmf_reg_write32);
 
+int nvmf_subsystem_reset(struct nvme_ctrl *ctrl)
+{
+	int ret;
+
+	if (!nvme_wait_reset(ctrl))
+		return -EBUSY;
+
+	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_NSSR, NVME_SUBSYS_RESET);
+	if (ret)
+		return ret;
+
+	return nvme_try_sched_reset(ctrl);
+}
+EXPORT_SYMBOL_GPL(nvmf_subsystem_reset);
+
 /**
  * nvmf_log_connect_error() - Error-parsing-diagnostic print out function for
  * 				connect() errors.
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 561c2abd3892b..f727f846ec34e 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -182,6 +182,7 @@ nvmf_ctlr_matches_baseopts(struct nvme_ctrl *ctrl,
 int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val);
 int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val);
 int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val);
+int nvmf_subsystem_reset(struct nvme_ctrl *ctrl);
 int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl);
 int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid);
 int nvmf_register_transport(struct nvmf_transport_ops *ops);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index ebca6244a96c3..ac1e4482011ee 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3361,6 +3361,7 @@ static const struct nvme_ctrl_ops nvme_fc_ctrl_ops = {
 	.reg_read32		= nvmf_reg_read32,
 	.reg_read64		= nvmf_reg_read64,
 	.reg_write32		= nvmf_reg_write32,
+	.subsystem_reset	= nvmf_subsystem_reset,
 	.free_ctrl		= nvme_fc_free_ctrl,
 	.submit_async_event	= nvme_fc_submit_async_event,
 	.delete_ctrl		= nvme_fc_delete_ctrl,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index c8ec0e146c8cb..c6cd3d65065c8 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -514,6 +514,7 @@ struct nvme_ctrl_ops {
 	int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 *val);
 	void (*free_ctrl)(struct nvme_ctrl *ctrl);
 	void (*submit_async_event)(struct nvme_ctrl *ctrl);
+	int (*subsystem_reset)(struct nvme_ctrl *ctrl);
 	void (*delete_ctrl)(struct nvme_ctrl *ctrl);
 	void (*stop_ctrl)(struct nvme_ctrl *ctrl);
 	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
@@ -583,18 +584,9 @@ int nvme_try_sched_reset(struct nvme_ctrl *ctrl);
 
 static inline int nvme_reset_subsystem(struct nvme_ctrl *ctrl)
 {
-	int ret;
-
-	if (!ctrl->subsystem)
+	if (!ctrl->subsystem || !ctrl->ops->subsystem_reset)
 		return -ENOTTY;
-	if (!nvme_wait_reset(ctrl))
-		return -EBUSY;
-
-	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_NSSR, 0x4E564D65);
-	if (ret)
-		return ret;
-
-	return nvme_try_sched_reset(ctrl);
+	return ctrl->ops->subsystem_reset(ctrl);
 }
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 740709ee08529..0fd88317bbf1f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1121,6 +1121,41 @@ static void nvme_pci_submit_async_event(struct nvme_ctrl *ctrl)
 	spin_unlock(&nvmeq->sq_lock);
 }
 
+static int nvme_pci_subsystem_reset(struct nvme_ctrl *ctrl)
+{
+	struct nvme_dev *dev = to_nvme_dev(ctrl);
+	int ret = 0;
+
+	/*
+	 * Taking the shutdown_lock ensures the BAR mapping is not being
+	 * altered by reset_work. Holding this lock before the RESETTING state
+	 * change, if successful, also ensures nvme_remove won't be able to
+	 * proceed to iounmap until we're done.
+	 */
+	mutex_lock(&dev->shutdown_lock);
+	if (!dev->bar_mapped_size) {
+		ret = -ENODEV;
+		goto unlock;
+	}
+
+	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	writel(NVME_SUBSYS_RESET, dev->bar + NVME_REG_NSSR);
+	nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE);
+
+	/*
+	 * Read controller status to flush the previous write and trigger a
+	 * pcie read error.
+	 */
+	readl(dev->bar + NVME_REG_CSTS);
+unlock:
+	mutex_unlock(&dev->shutdown_lock);
+	return ret;
+}
+
 static int adapter_delete_queue(struct nvme_dev *dev, u8 opcode, u16 id)
 {
 	struct nvme_command c = { };
@@ -2905,6 +2940,7 @@ static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 	.reg_read64		= nvme_pci_reg_read64,
 	.free_ctrl		= nvme_pci_free_ctrl,
 	.submit_async_event	= nvme_pci_submit_async_event,
+	.subsystem_reset	= nvme_pci_subsystem_reset,
 	.get_address		= nvme_pci_get_address,
 };
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 6e92bdf459fe4..00c6924bf5f94 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2287,6 +2287,7 @@ static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
 	.reg_read32		= nvmf_reg_read32,
 	.reg_read64		= nvmf_reg_read64,
 	.reg_write32		= nvmf_reg_write32,
+	.subsystem_reset	= nvmf_subsystem_reset,
 	.free_ctrl		= nvme_rdma_free_ctrl,
 	.submit_async_event	= nvme_rdma_submit_async_event,
 	.delete_ctrl		= nvme_rdma_delete_ctrl,
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 99bf17f2dcfca..1be8f7867a064 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2559,6 +2559,7 @@ static const struct nvme_ctrl_ops nvme_tcp_ctrl_ops = {
 	.reg_read32		= nvmf_reg_read32,
 	.reg_read64		= nvmf_reg_read64,
 	.reg_write32		= nvmf_reg_write32,
+	.subsystem_reset	= nvmf_subsystem_reset,
 	.free_ctrl		= nvme_tcp_free_ctrl,
 	.submit_async_event	= nvme_tcp_submit_async_event,
 	.delete_ctrl		= nvme_tcp_delete_ctrl,
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 537cc5b7e0500..94fa0184c153f 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -27,6 +27,9 @@
 
 #define NVME_NSID_ALL		0xffffffff
 
+/* Special NSSR value, 'NVMe' */
+#define NVME_SUBSYS_RESET	0x4E564D65
+
 enum nvme_subsys_type {
 	NVME_NQN_DISC	= 1,		/* Discovery type target subsystem */
 	NVME_NQN_NVME	= 2,		/* NVME type target subsystem */
-- 
2.51.0


