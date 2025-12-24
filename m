Return-Path: <stable+bounces-203364-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B7DCDBD11
	for <lists+stable@lfdr.de>; Wed, 24 Dec 2025 10:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2BD03016CF4
	for <lists+stable@lfdr.de>; Wed, 24 Dec 2025 09:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BB7332ED3;
	Wed, 24 Dec 2025 09:38:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B45630E0CE;
	Wed, 24 Dec 2025 09:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766569137; cv=none; b=NYpqQaAEdMwdbq9fLzg4SRn6AV1WTW9fh5Zr/BVXmD6Sr+byHIhaBwhO83e8k5uFXAtF/He0I7cWF2EzntPwONhohCMBwJ6A4u1MwPzY4XpAWLkYPHXZspm2abUzHkIcNIcKxb1bxU8YpbtagnZEjb7evSic8tOj++W13wjgzuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766569137; c=relaxed/simple;
	bh=C5wzQhoy2QIsfMc4wnniP+p1geEoUa39/BumWfgm+s0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k064kawcgaBxIP02NOH28TK4u1Foz6M60NRxzve3iOmH9vC9SIMEraL1DmD9kypoyZk2zJ/fH2YNOelxM1LFkjqbSpjtv939bm3R0MKSbTabXTgITHwfpg26E4oZC7MItI+8L/1utpwafF/KQIbnYxsbvJ/GudhdGZHgYBLIufI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.209])
	by APP-03 (Coremail) with SMTP id rQCowADnANimtEtpJw_SAQ--.6418S2;
	Wed, 24 Dec 2025 17:38:46 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: pawell@cadence.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] usb: cdns2: fix a null pointer dereference in cdns2_gadget_ep_queue()
Date: Wed, 24 Dec 2025 17:38:45 +0800
Message-Id: <20251224093845.1578894-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowADnANimtEtpJw_SAQ--.6418S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtrW5XF1fur4rXrW7uw4UArb_yoWDJFgEkr
	4j939rCrW5Wwn0yw48Aw13uryjg3WxX3WkWF4DtF15A3yqgw1fAry5Xr95CF17ur4UGF1v
	y3s5t3ZxCFn8WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb48FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbhvttUUUU
	U==
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiBwoGE2lLmnBeDwAAsB

If cdns2_gadget_ep_alloc_request() fails, a null pointer dereference
occurs. Add a check to prevent it.

Fixes: 3eb1f1efe204 ("usb: cdns2: Add main part of Cadence USBHS driver")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
---
 drivers/usb/gadget/udc/cdns2/cdns2-gadget.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/udc/cdns2/cdns2-gadget.c b/drivers/usb/gadget/udc/cdns2/cdns2-gadget.c
index 9b53daf76583..c5b9dae743d8 100644
--- a/drivers/usb/gadget/udc/cdns2/cdns2-gadget.c
+++ b/drivers/usb/gadget/udc/cdns2/cdns2-gadget.c
@@ -1725,6 +1725,8 @@ static int cdns2_gadget_ep_queue(struct usb_ep *ep, struct usb_request *request,
 		struct cdns2_request *preq;
 
 		zlp_request = cdns2_gadget_ep_alloc_request(ep, GFP_ATOMIC);
+		if (!zlp_request)
+			return -ENOMEM;
 		zlp_request->buf = pdev->zlp_buf;
 		zlp_request->length = 0;
 
-- 
2.25.1


