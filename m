Return-Path: <stable+bounces-270088-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id su5BFgB+RGoXvwoAu9opvQ
	(envelope-from <stable+bounces-270088-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 04:40:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 236586E9467
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 04:39:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Bj8Way8a;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270088-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270088-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1B6993010CA1
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 02:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83F636167B;
	Wed,  1 Jul 2026 02:39:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FEA21257F
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 02:39:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782873592; cv=none; b=SNjWI+cNEUQt/Fq+RV3PqcwlJcFs6wb4FIKmjTUsSyNq+gwAwsS6uElyLuErNOADRAMAX2LGrUNx+HTiF0KM3t1HF8sHTH3l04/Z+GJxta6P4YcJlMDHuY6WonMBeKo7R5WKVC2Q7hmm24zMur/gWbivKpD7P9SJurJfgaRCJnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782873592; c=relaxed/simple;
	bh=Taobu97kSS/BoYiN0TR+2a4iyUBtc3Kw7iUJ8JW5lkE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z1Pvr1bC6pD8hZwn0hdS+lL4CjgsqaxpGwAVrHhBWPJ+pWt6CwlCDgZa+bOKfBsnhDBY7QkvKKgmeTXW17fhiZK9ZjDKzexwEB4UjkBXuylbSRIYHWVMwP2M2W22Ndzs6wyFTaounmbZz9O61jrNnzucHaIzJSu8WDgkYs2it4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bj8Way8a; arc=none smtp.client-ip=209.85.210.181
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-845eb7b96feso98033b3a.0
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 19:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782873590; x=1783478390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lhBKIBTyUUlzBSrRoY3fwwZdfAj9Qw3eVw3ezZbn3wQ=;
        b=Bj8Way8aYzYBhqBju2qxeNClnh3gR2aJTfCGZZDHA+3kPvnRoSiaTpqvkcpgIQ2jN1
         0wtgQM8vhSHJOjBXq55V3gOpmwhl9YFJD8prZ7tzn7rJKGThrW/2Lq81afGGsLZf68L/
         nxEZFh409t+1K5n+QlwE1hFVh05Tqz76O3UC6wmoiEjujUq2krHuQ0EeP2ImHkcQqdwf
         wlZ/5WhTqDb3+dqooGXfQYCVJTFf+movys1EDHYDUlKsZFySW3sJg3vwLuzkYXz9u5fF
         iRTdHLdkUzRSzsPo6GTm4Kv6aR+iE4K5nlebAQ5ezgW7eXBpmpkbfazsxtvnvnlkzLRc
         CK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782873590; x=1783478390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhBKIBTyUUlzBSrRoY3fwwZdfAj9Qw3eVw3ezZbn3wQ=;
        b=Uc7Ei6yIs9weDukxpts5x0AhwtEeEl0Al99M4lBjgllRZDyIMZ0Eoav7ldXuC/93co
         ufaVZPcPATDjjeYBtAs5AodGD4smgRkbQV85u2LkffSTkPX/nsBnipc5LNGWcI49R/9q
         WXqyim313DSLZ8kB35W2TJ5cSDXEAAckkWf1AOo3Z2DSdHwDPQskMkbD9RFAd0ojyOHf
         Qrny21SQnrramCCX4k/Tvj+qq7CWZiMSoCyZf1gZz/p2+/DRpLeT0VEnqqUu11PaqaDm
         H2dJXsggeW9JwMr7Xg29E/wdZhrmB/Fhe1Rw/lotHtPdUvHw2Y5Kr6u81kpZp0FhRGox
         dx7A==
X-Gm-Message-State: AOJu0YxFbUuW5CS6yrSbmyhOBHGaW7NyUKebjQPkZUev+WL2ENXhPZ8D
	WdW9Ow9Csz0daknYWj0O6IXpBHEDXlUHDJETOZSc0msI6y7PpLDxNinw
X-Gm-Gg: AfdE7ck4DqrKlwEfqB4737FhYX5/1veHanNyg3Pf6thw4iVKBZCMycunqTa3dFvZyZK
	euMoGl203t6baCx3TrFDGSFUAu7YAOwn2WGTVsAWmk97Ww3UB401lowK0SfwZF6PIUbw3E7T4Qk
	TJj4wFLzSzE70Rek8ulQE/G5oAywCwQhTtvNJVat46DyMcSN1SaMSW6bGot8nuDujNAHg7cr1Mr
	PbYRMuUNUQ6fl94URU7LFIyc+dYoFjvSVObkaDkc1m4DQaZ/nABtsd7H0zNPK2HM4YBBY5F+uv5
	tYj7Xe/YI5OwoqaB9IOjAy/bGQiUKjGuWql+5wNsnEqd1xOZxSi8qYACpH13gAMqzUgbYZgXacB
	4xB999sQe0Rnfoa9W3ZsvxGIakWxyi6I3t5G3oWhBniNhPjc5DBsuXvbXRrXQ1KQZLq3y6Z6z6q
	BmbnzhTQ2h7gHdGDH4f4jfLAq06k7EkH/C3bg=
X-Received: by 2002:a05:6a00:3408:b0:845:bc1d:40f4 with SMTP id d2e1a72fcca58-847addc8f6dmr2692628b3a.27.1782873590337;
        Tue, 30 Jun 2026 19:39:50 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a0329c08sm3058685b3a.42.2026.06.30.19.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 19:39:49 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (unknown [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 40F31416A065;
	Wed,  1 Jul 2026 10:39:47 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: stable@vger.kernel.org
Cc: tudor.ambarus@linaro.org,
	pratyush@kernel.org,
	mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	alvinzhou@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH 6.6.y] mtd: spi-nor: macronix: Add post_sfdp fixups for Quad Input Page Program
Date: Wed,  1 Jul 2026 10:36:18 +0800
Message-Id: <20260701023619.2730136-1-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270088-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:tudor.ambarus@linaro.org,m:pratyush@kernel.org,m:mwalle@kernel.org,m:miquel.raynal@bootlin.com,m:richard@nod.at,m:vigneshr@ti.com,m:linux-mtd@lists.infradead.org,m:alvinzhou@mxic.com.tw,m:chengminglin@mxic.com.tw,s:lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[linchengming884@gmail.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[linchengming884@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mxic.com.tw:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 236586E9467

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

commit 798aafeffb369c5eb36e406b18970ef27baa820d upstream.

Although certain Macronix NOR flash support the Quad Input Page Program
feature, the corresponding information in the 4-byte Address Instruction
Table of these flash is not properly filled. As a result, this feature
cannot be enabled as expected.

To address this issue, a post_sfdp fixups implementation is required to
correct the missing information.

Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
Link: https://lore.kernel.org/r/20250211063028.382169-2-linchengming884@gmail.com
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/macronix.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index eb149e517c1f..b676a71822a3 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -28,8 +28,26 @@ mx25l25635_post_bfpt_fixups(struct spi_nor *nor,
 	return 0;
 }
 
+static int
+macronix_qpp4b_post_sfdp_fixups(struct spi_nor *nor)
+{
+	/* PP_1_1_4_4B is supported but missing in 4BAIT. */
+	struct spi_nor_flash_parameter *params = nor->params;
+
+	params->hwcaps.mask |= SNOR_HWCAPS_PP_1_1_4;
+	spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP_1_1_4],
+				SPINOR_OP_PP_1_1_4_4B, SNOR_PROTO_1_1_4);
+
+	return 0;
+}
+
 static const struct spi_nor_fixups mx25l25635_fixups = {
 	.post_bfpt = mx25l25635_post_bfpt_fixups,
+	.post_sfdp = macronix_qpp4b_post_sfdp_fixups,
+};
+
+static const struct spi_nor_fixups macronix_qpp4b_fixups = {
+	.post_sfdp = macronix_qpp4b_post_sfdp_fixups,
 };
 
 static const struct flash_info macronix_nor_parts[] = {
@@ -81,7 +99,8 @@ static const struct flash_info macronix_nor_parts[] = {
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
 	{ "mx25u51245g", INFO(0xc2253a, 0, 64 * 1024, 1024)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
-		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
+		.fixups = &macronix_qpp4b_fixups },
 	{ "mx25uw51245g", INFOB(0xc2813a, 0, 0, 0, 4)
 		PARSE_SFDP
 		FLAGS(SPI_NOR_RWW) },
@@ -91,18 +110,22 @@ static const struct flash_info macronix_nor_parts[] = {
 	{ "mx25l25655e", INFO(0xc22619, 0, 64 * 1024, 512) },
 	{ "mx66l51235f", INFO(0xc2201a, 0, 64 * 1024, 1024)
 		NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
-		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
+		.fixups = &macronix_qpp4b_fixups },
 	{ "mx66u51235f", INFO(0xc2253a, 0, 64 * 1024, 1024)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
-		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
+		.fixups = &macronix_qpp4b_fixups },
 	{ "mx66l1g45g",  INFO(0xc2201b, 0, 64 * 1024, 2048)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
-			      SPI_NOR_QUAD_READ) },
+			      SPI_NOR_QUAD_READ)
+		.fixups = &macronix_qpp4b_fixups },
 	{ "mx66l1g55g",  INFO(0xc2261b, 0, 64 * 1024, 2048)
 		NO_SFDP_FLAGS(SPI_NOR_QUAD_READ) },
 	{ "mx66u2g45g",	 INFO(0xc2253c, 0, 64 * 1024, 4096)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
-		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
+		.fixups = &macronix_qpp4b_fixups },
 };
 
 static void macronix_nor_default_init(struct spi_nor *nor)
-- 
2.25.1


