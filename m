Return-Path: <stable+bounces-244921-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBIRHQ/n/mlLzAAAu9opvQ
	(envelope-from <stable+bounces-244921-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 09:49:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A234FE92A
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 09:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC20E302B76A
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 07:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9683806C7;
	Sat,  9 May 2026 07:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kK0k+5KR"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA3D35B63D;
	Sat,  9 May 2026 07:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778312941; cv=none; b=Lmx1bIDpCR43ST7o1kn5rzyBV1oHWHIuKYVSnhvvny5dkahXJb2g9SzLoNQs6ndVtZQL1Z708SCyF5ehl+fIcC1Jvh2/hHhqVoxo5WTJPp6+i9BP7i0yF4fA1M7Y0mdFP5R2KWC2bKwKYVHy35irbYQ6ZZvyvgFHAPbpPgO4yVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778312941; c=relaxed/simple;
	bh=0lmm43bJm6wHyWUAAmxfIVZVCishr7271DHqldppO4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PqwcALw5zk64aHEcAhKsEIwuRfAfRCpVQjNbGWye9Nx1x033KrvNv5nL3YuPRornn4kAaqSF4+Z/+4rz2eSTqfllEv7MNMgqa1Rc3jlLwzRs/KwIgbAS70Nen7V40i3Dn5wozv+IzKaLh6AhwpZzl1fStI8cvSQ7x2k6WZvq8yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kK0k+5KR; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ZT
	UWpsDi0q7O8I50MMzd6hYadrzxAun/71ZcCAsMoFA=; b=kK0k+5KRRg+sIa7OiE
	Ra7PIg0ANw+5Uo21LtrUCd1Lst6QoBIfTGW+tWthz7GBliiAq48CNjyU6VOCuPSW
	vuCJPRFoslP3/51UzDxFG/9y2Q5EBoOTij4OlIG6ukH8jlyo3QwSmDTNyMjXAhm4
	VGfcYBEuo91Fi8T1z8Bh9xP5s=
Received: from China-163-team (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3vx7H5v5pPBpuAQ--.62799S4;
	Sat, 09 May 2026 15:48:30 +0800 (CST)
From: Wenshan Lan <jetlan9@163.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	vinicius.gomes@intel.com,
	dave.jiang@intel.com,
	vkoul@kernel.org,
	jetlan9@163.com
Subject: [PATCH 6.6.y v2 2/2] dmaengine: idxd: Fix leaking event log memory
Date: Sat,  9 May 2026 15:48:22 +0800
Message-ID: <20260509074822.2587-3-jetlan9@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260509074822.2587-1-jetlan9@163.com>
References: <20260509074822.2587-1-jetlan9@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3vx7H5v5pPBpuAQ--.62799S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF1DJF4kXw1fWw1UKr4fuFg_yoW8Xw17pr
	4UW3WFyr9xWr17uw1UXF47ZFyYka17A3ySg3y2y3Wa9F43ZFy3WryftF1agr18Jr95Gay5
	Xa4aqrWxur48Jw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi1EEUUUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/xtbC7A8Hz2n+5s9zuQAA3f
X-Rspamd-Queue-Id: C9A234FE92A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,kernel.org,163.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244921-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jetlan9@163.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[163.com];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Vinicius Costa Gomes <vinicius.gomes@intel.com>

[ Upstream commit ee66bc29578391c9b48523dc9119af67bd5c7c0f ]

During the device remove process, the device is reset, causing the
configuration registers to go back to their default state, which is
zero. As the driver is checking if the event log support was enabled
before deallocating, it will fail if a reset happened before.

Do not check if the support was enabled, the check for 'idxd->evl'
being valid (only allocated if the HW capability is available) is
enough.

Fixes: 244da66cda35 ("dmaengine: idxd: setup event log configuration")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Link: https://patch.msgid.link/20260121-idxd-fix-flr-on-kernel-queues-v3-v3-10-7ed70658a9d1@intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Wenshan Lan <jetlan9@163.com>
---
 drivers/dma/idxd/device.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index e769e1f0d28b..13af4ef2f43f 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -813,10 +813,6 @@ static void idxd_device_evl_free(struct idxd_device *idxd)
 	if (!evl)
 		return;
 
-	gencfg.bits = ioread32(idxd->reg_base + IDXD_GENCFG_OFFSET);
-	if (!gencfg.evl_en)
-		return;
-
 	mutex_lock(&evl->lock);
 	gencfg.evl_en = 0;
 	iowrite32(gencfg.bits, idxd->reg_base + IDXD_GENCFG_OFFSET);
-- 
2.43.0


