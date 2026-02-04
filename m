Return-Path: <stable+bounces-213523-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPmlERFdg2mJlQMAu9opvQ
	(envelope-from <stable+bounces-213523-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:52:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 804F1E77C9
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 870303033E7E
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 14:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D6927B359;
	Wed,  4 Feb 2026 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VIXWZAmC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBCC2C0263;
	Wed,  4 Feb 2026 14:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216620; cv=none; b=nKr3vLmfAzE+4F2sppXXvKdNLLqk/GRf30CF/efzposJXoVx0sfFNw+xiZX+rjtESIXC/PSioIGNbK4AXV6E96BsvUkIUZ5Ub24RAYXuTmD0G3eKqhBdP3KKJkTloPaRRCS6WkQr1VYEKRu9wV+Mxj50SMX3XIRWJ++ikzzBPNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216620; c=relaxed/simple;
	bh=w+9LFOZ1YCu7AmE0+FHMPPvYQgN4SrRmqkZnc7Tl3ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JR1+88e/xODEfbkI69umbGZJm3TOFfn7JneB+t8Vjl29MggNOQ2zof97VeVKyzu/m6MwWm3juVl8Wxzt/V9/+YCCQuH/rM1aXmkl+GZ+OMVjpjR+O5wQqlN1Frivv9PtHJvZp9QaSPQr59hcfCh78zDeKb6xMF3uVNoASOyWQhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VIXWZAmC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C6EC4CEF7;
	Wed,  4 Feb 2026 14:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770216620;
	bh=w+9LFOZ1YCu7AmE0+FHMPPvYQgN4SrRmqkZnc7Tl3ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VIXWZAmCMlRxsSvA7qcX+p0D3vgD8RFTfifEFUkKiRgZbR/d+JYUpHiXs/+0S4bKh
	 2+ZQ3aOSoPaifd25D85wCY5WisHQ/zQaF0Ff7/RXMKYSnBnIPpWG2GcdnauhDebTgA
	 HWq/Gg0PKjU6LaUMoveXe1bUvroazdcRK7wslZ6Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nilay Shroff <nilay@linux.ibm.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 135/161] nvme-pci: do not directly handle subsys reset fallout
Date: Wed,  4 Feb 2026 15:39:58 +0100
Message-ID: <20260204143856.600107602@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.755002596@linuxfoundation.org>
References: <20260204143851.755002596@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213523-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: 804F1E77C9
X-Rspamd-Action: no action

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/fabrics.c |   15 +++++++++++++++
 drivers/nvme/host/fabrics.h |    1 +
 drivers/nvme/host/fc.c      |    1 +
 drivers/nvme/host/nvme.h    |   14 +++-----------
 drivers/nvme/host/pci.c     |   36 ++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/rdma.c    |    1 +
 drivers/nvme/host/tcp.c     |    1 +
 include/linux/nvme.h        |    3 +++
 8 files changed, 61 insertions(+), 11 deletions(-)

--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -253,6 +253,21 @@ int nvmf_reg_write32(struct nvme_ctrl *c
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
  * nvmf_log_connect_error() - Error-parsing-diagnostic print
  * out function for connect() errors.
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -166,6 +166,7 @@ nvmf_ctlr_matches_baseopts(struct nvme_c
 int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val);
 int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val);
 int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val);
+int nvmf_subsystem_reset(struct nvme_ctrl *ctrl);
 int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl);
 int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid, bool poll);
 int nvmf_register_transport(struct nvmf_transport_ops *ops);
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3350,6 +3350,7 @@ static const struct nvme_ctrl_ops nvme_f
 	.reg_read32		= nvmf_reg_read32,
 	.reg_read64		= nvmf_reg_read64,
 	.reg_write32		= nvmf_reg_write32,
+	.subsystem_reset	= nvmf_subsystem_reset,
 	.free_ctrl		= nvme_fc_free_ctrl,
 	.submit_async_event	= nvme_fc_submit_async_event,
 	.delete_ctrl		= nvme_fc_delete_ctrl,
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -485,6 +485,7 @@ struct nvme_ctrl_ops {
 	int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 *val);
 	void (*free_ctrl)(struct nvme_ctrl *ctrl);
 	void (*submit_async_event)(struct nvme_ctrl *ctrl);
+	int (*subsystem_reset)(struct nvme_ctrl *ctrl);
 	void (*delete_ctrl)(struct nvme_ctrl *ctrl);
 	void (*stop_ctrl)(struct nvme_ctrl *ctrl);
 	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
@@ -554,18 +555,9 @@ int nvme_try_sched_reset(struct nvme_ctr
 
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
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1123,6 +1123,41 @@ static void nvme_pci_submit_async_event(
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
 	struct nvme_command c;
@@ -2844,6 +2879,7 @@ static const struct nvme_ctrl_ops nvme_p
 	.reg_read64		= nvme_pci_reg_read64,
 	.free_ctrl		= nvme_pci_free_ctrl,
 	.submit_async_event	= nvme_pci_submit_async_event,
+	.subsystem_reset	= nvme_pci_subsystem_reset,
 	.get_address		= nvme_pci_get_address,
 };
 
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2293,6 +2293,7 @@ static const struct nvme_ctrl_ops nvme_r
 	.reg_read32		= nvmf_reg_read32,
 	.reg_read64		= nvmf_reg_read64,
 	.reg_write32		= nvmf_reg_write32,
+	.subsystem_reset	= nvmf_subsystem_reset,
 	.free_ctrl		= nvme_rdma_free_ctrl,
 	.submit_async_event	= nvme_rdma_submit_async_event,
 	.delete_ctrl		= nvme_rdma_delete_ctrl,
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2530,6 +2530,7 @@ static const struct nvme_ctrl_ops nvme_t
 	.reg_read32		= nvmf_reg_read32,
 	.reg_read64		= nvmf_reg_read64,
 	.reg_write32		= nvmf_reg_write32,
+	.subsystem_reset	= nvmf_subsystem_reset,
 	.free_ctrl		= nvme_tcp_free_ctrl,
 	.submit_async_event	= nvme_tcp_submit_async_event,
 	.delete_ctrl		= nvme_tcp_delete_ctrl,
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



