Return-Path: <stable+bounces-244814-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kELfAgI7/mkroAAAu9opvQ
	(envelope-from <stable+bounces-244814-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 21:35:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 302474FB2B6
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 21:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B391306FE6D
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 19:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9B34218AF;
	Fri,  8 May 2026 19:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4BZDnmy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15E142189E
	for <stable@vger.kernel.org>; Fri,  8 May 2026 19:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778268729; cv=none; b=LZ9X5+rkFNHjRjws7p5MV2FedZtJjPNp17tqdjSM8MO0b1LOZlEJtzWItiBeMVcNqRLb1zVN3cIYN8jb32R+ekLWM1UDK7dg6cl4sPjxhUtovlMVZYNcOhzAVwiG5rt2nRTN703Q/HgLdQrDpBTmojdsSMBWtX0pyf5EQ2eO1v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778268729; c=relaxed/simple;
	bh=2r2ofgEqkjXEUP2Ek3lPGjePMz9iwf5NNxgCj5wzIC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WEJsQiDz7UIl2MAtTSu8M6XVNDntg73ilVuTk9XQpZTdxZBuzXCwCdTLVARvX1IoE9o8SliJRakm481zSXzUs6mg2ZZaTSyczzncCgUCDBypwR9FW1TeyAU39JF0tpODZFi62FbMgPzZx5X+jz5a3Ec/EIJ3+9Vs0srMeF4u8iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4BZDnmy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FCEC2BCC9;
	Fri,  8 May 2026 19:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778268728;
	bh=2r2ofgEqkjXEUP2Ek3lPGjePMz9iwf5NNxgCj5wzIC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A4BZDnmy3e3147HGUldCbgYXgwwrFwRVMgzQtGKmNmudkC0p8r8JOp6TUfsT0wxhP
	 5cMjyuEVgmZTIFQy9juufTfePGIiPc/0emBnMIAnD53tlyKUJnpmLCQ3yig8z7beQk
	 wGH0k86m6XRVzi/ta2DfkcV2Hm8sygGKUcwBmO5UKdIPncUuQYwrjwwQfxWfYwDpJM
	 JjQIRig6jJuZqyEz0JZVSSy0BB8RkaXLDBMqmnAeYHZxn3o10n9OTh0HXHL4BBXfl8
	 kKMzJ0/vUhFO+/XBvbt9t2QrG2LpKSJ3M0QGOJqEhJfH2sKM/ccoaLB1OrVnXd1Ik7
	 pcSKXih7qSrwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	Pratyush Yadav <pratyush@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] mtd: spi-nor: sst: Factor out common write operation to `sst_nor_write_data()`
Date: Fri,  8 May 2026 15:32:03 -0400
Message-ID: <20260508193205.1850313-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050405-sizzling-activate-5c93@gregkh>
References: <2026050405-sizzling-activate-5c93@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 302474FB2B6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-244814-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

From: Csókás, Bence <csokas.bence@prolan.hu>

[ Upstream commit 18bcb4aa54eab75dce41e5c176a1c2bff94f0f79 ]

Writing to the Flash in `sst_nor_write()` is a 3-step process:
first an optional one-byte write to get 2-byte-aligned, then the
bulk of the data is written out in vendor-specific 2-byte writes.
Finally, if there's a byte left over, another one-byte write.
This was implemented 3 times in the body of `sst_nor_write()`.
To reduce code duplication, factor out these sub-steps to their
own function.

Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
[pratyush@kernel.org: fixup whitespace, use %zu instead of %i in WARN()]
Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
Link: https://lore.kernel.org/r/20240710091401.1282824-1-csokas.bence@prolan.hu
Stable-dep-of: a0f64241d356 ("mtd: spi-nor: sst: Fix write enable before AAI sequence")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/spi-nor/sst.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
index 63bcc97bf978f..8b705ff66615d 100644
--- a/drivers/mtd/spi-nor/sst.c
+++ b/drivers/mtd/spi-nor/sst.c
@@ -117,6 +117,21 @@ static const struct flash_info sst_nor_parts[] = {
 		.fixups = &sst26vf_nor_fixups },
 };
 
+static int sst_nor_write_data(struct spi_nor *nor, loff_t to, size_t len,
+			      const u_char *buf)
+{
+	u8 op = (len == 1) ? SPINOR_OP_BP : SPINOR_OP_AAI_WP;
+	int ret;
+
+	nor->program_opcode = op;
+	ret = spi_nor_write_data(nor, to, 1, buf);
+	if (ret < 0)
+		return ret;
+	WARN(ret != len, "While writing %zu byte written %i bytes\n", len, ret);
+
+	return spi_nor_wait_till_ready(nor);
+}
+
 static int sst_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 			 size_t *retlen, const u_char *buf)
 {
@@ -138,16 +153,10 @@ static int sst_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 
 	/* Start write from odd address. */
 	if (to % 2) {
-		nor->program_opcode = SPINOR_OP_BP;
-
 		/* write one byte. */
-		ret = spi_nor_write_data(nor, to, 1, buf);
+		ret = sst_nor_write_data(nor, to, 1, buf);
 		if (ret < 0)
 			goto out;
-		WARN(ret != 1, "While writing 1 byte written %i bytes\n", ret);
-		ret = spi_nor_wait_till_ready(nor);
-		if (ret)
-			goto out;
 
 		to++;
 		actual++;
@@ -155,16 +164,11 @@ static int sst_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 
 	/* Write out most of the data here. */
 	for (; actual < len - 1; actual += 2) {
-		nor->program_opcode = SPINOR_OP_AAI_WP;
-
 		/* write two bytes. */
-		ret = spi_nor_write_data(nor, to, 2, buf + actual);
+		ret = sst_nor_write_data(nor, to, 2, buf + actual);
 		if (ret < 0)
 			goto out;
-		WARN(ret != 2, "While writing 2 bytes written %i bytes\n", ret);
-		ret = spi_nor_wait_till_ready(nor);
-		if (ret)
-			goto out;
+
 		to += 2;
 		nor->sst_write_second = true;
 	}
@@ -184,14 +188,9 @@ static int sst_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 		if (ret)
 			goto out;
 
-		nor->program_opcode = SPINOR_OP_BP;
-		ret = spi_nor_write_data(nor, to, 1, buf + actual);
+		ret = sst_nor_write_data(nor, to, 1, buf + actual);
 		if (ret < 0)
 			goto out;
-		WARN(ret != 1, "While writing 1 byte written %i bytes\n", ret);
-		ret = spi_nor_wait_till_ready(nor);
-		if (ret)
-			goto out;
 
 		actual += 1;
 
-- 
2.53.0


