Return-Path: <stable+bounces-123232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88012A5C45D
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DC763A65E8
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A525625DAEF;
	Tue, 11 Mar 2025 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eMAY1ZF0"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6C425DAE3
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 15:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705309; cv=none; b=s/zsTpPpcAtpLZW56F59/AVvqm+VDyKEVSooqUOUrQw/bX7JtzA2XiCGmLJOs/qCTFeemC8Tw/a84/Ttg0nEArGJFknlwo78O0pl9g+U6rnROFRVadSrYd4jal4x1S3RbkhJkNx2P1NNFyDSciKaO5g6Mz89YSCI8S4UUq9J4B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705309; c=relaxed/simple;
	bh=Es7Jq+xaUItmnmFx3FliQRRwKbWCSA0oO4kxOs+0tR0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=lXvewijfFz36BRwegnz3uDZvliwG9vzEIq0JZjt5D8noPQ/uQWoKhzipyOJDTBWjSAxmWUNCKRyanNxLiju4/7qvUR7NLYYchEHZvGMiisjInKsJHcK1g1o+CdU3ZnNJRpyr4c8hpFri8uHnNKGIP3mig+/uGyXes3P+XgVdYrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eMAY1ZF0; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-72b82c8230aso565022a34.2
        for <stable@vger.kernel.org>; Tue, 11 Mar 2025 08:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741705307; x=1742310107; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4b/KdywCYMFDDq1/kWvENPSoLkrsBJwlXAOtPzvf0I=;
        b=eMAY1ZF0lLHPg0dOW/tX9X/on+2/+H3t0pn1rFeX7hOnh11h3we9Zc0jPHORxvcT+i
         VnV/tLSWF2po4TZLDDzSkROkC0gSmE2KuVC4yBvwTT8sVcpe4MUwNuMfkfJPj5/lb3Q8
         JHnd9FFHK1bGv1rpHyrghcmK068GzRqIBUVlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741705307; x=1742310107;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g4b/KdywCYMFDDq1/kWvENPSoLkrsBJwlXAOtPzvf0I=;
        b=L+yt0xvy1kdhF2UQ/P/S2JbrFFCaDWs7DEtxeiHuJH1vmplZnw6wgcHekeLq+WFvHF
         FoQ90uCOrK/Xz+0huFuY+J5Ru1OdZ/ym6muK3zWnVLQMkZhPcpWBD1/gcW6kX8KACclX
         SXElk7vff/SDZY+QzR3OeICxdJz8bONn/SvbShBmMUbqj2HPbEf5xNbJmozG1vjMKzNw
         u5YV9MjBj4A/g2AfNOWQWGh0HJqgQYCLGXfVte5piFhYdTOYMBLXgIAza+SsS2/Rf6lZ
         hHsPwFTnbhdRcnVxdk8wDUUS87xcNeJdNg3D902IoLxUbXOSs5lqwNH6ZuezxDQeSiUv
         plKw==
X-Gm-Message-State: AOJu0Yx5IFLYSFlHy3M+uWmPAU3sAxb83D0gKyBfiC1il8jDe1GJFncT
	2ANEWOLkKpNX3ED291m28xH2ou0Y8+iQYUhcyddfxr4wDiEL/o/DqdBzRu3x/Vqf2wJaPg1NwlU
	=
X-Gm-Gg: ASbGncvud9RRA4RLZyo6SIi4/mr+0ITdkFb+DI3Zol2zziSuEGjyYE2TZxFjH4vGi97
	IYZNGxcO5BDE4MWQ9LjpxI5ImJ8d7oQgsyTqpCdVqn4x0LpUqJHxNoBaEkls0fLSdQe8HZZBxLS
	585WnzBBzNgS2vGO9UpH0Sr1UrZirtPQ5SoANbdNmdusKHDpSR5oV+B/Fi15blkCykgJKbxSJx0
	K0v3+E6GpjO1ycQ5pXrnTNz0AYJfo+nbDcOgEy3F2aIaQnMT5eBcubxJG7n6JRIghCJefp3vv3l
	VM2Ekccp9wI1ox0HrPzyqndfDoJ7QiXSzjgq6kbDA8AgDm72HcGkx1s9QGSVFdVFsOanTcw3cKw
	lrdv7
X-Google-Smtp-Source: AGHT+IFdbjAPLkBcT/PdO6aUZ/LPk9p9TaaPPNTQhmFPj4MU5+L0g0wPVorRUgYDuoVha/IN/Ce0Hw==
X-Received: by 2002:a05:6808:151f:b0:3f6:d59c:6a40 with SMTP id 5614622812f47-3fa2b30bb82mr2312809b6e.28.1741705305315;
        Tue, 11 Mar 2025 08:01:45 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f9513f1f88sm646247b6e.0.2025.03.11.08.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 08:01:44 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] mmc: sdhci-brcmstb: add cqhci suspend/resume to PM ops
Date: Tue, 11 Mar 2025 11:01:28 -0400
Message-Id: <20250311150136.46938-1-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

cqhci timeouts observed on brcmstb platforms during suspend:
  ...
  [  164.832853] mmc0: cqhci: timeout for tag 18
  ...

Adding cqhci_suspend()/resume() calls to disable cqe
in sdhci_brcmstb_suspend()/resume() respectively to fix
CQE timeouts seen on PM suspend.

Fixes: d46ba2d17f90 ("mmc: sdhci-brcmstb: Add support for Command Queuing (CQE)")
Cc: stable@vger.kernel.org
Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 drivers/mmc/host/sdhci-brcmstb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 0ef4d578ade8..bf55a9185eb6 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -505,6 +505,12 @@ static int sdhci_brcmstb_suspend(struct device *dev)
 	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
 
 	clk_disable_unprepare(priv->base_clk);
+	if (host->mmc->caps2 & MMC_CAP2_CQE) {
+		ret = cqhci_suspend(host->mmc);
+		if (ret)
+			return ret;
+	}
+
 	return sdhci_pltfm_suspend(dev);
 }
 
@@ -529,6 +535,9 @@ static int sdhci_brcmstb_resume(struct device *dev)
 			ret = clk_set_rate(priv->base_clk, priv->base_freq_hz);
 	}
 
+	if (host->mmc->caps2 & MMC_CAP2_CQE)
+		ret = cqhci_resume(host->mmc);
+
 	return ret;
 }
 #endif
-- 
2.17.1


