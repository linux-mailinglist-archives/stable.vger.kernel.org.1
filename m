Return-Path: <stable+bounces-136510-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAFEA9A0E1
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 08:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 788FD7A16D5
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 06:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02AD1B043E;
	Thu, 24 Apr 2025 06:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="WmBTBrIJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30842701B8
	for <stable@vger.kernel.org>; Thu, 24 Apr 2025 06:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745474871; cv=none; b=NiseMc8WH+8e4O8CLoxNAI0iG0+zI4keE66kp1muew2UDnnLtyIn+0USHZ626XQ+0GxhRwvnQhbBd2QU+ilXlki2+2eTnV7M55USD3iucTh0C86J2VIGNp6vqp8CdDqkie3NFXsWloFSak0AB1v8jq2MlJ8qabZkkFNNRPv984Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745474871; c=relaxed/simple;
	bh=WttjMgDZYbOd66AP+1dvOIKCUTgFDvPmt2NAkZfg4iY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ILSf+7RLO/P5HdKwJqXavMwsPOjJIXOlIMr2bx0I7n2phjXEp1OsQHy4XeUwaPJvGKJ1Q4BqIjhrAVL89DUennL6TgNg6WwH7xs8rRSPctV4IKjE1bWDYP4kDvAUVo1CgQGk77YDvaemeGxq5UYO/QAmYYQynOEHCl8r2uBoLoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=WmBTBrIJ; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-736ad42dfd6so493801b3a.3
        for <stable@vger.kernel.org>; Wed, 23 Apr 2025 23:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1745474869; x=1746079669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qfZc9Rw2ieXlpUTn1KhIaBFzgUnpbC6LiSdErPjvIu0=;
        b=WmBTBrIJZNmU7jay1pu9rj9WjzFd2FD6FsSgorI2jIpf65IQNNV7AKnbQ0/KtTu/cR
         HdYm07nJoVAkVqTAsxZapHjeciflBdBT/MwecSXcy1qwh33jfH1bhfBWBsjreBKib+pp
         4ZwM/0iqCavUlvuONk3XypUj7S7XbsLUIF+zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745474869; x=1746079669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qfZc9Rw2ieXlpUTn1KhIaBFzgUnpbC6LiSdErPjvIu0=;
        b=ATABfSrIbM0nrmUxh9Yc8L1i2ABYL6839oETk61i/ibXzL7oArPJjAE5lkKmZKoLX3
         r6P5fNYzU7TaVtfMPjtHzU62RE55eP0mCvPnk7QseIjuQ3CgP/xrE9WNkA1blO8cnb9y
         1RjWa5y5W2rzlg1iV/Nma1eWqkKBiiw0i4QPa1E7qb6Uv5nEsQTpWuHrHyL5mU/bMDxW
         3FXA0IdTr+U7Q9tlwzG96SAFBj3cd+aB3JrL3lU1X3wkKeXVVZ2JZ5UgXuu3iDvVxEoj
         ylQsZxCJDzVE75Jtf4QVA3OD8Z/2+tyH2WLBKNH714+VbIOTPkc/x228pbBA1+yU+XVk
         lPUQ==
X-Gm-Message-State: AOJu0YyQKM/SSXDc65vZbWIYe287LL5Llzfuy70FEfBvwGbhgBvleBBA
	H5yB1OsQ+VO2GVA4NZVOvrq6P4j4HMAKSFWD3f6D0zw5NNKGrEWxQPLad6RDkmVIh5+mUcVXQQY
	LJTp1CA==
X-Gm-Gg: ASbGncuI9KS2Tvqmt5/Jf1z+pwEyMfzWTrMwAK5FIcIIK+DN5PbbTbffAAMoBVDkXdK
	rUru+gJf0McnIQlHAD7Qj7LJHuHGHW8IwJZLhQQLR2qGkQHg/nxlBX6qxoRGbZKChf2oxMIQ9Q/
	lrG9RJ+4xw7INo81G7BXTom/vKVX7mLXFOAvkoWNf6SN/xWc1WDggHQV5GyxuzrTz/GnFlk/ks4
	AlZZ4MKNIEDV+eE8ZePdNHXWAloX/Gx5peM+v93pNJ7LV/p2ygJwAGoe42enYZeCUdooiD9wVBg
	ko/ow0LQBWOwrHgZh9wvjErx0+xKfJ4OcR2zwg9xhhfpXA==
X-Google-Smtp-Source: AGHT+IH0p2oVpmUOc8VMJh7qzHCr3LntbuzglZsrCkDf0l8eMTAmgLd2aiw72jYXhcR2/xU7aUzm1g==
X-Received: by 2002:a05:6a00:428e:b0:736:a8db:93bb with SMTP id d2e1a72fcca58-73e245ccca8mr1869633b3a.5.1745474868954;
        Wed, 23 Apr 2025 23:07:48 -0700 (PDT)
Received: from testing.mvista.com ([182.74.28.237])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25912bf3sm600512b3a.32.2025.04.23.23.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 23:07:48 -0700 (PDT)
From: Hardik Gohil <hgohil@mvista.com>
To: stable@vger.kernel.org
Cc: peter.ujfalusi@ti.com,
	vkoul@kernel.org,
	Kunwu Chan <chentao@kylinos.cn>,
	Sasha Levin <sashal@kernel.org>,
	Hardik Gohil <hgohil@mvista.com>
Subject: [PATCH 3/3 v5.4.y] dmaengine: ti: edma: Add some null pointer checks to the edma_probe
Date: Thu, 24 Apr 2025 06:06:34 +0000
Message-Id: <20250424060634.50722-2-hgohil@mvista.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250424060634.50722-1-hgohil@mvista.com>
References: <2025042315-tamer-gaffe-8de0@gregkh>
 <20250424060634.50722-1-hgohil@mvista.com>
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
Signed-off-by: Hardik Gohil <hgohil@mvista.com>
---
 drivers/dma/ti/edma.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 4fea8688b596..625f04cbbcd4 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2390,6 +2390,11 @@ static int edma_probe(struct platform_device *pdev)
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
@@ -2406,6 +2411,11 @@ static int edma_probe(struct platform_device *pdev)
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


