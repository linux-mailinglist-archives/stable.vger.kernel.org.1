Return-Path: <stable+bounces-191740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B63C2095C
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 15:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81BC1189D3FD
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 14:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E08D26B96A;
	Thu, 30 Oct 2025 14:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mTrQfNdp"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6B2223DDD
	for <stable@vger.kernel.org>; Thu, 30 Oct 2025 14:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834527; cv=none; b=Ug+8gEGP6IZv2I/Hf8EbOKAXJljKHHymLdKO6fvZ3JW7+vsgQzcwycEVjMKqvDbt5R7CmPQW/UU93E8f0IOQQh0mmKEVRUGomI4cPjisBsyYPpMmkUuZXOY131pgvWR+thkB65s93Lc1ouLWEIOIoqEnP6s7H40fyFq/GWZ8gIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834527; c=relaxed/simple;
	bh=wY6LNAbG2M5UsmhAu2jc0oYSG8BcgwgRl3gvCHoawYY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sF6KrJOnx4calQIk3S7opy3HFkM88FsxKFdpESogc6EiVIJIlCCHljbzyjy/j1MdI4Ov5j2v7ZbSgmAteCqw/L28tvjsliyJhTp1MBOO5oJaWe0B4eumZ4HxVZuKyJdVKyPRIW7KyL1/R8c3wRtgGRd7H2+Krxz8Gp/2Ff0YlH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mTrQfNdp; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47118259fd8so8541855e9.3
        for <stable@vger.kernel.org>; Thu, 30 Oct 2025 07:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761834523; x=1762439323; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WNmb87m3Rijz4kqOvvHn5rqCiIVcDcTIZ49w/e1XZvU=;
        b=mTrQfNdphZ8+XAdWmK4Lp2IVZwcqBvJp/J83vFW6PAPly0bG+CtAdsjUe3c09KlHGj
         XyQ57s7cWzMEH/xq0smvA3J/C7X/1hKwZJkkS0qnPynMFZuh7IRJDQT8PQ6Xho5G7yuA
         OGhl+oLokKlsA7mp9UU6ht2aPL4SP4jenEeBvu1/Pu87qmz4YdNjpBcLckCQOHWSEjfW
         mWFeo4RV1e/8juOzmsyjfzQc/fH1WYxF+LKR2SvAnoefLH5nHv1PFnUfhPT7/3GFdswv
         i45IgOSo/rWAvjoMsCm+SldrR/QnY4oBBPiVmXpY3cR7sDhExKKgrivmkzU0PhYqeoBu
         hcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761834523; x=1762439323;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WNmb87m3Rijz4kqOvvHn5rqCiIVcDcTIZ49w/e1XZvU=;
        b=ePQ6Q/pVNkEd7h3BGG0mFjNF8WBK8YyfDw2BX0+/olYMK7LquVf3n7UN15g8WIUxRB
         sbvCWJONeP6el0f1g4mQL6na7fw+W3myiuuBSfEJ8ojo/Z/UarRkEf67wJncXB6k7IrU
         JCG9kjMm1oBS172rVhbEdDweNvTVKAv/FBPmZbDyfQGBT0nNaHFH2URmB2bt95QQLJFn
         2VcRTlh7jyRAp0sGBqYbMStEtqRCUIMJ3xxbL820wxTZlQOftMe0Pz/TievWdxgr3KW6
         qjOnyeeXOXGY/df99VJKhAcP3mlpObTIpSIl0egGq93UB8NpcHZzBLI9w1lvtu65dSZ2
         xNQg==
X-Forwarded-Encrypted: i=1; AJvYcCUAEeUjdAU1iufLC9F822ftxSA3ty+VpSn8ekdAeuKdSEqJbCtT1FtFjTQgIpFRbNijhgrcWU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4EtuHfvQV0xVql7l6XvKSfvSXckk8ihTxMCcFE6a3fuIXJ+Dq
	czgIJcCerz/TXmdYjNe/xSbVwmDZAcyFbt3sO2dMB+6akKDdSZXK6EV0gLsMC7YtIcg=
