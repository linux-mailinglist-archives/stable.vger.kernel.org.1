Return-Path: <stable+bounces-181993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45617BAA7D3
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 21:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9EC87A40A4
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 19:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2CB22FDFF;
	Mon, 29 Sep 2025 19:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YM/Z8nhS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF541E3DE8
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 19:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759174979; cv=none; b=JKnMpReuvuJicFUlzIlgDwwKuNy8SbgMCKwUTrgcHiJaPFg8Pn533HdZo/Gw5/oOHWAHfPowKTiu/yRe+N2HbN87Ao+chC+EG6IQVRwNyzVKhkp7+8M46SZk6jta8i7YHfI/CETu3rGyEY4SgoN4VO45PZVNFh2YKBWiy2AEQIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759174979; c=relaxed/simple;
	bh=JUB5Cg4Ey7zTyjgnIaWZak+WuoyNGg6MYLkCHjYHfBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gvh0O0pvmxkcVUBDGLEc1TxvYSiblS0ooSUtrH+vW6MPwdef4ZdFu37EtgrD9zEcGznJTlKkS0uo+HgO8uCuNoF1j4JyGfdnmJDwLRVMuxPp2UnF8JSFVOzqc+gWhr6L5i1zm4eyUtDhi5AFJWzjQ7tZ02he5HGdRtCHK9ABUOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YM/Z8nhS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E02C4CEF4;
	Mon, 29 Sep 2025 19:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759174978;
	bh=JUB5Cg4Ey7zTyjgnIaWZak+WuoyNGg6MYLkCHjYHfBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YM/Z8nhSanH08PhgJzDLsk3dZX8nmjrXHnsTsTAuyMSnkWY8/0SgD6yAiXS+IxMye
	 OwVXo9mPPZ1JcMOk5FqGwuSi2SAInrbkMlcF8dLlNYiYvE5Q4TBkYKPdg/LqN10Qgx
	 /5HyZ+yRPiJ3EdpZksIMg3zsrwdu/NNSDvPOftK1kZ8xev3bhVPpBv+j/DaM1fvsmX
	 DIardtfVHFbm9mXpxXptHMjDIGegIg6ntPMuvYc9GO+2WBbJ9uHEKafek7qWTfaLq9
	 UnUHahOXrrNPhDbq3pU8L5NhpP4G+t7WiDE6kWK0Hki2vMSb0JKGThgjuRX8UnfOgF
	 9EJxYWRB5bDgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Niravkumar L Rabara <nirav.rabara@altera.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y 1/2] spi: cadence-quadspi: Implement refcount to handle unbind during busy
Date: Mon, 29 Sep 2025 15:42:54 -0400
Message-ID: <20250929194255.332788-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025092913-wriggly-condition-4b00@gregkh>
References: <2025092913-wriggly-condition-4b00@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Stable-dep-of: 30dbc1c8d50f ("spi: cadence-qspi: defer runtime support on socfpga if reset bit is enabled")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-cadence-quadspi.c | 33 +++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index d3c78f59b22cd..d656f36002887 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -108,6 +108,8 @@ struct cqspi_st {
 
 	bool			is_jh7110; /* Flag for StarFive JH7110 SoC */
 	bool			disable_stig_mode;
+	refcount_t		refcount;
+	refcount_t		inflight_ops;
 
 	const struct cqspi_driver_platdata *ddata;
 };
@@ -735,6 +737,9 @@ static int cqspi_indirect_read_execute(struct cqspi_flash_pdata *f_pdata,
 	u8 *rxbuf_end = rxbuf + n_rx;
 	int ret = 0;
 
+	if (!refcount_read(&cqspi->refcount))
+		return -ENODEV;
+
 	writel(from_addr, reg_base + CQSPI_REG_INDIRECTRDSTARTADDR);
 	writel(remaining, reg_base + CQSPI_REG_INDIRECTRDBYTES);
 
@@ -1071,6 +1076,9 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 	unsigned int write_bytes;
 	int ret;
 
+	if (!refcount_read(&cqspi->refcount))
+		return -ENODEV;
+
 	writel(to_addr, reg_base + CQSPI_REG_INDIRECTWRSTARTADDR);
 	writel(remaining, reg_base + CQSPI_REG_INDIRECTWRBYTES);
 
@@ -1461,12 +1469,26 @@ static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	struct cqspi_st *cqspi = spi_controller_get_devdata(mem->spi->controller);
 	struct device *dev = &cqspi->pdev->dev;
 
+	if (refcount_read(&cqspi->inflight_ops) == 0)
+		return -ENODEV;
+
 	ret = pm_runtime_resume_and_get(dev);
 	if (ret) {
 		dev_err(&mem->spi->dev, "resume failed with %d\n", ret);
 		return ret;
 	}
 
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
+
 	ret = cqspi_mem_process(mem, op);
 
 	pm_runtime_mark_last_busy(dev);
@@ -1475,6 +1497,9 @@ static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	if (ret)
 		dev_err(&mem->spi->dev, "operation failed with %d\n", ret);
 
+	if (refcount_read(&cqspi->inflight_ops) > 1)
+		refcount_dec(&cqspi->inflight_ops);
+
 	return ret;
 }
 
@@ -1926,6 +1951,9 @@ static int cqspi_probe(struct platform_device *pdev)
 		}
 	}
 
+	refcount_set(&cqspi->refcount, 1);
+	refcount_set(&cqspi->inflight_ops, 1);
+
 	ret = devm_request_irq(dev, irq, cqspi_irq_handler, 0,
 			       pdev->name, cqspi);
 	if (ret) {
@@ -1989,6 +2017,11 @@ static void cqspi_remove(struct platform_device *pdev)
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
2.51.0


