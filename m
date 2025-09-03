Return-Path: <stable+bounces-177565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5E9B413B1
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 06:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC51F1B26E6C
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 04:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C8C2D481F;
	Wed,  3 Sep 2025 04:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOCEQaR1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DD02D4813;
	Wed,  3 Sep 2025 04:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875170; cv=none; b=uY8dBf2Jslq6/7oMRCRzu0yHrdqqvlUVa+6CMUbjcyyGP9Xd+GBa91ZkLyEgEOxDf2T2RVh0cEEGyIKhzcrz9v2wRys2ecoY4o8JS4jWBMw2OXFUm2kv2uI3KHy8hBalGVQOnmepsIRvPqRLDleM9nA83cnzTzLZW2W9Y2kiXXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875170; c=relaxed/simple;
	bh=KyAtw1ROkQzmskX697stOWX20DsHTRWeC52X8SmVBqs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VTjsO1WTDUpIayHxbEdsllqnkn7HVpNvqlRgry3TyoGFS1YzcERaCmHY7helbYaiXTTKJTQl0N7IqOnhqT0AwBIkgzpgMDefwIjgwfzwVFhBKHnzidtHNIeAStsyPykdLIeVB/1W0c707emgN+2us5D2MpViO15J1WVdjelFap8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOCEQaR1; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b49cf21320aso6558609a12.1;
        Tue, 02 Sep 2025 21:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756875168; x=1757479968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7R3UA6dJinJ0I/6N9AH4Q+v9BW5iCYGVoJtMMc/Y28=;
        b=cOCEQaR1NYJ1es1otQDAm5E4s6zSRbFd3BRNINSWJne7RTWm7ZnNnvsoboDk5ox0+G
         UjwnwB6G8W8WiYFB/YySla9kZm7Uyesz88uLQhDAXw80Qwc8T5JvkJBkt6BOAJTzzeTQ
         KPICARgW7Qa0WnTHqevdz+ZxpCO44LfU4ljr0uuw+81yMss9N/2dnNT3Uz/oi85D43kW
         g4KgzVDv8XAkw/BlDDqrMxsrU6d1Brv28g+5mf4NObwQS7hTfKcKQKHXyFjl9WOkivFe
         lTv/+ImZAwDEt5CMwi/8pGBltc+DCipMEBTw5OmNbxUpbeVHPP4tJi+MES85gu3lgmvi
         G2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756875168; x=1757479968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q7R3UA6dJinJ0I/6N9AH4Q+v9BW5iCYGVoJtMMc/Y28=;
        b=WUmT2/lX0dUg3tQQ1zkM0onfT9eyDRUTh5FSrmNIFrJ2Kh5adKG8/2QwhWEeLH1tPg
         bmoV6UUrZ41Zv8MwJX0FIyK4V9sn5w6TB+LSzPMl2gqTIUbsEO7CEq1K23hC5w3QVEe+
         dNrribcoSLu9/rRSXFHEK+eFnWd4drmGQRdsLcwOb5x1R87Qo1S1ZXbLHslTrKsxKQf7
         KpPnHVM4KGcM8BZU3fY90wJTMaSRQ2to3CxLVxHurx5lA4/7sQQVkkPoHIYvoV3vF1C4
         oESfU4GJTeKLWbQrT99WVbzPCbpnn0ro3iDsveKl5gkSiLBTFQOPDfxvzdfsIJCXhzbh
         TFDg==
X-Forwarded-Encrypted: i=1; AJvYcCUeG1Tws8zxvt54BkUqwmeppWyKvSfVdQDN9wUUrAl/JX+TRbvNZRs0CQw4Ahgd3hpXKsydmhzpSn7b5So=@vger.kernel.org, AJvYcCVEUnCeBYYG5TyLFBbaZ45vgy0rZwOjmBUXMO9MQ5zcL4sOttnvlweEkxhW2l8/rQTj162fAty+@vger.kernel.org, AJvYcCXW1lqFrI/6fswX7uoSGFgO/G6CIGFV3m/bEgc+z6sr7ZnZBddixQSVjo+OsSk/sPTiXHcyemU2Mn/nBpU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8n+fgUCs1r/KLa6ErjQeCQFcpECbxo/hKLc51aTjsaoToHmdA
	OmlqmLn2+NGK6A4qWeZ0V4YvTcv6sgXp5aQ/v9OYCs/rw2Lo8m8tzSx3
