Return-Path: <stable+bounces-257582-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PJVD0kcG2p3/QgAu9opvQ
	(envelope-from <stable+bounces-257582-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:20:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF18C60F6A9
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A5BA83034215
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED662263F44;
	Sat, 30 May 2026 17:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2bZOQYx8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCAE30E829;
	Sat, 30 May 2026 17:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780161482; cv=none; b=tnhgZYpq0vRvRTtYwjN3cpD9DwcWvkO95gN+BpXHRGKsCITxazAVXmQP/BvJPSDsvsTzYkDCCJF9B2Iqz4mb+nGICbBmB0KhRMPJNWCpYr7AI4YKaZt903G/XP3sPDvgEANufENzob2JVyKqwtY3GZkw6o+s+Zi4Bu8iOl3z7nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780161482; c=relaxed/simple;
	bh=1D1d3uF53dbM9hELnvb9BlpqWoQCXp+9bOUzI4PK2dI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQUU7czOs00XnxxkX9GGiWYEQkRSKqgS1oxFn5g1fvvLIAjXMxw2glCQsp2jPcothWGhO0GO6KF+NRj68iG6yHO5ZzXm/yfYd0vsnwUo6NAGnqwi4o9tzwzRTf+6wsZv7CaDUod2CvNAP8CyLsJK+c6F2+2cLny26r4OmDy6T04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2bZOQYx8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136921F00893;
	Sat, 30 May 2026 17:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780161481;
	bh=C5XuAYSJG2Qp7oTJPHsG1+lA+s6x5LljQP7uoEPDSPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=2bZOQYx81IqjeyMdRblKK/2LUbt0u7Qoj03qAa/mJVvpZSHGkRN9Xc5Yi1eSBPW+Z
	 iMb20pH6ifXwTdOeMhZ7ZXTbSuVZLWIUwugAFf6wSMblj3hv0TxNSHvB1HoRl1AKK8
	 4ZIypTBl9R5y0fc/yS8LUc3rLAS2HcLHmK32rYJ8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tudor Ambarus <tudor.ambarus@microchip.com>,
	Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 606/969] mtd: spi-nor: spansion: Replace hardcoded values for addr_nbytes/addr_mode_nbytes
Date: Sat, 30 May 2026 18:02:10 +0200
Message-ID: <20260530160317.166090832@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257582-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CF18C60F6A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tudor Ambarus <tudor.ambarus@microchip.com>

[ Upstream commit 05ebc1ccb8affcbaaa9f8b8fe56839cbfc9b9144 ]

We track in the core the internal address mode of the flash. Stop using
hardcoded values for the number of bytes of address and use
nor->addr_nbytes and nor->params->addr_mode_nbytes instead.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Tested-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Link: https://lore.kernel.org/r/20220728041451.85559-2-tudor.ambarus@microchip.com
Stable-dep-of: 3620d67b4849 ("mtd: spi-nor: update spi_nor_fixups::post_sfdp() documentation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/spi-nor/spansion.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 0109fccca7ea2..faa8a49545be7 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -54,11 +54,13 @@ static int cypress_nor_octal_dtr_en(struct spi_nor *nor)
 	struct spi_mem_op op;
 	u8 *buf = nor->bouncebuf;
 	int ret;
+	u8 addr_mode_nbytes = nor->params->addr_mode_nbytes;
 
 	/* Use 24 dummy cycles for memory array reads. */
 	*buf = SPINOR_REG_CYPRESS_CFR2V_MEMLAT_11_24;
 	op = (struct spi_mem_op)
-		CYPRESS_NOR_WR_ANY_REG_OP(3, SPINOR_REG_CYPRESS_CFR2V, 1, buf);
+		CYPRESS_NOR_WR_ANY_REG_OP(addr_mode_nbytes,
+					  SPINOR_REG_CYPRESS_CFR2V, 1, buf);
 
 	ret = spi_nor_write_any_volatile_reg(nor, &op, nor->reg_proto);
 	if (ret)
@@ -69,14 +71,16 @@ static int cypress_nor_octal_dtr_en(struct spi_nor *nor)
 	/* Set the octal and DTR enable bits. */
 	buf[0] = SPINOR_REG_CYPRESS_CFR5V_OCT_DTR_EN;
 	op = (struct spi_mem_op)
-		CYPRESS_NOR_WR_ANY_REG_OP(3, SPINOR_REG_CYPRESS_CFR5V, 1, buf);
+		CYPRESS_NOR_WR_ANY_REG_OP(addr_mode_nbytes,
+					  SPINOR_REG_CYPRESS_CFR5V, 1, buf);
 
 	ret = spi_nor_write_any_volatile_reg(nor, &op, nor->reg_proto);
 	if (ret)
 		return ret;
 
 	/* Read flash ID to make sure the switch was successful. */
-	ret = spi_nor_read_id(nor, 4, 3, buf, SNOR_PROTO_8_8_8_DTR);
+	ret = spi_nor_read_id(nor, nor->addr_nbytes, 3, buf,
+			      SNOR_PROTO_8_8_8_DTR);
 	if (ret) {
 		dev_dbg(nor->dev, "error %d reading JEDEC ID after enabling 8D-8D-8D mode\n", ret);
 		return ret;
@@ -102,7 +106,8 @@ static int cypress_nor_octal_dtr_dis(struct spi_nor *nor)
 	buf[0] = SPINOR_REG_CYPRESS_CFR5V_OCT_DTR_DS;
 	buf[1] = 0;
 	op = (struct spi_mem_op)
-		CYPRESS_NOR_WR_ANY_REG_OP(4, SPINOR_REG_CYPRESS_CFR5V, 2, buf);
+		CYPRESS_NOR_WR_ANY_REG_OP(nor->addr_nbytes,
+					  SPINOR_REG_CYPRESS_CFR5V, 2, buf);
 	ret = spi_nor_write_any_volatile_reg(nor, &op, SNOR_PROTO_8_8_8_DTR);
 	if (ret)
 		return ret;
@@ -196,7 +201,8 @@ static int cypress_nor_quad_enable_volatile(struct spi_nor *nor)
 static int cypress_nor_set_page_size(struct spi_nor *nor)
 {
 	struct spi_mem_op op =
-		CYPRESS_NOR_RD_ANY_REG_OP(3, SPINOR_REG_CYPRESS_CFR3V,
+		CYPRESS_NOR_RD_ANY_REG_OP(nor->params->addr_mode_nbytes,
+					  SPINOR_REG_CYPRESS_CFR3V,
 					  nor->bouncebuf);
 	int ret;
 
-- 
2.53.0




