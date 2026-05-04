Return-Path: <stable+bounces-243921-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FRiCHQZ+Wlc5gIAu9opvQ
	(envelope-from <stable+bounces-243921-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 00:11:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA964C450E
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 00:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 84493300B1AA
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 22:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7225537BE78;
	Mon,  4 May 2026 22:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rulkc.org header.i=@rulkc.org header.b="EwdnCP/U"
X-Original-To: stable@vger.kernel.org
Received: from mail.rulkc.org (mail.rulkc.org [155.212.184.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6EB2DCF45;
	Mon,  4 May 2026 22:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.212.184.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777932655; cv=none; b=D82hDDzkVxWlnrP05nr5QA3PLezCyPc8UHOuT/fBbCu9bEzESc5WKorpYC+VfmkuOqMN5w9WsbomRU1OwNf1tioDlWrsR9s2vhuqFrjccocscmqSDD+F9EwWuDHY5Zqdg0uKEVzfsR0VzYlvAbga5nFmu1ASySyb4dTFkwG+JtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777932655; c=relaxed/simple;
	bh=tEehmQtDegZFxXuafZ00Yb2xEyd90WkOHl4+sFhpbyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ToiJhxxFtjJahC5BBvL7u/yVvk2Jf8j1XtXErL/KvgEBZjFRp/HtXj8phOKAdfgGXQyGzdf0JD7aUtZxS4HVtbAOPSjWVmVho7ZrXFEh8+RR4sIAoR5MOYEFPcjjLALNfhESlnMhysGyOay0Nm440OHPGE9uWUCc3p5PneZaUwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rulkc.org; spf=pass smtp.mailfrom=rulkc.org; dkim=pass (2048-bit key) header.d=rulkc.org header.i=@rulkc.org header.b=EwdnCP/U; arc=none smtp.client-ip=155.212.184.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rulkc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rulkc.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 23FA7100036;
	Tue,  5 May 2026 01:10:39 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rulkc.org; s=dkim;
	t=1777932648; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=2pJdonCvAwld4fN0yK+Xb4wRHrqadLgYk32qyWpwm5w=;
	b=EwdnCP/UfNaCJtQp4gMxFS/oHIQUm3csgs8flJs0WhksOp+BDGJHp/kV80kj8aZCT9IwS1
	vfSXUgERRnADLxLPRB//UaXrpRSEA/yS9Dl5psrhFX1rW/eZUr6GWLUSIW/Bv1VrfCdYj8
	R09suF8AocShHLhy4at3X9CPo8peNRtGDT830QMqaqgdy5xu6+yNnaBmHAjQ74bKZ3Ac0p
	dAgCCnBNmkyxfn08IrXIwbNnHDOTiHdX4TR/EmHV24FGz0tV1CurIV98e8Jkp3wPUBYFwT
	zT2u1Ol40yHaZ81TjT2JJo0HGaV1jxvOLGmUA/Ezgp/7P23oWUaCAJ+uxiTW9A==
From: Arseniy Krasnov <avkrasnov@rulkc.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Boris Brezillon <bbrezillon@kernel.org>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	rulkc@linuxtesting.org,
	oxffffaa@gmail.com,
	Arseniy Krasnov <avkrasnov@rulkc.org>,
	stable@vger.kernel.org
Subject: [PATCH v1] mtd: rawnand: fix condition in 'nand_select_target()'
Date: Tue,  5 May 2026 01:10:12 +0300
Message-ID: <20260504221012.1310605-1-avkrasnov@rulkc.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 9DA964C450E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[rulkc.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[rulkc.org:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243921-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,linuxtesting.org,gmail.com,rulkc.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avkrasnov@rulkc.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[rulkc.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

'cs' here must in range [0:nanddev_ntargets).

Cc: stable@vger.kernel.org
Fixes: 32813e288414 ("mtd: rawnand: Get rid of chip->numchips")
Signed-off-by: Arseniy Krasnov <avkrasnov@rulkc.org>
---
 drivers/mtd/nand/raw/nand_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 13e4060bd1b6a..edfee22f15a73 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -174,7 +174,7 @@ void nand_select_target(struct nand_chip *chip, unsigned int cs)
 	 * cs should always lie between 0 and nanddev_ntargets(), when that's
 	 * not the case it's a bug and the caller should be fixed.
 	 */
-	if (WARN_ON(cs > nanddev_ntargets(&chip->base)))
+	if (WARN_ON(cs >= nanddev_ntargets(&chip->base)))
 		return;
 
 	chip->cur_cs = cs;
-- 
2.47.3


