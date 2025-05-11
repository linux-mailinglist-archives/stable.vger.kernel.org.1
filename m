Return-Path: <stable+bounces-143098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB039AB29DF
	for <lists+stable@lfdr.de>; Sun, 11 May 2025 19:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F4E61896103
	for <lists+stable@lfdr.de>; Sun, 11 May 2025 17:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FB922D7A3;
	Sun, 11 May 2025 17:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libre.computer header.i=@libre.computer header.b="E8Z+un9Z"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A198E22D7AA
	for <stable@vger.kernel.org>; Sun, 11 May 2025 17:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746984481; cv=none; b=lKfJVn/XOiQVG2HxgqCHTeGmRD5OgtOFOddMUqQI9XXMTT8IvvYSI2b2xEDM28iqv1jlpireZZzSPLr1S++gCnZQvr5FIdUm0i6zkIniPxL2WEZfCEDmWLZh5s57euLGFE/VpQKOuVxRlWYXibgvfUTehLlHtpP/Quuicqrpisw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746984481; c=relaxed/simple;
	bh=u8Ob+G3P6BviIfXvZ2FMgD6fVlQn8wTY2uh9z+JTQCo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N0zYvRCZSWo0WHNHLV7iysNCM/Yb+wSpT/NhkGIXH9913BkevHerZpDQI0GQCvQR2HDP4WxTJV+7RA0z5zXWeFB7DCaEOXXLIAZ1sgNtvX3vZt6sUVkIkpUVEiNRbiiMBkcRayS+KA/pyLyCVCCS3X0LmlgxjNYlw8F0lLmvFuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libre.computer; spf=none smtp.mailfrom=libretech.co; dkim=pass (2048-bit key) header.d=libre.computer header.i=@libre.computer header.b=E8Z+un9Z; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libre.computer
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=libretech.co
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6f2b04a6169so46712076d6.1
        for <stable@vger.kernel.org>; Sun, 11 May 2025 10:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=libre.computer; s=google; t=1746984478; x=1747589278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PUIuHKm5CrgLUrfb0rxe39olGMFqadKbva67STDygLc=;
        b=E8Z+un9ZmPdPSMz1ByujP8l7EUJ5AEMxdr0TBu/k9Gl4dfdr8r771kB2icm/qWHEHO
         Em4ggo9By9jDX7VsKlvWzTMmMgKMCqTSUszKT5F7J0GIdsjakM2FRdoDs0Fj7zcX64Y5
         KZThpXDGiYWcI4hns0+Tg0Df9wdc0K5jrTAOhnrBtNBqcKzKm+2XmGPJctIpUFi5RnVw
         q4yNNaEmrvl5dckB8UZIa2qInYMbgfe5satZdp29RjWRtRALPCt9CFx7UFzkcmdOwf/4
         64aa+DklUxBe4lBNXe2gLAUPrLaBD/ZzFEeroI7XW4aBsVbO6LPTi/zzCZ8l8j60+bn/
         eotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746984478; x=1747589278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PUIuHKm5CrgLUrfb0rxe39olGMFqadKbva67STDygLc=;
        b=i89VjDTwQX+2sDsGE0vj1zajSP+9Jb2k9eZ1c4eYIs77ddwyj6DXcB7Gy8bU6Hp1P3
         RL3PODO5UXAfRettRKaFOf0dF7pd9yMIPNNgIykxsRTbGJ5OrsgjF8PeGjfudYVFNNYd
         ua+7x2YM69COj8SewUBwtquAFnB+4zabkoMYn4NZpVdOo4Bo/GV2A/itqiWKMM1kDAzR
         DPNjexvyOZpiql4zG2xDD/GyYqQH0gJHRmAuFosarbdejZsV9F21s0d7MPOlDsnHYMWk
         MnIA3XqNHGw99+wAicQfwIFvZTK6Lg+I8Yj4W5tD88xPJe608pKLqgiPMdndeZ4SS43T
         qf7w==
X-Forwarded-Encrypted: i=1; AJvYcCVQJ3O2DYpws3QneJnUW21RY6Uf6mgoEGRtOFZUqrQ5oVE3GIhLreNF0+HOccSvU/yZ6Kg39cU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMqPCwPdyc/SOHpoNOHz3Txrzljhqiv4vlMq9e2YYxQLmREqur
	QRO996S3wUHqTjwKDyM/mOp6vM1Fj+sgfqKFRRKs9qayh8CkJPkp9ibgJd3zGw==
X-Gm-Gg: ASbGncsWQlDG8KZKULAVb9GAciVp3ifvdwET98FdFWN6hLfNqzRCviqEDGmzppBCfQe
	WHWHiyeAyEv2Hzyxlx9IbXNoJe5pfpn44deScRIY/AmxuZ2J8wklhMdM1kc7Bwe86RNzhFZVCXA
	bIMyG+d42Y2WKXBIf7wnKBHjkcjovRhZkIgBdK86M0ihe319MT3NO7RwLKhpnFcXEuWAsNEHG5F
	gs02DxHnGy1n6llsZabzeKbBhzeAndo7LeTMtqvox6qhSok9yrndRkhBqBDIJK8GvGmiuCYG35u
	UBX0VPdfhfFhZ8gI973efH4QOQ4d1gpnxlOVH41eT8D7qs4=
X-Google-Smtp-Source: AGHT+IFlP5l0H31XlZsHA+W4Q93wZy0iO7ylnNI0g0kBW6+BKRL+6jyRI5gTxis2QFwWchN0XCtGaQ==
X-Received: by 2002:a05:6214:224a:b0:6e8:f770:5045 with SMTP id 6a1803df08f44-6f6e4801da4mr189887276d6.28.1746984478330;
        Sun, 11 May 2025 10:27:58 -0700 (PDT)
Received: from localhost ([2607:fb91:eb2:c0a0:10e4:4464:87db:3a66])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f6e39f47basm39766846d6.42.2025.05.11.10.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 10:27:58 -0700 (PDT)
From: Da Xue <da@libre.computer>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Da Xue <da@libre.computer>,
	stable@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] clk: meson-g12a: fix missing spicc clks to clk_sel
Date: Sun, 11 May 2025 13:27:32 -0400
Message-Id: <20250511172732.1467671-1-da@libre.computer>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HHI_SPICC_CLK_CNTL bits 25:23 controls spicc clk_sel.

It is missing fclk_div 2 and gp0_pll which causes the spicc module to
output the incorrect clocks for spicc sclk at 2.5x the expected rate.

Add the missing clocks resolves this.

Cc: <stable@vger.kernel.org> # 6.1.x: a18c8e0: clk: meson: g12a: add
Signed-off-by: Da Xue <da@libre.computer>
---
 drivers/clk/meson/g12a.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index 4f92b83965d5a..892862bf39996 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -4099,8 +4099,10 @@ static const struct clk_parent_data spicc_sclk_parent_data[] = {
 	{ .hw = &g12a_clk81.hw },
 	{ .hw = &g12a_fclk_div4.hw },
 	{ .hw = &g12a_fclk_div3.hw },
+	{ .hw = &g12a_fclk_div2.hw },
 	{ .hw = &g12a_fclk_div5.hw },
 	{ .hw = &g12a_fclk_div7.hw },
+	{ .hw = &g12a_gp0_pll.hw, },
 };
 
 static struct clk_regmap g12a_spicc0_sclk_sel = {
-- 
2.39.5


