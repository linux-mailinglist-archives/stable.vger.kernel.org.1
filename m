Return-Path: <stable+bounces-165540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D34B1646A
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 18:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 286FC18849D5
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 16:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B1E2DECD3;
	Wed, 30 Jul 2025 16:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kM/rN6Yg"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EE52D9EEA
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 16:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753891898; cv=none; b=t5DZthUc+gtRBENOm06Rk7Op0opbTcBXmP3QTgTjykw9imROEXWTG9Sbh3woexWVW7UiOx5SRQVQhb0bQ2vsD/dB9FCybTorOd2OkDZ0Y+64wRSyIUAKu1Uu9cOuN+5uyz2Q/JpuMS+HdgKpKcGIBnK4lI4ayHbYtClDEWJvb9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753891898; c=relaxed/simple;
	bh=Fd6r5ej70Gx78OKCjT5dW6+hePHwHbsPkXWk9c0URgA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jSrUjEez7fXhER5kKreFFh8nBwyGbWN2261hie2vwyVNFUuV9XEeKCDAuAybi71LR6VzSZURjgm7RvHBofU68DoTjGy0dtO/rd5C7p++1NKMnGS3FnzMi1ttVYPWniXMubm9u1gsdhXXTA64ZHnvDF5nA2z45bZRe0/JotJ1cr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kM/rN6Yg; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b7834f2e72so2560067f8f.2
        for <stable@vger.kernel.org>; Wed, 30 Jul 2025 09:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753891893; x=1754496693; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UqOwZkurxN6DP6mkxJOVh++qBYZQgQgS3fnY4YseNNE=;
        b=kM/rN6Ygq+MbGLfNlLSfID9cDiMBbXUl7HwR821U5p2PPPqDzdx5yM59aZ2Wbk7GMx
         JB+BlZXR2w9fJJuT4y06UbbaPpRkJY36DapfqAb5Eujh+8sTgxgDN/VCLu5CHaohyaDS
         aruFlH7L94VUUD1YNg0RD6A501uPDqWaSXavh+3gQ+XVpOkSm7J3Y6zk9D1XFx4ZPTOR
         f3X0iGU/WZZJW3OcbMl+dIAkLtaB/8lFGP24X/yBMpfKlk32Nt725UBYrptuQT6OWeoJ
         dSgqKnTui95Ro4rL0B8myL264+jxYPKGLfkz+nkbLpM0g6vbZZ8NJAs/sHThGzbLeeGW
         fy6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753891893; x=1754496693;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UqOwZkurxN6DP6mkxJOVh++qBYZQgQgS3fnY4YseNNE=;
        b=Lo5Q50Cl9+foKFAkSzVHtg7vItQG+En0hY/HMCN/gpGpxc7ffwdtLuB9kuBP80xbK1
         d7k71//XWNrVefuWDEr2APea96LdioZxpmOEYtiI8T+6UzDTBKrNpzBlIWtcgUzBErXX
         jUdE3KLmH4yskWtQIqYgZcMfll3I9VZa1uUw+FGZv3LGjz8rCSqnu3OamTwwvFm9cpUn
         lPeyOV61AaDps07hY1Lv2mKFhJD6tFaehlXiMkLY1HnLAoYkAhz6RwkERQI6zCd0ARA6
         eMcGeOv4D621TxCVoQ8e4RFa28WjgneT0hfrYuA4qKK/MxB/QTdVI77HjDIK2ihWu6Ow
         dDLQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7s8H9ny+vRTzRa97syndK3bcIjSctgayV/RQ659AQXvAqvtcv1YTEANESgd6Pey7t6iYk3eM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe2Hka81n1SH4eojBrU70Wu6Caze+At8MvZeIPo5WcgZWBc0Pj
	37+3SIeuLZMkGyd0BcvR9/6gEoMyhVQ3N++zyF2SR8pm4KgOulbzS2Yv5tjBAr2X/dU=
X-Gm-Gg: ASbGncsqYaPuRGIYlnPYT6lPNtoh3kH/AOV0YUh86Ga2CNJY+GziGuJvlV3jq87AU0r
	WoRKjvRGBGhWu/E1fE6RJ3eFynrrzf3jStVe3RYtBg2PJFAuMg0xZ1bXIVQVTQGNzXUSXyCETDM
	49JImeb2w18/8NEwCGtWbFfAu3OSftNvjXBinC56asXVz2fmNpB9/2i8kVos7IH5bw/KSrhdxKP
	vHd7436dXKvDFIDE9ou3vkt+6mXug0jlnGuc84jAdiDjxkhPtHiEjpKmLKcoAvhEV29YiOg9Qnq
	OU5QENh0FEOQWgPW0u3knWy+9j/GuTOQTT/EgqxHVUxHmRoIPM/Nq3b0K/79a3qkM+qcxZQBIeI
	D8HgUxqgw+yy5T+LMbMTP
