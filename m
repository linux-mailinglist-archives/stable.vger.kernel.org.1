Return-Path: <stable+bounces-244014-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AobFsmq+Wky+wIAu9opvQ
	(envelope-from <stable+bounces-244014-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 10:31:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 771414C8AE2
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 10:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B90FD30157E7
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 08:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58A22D0C84;
	Tue,  5 May 2026 08:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rulkc.org header.i=@rulkc.org header.b="LDKs5+2p"
X-Original-To: stable@vger.kernel.org
Received: from mail.rulkc.org (mail.rulkc.org [155.212.184.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B14B21018A;
	Tue,  5 May 2026 08:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.212.184.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777969856; cv=none; b=naI5erJEIqviaExF2CmV3lw1/TKBf2NG731TG39Mp/HKI1ae2trwDucTnlQ47OyT0S8TSrfkxaSW/1D3JBEsW2eL4l913h3r/xMRu5tfGnxzqkiMnAQ1kOoG/qR+uySlQZvDPvdXC5/xcMW8BwQE8L2waGoSf8LVE1YIdrAzCEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777969856; c=relaxed/simple;
	bh=zVieooqU+J7JUhEmGlq6Mm6YHBJva8CQ8CC34yPSy+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DUX+7hfTHdzoQWiC4l5fGdl3wHZz7FUgEdrmDAUQ6pKHceg8NB9Iy8IUx20Qxj2F4CUvCpRH3DFdeO7LB7okWUjS4fU4bzgPY4Po4zXhRC1Ej+l2IzPhT1Dx8YccInqOd8blDcUCYJKSfspbON8z7NQdC8tget4mr2W7VBCDK1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rulkc.org; spf=pass smtp.mailfrom=rulkc.org; dkim=pass (2048-bit key) header.d=rulkc.org header.i=@rulkc.org header.b=LDKs5+2p; arc=none smtp.client-ip=155.212.184.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rulkc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rulkc.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BCED31000EC;
	Tue,  5 May 2026 11:30:46 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rulkc.org; s=dkim;
	t=1777969850; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=q7t8MrRJBq4aCjr+OmwYrbkXqqcXSUAe/YZDL4CoyLY=;
	b=LDKs5+2p55RIdcaZBPKKFd1HBkEof4LQdtUtRhpKenHTDVNIupey72YsSSqAn877pdy0yt
	PX4IgrMLK0oiLWzTolLUNO1O1Gfu48kWtObKVYJBIu/1Bk8LrzmEi/MfLH6CepvS598YFu
	K0CBeu5n1p9sSrHMrw0fpjANVciPkXYLaRn2KYiU05b0V9gML+ff4Yfsg21wRny0j6KRtS
	C0UXMcaRI6+Ju4KGqqxZJWGTp/1XD1UwYU6lY1Imxdcoy/Vjis0X3j6QGG52K73wZrZW1u
	xp+Y2hGjIYM/w4Bb3Z0UMmWjteyJZM/CW+xkkxrmGXFLxHjwuInzqK1vukLnJg==
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
Subject: [PATCH v2] mtd: rawnand: fix condition in 'nand_select_target()'
Date: Tue,  5 May 2026 11:30:30 +0300
Message-ID: <20260505083030.322528-1-avkrasnov@rulkc.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 771414C8AE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[rulkc.org,reject];
	R_DKIM_ALLOW(-0.20)[rulkc.org:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,linuxtesting.org,gmail.com,rulkc.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-244014-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avkrasnov@rulkc.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[rulkc.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rulkc.org:email,rulkc.org:dkim,rulkc.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

'cs' here must be in range [0:nanddev_ntargets[.

Cc: stable@vger.kernel.org
Fixes: 32813e288414 ("mtd: rawnand: Get rid of chip->numchips")
Signed-off-by: Arseniy Krasnov <avkrasnov@rulkc.org>
---
 Changelog v1->v2:
 * Commit message typo updates.

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


