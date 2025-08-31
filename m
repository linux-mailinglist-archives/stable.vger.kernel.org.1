Return-Path: <stable+bounces-176753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82846B3D292
	for <lists+stable@lfdr.de>; Sun, 31 Aug 2025 13:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF47D189E26F
	for <lists+stable@lfdr.de>; Sun, 31 Aug 2025 11:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD2A25B31C;
	Sun, 31 Aug 2025 11:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5lA8PrT"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D18F258EE2;
	Sun, 31 Aug 2025 11:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756640197; cv=none; b=ckBWQv1hAF196O0cisD/7Vzy1nXUqb/JfNJg5zJ9Zeb8XrUdiTVF7Mj3abthtNPnOjpe1BUFE0GuKqRpUqHgFjnTkWqnagX/M2DCS34gxmsHVGPpv4JC0KhnyCNNWarWO/sCX4uf5TEFUix9VOZGgH8be5f6LFWHPoPOTl5Jw7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756640197; c=relaxed/simple;
	bh=NZAHdt9F5rXzmbN5Hw/0e1pggZILf7NjvtYrLHqHZzg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Oa5CL+BjCALLPJFaJteHu9mTfOjeIpo2PHkqFdygLM4mw+5BgeOJ1vFuQsm4moXyrlBYf1LslQpv1uJNCfFFrB80BcNk524hrqmIgFe1qD73uP3lReGPKpE9oApg0nKHoFSZy01SrB56wox/S1nibMFSXdCRMuMbH5okQfgze0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5lA8PrT; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-70dd5de762cso27711326d6.1;
        Sun, 31 Aug 2025 04:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756640195; x=1757244995; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UX2JSAZgj2wBU/RFTeov5tRZASF8EFkjg2DWvmdKZ/0=;
        b=U5lA8PrTZanD64DWq9JBet4lHimqKy9Juo979tdxFZC7JNo+GdxxeGy35sj2f9/j5n
         THR0iayW0PoQwBkwqx6azkezFl3s10vtqh7IuiS76zSXixY3EVybuOpS1wQ45ITrYxgj
         uTnPOF4XSSRG8XM91PtygsHn+lSGC9iFyZFmXxSGFz/HfAgqjIiRJKY9tZ6N+Vhh5EhU
         n8Klurc6rKBrpbhxxttExmGUGMabO085xJELd+2iwsI7ZsIpIGIjgn8hI/+mELMhoE1U
         r6O0Cn/dyP9JnOVY+0N/k5dYEqGJwWRrldBEaqm/9vcejFDibkJ26RGYX46QXabFwBSM
         WKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756640195; x=1757244995;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UX2JSAZgj2wBU/RFTeov5tRZASF8EFkjg2DWvmdKZ/0=;
        b=UgmMcegqx+OGLGoSgf3vSoVgoihKJER3ofYXkKvY0L28NaAR+TrbUFkrnZSzM2x90l
         yOEL0HRVzkvTrKxa0fcSv8HzDPw3Q6zs81iBhCq5hDnpUpzTQSxnA0nFoQgLYB3kfdV2
         KepOs1pz1iGmv9isD2audnlHnoXTq50oWX0PchVTLbobr2wjH+s8UBPcz5YKM1INw1mi
         SQWPEQYkg7XVVpAEsAV/AM3cCCYXugjYcMGmvGXRqc4z8MWQEgcNQZdn07u/Ybh3Xh4K
         dZL5SK858ry+B0FnWg9L2jGtZNqAQ8SjoAS1oFh05Y8ARpj75gztFvvwyg3gxfwn0qir
         NuOQ==
X-Forwarded-Encrypted: i=1; AJvYcCV54QxMRkWWPchgPFoOGxPWhfmqg5NAH8QWndjKK9AGbelhpuejfRYOqo5d3e00+Q5TC8Q2jHgo@vger.kernel.org, AJvYcCX/X83XIjOs4Sct5ACx6T6LAouQcMXsuCTb/+Jm/6HFPROj/3FO6jME3Bq1MtlD0TkyI4DTEwLEgLq0@vger.kernel.org, AJvYcCX9uEz+me71NoeOsWW26s6STgqDhlJoBPLZ5uaZZvbHBKfmnM9uZ7aG5bw8iLFh1vQrD8r72jhzJyr4@vger.kernel.org, AJvYcCXnETHEuFKv9QepAgqeP7uLdwG8A6cQjrLMI9UkmtXnKmL9TuY6jxSw3sRd7FzaR+/E6xRL08tWsa1M7yGE@vger.kernel.org
X-Gm-Message-State: AOJu0YzhH/1bzOn7VItfjUvIE9p/bsKNUIjEuVsPJ8jWdbPwFaj6NAiu
	mO85z/ux0e5u8wFNcA4g8X4x/1u0A5/thf0ISHtVq/ZKvPSLigQU29+o
