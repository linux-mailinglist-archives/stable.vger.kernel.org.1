Return-Path: <stable+bounces-125975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1324A6E4A2
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 21:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C64E3A80E9
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 20:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C9A1D63D5;
	Mon, 24 Mar 2025 20:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iBihvzcX"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D421B0406
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 20:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742849269; cv=none; b=lVI6LZcDZIlkTQ/h+W8a17+T3/0+1vX6LvmajmLEDtsZIBAeDwXGK5Nas/goxiGm7PbR3YldIoAt6AY3L9W2O6Rs3WjBp9lzrMKfaeLrNOHyJJwkFtn+nXD42FAgkdLVDQ3Vv606L9KZwPlEUR7jxQiR5ATyqP2krsnVrTgKTdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742849269; c=relaxed/simple;
	bh=P3H3yWNOTU7Jx5ICD3CTnIYzj80n61dEQx302ZRspv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=g3rb8YF/45lUNim/MTv7cGButiUgaX9omZLD0cyR02yqc0hE4UT1ej9ej+vEL5knn+tonh376ZY5z0DSbUko1zG6Erl+YcGipaOgwLWg3B9/zKn6kVbk8jci60NMqVfWuCIK72fgmYLcFUiNZGLWrQIw1aU3DWV4kSa2l1K3+/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iBihvzcX; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-602513d21fdso358094eaf.0
        for <stable@vger.kernel.org>; Mon, 24 Mar 2025 13:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1742849267; x=1743454067; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wDHxaRphamGmnxyvpLWbK14rCZzk5U7NR+E3kzCo3X8=;
        b=iBihvzcXFK9BK3g21Xe8Qxpwc65u58E20ARnnitRs5aAJ58UA9TFX9yAI155SQ0cfv
         UM7pdczi7W197SSlfLWAWoJ+YBvWLqkBqmFIf6nePSyZTDu2F5O6ZPlGk6zAEgSCDOXl
         mIsOAuQ4qndHsXLlwCaMXn7IqcqIUdK0kE9Vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742849267; x=1743454067;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wDHxaRphamGmnxyvpLWbK14rCZzk5U7NR+E3kzCo3X8=;
        b=qF9UMRYOjzacNhEa+y6Pp9C1zlsbYOoRLp2xT2cq18eHRChgyI6I/VbHxaFByAJTbo
         JV6dBEKSdtCdya7JZurJfgc4YG5uVG7w0ocsFiVDr7JJRbHczR55mmtLcfRiTQoXrB2Q
         czCPFxILF7hoMbfRQUlDfKQ3DGVDXWMZ2sjddXR3gmP6enCZIx4ruj+7vgNXWtbSjGbo
         R628YwuywI9e1eIfnBihuCdO/Y6TQXSxwHBuBBC6TBuRXd6i+vJQf+/uFAVy/GLX6VxC
         aCoerymY7zniaXZGjcvjPHEBo+2FtqEALpRaBOceHnSXxeR/cnrDO3rQ6dNFMownOANM
         PNhw==
X-Gm-Message-State: AOJu0YzLt7S9USTqxrtMdtr5/nD1aD0he0ZZauI9Ic1LE0eeISmB+271
	upQcBYGww0qsaf/6DOTE1ccAbs6pz3rrnq4E78gjDG47aZ5EyA4bzza4l1fwFSKnlUIjfySbh3O
	XQtpLcaXXP1igMZTQufM8RxVorJoXsyC4KLKL4Gc9fNI3lTeNp/KjDX+ik51wgO9IlZvxeH0haL
	L1dFBTpbcnpNYXhdjB03dS2zK+nQaXQgs8RDHGsIg4
X-Gm-Gg: ASbGncsSioYtBZGeOfXncGNfwenlOGBoL8ZzGERDccU80oNz4UEm8wr5PXKL187xrxd
	NQRxuqq7p+n/MPrwBZdMdXBYf3aoEWnthCrK1pSYZxsy/HU+18H/BW7lqsunw4/dJoMLBiyekOb
	0OkkB7uGs8Bfb/a5gJ59MI4I00QsybzmT3kKkmbeQ0kNkB7l1nwrO3tsgjw/epqF5LQk3OxH8Xd
	c8lGOJYYAA1NcG3Fssglur5Gg0gbJ+hoZ8acyseH6Pst2Uy/ravq40vHUc5IZx7XwCcS2wF1T+O
	fSMf8tWJMiCtb1nhmSYg4hyknZRt4Nhdn127lKTjoZv4scUEXHhA3sI/sibtWhnntGGBMf/bcBl
	dQxIo
X-Google-Smtp-Source: AGHT+IF9F42DRq4ffVAaenhmYzaiLdXilWXdCTCAeXnyxi7BLjFdRdPowGzMwzUjQCo/3V99RJGN8A==
X-Received: by 2002:a05:6871:400c:b0:29e:503a:7ea3 with SMTP id 586e51a60fabf-2c7805c6e03mr9477235fac.36.1742849266607;
        Mon, 24 Mar 2025 13:47:46 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c77f0f6825sm2181080fac.43.2025.03.24.13.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 13:47:46 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: stable@vger.kernel.org
Cc: Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH 5.10.y 4/4] mmc: sdhci-brcmstb: add cqhci suspend/resume to PM ops
Date: Mon, 24 Mar 2025 16:46:39 -0400
Message-Id: <20250324204639.17505-4-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250324204639.17505-1-kamal.dasu@broadcom.com>
References: <2025032414-unsheathe-greedily-1d17@gregkh>
 <20250324204639.17505-1-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

commit 7116ceb621274510ccbc7e9511f44ba6c3456ff8 upstream

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
index ff0404d591d1..05b06fcc90bf 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -392,8 +392,15 @@ static int sdhci_brcmstb_suspend(struct device *dev)
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
 
@@ -418,6 +425,9 @@ static int sdhci_brcmstb_resume(struct device *dev)
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


