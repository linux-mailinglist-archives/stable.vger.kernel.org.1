Return-Path: <stable+bounces-200330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C14ABCACB95
	for <lists+stable@lfdr.de>; Mon, 08 Dec 2025 10:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AF6E306C662
	for <lists+stable@lfdr.de>; Mon,  8 Dec 2025 09:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7A03126D2;
	Mon,  8 Dec 2025 09:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="arPsEBnk"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726913126B0;
	Mon,  8 Dec 2025 09:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765186095; cv=none; b=jxvJ3ABKdx80EkQEotC5KrINRWGj3+3IVRcV+7ijgSC0SOhbS68YXan5OkSzsxTRnVl3nv6ljp1m5J8BswB9W1g1UDYa8dq+QANTCszjwiPcFwQMnRs3aiUd1IOGYD2IqrLLzOnk//9tfY1dtEQi3CiIZCt0zctGtxDOGnvhxBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765186095; c=relaxed/simple;
	bh=aoqKqQiEPNpyzezO+H0oPqMpr4QDKaHeBSakO0ljG5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lS6iTsMA48odmcuk4YAmzEoYDzYGUuJMzDddJEBvq6bS75xj83f35PHKVHPgsVbGbBMNYdmjHO+Qyt7cvSAzMaDg7I8tL4AEZisXWyTtGEDoPimig80CP99h32jOoKankOrehzKwwOFI6SNg1JTN8lRtIsDovZK9oCXLsbAaIPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=arPsEBnk; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=gs
	z9tNB9/8sHknbJBNmma0qTBrlJq/yDbnGrGXw2W+Q=; b=arPsEBnkKmJT/hgl8u
	oLLNOBnceIIE2iPo928alCW4B9j+qy43p5YK3BnwwY+g5/1GMWyEyd6JqX/r31a5
	jHchYHmnDABA+aHraAu4c9mSh/bcxLjEPQWGOxMT7LOkmozqyvVS1HBG349FJHIE
	B6GjvlEISZx33sHHyj9QFiagQ=
Received: from hello.company.local (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDntNsFmjZpP2eyHA--.46282S2;
	Mon, 08 Dec 2025 17:27:34 +0800 (CST)
From: Liang Jie <buaajxlj@163.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexandre Viard <xela@viard.dev>,
	Liang Jie <liangjie@lixiang.com>,
	fanggeng <fanggeng@lixiang.com>,
	Michael Straube <straube.linux@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: yangchen11@lixiang.com,
	stable@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: fix missing status update on sdio_alloc_irq() failure
Date: Mon,  8 Dec 2025 17:27:28 +0800
Message-Id: <20251208092730.262499-1-buaajxlj@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgDntNsFmjZpP2eyHA--.46282S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrKFWkJF1ruw1rCF4xCrWxWFg_yoW8JrWrpr
	Z5C390krZ8tFy7C3W2y3WkCFyrCa4xWry8Cryq9w15uFyvvFy3Xr1DG34Fqr48Jry8Aa1r
	tF9Yg3yFga1UCrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j2CJPUUUUU=
X-CM-SenderInfo: pexdtyx0omqiywtou0bp/1tbiNhIeIGk2jo-p3wAAsy

From: Liang Jie <liangjie@lixiang.com>

The return value of sdio_alloc_irq() was not stored in status.
If sdio_alloc_irq() fails after rtw_drv_register_netdev() succeeds,
status remains _SUCCESS and the error path skips resource cleanup,
while rtw_drv_init() still returns success.

Store the return value of sdio_alloc_irq() in status and reuse the
existing error handling which relies on status.

Cc: stable@vger.kernel.org
Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Reviewed-by: fanggeng <fanggeng@lixiang.com>
Signed-off-by: Liang Jie <liangjie@lixiang.com>
---
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index f3caaa857c86..139ace51486d 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -377,7 +377,8 @@ static int rtw_drv_init(
 	if (status != _SUCCESS)
 		goto free_if1;
 
-	if (sdio_alloc_irq(dvobj) != _SUCCESS)
+	status = sdio_alloc_irq(dvobj);
+	if (status != _SUCCESS)
 		goto free_if1;
 
 	status = _SUCCESS;
-- 
2.25.1


