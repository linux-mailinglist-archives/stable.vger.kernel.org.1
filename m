Return-Path: <stable+bounces-125984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA595A6E675
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 23:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D9E3AB3EC
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 22:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB121EB9EB;
	Mon, 24 Mar 2025 22:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KddXk5tx"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513601EA7DB
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 22:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742854381; cv=none; b=geBLDANt6QUZNZSm7DijTTyn3bji+Tl8+dBndvY/P/gTyc1fjtIS/x/rjGGB8cSiPwcTQVLImXx+DrlHe4lNNYZ93x1Z+djHQ7fGDLuVgvcaIHIa7HdiqvOhFpd6Tq7nSXf8i6WwyKVfW8GxTF5Khn4ke2Z9f+Q7DPd1Vu6rkMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742854381; c=relaxed/simple;
	bh=WT3tlT8xzyE1NJyAoePmuA/c2+6VuluHKHGHSaGCCRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=FnXC92CY4FPGed5cvj/YugQw8MuuI/G9W3IsgYXy1aj6V4Hdz77mkDImA5DI2SZL4qIJm6NIRvpsonxT9qi9TOAWtJspEszqfJwrexvQPs1s+XWxTRwaGutK+pR72gT481PSPB0UPf9NBmpQz33Wf/eSAcJi4WuwyI8fWhRBlXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KddXk5tx; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-72bd828f18dso1646056a34.2
        for <stable@vger.kernel.org>; Mon, 24 Mar 2025 15:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1742854379; x=1743459179; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=opspjgikh9o2xH7iG0oywEKtuTJ6YLxFhbvaoTNv65w=;
        b=KddXk5txW3CJx7hE3U1ldWPZbqiiCt+JZgtmxfWRAN2V4U5NBKB0db/za7SUZ9pItL
         yFw80nJ6qL+yVqxt9g1USqw9ACkYRZmZ00boDWjHGBUlCkpaUIKtpJctTvCg0ygPY5uu
         oe2ZFVXekBx+bkEFPweFyg2AxygtbycoLl1Wg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742854379; x=1743459179;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=opspjgikh9o2xH7iG0oywEKtuTJ6YLxFhbvaoTNv65w=;
        b=idTu0VU/qKpdnODjSx0ivRVKVBO55aw4vHMyyJyt5R0GWOMOd8F1ek2VYLegcOR7qr
         1+3m5mCfKtwI5c+u7E8dPOIYLyGsGasYOi5sNERxVBRN+R5uKvtVd9NtiK7cukLfstPg
         9zJJcl1XJ56cLw1GT/xUxo0pT4jD/5yjMQnR7KRRg+GxX/E6TkWigMl+Tcv9oVv950ew
         dd6eq/gsSYTFfcuBh00WlGdq3cKBtLAyKiDlYQiNxIKGHs+nLjNOElwbj5vsphOCGs1b
         wSjXA272sfqN3anKpTB3s1FBrevb7gKAnQx4f+xJ8oGfbsAjDC84JFUHIgajTOhN46l/
         20ww==
X-Gm-Message-State: AOJu0Yxcso37ZfG5wFJE9+7VwYnj7NjDV974yLu31YmV6Mf7XXkaVPqc
	Eh9aqX4vdFESxBlw8vIxWngGWweWuC5TpVshX0tYcdEXSgpwWe5iSncX6LrcLXU7TNb8QPZ334O
	EbLwZt1pW7JBHQ8iqaDES479JCrkET3ZwX02glJToX+PEkX7qijh4gZfKt2egCHXTXFJriNwHKB
	2265Q9xhPPeQFyd25XSVSc9cRXyAX/mx6ZLN0MRCTRVN0=
X-Gm-Gg: ASbGncuNzOB/9bcjm1wj6bJBFZVqZcmEdSaHgRRAxve1yEBdZnrtaEwTnxqsDs9zvFH
	U8IIVVlkJH8PqquN5A+dBMckaiMW9L7XpqOwaAggzGW4LLZ8j8v4/mPdYVx20ddW92HDXSyI9/Y
	jfSkxKWWIMubMx84j2ri1ZI1edaIFvMKzfjdrZVD88onbtNaXC+0Acqs05+KlUWGAGBwAqiY1Q1
	F7Jb1i+7ApJOqS/ynret1/yT/KkhNc/102RqSm/sLqZ4EaB/Q/1TU2jgavhOjEj/S1KSBzeSbzR
	AUsoVFdp5vLmK6tRpJm55D9+KuftbcSoCLLca+29Um0xziPDeIuDdNG6wn0PI+Ecp22zN4PWqHR
	6tyeH
X-Google-Smtp-Source: AGHT+IHJArxJPoe/8PMXpo5l55ZEXbMKhaWAnWLXJ6bnczMOwNIiGq0LauI/hWcp9Scv0IfnOOzSkA==
X-Received: by 2002:a05:6830:4882:b0:727:3439:5bdf with SMTP id 46e09a7af769-72c0ae98f15mr10187583a34.13.1742854378549;
        Mon, 24 Mar 2025 15:12:58 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c77f0f4105sm2217555fac.47.2025.03.24.15.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 15:12:57 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: stable@vger.kernel.org
Cc: Kamal Dasu <kdasu.kdev@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH 5.15.y 3/4] mmc: sdhci-brcmstb: use clk_get_rate(base_clk) in PM resume
Date: Mon, 24 Mar 2025 18:12:35 -0400
Message-Id: <20250324221236.35820-3-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250324221236.35820-1-kamal.dasu@broadcom.com>
References: <2025032413-email-washer-d578@gregkh>
 <20250324221236.35820-1-kamal.dasu@broadcom.com>
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


