Return-Path: <stable+bounces-230365-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHTcIkkXxGlvwQQAu9opvQ
	(envelope-from <stable+bounces-230365-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 18:11:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2A3329A79
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 18:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87863301C8B1
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 17:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659423FF888;
	Wed, 25 Mar 2026 17:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="upJpg+bk"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A923FCB07
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 17:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774458306; cv=none; b=rWAiFIOOKp+ZbWHonGOEk0emzWCRU8P7jFWCn59wVhvn34oRH68IzuIWz+j48sNnu16ZzXgwyJgm77K0Kc66UNn2x6mKOW8cgaRIRQAPK42BJfCHNhYKCHqYr6LmD/F4LzrURb7YeT2ettYlRxzFM1ONQneY+JpGoGwuumA2dJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774458306; c=relaxed/simple;
	bh=7478S8Y2/HSpoAXBxEwzt3CRrYFyT4cxo1oj1wdwk2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rHcJ4DSKHlcWKOi8+G8EbzPoyq5WDBfgrb0Fh862HsZaVN3ZLGsN/O1FZubrbm3OFwh0pilqVJEf0cFvOAzGPW3fkUhxYuH0pbbCO91L8spdU6JS/n8uCKLLHGo7EfvO2UuuHsU6nfX/+lI7r/XQZz5H7b3qu+bTZymX75xejag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=upJpg+bk; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8669A1A2FEC;
	Wed, 25 Mar 2026 17:04:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5A8B2601E2;
	Wed, 25 Mar 2026 17:04:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4652210450E99;
	Wed, 25 Mar 2026 18:04:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774458295; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=/NNlFm5wYdx/X/cIoEotMZfWV7mGMvMIKFK+lvElmOQ=;
	b=upJpg+bkcB0DgFPqoDtr6gVAd+KCgjLlm1tuYIstDFTZjzQq7/Tl2s1jQNa7s7FKFLAnsx
	vTilrkaFf2NNmWqj00EKGhNB3I31sHOoacL3SSRNiQHMOYwv+cRkdyIyzLSE7DGpnt/U4q
	8sB8mQTDLmx5BcYWEnjb/GjYDKxgz2f5HDmdHrhQ1nhJW1hYIodWNaPRSDkZpSIb3KW24z
	pZCAmZyaidRZdl5ShGWdEA9wpj3TpekNknMDR1bhgXv0va8JLaoqFMmccTMzlXMlJAClQb
	X3hWyMhREg5DhSUKaFdkpk46iyHTvbsW/aIj9EWNR2dSuEzNQ4XCOCk400iCXQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>,
	<linux-mtd@lists.infradead.org>
Cc: Steam Lin <stlin2@winbond.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	stable@vger.kernel.org
Subject: [PATCH] mtd: spinand: winbond: Declare the QE bit on W25NxxJW
Date: Wed, 25 Mar 2026 18:04:50 +0100
Message-ID: <20260325170450.1118324-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230365-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[miquel.raynal@bootlin.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[bootlin.com:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid]
X-Rspamd-Queue-Id: DA2A3329A79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Factory default for this bit is "set" (at least on the chips I have),
but we must make sure it is actually set by Linux explicitly, as the
bit is writable by an earlier stage.

Fixes: 6a804fb72de5 ("mtd: spinand: winbond: add support for serial NAND flash")
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/winbond.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index e0138785e280..ad22774096e6 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -488,7 +488,7 @@ static const struct spinand_info winbond_spinand_table[] = {
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_dual_quad_dtr_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
-		     0,
+		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&w25n01jw_ooblayout, NULL),
 		     SPINAND_CONFIGURE_CHIP(w25n0xjw_hs_cfg)),
 	SPINAND_INFO("W25N01KV", /* 3.3V */
@@ -552,7 +552,7 @@ static const struct spinand_info winbond_spinand_table[] = {
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_dual_quad_dtr_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
-		     0,
+		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL),
 		     SPINAND_CONFIGURE_CHIP(w25n0xjw_hs_cfg)),
 	SPINAND_INFO("W25N02KV", /* 3.3V */
-- 
2.51.1


