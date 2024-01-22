Return-Path: <stable+bounces-14730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD93C8382DB
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 699F2B23665
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1335B207;
	Tue, 23 Jan 2024 01:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KbutMN5Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6785B20E;
	Tue, 23 Jan 2024 01:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974325; cv=none; b=J25ZkM9/yd46rMvZZvfaLMC4BeNDO+hHKsHU8m5YnQvBb1YY+S592VTwezsPVCsHJZw40hTB2G0xMVjRdG6fzce9YCJomCyYht9yfU8xr3GgGLOWXrrBWCwtSvb4Bi/m87ltFZ7x4IttLz5kdVWhR3RSjenmQFrnnptzzHLkzdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974325; c=relaxed/simple;
	bh=4kFk0JWIUpyxXIMzyKu8vsoDzYPAvLWRUL6wiiQc6Ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T6U5ONmLmlsfLtlMZBfuQolGXpQ3WG0X/dBe0JuDWwLoqAumCGU4xZgAviZjJ3iriXW4ogCz2rEpp6ybQzj0fUPbkyyUM3lbiHYkjo9pLuioL6pfK+YKCQZFVYaFTk2/m2eKBmeLgz4p2rJgG/WXGhciatPsS+4Vi48oz9XWcRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KbutMN5Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856F2C433C7;
	Tue, 23 Jan 2024 01:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705974324;
	bh=4kFk0JWIUpyxXIMzyKu8vsoDzYPAvLWRUL6wiiQc6Ek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KbutMN5ZEBT39ROeKeQ++0wfnqWQYiSiv6dZH6vS3umKymdkrQ47qyHj5VC8UvU3z
	 6RcSNerI4sOHklzGh37weUlD9H/gc7OzEj6fgvtrzKA2E+hMnLKLf+tzjn53AfOO3Q
	 V3MWqnf9wGNUVgr/rdmzuedmHX2NculY47PqP9J0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 022/583] spi: spi-zynqmp-gqspi: fix driver kconfig dependencies
Date: Mon, 22 Jan 2024 15:51:13 -0800
Message-ID: <20240122235812.887951345@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>

[ Upstream commit 424a8166764e462258fdccaaefbdeb07517c8b21 ]

ZynqMP GQSPI driver no longer uses spi-master framework. It had been
converted to use spi-mem framework. So remove driver dependency from
spi-master and replace it with spi-mem.

Fixes: 1c26372e5aa9 ("spi: spi-zynqmp-gqspi: Update driver to use spi-mem framework")
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Link: https://lore.kernel.org/r/1699282435-884917-1-git-send-email-radhey.shyam.pandey@amd.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index bcbf840cd41c..3ce0fd5df8e9 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -1165,9 +1165,10 @@ config SPI_ZYNQ_QSPI
 
 config SPI_ZYNQMP_GQSPI
 	tristate "Xilinx ZynqMP GQSPI controller"
-	depends on (SPI_MASTER && HAS_DMA) || COMPILE_TEST
+	depends on (SPI_MEM && HAS_DMA) || COMPILE_TEST
 	help
 	  Enables Xilinx GQSPI controller driver for Zynq UltraScale+ MPSoC.
+	  This controller only supports SPI memory interface.
 
 config SPI_AMD
 	tristate "AMD SPI controller"
-- 
2.43.0




