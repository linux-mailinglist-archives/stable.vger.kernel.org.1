Return-Path: <stable+bounces-254699-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EH0IneiF2osLwgAu9opvQ
	(envelope-from <stable+bounces-254699-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 04:03:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BCD5EBA74
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 04:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B06B303DD17
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 02:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE2C2248A3;
	Thu, 28 May 2026 02:03:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEF82E718B;
	Thu, 28 May 2026 02:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779933810; cv=none; b=eiwVGhks6oSRD7NWyB9ElDcc5yrYwptk69HPmCTam2fbjS0f2QHedE3fgXDXJ66DjK6rK2zOvxpQNanm/87+u9qn0zrmgx/qCa+AaWUBW9gHuofuSXIrIQt35y2aQXkH9nbdAPA1vvM66b0IaBVcLfV7J1ZjXVPNuCZ+rCehk+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779933810; c=relaxed/simple;
	bh=9e65qgcU6UrnYgnWOYVQ0efxW6VtTPj1fK/IM/xgs2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AEjrvj1O0nJGIOPyNlzZnxq0hcO9j83cUm5P5R+RrCRkiRVTSDjYhaUMFW9Ub+9VRx2vHNvKSgIz0/ETJ92RMb19d/miLxR7w+cL0lZ90qKQY70BdCeDjwao+nseiF1HsZcjRIWrDC2zNYTkpwr6/6lqjLc4p4SL6k6SAmv/Uik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 67510caa5a3911f1aa26b74ffac11d73-20260528
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:22559811-f1cc-4b30-a328-cd2116ec1aed,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:8a1a4817c540f06c7001fdb9491d7e33,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 67510caa5a3911f1aa26b74ffac11d73-20260528
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 665599067; Thu, 28 May 2026 10:03:21 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: dpenkler@gmail.com,
	gregkh@linuxfoundation.org,
	dominik.karol.piatkowski@protonmail.com,
	lukeyang.dev@gmail.com,
	kees@kernel.org
Cc: linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] gpib: ines: Fix resource leak in ines_isa_attach()
Date: Thu, 28 May 2026 10:03:17 +0800
Message-Id: <20260528020317.14836-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254699-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	FREEMAIL_TO(0.00)[gmail.com,linuxfoundation.org,protonmail.com,kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,126.com,kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zenghongling@kylinos.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.719];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:mid,kylinos.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E7BCD5EBA74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When request_irq() fails in ines_isa_attach(), the function returns -1
without releasing the I/O port region that was successfully acquired
earlier by request_region(). This causes a resource leak.

Fix this by adding a proper error path that releases the I/O port
region before returning.

Fixes: 0de51244e7b7e3 ("gpib: ines: use request_region for isa devices")
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
Cc: stable@vger.kernel.org
---
 drivers/gpib/ines/ines_gpib.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpib/ines/ines_gpib.c b/drivers/gpib/ines/ines_gpib.c
index c000f647fbb5..1e5112d05dfc 100644
--- a/drivers/gpib/ines/ines_gpib.c
+++ b/drivers/gpib/ines/ines_gpib.c
@@ -911,11 +911,16 @@ static int ines_isa_attach(struct gpib_board *board, const struct gpib_board_con
 	nec7210_board_reset(nec_priv, board);
 	if (request_irq(config->ibirq, ines_pci_interrupt, isr_flags, DRV_NAME, board)) {
 		dev_err(board->gpib_dev, "failed to allocate IRQ %d\n", config->ibirq);
-		return -1;
+		retval = -ENODEV;
+		goto err_release_region;
 	}
 	ines_priv->irq = config->ibirq;
 	ines_online(ines_priv, board, 1);
 	return 0;
+
+err_release_region:
+	release_region(config->ibbase, ines_isa_iosize);
+	return retval;
 }
 
 static void ines_pci_detach(struct gpib_board *board)
-- 
2.25.1


