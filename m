Return-Path: <stable+bounces-251738-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gG68CcUADmo95QUAu9opvQ
	(envelope-from <stable+bounces-251738-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:43:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D685597123
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4FA4E31AD5CE
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3AD3A3E9C;
	Wed, 20 May 2026 17:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ycbjMcoz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3613D75C7;
	Wed, 20 May 2026 17:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298763; cv=none; b=nQYbNsW5i7e+/sfgMPbe9O8XcjJPu9EfGgXKVuR+FlMvoShKhOUIUPoasYf/vYIM0Z+c06lzK7B6cju/d1YEV1DCHM7IK+BlgQtfm4/9KInpi+x8Q1UccCev9knjSiyFMYH96xdCQOPO7ntL2uiKY1BGUC/FeN2m7npalCU6ch8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298763; c=relaxed/simple;
	bh=aK0AXmtmfeMCF/CsfqMCshwc6qa4A1rBnr8JSaMkyes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WEPj3ldzncwf3+duSdO/OaDfl7bmFnFfhlzwOnTpmbfuhd4LUhVTGfyAByA1GulSzPAstjOoRilOEzBx7dT2Yo7ATErcgzF6CWqBOi5UX3ngg0Y/cH8G09eSbXt2UAbeVvkBJ2EbQ7wEisBmrP374Dd55jkxNbr1qz2u6oo/RLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ycbjMcoz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0501F000E9;
	Wed, 20 May 2026 17:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298761;
	bh=h/iw333POFaarcsG2zrI1KalE81zt/pPvvLrX725/+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ycbjMcozqIBRyrzH05QrKAzL5NVo5qFnXnZFCUWkAtte5Vn3aKcn5NbhsgakcYGF+
	 Z4wWClqGvGo5PLn290QtI/30nC+ESSeFW13T9YJbapln5wT1JepsYFH7HYHXtI/8PV
	 KRXppGTwYmw1SqyCp0sLHE/cPgCbbmEAJ2m4VhKM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 482/957] mtd: spinand: winbond: Clarify when to enable the HS bit
Date: Wed, 20 May 2026 18:16:05 +0200
Message-ID: <20260520162144.977827682@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251738-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,bootlin.com:email]
X-Rspamd-Queue-Id: 4D685597123
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miquel Raynal <miquel.raynal@bootlin.com>

[ Upstream commit 25a915fad503c2678902075565d47ddc2aa45db9 ]

Above 104MHz when in fast dual or quad I/O reads, the delay between
address and data cycles is too short. It is possible to reach higher
frequencies, up to 166MHz, by adding a few more dummy cycles through the
setting of the HS bit. Improve the condition for enabling this bit, and
also make sure we set it at soon as we go over 104MHz.

Fixes: f1a91175faaa ("mtd: spinand: winbond: Enable high-speed modes on w25n0xjw")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/spi/winbond.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 0ea5b1c97d33d..578924c98b90a 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -295,16 +295,19 @@ static int w25n0xjw_hs_cfg(struct spinand_device *spinand,
 	if (iface != SSDR)
 		return -EOPNOTSUPP;
 
+	/*
+	 * SDR dual and quad I/O operations over 104MHz require the HS bit to
+	 * enable a few more dummy cycles.
+	 */
 	op = spinand->op_templates->read_cache;
 	if (op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr)
 		hs = false;
-	else if (op->cmd.buswidth == 1 && op->addr.buswidth == 1 &&
-		 op->dummy.buswidth == 1 && op->data.buswidth == 1)
+	else if (op->cmd.buswidth != 1 || op->addr.buswidth == 1)
 		hs = false;
-	else if (!op->max_freq)
-		hs = true;
-	else
+	else if (op->max_freq && op->max_freq <= 104 * HZ_PER_MHZ)
 		hs = false;
+	else
+		hs = true;
 
 	ret = spinand_read_reg_op(spinand, W25N0XJW_SR4, &sr4);
 	if (ret)
-- 
2.53.0




