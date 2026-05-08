Return-Path: <stable+bounces-244833-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMFYOR1T/mntpAAAu9opvQ
	(envelope-from <stable+bounces-244833-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 23:18:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 915614FBD79
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 23:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D861E3009094
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 21:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7607E376464;
	Fri,  8 May 2026 21:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQjUW8W5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B51336896
	for <stable@vger.kernel.org>; Fri,  8 May 2026 21:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778275099; cv=none; b=dlhoWiEsCZYKrs6Ly8nNx1O/TUWRydceX1WVUbe2Mb3odlQp+X5bwF053nKG1Ft1YNwBRrBZ60lefZle0XJVUYINal8W32tUfWdSCpq1kJETOhgtSblC4xy9argG6zYSLL7v5HiVV+RgAcP00b1wPVjU1TkBbjhsy63TpjwhYjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778275099; c=relaxed/simple;
	bh=xBgJyvA/bM47mnjHadGw0FOuT/Z4Gf7GGt1qER6NKpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfUsiReILwKIipF0MU5ZeUhCOkn18dAlmLrQvEyNuQEOEqi3YV8hhgj0dr722evo+g9HYXHZcMeb2Ybb1gaJDXsuR8k5hG+5EkbxxiqYQ0FQMQ4yRQupH7wb1baqIFd3cS0EKJjUY3uJrSai1hAXY4YfwWyNM8oBhC3VXLldaMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQjUW8W5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD3AC2BCB0;
	Fri,  8 May 2026 21:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778275098;
	bh=xBgJyvA/bM47mnjHadGw0FOuT/Z4Gf7GGt1qER6NKpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bQjUW8W5KMVUdDTt4GoUMQph/PnDMGj1vqI33p59jKRJSJjfrJeHX7fgjdrWk7ZQp
	 gcw/j9yHqv9bgGDpqfJvug0CpOilk9SuP72C9MfKdPcqzFxnXOzjVUgvLGmTpxjCbS
	 oCm2m4I9hy2L2b1lnw5q9RLeE9mRpgXzK/zgG4d/kMV8RgVooy1zPJZByjpWHQYNtb
	 YSBTd9K+3usPRzXdJU823TWvikZVLmV7pxnmsDfxZforadxXWl60awpMSC2GfGq+uU
	 2UjyRgHQ2asyMANJKtQEMt/9T1W0pkfOnHNXVQjz/OWXJ+6qZAZddqLmvMs9rtW1gl
	 L2rJ5csQEBLMg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sanjaikumar V S <sanjaikumar.vs@dicortech.com>,
	Hendrik Donner <hd@os-cillation.de>,
	"Pratyush Yadav (Google)" <pratyush@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mtd: spi-nor: sst: Fix write enable before AAI sequence
Date: Fri,  8 May 2026 17:18:16 -0400
Message-ID: <20260508211816.1960968-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050406-deputize-unengaged-f5c5@gregkh>
References: <2026050406-deputize-unengaged-f5c5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 915614FBD79
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244833-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,os-cillation.de:email]
X-Rspamd-Action: no action

From: Sanjaikumar V S <sanjaikumar.vs@dicortech.com>

[ Upstream commit a0f64241d3566a49c0a9b33ba7ae458ae22003a9 ]

When writing to SST flash starting at an odd address, a single byte is
first programmed using the byte program (BP) command. After this
operation completes, the flash hardware automatically clears the Write
Enable Latch (WEL) bit.

If an AAI (Auto Address Increment) word program sequence follows, it
requires WEL to be set. Without re-enabling writes, the AAI sequence
fails.

Add spi_nor_write_enable() after the odd-address byte program when more
data needs to be written. Use a local boolean for clarity.

Fixes: b199489d37b2 ("mtd: spi-nor: add the framework for SPI NOR")
Cc: stable@vger.kernel.org
Signed-off-by: Sanjaikumar V S <sanjaikumar.vs@dicortech.com>
Tested-by: Hendrik Donner <hd@os-cillation.de>
Reviewed-by: Hendrik Donner <hd@os-cillation.de>
Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
[ kept inline `nor->program_opcode = SPINOR_OP_BP;` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/spi-nor/sst.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
index 980f4c09c91de..4c970c33957a3 100644
--- a/drivers/mtd/spi-nor/sst.c
+++ b/drivers/mtd/spi-nor/sst.c
@@ -112,6 +112,8 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
 
 	/* Start write from odd address. */
 	if (to % 2) {
+		bool needs_write_enable = (len > 1);
+
 		nor->program_opcode = SPINOR_OP_BP;
 
 		/* write one byte. */
@@ -125,6 +127,17 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
 
 		to++;
 		actual++;
+
+		/*
+		 * Byte program clears the write enable latch. If more
+		 * data needs to be written using the AAI sequence,
+		 * re-enable writes.
+		 */
+		if (needs_write_enable) {
+			ret = spi_nor_write_enable(nor);
+			if (ret)
+				goto out;
+		}
 	}
 
 	/* Write out most of the data here. */
-- 
2.53.0


