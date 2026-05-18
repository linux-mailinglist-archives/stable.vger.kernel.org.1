Return-Path: <stable+bounces-249169-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LTTDA56Cmqe1wQAu9opvQ
	(envelope-from <stable+bounces-249169-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 04:31:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E185651B3
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 04:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D31BC301FA42
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 02:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AC5373BE6;
	Mon, 18 May 2026 02:29:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3278371042;
	Mon, 18 May 2026 02:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779071397; cv=none; b=jt9oZ8tlkorvlSLU/lda+APF+LPl1SwX1bvVKEFQmK5khHK71RsUJ6vTl51qkjwARaNFRmWRr9qGfyMkCmkkbuPUclY5FfqYdObMomdpqv/O1Ob8r7LIporh0K3jfPySIDJ88QWATl5ydixn6jnnxkcUTK3GZ50xtZixIV8B9dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779071397; c=relaxed/simple;
	bh=CIxDM7FQsFjvzHecmrOxcqkKmeMWru4rlfTBN6MAD4A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J4vBTOC9/XCHfZwbHPu0hIMMzFGMfjFdU/D3PjnYJETDWK+x/xj3YOpppPGqT/lrVyr8mAffokI8hXgEglECMPkGHw+zG2j65WxrZS0Mww2R2h5n+epVSNopHqNp59t6dmmZnqv25wxdTsBpLnG/XkrRWj7yyoU5AeZXdl+fobg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6ed2f842526111f1aa26b74ffac11d73-20260518
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:1d9f5817-fed9-42c1-944c-1cc929071941,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:dd1138e5ce22c4074c88f845fc9b5b62,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6ed2f842526111f1aa26b74ffac11d73-20260518
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1363054930; Mon, 18 May 2026 10:29:44 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: dpenkler@gmail.com,
	gregkh@linuxfoundation.org,
	dominik.karol.piatkowski@protonmail.com,
	adam.quandour@gmail.com,
	kees@kernel.org
Cc: linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	kernel test robot <lkp@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] gpib: cb7210: Fix region leak when request_irq fails
Date: Mon, 18 May 2026 10:29:39 +0800
Message-Id: <20260518022939.16881-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 80E185651B3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249169-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	FREEMAIL_TO(0.00)[gmail.com,linuxfoundation.org,protonmail.com,kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,126.com,kylinos.cn,intel.com];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zenghongling@kylinos.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,kylinos.cn:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Action: no action

When request_irq() fails, the region allocated by request_region()
is not released. Fix this by adding an error handling path with
proper goto labels to release the region.

Fixes: e9dc69956d4d ("staging: gpib: Add Computer Boards GPIB driver")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605160620.ReBOadPX-lkp@intel.com/
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
Cc: stable@vger.kernel.org

---
 Changes in v2:
   - Fix variable name typo: use 'retval' instead of 'ret' (reported by test robot)
---
 drivers/gpib/cb7210/cb7210.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpib/cb7210/cb7210.c b/drivers/gpib/cb7210/cb7210.c
index 6dd8637c5964..673b5bfe2e7d 100644
--- a/drivers/gpib/cb7210/cb7210.c
+++ b/drivers/gpib/cb7210/cb7210.c
@@ -1049,7 +1049,8 @@ static int cb_isa_attach(struct gpib_board *board, const struct gpib_board_confi
 	if (!request_region(config->ibbase, cb7210_iosize, DRV_NAME)) {
 		dev_err(board->gpib_dev, "ioports starting at 0x%x are already in use\n",
 			config->ibbase);
-		return -EBUSY;
+		retval = -EBUSY;
+		goto err_release_region;
 	}
 	nec_priv->iobase = config->ibbase;
 	cb_priv->fifo_iobase = nec7210_iobase(cb_priv);
@@ -1062,11 +1063,16 @@ static int cb_isa_attach(struct gpib_board *board, const struct gpib_board_confi
 	// install interrupt handler
 	if (request_irq(config->ibirq, cb7210_interrupt, isr_flags, DRV_NAME, board)) {
 		dev_err(board->gpib_dev, "failed to obtain IRQ %d\n", config->ibirq);
-		return -EBUSY;
+		retval = -EBUSY;
+		goto err_release_region;
 	}
 	cb_priv->irq = config->ibirq;
 
 	return cb7210_init(cb_priv, board);
+
+err_release_region:
+	release_region(nec7210_iobase(cb_priv), cb7210_iosize);
+	return retval;
 }
 
 static void cb_isa_detach(struct gpib_board *board)
-- 
2.25.1


