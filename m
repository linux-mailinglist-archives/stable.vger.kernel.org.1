Return-Path: <stable+bounces-176750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC83B3D283
	for <lists+stable@lfdr.de>; Sun, 31 Aug 2025 13:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EF747AD8D3
	for <lists+stable@lfdr.de>; Sun, 31 Aug 2025 11:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8181A257AC1;
	Sun, 31 Aug 2025 11:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2gWyH7h"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9864C6E;
	Sun, 31 Aug 2025 11:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756640195; cv=none; b=V2y7ZWaSL6yqqamWAgvnRmce6JVuHMPEy0KsfIvt1qK7qoHSZ+ENK/IZil71zEkxgewOW0m6tAZKTpgxmNTgJK0zjj29SRzbRSl9c3ZgM60ckvK9qzeBO02rdkZqoh0Kck45+7eE3cRvTg/UiOkAA3d8y1h6Fp6BJ8Mwb5lAPU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756640195; c=relaxed/simple;
	bh=Y5SdIDp6Dj51UlHP63gpByU/X9ah8B/bJJRwBKB06vA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kMFg2PEKu4dmb4E17U0MdcLyZSpoXnm5X+IJWkIIBt6IVtA/BdRzBoxTOjWOFt+sMvsRAGPQpwZeO5eQ8buOXrLHSnRMEWH/1pn50Rotik3kRUq1iMAYf5BmpQ564nPfOWvLcKBmgV6A2o9A4LuXWAHSYbwa1um4iYyrCjOIFUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2gWyH7h; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-70def6089b2so46747706d6.1;
        Sun, 31 Aug 2025 04:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756640192; x=1757244992; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZUh0MEEJkewGsicwduu83OxT2GPj9q4Ws7POcHR5kI=;
        b=a2gWyH7h6jkaPdHo3sVg7q0q9asR8sKc179NSmIfIyE5fS47Oo/A7TvY/z1cod9LMS
         kVtqNpL+LPP6Q/SiQfIUX3bndbDhSvE4Z4022aJ+HDUWhIcxwZPm1M1zo7L6B9c4Ah/X
         M+TIx2Chch44fH0dKZq+jccdJ0GzqJsTgMeOjvPm7x/8xfjl9aCZZ0VvynPTiOm86huS
         j22Psb4SwHr1LDMWlhLdFdv1om46pbZW1iiEp4hkZq3OUtyDSlRmGPrljnOCh5CNI3PK
         5qm2hn3R88odI4exXCeRdKCquItaOVuTySje9Mz3OS5sCXYBJZajLlYwQTs2Fpd//x8j
         X4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756640192; x=1757244992;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ZUh0MEEJkewGsicwduu83OxT2GPj9q4Ws7POcHR5kI=;
        b=bMLSU2C7vQfFob3AMehiVAWwYJK5mPc4MDBc6FZBvLmGahLz9SvlmaUgwX0BF+ZYCw
         gxb+Cb3/E8cnOeB8812FqAIY5Z3WsaJk6qLGgA5x90OHOM8tjxuSXZh36aJrEmcox2uw
         20+0DNZce/XUWn8U/4Yw1jC9j4iHPK5MO8y7kPkMVE8NcDfXYGPOBP2o4S01E4tYMMTz
         q1a0/DyWBP3ocyrNvafC5gSzmR7gh7HToCjMVI/x5Ze9P5NIORNZaB9g8rQochnP7v8z
         3y2WkHd836Rtp6YiDf8BEZQnhxRYBL1GXI2MCQbFFY55KxD7iksivBmGYPtoomQwf0aq
         DvVw==
X-Forwarded-Encrypted: i=1; AJvYcCVh1Tbz6Jh1WoAXZ06a7OKOt/qBnovQMWtG1k48qHDlOcB/C7BIbmXsCllzMpI9yNMWCs34bnUxVU7H@vger.kernel.org, AJvYcCW6V3tTy+ylPmECs9JK3esruzWnvaAnx94R8ypKHvWk2TzFbJJmPQJnXIK60ENUdwhNQ8IaAhRistCWre19@vger.kernel.org, AJvYcCWJ/p8pDv/iai5maydDu6rWG0puAYJxHwlg0HBpZkpD6XdxZ1IGTIYEhdZ668yzckNhp7IgOyCF@vger.kernel.org, AJvYcCXb3tAPlKcFgYwfy0Kqv5l+/dsUapTgtli/WHPnF7PUcnoyyWTnhaRkAHrYaSVUNtV8E4kP5gdIeM8u@vger.kernel.org
X-Gm-Message-State: AOJu0YyFOXg82OmKz14ZfNeGZQAeXOpKvBLs9zAYYDGVSLVKMsY2ju1b
	oUe8Oam8QW4ksAbstith7hyQmy/2RTG11UzRo5mzE9N9uAA/rwsI/qChdviJoln9DIE=
