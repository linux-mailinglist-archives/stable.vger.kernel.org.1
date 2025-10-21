Return-Path: <stable+bounces-188388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C768EBF7D49
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 19:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0B3619A64CC
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 17:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD34347FC6;
	Tue, 21 Oct 2025 17:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TV0zIBVv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8F7345CB1
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 17:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761066661; cv=none; b=Wq4FOd+4/DtMnCtjyXRH0g/rb4JECzGVN6+xxJEPqe3NIBTWN25i/zpOIwPz6c66haIjHuo9ed/MCEZFBnVI02QG7ASrcXHwLqWeVCsv/P632GFQ1cVbxcdzo3RYKdlUxopdKCSQG6eVvI1XeEEI7RiHDXUmNemrIiWPnp6N0cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761066661; c=relaxed/simple;
	bh=ndpoYvDHpJCeCHkx0vczV7h4N6Xr6AnIME+hX5AX/pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWgconbHLXbE1yKadPUuJ16ZZ/rn0fDvPvzZQ6ab3AVz/qtNHdGFkazDw+C0Ev+BxXk6r46bf8/XsmQqLezaE8gSOXuwmOGhHVEBdQfo3XpDrJPwWEltozk2fy9IItZ+y2pF9VtCP2F+UyrreIhGqIAcf0kdhXrVCPTrcULVuTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TV0zIBVv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC42C4CEF1;
	Tue, 21 Oct 2025 17:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761066659;
	bh=ndpoYvDHpJCeCHkx0vczV7h4N6Xr6AnIME+hX5AX/pQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TV0zIBVvYN3qboIUu4K8Z9UOVhxqOzpK6G3pl863csDLVxtVVhWPtOjGAkO+ITv/d
	 DbR4Sw/L2l1kwORvkQNWWBLQO8rmnaLzIRM5Htk8w2nUIHlILeKvJgMxA/RYXHAzHx
	 erM++AU3htt/jpA1vVfTA7wZz7OHRLCiXfwcZYZImNp/cy1vwFIycH192bNdXLAIXO
	 dlQvpnfyFtzfaKwL6IIH1R5bo5ZRk41IY8dWdCrjgf4WOY7++XW3xI95PSY3KYn5KB
	 rk+DAF7qOy77RWpDZMLiDnmpsbS2LY1WMpV5g9o4xbkNUi3idtSrS97t7+lkj2TYw9
	 8drmxrR8tw65g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pratyush Yadav <pratyush@kernel.org>,
	Santhosh Kumar K <s-k6@ti.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] spi: cadence-quadspi: Flush posted register writes before DAC access
Date: Tue, 21 Oct 2025 13:10:55 -0400
Message-ID: <20251021171055.2412702-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101634-glare-unrivaled-70bf@gregkh>
References: <2025101634-glare-unrivaled-70bf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pratyush Yadav <pratyush@kernel.org>

[ Upstream commit 1ad55767e77a853c98752ed1e33b68049a243bd7 ]

cqspi_read_setup() and cqspi_write_setup() program the address width as
the last step in the setup. This is likely to be immediately followed by
a DAC region read/write. On TI K3 SoCs the DAC region is on a different
endpoint from the register region. This means that the order of the two
operations is not guaranteed, and they might be reordered at the
interconnect level. It is possible that the DAC read/write goes through
before the address width update goes through. In this situation if the
previous command used a different address width the OSPI command is sent
with the wrong number of address bytes, resulting in an invalid command
and undefined behavior.

Read back the size register to make sure the write gets flushed before
accessing the DAC region.

Fixes: 140623410536 ("mtd: spi-nor: Add driver for Cadence Quad SPI Flash Controller")
CC: stable@vger.kernel.org
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
Message-ID: <20250905185958.3575037-3-s-k6@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-cadence-quadspi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 8b31aaa1d0f16..1ee3641c88736 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -474,6 +474,7 @@ static int cqspi_read_setup(struct cqspi_flash_pdata *f_pdata,
 	reg &= ~CQSPI_REG_SIZE_ADDRESS_MASK;
 	reg |= (op->addr.nbytes - 1);
 	writel(reg, reg_base + CQSPI_REG_SIZE);
+	readl(reg_base + CQSPI_REG_SIZE); /* Flush posted write. */
 	return 0;
 }
 
@@ -586,6 +587,7 @@ static int cqspi_write_setup(struct cqspi_flash_pdata *f_pdata,
 	reg &= ~CQSPI_REG_SIZE_ADDRESS_MASK;
 	reg |= (op->addr.nbytes - 1);
 	writel(reg, reg_base + CQSPI_REG_SIZE);
+	readl(reg_base + CQSPI_REG_SIZE); /* Flush posted write. */
 	return 0;
 }
 
-- 
2.51.0


