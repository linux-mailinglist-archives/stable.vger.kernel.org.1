Return-Path: <stable+bounces-179628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E71B57E00
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 15:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94F611638E2
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 13:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A215D1F4C98;
	Mon, 15 Sep 2025 13:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MIlBTByE"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9823E15E5DC;
	Mon, 15 Sep 2025 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757944344; cv=none; b=LefkEkZHXztCaR8F7NI9faEUEsX66DoFtTYgpAnnpLYZUBx5FgbX0DTpFlMZt6PStvdOv3Fh7am2fmem8PMvq7OEtRP/k7Bne2b1uHZOekCoW1VE2jOR966l+XeRWSMa7cszz0pffkM4yNFW8EVn03PKaUt7Sho/aVWVicRoJmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757944344; c=relaxed/simple;
	bh=A9wGSKQWTgVbN5PUpTVVIy4I5HQdmYev8rnlZghLy5o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CIbh2N7IXDIBbDdFTJwLLpWQA8fn7WkZb1FuIo4VKz/NUZwnqqRNofAMooIxwtwOxbMEp3kuCSWEeliKjpLAOknCi1Une4i9Pe3Lr2g/3MGi6yRcTDhN1a7VuXqRCWQ2cthUWD35Xu4b6zFa0LRnwY3tVcM759IcMDeYXD40S7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MIlBTByE; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ZS
	1DV7iVPnHgFJniBg8Hr6Bv03+t0XpK4+IrR9aoPl8=; b=MIlBTByEzo3mFlLI9R
	kdOKHE8aRwZ24MN0DQeWCL0HvPi2x61oJKW7sf/hMxiCRb13w85KRmfGKXNuk0Tj
	sumGuyutmsiRmGrmUxIAWpKGsMzP7VJwWHw6PCBngnWBx/+ok6qqLADJsOUnLGog
	QMHcaHFXgmsdu20KvKwgU57/Y=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3N_cDGshoSmy2BQ--.63017S4;
	Mon, 15 Sep 2025 21:52:03 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	haoxiang_li2024@163.com
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] sparc: Fix a reference leak in central_build_irq()
Date: Mon, 15 Sep 2025 21:52:01 +0800
Message-Id: <20250915135201.187119-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3N_cDGshoSmy2BQ--.63017S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw4fWryktF13KryfAry7Jrb_yoWDCrX_uF
	1fA3Z3Wr4rGw4IvFy7C3y3ZF13A3ZFqFW5W34vqrZ5CFy5Xr4UXrs3XFZ5Jrs8urW3urn8
	u3ZrWws5Kr129jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRAAwIUUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbBEAbJbmjIEI1b9wABsh

Call put_device() once central_op is no longer needed, preventing
a reference leak.

Fixes: 5fce09c6f636 ("sparc: Move irq_trans_init() and support code into seperate file.")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 arch/sparc/kernel/prom_irqtrans.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sparc/kernel/prom_irqtrans.c b/arch/sparc/kernel/prom_irqtrans.c
index 5752bfd73ac0..4cfc27131caa 100644
--- a/arch/sparc/kernel/prom_irqtrans.c
+++ b/arch/sparc/kernel/prom_irqtrans.c
@@ -733,6 +733,7 @@ static unsigned int central_build_irq(struct device_node *dp,
 	} else if (of_node_name_eq(dp, "clock-board")) {
 		res = &central_op->resource[3];
 	} else {
+		put_device(&central_op->dev);
 		return ino;
 	}
 
@@ -747,6 +748,7 @@ static unsigned int central_build_irq(struct device_node *dp,
 	tmp &= ~0x80000000;
 	upa_writel(tmp, imap);
 
+	put_device(&central_op->dev);
 	return build_irq(0, iclr, imap);
 }
 
-- 
2.25.1


