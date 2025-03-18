Return-Path: <stable+bounces-124758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B4BA66695
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 03:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0BF73BA80B
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 02:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C5918FDD2;
	Tue, 18 Mar 2025 02:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MoSynisg"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5B818A959;
	Tue, 18 Mar 2025 02:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742266737; cv=none; b=j3zixCxcXlDzGDdm48SHZrxTgtBjDv+wqc4lezyxxPiUyvnsD6wbfIScAKMBn471ND0lM2iA0vZrouOECRf9X7d8FoL8Q7xmnPndo7ZvY4nvoXX/7lpHX5Lu+W4fQqEYQ9NXcLLVGizjS59KHfg9h7KD2qe20JcalIFn+yVCgQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742266737; c=relaxed/simple;
	bh=1++UtJ/x4fYcljqobaSvICMiESEAey2qNTq0v65tYIA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uyqe3rM8JfjRatAzAOGjXER4XWHGOIsuJ+1pwBvIfz8diDhxVmXrUpJbc2xN7dcBSpf6nrPbO28f35oMUy4j6hg2UCJNvqiE+XeGQJbauKiYNeaQKlyAQvOB0jCeHjn/1b4KECaavJqxL5oa8vGzl4pHefnBHHc9B0TEsijbOxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MoSynisg; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=xip++
	Y+wP8cdm9eHLHgn2+Hxo2dOyBCVc1sz06DsCjw=; b=MoSynisgKDhxtQDPgi0N4
	6xCc6CxSrxkk2oZW3Z156rNWkqt2R0tPMc5SbcpNjY75X4Ti5TdR5ltKmOXTibob
	8Amvr2uVfneRcuFpOI9Fg92RBlzZdK0BzW19nret4oMuDz/R6Vm34QKMlHIrIz+S
	R8cbo1rATD0yOFApy9UKOc=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgCnb3td4dhn4C1QAA--.21105S4;
	Tue, 18 Mar 2025 10:58:38 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: linux@dominikbrodowski.net,
	haoxiang_li2024@163.com
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH RESEND] pcmcia: fix a potential null pointer dereference in __iodyn_find_io_region()
Date: Tue, 18 Mar 2025 10:58:36 +0800
Message-Id: <20250318025836.1569313-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgCnb3td4dhn4C1QAA--.21105S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr4xKr1rur45Jr45Zw17trb_yoW3AFc_ur
	10gryxGrWUtr4Ikw13trsavrySvrn5Wr1kuFn5t3Z3ur9F9w4SqFnxAr98W34xJryfAF1k
	AryDJrnrCasxWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_Yii3UUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/1tbiqAETbmfX849cAgABsH

Add check for the return value of pcmcia_make_resource()
to prevent null pointer dereference.

Fixes: 49b1153adfe1 ("pcmcia: move all pcmcia_resource_ops providers into one module")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/pcmcia/rsrc_iodyn.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pcmcia/rsrc_iodyn.c b/drivers/pcmcia/rsrc_iodyn.c
index b04b16496b0c..2677b577c1f8 100644
--- a/drivers/pcmcia/rsrc_iodyn.c
+++ b/drivers/pcmcia/rsrc_iodyn.c
@@ -62,6 +62,9 @@ static struct resource *__iodyn_find_io_region(struct pcmcia_socket *s,
 	unsigned long min = base;
 	int ret;
 
+	if (!res)
+		return NULL;
+
 	data.mask = align - 1;
 	data.offset = base & data.mask;
 
-- 
2.25.1