X-Google-Smtp-Source: AGHT+IE35Ywlzmt6bKCd2ef14MK+xws1qwAv8vwYO/BNrAHqXdxEW1CdRvYO8omT7ooIKsh8esKQuA==
X-Received: by 2002:a05:6000:1a8d:b0:3b7:8d0b:3282 with SMTP id ffacd0b85a97d-3b794fe90damr2754479f8f.31.1753891893243;
        Wed, 30 Jul 2025 09:11:33 -0700 (PDT)
Received: from [127.0.1.1] ([82.79.186.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b78acd884dsm9164564f8f.33.2025.07.30.09.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 09:11:32 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Wed, 30 Jul 2025 19:11:12 +0300
Subject: [PATCH] clk: qcom: tcsrcc-x1e80100: Set the bi_tcxo as parent to
 eDP refclk
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250730-clk-qcom-tcsrcc-x1e80100-parent-edp-refclk-v1-1-7a36ef06e045@linaro.org>
X-B4-Tracking: v=1; b=H4sIAB9EimgC/x2N0QqDMAxFf0XyvECqdMp+ZeyhxqhhW+1SEUH89
 3V7PJfDPQdkMZUMt+oAk02zLrGAu1TAc4iToA6FoabaU9sQ8uuJH17euHI2ZtyddOSIMAWTuKI
 MCU3Gn9b1rg3+OpKnAOUwlV33f+z+OM8v1KcEPXwAAAA=
X-Change-ID: 20250730-clk-qcom-tcsrcc-x1e80100-parent-edp-refclk-8b17a56f050a
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1272; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=Fd6r5ej70Gx78OKCjT5dW6+hePHwHbsPkXWk9c0URgA=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBoikQn1mpNTbomnI6wjUQllPAQi1cNsItik0+LO
 NhyFErPoFqJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaIpEJwAKCRAbX0TJAJUV
 VqdED/9TUcuk43y0Rv60rmuHzWZ8ypABjV0pMT0RaclplWU0Wdlf1KPt4twokPE4hWzS4QO1oB0
 Q3XhvFPTgYWujJfcQnJxWKwCnJbFfmpJCDga5f5ODbrv1BDvxEJCGB6vPiYO30xLlRx113JqZhW
 GhKSbCuo7ofu6otLGjpkPYGGe68rbK/Pb1ePYqUOqp4/mgJSo8Rgqg6+h67oUV5207B8fn9K+c0
 ln1th174V9uipBKGSRYpSkrx5cfNIaIujPc/LQT4s8ynjy66RpbIe6Xkgilnons33PbCIawGeGE
 BVZY5YYLinXYl1D5H/VHm0xGVHz1eE27Ch4Vx6fy+fx719fXDCRHlFI5U9D/xyp+E0OmykfPZ2d
 q57P28jFeJntrmDz28Lp1mB3TWMN8QpbUMIUOUz+3ip2mKYkytplWY7sG2UNS8MZY2jhptZfF02
 F2ABNDdc9kY2+VHanWGWwtYh0puF/NDYyfeUAAJhw0fRbbet+ab7wT1GdYnEbsufh5hjXnVirIk
 CFur6uOQ439azeVH1zxRTkFAeXguQg/3rpxJU8KAhHpatXZHz+INKc/Cg1QxOMXACW+kbZcwHOS
 JbN3W49T3M8ziNDM5Z+1uStqzEc1dHNFgKmZIkjvyfznBuKEqg2dkTr4eyFHnghbZYR+hLmD7L0
 XjCZTSzqC+I01zQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

All the other ref clocks provided by this driver have the bi_tcxo
as parent. The eDP refclk is the only one without a parent, leading
to reporting its rate as 0. So set its parent to bi_tcxo, just like
the rest of the refclks.

Cc: stable@vger.kernel.org # v6.9
Fixes: 06aff116199c ("clk: qcom: Add TCSR clock driver for x1e80100")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/clk/qcom/tcsrcc-x1e80100.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/qcom/tcsrcc-x1e80100.c b/drivers/clk/qcom/tcsrcc-x1e80100.c
index ff61769a08077e916157a03c789ab3d5b0c090f6..a367e1f55622d990929984facb62185b551d6c50 100644
--- a/drivers/clk/qcom/tcsrcc-x1e80100.c
+++ b/drivers/clk/qcom/tcsrcc-x1e80100.c
@@ -29,6 +29,10 @@ static struct clk_branch tcsr_edp_clkref_en = {
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "tcsr_edp_clkref_en",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO_PAD,
+			},
+			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 		},
 	},

---
base-commit: 79fb37f39b77bbf9a56304e9af843cd93a7a1916
change-id: 20250730-clk-qcom-tcsrcc-x1e80100-parent-edp-refclk-8b17a56f050a

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


