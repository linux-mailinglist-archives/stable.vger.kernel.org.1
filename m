Return-Path: <stable+bounces-181467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 983EBB95ACC
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 13:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F1D0447601
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 11:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC67A321282;
	Tue, 23 Sep 2025 11:36:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-m3288.qiye.163.com (mail-m3288.qiye.163.com [220.197.32.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23571B4231;
	Tue, 23 Sep 2025 11:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758627409; cv=none; b=UuzOHi3Fk0xqhiBlO+hoBLR8CnsuztrRyipcDQxeozgOngI9EuH12DIsJSFB1jW9oBCRJgeVm2hOOAVeRGXEUbo4yEFpWOFQJyJYF/CUTqcUXrUrwBzEQtAsh5co/H+2qvXIgom1WyycxizZgf6DSad3ZrZFSoY0pZeM3oOvC/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758627409; c=relaxed/simple;
	bh=nffp39x/M7Ks1yMwtuJB7i6A9V8frjNYTRLBRUbDvqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F439MEOtChoKWNXjXxvXbJHxxMHgY7mRqiI5TwKVne6ShIGP6+GVI8Noz9Ct62NU1rN4B2Z+o3gWDhKVryHMGtZP7S0jlhtBVc0KkDOaK55MTsb2xk/jJ+Ex8nEUkWKl8VFHg6YmhqpWF87AQH2u7bD7h0Af21x0fhYK5d5/ZK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=220.197.32.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 10a123ea3;
	Tue, 23 Sep 2025 19:21:22 +0800 (GMT+08:00)
From: Zhen Ni <zhen.ni@easystack.cn>
To: andersson@kernel.org,
	mathieu.poirier@linaro.org
Cc: linux-remoteproc@vger.kernel.org,
	Zhen Ni <zhen.ni@easystack.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] remoteproc: pru: Fix potential NULL pointer dereference in pru_rproc_set_ctable()
Date: Tue, 23 Sep 2025 19:21:09 +0800
Message-Id: <20250923112109.1165126-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250923083848.1147347-1-zhen.ni@easystack.cn>
References: <20250923083848.1147347-1-zhen.ni@easystack.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a99764e8a850229kunm03720d87fe104
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSkNJVhoeHxpMSk9MGBoeH1YVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0JKVUpLS1
	VLWQY+

pru_rproc_set_ctable() accessed rproc->priv before the IS_ERR_OR_NULL
check, which could lead to a null pointer dereference. Move the pru
assignment, ensuring we never dereference a NULL rproc pointer.

Fixes: 102853400321 ("remoteproc: pru: Add pru_rproc_set_ctable() function")
Cc: stable@vger.kernel.org
Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
v2:
- Changed "null" to "NULL"
- Added " pru:" prefix
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


