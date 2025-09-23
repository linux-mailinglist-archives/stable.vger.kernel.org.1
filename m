Return-Path: <stable+bounces-181447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB498B950DD
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 10:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 252A1176424
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 08:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC70931D362;
	Tue, 23 Sep 2025 08:44:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-m155115.qiye.163.com (mail-m155115.qiye.163.com [101.71.155.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967012EAB61;
	Tue, 23 Sep 2025 08:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758617055; cv=none; b=VOayQkGkxIncpV0ASv5VyaSpwfJZepso+VdBgjoTO2DUnWe0wb1q3Gz+Q0PZGp1wRxk81n0GqS4dIGEyUa73PJP3SnImzL0iV0pO9THKCMjtxCo1nhoSsfXna7vjLlpdBOJp5E/VBfO0VvgFNS2EqCPxELWGGsGc5K1fq9m5JqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758617055; c=relaxed/simple;
	bh=4mj6jOy0kC86zUWfpRH30od4C+M8eCeDVWnZV/Tz+kk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jo9CKr9klqnMWpvw/tYWxBpyHAnjAk+vboYcZniw+0Hb4SUqeIvwjZxNbf/W6q2Kgbkn/yyIIiEUq6fvfxo4fgZ4vSaDkOoUpaCwUHWy97h93wD819gSQcbaoFbuyJNh24l8D4lWUuCio3FNsW68EetP8ifAnueXg2/NB4Sv8sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=101.71.155.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 109f1fcda;
	Tue, 23 Sep 2025 16:38:58 +0800 (GMT+08:00)
From: Zhen Ni <zhen.ni@easystack.cn>
To: andersson@kernel.org,
	mathieu.poirier@linaro.org
Cc: linux-remoteproc@vger.kernel.org,
	Zhen Ni <zhen.ni@easystack.cn>,
	stable@vger.kernel.org
Subject: [PATCH] remoteproc: Fix potential null pointer dereference in pru_rproc_set_ctable()
Date: Tue, 23 Sep 2025 16:38:48 +0800
Message-Id: <20250923083848.1147347-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9975b9d95d0229kunm8693f78fdd34a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSh1OVkIZHktPGBofTUgdHVYVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0JKVUpLS1
	VLWQY+

pru_rproc_set_ctable() accessed rproc->priv before the IS_ERR_OR_NULL
check, which could lead to a null pointer dereference. Move the pru
assignment, ensuring we never dereference a NULL rproc pointer.

Fixes: 102853400321 ("remoteproc: pru: Add pru_rproc_set_ctable() function")
Cc: stable@vger.kernel.org
Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
 drivers/remoteproc/pru_rproc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
index 842e4b6cc5f9..5e3eb7b86a0e 100644
--- a/drivers/remoteproc/pru_rproc.c
+++ b/drivers/remoteproc/pru_rproc.c
@@ -340,7 +340,7 @@ EXPORT_SYMBOL_GPL(pru_rproc_put);
  */
 int pru_rproc_set_ctable(struct rproc *rproc, enum pru_ctable_idx c, u32 addr)
 {
-	struct pru_rproc *pru = rproc->priv;
+	struct pru_rproc *pru;
 	unsigned int reg;
 	u32 mask, set;
 	u16 idx;
@@ -352,6 +352,7 @@ int pru_rproc_set_ctable(struct rproc *rproc, enum pru_ctable_idx c, u32 addr)
 	if (!rproc->dev.parent || !is_pru_rproc(rproc->dev.parent))
 		return -ENODEV;
 
+	pru = rproc->priv;
 	/* pointer is 16 bit and index is 8-bit so mask out the rest */
 	idx_mask = (c >= PRU_C28) ? 0xFFFF : 0xFF;
 
-- 
2.20.1


