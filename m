Return-Path: <stable+bounces-143289-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C63DAB3A85
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 16:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3D3C162C1F
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 14:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DA5218845;
	Mon, 12 May 2025 14:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libre.computer header.i=@libre.computer header.b="XKPL7R/Z"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25501E379B
	for <stable@vger.kernel.org>; Mon, 12 May 2025 14:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747060018; cv=none; b=EDiCi7JZkkfMQoY9cZfy4IzvEGzOWMCWzzo86DTDzHDd3Kktn70G/q3yEgdOwlgykbsuON0jY7ymP1aY3Cwyuv34xHwFaLD5Nxt8T+QjQ8orIqSy68dIoTfxJqQ6/M0P2zqgmsG4SlbuVUlAIssC0f0ZbXTzn5hsGOuDZAG3PKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747060018; c=relaxed/simple;
	bh=6T2kDON1dhsNnU+XjIY2oPcsXbHsrN2ApoTFS8oDyVs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bCLiHLAzIKP8xTuUZUiukTR91pmJHWXWbSx5Xk1RKlOefY4+IwX6TdLvLkubvSCXfFyBEr1sMcMhdixiHmPDadbQ+64LPfeXwpTG5dEXsakVTypuW+ar+NrdLhEBrqbQ2OcL4UGzKSUh+PQaGxWi9nbzCjQdovEuw+sVKfR0vYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libre.computer; spf=none smtp.mailfrom=libretech.co; dkim=pass (2048-bit key) header.d=libre.computer header.i=@libre.computer header.b=XKPL7R/Z; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libre.computer
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=libretech.co
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6ecfc2cb1aaso51018806d6.3
        for <stable@vger.kernel.org>; Mon, 12 May 2025 07:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=libre.computer; s=google; t=1747060015; x=1747664815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RKMd5G0cFDMucPOpi+tWbuy3t/lyFnn71icIWCgXypM=;
        b=XKPL7R/ZhanEz962li/zfhA6mK3Kl4Wt4vgXw4oWSqjQdvTjwsg1UByr6HxxrH+HEK
         78lp9LNx4oZxILKw/eBgl2TF4mK8j5WtEXf1h4EY0c07yNDTkyJRK145B/Sm84JkTMFc
         h9fNZ7BrufrfHJdbkFPb1MX+40dPVKMUNPEKr9sGKC466AQRDO2MsJaohVgdnbvIeB2W
         EFJjgTG/CB2DXl6m14GG6uot9gOkQvg050Yfnydg+o75fcpufAAO/J3yJROqdUUTA6H7
         nDODuaXp4gm/AKOVdi3zoGF98PBqmAbPg+IPi01j9ZUcCRuc8CcsbsGXtD4Pikh5TOsa
         tgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747060015; x=1747664815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RKMd5G0cFDMucPOpi+tWbuy3t/lyFnn71icIWCgXypM=;
        b=Mz76S1XddUNYsRENiIkr7CdH3wuA/UwWV0D5bRScz1xAC2u75xIdHNkwFisDuzJjgl
         0ZkjxpC07yIE2BI//aAFpsdCvuG36y20cO3bp2T/1pbXZFCi9Gnm2dq+TeBBrtSK6Do9
         +buXpoDuaZBsVFloAff47fqu5YYZVLLdIZ2MyRYgQN2gK8eYbHpvR8TF7/m/QLQEY6uw
         2Kvl5LwfcySnGUz7mpHOB3oFh6dD0efaihs70aJXoLBNKeIKpek2vgoxr/9za5vJ6awk
         zD+EQJywEY/RxSU1ZMieRa5gE26ZO2WricdhxlWdzi7eWdH6aFzZqOuja/024LpAxvOM
         ZJRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfyZHqYt5Mc7emjUU//pU1uD98yLZ9Q0EqRUD49Aeqc+afmQTGDGuxsl75vAAVjaBgd756ZTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTjTjd7Zes7h0QHHKm+itrUQ/Ir5Oy9vuL+Cmii6EBqKnWtMO2
	UK486AXsaJWH8i7y9V8eMRC+Cz9/24qYbpVwA7FRS87x6deZzFenHxMatTYjFA==
X-Gm-Gg: ASbGncsabKtZJHs66Zl/Q/ra/KeVTDcXN2ZLo0VHJ8cYkUUKZu5cEsXfMSDuLkIN7qV
	d7xMVVp09ZHOYR/NayeH7bS82dUgYLD/KGjqTJZkEOjY1UFrUU3h7Lg53Gr+8XcM1AUKo9h1OG9
	cAu0094A1mJk2WXXCLLdjcs5KxJFN7Ek6RDM5TZL/hL1NEeTkFIRmxoZ4+OTBc73xX8iVPXPRJ+
	V5ZTJhj0M4Pw0lebKoZzRlxFhNytF7aBpiUaL9O52kt82zrCQ7ZtpATKKyo1YnvZnFudnlFJy0t
	lJsTw6pUqdiQlg5KkQ1p3JH90c9N3MJ/mqCE30yHEK0X/N8I
X-Google-Smtp-Source: AGHT+IHwLWxHT8fQlj2kksRDBg+A0JhtXKo+AreGOwt+ETP5hLx/Dy37l3apsuA9OkV+nl0kGKBq4w==
X-Received: by 2002:a05:6214:300e:b0:6cb:ee08:c1e8 with SMTP id 6a1803df08f44-6f6e47fa918mr229336596d6.23.1747060013390;
        Mon, 12 May 2025 07:26:53 -0700 (PDT)
Received: from localhost ([2607:fb91:214c:42a4:3793:dd95:dfa1:719a])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f6e393df31sm53362726d6.0.2025.05.12.07.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 07:26:53 -0700 (PDT)
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
Subject: [PATCH v3] clk: meson-g12a: add missing fclk_div2 to spicc
Date: Mon, 12 May 2025 10:26:16 -0400
Message-Id: <20250512142617.2175291-1-da@libre.computer>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SPICC is missing fclk_div2 which causes the spicc module to output sclk at
2.5x the expected rate. Adding the missing fclk_div2 resolves this.

Fixes: a18c8e0b7697 ("clk: meson: g12a: add support for the SPICC SCLK Source clocks")
Cc: <stable@vger.kernel.org> # 6.1
Signed-off-by: Da Xue <da@libre.computer>
---
Changelog:

v2 -> v3: remove gp0
v1 -> v2: add Fixes as an older version of the patch was sent as v1
---
 drivers/clk/meson/g12a.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index 4f92b83965d5a..b72eebd0fa474 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -4099,6 +4099,7 @@ static const struct clk_parent_data spicc_sclk_parent_data[] = {
 	{ .hw = &g12a_clk81.hw },
 	{ .hw = &g12a_fclk_div4.hw },
 	{ .hw = &g12a_fclk_div3.hw },
+	{ .hw = &g12a_fclk_div2.hw },
 	{ .hw = &g12a_fclk_div5.hw },
 	{ .hw = &g12a_fclk_div7.hw },
 };
-- 
2.39.5


