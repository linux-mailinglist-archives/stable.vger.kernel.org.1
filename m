Return-Path: <stable+bounces-244492-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3ibQIYsP/GlYKwAAu9opvQ
	(envelope-from <stable+bounces-244492-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 06:05:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA3C4E2C36
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 06:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B55D301A3A8
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 04:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBF031A06C;
	Thu,  7 May 2026 04:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="A7k8XZdZ"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9DFE54B;
	Thu,  7 May 2026 04:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778126726; cv=none; b=Txl92Rp/+c9z3mXnVu6xyX1L1rz6KMS29pZu7LMwh1JykBvkwTm2usMOzKPuSvSU+wzN8crwURf04QP7jKRzFxJP7OjwqBAb9YyxoK7FErjzP/2FqFFGbCiECDIbjWidSMdxeHXMpFj/9nLtg9YsrdW1McjEpDJ4MRabdeJnXbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778126726; c=relaxed/simple;
	bh=MmAfVNgswV1A/GH3+xzR7PBvCp/DxhJsraw5eqMnaUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CtWe5IcfKslkqK8V/WDnjQ1UtyLBov/7Q9S5pEP4bK/znRrA9/fk82TBy2DKCf0aj/lwLCktqC9mmv6v3AxLHqTc0HxAOTNeNvCVecb3vxz1IaLbDefmuKVD/Pp5qvmQ60F0iIC9p+7kvCI6y05ikLrCMK2Lfv6mZ3kLYcZT848=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=A7k8XZdZ; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=re
	1V+v7DE5nMX1bAvXkE2YoTYPQe4SG/giVN4idndX4=; b=A7k8XZdZVOXGGyG/2g
	RWNOAx7nIGfmb5zBFpHyopThbleixNbR3sBRHvoKXtec4xAjJAz3hgrzie6uYbvn
	URuxAMiKodSPLbNnTEXDx4U4gQBqkp9pQ5CKBfV6DHl2VET5Rfy5kWsz83TVOgXX
	khIbPeLfTNZJ4Gjo6vhsoeMMQ=
Received: from China-163-team (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgBn6FtgD_xp7H1CCw--.49S2;
	Thu, 07 May 2026 12:04:53 +0800 (CST)
From: Wenshan Lan <jetlan9@163.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 6.6.y] dmaengine: idxd: Fix leaking event log memory
Date: Thu,  7 May 2026 12:04:15 +0800
Message-ID: <20260507040415.565-1-jetlan9@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgBn6FtgD_xp7H1CCw--.49S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF1DJF4kXw1fWw1UKr4fuFg_yoW8WFyrpr
	4UW3WFyr9xWr17uw4jva1IqFy5Ka10y3ySg3y2ya4a9FWrZFy3WrZ3tF1a9r18Jr93Gay5
	Xa4aqrWxuF48J3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEWE_ZUUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/xtbC6wd2P2n8D2cqdAAA3G
X-Rspamd-Queue-Id: CCA3C4E2C36
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244492-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,kernel.org,163.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jetlan9@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
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
[ Minor context conflict resolved. ]
Signed-off-by: Wenshan Lan <jetlan9@163.com>
---
 drivers/dma/idxd/device.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 44bbeb3acd14..10e54a050ea9 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -810,10 +810,6 @@ static void idxd_device_evl_free(struct idxd_device *idxd)
 	struct device *dev = &idxd->pdev->dev;
 	struct idxd_evl *evl = idxd->evl;
 
-	gencfg.bits = ioread32(idxd->reg_base + IDXD_GENCFG_OFFSET);
-	if (!gencfg.evl_en)
-		return;
-
 	mutex_lock(&evl->lock);
 	gencfg.evl_en = 0;
 	iowrite32(gencfg.bits, idxd->reg_base + IDXD_GENCFG_OFFSET);
-- 
2.43.0


