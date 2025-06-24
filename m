Return-Path: <stable+bounces-158378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A48EAE6358
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 13:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62C723A91EE
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 11:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFA6289E1B;
	Tue, 24 Jun 2025 11:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ITI77JqV"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B91221F17
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 11:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750763411; cv=none; b=nzf0Q0NUIfWu1pI8irlzAwpAvBZIYviLGDOmIYX6nlXhgJLijZx1WztTb4UwDZ+RSLWmvhOBNbFqTUVQRszsajr2X927+zzMOhcl4W5d1hiLEkR5CKH8UPam8KhNEBuYj83jrEpeZeTDYmZTCPnlIEG4NXzSE7kdpbHXwCM9GWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750763411; c=relaxed/simple;
	bh=z4rJtnFF30lqR3jrDEtJ16ql7i973YYLkV6fm+6rt/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rz2q3gR+xhhKUtkrUrmlPXPlBbKwRqKSl3JElpm+0KW87KIQQF4hIOkJ+4eFRElusOOIEehLJekIur9XLtE80ioONGFTCRFf4bq7UqxX2vmLoK6W0cPdOecCwOaPe+Kysk4eSqwHim7GxviQjcpOlugFcNgCNx+caDAHuLZzmsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ITI77JqV; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-553b16a0e38so312890e87.1
        for <stable@vger.kernel.org>; Tue, 24 Jun 2025 04:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750763407; x=1751368207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5t54NOu9eJMfewpsFMkasSGMJUYUFumjVVb6dnB5QGU=;
        b=ITI77JqV+600vjMciOQiN59nbadMg1SrrkoLGwbKaTEuxwVDMEXD0X0NlnUAOPsr6F
         ccsJtIN0ECT50kl+PaypIgQKKLfIk8oX2DGXOuFZxnqwdL5kBSXS+rXl4UN5bkOK8qtu
         P3z+DmpWA+1PMdG+eEocV1oBGAZn0BOv64NcbBmgtFil8Xb0EMaWKy0JMuECzlcZvvxA
         xvxrFhRfR+srfDnTxWSOogsTDswMJP8Y3jcgYD/c2ppUh/teMi+k7lgdCZFyZafPyaty
         yGuVy062N4d1mmlPPL8x1dIk5USMdk47eZHnJJygOfigJ6lpfuKowdjtvCT3wRx555S2
         lp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750763407; x=1751368207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5t54NOu9eJMfewpsFMkasSGMJUYUFumjVVb6dnB5QGU=;
        b=ZtYxkZ6EQRvZnrHzw1e0LgnwaB6O68VjSh99aNm2ozgN4a/vrQ5pFFFQyA0DU5WAcF
         1na/x1f2/JN5GUKUgQc/Bh2/6Jex4EhAKHa0S1teUjA+li+eZq1ZkADsx5qOiD+SF2HX
         OX07TdC/cjRA9/uKYLRYVtcYgnZ3ruEIy5wxshhPmINY7+xnWZwV8Mzs2TG6sL2L+KeW
         o38/rbNyhaQEisjUZNtKMFrcF6gVRM5Guh3akoj6dGO9/89cWS1joK88SKqRjUYqh6Hb
         P485fzST0Vrh9gktqGsovRTh/LCR+rwWrlGb8upRN1wUYklRDkYv7hFNQTE+IBxdUIMQ
         OQAg==
X-Forwarded-Encrypted: i=1; AJvYcCWm3vnhWG7ZA5VICiIMWeQ1ZpSahVN4AdLEtuNictO7jwhGzuD7+bmlFfeYN6f4F6tnC4dk5To=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyVAZP74MHa69FIaEIJ8Ndnbw95y0bI0styr48+36EDXlMp0Ex
	jQ63G913sBXWExx489Tk5Hjlze9gvasxGXbs1JaZDpyndacJlFyavHR1kgIOfNhUkPk=
X-Gm-Gg: ASbGncukHXQvDMay8xZIl3y0a52bbGjRSe7Mc7AGW1JV3bae8WKnHsgE06oQR8L3lYn
	xMoo7kR51R8c8pbANMVGxlZhJR0lFVJimxpCvYEwI1PypDpd0HvFEW41mCwLMaTMPcAGAIx/8pM
	Goa+Vnn4SC51or3olMier+sWuID+adPTVHh96IuEGyyVkV2U3vNtsoUB+6ryl7MUdv1C4qj/fcG
	n4DpJk5sAhOOXR0EOIR9GY9UHTFn+0W/RHRua4ke0XBVzIEV6DoKrOPyHGM6gQwn3h2UKgfGM2G
	Ob8HuNGMqTlyrk4ZE2Ny8jO29QG3cQw8oDbO+ogyhr2k+pEBwz9DnR9OBc/VyOH88QW/16/r7fA
	HTBXDm8PZt2HYDJuRoRD0IVzlMJoay6YmVyP2
X-Google-Smtp-Source: AGHT+IENbLN83OkH03hyG1yobNT45Foc2hr2LQyAWmtZ5swCAZoTpbyCfwqy+Q3f5C109deHitMiZA==
X-Received: by 2002:a05:6512:3e04:b0:553:30fc:cee4 with SMTP id 2adb3069b0e04-553e3d1d8bfmr4582281e87.49.1750763406612;
        Tue, 24 Jun 2025 04:10:06 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553e41bbd9dsm1791204e87.105.2025.06.24.04.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 04:10:05 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	Erick Shepherd <erick.shepherd@ni.com>,
	stable@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jonathan Liu <net147@gmail.com>,
	Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH] Revert "mmc: sdhci: Disable SD card clock before changing parameters"
Date: Tue, 24 Jun 2025 13:09:32 +0200
Message-ID: <20250624110932.176925-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It has turned out the trying to strictly conform to the SDHCI specification
is causing problems. Let's revert and start over.

This reverts commit fb3bbc46c94f261b6156ee863c1b06c84cf157dc.

Cc: Erick Shepherd <erick.shepherd@ni.com>
Cc: stable@vger.kernel.org
Fixes: fb3bbc46c94f ("mmc: sdhci: Disable SD card clock before changing parameters")
Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Reported-by: Jonathan Liu <net147@gmail.com>
Reported-by: Salvatore Bonaccorso <carnil@debian.org>
Closes: https://bugs.debian.org/1108065
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 4c6c2cc93c41..3a17821efa5c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2065,15 +2065,10 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	host->mmc->actual_clock = 0;
 
-	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
-	if (clk & SDHCI_CLOCK_CARD_EN)
-		sdhci_writew(host, clk & ~SDHCI_CLOCK_CARD_EN,
-			SDHCI_CLOCK_CONTROL);
+	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
 
-	if (clock == 0) {
-		sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
+	if (clock == 0)
 		return;
-	}
 
 	clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
 	sdhci_enable_clk(host, clk);
-- 
2.43.0


