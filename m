Return-Path: <stable+bounces-254130-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIqyOJ8xFGqUKgcAu9opvQ
	(envelope-from <stable+bounces-254130-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 13:25:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 839A65C9EA0
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 13:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08393301778F
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 11:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6277437F72A;
	Mon, 25 May 2026 11:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="jhqCRc/P"
X-Original-To: stable@vger.kernel.org
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072C437D134;
	Mon, 25 May 2026 11:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779708280; cv=none; b=ZayDhkYts6OMJ8vNrV9JhV4rX1iI1Z9F9pX2xvMaueDSY8CAn4odPDTeUsc1bXMDW0VSZoo1826ejn8bE53xZeoBp51g7mXHnDp7NFLPRKl107VLcL1sIaixdHpD6U2Ao5vcF+5X48TcvPQTlu+k45Csg+dpVsQnT6SfdB8X+3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779708280; c=relaxed/simple;
	bh=uxLP8IbyUY1c4syNBTYNja87B/Fv7UleF8C+qDT8zMU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=r6bVbt4EM4hxDTIaXuAdHWoJqHmzi11fTGGaW1NsKjlpBkX+zUsU/G7PWVwNZCOZVmv0r45+uRUazOqxxa4O0/AOCRm8Ue3b+mrSJ7LONB//87Q6YowaNXfQV7BrKYPHG5IRq0b1H+wx80OAzXFQYtLIvtVK0dN5cv/rr/N4JfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=jhqCRc/P; arc=none smtp.client-ip=212.27.42.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from [127.0.1.1] (unknown [91.160.0.144])
	(Authenticated sender: vjardin@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 148BBB0051E;
	Mon, 25 May 2026 13:24:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1779708269;
	bh=uxLP8IbyUY1c4syNBTYNja87B/Fv7UleF8C+qDT8zMU=;
	h=From:Subject:Date:To:Cc:From;
	b=jhqCRc/PehNw3nqF2B2O4/2bqBpdPkGXQP35+CUsg0a5EMGjXcVS4aNUkDmWMoip3
	 SzX5bDpg8g5aHmBCAnAf8dnoTyi0C6xrFnNoKAjerNZJCSRjoQJnd5+jDRMUnzHSMl
	 UH9Qcijk4KsVswkLjpxe11PfaQK2nJF2YC4x8pu7MxMNv1utSQwg6Fs0YGSUcfh46F
	 bF/CW2Tce/lhGkCpLxOE9kUaOQj2xGu9BVXHxAy1Fy24rwcPFB2GKxT+RJQywoClKi
	 yZeA1khX9in+kArfr89M6ejVhttRETJE2T3H1Z2rvXNeMd8Iw3ktx2JqxxfwjEAOHP
	 AF/iXEaLdxedQ==
From: Vincent Jardin <vjardin@free.fr>
Subject: [PATCH 0/2] i2c: imx: fix SMBus block-read of 0 locking the bus
Date: Mon, 25 May 2026 13:24:01 +0200
Message-Id: <20260525-for-upstream-i2c-lx2160-fix-v1-v1-0-f30ab53dd97c@free.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFExFGoC/x2NywqEMAwAf0VyNpBGKuiviIfajbsBX6Qqgvjvl
 j0OAzM3JDGVBG1xg8mpSdclgysLiL+wfAX1kxmYuCbPHsfV8NjSbhJmVI44XexqwlEvPB1SHAI
 FoqYSDzmymWTzH3T987wKnwFBcAAAAA==
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Andi Shyti <andi.shyti@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
 Wolfram Sang <wsa@kernel.org>, 
 Kaushal Butala <kaushalkernelmailinglist@gmail.com>, 
 Shawn Guo <shawn.guo@freescale.com>, 
 Stefan Eichenberger <stefan.eichenberger@toradex.com>
Cc: linux-i2c@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Vincent Jardin <vjardin@free.fr>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779708249; l=982;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=uxLP8IbyUY1c4syNBTYNja87B/Fv7UleF8C+qDT8zMU=;
 b=hkA59lEEOgeOFJ62bM+X3GOA+PH/x5di7iGQBCaVOjxVxUp+FZp9cFCnIJDDQxlkgi9lopr6U
 iwT9zSFoOLtB2OVKP/wOMpRkBZp/8xxLcR0qu4nvFHYWOHzy3ctSyy9
X-Developer-Key: i=vjardin@free.fr; a=ed25519;
 pk=hppgLeFpGpKOi7LNwGEZ4jOYofJCoGd4Jf1ltAabiLw=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[free.fr,quarantine];
	R_DKIM_ALLOW(-0.20)[free.fr:s=smtp-20201208];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-254130-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com,freescale.com,toradex.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[free.fr];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,lists.infradead.org,free.fr];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vjardin@free.fr,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[free.fr:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 839A65C9EA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

i2c-imx rejects a SMBus Block Read byte count of 0 (valid per SMBus 3.1
6.5.7) and it returns without a NACK+STOP, leaving the target
holding SDA so the bus is stuck until a power cycle occur.

The same bug is occuring with two independently introduced spots, so the
fix is two patches with their respective Fixes: tags and backport ranges:

  1/2  atomic/polling path       Fixes: 8e8782c71595   v3.16+
  2/2  IRQ-driven state machine  Fixes: 5f5c2d4579ca   v6.13+

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
Vincent Jardin (2):
      i2c: imx: fix locked bus on SMBus block-read of 0 (atomic)
      i2c: imx: fix locked bus on SMBus block-read of 0 (IRQ)

 drivers/i2c/busses/i2c-imx.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)
---
base-commit: 6916d5703ddf9a38f1f6c2cc793381a24ee914c6
change-id: 20260525-for-upstream-i2c-lx2160-fix-v1-0cba0a0093e5

Best regards,
-- 
Vincent Jardin <vjardin@free.fr>


