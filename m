Return-Path: <stable+bounces-93065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D11959C9621
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 00:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFC11B248D5
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 23:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7435C1B372C;
	Thu, 14 Nov 2024 23:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="knwweu2i"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C62B1AF4EE
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 23:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731627199; cv=none; b=IBiVtQz31DPNr4iiDbtFGEVAgJRJRJDxu717UKon7WNAnl80gn3KWlGsfbLoVz7GRGESqxEn2+yy40YCs6VbKA5o0UEADHVQokPDn8V8NKhE364K5Ufe8tb/UOA8/Am/X+RQL61eUu1iBGsQ1p6UJlocnYgAaFFfxizU4VWxs04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731627199; c=relaxed/simple;
	bh=UYWLHm7qfMw23PDHj1x/cvLxSnpl+KHifSvGS/dxR3I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XcSRP+/eSK2xUjHTxdkH2RS6a7Dv6HoK1NQig4N90Ars2LaU2W0UHjLMffJIx9jx6IZW9zQ5pMtKfm86vI2TNRQHskfomIYUF4NQK48Gy7JWqSGDTSE+GkaTnawbr8DVJprOBAoYDEFwwZZU2lVH0xtsObLmtCo426VcmZfwvEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=knwweu2i; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4314f38d274so13208905e9.1
        for <stable@vger.kernel.org>; Thu, 14 Nov 2024 15:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731627194; x=1732231994; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VVvwlAu+8zSpv+81YL0HNfwnIe4vXYe/t9Y2ZwRkEAk=;
        b=knwweu2i6RwuZyu3uqCuLCgE2Kulu1D2F7jUscYz5++8v3/gZylbQzTNU+gXuV8mX+
         h80X1oYoLKnxeRjQFQU/oSvfSlCwE16mwehI1RtKbK2lItPHOua4Dwsp8QIWigDMPyDu
         TToyr1Enmia7IAYGKSHb6JojaZ22W4dTtTJaZolcz0g1+rCCmi4H5LmQ4r3uh69CRhNm
         t6BxG4HTz7C1if0ailW2SFFzyNuObF37ESvkGUnP7zw9gXxQwA0HbJTQGZxkScIS637l
         BuFDfuicBVva133fzMaomifXj6HPTArAS4IYwh7RrZKkhuxh1WAbpj7+jOOs9Mi1Vav2
         JJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731627194; x=1732231994;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VVvwlAu+8zSpv+81YL0HNfwnIe4vXYe/t9Y2ZwRkEAk=;
        b=lxx5MdjQyycTJoe/F44NbaOExzCRmi5K5a4Yi6WqtD60tIURfBDAdJIfabJh3QJhpS
         BVd5UXHTCtk+/0ifWY2uBqnzcVMnPM0JzDF2iEyRTXslDF0tj8wZq1vMJ0d+HSWDi9ji
         SScbM6RC6TPqAihfEr3qrVOa52tTisW5I7vRa6BDQxLrGfzVFox0yo9AN4kS/YqyxwZ/
         SUiBrr4ZzHpSKl9txv+KvzbNZFy9ZsSlMJbVbzokBJCK1P4fb8ffN5zSCN9fSn8LykCC
         mHhwTBB8deCLzErGaud7pHaleEYGOJODvombGqMCiHva50gzIecswZni7ra/hcuhpMYl
         R1Fw==
X-Forwarded-Encrypted: i=1; AJvYcCWjKbLyu4uYQ+EPh0SiMdkpkdDFXqK/1A54vkGAECq9HxmcEAiBOcc0k27jiBN9SfRyy2/LVHM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyu3XVlVvJNvRLauy2ctF/XLbc41KO9265KJzYwy6wDTf8PaJv
	WA1/DHfle0UolnwSKEfCLq3yRLiOTkP89pBRpY2DB4BpfMOLGezh9xF5s219REM=
X-Google-Smtp-Source: AGHT+IGKLPXfM66rPtUFkfPweOwpn1ja3LCHTx2W2I4nd96tds3LIExpBIYxelahGIXvBpARzXKnpA==
X-Received: by 2002:a05:600c:5125:b0:42f:8229:a09e with SMTP id 5b1f17b1804b1-432df7937c9mr4239815e9.29.1731627194373;
        Thu, 14 Nov 2024 15:33:14 -0800 (PST)
Received: from [127.0.1.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da28ba80sm39513565e9.29.2024.11.14.15.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 15:33:13 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Thu, 14 Nov 2024 23:32:58 +0000
Subject: [PATCH] clk: qcom: camcc-x1e80100: Set titan_top_gdsc as the
 parent GDSC of subordinate GDSCs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-b4-linux-next-master-24-11-14-titan-gdsc-v1-1-ef2533d487dc@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKmINmcC/x2NwQoCMQwFf2XJ2QdNzclfEQ+1jWtAqzRVCsv+u
 8XjMDCzkWszdTotGzX9mturTuDDQvme6qqwMpliiMLMgqvgYfUzUHV0PJN3bYgCZkzbraeKtXi
 GlCNnDlxCYpq5d9Objf/qfNn3H/mTBJR6AAAA
X-Change-ID: 20241114-b4-linux-next-master-24-11-14-titan-gdsc-4d31c101d0a1
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.14.2

The Titan TOP GDSC is the parent GDSC for all other GDSCs in the CAMCC
block. None of the subordinate blocks will switch on without the parent
GDSC switched on.

Fixes: 76126a5129b5 ("clk: qcom: Add camcc clock driver for x1e80100")
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/clk/qcom/camcc-x1e80100.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/qcom/camcc-x1e80100.c b/drivers/clk/qcom/camcc-x1e80100.c
index 85e76c7712ad84c88decb62ccaed68533d8848de..b73524ae64b1b2b1ee94ceca88b5f3b46143f20b 100644
--- a/drivers/clk/qcom/camcc-x1e80100.c
+++ b/drivers/clk/qcom/camcc-x1e80100.c
@@ -2212,6 +2212,8 @@ static struct clk_branch cam_cc_sfe_0_fast_ahb_clk = {
 	},
 };
 
+static struct gdsc cam_cc_titan_top_gdsc;
+
 static struct gdsc cam_cc_bps_gdsc = {
 	.gdscr = 0x10004,
 	.en_rest_wait_val = 0x2,
@@ -2221,6 +2223,7 @@ static struct gdsc cam_cc_bps_gdsc = {
 		.name = "cam_cc_bps_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.parent = &cam_cc_titan_top_gdsc.pd,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
@@ -2233,6 +2236,7 @@ static struct gdsc cam_cc_ife_0_gdsc = {
 		.name = "cam_cc_ife_0_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.parent = &cam_cc_titan_top_gdsc.pd,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
@@ -2245,6 +2249,7 @@ static struct gdsc cam_cc_ife_1_gdsc = {
 		.name = "cam_cc_ife_1_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.parent = &cam_cc_titan_top_gdsc.pd,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
@@ -2257,6 +2262,7 @@ static struct gdsc cam_cc_ipe_0_gdsc = {
 		.name = "cam_cc_ipe_0_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.parent = &cam_cc_titan_top_gdsc.pd,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
@@ -2269,6 +2275,7 @@ static struct gdsc cam_cc_sfe_0_gdsc = {
 		.name = "cam_cc_sfe_0_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.parent = &cam_cc_titan_top_gdsc.pd,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 

---
base-commit: 37c5695cb37a20403947062be8cb7e00f6bed353
change-id: 20241114-b4-linux-next-master-24-11-14-titan-gdsc-4d31c101d0a1

Best regards,
-- 
Bryan O'Donoghue <bryan.odonoghue@linaro.org>


