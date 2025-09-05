Return-Path: <stable+bounces-177788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AD8B450BE
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 10:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440C01C20F8A
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 08:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6D1308F17;
	Fri,  5 Sep 2025 08:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRS5bqGr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D5B307AFD;
	Fri,  5 Sep 2025 08:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757059248; cv=none; b=Qs8KfMIy4WjW6WftH0tAZVwS+pcgJuAM99NGOdoOlVeSqcjnlkFdsVWlzxMUHhi4Zqyn7joxpu9nZNEjWRn1sXsoyDnVwKjthrcIJiX8SmWU+me/zAYyIU/kX6ZvVDsJpFAMq2lt++8OeByGVfHj0jk4Qrhaydj5CwTIJ7UKorU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757059248; c=relaxed/simple;
	bh=vACb045QkIDhZiJ/eUdfWeAu7UePhs1aiEPZxg+4yi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pCUW5N9FdWhIj8rqPo9M2K/ldNDTW4aYtIRFKhYW7AnaBrYhIcIBX/O7KGx8FqQcSw8TBb92wH/t8QClYNUDxnS9tU9GvB/WP8aQYN4B6J3t1ScxPwFkBgD3qHlAeN9diGClbuFL6Wj1g2bi4ib7GjompT6I1L370ynIFcGa/2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRS5bqGr; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24cbd9d9f09so24886425ad.2;
        Fri, 05 Sep 2025 01:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757059246; x=1757664046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=197N926JqxKxoYCk7QivC9r+n93Tl38dys0FCD1AK5A=;
        b=HRS5bqGrdu5jmcxpZC/0XCrMr0iu5sNo065Gn+3aY8wDlffUb0YR46ZyZHErZVYSZY
         Xna2TmHUjQL3PyqJV+0IYHHmDAwxp/pLsaONOpa20duZMC4Cu5InUGYuIECXSgX/21Yy
         43KKu8g5Xwfghm6Y4vcnztnqanwrglnlA0hflVA05fW37Gj5NKoI9GwD1QKsmUgrSNSX
         fLECAmwhBR5i4kiBE1xSex36cBuZn8cd3VkVzcX8JmQjPC8TCVPkr1ucRpIOM0FVGI5m
         uGNhz0YzwQJS9GhGNiDOqx08vxuv2OuKh5YWVdA9D1EXkWi2dbNtbG6hg8OZuBez7goV
         twRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757059246; x=1757664046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=197N926JqxKxoYCk7QivC9r+n93Tl38dys0FCD1AK5A=;
        b=vRmpPkH/pmcPsr9uLNqKAVh3zmeUbrgG/TA3qK2m7sITYCD5FftpJ56HZvdMBh+zBl
         v+weJnW5cw8h0kyeZh0M5PY2rIDss/QZBMu+YRs3Dm1G4is4wg2D6WuVyXyFrn1VZ/75
         RxXvLTTsZaueDliwZdggQSz21rdPK7BCe/IxsOIJ+IkOEr/mKgRjWJXrBpF/A7q+Q282
         s5o7b1ki5pFUjelpF+OoXyGqfrXMl3AUNQm3ATnC+jYL28dceybtCYGZfdDGgMs7AI5d
         MfaWkRxa9wtAuozy1HRBlv9bXUyxO2jK6q4TcovGuTLDTCEu4OmiKio2Krlnx0lyHdU5
         Esog==
X-Forwarded-Encrypted: i=1; AJvYcCVAg2ysVksvvh0ojbyjQw+zWLjqvMwi5K1Ep92y9TWev59cSUZzcBo7YS8AnK3tNhOaXfe/ITw1+QnCkIk=@vger.kernel.org, AJvYcCX/ZtCmH5lNlhKmzPGHWlnse1hsFmf4f3M0Ugji/6zTe8V5pPAifiOEbMNvhvzfG6s2lyLY30Zg2el9@vger.kernel.org, AJvYcCX68LNHYVFHVaw++tMes71rD6BM6lyHmbN1mLKB1pBh/zDtiUIHgZPOSBT/jYzHXymarJ+OwB1Q@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq8xiUeSV4RYAVbDWPfjlvdJtoBL4ywg4QCqxFTEI+8VVg6z0N
	hPVYRX6qKTGlTzw6d/5dJqznr+uTJA6AFSbX+dYQhDsYeTBs57oAMsOw
