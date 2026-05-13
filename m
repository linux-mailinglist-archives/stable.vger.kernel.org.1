Return-Path: <stable+bounces-247025-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHy8FOLTBGr0PQIAu9opvQ
	(envelope-from <stable+bounces-247025-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 21:41:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EB853A218
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 21:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D0CC3052B7E
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C6C3B6C02;
	Wed, 13 May 2026 19:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tne6DERT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CD03B6362
	for <stable@vger.kernel.org>; Wed, 13 May 2026 19:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778700864; cv=none; b=QuKqDassAXqyroFsnRkbKrCDsAo8eexLp+SkFWJAiycFJU4kmDvcJZUnrAY/jmHHgtAZN32y7Jtx6hF+XeXyB1V3SI5AEmij5lxYgPgEO8aOtbXEIKcQJvVZxl5ElQABUn+nntX9eFyB8qaOGO0eNyakssYpjRaH1F44I8aHQus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778700864; c=relaxed/simple;
	bh=mK6ocOvblzRpANtP4cypLtkWTxdelkLWqaNcwddXFCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Glk98pjlyUjMMLq8XIkO2qmm2NLyCXdw+6w5If0eyShS948ukZtvJmal8t/MOZDf/smApxnn4muh2Rj+o8bTRJTdIYnhFuqqMa9RYRvPBuOFU2+riQC2vw4LT2mlYZyc+afflY5rkUr6yzb2arUYn3/djjwm1YyOuCaFvZXw19M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tne6DERT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EC2C2BCB7;
	Wed, 13 May 2026 19:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778700864;
	bh=mK6ocOvblzRpANtP4cypLtkWTxdelkLWqaNcwddXFCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tne6DERT6q4tNlwexaPFZIj7T7XUlgm5HyT53l9HeGOa6QstP9RRazApFqUC0xyGE
	 QcLeZOfgsdXQDFmpWeWFYuFgICjC2d4Mjf0m1ROSXRyXyX9BLDbnP4PAjXX76jqzpO
	 2W+twWaG8QxgM0xS5sFYvP/BKWQvMk3pw+Aqonn75W7oO/J7JuO/P8l91henH/aEVR
	 2INSYrGLOpYoQ/EMbnuPhKvcm+ctp5+3ug1zmdS8r+QHJ2mawYpTTCViEuKVpuAhPn
	 KmT9iSPBHBMhWF88GsLiCuKmclaE9SSXZtP9/R3QBSJmECkjM1MPhCdTDsPP6WXDZO
	 by0YxZU/kGsLw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ruan Jinjie <ruanjinjie@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/5] spi: spi-zynq: Do not check for 0 return after calling platform_get_irq()
Date: Wed, 13 May 2026 15:34:17 -0400
Message-ID: <20260513193420.3938432-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513193420.3938432-1-sashal@kernel.org>
References: <2026051203-regain-crablike-8461@gregkh>
 <20260513193420.3938432-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A3EB853A218
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247025-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Action: no action

From: Ruan Jinjie <ruanjinjie@huawei.com>

[ Upstream commit 3182d49aad5f1cd8acdcf7de0c5b651772edd32e ]

It is not possible for platform_get_irq() to return 0. Use the
return value from platform_get_irq().

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
Link: https://lore.kernel.org/r/20230802094357.981100-1-ruanjinjie@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: c9c012706c9f ("spi: zynq-qspi: fix controller deregistration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-zynq-qspi.c    | 4 ++--
 drivers/spi/spi-zynqmp-gqspi.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index 6f248520c6381..3cc2b0cb14f61 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -688,8 +688,8 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 	}
 
 	xqspi->irq = platform_get_irq(pdev, 0);
-	if (xqspi->irq <= 0) {
-		ret = -ENXIO;
+	if (xqspi->irq < 0) {
+		ret = xqspi->irq;
 		goto clk_dis_all;
 	}
 	ret = devm_request_irq(&pdev->dev, xqspi->irq, zynq_qspi_irq,
diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index fde7c38103596..16ca8b93c93d2 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1164,8 +1164,8 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	zynqmp_qspi_init_hw(xqspi);
 
 	xqspi->irq = platform_get_irq(pdev, 0);
-	if (xqspi->irq <= 0) {
-		ret = -ENXIO;
+	if (xqspi->irq < 0) {
+		ret = xqspi->irq;
 		goto clk_dis_all;
 	}
 	ret = devm_request_irq(&pdev->dev, xqspi->irq, zynqmp_qspi_irq,
-- 
2.53.0


