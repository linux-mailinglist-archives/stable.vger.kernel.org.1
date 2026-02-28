Return-Path: <stable+bounces-220431-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EP+AOH02o2nP+QQAu9opvQ
	(envelope-from <stable+bounces-220431-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:39:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5491C6169
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 560B33087633
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396743B3C03;
	Sat, 28 Feb 2026 17:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6vj0w/h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC503B3BF9;
	Sat, 28 Feb 2026 17:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300321; cv=none; b=HkrqEiua3My+wlSI2G1VT8L3qr7zENtDg2AD6NPCmnHxHYvbUnTCcGbiJkdTB9YJr4VlodSReb/lfQKX9etVhfTVWwGQgDo2p90X8jxrgJYAVrenHQYXvBFBRvjCbG+eVuKfd/SYO6ackEgxZ7lrC9Dl+HHI9ODpOuH8yXEfv+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300321; c=relaxed/simple;
	bh=l7MNXpfxHs18FIzzszA7gfEIQrfQvlOn0TBRcP4V6i4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rl+QIslZiEFhzpVhds224rNkRVSGW9HRjDVDflh6+JFrBvGt9mA3wxFFe22LWANi9asDNVRQvIzbVB83otvPuIVoTvLTYP2ACEnNguGv0rgrPboFEGLig4NVIiCtNyVQqCe//8fSy6R2IR6nuxL90xq7vgmRLWCU/uvIsvIWUOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6vj0w/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32424C19424;
	Sat, 28 Feb 2026 17:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300320;
	bh=l7MNXpfxHs18FIzzszA7gfEIQrfQvlOn0TBRcP4V6i4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U6vj0w/hjvDvo8eu2a75uUiCbbE45d1dtjR1+j+p9VMva1rTXrAnCkYO+ABEIjHuw
	 GBClhex4nZYAyolvuYmOkLnfcaQ92DAO7aFJ8MA68/+b1cLeqsUXm+rGhEwhWNt5M0
	 thwIW8YRl2t9gT3stVwc0il2J+YK0qcOtyydMjmEuZCcHrRbtHZlEdwLy0OscOBo/J
	 Pzrg7RkNo9Ilk6mI5fDLSEsIbB54jeopjugYRkXW8sJ/FzGxwaRpzCZPHh/qp0qE86
	 nfs3eB8Jbaeiqm2OJOiLxSgeFMqHNVADrbzyg7hB6nVwbMID2xm6179zVdMx3ndR7j
	 14PN0JU3GpUzA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Valentina Fernandez <valentina.fernandezalanis@microchip.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 352/844] mailbox: mchp-ipc-sbi: fix out-of-bounds access in mchp_ipc_get_cluster_aggr_irq()
Date: Sat, 28 Feb 2026 12:24:25 -0500
Message-ID: <20260228173244.1509663-353-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220431-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5C5491C6169
X-Rspamd-Action: no action

From: Valentina Fernandez <valentina.fernandezalanis@microchip.com>

[ Upstream commit f7c330a8c83c9b0332fd524097eaf3e69148164d ]

The cluster_cfg array is dynamically allocated to hold per-CPU
configuration structures, with its size based on the number of online
CPUs. Previously, this array was indexed using hartid, which may be
non-contiguous or exceed the bounds of the array, leading to
out-of-bounds access.
Switch to using cpuid as the index, as it is guaranteed to be within
the valid range provided by for_each_online_cpu().

Signed-off-by: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/mailbox-mchp-ipc-sbi.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/mailbox/mailbox-mchp-ipc-sbi.c b/drivers/mailbox/mailbox-mchp-ipc-sbi.c
index a6e52009a4245..d444491a584e8 100644
--- a/drivers/mailbox/mailbox-mchp-ipc-sbi.c
+++ b/drivers/mailbox/mailbox-mchp-ipc-sbi.c
@@ -180,20 +180,20 @@ static irqreturn_t mchp_ipc_cluster_aggr_isr(int irq, void *data)
 	/* Find out the hart that originated the irq */
 	for_each_online_cpu(i) {
 		hartid = cpuid_to_hartid_map(i);
-		if (irq == ipc->cluster_cfg[hartid].irq)
+		if (irq == ipc->cluster_cfg[i].irq)
 			break;
 	}
 
 	status_msg.cluster = hartid;
-	memcpy(ipc->cluster_cfg[hartid].buf_base, &status_msg, sizeof(struct mchp_ipc_status));
+	memcpy(ipc->cluster_cfg[i].buf_base, &status_msg, sizeof(struct mchp_ipc_status));
 
-	ret = mchp_ipc_sbi_send(SBI_EXT_IPC_STATUS, ipc->cluster_cfg[hartid].buf_base_addr);
+	ret = mchp_ipc_sbi_send(SBI_EXT_IPC_STATUS, ipc->cluster_cfg[i].buf_base_addr);
 	if (ret < 0) {
 		dev_err_ratelimited(ipc->dev, "could not get IHC irq status ret=%d\n", ret);
 		return IRQ_HANDLED;
 	}
 
-	memcpy(&status_msg, ipc->cluster_cfg[hartid].buf_base, sizeof(struct mchp_ipc_status));
+	memcpy(&status_msg, ipc->cluster_cfg[i].buf_base, sizeof(struct mchp_ipc_status));
 
 	/*
 	 * Iterate over each bit set in the IHC interrupt status register (IRQ_STATUS) to identify
@@ -385,21 +385,21 @@ static int mchp_ipc_get_cluster_aggr_irq(struct mchp_ipc_sbi_mbox *ipc)
 		if (ret <= 0)
 			continue;
 
-		ipc->cluster_cfg[hartid].irq = ret;
-		ret = devm_request_irq(ipc->dev, ipc->cluster_cfg[hartid].irq,
+		ipc->cluster_cfg[cpuid].irq = ret;
+		ret = devm_request_irq(ipc->dev, ipc->cluster_cfg[cpuid].irq,
 				       mchp_ipc_cluster_aggr_isr, IRQF_SHARED,
 				       "miv-ihc-irq", ipc);
 		if (ret)
 			return ret;
 
-		ipc->cluster_cfg[hartid].buf_base = devm_kmalloc(ipc->dev,
-								 sizeof(struct mchp_ipc_status),
-								 GFP_KERNEL);
+		ipc->cluster_cfg[cpuid].buf_base = devm_kmalloc(ipc->dev,
+								sizeof(struct mchp_ipc_status),
+								GFP_KERNEL);
 
-		if (!ipc->cluster_cfg[hartid].buf_base)
+		if (!ipc->cluster_cfg[cpuid].buf_base)
 			return -ENOMEM;
 
-		ipc->cluster_cfg[hartid].buf_base_addr = __pa(ipc->cluster_cfg[hartid].buf_base);
+		ipc->cluster_cfg[cpuid].buf_base_addr = __pa(ipc->cluster_cfg[cpuid].buf_base);
 
 		irq_found = true;
 	}
-- 
2.51.0