X-Gm-Gg: ASbGnctRx5NEcNujZngH3a86D/oH+ibgT/58bCbr6Plinr8xgVJ3VhMgDSwj0K38VKN
	ul9IHgNSas2vRgdZgi1NMGB9GwhKW5wqZxc2qfaqVy98iIKsjwdEOfltSbqXsx6SZjGr7bguwWn
	is/oiPq0W4wBCFTeRBkEwctTQCjSvPabQkVgNlkiLHA4LsanhePHgiDvhPjW6cYvqCtupTknsiK
	s/iydqFyXUZaEmapqZkmr0om9QYCVX2qlWJeJ5GzQO2UQPOutr3DYdKm2bESQrv7wBli29HrWW3
	lV8uHxw35U9PeYpR/gNTc9bWgj/BzV+6WLr9ib76C7FJY4N2yjHvJOIb+xDwPapIyXc2TIJgLcE
	hr+vJUgKnq7XprDW8ga6Qv1SYBSbIjqd2Dt4dmrd6nykMwEASWRA4hiLnNZPfN8Ot8G9FLDbF11
	JxKuiva/Of65o+rSMZ1s3lVcCPlcvKb2CIjx5Tx6T8fP+VhtEgtI+iIKWy
X-Google-Smtp-Source: AGHT+IG/noxDbJ2ua4C+CLSewBamCxkllBE3NpGs19mktDiXa50Eu+evBczxnqDV+nDB2Up/ZpTxbA==
X-Received: by 2002:a17:90b:2751:b0:312:e731:5a66 with SMTP id 98e67ed59e1d1-32815412c9emr18183834a91.3.1756875167828;
        Tue, 02 Sep 2025 21:52:47 -0700 (PDT)
Received: from vickymqlin-1vvu545oca.codev-2.svc.cluster.local ([14.116.239.34])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3276fce1160sm21537553a91.22.2025.09.02.21.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 21:52:47 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: JC Kuo <jckuo@nvidia.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-phy@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] phy: tegra: xusb-tegra210: Fix reference leaks in tegra210_xusb_padctl_probe
Date: Wed,  3 Sep 2025 12:52:40 +0800
Message-Id: <20250903045241.2489993-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing of_node_put() and put_device() calls to release references.

The function calls of_parse_phandle() and of_find_device_by_node()
but fails to release the references.
Both functions' documentation mentions that
the returned references must be dropped after use.

Found through static analysis by reviewing the documentation and
cross-checking their usage patterns.

Fixes: 2d1021487273 ("phy: tegra: xusb: Add wake/sleepwalk for Tegra210")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/phy/tegra/xusb-tegra210.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/tegra/xusb-tegra210.c b/drivers/phy/tegra/xusb-tegra210.c
index ebc8a7e21a31..cbfca51a53bc 100644
--- a/drivers/phy/tegra/xusb-tegra210.c
+++ b/drivers/phy/tegra/xusb-tegra210.c
@@ -3164,18 +3164,23 @@ tegra210_xusb_padctl_probe(struct device *dev,
 	}
 
 	pdev = of_find_device_by_node(np);
+	of_node_put(np);
 	if (!pdev) {
 		dev_warn(dev, "PMC device is not available\n");
 		goto out;
 	}
 
-	if (!platform_get_drvdata(pdev))
+	if (!platform_get_drvdata(pdev)) {
+		put_device(&pdev->dev);
 		return ERR_PTR(-EPROBE_DEFER);
+	}
 
 	padctl->regmap = dev_get_regmap(&pdev->dev, "usb_sleepwalk");
 	if (!padctl->regmap)
 		dev_info(dev, "failed to find PMC regmap\n");
 
+	put_device(&pdev->dev);
+
 out:
 	return &padctl->base;
 }
-- 
2.35.1


