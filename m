Return-Path: <stable+bounces-65483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEC7948EC4
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 14:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0009D1F2333E
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 12:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DDA1C68A6;
	Tue,  6 Aug 2024 12:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVKkKDNz"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028B71C6891;
	Tue,  6 Aug 2024 12:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722946293; cv=none; b=Y2SCnU1hDhsVcHXtu78z/swPdOnNiyEuC9xQH4Kmvafy+1uJ9dhloltDRvWj7X65K2s5zxjGH1oNerEOzLOVpC0mg6sfBNL4IQHCGCABuWQdQECFW3FHUS39XXeTN4OMXTGXDm5K/n0J59aQGwmIjupFa6Fg1NvbwHn9AWbFOOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722946293; c=relaxed/simple;
	bh=7GiRoGmJLDErspUscRFHW3SVsSvcjaniCprxhr2WmLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SW+ZTLv8IMiZILJzmDZDdDLupdXW11jb8wxnqpiJuOPAA+kalzdPjXRDomSKpAk2Fz9w6dW7pX0yQiD3ONVQH1MAfepf5xz3EJZdxj0CL6UYQYkEfmqgdje1/R921Uvm9TiuGNYvFvd7iIxetXKDqhM9Y/K+If/5EwDhStWZisI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVKkKDNz; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52efd08e6d9so1028027e87.1;
        Tue, 06 Aug 2024 05:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722946290; x=1723551090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjHC3HTfFfqBvl70BeunbeIG1gwZ0SxmbRT6QMGAa/Y=;
        b=hVKkKDNzjV1b4TPsjAd/L/biVpe48GBZ5hKoV+Vl5dE2ktqPGburD/N+arc/8puizO
         OvUSDP5KXj+roNNwDpDiRtPvZ4yLLZTUy9x+jYM5+MAuuR0v+iuveUi9Q2GtVAuyATGY
         e9+xjRF7zVn3HJGrnwdtIOlIAJ0qSq4o38VtSOCWLhsNVXhN240Z1Q8VJLcZEpglTb+B
         uJhBOj3o420SmLnep1bl4kQsmhs5UmchOswj2dhvUy8u4dviYjCGpcKhgCBRXF+mBceG
         dNaF292i4hdcWIdjtOJaP+eMnydX++ggEU6IqlcpcHa3GOVXUnb+kGoiP7/VukCFFMcD
         6V6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722946290; x=1723551090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cjHC3HTfFfqBvl70BeunbeIG1gwZ0SxmbRT6QMGAa/Y=;
        b=GGMMZKQowCQkeDn2iLaSmCem5CPvspXYTYdyoITENMS0A0uFz+5DoD2Ya6MN7Pq3oX
         Sqx8xeUGvnCrh/5CX9ttBPcVrx5f5YH3Ouo+Ei0GhfmtXek92DDrJGTnCNcMtM+5i73I
         yPGtqG9rdLuQpZG3YakpUG9OejtYsvKFgzS7UZFdu+Qrn5A0IbQW1gX0HxBUiakgN5yB
         Cb0eHBJ7sSvWXCzMNDs304jGMysDOfVh7vbebU/QmCqvyuTfJZsZuAl9D2Y47eTzAIYf
         IwoLrX7CdHzKevW8AWF3qHSsIY3RPB5CxF3ZpD4wPNEcyurOjTme9LmIE/G+uipq2neV
         zhAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbWSgjJg5rWPVV62aUkSsvZQrn5dOtDfJ8CUMn12cjch9kWIx2MRJ6FGnEMB++G9b4FJGj8v2S0Tu1TtYRYR9I26EvARBYA82i/R8GmktUH+HXErVr3LJg+/rg/E4S9rly5YbiP+D7acwa61JErNrmODcO+3zVkZkL4mWTwqhMvN1qPl6z3f6XjMoOZLx8Z66OVKbgXKo3slewWxljilWYuQi8B+xP
X-Gm-Message-State: AOJu0Yyz5KnN1/0LXk2FiYPehwewNA/PbxCoc/EwymJX8PGKs78OgIxS
	BpIZfMxojM5TIMMRRj5FFXCxvjvWF8aLdGsoMKny7uP6lNFqXRpL
X-Google-Smtp-Source: AGHT+IFlQRuGQP0Gc8zcIPXHKIel/qOkAVK8ZtVTqhuzLGbG3UrBXcw+xuLmF0ETP/3Q62eOPi03PQ==
X-Received: by 2002:a05:6512:131e:b0:52c:952a:67da with SMTP id 2adb3069b0e04-530bb4d6d4fmr9824609e87.55.1722946289592;
        Tue, 06 Aug 2024 05:11:29 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:3711:c80:e7a7:e025:f1a5:ef78])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a7dc9ecb546sm542080366b.224.2024.08.06.05.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 05:11:29 -0700 (PDT)
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
Subject: [PATCH v2 1/7] dt-bindings: clock: exynos7885: Fix duplicated binding
Date: Tue,  6 Aug 2024 14:11:44 +0200
Message-ID: <20240806121157.479212-2-virag.david003@gmail.com>
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

The numbering in Exynos7885's FSYS CMU bindings has 4 duplicated by
accident, with the rest of the bindings continuing with 5.

Fix this by moving CLK_MOUT_FSYS_USB30DRD_USER to the end as 11.

Since CLK_MOUT_FSYS_USB30DRD_USER is not used in any device tree as of
now, and there are no other clocks affected (maybe apart from
CLK_MOUT_FSYS_MMC_SDIO_USER which the number was shared with, also not
used in a device tree), this is the least impactful way to solve this
problem.

Fixes: cd268e309c29 ("dt-bindings: clock: Add bindings for Exynos7885 CMU_FSYS")
Cc: stable@vger.kernel.org
Signed-off-by: David Virag <virag.david003@gmail.com>
---
 include/dt-bindings/clock/exynos7885.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/exynos7885.h b/include/dt-bindings/clock/exynos7885.h
index 255e3aa94323..54cfccff8508 100644
--- a/include/dt-bindings/clock/exynos7885.h
+++ b/include/dt-bindings/clock/exynos7885.h
@@ -136,12 +136,12 @@
 #define CLK_MOUT_FSYS_MMC_CARD_USER	2
 #define CLK_MOUT_FSYS_MMC_EMBD_USER	3
 #define CLK_MOUT_FSYS_MMC_SDIO_USER	4
-#define CLK_MOUT_FSYS_USB30DRD_USER	4
 #define CLK_GOUT_MMC_CARD_ACLK		5
 #define CLK_GOUT_MMC_CARD_SDCLKIN	6
 #define CLK_GOUT_MMC_EMBD_ACLK		7
 #define CLK_GOUT_MMC_EMBD_SDCLKIN	8
 #define CLK_GOUT_MMC_SDIO_ACLK		9
 #define CLK_GOUT_MMC_SDIO_SDCLKIN	10
+#define CLK_MOUT_FSYS_USB30DRD_USER	11
 
 #endif /* _DT_BINDINGS_CLOCK_EXYNOS_7885_H */
-- 
2.46.0


