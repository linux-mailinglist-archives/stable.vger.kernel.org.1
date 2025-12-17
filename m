Return-Path: <stable+bounces-202780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D61CC6C4E
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 10:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A04E6304DE82
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 09:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EEC33554F;
	Wed, 17 Dec 2025 09:16:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0B127AC5C;
	Wed, 17 Dec 2025 09:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765962968; cv=none; b=SirTQCzuC91SH0HjQ7hHYcg+UpeRdMtd3swTycYFrVvaWHM0yZTnJd4/4K0ZulfbbS2Eo6Eo33pDPn++Ggn7T56YE9AOQ9JiQwxJ/KH4Lf25ThU6uM5dHDFxXg1KDtiN4oVRudSUetXlug0/SYd04+ffg1p1WphFIBIoerZF28s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765962968; c=relaxed/simple;
	bh=6DzFipEzWj4y0T/wSMWEFVVnrsWvqWUeNnKm3Cx5Ooo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KPvzUk3AA3tZTGvkTBvLbXfhEIT6wf20UjY6BWE9bLBiFGdozjS+0Wc58khyC8JpVyQMGxjzP6jq7DTySCWHqrruNxhC/f1wdmS2kAHt+QC1RHG4ODC7uw2OrGl6RWiULaEp9eqj8EeUwvH5sn9mTbVGKP3izly9pIjmgkQp3/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.223])
	by APP-01 (Coremail) with SMTP id qwCowADHbmrFdEJpPd7mAA--.15846S2;
	Wed, 17 Dec 2025 17:15:50 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: mporter@kernel.crashing.org,
	alex.bou9@gmail.com,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] rapidio: replace rio_free_net() with kfree() in rio_scan_alloc_net()
Date: Wed, 17 Dec 2025 17:15:48 +0800
Message-Id: <20251217091548.482358-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADHbmrFdEJpPd7mAA--.15846S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JFWkGrWfZr4Uur4rCryxuFg_yoW3Krg_WF
	18Xrs7Ars0yF40kw45uw4SvFWF9r48XrWkuFW5t39xtFy3Zw1FkF4qgrs8Z34xXr4kJrn3
	A34qqr1kCr47CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbcAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_
	Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUehL0UUUUU
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiCRETE2lCRwmvhQAAsX

When idtab allocation fails, net is not registered with rio_add_net()
yet, so kfree(net) is sufficient to release the memory.

Fixes: e6b585ca6e81 ("rapidio: move net allocation into core code")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
---
 drivers/rapidio/rio-scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rapidio/rio-scan.c b/drivers/rapidio/rio-scan.c
index c12941f71e2c..03615eb2d3d7 100644
--- a/drivers/rapidio/rio-scan.c
+++ b/drivers/rapidio/rio-scan.c
@@ -854,7 +854,7 @@ static struct rio_net *rio_scan_alloc_net(struct rio_mport *mport,
 
 		if (idtab == NULL) {
 			pr_err("RIO: failed to allocate destID table\n");
-			rio_free_net(net);
+			kfree(net);
 			net = NULL;
 		} else {
 			net->enum_data = idtab;
-- 
2.25.1