X-Gm-Gg: ASbGnctPp/Wgt4FWOkWhqGgTs2LfO+D9M+V+1nZi93oX7/sJ/+VcO2cP4fwhmRJMyaK
	X2uGq5lK7cktXtCTx49R0WIeo/TXqqmHUD0cZiO2QAQh0X7hWiF50JHpp44dtIvbKv9b3kqrZdu
	oYveSw5Pv/nQJKn03ayivcQe+IMVW51spVqhUa7bXTFIsf2d7FKVLNd0mYo3RknlWLZMdluDW46
	txDtM5i6wzQD8SA4mK31T8g7ZyYKDNgTqwD/gdiyrxBfJpIhRCf3pUuoSTrrZO3MWsXYW3po6Yc
	GD15LPmP3+dGiXZ7X+45seg+bUaX+D3tBC9Wj6rq7saQL8Zvgp68CJM7S6MbklwqMVMvNGnsPPt
	lsvDV2sOnC3c+H9e+HI6s2T/3kmOsq+Y6kKO1nVa5Ng==
X-Google-Smtp-Source: AGHT+IEgyOkl/UbdfyW6MG7c7Sd8lz8jggA53zwGgpqsmVaB7MV9/7bu+KNwjTwRd47DIj9JlUGgbA==
X-Received: by 2002:a05:6214:491:b0:70d:bcbe:4e87 with SMTP id 6a1803df08f44-70fac70188amr43385146d6.8.1756640192586;
        Sun, 31 Aug 2025 04:36:32 -0700 (PDT)
Received: from [127.0.0.1] ([135.237.130.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70fb28383b9sm20519076d6.37.2025.08.31.04.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 04:36:32 -0700 (PDT)
From: Denzeel Oliva <wachiturroxd150@gmail.com>
Subject: [PATCH 0/3] clk: samsung: exynos990: Fix USB clock support
Date: Sun, 31 Aug 2025 11:36:25 +0000
Message-Id: <20250831-usb-v1-0-02ec5ea50627@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALkztGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDC2MD3dLiJN1kixRjU6M005RUyzQloMqCotS0zAqwKdGxtbUA9XRauFU
 AAAA=
X-Change-ID: 20250830-usb-c8d352f5de9f
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756640191; l=1076;
 i=wachiturroxd150@gmail.com; s=20250831; h=from:subject:message-id;
 bh=Y5SdIDp6Dj51UlHP63gpByU/X9ah8B/bJJRwBKB06vA=;
 b=N/msIsCF1bZxakusiiyW02vDVnrgyxYTtYKUAjfW7cOttGAEA0iytAQgQQekdIdCrg/8CfLQR
 ewo3N0AtgQTByyC6MjYFTtgNCKOb86wvYiHdpUUKylgB32HgWm60FzP
X-Developer-Key: i=wachiturroxd150@gmail.com; a=ed25519;
 pk=3fZmF8+BzoNPhZuzL19/BkBXzCDwLBPlLqQYILU0U5k=

Hi,

Small fixes for Exynos990 HSI0 USB clocks:

Add missing LHS_ACEL clock ID and implementation, plus two missing
USB clock registers. Without these, USB connections fail with errors
like device descriptor read timeouts and address response issues.

These changes ensure proper USB operation by adding critical missing
clock definitions.

Denzeel Oliva

Signed-off-by: Denzeel Oliva <wachiturroxd150@gmail.com>

Signed-off-by: Denzeel Oliva <wachiturroxd150@gmail.com>
---
Denzeel Oliva (3):
      dt-bindings: clock: exynos990: Add LHS_ACEL clock ID for HSI0 block
      clk: samsung: exynos990: Add LHS_ACEL gate clock for HSI0 and update CLK_NR_TOP
      clk: samsung: exynos990: Add missing USB clock registers to HSI0

 drivers/clk/samsung/clk-exynos990.c           | 8 +++++++-
 include/dt-bindings/clock/samsung,exynos990.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)
---
base-commit: e0edfc39b62e35dfb6d669b1189fa268147345ef
change-id: 20250830-usb-c8d352f5de9f

Best regards,
-- 
Denzeel Oliva <wachiturroxd150@gmail.com>