X-Gm-Gg: ASbGnct5MbhivYL9GCmG991rLrzXuA2THXiDQBxStN3DjkNifDdlBy3FRwjbWtjEe/y
	JC7yaEjSOKduwc2jxAJINO0hdx7l6RmkRdEChTv+mqgUVQe9XdWDbFSupSsRxNc4/cR86BlTWBk
	13E+rPP4nRw/HD04BxTgqm4RyuTNHaBaOYICNSyO7lPtD/oSH4xtHGa5DZirSxZv8DUy0GFvBfj
	oHjVQ8aGScdPIlaXNH/b/PAwA9mHpILiVn5JrwOGDgxIgGmPXmlhO3Xp1LmBi8+Gcz2dogGQecZ
	CBjMwEmv41mlhK+GHWAgL4QE2lL/moXnE9Kak3DPhk/FU3k14Pui3VGp4AUsnkpVFcRs+pHnC+W
	PrUuazXnwJaDhi2G7Kt2+nziXppcUrROglLQ5lbHuXg0KWI8/alkW/QBiwdVxy0vpZ8ES+YzB1Q
	==
X-Google-Smtp-Source: AGHT+IF8onpXLUwHzyQwiL2ymhPUUzbiovk1DBU/h/ClaO/WmGzfHMke0FOZV4rN9zHf7Ltn2HttKQ==
X-Received: by 2002:a05:600c:4e05:b0:475:de81:563a with SMTP id 5b1f17b1804b1-477268a167fmr28644665e9.33.1761834523355;
        Thu, 30 Oct 2025 07:28:43 -0700 (PDT)
Received: from hackbox.lan ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772899fdfbsm42230475e9.4.2025.10.30.07.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 07:28:42 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v5 0/3] phy: qcom: edp: Add missing ref clock to x1e80100
Date: Thu, 30 Oct 2025 16:28:28 +0200
Message-Id: <20251030-phy-qcom-edp-add-missing-refclk-v5-0-fce8c76f855a@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAx2A2kC/43PzW7DIAwH8FepOM+TIVDoTnuPaQcCJkFrQwZTt
 KrKu8/tYR/qIZMlS38ffrYvolHN1MTT7iIqLbnlMnEwDzsRRj8NBDlyFgqVQdshzOMZ3kM5AcU
 ZfIxwyq3laYBKKRzfwPjeKa7kyApWZp7nz9uGl1fOY24fpZ5vCxd5nf7fXiQg7JN1PpGPfUjPx
 zz5Wh5LHcQVX9QPeMBuG1QMRueC7DFE7ndg9w1KlHob7BhE63pCLSPu7y/Uv0B12AY1g/yrTSY
 YnUj/Add1/QJuGDu8wgEAAA==
X-Change-ID: 20250730-phy-qcom-edp-add-missing-refclk-5ab82828f8e7
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, stable@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2640; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=wY6LNAbG2M5UsmhAu2jc0oYSG8BcgwgRl3gvCHoawYY=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBpA3YPWqFLDLRdPEjLN7eOU3AUYjAT9dLBCL3VM
 INsZMGxOt+JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaQN2DwAKCRAbX0TJAJUV
 Vj/+D/43cHxzYyYgYxsyzHDvRgZW3UY6vruvxLhhSZr/XB2X10fKSfaTPiRyNWAqSzx6eh5ca4L
 UJgBAn4W+/C72c4fAq5shr7ioPglnlS9JDYc4+4yWxSceW9PpXbLa6XnygDZ5aBZ/HpESi7M0lQ
 J7Qr50838/Kmbjq1LaTzAkTADrcf5QT9NlnlMzTyp+QhXnEmvHM23/hL8xtt5DPU4+ieSco2nde
 s/JpG6xwMP5rCozKjtbJTzD2zvtqsQZekxaASAaC5uSdJSs3clelGDznFaOO9OUtKVqLwxuyZYH
 QOD8nZ5RvgrCPSFBGDvfCYdpozeHK4pb5zpciQ2fKYX398DObj1oxRiPD7koGf209xvhmuFrUbw
 keEaDy3dFNPTlYd6deF1KQocqoAFFo61DidrvhdCZQ3G7YK062hhuEcjoTf573BVqbc2sp9UrZU
 0NJA14wUpIlYEhxvuaUc2NssA89bwhAMcd7NSKf6AEa26f2rTG3pvdZC48is+8lKx5d7RLeLCur
 b//siaBZgT1PgKy3/37q04vn1/BFC7MFsWDaB3R2jG/LOv6e19YSSYT7oo9mx0djNRI9GoB4vVI
 KakngTb73xZXt15d4Gi/1yIMv0EHabmg2oY1vujXFodJYXLE0XmyuoOBzXN5yRBHXO6Hhh4/bF0
 ooZ5xY0f+8aCLLg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

