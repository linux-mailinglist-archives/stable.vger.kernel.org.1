Return-Path: <stable+bounces-125973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC74A6E49E
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 21:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4F1716B01D
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 20:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB2F1DACA1;
	Mon, 24 Mar 2025 20:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PM1S6eok"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f65.google.com (mail-oo1-f65.google.com [209.85.161.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EC2188A3A
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 20:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742849268; cv=none; b=rem3fa8lmeMFZl6auzrq0wkhkLEKouLAid1oyeOipp2zEf4I1HbAJBvhG8IsAo02RcL6tNP/QS5cgUF8xgdfiMhMYyHclDLUJ3HaF5+zX6l8VakbczBu8Grg7YBSseY7/a/qZzHsPssIzg+7mvhRtU9ujB3PTpRktSGb2PZcTs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742849268; c=relaxed/simple;
	bh=WT3tlT8xzyE1NJyAoePmuA/c2+6VuluHKHGHSaGCCRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=B/J6mW+tMUBB/FQ2e2XXwdHHcKRfEfHSj7ByDZCg1a2Aolq/UrRXrw55yrKY3Q6dS8CiB1YFn6VcFSo99ju+OTbZ/daC0GjKxL4QXQf8V1AxHUGnLTzszjmX0X60ChaDBp+B4nliPO2MmqNNynllwHil2HW7uVwV8b5myyDVeBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PM1S6eok; arc=none smtp.client-ip=209.85.161.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f65.google.com with SMTP id 006d021491bc7-601b1132110so2704586eaf.3
        for <stable@vger.kernel.org>; Mon, 24 Mar 2025 13:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1742849266; x=1743454066; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=opspjgikh9o2xH7iG0oywEKtuTJ6YLxFhbvaoTNv65w=;
        b=PM1S6eoklvlpAaEXYv2N06+NqDOJNMmsieDwFY4TX2CZAsYVEitEiob53T5T1iSvrC
         7Mkr9XNmKZwiKtgmm5/vw6mjXk9HIIWNBzV7VGy/vuUX97yN1OaY2a94BvHrnzQkDeMx
         jfIWDHhJlQ8REBzpC2uwtMax6hHk0bjTfzSfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742849266; x=1743454066;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=opspjgikh9o2xH7iG0oywEKtuTJ6YLxFhbvaoTNv65w=;
        b=fnUrF8br8W+nujZkvKSNt5AlbXyPNS9HCT3VOIDYuzwfgyLu54d6h7SSk44HP6Yma2
         h4RMIg4NJbm4E+eX59Z8sqsHyp81RO7XmzUbMCEbmyZB5tq0yObGULZGoq8xBiE/Jly/
         4fu9KGDXAURZuePTt3XLLqJyx9Gbk4RRQeOIxcGuR25m+413wXfzivRehB8g/qz+6Cbc
         W98xetHVyeig7K6vKDy/EZOdh/c8+uP523TrpTIaNzHetL26Yu5s2lDEI7lKOpLon28I
         LoEPcrt/EZPk6R3oQsp/IhPsDPjEYt9Oub99sXqVYCRl3VpA/CtkNWTbp5JYIyeXqzkh
         RLXA==
X-Gm-Message-State: AOJu0YxRUoq1DZyveFjcaG44HFe2CoZFSf9C2A5Ew2FbqpQRt8sRFNGt
	ifNtv/TcUsiJqAeDEXJn7Hq90Zb7QuM7O1bHSRqKVi2X3Ach3QtMQ0+O8NkHRUhZz+DSuHPklse
	wFduPFnPMw+1oKQBl68dytvWbx3Ru/DGAFy8wyvH5LBCfcNsZWC4vX9wmNQmcU9GLndlz/0H+9N
	BbdmqvA5pS0pknj8KTKjX9mQXXEuvVIRYgV00cDsG6LnI=
X-Gm-Gg: ASbGnctQr+qCAbpmzCTqnc/thJHOWUUufdb4a5cMrQRenb3f+OtkLVzz3JscD/snfL6
	MNuS59JGQ7lIAOum+wTT05FEIq5IBvAHCSjFRPEfbctvbblIZGSrDjhEuuCh8VCSBcFPJdnWFCH
	H9IRCFY2bbA2i86995IguPMdLLY+e7JWhzmAxgbrUpEX3yuxhqsi/HCN57/lfyfPGC1suR2QcmJ
	ExOM0Tq1ALX1ONBnKaDg5DJLKfKEU4gWAB3tyL9hN09Qgxml2PQHtCSGLMEZhQmRzXidldF93Q8
	ewijrcPTsx4cZJQLyo9p8ZsqK5k224ywqmurwpgLZwgHwLkT/WmRlLMiZeefKsw+RYjl550/rc+
	HwiSTvCaOGQDq9lM=
X-Google-Smtp-Source: AGHT+IEFsYH0Ees/vTY2kiyp3eBEA06rR1GKHEIeILs7Co4DNKvd/19ly37PJY/dDMQVv60aZ3aIUw==
X-Received: by 2002:a05:6871:88c:b0:2c1:5e2a:b8f1 with SMTP id 586e51a60fabf-2c780542b63mr8768753fac.37.1742849265627;
        Mon, 24 Mar 2025 13:47:45 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c77f0f6825sm2181080fac.43.2025.03.24.13.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 13:47:45 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: stable@vger.kernel.org
Cc: Kamal Dasu <kdasu.kdev@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH 5.10.y 3/4] mmc: sdhci-brcmstb: use clk_get_rate(base_clk) in PM resume
Date: Mon, 24 Mar 2025 16:46:38 -0400
Message-Id: <20250324204639.17505-3-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250324204639.17505-1-kamal.dasu@broadcom.com>
References: <2025032414-unsheathe-greedily-1d17@gregkh>
 <20250324204639.17505-1-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Kamal Dasu <kdasu.kdev@gmail.com>

 [ upstream commit 886201c70a1cab34ef96f867c2b2dd6379ffa7b9 ]

Use clk_get_rate for base_clk on resume before setting new rate.
This change ensures that the clock api returns current rate
and sets the clock to the desired rate and honors CLK_GET_NO_CACHE
attribute used by clock api.

Fixes: 97904a59855c (mmc: sdhci-brcmstb: Add ability to increase max clock rate for 72116b0)
Cc: stable@vger.kernel.org
Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Link: https://lore.kernel.org/r/20220714174132.18541-1-kdasu.kdev@gmail.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 drivers/mmc/host/sdhci-brcmstb.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 931b34bf2af1..ff0404d591d1 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -407,7 +407,14 @@ static int sdhci_brcmstb_resume(struct device *dev)
 	ret = sdhci_pltfm_resume(dev);
 	if (!ret && priv->base_freq_hz) {
 		ret = clk_prepare_enable(priv->base_clk);
-		if (!ret)
+		/*
+		 * Note: using clk_get_rate() below as clk_get_rate()
+		 * honors CLK_GET_RATE_NOCACHE attribute, but clk_set_rate()
+		 * may do implicit get_rate() calls that do not honor
+		 * CLK_GET_RATE_NOCACHE.
+		 */
+		if (!ret &&
+		    (clk_get_rate(priv->base_clk) != priv->base_freq_hz))
 			ret = clk_set_rate(priv->base_clk, priv->base_freq_hz);
 	}
 
-- 
2.17.1


