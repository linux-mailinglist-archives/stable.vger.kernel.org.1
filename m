Return-Path: <stable+bounces-124054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BEBA5CB7D
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 18:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6BD63AD961
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 17:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA0E2620CA;
	Tue, 11 Mar 2025 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="A2rmn93w"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870C1261368
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741712399; cv=none; b=lSDTa71uRpBo0UZjOlC9HejEgDTcPwfHI6ufKkNOwvTKngEIUDaai08aKvKMPkD82AqV6LbrHrXUzcbyQQ0RFhhl/Gg6ILMIu+5X8x/PJBW+4CW2t/u8OLVOShKcBzRng19hBLlQ1UA6hrdmr+uefx0rj4W2rOiW2sfEKyxK7+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741712399; c=relaxed/simple;
	bh=152+JhKdJURsyIW035cU5ZqaX/06tU57xV2M5Cjl64Q=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ABHBdpRBEeHcHnJRv3neTukcFkqsX2cu8XRuuQ88d8duuDiQiGsn8a5hYSrBuxaCCst4WRWkkS4+0UduWhf23XTaJbcUCBbwZoVO311raACyN178HeJnh2pcf59F2fVsf8w15+Sh/TcnL2wf2kKHHmp0YfaY3q7+gG4N5Dw9Q7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=A2rmn93w; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-60010601291so1039519eaf.3
        for <stable@vger.kernel.org>; Tue, 11 Mar 2025 09:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741712395; x=1742317195; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mXZ5saot0RNfXEwNRIKD6v3oYeaF3NNGEULkoMtNjs=;
        b=A2rmn93wxtQJ43UgkZxaODw/TyPkwsKhDBJVK+WN76dU++7buB/cLc3ALDtF6TdrEp
         6vNI+WHkYNziFOoEqyrRnulc6wWspx9XRAL2UBdKk1i4s2DoTDLD+HvSKMIrz8q1GpJU
         nuSE5+hxNDdzEiTnRTreYPmEq8UxWPeS7/8+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741712395; x=1742317195;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3mXZ5saot0RNfXEwNRIKD6v3oYeaF3NNGEULkoMtNjs=;
        b=lY8zgwbQ9mmMqtnjojmCahzj5fy6aTI8FsAKLcWttXMDz8bzPEg8vWwC77U9YKA8F8
         p/4IVEvgIuEMDSXmHDS2t5l5HkSb0tRZ0tsh3f+wAY+voiBk2WHqKofHlghOznHpz+rm
         OQ0LhjA5gf1lptVN76tHZza3HFr8+o8kMHfO4ZEkUPekG5YxtcU7lrzZ5o3Gjo4XtaK7
         3EvX1rTF94r0/3VLhjkBhGW8izUrba+ipjqMgiLejf2G/UMSTC/ns9XvReE6nYtLE3t6
         g1Agpuj0Oa4412vgtuTVXqLHI8uts0ayKLdfEl/F1IpdikhC9da2pSsnVf5qjI6VLV9I
         HMlA==
X-Gm-Message-State: AOJu0Yz9fapDKw2F+WvLIk3uTMHjhz2WGLjE0gwcPgpxdgFlJZSvXTiV
	JmE8JaR68t2OgcWw8AAo7y5kZudyfbpmlZPlP81C2PzKl7T+JuHigXugffFzYQ==
X-Gm-Gg: ASbGnctqUkDmBCpVNlSIpJhFwRKOQHKKsD4xNRWbxSJibxdcjnTlTbQssg2QznDFz2c
	nM3QJWD3lrlZzoKzzNsUxUTUsIF8BPTHo+dkA77PhIoovgz2F5+fBcQgeDS11DMH+ISDMrlBird
	86+gklgLCUQPulSVAESu9z2pOyjaq+YOJa/D0Zjj2jvpZL1dLNU0ZowIjInOO2I2WKPhmPFaxVD
	zZOzul7udkVq/CX13Yz8Q+LGPXjAhr+Sfx2VOxG8VmMZCIQBcXbh7kljH8jSka9m/alEosHFXgk
	yH9KpJZtPt5ns1w3bFG/1pvUwdqCz5RnlIqWtuq8aP8wyKlbVEeyIkYRexwGT8R6cf1Td2pM2Fm
	Z2lvWjPTEq7J4LA0=
X-Google-Smtp-Source: AGHT+IEo2y1B2P4YlspZf6ieZjf8/Wmas/53NMabqNUKfjrw4XnZraf15n9gzLSdbh8zE4W/K5VXSw==
X-Received: by 2002:a05:6808:1b13:b0:3f7:28ac:8068 with SMTP id 5614622812f47-3f728ac86fcmr6097289b6e.13.1741712395590;
        Tue, 11 Mar 2025 09:59:55 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f9513f1f88sm682492b6e.0.2025.03.11.09.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 09:59:54 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2] mmc: sdhci-brcmstb: add cqhci suspend/resume to PM ops
Date: Tue, 11 Mar 2025 12:59:35 -0400
Message-Id: <20250311165946.28190-1-kamal.dasu@broadcom.com>
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
 drivers/mmc/host/sdhci-brcmstb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 0ef4d578ade8..48cdcba0f39c 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -503,8 +503,15 @@ static int sdhci_brcmstb_suspend(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	int ret;
 
 	clk_disable_unprepare(priv->base_clk);
+	if (host->mmc->caps2 & MMC_CAP2_CQE) {
+		ret = cqhci_suspend(host->mmc);
+		if (ret)
+			return ret;
+	}
+
 	return sdhci_pltfm_suspend(dev);
 }
 
@@ -529,6 +536,9 @@ static int sdhci_brcmstb_resume(struct device *dev)
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


