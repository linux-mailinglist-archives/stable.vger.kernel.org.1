Return-Path: <stable+bounces-180557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4582B85EAF
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 18:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DDE27B307D
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 16:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8AB30E848;
	Thu, 18 Sep 2025 16:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J21xbqK5"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04491306D36
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 16:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758211952; cv=none; b=SAjmMi3t68HwxHJi5t/bhbqeDrQvazPBAF+Ttu/uiyai/R4SWg+lyrEZVLBx93RgoBW3JbpjEA51/0hIckXuNZjHZ7Sn4F5EgqGLqzVN5k2y08yk/2AdSRHesYu7Cy3NLi1zoT3d3iPbN4t0CRjFgrWT4THepf9yMO/ZuHbDZsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758211952; c=relaxed/simple;
	bh=9NHi/2Cce6YtYupIQCjuGL2CK/BqjDprlX3JyUrBZ4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=euS2+nfiCLyYqL9UiU6r913x8JpYgbyf3p0fw3L74s7rg9rwVMicTwgc+rfh9AsyAZLY5PYwuHn0NiZV6abvkqx16JWfruGjPN1yCFuImwKq71daQZ60swcu1T6W/CONTPCIvPPLsKMw0SHC/e7xfcJtI5QRkJD/T/KfGq25Sb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J21xbqK5; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-545e265e2d0so779313e0c.1
        for <stable@vger.kernel.org>; Thu, 18 Sep 2025 09:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758211950; x=1758816750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Sc26hxDTkdtCvz76lZc7JwNfgd5ybo+08CIFSOrjwg=;
        b=J21xbqK5jMhq4hwH0aeiH3Bb53TPRP4taFoXVXuqspbMTUNt5WVf5MLq+dVXAJfkGR
         qHxDRKZhL9gehS3ICvduHkIqDGj43alcW+xQyU3Q73HONIG9jmF4+XAlQomXG/FnXPeG
         mm8npmrvnJa7fdnUjhqY++8/5e5PGeZMvylUHVfCLfuR1pF7T/36wMMnGyHxAbmImWw6
         hiC9df6QI+7r4lSF/30t+E7BSE3c5LMd0xq3OzDt7QHl71cN1CktFJ/oDF2pAcWrULaN
         NbWBKONWDPZFaS+538GLPia81QcY54pMV7bkn/Pb355YQ9/t6WiUvbSIN6HWfrKltX2R
         0Ddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758211950; x=1758816750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Sc26hxDTkdtCvz76lZc7JwNfgd5ybo+08CIFSOrjwg=;
        b=TzBxVgB8F/JqdQhXuqtC/BQBBsD+Fww+vNON/C7qlaY24e5wbKDlZQnn9v+1rVra8B
         GY3dOMgb+SENwZSbXAlA2BVIwEuwjeuUIns/7lBTCmGvYQlOVYbdW17w5xKHo2Vmqw9E
         cSuJvDs/4aHGxM+pbkHAxSOxJcWjaFw36mUdcxNVRa7dqcMgsozVpaLqgidGVrIDInTt
         nIH1KZuZDaLQOyBsDKR0QRVUUF73q4v4LnVx+ZZk+yoBWa12o1CD45eAkL6dLOj4PP+C
         wHEgnv3WMCmHkdBvnlkW1LMJlxkoJAlF1M53RYp+bVFdvZ6Yg5C2sD1qUhtyh2iHHoE2
         zaLw==
X-Gm-Message-State: AOJu0Yw6LXWg3YOUnrrYdgDkB5jaNHIxLFtUzMagVXTHq26iIsRR8Y24
	xDa4TSVnmiCnmobF7PGmyfIRGEkxxtOR7e9X74nbEbpe1j565HXy6VW+SgBBKOF6qro=
X-Gm-Gg: ASbGncuf9BDMwCuEpSUnehk4zBADJkWM7ozrBY8lm+jIuxWUMZ4cRXErg2m2NGU9dNd
	JhffXc1MwEvCR047cDGHpB5STIMRi4Hu+fruy332iY06hFf/ESSoR8xSsmPBxOBlX+/YDK1IY62
	h5KwcaU3oRDXCcqPTBKoNEJZSnLQLZisN7wm562flFL1M+gZ38yFX1qgqpH/UW3issi4qSXszzh
	IKB4RQrroT+7uQxF1wmzvZLzUCw2tVuQEwdwNsihFizK9khvz+F2PWiWmfd5RwsUse8mQIbpbAd
	rhrMLuTfL9ldRoNgsWZfcnBuaEVzrydOQ6RBd++uTkA8uxk1A5V2Z7wwdbqe6+eWSqN9sUkKqFu
	iaLMexb8iVaMZ98nIZVAWtzTBNdy0ksjNPTnWjDggJw==
X-Google-Smtp-Source: AGHT+IF9suJfr/TckXhc3x4V/Ham0gaboRPTGKUywBt8FfSoHGxa1LjxFJVx6FIwVN06VaKFltF9Bg==
X-Received: by 2002:aa7:888e:0:b0:772:499e:99c4 with SMTP id d2e1a72fcca58-77bf926881fmr9331092b3a.18.1758204996072;
        Thu, 18 Sep 2025 07:16:36 -0700 (PDT)
Received: from lgs.. ([2408:8417:e00:1e5d:70da:6ea2:4e14:821e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cff321237sm2490376b3a.102.2025.09.18.07.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 07:16:35 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Santosh Sivaraj <santosh@fossix.org>,
	nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] nvdimm: ndtest: Add check for devm_kcalloc() allocations in ndtest_probe()
Date: Thu, 18 Sep 2025 22:16:06 +0800
Message-ID: <20250918141606.3589435-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_kcalloc() may fail. ndtest_probe() allocates three DMA address
arrays (dcr_dma, label_dma, dimm_dma) and later unconditionally uses
them in ndtest_nvdimm_init(), which can lead to a NULL pointer
dereference on allocation failure.

Add NULL checks for all three allocations and return -ENOMEM if any
allocation fails.

Fixes: 9399ab61ad82 ("ndtest: Add dimms to the two buses")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 tools/testing/nvdimm/test/ndtest.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/nvdimm/test/ndtest.c b/tools/testing/nvdimm/test/ndtest.c
index 68a064ce598c..516f304bb0b9 100644
--- a/tools/testing/nvdimm/test/ndtest.c
+++ b/tools/testing/nvdimm/test/ndtest.c
@@ -855,6 +855,11 @@ static int ndtest_probe(struct platform_device *pdev)
 	p->dimm_dma = devm_kcalloc(&p->pdev.dev, NUM_DCR,
 				  sizeof(dma_addr_t), GFP_KERNEL);
 
+	if (!p->dcr_dma || !p->label_dma || !p->dimm_dma) {
+		pr_err("%s: failed to allocate DMA address arrays\n", __func__);
+		return -ENOMEM;
+	}
+
 	rc = ndtest_nvdimm_init(p);
 	if (rc)
 		goto err;
-- 
2.43.0


