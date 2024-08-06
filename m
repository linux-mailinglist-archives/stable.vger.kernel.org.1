Return-Path: <stable+bounces-65484-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15258948ED2
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 14:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C38B328B8D5
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 12:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0121C8238;
	Tue,  6 Aug 2024 12:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1tJDbWH"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09801C7B85;
	Tue,  6 Aug 2024 12:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722946298; cv=none; b=vGrzvvXv+ipif//VCVZ53zPpWfg+SvmMv4vV+8At1BPvuTFORyurNv6HbqyCpqBj3y6PusAXO1Qjc+Yjed3P9357UeRn0ICrpr7UrZh8BhmB0+RjJGvp9DrimY3P/1tz6XDy/QkmBPiNuoxMv85F2bZsFswc5vkvu4pc+fC2mMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722946298; c=relaxed/simple;
	bh=yZCPxec+Nt05+vFpfuZAEIwPsSYT72gElqKmIsVcVcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hoeNv0qBGvo2/v7BhOVZo+87nAdfdbzB/BVBldS0kGdLW7lZYnQxY0Z2hhE5+JoTVKCU6E7XgLDgdlz/tpibGXNd10V7zZTSI1JFvus6GuDfMZrtR9ddiq40Q+9oqhCIaeRQD0BrEV/U+wGY90WyKIzDBpT98Hza0yTtysWOD2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1tJDbWH; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7d89bb07e7so62099566b.3;
        Tue, 06 Aug 2024 05:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722946295; x=1723551095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0aRz/NvzMoGMcs/X68qWsjTCXJVKjTHjK/Kr5hohQg=;
        b=T1tJDbWHdi2cFDidBSlo6wc+Pln3/aWY51Um+tAzq7GRDzfB5Ze5hVk3p0vPq27Mo7
         TtpC9gJXx8qRCUzvBcf2I+DN3TwGS2wSHlBddUpgoyFlTTRJQ3wk/FGtFwYJ2qKzYOzY
         ngh+2G3SwBOjwsBHK1v4S/tEnooQOZyzAQIIv5dMfY0nao7y1+h+0U+IdzaG9pBsEq7U
         1+oFp8nTUSSBSwIdgOd6XyRiQYTxjnKxvCGT7+qapB7QJubxFIMEX6PIJdXMkO1EbhyQ
         GdMW3q+cP37deDDGbqcB46NlmWaVdAyocJ4xW98cuLMoopLCOqHfh79lDXYU2XTgzDSm
         PnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722946295; x=1723551095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0aRz/NvzMoGMcs/X68qWsjTCXJVKjTHjK/Kr5hohQg=;
        b=Rem72XxpD6J2U3F/MMzLwnurpNfrQQeancxd4pOxscFN/r8xz51DLLhnUQL71zg4l8
         IuhU1N82OVExKNPUDKSRpsp9EVvcdWpVUUzsuIYJLAyGAYptqbnb0sEaS6iIwZ4o0U1I
         0HhMUKcvWX6u+ASYa7k4F5Xact5SKDcgW9eR8rnWSzleM1HPpOEuVBCwPhOraXbObyJP
         mC7Qg/EUDl8f7K7eNpm4fU/H2fvBy5sMaEZCuIimqGKgH5BVeC+U4HG/B5Qt/tefPZmZ
         RZdTuXrm+o4WquUdbHJFp/iCecB89FP9wbpO1IhyT6nAROr5C+7W11wvnRkGiICD/F9s
         Y7BA==
X-Forwarded-Encrypted: i=1; AJvYcCVpHA/x4gOIm1MQ0OrvsXXzQjZe6A//gSVmHZFXuqhGeErMbuMLulP+obTNp94+DhQDbKkOlV1VeFtOjWUcBnpFNmW9YNE/zhXtI5hrwnON7nSdVMWzA78ol6znFRjr85UrmjQYWSLjHisw1dVK9VUxTm2YLbY46eVlWJ7Nvn4KHD/4gSBJvmE8jofYLSUugrm2hWcVaW1NGwNj3IOZzwpP/DPruc2Z
X-Gm-Message-State: AOJu0Yx6H/tsBIUrJ7BB8MfxrYbJbfvv2See7aTLv9Jm15oNLaTuq8tq
	Tgn8qL8277OhSc4Pwh9ZidBxf0IWULAWLxcE2lZM/M1Ru1tWXTVT
X-Google-Smtp-Source: AGHT+IE1jURrKaQSilbk7NTpniLbZ+h6z1PD5RRA56U41hrhim0QfQbdfC/eEjpHZUkMW++bMWlMXA==
X-Received: by 2002:a17:907:a01:b0:a7a:b73f:7583 with SMTP id a640c23a62f3a-a7dc4da5044mr1158998766b.6.1722946294708;
        Tue, 06 Aug 2024 05:11:34 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:3711:c80:e7a7:e025:f1a5:ef78])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a7dc9ecb546sm542080366b.224.2024.08.06.05.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 05:11:34 -0700 (PDT)
From: David Virag <virag.david003@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Virag <virag.david003@gmail.com>
Cc: stable@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 4/7] clk: samsung: exynos7885: Update CLKS_NR_FSYS after bindings fix
Date: Tue,  6 Aug 2024 14:11:47 +0200
Message-ID: <20240806121157.479212-5-virag.david003@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240806121157.479212-1-virag.david003@gmail.com>
References: <20240806121157.479212-1-virag.david003@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update CLKS_NR_FSYS to the proper value after a fix in DT bindings.
This should always be the last clock in a CMU + 1.

Fixes: cd268e309c29 ("dt-bindings: clock: Add bindings for Exynos7885 CMU_FSYS")
Cc: stable@vger.kernel.org
Signed-off-by: David Virag <virag.david003@gmail.com>
---
 drivers/clk/samsung/clk-exynos7885.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos7885.c b/drivers/clk/samsung/clk-exynos7885.c
index f7d7427a558b..87387d4cbf48 100644
--- a/drivers/clk/samsung/clk-exynos7885.c
+++ b/drivers/clk/samsung/clk-exynos7885.c
@@ -20,7 +20,7 @@
 #define CLKS_NR_TOP			(CLK_GOUT_FSYS_USB30DRD + 1)
 #define CLKS_NR_CORE			(CLK_GOUT_TREX_P_CORE_PCLK_P_CORE + 1)
 #define CLKS_NR_PERI			(CLK_GOUT_WDT1_PCLK + 1)
-#define CLKS_NR_FSYS			(CLK_GOUT_MMC_SDIO_SDCLKIN + 1)
+#define CLKS_NR_FSYS			(CLK_MOUT_FSYS_USB30DRD_USER + 1)
 
 /* ---- CMU_TOP ------------------------------------------------------------- */
 
-- 
2.46.0


