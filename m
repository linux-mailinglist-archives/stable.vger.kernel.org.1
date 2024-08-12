Return-Path: <stable+bounces-66484-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E8494EC27
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 13:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43BC91C21380
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 11:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC53178CC3;
	Mon, 12 Aug 2024 11:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpfBTSkg"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3171178375;
	Mon, 12 Aug 2024 11:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723463728; cv=none; b=V+fRq2CNQgp2gvxQ0bJB2OowpjS2cTDJ11IankXv6iAGkHYr65tuLOUieTM2LMnoca7gtrSGYPlga9jEuGJLpOz7vxbZ/rHEBWaMgNXWo2OchQ0VWiNfJyn+ftZBo7N82+DO5ZuaLv/YoyyXKSbA/W0OAzETpu/ZHB8UMmwvoI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723463728; c=relaxed/simple;
	bh=D+7bmUBmPf9R1lZOFP6pwp2kl3GgyVARNY9iPApW6Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s6NvlSZQVGtASQJAy0uibvlreBSeDHCilz29fZsF2dujGQVH6cK7iECbgFaX9JxOZNVZDDh0ivMzo4K5wkh327NAnis9wxRtIQgDVY+y9V7iHtcUkT+kckAgaK+Re8GvqN2heDVpg6F4IJAhLLDiBdm3p984UKm7Yq1IHhuhy94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpfBTSkg; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-428141be2ddso31696825e9.2;
        Mon, 12 Aug 2024 04:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723463724; x=1724068524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nGqwTPLmyEyMz26JbF1oTN1ZIomEQ9CX54wEGKF1mH0=;
        b=BpfBTSkgkFXs34AsGBWVKXYlJX0uwSwmBqaksrzNwCS7mvNmb3MZ+pvE79mkM7ozfS
         V+cfJI5zZoh5CS809/fzW1BMtv9XfSC1Fa1umMPvDU8AGy6j1PEmgtHCHWmeF5ZPxkGB
         WSe30+tBbs1I/z6xioTuIB8qKFlRMSwVVygC8jHSniWDFuTQ2xEPiwwps3O3eF+oB5Ot
         dJZHtRjIlj42wP4cK+Ghu2yrNkLBDXE1Z/tPbB7Sg1TcGJEhRwUt/PeVEqi+QAfTMo03
         6ene8ctzSPohirC9ZO5hYJuJsXAb/NYtREIUb4kFlO9q900iaImlfT6eBrMKGXRR77XH
         quNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723463724; x=1724068524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nGqwTPLmyEyMz26JbF1oTN1ZIomEQ9CX54wEGKF1mH0=;
        b=SC8XSYA1IT3DdJYyaojHlcVk8DAjnW1sCSZh17KvRtOO7RafHvdAasl5SUmdIiFzO4
         RwL34ymslSKCzoiglIcfBcj2TcTyfvM2fv5pFVCtbxXmEwWUfxrrB6ALSK5BWwtiSgsS
         7GsRLHJe3RsH8U0+c8dAw6uBBUGgYwHWfL1LGoFgCHJr8TJJeNlG98M0nD0Jfs2RkpHE
         6M7cXLXgLj+JIKJ9ACDk/hWRcphRp2Z+9n5o28N5w6FRcIKHTscFcMAhzvX1EYDAFUuA
         1+SDoCb0fLrxftR0tT/1emOFpSia6zPVucjr0Iu/WrlpbMvaJaK4fkDFEffDnAXn2Gv2
         /dHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUePQeJZsDv/y6IqbiiSeWqQQs3o/vwJ28ZTfKLYQTqfDl+HtJxAZyxzt/pTATPbnnSF83RtqZXQKTeDkZW+svVNUJAqyjIcaY0NLxk2khWEQDI4AUFBw87CkMds5B6lBfqxa0jiHSSxqeIvtdEV7SZl7qdWVrfDJ6jwj06JCJJ
X-Gm-Message-State: AOJu0YzLzFlHwg3Kiw3Ta/v/ZsF3PtBQP6hgpm/VL3JNggggZl/8qw+x
	ynzHCr1KiMK6MF+oS5wWD3iKEFevVo6LvhnbVyoi4hEDc/KFenbvwIVS5w==
X-Google-Smtp-Source: AGHT+IEzjMxUddGepYwSs+gi2qqbMIT/TW4uXG/465a39anmmtS9nzyhnaPu4fhSF0pZShiTU2DVEw==
X-Received: by 2002:a05:600c:1d21:b0:428:3b5:816b with SMTP id 5b1f17b1804b1-429d47f19ffmr1249145e9.3.1723463723486;
        Mon, 12 Aug 2024 04:55:23 -0700 (PDT)
Received: from localhost.localdomain (host-79-52-250-20.retail.telecomitalia.it. [79.52.250.20])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-36e4c937b23sm7261602f8f.35.2024.08.12.04.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 04:55:23 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mmc: meson-gx: fix wrong conversion of __bf_shf to __ffs
Date: Mon, 12 Aug 2024 13:55:10 +0200
Message-ID: <20240812115515.20158-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 795c633f6093 ("mmc: meson-gx: fix __ffsdi2 undefined on arm32")
changed __bf_shf to __ffs to fix a compile error on 32bit arch that have
problems with __ffsdi2. This comes from the fact that __bf_shf use
__builtin_ffsll and on 32bit __ffsdi2 is missing.

Problem is that __bf_shf is defined as

  #define __bf_shf(x) (__builtin_ffsll(x) - 1)

but the patch doesn't account for the - 1.

Fix this by using the __builtin_ffs and add the - 1 to reflect the
original implementation.

The commit also converted other entry of __bf_shf in the code but those
got dropped in later patches.

Fixes: 795c633f6093 ("mmc: meson-gx: fix __ffsdi2 undefined on arm32")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Cc: stable@vger.kernel.org # see patch description, needs adjustements for < 5.2
---
 drivers/mmc/host/meson-gx-mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index c7c067b9415a..8f64083a08fa 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -464,7 +464,7 @@ static int meson_mmc_clk_init(struct meson_host *host)
 	init.num_parents = MUX_CLK_NUM_PARENTS;
 
 	mux->reg = host->regs + SD_EMMC_CLOCK;
-	mux->shift = __ffs(CLK_SRC_MASK);
+	mux->shift = __builtin_ffs(CLK_SRC_MASK) - 1;
 	mux->mask = CLK_SRC_MASK >> mux->shift;
 	mux->hw.init = &init;
 
@@ -486,7 +486,7 @@ static int meson_mmc_clk_init(struct meson_host *host)
 	init.num_parents = 1;
 
 	div->reg = host->regs + SD_EMMC_CLOCK;
-	div->shift = __ffs(CLK_DIV_MASK);
+	div->shift = __builtin_ffs(CLK_DIV_MASK) - 1;
 	div->width = __builtin_popcountl(CLK_DIV_MASK);
 	div->hw.init = &init;
 	div->flags = CLK_DIVIDER_ONE_BASED;
-- 
2.45.2


