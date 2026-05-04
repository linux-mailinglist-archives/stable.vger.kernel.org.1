Return-Path: <stable+bounces-243910-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FkAF3kD+WlK4QIAu9opvQ
	(envelope-from <stable+bounces-243910-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 22:37:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B27814C3962
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 22:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3531D3028B17
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 20:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C447A3164C5;
	Mon,  4 May 2026 20:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rulkc.org header.i=@rulkc.org header.b="ONNo1Jdg"
X-Original-To: stable@vger.kernel.org
Received: from mail.rulkc.org (mail.rulkc.org [155.212.184.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6791E2D877D
	for <stable@vger.kernel.org>; Mon,  4 May 2026 20:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.212.184.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777926983; cv=none; b=BNUJcqy/eY4MGodW5eDI/5HzfDMunjqeEhr06LcrBhDgx7+Bhet3HMtCf5y96tIxVDkro/XIZ4GdtlQFRK/U78394g72Pzw8+N5fBm+0cY8Pi2bwRDTWBpIWNyiYjYvogP8fZK3mjigUY10sAU/BrJUEZiztxiwmSynztO4B9r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777926983; c=relaxed/simple;
	bh=tEehmQtDegZFxXuafZ00Yb2xEyd90WkOHl4+sFhpbyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BE1dvi0QYsOMkERBK+4hmkF+Er/X0T+S0Qm9V9WPrSuBFtAppYq6zTZVXVsakFudckkup3z17Vf1+YnUBZ3l3+NnoNvfQaUK0KSqB4fqh0EpUnIuxtpCtcrBamirYt+uEI6HlnAN7MA3vBxnG7wXUWjCde+ECeYp9hzpS9CNPAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rulkc.org; spf=pass smtp.mailfrom=rulkc.org; dkim=pass (2048-bit key) header.d=rulkc.org header.i=@rulkc.org header.b=ONNo1Jdg; arc=none smtp.client-ip=155.212.184.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rulkc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rulkc.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A978B100036;
	Mon,  4 May 2026 23:29:21 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rulkc.org; s=dkim;
	t=1777926562; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=2pJdonCvAwld4fN0yK+Xb4wRHrqadLgYk32qyWpwm5w=;
	b=ONNo1JdgdAHXml56mztOFdynRv/RFaFVzRuOJFs6LX86nxPCBAohxiMBtymw9EHXWKTIo7
	2a2itJZ/GFqZuwaFidgf1D5Yw12Q3Zsh5fWktUsFIs6G4OieUTSxvTHZsCKR7qej+pMsM5
	r60Vt4skrv/SxIwHwo8SYu4geddtAs9cu550XUg55eMIni6biY5cuR3fO7ZtW/D/ir0SoQ
	GrK3nF3cJ2OCGlikxiyNQaj4hV+zeursKhbDofxmc2aSQxkzkquCKh4sNCwrxCihSpxQZQ
	h7Ja1sJYRe5udsbaQWlXA4o0+ass3Gtyq+Eoot4Tlf7Vf6tWsexe3DuEjynlRw==
From: Arseniy Krasnov <avkrasnov@rulkc.org>
To: oxffffaa@gmail.com
Cc: Arseniy Krasnov <avkrasnov@rulkc.org>,
	stable@vger.kernel.org
Subject: [PATCH v1] mtd: rawnand: fix condition in 'nand_select_target()'
Date: Mon,  4 May 2026 23:28:57 +0300
Message-ID: <20260504202857.1192275-1-avkrasnov@rulkc.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: B27814C3962
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rulkc.org,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[rulkc.org:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243910-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avkrasnov@rulkc.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[rulkc.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rulkc.org:email,rulkc.org:dkim,rulkc.org:mid]

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


