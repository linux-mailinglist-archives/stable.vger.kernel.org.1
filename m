Return-Path: <stable+bounces-216218-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cL5uK8Mtj2ksLgEAu9opvQ
	(envelope-from <stable+bounces-216218-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:57:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EB584136C7E
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 867B7301C648
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 13:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186F535FF61;
	Fri, 13 Feb 2026 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ufZYhrxl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D095B1D432D;
	Fri, 13 Feb 2026 13:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770991037; cv=none; b=T1WtXqkcbllrsaHMvWPBWZ9kleeN+rrGrD59S2lwDm7ZA2dDGkHrRIAIn06bjauq9LNUnSt5VNbgsWOWbqknunXHZdXLkEiWB/NUrz6gC0vsDG5RN16CBkDxSDRPwj7rmyWofWG9RuoBLTL7Cnu2GpvHsmvjfI60RxgGnDWf5Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770991037; c=relaxed/simple;
	bh=B+23NUpQAEEuSPMSvjQWHiWwSD7vsIjvH91ywdH7AoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=baQ4LAHe3XMEICoWTbWxOv+942ieLqOFuA4x5RMLDp57uvXZctyaExwJMkeyLabrhVauEBs5HDAT3KjtPVd/0Cm4/R32rimiokhRrDcnygukH7sTVKA4bT+1nX42hpqbfO07f34ZWbOCzjXKSyEcqBz+atIBSeOs0eYSzgaw4CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ufZYhrxl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB54C16AAE;
	Fri, 13 Feb 2026 13:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770991037;
	bh=B+23NUpQAEEuSPMSvjQWHiWwSD7vsIjvH91ywdH7AoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ufZYhrxlirjzdf4avM7sdCkCfAM0Cpz8MhyVQC3O3CKl6PHGIlPYYphTHosDXLxCb
	 CazONIdaQwBhKhLrC2uwnpcx3tzPwxtBHG1JCf3Na+6zFPrZLbAkBbFV5riPXT6fb9
	 HXFfTiVroGYEvIArYmfKBB/z80Cp6X2OJQOEMKsY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Niravkumar L Rabara <nirav.rabara@altera.com>,
	Mark Brown <broonie@kernel.org>,
	Robert Garcia <rob_garcia@163.com>
Subject: [PATCH 6.6 22/25] spi: cadence-quadspi: Implement refcount to handle unbind during busy
Date: Fri, 13 Feb 2026 14:48:48 +0100
Message-ID: <20260213134704.688888759@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260213134703.882698935@linuxfoundation.org>
References: <20260213134703.882698935@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216218-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,altera.com,kernel.org,163.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[altera.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: EB584136C7E
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>

commit 7446284023e8ef694fb392348185349c773eefb3 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/spi/spi-cadence-quadspi.c |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -100,6 +100,8 @@ struct cqspi_st {
 	bool			apb_ahb_hazard;
 
 	bool			is_jh7110; /* Flag for StarFive JH7110 SoC */
+	refcount_t		refcount;
+	refcount_t		inflight_ops;
 };
 
 struct cqspi_driver_platdata {
@@ -705,6 +707,9 @@ static int cqspi_indirect_read_execute(s
 	u8 *rxbuf_end = rxbuf + n_rx;
 	int ret = 0;
 
+	if (!refcount_read(&cqspi->refcount))
+		return -ENODEV;
+
 	writel(from_addr, reg_base + CQSPI_REG_INDIRECTRDSTARTADDR);
 	writel(remaining, reg_base + CQSPI_REG_INDIRECTRDBYTES);
 
@@ -1021,6 +1026,9 @@ static int cqspi_indirect_write_execute(
 	unsigned int write_bytes;
 	int ret;
 
+	if (!refcount_read(&cqspi->refcount))
+		return -ENODEV;
+
 	writel(to_addr, reg_base + CQSPI_REG_INDIRECTWRSTARTADDR);
 	writel(remaining, reg_base + CQSPI_REG_INDIRECTWRBYTES);
 
@@ -1412,11 +1420,29 @@ static int cqspi_mem_process(struct spi_
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
 
@@ -1847,6 +1873,9 @@ static int cqspi_probe(struct platform_d
 		}
 	}
 
+	refcount_set(&cqspi->refcount, 1);
+	refcount_set(&cqspi->inflight_ops, 1);
+
 	ret = devm_request_irq(dev, irq, cqspi_irq_handler, 0,
 			       pdev->name, cqspi);
 	if (ret) {
@@ -1899,6 +1928,11 @@ static void cqspi_remove(struct platform
 {
 	struct cqspi_st *cqspi = platform_get_drvdata(pdev);
 
+	refcount_set(&cqspi->refcount, 0);
+
+	if (!refcount_dec_and_test(&cqspi->inflight_ops))
+		cqspi_wait_idle(cqspi);
+
 	spi_unregister_controller(cqspi->host);
 	cqspi_controller_enable(cqspi, 0);
 



