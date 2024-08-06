Return-Path: <stable+bounces-65482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FCF948EC0
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 14:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0A0A1F236EE
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 12:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECC91C688C;
	Tue,  6 Aug 2024 12:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUjp9Gxs"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AE81C460B;
	Tue,  6 Aug 2024 12:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722946291; cv=none; b=cmplIZAYx5bR+j7xcF08Qd7Vs1BalVBbAcLIttN95uxECZU4+LipETdJewfMomGy8gwyj1fo9WgtAF+AX4St7Rwf9cKKXMo+bNAC/sBcqCkrYzS9SwSnWwip3QYopH+CGgvDPnNcwQqyML4Gh6sEnaB9PupN+o58O7bDDcIKBFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722946291; c=relaxed/simple;
	bh=suWPD/95x9rT+UH16nQBm/cnb20gIfoOsvWyscg0qQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e2pN5bLtncA3wP74t3PZ+L2JyMASpwi/UmOyM5bkwquVbqwWk0YmYltI99vq2bgZuKdGg3xBucCgSBx+aV0xf6qQ918YkRZM+Hp31nGZRj1iGpwuY7SAqd9ecRauyUNN2c4FPPnYubgqNCJq3XM2/UcUOH0WGEBXbfxTQmZbGtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUjp9Gxs; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7aa212c1c9so78349566b.2;
        Tue, 06 Aug 2024 05:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722946288; x=1723551088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f8Rxi9oZBmORLJ1iHbLg15yYhmyteSjrYkO+zSel3Mc=;
        b=DUjp9GxsBnHoRJsylcD2nTPZMCXm7XN0OkzFXH/ngokQdV/zGw46bz9biUecaZEBoz
         gmrkA55gdB7Z0SsNazjW0ysM1hegtYr1ix1vpr2bcBuVOOm/l0TbeYSSDBLoSKjzCg9F
         r4uUe2AunJE1dC4bprXh2tvOiT6K9i5NUeDMKRqF7zzhx3zVDTaA3fm3OpRc/WXrB1XQ
         slxY4FsGrHlp6pq3C1QzdYH6u/KUxUv8ze1NPhq6Ru12PEiXF8Emlp6fxwAs9PWPQjih
         3Z9/BT1J5IlvXlklcWr6bvJ6jiQWiqX9xpkeZ076KzpLMjccgmzX5IjZ7DbJB1P5H1uU
         WezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722946288; x=1723551088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f8Rxi9oZBmORLJ1iHbLg15yYhmyteSjrYkO+zSel3Mc=;
        b=onWqcW10amZuaH14XKoXsqXnckwQcXVgbf7zQWDDgB0QbYvU8S0Z7ezxsgn1IbWIfO
         K/Kef/Gnz22/TJxxq/SWh8GE/jfRbB6aZQNXy+MNBGdm0U4xQBKhYcZ1ac/CoIyrijXS
         9K8YPzl0fGgGb1+yPtxXvcFKAeCqkZ+JRRsBqn4AY9DDkjo6lRVIW/sToLYl2PKGzDaf
         q+knqsrMX8XyVX4eUEAP6btE6UxL//UcSbj8kc/zW7sdwDdNbIn0WkuHAhwXowpb2y+p
         YlIQX0RlG3unumd07kTc4axu7vF7UugOpJsz3RpqqVtA4QSqvlbN08yYiJz2HGkErwnX
         LjbA==
X-Forwarded-Encrypted: i=1; AJvYcCVZg7do9mFERpY2a2vOIs1rsgQpUdSabek+wNvMfIJg8zuLJbJuCpl+4PKhClGcerhTiiQ4DLbgAwSZIyh9hVJYpKZlCzlkXqckHTfrlEFVw1Llw3S9NYgWyOMnkTBIBigk65HPZR+np2iQM1gAHz2mhoqGJB+G/06Hbvi//ur2oqatKbON7gl6AxBpqdP+qkqXKnRbC7c7/bi34Ewq1aUxUvdp9eIL
X-Gm-Message-State: AOJu0Yw1E1HjdLyPI3CoTY4UK9K+5/FLoDGpIn4sKXzu1HG6GVO2bS4c
	zp4sHHtGuDnHhygxVBjk92S2yPccrVug1rKnPxlnAwrYiXleCnE7ZN6Kpbqt
X-Google-Smtp-Source: AGHT+IHsg/cOTLkQX9qlRiH8hTY18OxisAJ4r8hZ0x1M/XZ83NkiV0ssfMBZdJoVPxj54USV7sSddQ==
X-Received: by 2002:a17:907:2d29:b0:a7a:b385:37c8 with SMTP id a640c23a62f3a-a7dc4dbaae9mr1106144766b.5.1722946287917;
        Tue, 06 Aug 2024 05:11:27 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:3711:c80:e7a7:e025:f1a5:ef78])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a7dc9ecb546sm542080366b.224.2024.08.06.05.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 05:11:27 -0700 (PDT)
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
Subject: [PATCH v2 0/7] Add USB clocks to Exynos7885
Date: Tue,  6 Aug 2024 14:11:43 +0200
Message-ID: <20240806121157.479212-1-virag.david003@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This set of patches adds the clocks necessary for USB on the Exynos7885
SoC.

While at it, also fix some issues with the existing driver/bindings.

This set was split from a previous set containing clk, phy, and usb
patches [1].

Changes in v2:
- Split from full patchset.
- Added Cc-stable tags and fixes tag to update CLKS_NR_FSYS patch
- Blank line fixes

Cc: stable@vger.kernel.org

[1] https://lore.kernel.org/linux-samsung-soc/20240804215458.404085-1-virag.david003@gmail.com/

David Virag (7):
  dt-bindings: clock: exynos7885: Fix duplicated binding
  dt-bindings: clock: exynos7885: Add CMU_TOP PLL MUX indices
  dt-bindings: clock: exynos7885: Add indices for USB clocks
  clk: samsung: exynos7885: Update CLKS_NR_FSYS after bindings fix
  clk: samsung: exynos7885: Add missing MUX clocks from PLLs in CMU_TOP
  clk: samsung: clk-pll: Add support for pll_1418x
  clk: samsung: exynos7885: Add USB related clocks to CMU_FSYS

 drivers/clk/samsung/clk-exynos7885.c   | 93 ++++++++++++++++++++------
 drivers/clk/samsung/clk-pll.c          | 20 ++++--
 drivers/clk/samsung/clk-pll.h          |  1 +
 include/dt-bindings/clock/exynos7885.h | 32 ++++++---
 4 files changed, 111 insertions(+), 35 deletions(-)

-- 
2.46.0


