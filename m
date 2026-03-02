Return-Path: <stable+bounces-222505-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNncGcv/pGmpyAUAu9opvQ
	(envelope-from <stable+bounces-222505-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 04:11:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D423A1D2A44
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 04:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2ED5B301DD9D
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 03:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A5B2C236B;
	Mon,  2 Mar 2026 03:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="d2d+HNg6"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE1115539A;
	Mon,  2 Mar 2026 03:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772421044; cv=none; b=gpaYCNZ20V2ZGQxeIXDaocWWtgrgaBe0SaQxRmbHIQhEJS9nRw0Kc2mNkxH00PczN3tgdh3spUnafXrD8v3YOCtsGf+4z2ZsD+mlksR63hGfOV9eUA9toGRHTDTs5r/GvfLco/+oWUlu49PB0986WrR8nkXu3fL3Zt1R253SnVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772421044; c=relaxed/simple;
	bh=gUTzNrMfgs+tDHQ+LOw0o37eEB3pdSvw1kSHIpxvVgE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LP9ZFrvleBypUSMSncdthYI/Hn5VrswVhRa1raIbFVhU6rniDmlxDVmhD7Hz5lT3OJHCBnWtOSdcxG5LGaO5nHcy63z4KQEKlD2Ob0iYyUm+O07UThHCiPbTsxpcPXi+5coSk0PXYSIz4/iqd/KoJ7S5ADT2afja4eTscOW3OVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=d2d+HNg6; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Yq
	STCjcPUw6J3JZXlqT0+hhApEQL3FkkNPm8nTHHHeo=; b=d2d+HNg6HMsI5eepwD
	VRO4l1Altdx8ZjFyx1aMV4dAgOmL842/S+EqO5l7/hoz4sF/cLfuEVNwGA3xgitv
	q3DcHa7aChcPc81FQuq0HoUi5ZQ9Ce20xaObBiU2GAwJPHDrxuFT9P2Vawuu108a
	u2RZZXim5NWApFTO50VVPGNyc=
Received: from pek-lpg-core5.wrs.com (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgDn5_CX_6RpCjgLQA--.6902S2;
	Mon, 02 Mar 2026 11:10:17 +0800 (CST)
From: Robert Garcia <rob_garcia@163.com>
To: stable@vger.kernel.org,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Cc: Mark Brown <broonie@kernel.org>,
	Niravkumar L Rabara <nirav.rabara@altera.com>,
	Robert Garcia <rob_garcia@163.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.1.y] spi: cadence-quadspi: Implement refcount to handle unbind during busy
Date: Mon,  2 Mar 2026 11:10:15 +0800
Message-Id: <20260302031015.1319477-1-rob_garcia@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgDn5_CX_6RpCjgLQA--.6902S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFWrXFykur4rAw1fWrWkCrg_yoWrXrWfpF
	4UGw45tF4xKFWIqFnrJa4DZF1fKrWxJ34fW39Fy34a9ry3Jwn8Za4FkF1Utr43AF97AF1U
	WF409FyIkFsxZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07US-ewUUUUU=
X-CM-SenderInfo: 5uresw5dufxti6rwjhhfrp/xtbDAhmpFWmk-5ng1QAA35
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222505-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,altera.com,163.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rob_garcia@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D423A1D2A44
X-Rspamd-Action: no action

From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>

[ Upstream commit 7446284023e8ef694fb392348185349c773eefb3 ]

driver support indirect read and indirect write operation with
assumption no force device removal(unbind) operation. However
force device removal(removal) is still available to root superuser.

Unbinding driver during operation causes kernel crash. This changes
ensure driver able to handle such operation for indirect read and
indirect write by implementing refcount to track attached devices
to the controller and gracefully wait and until attached devices
remove operation completed before proceed with removal operation.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
Reviewed-by: Niravkumar L Rabara <nirav.rabara@altera.com>
Link: https://patch.msgid.link/8704fd6bd2ff4d37bba4a0eacf5eba3ba001079e.1756168074.git.khairul.anuar.romli@altera.com
Signed-off-by: Mark Brown <broonie@kernel.org>
[Add cqspi defination in cqspi_exec_mem_op and minor context change fixed.]
Signed-off-by: Robert Garcia <rob_garcia@163.com>
---
 drivers/spi/spi-cadence-quadspi.c | 34 +++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 5b0ce13521f2..feaaf4ec0f15 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -100,6 +100,8 @@ struct cqspi_st {
 	bool			apb_ahb_hazard;
 
 	bool			is_jh7110; /* Flag for StarFive JH7110 SoC */
+	refcount_t		refcount;
+	refcount_t		inflight_ops;
 };
 
 struct cqspi_driver_platdata {
@@ -686,6 +688,9 @@ static int cqspi_indirect_read_execute(struct cqspi_flash_pdata *f_pdata,
 	u8 *rxbuf_end = rxbuf + n_rx;
 	int ret = 0;
 
+	if (!refcount_read(&cqspi->refcount))
+		return -ENODEV;
+
 	writel(from_addr, reg_base + CQSPI_REG_INDIRECTRDSTARTADDR);
 	writel(remaining, reg_base + CQSPI_REG_INDIRECTRDBYTES);
 
@@ -973,6 +978,9 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 	unsigned int write_bytes;
 	int ret;
 
+	if (!refcount_read(&cqspi->refcount))
+		return -ENODEV;
+
 	writel(to_addr, reg_base + CQSPI_REG_INDIRECTWRSTARTADDR);
 	writel(remaining, reg_base + CQSPI_REG_INDIRECTWRBYTES);
 
@@ -1365,11 +1373,29 @@ static int cqspi_mem_process(struct spi_mem *mem, const struct spi_mem_op *op)
 static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
 	int ret;
+	struct cqspi_st *cqspi = spi_controller_get_devdata(mem->spi->controller);
+
+	if (refcount_read(&cqspi->inflight_ops) == 0)
+		return -ENODEV;
+
+	if (!refcount_read(&cqspi->refcount))
+		return -EBUSY;
+
+	refcount_inc(&cqspi->inflight_ops);
+
+	if (!refcount_read(&cqspi->refcount)) {
+		if (refcount_read(&cqspi->inflight_ops))
+			refcount_dec(&cqspi->inflight_ops);
+		return -EBUSY;
+	}
 
 	ret = cqspi_mem_process(mem, op);
 	if (ret)
 		dev_err(&mem->spi->dev, "operation failed with %d\n", ret);
 
+	if (refcount_read(&cqspi->inflight_ops) > 1)
+		refcount_dec(&cqspi->inflight_ops);
+
 	return ret;
 }
 
@@ -1800,6 +1826,9 @@ static int cqspi_probe(struct platform_device *pdev)
 		}
 	}
 
+	refcount_set(&cqspi->refcount, 1);
+	refcount_set(&cqspi->inflight_ops, 1);
+
 	ret = devm_request_irq(dev, irq, cqspi_irq_handler, 0,
 			       pdev->name, cqspi);
 	if (ret) {
@@ -1852,6 +1881,11 @@ static int cqspi_remove(struct platform_device *pdev)
 {
 	struct cqspi_st *cqspi = platform_get_drvdata(pdev);
 
+	refcount_set(&cqspi->refcount, 0);
+
+	if (!refcount_dec_and_test(&cqspi->inflight_ops))
+		cqspi_wait_idle(cqspi);
+
 	spi_unregister_master(cqspi->master);
 	cqspi_controller_enable(cqspi, 0);
 
-- 
2.34.1


