Return-Path: <stable+bounces-135145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0284CA97048
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 17:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC038189DB3A
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 15:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9742853EE;
	Tue, 22 Apr 2025 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="CaAqrHqe"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F95BEEBB
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745335050; cv=none; b=jl7aAUw9j3e7UNqxZ3HNzdse44XKndKJWjAHZMG2q0JkdO0iRlVlKU46GVxOl9W11Ygq+vKGfWqmnh0bqjvofIUN9r00mM3Jks07nSOPtfeGARwyk2RpwJUcz56J9fzO23nntLi+aZZUq16kUbO2LbhkgZlB8VP62jhyNGvpkVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745335050; c=relaxed/simple;
	bh=6ht/7jPjqYk9NCa0HFeEcEKWrV5CDs/7zlL6zdbTdK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B5d2QaqCJ3i40Wystp2/CCQ+bUj2XwEipbTIC+21tbjve1aC8sdhOYd0b75iErhTZsVA2JovEEQgIsNE8wPJlL9ba249Ufq/f/K/xUzPaCA+nGTlnEteKyTg0E8+9LEN/iVMgugHn9aNwLOmijTdVUq6HyPjMv7tztlXRG+zaio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=CaAqrHqe; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2295d78b45cso84036155ad.0
        for <stable@vger.kernel.org>; Tue, 22 Apr 2025 08:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1745335048; x=1745939848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+XlgVU4t9hTiQMNifpIzD5yUeqaGj7eOwzYvUcvzWc=;
        b=CaAqrHqeKFgoItgcz+1cnTMwrDwmXGwyTDsWW3cK+UUEtIEPoG9acU+cRcv1vU9CdM
         KF/4Eihod9OB+trFJ8l9m04qnleJIXSVnxoCk0qxyXquUJ+xPuYBpI7yMuHzjCEcCQ1E
         l93MRCcDu2LF00h6EhUVedd+SiUwdXjQ6jEEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745335048; x=1745939848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O+XlgVU4t9hTiQMNifpIzD5yUeqaGj7eOwzYvUcvzWc=;
        b=pkpYaUQjWcEqN3OGT/Fx99qFqhyuTRrHwSq+fLqchPbGzfPTKT+Jx+1apXscDA2Ikp
         GgdFDEfpRCPPXGeR9oEkdLNSLdoBssPNzNPUyn0UrlyL6OlYI52QkJtVZIVW5L4iJxZK
         JyivzbzqCLTkIzc9Yj1swINoUh9niTke+pW7DrBptSe8wrW9BR2tTspUZoz70aiBtsSc
         PVr6UtNQp+4Q2d1S413r72r0+T14GcHKbXh0TexKT/nwJbqmobqcwDjNwmysTT6FPTqP
         ONWaFwTb4gDH89EyuQK6QHGhSUuD+N3RfNiAuDi2vjjFOwdOdpdUeasVFjl7uRZvI2Ch
         P3QA==
X-Gm-Message-State: AOJu0YwATwUxMA1i7Slv3cS1nF/dfNQB1o4A4vSRLBtkuK8zqq5H+23+
	ACakC2HC/vtQeb1GbA9/EMond8yNMzjUNDN3CjXzXEJKKn+ad0JdQ5Zhxw0YeuE33TmNi/h9KsX
	OAp68GA==
X-Gm-Gg: ASbGncsTWR+UwM59Rq7RX6x8wDQFiVffacuDg/sTglXOk2kUOgZ+OWI/wtsll/kQCII
	NcPmBdSAVRUtSOI7+rkd+y1S5i7wCEeQCj7nj0P1mwsfIqmmEuG/ZN0Zw0DDUrEsYH3+wudzYP1
	+T3NYen7gi1LIwSJj7DBgoKfN3+EgqQnrZWph+9XhywlLEM2GE3XQ6D3lKwvDB+YmPI4njyogB2
	qu6fcxyjP3M0cykHSruQxG0vCa2G9/29UeUeI6zcuNe93nb3yYZeK3cfysruacQdW88MUWOZhwC
	fA5Q6bnc0amBDFrVB9P2GbbprHrjMVxMc2feEnQtc17r+w==
X-Google-Smtp-Source: AGHT+IFXJ9oKukyuo3lwsVw+t+ZL6oZRqWayMnrRayk4vNxOoKL9Q73F8XdvzHVp+TY7a+09KAWaKA==
X-Received: by 2002:a17:903:1a6b:b0:223:f408:c3e2 with SMTP id d9443c01a7336-22c5357f39cmr243215945ad.14.1745335048319;
        Tue, 22 Apr 2025 08:17:28 -0700 (PDT)
Received: from testing.mvista.com ([182.74.28.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bdac14sm86563985ad.26.2025.04.22.08.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 08:17:28 -0700 (PDT)
From: Hardik Gohil <hgohil@mvista.com>
To: stable@vger.kernel.org
Cc: peter.ujfalusi@ti.com,
	vkoul@kernel.org,
	Kunwu Chan <chentao@kylinos.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3/3 v5.4.y] dmaengine: ti: edma: Add some null pointer checks to the edma_probe
Date: Tue, 22 Apr 2025 15:17:09 +0000
Message-Id: <20250422151709.26646-2-hgohil@mvista.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250422151709.26646-1-hgohil@mvista.com>
References: <2025042230-equation-mule-2f3d@gregkh>
 <20250422151709.26646-1-hgohil@mvista.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <chentao@kylinos.cn>

[ Upstream commit 6e2276203ac9ff10fc76917ec9813c660f627369 ]

devm_kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure. Ensure the allocation was successful
by checking the pointer validity.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Link: https://lore.kernel.org/r/20240118031929.192192-1-chentao@kylinos.cn
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/ti/edma.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index a1adc8d91fd8..69292d4a0c44 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2462,6 +2462,11 @@ static int edma_probe(struct platform_device *pdev)
 	if (irq > 0) {
 		irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_ccint",
 					  dev_name(dev));
+		if (!irq_name) {
+			ret = -ENOMEM;
+			goto err_disable_pm;
+		}
+
 		ret = devm_request_irq(dev, irq, dma_irq_handler, 0, irq_name,
 				       ecc);
 		if (ret) {
@@ -2478,6 +2483,11 @@ static int edma_probe(struct platform_device *pdev)
 	if (irq > 0) {
 		irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_ccerrint",
 					  dev_name(dev));
+		if (!irq_name) {
+			ret = -ENOMEM;
+			goto err_disable_pm;
+		}
+
 		ret = devm_request_irq(dev, irq, dma_ccerr_handler, 0, irq_name,
 				       ecc);
 		if (ret) {
-- 
2.25.1


