Return-Path: <stable+bounces-215922-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKceAPaMjWnq3wAAu9opvQ
	(envelope-from <stable+bounces-215922-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 09:19:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D1812B321
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 09:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A26E30E9116
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 08:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856872D0C68;
	Thu, 12 Feb 2026 08:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jBt3QSzu"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B30F145355;
	Thu, 12 Feb 2026 08:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770884299; cv=none; b=cEOKNw9rvgc3FcvmPzX2zp7NOMiDVGmQZSEmmvNVq3swjLHGFaQ89nMYvtRM0tuT9KoIo4izLuhmzYfj4FltwJOkcOoN6Qc68YicmFvVFJqvX+I3Z3BhzKxBsqOK8w5ZTcHkWbPGTVdi6pTorChq1N2x7b+D5xo3/rA9Duq70HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770884299; c=relaxed/simple;
	bh=gb7oE0tg3OUkogbWMEHphSa0+94S+0FjanBb9PzUyAA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rgaBACObvD6BkcSWG5bXtlSemtFqIR4QLBig4LzYPlR21REpg2D86gVeE5sY1/7QgrM700ua5nmbnN1oA/UxPqpyZeTstfl41lZAADoTl+sxLa0czzp1rsu7No2xoKfsuY6s58LAhrW4Fbsnx1KDrhAUWH7fykJN21ztUq1YLFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jBt3QSzu; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=oB
	0XDhqS4bBwAuzTTWE/s1rt96As4j4hqN4FxPFSt20=; b=jBt3QSzunSQtrgD+U4
	0431SFKHf2I5IpyC7EJgZPUgN7m/9pVybOCZNxZ1Uzv65bO8v40Txzdn41mG+jCm
	0xZgxJuPljD9fk5kw+AK4jp72kpz+Y55nUNqgziF2v7kPBQDF6kiPGdh0xkZfyMS
	Q294rmHjx7+UL1OwQ+IWCMC7o=
Received: from pek-lpg-core5.wrs.com (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wAXSLWnjI1pzQIXLQ--.8152S2;
	Thu, 12 Feb 2026 16:17:43 +0800 (CST)
From: Robert Garcia <rob_garcia@163.com>
To: stable@vger.kernel.org,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Cc: Mark Brown <broonie@kernel.org>,
	Niravkumar L Rabara <nirav.rabara@altera.com>,
	Robert Garcia <rob_garcia@163.com>,
	alex Walker <18501357977@189.cn>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.6.y] spi: cadence-quadspi: Implement refcount to handle unbind during busy
Date: Thu, 12 Feb 2026 16:17:43 +0800
Message-Id: <20260212081743.4137376-1-rob_garcia@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXSLWnjI1pzQIXLQ--.8152S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFWrXFykur4rAw1fWrWkCrg_yoWrXrWkpF
	4UGw45tF4xKF4IqFnrJa4DZF13KrWxJ34fW39rA34avry3Jwn8Za4FkF1Utr43AF97AF1U
	WF409FWIkFsxZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UpUDJUUUUU=
X-CM-SenderInfo: 5uresw5dufxti6rwjhhfrp/xtbC5gkLdmmNjKnNAQAA3f
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,altera.com,163.com,189.cn,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-215922-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	FROM_NEQ_ENVFROM(0.00)[rob_garcia@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,altera.com:email]
X-Rspamd-Queue-Id: 93D1812B321
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

 drivers/spi/spi-cadence-quadspi.c | 34 +++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index eed88aba2cfe..3e7bf76be22b 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -100,6 +100,8 @@ struct cqspi_st {
 	bool			apb_ahb_hazard;
 
 	bool			is_jh7110; /* Flag for StarFive JH7110 SoC */
+	refcount_t		refcount;
+	refcount_t		inflight_ops;
 };
 
 struct cqspi_driver_platdata {
@@ -705,6 +707,9 @@ static int cqspi_indirect_read_execute(struct cqspi_flash_pdata *f_pdata,
 	u8 *rxbuf_end = rxbuf + n_rx;
 	int ret = 0;
 
+	if (!refcount_read(&cqspi->refcount))
+		return -ENODEV;
+
 	writel(from_addr, reg_base + CQSPI_REG_INDIRECTRDSTARTADDR);
 	writel(remaining, reg_base + CQSPI_REG_INDIRECTRDBYTES);
 
@@ -1021,6 +1026,9 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 	unsigned int write_bytes;
 	int ret;
 
+	if (!refcount_read(&cqspi->refcount))
+		return -ENODEV;
+
 	writel(to_addr, reg_base + CQSPI_REG_INDIRECTWRSTARTADDR);
 	writel(remaining, reg_base + CQSPI_REG_INDIRECTWRBYTES);
 
@@ -1412,11 +1420,29 @@ static int cqspi_mem_process(struct spi_mem *mem, const struct spi_mem_op *op)
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
 
@@ -1847,6 +1873,9 @@ static int cqspi_probe(struct platform_device *pdev)
 		}
 	}
 
+	refcount_set(&cqspi->refcount, 1);
+	refcount_set(&cqspi->inflight_ops, 1);
+
 	ret = devm_request_irq(dev, irq, cqspi_irq_handler, 0,
 			       pdev->name, cqspi);
 	if (ret) {
@@ -1899,6 +1928,11 @@ static void cqspi_remove(struct platform_device *pdev)
 {
 	struct cqspi_st *cqspi = platform_get_drvdata(pdev);
 
+	refcount_set(&cqspi->refcount, 0);
+
+	if (!refcount_dec_and_test(&cqspi->inflight_ops))
+		cqspi_wait_idle(cqspi);
+
 	spi_unregister_controller(cqspi->host);
 	cqspi_controller_enable(cqspi, 0);
 
-- 
2.34.1


