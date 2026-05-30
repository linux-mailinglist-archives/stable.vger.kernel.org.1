Return-Path: <stable+bounces-257583-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFZqIcQdG2qu/QgAu9opvQ
	(envelope-from <stable+bounces-257583-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:26:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C5F60FA88
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD944307DFE7
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB6330E847;
	Sat, 30 May 2026 17:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D7yauQjx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597B1263F44;
	Sat, 30 May 2026 17:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780161486; cv=none; b=IXwPp4RbO2+mFIH28SVMdrX5fWuh+38l9urWnf8mc93aCicPQ11CftlGgpV5fgQ3f2qaedXg4HifoAMoXL+K66aIuqdoEJ1croc8N5w5PxU4Di2+J5mppkTc07rAZbLkxxa/RITWSTnxBMa8Mo4EplJ9v5OqUSXKAljoKMoRlW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780161486; c=relaxed/simple;
	bh=MPoVRjhy9Ul9zx0mPSulR9vwBuP28OwM4hKnywpABBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4+g6ryULsRze9zGHuKCnONT+CHKEtyt1Kp6md1T18MCqnx/CQLPc7x5n0GHU1ncDRN1YujsYe9a4zHjtEalhOamVcVL7w3ZxjkkUSXGzroKR9j+ilWdHaspDSPmYcyoUoxptv9aPJ2VBvv4OmxlwB47Tm1aErmNOFqK+0QCLmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D7yauQjx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589921F00893;
	Sat, 30 May 2026 17:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780161485;
	bh=4jWHuuehYrX5Wq4ZGl+FYmIM7BPYW8SvxswT1LMJG+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D7yauQjxeEdtsc7/3fJdbBH5yhnIhoGQt6RQBBQ3Tvp/eJ1Bb7hA4giFD85Qg0Zk4
	 HOwd9ilWFg1lMlqMDQ/OrJmhHPSuvw+YRzI6XXUs+vAfqydpzGyOODx/oKKlD40tAi
	 1l3aHqtFKK4mqUQZl2HDwCqOYTQJj3VqwxwLdcMo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 607/969] mtd: spi-nor: spansion: Make RD_ANY_REG_OP macro take number of dummy bytes
Date: Sat, 30 May 2026 18:02:11 +0200
Message-ID: <20260530160317.193347721@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257583-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E6C5F60FA88
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

[ Upstream commit d628783c46d3c317deb0671ceb986be358fbaf69 ]

Currently Read Any Register op is used to read volatile registers without
any dummy cycles, but the op requires dummy cycles depending on register
type (volatiler or non-volatile), device family, and device configuration.
Add 'ndummy' argument to RD_ANY_REG_OP macro to support other use cases.

Suggested-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Link: https://lore.kernel.org/r/03756e9e3ac41d2016a71d2afb702398dd0b19ed.1677557525.git.Takahiro.Kuwano@infineon.com
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Stable-dep-of: 3620d67b4849 ("mtd: spi-nor: update spi_nor_fixups::post_sfdp() documentation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/spi-nor/spansion.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index faa8a49545be7..3ae59c7822039 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -37,10 +37,10 @@
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_DATA_OUT(ndata, buf, 0))
 
-#define CYPRESS_NOR_RD_ANY_REG_OP(naddr, addr, buf)			\
+#define CYPRESS_NOR_RD_ANY_REG_OP(naddr, addr, ndummy, buf)		\
 	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RD_ANY_REG, 0),		\
 		   SPI_MEM_OP_ADDR(naddr, addr, 0),			\
-		   SPI_MEM_OP_NO_DUMMY,					\
+		   SPI_MEM_OP_DUMMY(ndummy, 0),				\
 		   SPI_MEM_OP_DATA_IN(1, buf, 0))
 
 #define SPANSION_CLSR_OP						\
@@ -148,7 +148,7 @@ static int cypress_nor_quad_enable_volatile(struct spi_nor *nor)
 
 	op = (struct spi_mem_op)
 		CYPRESS_NOR_RD_ANY_REG_OP(addr_mode_nbytes,
-					  SPINOR_REG_CYPRESS_CFR1V,
+					  SPINOR_REG_CYPRESS_CFR1V, 0,
 					  nor->bouncebuf);
 
 	ret = spi_nor_read_any_reg(nor, &op, nor->reg_proto);
@@ -173,7 +173,7 @@ static int cypress_nor_quad_enable_volatile(struct spi_nor *nor)
 	/* Read back and check it. */
 	op = (struct spi_mem_op)
 		CYPRESS_NOR_RD_ANY_REG_OP(addr_mode_nbytes,
-					  SPINOR_REG_CYPRESS_CFR1V,
+					  SPINOR_REG_CYPRESS_CFR1V, 0,
 					  nor->bouncebuf);
 	ret = spi_nor_read_any_reg(nor, &op, nor->reg_proto);
 	if (ret)
@@ -202,7 +202,7 @@ static int cypress_nor_set_page_size(struct spi_nor *nor)
 {
 	struct spi_mem_op op =
 		CYPRESS_NOR_RD_ANY_REG_OP(nor->params->addr_mode_nbytes,
-					  SPINOR_REG_CYPRESS_CFR3V,
+					  SPINOR_REG_CYPRESS_CFR3V, 0,
 					  nor->bouncebuf);
 	int ret;
 
-- 
2.53.0




