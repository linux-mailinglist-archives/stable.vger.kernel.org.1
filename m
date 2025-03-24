Return-Path: <stable+bounces-125983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8220A6E66C
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 23:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D12516BE8B
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 22:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADF91DC998;
	Mon, 24 Mar 2025 22:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Nr0h0sC+"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f65.google.com (mail-oo1-f65.google.com [209.85.161.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429F01EA7DB
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 22:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742854378; cv=none; b=EICS6d3TKj8I+KmvNBKgZ29KdSeHSs2HhloBqPgMEo3KmF+jTsRWjkUq25AAIzYoTRJ5FS+mLa+5DYOaWRQiff8Xh4ZyeX+AP+xeuxgY0u2KRayTXQ13DlrGb4zLQ7Q7q1fv7v+bGzWcHi4YT233bebA4GMdUPPpRQbQ1UQFD5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742854378; c=relaxed/simple;
	bh=g5+KGivb5bkhp7xB4PeT8S/tD0FNEkmAn9VDhoT1rns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=kkrEY5Z/LkNpCTlMiBMav+FtaCtbhiWUhmZYHIYfaWBkwl/bnSu0/zvX4l+iy5jrK+Yfn5Hf+wX0S3L+KJSWNuKRp0CVsfx4OYwCkkKNjV59DeB/OlrCtX6LvHE0BFcL3ePi0pqS0UmnGlI5d5gkU/AEtypN7/5T697o/eZhONw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Nr0h0sC+; arc=none smtp.client-ip=209.85.161.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f65.google.com with SMTP id 006d021491bc7-601e049d92dso2991268eaf.3
        for <stable@vger.kernel.org>; Mon, 24 Mar 2025 15:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1742854376; x=1743459176; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+LSFHSoalAZ07w6VDW1lgdrvU1OpL++pjEBu5OXzZIc=;
        b=Nr0h0sC+XlKwpZlIjTrbzK7UYuAwX+P58vO2qT//0R2nb0mcFvPbEbjQc1puUPAVMo
         mBoHY5K4aywXVxpaBsHndcJlwOWoSNtyvlZjCl+9wUTfKAP4Aq2DlEOLcsjD4OUhOyEO
         HvTzv4lAviMVFdFb+gn4tzknrUMfho3xcgxwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742854376; x=1743459176;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+LSFHSoalAZ07w6VDW1lgdrvU1OpL++pjEBu5OXzZIc=;
        b=pGdqwcYFthgan/L3nwpZPy3AvkHSQA62P77br6i1JrvS6zMyOMQsjZJxzL+rLX7QMQ
         mDe1HM/XIfYxxa26jvJW+FdbA5f1T7FG9v9fGTAja4HTcmeHivNtrgtZL/dIkXmoQE92
         yNsRommiBSj8uLTWXnKFdUW9cL6fxViv9/ySAXPlM9MpVv6bJ3T8vyUHRcK81eR8+Kfw
         utQe6bgbBDJhEyXZLrI3EkjKByEWtZzbHB2cOJNmkWLCMEZ64ZeR+NvMWdx1lDduQhD5
         fceI7OO8f1t8zqpeD03LS3fbPLLHjHdePzEPQNInlZH8IJZiBZqGlgTMewpFMTgETKZE
         /2bw==
X-Gm-Message-State: AOJu0YyQbj/c6+cr7yJDoeJrb/96m/7mwAKxlsESMT6Q9NZX3wXCz6a/
	2k7UQPcAuHPPJBNumhD2WFG8EehWXgwnp474ZWGx3FGgAxIiy1G0EEM3gejzri/meTVekOQOHUy
	Hyxj716FxFj2gqkJPlbbduVGrGObumnS1xjg5JDJwL79IfiEt7a/hfygMhgJpW6RJ5rHv1GTeyS
	vL9oJ9pz+MZMUwy7ZyOkJtPPN98hVjF/EXRdNyJuOClAw=
X-Gm-Gg: ASbGncsmTHOrng7jzq0oCwvRp1YKLls9f96lsK0E3Hj4EUUuPSKPAlnuNbfsBXB9VDN
	sa4NjT3w1G1Rjd7BO0qkGPtZZn3UNXRXd+JzZ/+9Apvfe+yH9PmMYrqjOipVUC6vKHYAQ2tzK2M
	q55NK1dF7X8iBznwmDzV11ZO/ze+ox7vY090ml7nr/mg9Ai+uY+a2siGnb3L86qWFLQ+kUnU7IQ
	WSJCJpPQzYqB2SB7ZQaRXvbBs7ZBfbHqjvdhWPMmu96et+zb8neplSxmIVd0m+5itJ5vXqiTNJm
	epCRucUarOkbuq6y96hVDY/NcNiJPtmbgQDNlIffVu3bBabQMWFQ2XgP1divLRei+Lbf+F9TS5g
	yykVy
X-Google-Smtp-Source: AGHT+IGuEf9OCKtXB51sea1R53W1TazkzqAeerW3iN+sKGFyiZEG+g5VCVDoHsnI4BwPn8TYRmk/5Q==
X-Received: by 2002:a05:6870:be86:b0:2b7:f2dc:a4bf with SMTP id 586e51a60fabf-2c780347a23mr9187292fac.18.1742854375596;
        Mon, 24 Mar 2025 15:12:55 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c77f0f4105sm2217555fac.47.2025.03.24.15.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 15:12:54 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: stable@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH 5.15.y 2/4] mmc: sdhci-brcmstb: Initialize base_clk to NULL in sdhci_brcmstb_probe()
Date: Mon, 24 Mar 2025 18:12:34 -0400
Message-Id: <20250324221236.35820-2-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250324221236.35820-1-kamal.dasu@broadcom.com>
References: <2025032413-email-washer-d578@gregkh>
 <20250324221236.35820-1-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Nathan Chancellor <nathan@kernel.org>

 [ upstream commit c3c0ed75ffbff5c70667030b5139bbb75b0a30f5 ]

Clang warns a few times along the lines of:

  drivers/mmc/host/sdhci-brcmstb.c:302:6: warning: variable 'base_clk' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
          if (res)
              ^~~
  drivers/mmc/host/sdhci-brcmstb.c:376:24: note: uninitialized use occurs here
          clk_disable_unprepare(base_clk);
                                ^~~~~~~~

base_clk is used in the error path before it is initialized. Initialize
it to NULL, as clk_disable_unprepare() calls clk_disable() and
clk_unprepare(), which both handle NULL pointers gracefully.

Cc: stable@vger.kernel.org
Link: https://github.com/ClangBuiltLinux/linux/issues/1650
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20220608152757.82529-1-nathan@kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 drivers/mmc/host/sdhci-brcmstb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 8fb23b122887..931b34bf2af1 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -257,7 +257,7 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 	struct sdhci_host *host;
 	struct resource *iomem;
 	struct clk *clk;
-	struct clk *base_clk;
+	struct clk *base_clk = NULL;
 	int res;
 
 	match = of_match_node(sdhci_brcm_of_match, pdev->dev.of_node);
-- 
2.17.1


