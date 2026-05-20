Return-Path: <stable+bounces-253076-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ICWGssLDmot5wUAu9opvQ
	(envelope-from <stable+bounces-253076-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:30:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2455985F4
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1FD3B334A86A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6387C427A08;
	Wed, 20 May 2026 18:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HVTRs3jY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78D0425CFA;
	Wed, 20 May 2026 18:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302342; cv=none; b=lXcDG/LCvFm78H+U17SMf+EJaAhWdKy79u52aEcfIANp6bXic0d4dOyzLOTkXTcv9biP3lkCZGybWAEc9IZumF9IqRP4s2KwTbd0XZTtPKcSZt7ux0LESzyGY96iOlSjqe2D3NK45H53k+W3bDtLRDNPvbw5MU3ouH1P/Z7Dc2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302342; c=relaxed/simple;
	bh=Lr7uEMkKZI2X7j6NpZU2TR9uW66KEl+Xzx2eQE6otdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJzDSytriwpCCKQqfBqlBmdyEm1Y+K8g4Ks/5BktkvVANgs/wLFUpeJnV1Qb/ompytrUeHUEEEsiTdSSSg8+au2oNPlSREp5qY9tt1PNCCVYV/evFi8Qcrp7wIoGLiIrpVEZgvfmrNjPuwHfbcghLMekRcw47UehxOjJMS5bx8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HVTRs3jY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF6F1F008A7;
	Wed, 20 May 2026 18:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779302340;
	bh=qSby1O+6yB39dGwg7N8sg3RbR4MJHdAg9bS2IXsKGLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HVTRs3jYXVz5WkqK3E7v5AuQSeRA+M/DuBh6cZykkU0cd6A4ghiNXrlQygvD5QKPw
	 0Cl5JDWp4vxIMzpcEc4z2cZlmzU66c6vaJYcEDj8S1uYOAgg9olri/Uxq0KAo/fghG
	 eJLlq69eGI0hNr1xnfRk356wgVY/+L6TOIE2cIBE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shiji Yang <yangshiji66@outlook.com>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	"Pratyush Yadav (Google)" <pratyush@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 230/508] mtd: spi-nor: swp: check SR_TB flag when getting tb_mask
Date: Wed, 20 May 2026 18:20:53 +0200
Message-ID: <20260520162103.634325732@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162058.573354582@linuxfoundation.org>
References: <20260520162058.573354582@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253076-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,outlook.com,kernel.org,bootlin.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,outlook.com:email]
X-Rspamd-Queue-Id: 6B2455985F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shiji Yang <yangshiji66@outlook.com>

[ Upstream commit 94645aa41bf9ecb87c2ce78b1c3405bfb6074a37 ]

When the chip does not support top/bottom block protect, the tb_mask
must be set to 0, otherwise SR1 bit5 will be unexpectedly modified.

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
Fixes: 3dd8012a8eeb ("mtd: spi-nor: add TB (Top/Bottom) protect support")
Reviewed-by: Michael Walle <mwalle@kernel.org>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/spi-nor/swp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/swp.c b/drivers/mtd/spi-nor/swp.c
index a186d1fde8694..4f34283603587 100644
--- a/drivers/mtd/spi-nor/swp.c
+++ b/drivers/mtd/spi-nor/swp.c
@@ -27,8 +27,10 @@ static u8 spi_nor_get_sr_tb_mask(struct spi_nor *nor)
 {
 	if (nor->flags & SNOR_F_HAS_SR_TB_BIT6)
 		return SR_TB_BIT6;
-	else
+	else if (nor->flags & SNOR_F_HAS_SR_TB)
 		return SR_TB_BIT5;
+	else
+		return 0;
 }
 
 static u64 spi_nor_get_min_prot_length_sr(struct spi_nor *nor)
-- 
2.53.0




