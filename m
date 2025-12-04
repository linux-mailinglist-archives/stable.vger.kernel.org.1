Return-Path: <stable+bounces-199990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42395CA3326
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 11:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A24D303AEBF
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 10:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BF533B97D;
	Thu,  4 Dec 2025 10:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CK7uQmx7"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC3533BBAC;
	Thu,  4 Dec 2025 10:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764843706; cv=none; b=H9/XGrHk3GlY7hRYvJA64P2z/sH8BtFepOdUKBO7rcH6+8VBuT2DVIvumH1vq6gkbPMKBEpK8DDGRR8HEWqnxmFtN/Uh2lf/NhOFDaMjNzplR8VTmeZNwQV6YpCtlpzeL2N1SnjGTgk7LhnEbTgiGBiwglvDVSYuYkwecuoNG7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764843706; c=relaxed/simple;
	bh=sucnQt2jT43ByAJx+Qi2HrPDbpEPn3zqa3a+eQbWNiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mvWHK/vYDZsHXeTTwKACitE2CRQeyD6SIq7UF3a9kAa5UMAJxRoxCb7sNrO6c1bryBcWlIVME4I36azOBKul1DCSoeNKmvk8BhPMfPm5Y5eZZ/soiuI4hfdpKxBHmfUz1b8+VuuRbtzQRl8zF8yRqiRuNLF3doADOD6DA8Rn54s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CK7uQmx7; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=oO
	bGAmjdi3JvAty33o5ujX20oFjqkuDLoWzF8n+fhio=; b=CK7uQmx7goPzoD/MiE
	tDBXU7gEFOEACEFRZYgWqstqOaA2sLL0iRnpVLxSirNbIjCB22s8YR+g0qhHqM7E
	EBj1J8GFfsde7zG9lf1Qfu+q19ANLxGJKxs5lNT46Y5UT3Drg/SXj1iLUxbsUfyh
	eF8cQXHX0bMhLV/4KJV6x9dls=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wAXcVyBYDFph89sEg--.16629S4;
	Thu, 04 Dec 2025 18:20:50 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	haoxiang_li2024@163.com,
	kay.sievers@vrfy.org,
	gregkh@suse.de
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] powerpc: cell: Fix a reference leak bug in create_spu()
Date: Thu,  4 Dec 2025 18:20:47 +0800
Message-Id: <20251204102047.85545-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXcVyBYDFph89sEg--.16629S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7JrWDAr43GFyruFWfZFW3trb_yoWDGwc_Kw
	1xu3WDWr48Grs2vrnIya4fXr1UAws2gr48Kw4Iqa17Jay5Xan0gr4fZFW3GF13Wa1Ikrsx
	JF4kGF9rAa4S9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRMxR67UUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbCxgLeTWkxYIJyvAAA3j

spu_create_dev() calls device_register(), if it fails, put_device()
is required to drop the device reference.

Fixes: 8a25a2fd126c ("cpu: convert 'cpu' and 'machinecheck' sysdev_class to a regular subsystem")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 arch/powerpc/platforms/cell/spu_base.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/spu_base.c b/arch/powerpc/platforms/cell/spu_base.c
index 2c07387201d0..18145142d3ac 100644
--- a/arch/powerpc/platforms/cell/spu_base.c
+++ b/arch/powerpc/platforms/cell/spu_base.c
@@ -581,8 +581,10 @@ static int __init create_spu(void *data)
 		goto out_destroy;
 
 	ret = spu_create_dev(spu);
-	if (ret)
+	if (ret) {
+		put_device(&spu->dev);
 		goto out_free_irqs;
+	}
 
 	mutex_lock(&cbe_spu_info[spu->node].list_mutex);
 	list_add(&spu->cbe_list, &cbe_spu_info[spu->node].spus);
-- 
2.25.1


