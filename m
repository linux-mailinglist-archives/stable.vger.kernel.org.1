Return-Path: <stable+bounces-112760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39758A28E44
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F11516889F
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5E3149C53;
	Wed,  5 Feb 2025 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HvOuhWlN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464441519AA;
	Wed,  5 Feb 2025 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738764655; cv=none; b=RGEcB89BiE9Nx+Vi7gYE9Ij7UVGPpMlVvk5ApFpkApQ4FFwzzmq+h/AdPhVqG5WIazC2Uyc3wA03Jv4zIDvj21TAQGPROxM6sYwMsb1NQGpS3JAKOjjhuXjKR/f93qkl+IPDBm/o5fZ1hkL3+RsUs4rFDXPs4giOUdNg8TlR5t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738764655; c=relaxed/simple;
	bh=i4K3hh2WCr+TOurATJE6/L2fAJPqwWABAWC0a5rv/L0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XA+B7YCEI6/aFHFRRFRdan7fl4chY4Wur+XuTQCIpEkoos+7ujyJpf2HVo2wmqiYuSQTp7VpaP4gdy9U9GWpoLLZrMzqxWdexHrvmedgq4+wGKTVUOhkI828cJ2mArJcS6HgBV/gCf4pjqhje8j5peA8SQf/BgC4RSRs7gVXTq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HvOuhWlN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9821C4CED1;
	Wed,  5 Feb 2025 14:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738764655;
	bh=i4K3hh2WCr+TOurATJE6/L2fAJPqwWABAWC0a5rv/L0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HvOuhWlNLgdNDgtTqt06LZ3E9Kd5ULQbZSaKzueLw4voVJCQRzmHlFpV6ZhtvX5wo
	 3KwXyNP7nrFm2oKnQQq9xyxlheYX+G3Ui5bMkShmdVpvwKd86uYfl33svExLMh3TZV
	 r2DTRNizrkWoZ1zxdLQ0K59gHny5QGjTl50oiiAo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mingwei Zheng <zmw12306@gmail.com>,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 099/623] spi: zynq-qspi: Add check for clk_enable()
Date: Wed,  5 Feb 2025 14:37:21 +0100
Message-ID: <20250205134500.007179458@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134456.221272033@linuxfoundation.org>
References: <20250205134456.221272033@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mingwei Zheng <zmw12306@gmail.com>

[ Upstream commit 8332e667099712e05ec87ba2058af394b51ebdc9 ]

Add check for the return value of clk_enable() to catch the potential
error.

Fixes: c618a90dcaf3 ("spi: zynq-qspi: Drop GPIO header")
Signed-off-by: Mingwei Zheng <zmw12306@gmail.com>
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Link: https://patch.msgid.link/20241207015206.3689364-1-zmw12306@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-zynq-qspi.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index dee9c339a35e7..5caf0abf3763a 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -379,12 +379,21 @@ static int zynq_qspi_setup_op(struct spi_device *spi)
 {
 	struct spi_controller *ctlr = spi->controller;
 	struct zynq_qspi *qspi = spi_controller_get_devdata(ctlr);
+	int ret;
 
 	if (ctlr->busy)
 		return -EBUSY;
 
-	clk_enable(qspi->refclk);
-	clk_enable(qspi->pclk);
+	ret = clk_enable(qspi->refclk);
+	if (ret)
+		return ret;
+
+	ret = clk_enable(qspi->pclk);
+	if (ret) {
+		clk_disable(qspi->refclk);
+		return ret;
+	}
+
 	zynq_qspi_write(qspi, ZYNQ_QSPI_ENABLE_OFFSET,
 			ZYNQ_QSPI_ENABLE_ENABLE_MASK);
 
-- 
2.39.5




