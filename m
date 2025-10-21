Return-Path: <stable+bounces-188397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F6BBF8072
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 20:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3EE0408692
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 18:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8117434F27C;
	Tue, 21 Oct 2025 18:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqAJOc+X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F397355815
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 18:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761070449; cv=none; b=cnfS5lhcKvM3Hluy2P/ZNZQ/R3zwqhmlIHX23Auy66ZKDQKKo28Kv6QxhyBZ2PEJnC0IJxA/vscywz4fmVHNUYuRU6gpb644IICQPIGeneWjnWGW+89eEIdKyGYoNAGvRXD211Cit25J2v3dUrTWlbv8xh9E8EP/osAnT2pP8oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761070449; c=relaxed/simple;
	bh=edcwxSFs1rx0MqZGWryPy+KdgywrSBJHNKgxSXFTlCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HHzpkr8ik10+79/BnxCS8H8g2QDePkIUSlgDZli4mml5n3374acKTGJZIXhON6e9gT3wYeh7J2HvqE08kieuU6JhELR2SC7K298+Eh3V15N7PpCxWwHn6vKZPy7S+ubK9NlSPemjeZUeP99/ETs2Yy8LimY/XA9VDM/2LHcD3JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqAJOc+X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A341C4CEF1;
	Tue, 21 Oct 2025 18:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761070449;
	bh=edcwxSFs1rx0MqZGWryPy+KdgywrSBJHNKgxSXFTlCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QqAJOc+XI0WU0rJPK/k17fD/y/ic/6lLcY/mIal7CgO/4lbsUT5+F/PiyfFFlKAZn
	 hD2/ATn40yX4GmQp7V1LbgpjuDsIi6sSUFgN6EauqPIrY6sLrnmpw97LOeyE3EEjv7
	 XRnVoujaOLA0ArHZZ1SfgA38IkM6HbLUnDXo+TT3mOJIVswBoZccA6CzoN1/OpjEcN
	 EufthOOlQYPLDD0xA3ygkXe2+a4irIeHAHwM1HTufZn+Thy0c3lKTAm/5W6uBactqL
	 L1MAwzqJhBDFtSf6gf8g5MhPlUu3Ck/P8nQVbk9PG68Evv1MhrKByoE/pdnfRuXTSB
	 qaM1coMUVSv5w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pratyush Yadav <pratyush@kernel.org>,
	Santhosh Kumar K <s-k6@ti.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] spi: cadence-quadspi: Flush posted register writes before DAC access
Date: Tue, 21 Oct 2025 14:14:06 -0400
Message-ID: <20251021181406.2495307-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101635-laurel-crawling-2104@gregkh>
References: <2025101635-laurel-crawling-2104@gregkh>
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
[ backported to drivers/mtd/spi-nor ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/spi-nor/cadence-quadspi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
index 7bdc558d85601..85c05973ec4cb 100644
--- a/drivers/mtd/spi-nor/cadence-quadspi.c
+++ b/drivers/mtd/spi-nor/cadence-quadspi.c
@@ -496,6 +496,7 @@ static int cqspi_read_setup(struct spi_nor *nor)
 	reg &= ~CQSPI_REG_SIZE_ADDRESS_MASK;
 	reg |= (nor->addr_width - 1);
 	writel(reg, reg_base + CQSPI_REG_SIZE);
+	readl(reg_base + CQSPI_REG_SIZE); /* Flush posted write. */
 	return 0;
 }
 
@@ -608,6 +609,7 @@ static int cqspi_write_setup(struct spi_nor *nor)
 	reg &= ~CQSPI_REG_SIZE_ADDRESS_MASK;
 	reg |= (nor->addr_width - 1);
 	writel(reg, reg_base + CQSPI_REG_SIZE);
+	readl(reg_base + CQSPI_REG_SIZE); /* Flush posted write. */
 	return 0;
 }
 
-- 
2.51.0


