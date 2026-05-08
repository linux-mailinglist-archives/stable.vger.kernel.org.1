Return-Path: <stable+bounces-244819-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNoEF/k+/mmHoQAAu9opvQ
	(envelope-from <stable+bounces-244819-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 21:52:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2854FB482
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 21:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B8D63019163
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 19:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F663364943;
	Fri,  8 May 2026 19:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTu7OLUo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332EB2BD11
	for <stable@vger.kernel.org>; Fri,  8 May 2026 19:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778269940; cv=none; b=L2nui4vFc536chYQevAs2htHoF+HNC2EE2khJBt0ClglbexE67YD2mIMnjhixFB37/PbDKKGLkDRQIg9jI+Uqb/0LxzmMdlkPNpo/jbx+/j/SXk/bTRbZLupAhdvryo/A03yNB1f+7oYibymObxlWWpcbNiLdh9i9dkT4vWw6ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778269940; c=relaxed/simple;
	bh=l5ec+NUlf1JOEgAVChKUSJImXuYbPgIEsEfdRola/e8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qfUxfRSdfT3ZeA9xWlwFPe53nc86v4wO3V6VJCBDg7PWDVYnOm/2ckeyxIBYzrjHLzpPYjTBYgf9Cb7szzi1MN/eqiNPbWHF1j+EOAzjd5YL4avHPwFUyJgT9ar/Ek3xyR747L66OZ7p5cSdivX1C5WWww/eHOQ3c2oBwQpt0+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTu7OLUo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9B3C2BCB0;
	Fri,  8 May 2026 19:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778269939;
	bh=l5ec+NUlf1JOEgAVChKUSJImXuYbPgIEsEfdRola/e8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TTu7OLUoheIWXSE3yFVUyMr2ttimGuxA+SmjM5gzGFhPkBf0CnxrXWpo4ZkO15E+a
	 bZUrxbO5cDZBQSIy6/jW9imMwPikWKiS3jzdr4+R6FWVQFP7e01f/yBx0molAg+84m
	 f4Na5qO/hKyiG4kVSTGmphe50tTaTwvr8GX01C8kJJKDEDRYTyUXLHROAWoETIGl+/
	 OxPFepa9xqOFRR4qx7hg+ON71b0n/RR4w0V9q8r6XhyrUmFR8KyUJv+iqqHrWGciD8
	 SDH+0PdRsl9QKb3GDOIFpy1F64d2NpH0PdNf4Y4KLAySeQ1A/O7GU6vZgT9OcCaUQd
	 dmzKU+D6TElAw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mtd: spinand: winbond: Declare the QE bit on W25NxxJW
Date: Fri,  8 May 2026 15:52:17 -0400
Message-ID: <20260508195217.1877968-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050419-wobbly-truck-0b55@gregkh>
References: <2026050419-wobbly-truck-0b55@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CC2854FB482
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244819-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email]
X-Rspamd-Action: no action

From: Miquel Raynal <miquel.raynal@bootlin.com>

[ Upstream commit 7866ce992cf0d3c3b50fe8bf4acb1dbb173a2304 ]

Factory default for this bit is "set" (at least on the chips I have),
but we must make sure it is actually set by Linux explicitly, as the
bit is writable by an earlier stage.

Fixes: 6a804fb72de5 ("mtd: spinand: winbond: add support for serial NAND flash")
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
[ adapted chip name W25N02JW to W25N02JWZEIF and applied flag change via read_cache_variants context instead of read_cache_dual_quad_dtr_variants ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/spi/winbond.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index d1666b3151817..46bc06d674c0d 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -240,7 +240,7 @@ static const struct spinand_info winbond_spinand_table[] = {
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
-		     0,
+		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&w25n01jw_ooblayout, NULL)),
 	SPINAND_INFO("W25N02JWZEIF",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xbf, 0x22),
@@ -249,7 +249,7 @@ static const struct spinand_info winbond_spinand_table[] = {
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
-		     0,
+		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL)),
 	SPINAND_INFO("W25N512GW",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xba, 0x20),
-- 
2.53.0