X-Gm-Gg: ASbGncsbxnF8Cy/1uzXCCA16weOaBGvOBQ9APjXazdijnd+sdyXmkASwsLvU64aZHsU
	n8HCJunTv9ERtSHwH+58FQFEhNPyW+hvz0v8GiUVA/odCmxN3rGu13Kb5SpagH37DEi/U9A6So0
	vo2Jc3houZpattGvXsLt2rZrY509fAxjYzLIUcQVH604axXHfXqtJKJtPxFeKfYOuVZtGzwjUNL
	oB9GX+W5pGdADJhXu/50D7uWQYN2l458dMIS5HG7Xq2nrpjXHA2KdwVliQ7xhrjwdMHmNjt1Rnn
	L+r7ghTQ66y8sEIu2lerKofPYPm0vkdOIwbHAzCwCBLG3uHjuNP6BMZUdLHvvQdTbrwzVFtf0zP
	VuVHtV+nK+S/5NAq3AglpaNWV2zryla15lwdXgHYuNcmzkbaXQs3hHC7QLbktkmVwJmaFizEr6d
	gMliIvEJR3YaAlA1DAEs/JCt8dnjZ0
X-Google-Smtp-Source: AGHT+IEAAeZxluRJAwDrScg9wcdhKdRd9iBWcsaHf/WV0ErTxMECs7TLt8THiqcOOq6Vlk5JPNE79w==
X-Received: by 2002:a17:903:41d0:b0:23f:e869:9a25 with SMTP id d9443c01a7336-24944acf3b2mr265423835ad.44.1757059246213;
        Fri, 05 Sep 2025 01:00:46 -0700 (PDT)
Received: from arch-pc.genesyslogic.com.tw (60-251-58-169.hinet-ip.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276fcd6232sm27910926a91.16.2025.09.05.01.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 01:00:45 -0700 (PDT)
From: Ben Chuang <benchuanggli@gmail.com>
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org
Cc: victor.shih@genesyslogic.com.tw,
	ben.chuang@genesyslogic.com.tw,
	HL.Liu@genesyslogic.com.tw,
	SeanHY.Chen@genesyslogic.com.tw,
	benchuanggli@gmail.com,
	victorshihgli@gmail.com,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/3] mmc: sdhci-uhs2: Fix calling incorrect sdhci_set_clock() function
Date: Fri,  5 Sep 2025 16:00:35 +0800
Message-ID: <a9fdc8f66a2d928cf83a3a050e5bdb7aff4d40db.1757056421.git.benchuanggli@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <8772b633bd936791c2adcfbc1e161a37305a8b08.1757056421.git.benchuanggli@gmail.com>
References: <8772b633bd936791c2adcfbc1e161a37305a8b08.1757056421.git.benchuanggli@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Fix calling incorrect sdhci_set_clock() in __sdhci_uhs2_set_ios() when the
vendor defines its own sdhci_set_clock().

Fixes: 10c8298a052b ("mmc: sdhci-uhs2: add set_ios()")
Cc: stable@vger.kernel.org # v6.13+
Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
---
v2:
 * remove the "if (host->ops->set_clock)" statement
 * add "host->clock = ios->clock;"

v1:
 * https://lore.kernel.org/all/20250901094046.3903-1-benchuanggli@gmail.com/
---
 drivers/mmc/host/sdhci-uhs2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 0efeb9d0c376..c459a08d01da 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -295,7 +295,8 @@ static void __sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	else
 		sdhci_uhs2_set_power(host, ios->power_mode, ios->vdd);
 
-	sdhci_set_clock(host, host->clock);
+	host->ops->set_clock(host, ios->clock);
+	host->clock = ios->clock;
 }
 
 static int sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
-- 
2.51.0


