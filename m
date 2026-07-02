Return-Path: <stable+bounces-270318-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EzH1I07LRWpVFQsAu9opvQ
	(envelope-from <stable+bounces-270318-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 04:22:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 962806F2FB5
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 04:22:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=DlGNsKHp;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270318-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-270318-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 332BE300E92A
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 02:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754B628030E;
	Thu,  2 Jul 2026 02:21:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C562765ED
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 02:21:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782958918; cv=none; b=kBEtvCYGVWCsUw/7YRJzAllyAryq7YvPmUeDDRCrDNdcUp4t/A80HrhPXNOEsNaA5kNrDQ97bo4DsLhZwbLat4pXL6v4g7OdwkX7i6kD7LBoAo+kxPyszmkUON2i7AfqFqvrw6aQWV1zy8xst1oE4TIWfqvHFfY8W+CsOjh99AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782958918; c=relaxed/simple;
	bh=Taobu97kSS/BoYiN0TR+2a4iyUBtc3Kw7iUJ8JW5lkE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DHPwiKl++kHmHGEPSoL89F5Fjnjx0jPs0eHUmAT4DC8E7mFDfiCuryOB0QeH0/37/Q+KXEyj4XOsTReM2Q0Yo7/7cFubMxHVb9o4k5zQNvUVtWozOI+tTFGVcpKxk7lRJh80UO/Aaf9ub3PWZwC2I8AAhQuCA2W7fqOKGFuv/Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlGNsKHp; arc=none smtp.client-ip=209.85.215.179
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c85c531d4a9so624026a12.2
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 19:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782958916; x=1783563716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhBKIBTyUUlzBSrRoY3fwwZdfAj9Qw3eVw3ezZbn3wQ=;
        b=DlGNsKHptqx5x3pnAKGE/66LBMRetGjzggvdUfgWlyHVidPQrHOkPcg4P/csnwXXkP
         6E7RjE/mmAfNBYp2nN+n2rCth9e7ZlGCyGG9ZatdSS72lfR8kdWYjhX5ORtSwDZ5+GEE
         fTYiobc7AzWJTEmG1Xk9oiR5+EXrcjfgjSVHhpttXgvcapSqGIJ44ckR2lG8jIH262XW
         Di9uFKsTTVLmnOYutW5VqcfrhnH8J7l9x+pHKljAn4BUzpYaIYgvIn5GXKv3ayKuXjc4
         ldEj8k/LptICgHZ7/L8Q5LP7eF2rp28PH+VH6eGmyhJQzOvcCb95rAvtHeQErbEKwnQZ
         CH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782958916; x=1783563716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lhBKIBTyUUlzBSrRoY3fwwZdfAj9Qw3eVw3ezZbn3wQ=;
        b=NwU2oIDlMQhYz2ufEEJ5/PKV4tFxJuF564GzW58sbBDRcPweDy01L+k16uTRKckzFK
         fofJkk6gvjJqcFxrw5bh1UzNb/R+5cjvsQKyDCPyW1J/CnLw0JhRDwq3BS88Fr98gJqz
         iwc1ywxMAhDLJqb6MezIiTMzNgrd1ACj8Ggl/KzNFWXS9wIsricEsv50vjFu0ZJzc2zn
         dtXfjjEbFBbUHgD0ZxF/eKeZD9MxgJ4qKJkaJOM7o8vliDv0Oa9I4GCSiFKtdzzEB0TO
         LSOnXPxkb513dhAkGuxrJy7IOaQxLjw7Bwe3rSBjczvD8muL3qzaHMKDtYOinRIzh8nr
         ZT5Q==
X-Gm-Message-State: AOJu0YyF+35+LTUK2UNIqfNyy7JBYh2UqqO9Jxgxv3G5IgDRzaIMnv4L
	xrDmF05rZykwNVHjk9HIAChUluk2J+SmXNU+tGOTtvmE9nkiHSeIpa7E
X-Gm-Gg: AfdE7cme3+85r7yI58+pBegRWO7a4W9QZmtcR33XwRuwLsX7dRVM6+5ZTyjwxZdvZ5r
	P99WL0NAbcnZCnbMhebZEnbSill2ewkpJfW92oqmKwO/HvELNsTUdPFj/OtFmMiRUenLk3RBFhI
	c9byJHNDEXoRXJ54tqzG14BQrPdMpkXgKS/I+RNG9AVvjnwzlTCNgJMBIBaJkGVmRZK7vAKo2+B
	Y/C6SSPTB/Vwx3H4BmtRiK2+YiFrSC0NS8F72OLh003Z6vgV9Xutq7GBw4qZJYU2lOEONn1lnO8
	BWnUP7pyn7AJ2zZBPmGXdGO4QTNESdIDy58ofY1p4mRnOVvCw4g5Bvy7rXnuwJ2WnnaA4iEKq8I
	Wh/8oZ15JIFoOzBEtRcXKXjnxfJoRbWEy/Xkdac6hLYpz9kYqCq3s0sB7YUuBUTfsPNkp6fiKZJ
	3gM53f7HQiC8yGuHfMJrILWYHyRx7vGXB/W9o=
X-Received: by 2002:a05:6a21:697:b0:3bf:e94e:e38d with SMTP id adf61e73a8af0-3bfed472a5cmr4469448637.43.1782958916058;
        Wed, 01 Jul 2026 19:21:56 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e8eb0ef50sm602016a12.6.2026.07.01.19.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 19:21:55 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (unknown [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id E522A4163B74;
	Thu,  2 Jul 2026 10:21:52 +0800 (CST)
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
Subject: [PATCH 6.6.y v2 1/2] mtd: spi-nor: macronix: Add post_sfdp fixups for Quad Input Page Program
Date: Thu,  2 Jul 2026 10:18:41 +0800
Message-Id: <20260702021842.2771498-2-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260702021842.2771498-1-linchengming884@gmail.com>
References: <20260702021842.2771498-1-linchengming884@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270318-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:tudor.ambarus@linaro.org,m:pratyush@kernel.org,m:mwalle@kernel.org,m:miquel.raynal@bootlin.com,m:richard@nod.at,m:vigneshr@ti.com,m:linux-mtd@lists.infradead.org,m:alvinzhou@mxic.com.tw,m:chengminglin@mxic.com.tw,s:lists@lfdr.de];
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
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mxic.com.tw:email,linaro.org:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 962806F2FB5

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


