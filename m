Return-Path: <stable+bounces-254515-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJhBE3CtFmpHoQcAu9opvQ
	(envelope-from <stable+bounces-254515-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 10:38:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 259A75E1394
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 10:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 69D7D30054C8
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 08:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B647B3CFF5D;
	Wed, 27 May 2026 08:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.cn header.i=@sina.cn header.b="NX1gdJ1J"
X-Original-To: stable@vger.kernel.org
Received: from smtp134-31.sina.com.cn (smtp134-31.sina.com.cn [180.149.134.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA96E3E0099
	for <stable@vger.kernel.org>; Wed, 27 May 2026 08:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779871083; cv=none; b=iMYI6ub6EVTBfgZNG+BWdJB+Prjf0BJlXcqQmYIWDFxiC41AZi1eeI1+Mmd70KMmBerYmtv6J2k9bvOGO8jwJAm4W9Du2EfCE2/l9owLASt2qzXD23DbdYtNM0RJPhNwQkkNZbw935sbmEdsgaNuPH2ZZR6DQDg6EVPb0cG6Yg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779871083; c=relaxed/simple;
	bh=I4z+8VJYqVpgPjvdWJRlhh8HGFRyBISwIf3srYDkqD8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CqmVI4MwqreR5ibY1/gPJOUYcshpWNL08KULpVO57Nra8TFvwsskhpHKmOh4YvVwpiQo+OoG91UShkJHRAsaDuFBj74UoBqfPubmtmR5FPMyxtXurwnYYggs6a7WGh3AXmkXj425/01DTidtPK0tlzh5bmH3YQMHKDErY84fe1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.cn; spf=pass smtp.mailfrom=sina.cn; dkim=pass (1024-bit key) header.d=sina.cn header.i=@sina.cn header.b=NX1gdJ1J; arc=none smtp.client-ip=180.149.134.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.cn; s=201208; t=1779871077;
	bh=gwu+gTKA7b0+si9XlOBPWbZl86uenv532knH+cVPbuI=;
	h=From:Subject:Date:Message-Id;
	b=NX1gdJ1JoC1oM8zhHA95PpywfhtxKwSgHnYwzp2cDgQNQpnsg6wZ0ZTDPaClvkCBU
	 S7iYNkkG/10D5ZifAGekTa70fTN0OyrpuwM+Uh6L9ztzX8ReEeVUIImCeKdhLnD7m1
	 OkFNCLJWdg524pTvIaU97MT8pGU1djHkS+ws+oQs=
X-SMAIL-HELO: NTT-kernel-dev
Received: from unknown (HELO NTT-kernel-dev)([60.247.85.88])
	by sina.cn (10.185.250.21) with ESMTP
	id 6A16AD5C00006FCD; Wed, 27 May 2026 16:37:53 +0800 (CST)
X-Sender: jianqkang@sina.cn
X-Auth-ID: jianqkang@sina.cn
Authentication-Results: sina.cn;
	 spf=none smtp.mailfrom=jianqkang@sina.cn;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=jianqkang@sina.cn
X-SMAIL-MID: 5039023408329
X-SMAIL-UIID: 830C8500393149C4904CED70BAF0D1F0-20260527-163753-1
From: Jianqiang kang <jianqkang@sina.cn>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	adrian.hunter@intel.com
Cc: patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com,
	sashal@kernel.org,
	billy_tsai@aspeedtech.com,
	npitre@baylibre.com,
	boris.brezillon@collabora.com,
	linux-i3c@lists.infradead.org
Subject: [PATCH 5.15.y] i3c: mipi-i3c-hci: Correct RING_CTRL_ABORT handling in DMA dequeue
Date: Wed, 27 May 2026 16:37:47 +0800
Message-Id: <20260527083747.3865086-1-jianqkang@sina.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sina.cn,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[sina.cn:s=201208];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-254515-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jianqkang@sina.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sina.cn:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[sina.cn];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,intel.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,bootlin.com:email,msgid.link:url,sina.cn:email,sina.cn:mid,sina.cn:dkim]
X-Rspamd-Queue-Id: 259A75E1394
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Adrian Hunter <adrian.hunter@intel.com>

[ Upstream commit b795e68bf3073d67bebbb5a44d93f49efc5b8cc7 ]

The logic used to abort the DMA ring contains several flaws:

 1. The driver unconditionally issues a ring abort even when the ring has
    already stopped.
 2. The completion used to wait for abort completion is never
    re-initialized, resulting in incorrect wait behavior.
 3. The abort sequence unintentionally clears RING_CTRL_ENABLE, which
    resets hardware ring pointers and disrupts the controller state.
 4. If the ring is already stopped, the abort operation should be
    considered successful without attempting further action.

Fix the abort handling by checking whether the ring is running before
issuing an abort, re-initializing the completion when needed, ensuring that
RING_CTRL_ENABLE remains asserted during abort, and treating an already
stopped ring as a successful condition.

Fixes: 9ad9a52cce282 ("i3c/master: introduce the mipi-i3c-hci driver")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260306072451.11131-9-adrian.hunter@intel.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Jianqiang kang <jianqkang@sina.cn>
---
 drivers/i3c/master/mipi-i3c-hci/dma.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/dma.c b/drivers/i3c/master/mipi-i3c-hci/dma.c
index 28f40f805cb5..abfcf4902f01 100644
--- a/drivers/i3c/master/mipi-i3c-hci/dma.c
+++ b/drivers/i3c/master/mipi-i3c-hci/dma.c
@@ -448,16 +448,23 @@ static bool hci_dma_dequeue_xfer(struct i3c_hci *hci,
 	struct hci_rh_data *rh = &rings->headers[xfer_list[0].ring_number];
 	unsigned int i;
 	bool did_unqueue = false;
-
-	/* stop the ring */
-	rh_reg_write(RING_CONTROL, RING_CTRL_ABORT);
-	if (wait_for_completion_timeout(&rh->op_done, HZ) == 0) {
-		/*
-		 * We're deep in it if ever this condition is ever met.
-		 * Hardware might still be writing to memory, etc.
-		 */
-		dev_crit(&hci->master.dev, "unable to abort the ring\n");
-		WARN_ON(1);
+	u32 ring_status;
+
+	ring_status = rh_reg_read(RING_STATUS);
+	if (ring_status & RING_STATUS_RUNNING) {
+		/* stop the ring */
+		reinit_completion(&rh->op_done);
+		rh_reg_write(RING_CONTROL, RING_CTRL_ENABLE | RING_CTRL_ABORT);
+		wait_for_completion_timeout(&rh->op_done, HZ);
+		ring_status = rh_reg_read(RING_STATUS);
+		if (ring_status & RING_STATUS_RUNNING) {
+			/*
+			 * We're deep in it if ever this condition is ever met.
+			 * Hardware might still be writing to memory, etc.
+			 */
+			dev_crit(&hci->master.dev, "unable to abort the ring\n");
+			WARN_ON(1);
+		}
 	}
 
 	for (i = 0; i < n; i++) {
-- 
2.34.1


