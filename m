Return-Path: <stable+bounces-220434-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DJ2CAo7o2nO+gQAu9opvQ
	(envelope-from <stable+bounces-220434-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:59:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 713F91C67C6
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04B36310EEA3
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384693B4492;
	Sat, 28 Feb 2026 17:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4nu0aP8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1BF3B4489;
	Sat, 28 Feb 2026 17:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300324; cv=none; b=MWgJn4cdh4xhb9znP7PfTAeIaGasXDt/iV5fcMkjJ8k+cDPNXpY2mS9LSDGywq4hJUWYFUizzYK+BArTMifjuWKdRLXS3wD6p8IWyjlpgOhU8Lq8MVHxINV2W55/QVtQ8WxYZlj1rurSrX982K2uYyMzdUbTW3yu1dKiHEjFgsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300324; c=relaxed/simple;
	bh=aLpQTaDCsoaCt2G3eAu3tYCXL6/FwZb475hYCkU+bTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eX01DqG2EH2lHLZTfGhERwqU4027+QH3uunkCyDrqoIGt0xrg1z9oWsavXRQSnZA+OR/KSVVcPyV3NMLw2F2mXxXK29+ITwkofTnw5wZvLkmLFSa5XfYuWbdT+mhcMIHx71O06iYYkcTOqrSbphEdEK7iejtSA/Vb9SJAXaI2A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4nu0aP8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F85FC116D0;
	Sat, 28 Feb 2026 17:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300323;
	bh=aLpQTaDCsoaCt2G3eAu3tYCXL6/FwZb475hYCkU+bTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H4nu0aP8aS83hPXFGD/b8DfFuEpPnjp8DV9BEnjYD4mcuLCS0lz98dniAQgrgWhFx
	 6QcK1Do1PtbRJf0QWH3/6Gvgr3Ro56SqE0CdPvruNIsFUKHk0IEVRG7bgBGIjXaN3a
	 Tfoj3GSsqAaf+MtFnEj32U6QfiQKb3aitzPXSkirXGFIoEHRPRVih2Uup8eTVuMgVJ
	 l/x6fp45qXP2Q+pUv+jwSvSfWmfgz3RcKXdoIUEi1pzJRb+NGOqp4jO3SxmFpn5V29
	 ipKPwnDRAUIrmXRXhXI1boArEI3YqV7ujvXcHWT5kLiNXAk6GWr/qcWCsSVD9zqcV2
	 aSkCpFZf+VRLw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Valentina Fernandez <valentina.fernandezalanis@microchip.com>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 355/844] mailbox: mchp-ipc-sbi: fix uninitialized symbol and other smatch warnings
Date: Sat, 28 Feb 2026 12:24:28 -0500
Message-ID: <20260228173244.1509663-356-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[microchip.com,intel.com,linaro.org,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220434-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,intel.com:email]
X-Rspamd-Queue-Id: 713F91C67C6
X-Rspamd-Action: no action

From: Valentina Fernandez <valentina.fernandezalanis@microchip.com>

[ Upstream commit bc4d17e495cd3b02bcb2e10f575763a5ff31f80b ]

Fix uninitialized symbol 'hartid' warning in mchp_ipc_cluster_aggr_isr()
by introducing a 'found' flag to track whether the IRQ matches any
online hart. If no match is found, return IRQ_NONE.

Also fix other smatch warnings by removing dead code in
mchp_ipc_startup() and by returning -ENODEV in dev_err_probe() if the
Microchip SBI extension is not found.

Fixes below smatch warnings:
drivers/mailbox/mailbox-mchp-ipc-sbi.c:187 mchp_ipc_cluster_aggr_isr() error: uninitialized symbol 'hartid'.
drivers/mailbox/mailbox-mchp-ipc-sbi.c:324 mchp_ipc_startup() warn: ignoring unreachable code.
drivers/mailbox/mailbox-mchp-ipc-sbi.c:422 mchp_ipc_probe() warn: passing zero to 'dev_err_probe'

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202512171533.CDLdScMY-lkp@intel.com/
Signed-off-by: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/mailbox-mchp-ipc-sbi.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/mailbox/mailbox-mchp-ipc-sbi.c b/drivers/mailbox/mailbox-mchp-ipc-sbi.c
index d444491a584e8..b87bf2fb4b9b9 100644
--- a/drivers/mailbox/mailbox-mchp-ipc-sbi.c
+++ b/drivers/mailbox/mailbox-mchp-ipc-sbi.c
@@ -174,17 +174,21 @@ static irqreturn_t mchp_ipc_cluster_aggr_isr(int irq, void *data)
 	struct mchp_ipc_msg ipc_msg;
 	struct mchp_ipc_status status_msg;
 	int ret;
-	unsigned long hartid;
 	u32 i, chan_index, chan_id;
+	bool found = false;
 
 	/* Find out the hart that originated the irq */
 	for_each_online_cpu(i) {
-		hartid = cpuid_to_hartid_map(i);
-		if (irq == ipc->cluster_cfg[i].irq)
+		if (irq == ipc->cluster_cfg[i].irq) {
+			found = true;
 			break;
+		}
 	}
 
-	status_msg.cluster = hartid;
+	if (unlikely(!found))
+		return IRQ_NONE;
+
+	status_msg.cluster = cpuid_to_hartid_map(i);
 	memcpy(ipc->cluster_cfg[i].buf_base, &status_msg, sizeof(struct mchp_ipc_status));
 
 	ret = mchp_ipc_sbi_send(SBI_EXT_IPC_STATUS, ipc->cluster_cfg[i].buf_base_addr);
@@ -321,13 +325,6 @@ static int mchp_ipc_startup(struct mbox_chan *chan)
 		goto fail_free_buf_msg_rx;
 	}
 
-	if (ret) {
-		dev_err(ipc->dev, "failed to register interrupt(s)\n");
-		goto fail_free_buf_msg_rx;
-	}
-
-	return ret;
-
 fail_free_buf_msg_rx:
 	kfree(chan_info->msg_buf_rx);
 fail_free_buf_msg_tx:
@@ -419,7 +416,7 @@ static int mchp_ipc_probe(struct platform_device *pdev)
 
 	ret = sbi_probe_extension(SBI_EXT_MICROCHIP_TECHNOLOGY);
 	if (ret <= 0)
-		return dev_err_probe(dev, ret, "Microchip SBI extension not detected\n");
+		return dev_err_probe(dev, -ENODEV, "Microchip SBI extension not detected\n");
 
 	ipc = devm_kzalloc(dev, sizeof(*ipc), GFP_KERNEL);
 	if (!ipc)
-- 
2.51.0