According to documentation, the DP PHY on x1e80100 has another clock
called ref.

The current X Elite devices supported upstream work fine without this
clock, because the boot firmware leaves this clock enabled. But we should
not rely on that. Also, when it comes to power management, this clock
needs to be also disabled on suspend. So even though this change breaks
the ABI, it is needed in order to make we disable this clock on runtime
PM, when that is going to be enabled in the driver.

So rework the driver to allow different number of clocks, fix the
dt-bindings schema and add the clock to the DT node as well.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Changes in v5:
- Picked-up Bjorn's R-b tags.
- Replaced "parse" with "get" on clocks acquiring failure.
- Link to v4: https://lore.kernel.org/r/20251029-phy-qcom-edp-add-missing-refclk-v4-0-adb7f5c54fe4@linaro.org

Changes in v4:
- Picked Dmitry's R-b tag for the driver patch
- Added x1e80100 substring to subject of dts patch
- Link to v3 (resend): https://lore.kernel.org/r/20251014-phy-qcom-edp-add-missing-refclk-v3-0-078be041d06f@linaro.org

Changes in v3 (resend)
- picked-up Krzysztof's R-b tag for bindings patch
- Link to v3: https://lore.kernel.org/r/20250909-phy-qcom-edp-add-missing-refclk-v3-0-4ec55a0512ab@linaro.org

Changes in v3:
- Use dev_err_probe() on clocks parsing failure.
- Explain why the ABI break is necessary.
- Drop the extra 'clk' suffix from the clock name. So ref instead of
  refclk.
- Link to v2: https://lore.kernel.org/r/20250903-phy-qcom-edp-add-missing-refclk-v2-0-d88c1b0cdc1b@linaro.org

Changes in v2:
- Fix schema by adding the minItems, as suggested by Krzysztof.
- Use devm_clk_bulk_get_all, as suggested by Konrad.
- Rephrase the commit messages to reflect the flexible number of clocks.
- Link to v1: https://lore.kernel.org/r/20250730-phy-qcom-edp-add-missing-refclk-v1-0-6f78afeadbcf@linaro.org

---
Abel Vesa (3):
      dt-bindings: phy: qcom-edp: Add missing clock for X Elite
      phy: qcom: edp: Make the number of clocks flexible
      arm64: dts: qcom: x1e80100: Add missing TCSR ref clock to the DP PHYs

 .../devicetree/bindings/phy/qcom,edp-phy.yaml      | 28 +++++++++++++++++++++-
 arch/arm64/boot/dts/qcom/hamoa.dtsi                | 12 ++++++----
 drivers/phy/qualcomm/phy-qcom-edp.c                | 16 ++++++-------
 3 files changed, 43 insertions(+), 13 deletions(-)
---
base-commit: 131f3d9446a6075192cdd91f197989d98302faa6
change-id: 20250730-phy-qcom-edp-add-missing-refclk-5ab82828f8e7

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


