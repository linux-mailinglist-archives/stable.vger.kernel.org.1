Return-Path: <stable+bounces-71456-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCE79639DC
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 07:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A69701C23E7D
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 05:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A25132124;
	Thu, 29 Aug 2024 05:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJYoiEcc"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E213DDA6;
	Thu, 29 Aug 2024 05:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724909358; cv=none; b=VAirJe+Iu962MkCJ4beOF/E1ofK1oM/2adrl9SzH4BpgMHWSJxIOcvi9DnWzMJa+LZwcZ2atkEMud666W2QFDUEbHFzXp8nKPPpg7A2fdATlfZxPELpNgfDwGRWaZ67vQ1XNqZx1nKDujfOnf2jfYFHAknu1oHvgQJYT0ZZsS48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724909358; c=relaxed/simple;
	bh=JQwWjcraaDidX6aHumdCYM4MQqKSDmv9WIa0JDUajfo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DvpXyAqfQiCnxzwnW2hppVq3G6c1Jq+sKH3sDmarkNBkVGhoyOfaEj6GWiTAeBfmmuTZTYyX+7Qd6eanQysJAQIpl83kMBjpNBwC4u2UMuXRBZyU4Qc7BVe5pB6eOOaF6OQMI/4bLlkeQXMxnPN5uRtMMK62Lrb+wioXI+b8r04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJYoiEcc; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f3f07ac2dcso2573331fa.2;
        Wed, 28 Aug 2024 22:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724909354; x=1725514154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dRiNn71AXYlTP0EHfd7F7GiG1wbLGjDdP4bC5eKVZx8=;
        b=CJYoiEcc7lAP9cAv23fsgWMrK6AxygyTh5GRN3meknybw3adLEM40LWaQlGqqw/LiG
         1zsgi0fdFOPFqN5UfaqsBsK0gPTsouzzwMSdeJdf8b/CEVXDyYITIFQ7F0RwEvAvtrXj
         9tvGIV1s+ZEbf8d71BuHLjnd29NZuiX49LTnyIp1Q59JPM+4o5ngodWvPccnY8gPjx73
         RGmtlwvjYdz99Z3rymq7EXnZd7Rtei8EcbGM8m0mf/EwZ8pBCKn6tBSJHMUROmyzIzMP
         hYQOtaJDEJ4RQHHE3ZaZiJ7Yk8+wUjePhmsu1b6L70GRKZEZUnptCJon8lQ2GtrQulds
         uNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724909354; x=1725514154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dRiNn71AXYlTP0EHfd7F7GiG1wbLGjDdP4bC5eKVZx8=;
        b=uOBGDIujK9iXZnck2XraY2CUAU81JkINboi9NKEPd5iWqvV/is1zTuJYEx0DvLvI8f
         hJ9Y9S1gc5VXHgKR7acBjClqtBn9L/3MiQbrm8ES1aE+0tRCRXkew007U+gh7fxYkRH/
         Ii/dWrxwviWyQJMHtwWLGo8rFqsUaiJjYqyxzvbJFcmfXoy21+49a8ekfhcG3iScsKDP
         iGE9tAazAQ3BkQiC7Zdm5v7yR/zeG1NtU3os7Nvr/oMKD8GosUYjfLt2m7oJY+GcvwDP
         ioVFtMoBczogvEy9+538XpsKrbYPcLsv1+EU+s0f8pdicYxG5dBm5yjxa2tbpAxe+sIM
         fYdA==
X-Forwarded-Encrypted: i=1; AJvYcCWrFiEipFlpl1MYnA4ZVg8XaAQj9K+790wtW/5noeEvau/xkWee4L6PLGgX0WHOOoONkx1Opcr4@vger.kernel.org, AJvYcCXAvR8XC9v0MLmNt2u3YC98NNg8+yOvqhr3zYTjRMgURr57sztE74RLmDMO5JF+cBngtqI5l/OkmkM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3yZHasyz79Xixe1gW6sW5Fs2rX2vnPDel8/ytmPcBg1DARjXy
	rBDJzJFGjcrZWFSy1cZ+Mi7/tan20kiaVKwyh10BF3mC584N+Lsd
X-Google-Smtp-Source: AGHT+IE0ceBLba7nEA67Qlfy7jSL7y109zrmqgKYUx0DdBoUpfpwOTeJaqrDey2Clmx2ftpzBo0Kbw==
X-Received: by 2002:a2e:612:0:b0:2f4:510:10c9 with SMTP id 38308e7fff4ca-2f6104f27e8mr9410811fa.37.1724909353594;
        Wed, 28 Aug 2024 22:29:13 -0700 (PDT)
Received: from localhost.localdomain ([188.243.23.53])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f614ed1465sm836141fa.15.2024.08.28.22.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 22:29:13 -0700 (PDT)
From: Alexander Shiyan <eagle.alexander923@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org,
	Alexander Shiyan <eagle.alexander923@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>
Subject: [PATCH v2] clk: rockchip: clk-rk3588: Fix 32k clock name for pmu_24m_32k_100m_src_p
Date: Thu, 29 Aug 2024 08:28:20 +0300
Message-Id: <20240829052820.3604-1-eagle.alexander923@gmail.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 32kHz input clock is named "xin32k" in the driver,
so the name "32k" appears to be a typo in this case. Lets fix this.

Signed-off-by: Alexander Shiyan <eagle.alexander923@gmail.com>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Fixes: f1c506d152ff ("clk: rockchip: add clock controller for the RK3588")
---
 drivers/clk/rockchip/clk-rk3588.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3588.c b/drivers/clk/rockchip/clk-rk3588.c
index b30279a96dc8..3027379f2fdd 100644
--- a/drivers/clk/rockchip/clk-rk3588.c
+++ b/drivers/clk/rockchip/clk-rk3588.c
@@ -526,7 +526,7 @@ PNAME(pmu_200m_100m_p)			= { "clk_pmu1_200m_src", "clk_pmu1_100m_src" };
 PNAME(pmu_300m_24m_p)			= { "clk_300m_src", "xin24m" };
 PNAME(pmu_400m_24m_p)			= { "clk_400m_src", "xin24m" };
 PNAME(pmu_100m_50m_24m_src_p)		= { "clk_pmu1_100m_src", "clk_pmu1_50m_src", "xin24m" };
-PNAME(pmu_24m_32k_100m_src_p)		= { "xin24m", "32k", "clk_pmu1_100m_src" };
+PNAME(pmu_24m_32k_100m_src_p)		= { "xin24m", "xin32k", "clk_pmu1_100m_src" };
 PNAME(hclk_pmu1_root_p)			= { "clk_pmu1_200m_src", "clk_pmu1_100m_src", "clk_pmu1_50m_src", "xin24m" };
 PNAME(hclk_pmu_cm0_root_p)		= { "clk_pmu1_400m_src", "clk_pmu1_200m_src", "clk_pmu1_100m_src", "xin24m" };
 PNAME(mclk_pdm0_p)			= { "clk_pmu1_300m_src", "clk_pmu1_200m_src" };
-- 
2.39.1


