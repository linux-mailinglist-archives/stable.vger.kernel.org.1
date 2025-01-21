Return-Path: <stable+bounces-109994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF5AA1850D
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 19:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6381F7A6BB4
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 18:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAA31F76B5;
	Tue, 21 Jan 2025 18:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dYlJ/pQa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBD91F76AA;
	Tue, 21 Jan 2025 18:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737483034; cv=none; b=Mzq80zryh5BVH948HZGVi+rXO3IJ1UMHFxwWCRLyEpnGMQ3EHwpGKp3H17ivFD4OuPK3kARzXaX+UrPnf0TeShZsmeAT4lgoYBkbFOayIQXUpA7X39igxR2tOyUg++k0Uako6iDj645GH82kFyvi3mReW4DcHFpg+2lTZDU7cD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737483034; c=relaxed/simple;
	bh=s3MSu1FHIXk9JOcFBZ3VvVaMvl6de0YpDCH/f5d5fY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDP2Ix50FFAW5PkJAL0Vv2Y+vwRpd3pl78SIzzeY+tPG3SBo2xU1hsQXhS1otyXxvDt/kxTkKspTSQWqRZemum/TWtlRBc9/RycuS/GwNDhSt7j/YoT70N1s9aQLrWsN+FtV8Z6PVRGq2kW1YXiasJvQ8d/b/Fb4zcyHYn7pwNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dYlJ/pQa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C441C4CEDF;
	Tue, 21 Jan 2025 18:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737483034;
	bh=s3MSu1FHIXk9JOcFBZ3VvVaMvl6de0YpDCH/f5d5fY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dYlJ/pQaegTW4eRrmalkk2bK60QV0IfkQqtaP3oNEZoL+2E7Gyq6pAsQTH1otDQN2
	 uuSX1g+uN1g/DXF6yMiz5U42IcMxLY6Yx9UFquAzQkvyOjHHUSv7WY5o5RwuJVgeCV
	 qNqVgQkkKMaxe54DpUl2fE8CnNtJsAGWgPYW0GoY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 093/127] Revert "mtd: spi-nor: core: replace dummy buswidth from addr to data"
Date: Tue, 21 Jan 2025 18:52:45 +0100
Message-ID: <20250121174533.233906616@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250121174529.674452028@linuxfoundation.org>
References: <20250121174529.674452028@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pratyush Yadav <pratyush@kernel.org>

[ Upstream commit d15638bf76ad47874ecb5dc386f0945fc0b2a875 ]

This reverts commit 98d1fb94ce75f39febd456d6d3cbbe58b6678795.

The commit uses data nbits instead of addr nbits for dummy phase. This
causes a regression for all boards where spi-tx-bus-width is smaller
than spi-rx-bus-width. It is a common pattern for boards to have
spi-tx-bus-width == 1 and spi-rx-bus-width > 1. The regression causes
all reads with a dummy phase to become unavailable for such boards,
leading to a usually slower 0-dummy-cycle read being selected.

Most controllers' supports_op hooks call spi_mem_default_supports_op().
In spi_mem_default_supports_op(), spi_mem_check_buswidth() is called to
check if the buswidths for the op can actually be supported by the
board's wiring. This wiring information comes from (among other things)
the spi-{tx,rx}-bus-width DT properties. Based on these properties,
SPI_TX_* or SPI_RX_* flags are set by of_spi_parse_dt().
spi_mem_check_buswidth() then uses these flags to make the decision
whether an op can be supported by the board's wiring (in a way,
indirectly checking against spi-{rx,tx}-bus-width).

Now the tricky bit here is that spi_mem_check_buswidth() does:

	if (op->dummy.nbytes &&
	    spi_check_buswidth_req(mem, op->dummy.buswidth, true))
		return false;

The true argument to spi_check_buswidth_req() means the op is treated as
a TX op. For a board that has say 1-bit TX and 4-bit RX, a 4-bit dummy
TX is considered as unsupported, and the op gets rejected.

The commit being reverted uses the data buswidth for dummy buswidth. So
for reads, the RX buswidth gets used for the dummy phase, uncovering
this issue. In reality, a dummy phase is neither RX nor TX. As the name
suggests, these are just dummy cycles that send or receive no data, and
thus don't really need to have any buswidth at all.

Ideally, dummy phases should not be checked against the board's wiring
capabilities at all, and should only be sanity-checked for having a sane
buswidth value. Since we are now at rc7 and such a change might
introduce many unexpected bugs, revert the commit for now. It can be
sent out later along with the spi_mem_check_buswidth() fix.

Fixes: 98d1fb94ce75 ("mtd: spi-nor: core: replace dummy buswidth from addr to data")
Reported-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Closes: https://lore.kernel.org/linux-mtd/3342163.44csPzL39Z@steina-w/
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/spi-nor/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 4e66354b87f37..e115aab7243e1 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -89,7 +89,7 @@ void spi_nor_spimem_setup_op(const struct spi_nor *nor,
 		op->addr.buswidth = spi_nor_get_protocol_addr_nbits(proto);
 
 	if (op->dummy.nbytes)
-		op->dummy.buswidth = spi_nor_get_protocol_data_nbits(proto);
+		op->dummy.buswidth = spi_nor_get_protocol_addr_nbits(proto);
 
 	if (op->data.nbytes)
 		op->data.buswidth = spi_nor_get_protocol_data_nbits(proto);
-- 
2.39.5




