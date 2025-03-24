Return-Path: <stable+bounces-125974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DF1A6E49F
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 21:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6D3916FDED
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 20:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4FD188A3A;
	Mon, 24 Mar 2025 20:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cpv+Hbq0"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A4219E99A
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 20:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742849269; cv=none; b=EGJ1gghUvo4VbpXnAXP3mjzZXJCSFmyHAo9VSMl4i3ZShXrL+yWRg4Knq6L3ZTkdB1YFpogl5/voB1P+xKR7NiWOUGh25odzuIOwmQQb987wKsh76m5CTFckNThzfc5N4i6flnZFf54xiJw07BhvvEceA6GihgowvNoaL/IgqPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742849269; c=relaxed/simple;
	bh=g5+KGivb5bkhp7xB4PeT8S/tD0FNEkmAn9VDhoT1rns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=UtoMWYhZs9b5zbYiIUPdaM45oAJQaaetLieyoAZTythceuIHrHDe+5QHl4S1RUU9GPmYCxvRhbGqf+3p6laE0SMPpC4HG1MKceMjXcVfprvZbwDiYZ6tQGXaHsmdRosFTXqd77sfsy6iPca1fKOwnNJasMgXh5p8YV6JRulNh/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cpv+Hbq0; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-72c1425fbfcso1399843a34.3
        for <stable@vger.kernel.org>; Mon, 24 Mar 2025 13:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1742849264; x=1743454064; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+LSFHSoalAZ07w6VDW1lgdrvU1OpL++pjEBu5OXzZIc=;
        b=cpv+Hbq0HX9ct0KqKD7TaLO3P0oAT7kx1D6MWqjgMGL5EpqZ3ayUsvCDww6EsHekm2
         SSm5EWyQTuxsOQ7aLkh4r2LhBoTkoRD6ng5VYeesG9hDFGkx9Ccd1qZ0uQFYOe2zjz3J
         nhWamjel0y9T/kFTVs4+v7kQC3DSn9pLtJnzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742849264; x=1743454064;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+LSFHSoalAZ07w6VDW1lgdrvU1OpL++pjEBu5OXzZIc=;
        b=Grkc/CPby9sDuiRE+NS88Zo9UgRJbs+BBUfCJm6i1f50ihTLd9NpJZ5b6rh2rjuTcH
         ed7WLhC2A6U1WZW0WaF7UMtbR6/OAVfkOdM6+ovya1B3Sg3K+XtqNj4pAeCj6HCBAk1D
         kZpnqbHIgGTcj+W6kC3QpXqTcLP6fOadh0e7J2PvY3qivKbDgNLqgtNYH2NKwLJDDlzk
         8GotxiInK0F1+C32HIpeIRSvLI0LV0ifsR1qTt0t9GIFWNHe1R9a1e0k9qnrSMAQ2nA0
         K290PRZ0BUDcMmAV7vCdikl+/IfVcTm5umVDOMMG7ytBDZ1jS8zja6P5NrWFW0lhgyVv
         ogPQ==
X-Gm-Message-State: AOJu0Yx8dtWoen14Kw0xRMP9YecRk5cZFLOKdfIJqXwfZkp0wk0x8Lf2
	NaC6UALzaQIOlxAWVK7oqaSrfJHk0y6hFAbVBMnNJl68YPkmUKHm2rf1gLN7MRs1L11J2iRp6mS
	o7Cy6WmBHN0k9Z40u+7CTYRnkNRkmdwo+CWvcEnKfHYql92z6lg84nYZTxwFumWOlJOlCuInsGT
	q6xz/VWz75tDQbFmKKR7nkz4Fw/GGbBioCducwvWObegk=
X-Gm-Gg: ASbGnctMo9F7DTO4puVdbPWaX1Va6c7op7bTedZGl2h3LqfzdOB7DNQKpZ81Kg0CDg0
	sc6Lpm+qYHht2/jQWI4UKCl8NCcZxEjcl88SPdwcJex5LlYoMGsOymZuGSWV1D12CfVGmP6YrSX
	jAFSpQVCwWRHllBMsTPVozK4Nnim46qixkGmyN3k9xLEBFH17XBQqK2PmB9ryKqGCuUJvHmCIjS
	gp22WkB8/Q579gcLpgBXsFza4PZl0lrG2OPW4mnmPzrsAadHeCDN6rLTQCis2aPl6d/pdQJNO92
	1RAv+KtvA+ejv28IPIsdDFDKbmieN6gFYWbDtpVP5Psras9WTzCLjg4Ebtp/yKTB7raUWr8l8FI
	Ixuea
X-Google-Smtp-Source: AGHT+IHyhQWjPBreQsUGIex36U5Zqfl8d0BaMljOEM+7z4qmAd+oetzSn5io+KZRnjqx4stZ2rgjMA==
X-Received: by 2002:a05:6830:380e:b0:72a:18a6:d431 with SMTP id 46e09a7af769-72c0ae99824mr8858364a34.14.1742849264255;
        Mon, 24 Mar 2025 13:47:44 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c77f0f6825sm2181080fac.43.2025.03.24.13.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 13:47:43 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: stable@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH 5.10.y 2/4] mmc: sdhci-brcmstb: Initialize base_clk to NULL in sdhci_brcmstb_probe()
Date: Mon, 24 Mar 2025 16:46:37 -0400
Message-Id: <20250324204639.17505-2-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250324204639.17505-1-kamal.dasu@broadcom.com>
References: <2025032414-unsheathe-greedily-1d17@gregkh>
 <20250324204639.17505-1-kamal.dasu@broadcom.com>
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


