Return-Path: <stable+bounces-125985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4D6A6E66F
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 23:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FB0416BDB9
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 22:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AEB1EE013;
	Mon, 24 Mar 2025 22:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AQidUoCQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63961DC998
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 22:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742854385; cv=none; b=WYC4tjMcvhk5GWX4InlyDQMB7ViLkAUJ0QwjI+FWlQZtlmqaMyKlRVfakOsAmIFEDzuw+08zn78amk8tvCcVzA4c4kLOXrZlwNUuRHvOW25+wXZr5jFxqGcEGx7GEtysZQ4pa8fHGM8vC+5ESNMk0XmbdHWqtFy2Wep518MJCZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742854385; c=relaxed/simple;
	bh=P3H3yWNOTU7Jx5ICD3CTnIYzj80n61dEQx302ZRspv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=plONWUZl+xH9bzpxJXRbMJhIVkZlbTdKYjZ+/BiZAEX/dVWGlPmYUQzqjIElZTF97JkzglxbmkTJUmgUXxZKqOwx9yr/xWQNMsELNJKff+XEwNcWqF8FQcG0U300UcCpuuHNnX6NaV+vRxcyHgt8lLuiw7nHcGFDw7BTH+ZyPjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AQidUoCQ; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-601e77a880eso430671eaf.2
        for <stable@vger.kernel.org>; Mon, 24 Mar 2025 15:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1742854382; x=1743459182; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wDHxaRphamGmnxyvpLWbK14rCZzk5U7NR+E3kzCo3X8=;
        b=AQidUoCQ7sRqG6Os70oq03sAmPAphfHUoXtEVF6m3CrKUR2Kz1+eg3UK4QyotTZmdm
         LMoXoK/WalXh50N9uiWZGPpcZyH4HTeAKF2Elh/l+o+nQhoVO5608kJBaYIMm/h6m9XJ
         /A4e5wnf4a9V/he2/1KyHoMNdx5WSHeZKxA9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742854382; x=1743459182;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wDHxaRphamGmnxyvpLWbK14rCZzk5U7NR+E3kzCo3X8=;
        b=uNKluZZvH6HtMT11BST+T6M0wluhc1+Eor9jtarrvXssJNmLzOy/EWUz6pY2Hx8S7P
         2EOs0MZ9U9wZTVEvjwQHscCi1IOCVxmG9YJzd6LQgFP4Ju6mTcZOtoXXjLn1oHZ1VblP
         diy1kURDiSDp8KrTCK8DvJP7mARPH3NDCwGVxL0bzNZEHtqzMT2Ja8/TcJbw0aDU6/yj
         iRBgbbV43JsrxUwKv2Pl85+K8r2yXyK7Nlyw12CJaAK2SULLxvM5ez/jHfIjRgVP766r
         U+YWk0mp+UALqmLyLAIW5SLi5Aw1gYanvJhS0rBNegD3N+HB9YRY4LVagl/2+FeBJoSs
         QgBQ==
X-Gm-Message-State: AOJu0YzTX+4PPzX1jsfUpNZ81qnkrrIYDOPYMDrZrv7ygx74ChsWnjti
	BZa6AQUZoSDHNc+MGFwjcews0bpjLvOBl1ZXSQuGa2CteNXCiHOW8TWf/6n3jiwaSDZ+A6hY75U
	UrlWI2eEEZlGdvAW6DwdCS0bIUFlw8iYmGG5NXu+1x5SbCFtgMBx6e9cZFPHmlE3DDjuX6JFw7p
	IkRSqIBxvcSh+qF9WIkdZ3/sGqQN50+nPL4Z3hF1+3
X-Gm-Gg: ASbGncufc6/g4SLghrMdMxmDGAF8/ivfxAdofrV/1GQvPkoMow/Dohf0xb0vDsAL5dT
	kIdci7+jzaSnYcXccXTMZkxEsjrD1wMq8FCgmAdbw5UasoiJyjuqHxe2XTOHaBsDeHVvgn1pC8C
	6FHxiV0kMXB7Du4r2m4zC0kf+sQxUVArlfUmsGDP7BFCs2ZZVb0iTviXYCzxFXSk51cdQb/16By
	+u5BrTjHSd2PTKWPFbLayPIHX2wkyqI6qOaT2OGek+SfePfGYprcCpfUBxncwM7X+R2n45hrvfB
	3GC2SeeLc5E0+mNlF7/7Yp+DuuEdXiBhHQiV/i1oH8YQnIPrB6kWR79ezhiEef43X8NpvOla4Xq
	j/0zJ
X-Google-Smtp-Source: AGHT+IEZafmlU3AJ2pSLLGY/o0Jv51QpPhCe7Y2tBE58MCn6brVmdnZj6D+YY4tyrxGJuNPqBNSRKA==
X-Received: by 2002:a05:6870:3908:b0:29e:40f8:ad9b with SMTP id 586e51a60fabf-2c7802982ebmr9748002fac.14.1742854382166;
        Mon, 24 Mar 2025 15:13:02 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c77f0f4105sm2217555fac.47.2025.03.24.15.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 15:13:01 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: stable@vger.kernel.org
Cc: Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH 5.15.y 4/4] mmc: sdhci-brcmstb: add cqhci suspend/resume to PM ops
Date: Mon, 24 Mar 2025 18:12:36 -0400
Message-Id: <20250324221236.35820-4-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250324221236.35820-1-kamal.dasu@broadcom.com>
References: <2025032413-email-washer-d578@gregkh>
 <20250324221236.35820-1-kamal.dasu@broadcom.com>
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


