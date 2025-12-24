Return-Path: <stable+bounces-203363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EC7CDBCD2
	for <lists+stable@lfdr.de>; Wed, 24 Dec 2025 10:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4027930181AE
	for <lists+stable@lfdr.de>; Wed, 24 Dec 2025 09:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D015332F740;
	Wed, 24 Dec 2025 09:29:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B16121FF5F;
	Wed, 24 Dec 2025 09:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766568597; cv=none; b=nwjB/HPJx118u6ksNDKZH/cMebTY/KpMlgoBehv8ETHFt0dqW83hGkslslWE/z3WGahJ+2B6uh+lH8mxFVURlsGY4XYrmPZ7qIzqX+dhEGGsFUNdFbb1Z4f+MnC2/kkE7FmZo0CkgdusXIoMLpLDtEBsBRrVsKAdykSiCPCZSR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766568597; c=relaxed/simple;
	bh=TBZ9ucNnudTFC+zBXs8zp7F8yi2VaSJP7qncIjt0p0I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z9lBBlbGnZDBvtO3TqoB1SGn0yzpZKutqFRK5V2m/MU/+JdSOuPhY+0e3unRmEWtP+BmUapGxTgqzeB9+AgDUs0eN5BWh1bhzkS4Axz70533eptoQx7ZKhtiawPcq7doAh3BpSO4cX998FbNojxaHMC3xG/Id9ADiDq2686zKKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.209])
	by APP-03 (Coremail) with SMTP id rQCowAB3lt2AsktpnNTRAQ--.3493S2;
	Wed, 24 Dec 2025 17:29:36 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: peter.chen@kernel.org,
	pawell@cadence.com,
	rogerq@kernel.org,
	gregkh@linuxfoundation.org,
	felipe.balbi@linux.intel.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] usb: cdns3: fix a null pointer dereference in cdns3_gadget_ep_queue()
Date: Wed, 24 Dec 2025 17:29:35 +0800
Message-Id: <20251224092935.1574571-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAB3lt2AsktpnNTRAQ--.3493S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr4UArW5Xr17urykuryDJrb_yoWfKrXEkw
	40939rGrWYq3s5Cw4UG343Cr1jkFnIv3WkWanrtFy3Ca4UKr4kAry5Xrs5CF17Za1UGr1k
	J3WrKanxCFsxWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb48FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_
	Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q
	6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUU
	U==
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiDAUGE2lLmjpYOwAAs9

If cdns3_gadget_ep_alloc_request() fails, a null pointer dereference
occurs. Add a check to prevent it.

Found by code review and compiled on ubuntu 20.04.

Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
---
 drivers/usb/cdns3/cdns3-gadget.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 168707213ed9..cc2421a34588 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -2659,6 +2659,8 @@ static int cdns3_gadget_ep_queue(struct usb_ep *ep, struct usb_request *request,
 		struct cdns3_request *priv_req;
 
 		zlp_request = cdns3_gadget_ep_alloc_request(ep, GFP_ATOMIC);
+		if (!zlp_request)
+			return -ENOMEM;
 		zlp_request->buf = priv_dev->zlp_buf;
 		zlp_request->length = 0;
 
-- 
2.25.1