X-Gm-Gg: ASbGncuPwTyMpiw/WtHVaiZiXBzpr5Eq8zzk0kB7Qm9TJd7wwnrXyLgXi7maeb/W27G
	ulk0n8Vy8jJxYJk7RABVvJMWC0werLTOd10VFRd3YSIkpXwzld5grfTEyzRx82d3m5u+jvMHwkq
	g2f3IM07fNPMZzXYC3YR5OtRwBrvY3X0MQWN+9WT+pX2FLIWYUa/W+nlyk+YROSLtXjvwbIU4By
	ALrrxaVu1O2kytYwNFZBBynu1kSkKgzTGd03x8JG2jPUHUQ19DxCuUn7dvXHmWoMHKdqJq22evJ
	13dzC5x1ytcn0gxPbdI2CTKATvOtUtZfQTi1TSJctBBEPT98TmGV2wA9x2JnsRch/NVH5u12lEo
	VNlrJg5EELQhrUM6LdwbOFN0sYlPcawMk3PSBzSdf4Q==
X-Google-Smtp-Source: AGHT+IHTkP26xog0yMNm3B+SwhBdAjr8QJEF3EYmYKgDrxr8Gok7j2NB8tDWQTeOuXHpveiVGhgqjA==
X-Received: by 2002:a05:6214:76e:b0:713:12c3:9fae with SMTP id 6a1803df08f44-71312c3a291mr22891676d6.8.1756640194865;
        Sun, 31 Aug 2025 04:36:34 -0700 (PDT)
Received: from [127.0.0.1] ([135.237.130.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70fb28383b9sm20519076d6.37.2025.08.31.04.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 04:36:34 -0700 (PDT)
From: Denzeel Oliva <wachiturroxd150@gmail.com>
Date: Sun, 31 Aug 2025 11:36:28 +0000
Subject: [PATCH 3/3] clk: samsung: exynos990: Add missing USB clock
 registers to HSI0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250831-usb-v1-3-02ec5ea50627@gmail.com>
References: <20250831-usb-v1-0-02ec5ea50627@gmail.com>
In-Reply-To: <20250831-usb-v1-0-02ec5ea50627@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Denzeel Oliva <wachiturroxd150@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756640191; l=1291;
 i=wachiturroxd150@gmail.com; s=20250831; h=from:subject:message-id;
 bh=NZAHdt9F5rXzmbN5Hw/0e1pggZILf7NjvtYrLHqHZzg=;
 b=N74W6zP61WXE3Sp8sdVokQOqEkn6v08RPGvUJjdp9ga8f8gznDsm6utDRnqmMuQ09GG3+2yM8
 u/VQPgqm0VqDiWMIupNJCxHf79sZFuFwKm48ns1pYGgnmsKOTJNWwC3
X-Developer-Key: i=wachiturroxd150@gmail.com; a=ed25519;
 pk=3fZmF8+BzoNPhZuzL19/BkBXzCDwLBPlLqQYILU0U5k=

These registers are required for proper USB operation and were omitted
in the initial clock controller setup.

Fixes: bdd03ebf721f ("clk: samsung: Introduce Exynos990 clock controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Denzeel Oliva <wachiturroxd150@gmail.com>
---
 drivers/clk/samsung/clk-exynos990.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos990.c b/drivers/clk/samsung/clk-exynos990.c
index 7884354d612c54039289fa9b80ad08f34b9b7029..47a1e0850c3020ab66931ae0c5ac4920f41496d0 100644
--- a/drivers/clk/samsung/clk-exynos990.c
+++ b/drivers/clk/samsung/clk-exynos990.c
@@ -1224,6 +1224,8 @@ static const unsigned long hsi0_clk_regs[] __initconst = {
 	CLK_CON_GAT_GOUT_BLK_HSI0_UID_SYSMMU_USB_IPCLKPORT_CLK_S2,
 	CLK_CON_GAT_GOUT_BLK_HSI0_UID_SYSREG_HSI0_IPCLKPORT_PCLK,
 	CLK_CON_GAT_GOUT_BLK_HSI0_UID_USB31DRD_IPCLKPORT_ACLK_PHYCTRL,
+	CLK_CON_GAT_GOUT_BLK_HSI0_UID_USB31DRD_IPCLKPORT_I_USB31DRD_REF_CLK_40,
+	CLK_CON_GAT_GOUT_BLK_HSI0_UID_USB31DRD_IPCLKPORT_I_USBDPPHY_REF_SOC_PLL,
 	CLK_CON_GAT_GOUT_BLK_HSI0_UID_USB31DRD_IPCLKPORT_I_USBDPPHY_SCL_APB_PCLK,
 	CLK_CON_GAT_GOUT_BLK_HSI0_UID_USB31DRD_IPCLKPORT_I_USBPCS_APB_CLK,
 	CLK_CON_GAT_GOUT_BLK_HSI0_UID_USB31DRD_IPCLKPORT_BUS_CLK_EARLY,

-- 
2.50.1


