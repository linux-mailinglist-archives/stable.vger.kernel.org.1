Return-Path: <stable+bounces-179047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 235F2B4A3B6
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 09:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE4264E5284
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 07:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609F530F7F6;
	Tue,  9 Sep 2025 07:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AwUVa0l7"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095BD30C612
	for <stable@vger.kernel.org>; Tue,  9 Sep 2025 07:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757403248; cv=none; b=OvIzFLXWyQF1D9Qk1I+2AtIBZ/rFFRi0dhk7PculVV8RSHuvvxVAMhSfCLKoJ+WTdde+7ExdzrbDyugYJosGNcqa2034dJtEqGVHhY40MD0g8DGV+C4IzQLM48lko/gnvHLAqmFHhEAx6qMI1B0O27iH5Zy5+2hvrWGPAB1zQZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757403248; c=relaxed/simple;
	bh=MTtQcTvsFl6BJxIcDcZnuZz6haCfFueIa1gYdkc1MB8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CffdQFzjMaaOEam8N87gNqc/6SasoNg+Pmo0mH/MvS0n+uqnksd5TqI3704+e8lQ/0li3b8hiA/POW2bVOkgGHLjRu4hBYCi1leMdy10k2GqgDmPJ1AIjlnZqs4VeYONJvcgWROXsKKUlo98S6S1TfnrIm1gkngSoGI7pfTWptE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AwUVa0l7; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6228de280ccso6130416a12.3
        for <stable@vger.kernel.org>; Tue, 09 Sep 2025 00:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757403244; x=1758008044; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i/1NLxMBX+MAh3xYLikiYbFyJW+a2IOC8i0oc5vP7Nw=;
        b=AwUVa0l7EMNtaeVKF4dB47sNnwkFnyj1GfOVZhD7uo9GIqo61k4iDwTVU1wlzE6XS6
         QITxGo5AHe7/9mritnzgB8YwPwgbpV49S7xAjY9jo0MyzJOARBAoFzml1eZx++/CKaPX
         qYw7R5VVdqMun4UOVTuM76cidUEoBdignls1zM/8Y6mOrmzh7Z5GSd4npNjoKrhYrhO9
         b4/ppMbdrEkTHvPoirySmZOaP7FDYFjNm0CM3yE42jL5OkuDy5wSdvl173BbEDtnFyHc
         SdPTyjXOOurdRhoVGCsRgjxqL0sgTw8rM5ILbxjuXBW/iCfmcdwCgGpIpWBKE2gm44xp
         c+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757403244; x=1758008044;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i/1NLxMBX+MAh3xYLikiYbFyJW+a2IOC8i0oc5vP7Nw=;
        b=elIvXYYQ4YGn0Fy/n9E6onlGKa0uv7lddmEej/gVi+4aMyKVREZRqhSH55ICobhf22
         bvzk/yUW29/ttnkceY7P/SXjzEBLHXpgI94Lna3QkUR3W/Il8ZUHwqealENgRM/LgnZ8
         YqKfa75xTS9xuiMTxc7UjC+gGEGBqisarWqFOT24+lAdvIbgtjiCINm+QPimJRWIt5os
         9iyol14/OBWcycrgppOY8H5GKaYXsIIbEFHYde8rvJILVCzgBtM6THU+mm6BrD2Vb1Qf
         SonAm/ZcoyO6nK9GbvWNdQA4EFGnX5heXdOGtYifaL+wueNKNpM8lMAmXiFKPAA9tCUR
         8Z1g==
X-Forwarded-Encrypted: i=1; AJvYcCX2CkR45LaBdhcU3mCbjKAhMBhCRBCPqbzEdyraVcA9eHJ5aOmzLFnw1Qpp0HIloPbROocuicM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCAFXEP38eBJrqHxSzCqFAbXwaP6aNg7WuzCMrlxaUVwuux721
	lC/svS+wiMzFI6ft6Tm5IcB5wbM/P67oPAeHIYDhUQiZBEpvFwgb64P4UBCUd53cnJXd7hLDj4E
	X0v+x
X-Gm-Gg: ASbGncuO3Ei4cXXwCrFvApSvyYbeO61ty8BjTbSHEXetat/Oo/hE4kb652f+Jw90uSg
	Nf2pUKCuoZvvkz4m2HIyZcTY7bQwexzslgxz2/XinPa4A9PHG5X0mrbyTUagpKeeSzphR58H9uQ
	w3+ROP6Jyqp/Pc9X3qVUUq/BSwqp5PSYeYCq6WE5d+Apz9QujweM6yzGje2d4i6CmouLh56mNXI
	atG7YH5hHqNYUe8H6IiRyw3PWwHVuwQdZqOouVJCKXrsErXkX5VawdCB8HuvO3EQz2Kbi3kZivS
	VBthDqnL1W1/cj/wy9R4qLlzkqF0vr/cOnf8rRLFRoxVr8IU3/JYiFSZfW801GC5hQeYUFWRwsu
	ZW52Gr38fkKHZlMOG43TABnCp5DyrlBv9kEaRibAfwb7I
X-Google-Smtp-Source: AGHT+IGkhJLDbobgy2C5BuMSZlcQcqtyLvt/MH/bODV/Hsxj6fUv8CjpszsAijwFStZHJf6wNxnCIg==
X-Received: by 2002:a05:6402:2790:b0:61c:948e:59cd with SMTP id 4fb4d7f45d1cf-6237edb3818mr9962943a12.24.1757403244324;
        Tue, 09 Sep 2025 00:34:04 -0700 (PDT)
Received: from hackbox.lan ([86.121.170.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c6a264285sm226976a12.2.2025.09.09.00.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 00:34:03 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v3 0/3] phy: qcom: edp: Add missing ref clock to x1e80100
Date: Tue, 09 Sep 2025 10:33:32 +0300
Message-Id: <20250909-phy-qcom-edp-add-missing-refclk-v3-0-4ec55a0512ab@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEzYv2gC/43NTQrCMBAF4KuUrB1JU2qjK+8hLtL8tIM1qYkES
 +ndnXYjrpSBgfcW35tZshFtYqdiZtFmTBg8hWpXMN0r31lAQ5kJLmreVBzGfoKHDnewZgRlDNw
 xJfQdROv0cINatVLQOWkbRspIPb62hcuVco/pGeK0DeZybf+3cwkcDq6RylllWu3OA3oVwz7Ej
 q14Fh/wyKvfoCDQSKnLlmtD/wtcluUNlYJH7iABAAA=
X-Change-ID: 20250730-phy-qcom-edp-add-missing-refclk-5ab82828f8e7
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Sibi Sankar <quic_sibis@quicinc.com>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: Johan Hovold <johan@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1983; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=MTtQcTvsFl6BJxIcDcZnuZz6haCfFueIa1gYdkc1MB8=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBov9havRs3r52gUJUdKpU0j7bzrJpwOZVvDL49O
 z+L6hX8XRaJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaL/YWgAKCRAbX0TJAJUV
 VjKVD/41QcU3UdZITO4EEcZsCNvH9FFL5wTJXLkBVSsQiOKRN0v+t2zm/QNF6CijyEDiRuHltZM
 B0zu8pP5LapLU+NvBBKNoZk3//dzgqice4fUqggd7ELkaV/VP6uIpjYLlDKb3YTHdiI/6egOqHr
 rnAfwfdvBFLTHNu+QDyc0cP+AvvjcmtVdedX0dAW0djpLvI3ek4/89/4tVS6rQ9Dr6onukpSV/o
 1DXcSSFHDsc37Vua0RbUc8piq7Dgz2rBrA0Vi0uzTLTYmhMrmaMv835xj2Pdtax6sGE7d+fi7H8
 HnsqIbJZ+eh0egHv5xg2XOfmiZirqCEYPl2Q/HYn+LqyFtpcSPHxoacfm3DgoYoLzUSC2wdBCdM
 HA5qXCEq+0oYTiyJro5Uyo2EACoW5HvLkt0FfhcB/MaCSFeZby4ap3SJ4fF3t7fohKabdeEN+nY
 EjXve4k4M3Zrpu2PfGxa343RIbbL7ICqP2QaTdN3KC0I2qzstRwzOb7YYN1vLMH2amCloR2s5Ns
 03PWDXyHx3jIvU2LU5ehi9hPTewS0e6UDGcF3ANQBq3O8w7SXgM/o/mOjDQ+Var+lYUTjiTn7xD
 DiNSIpByvn9PExEmrD+spROm2O76wI4dKI6EtVtMoMIAhysE4eaQJOACIBkRj+Vgh3b5U+drmyl
 mzK6SXkSBKDfzCQ==
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
      arm64: dts: qcom: Add missing TCSR ref clock to the DP PHYs

 .../devicetree/bindings/phy/qcom,edp-phy.yaml      | 28 +++++++++++++++++++++-
 arch/arm64/boot/dts/qcom/x1e80100.dtsi             | 12 ++++++----
 drivers/phy/qualcomm/phy-qcom-edp.c                | 16 ++++++-------
 3 files changed, 43 insertions(+), 13 deletions(-)
---
base-commit: 65dd046ef55861190ecde44c6d9fcde54b9fb77d
change-id: 20250730-phy-qcom-edp-add-missing-refclk-5ab82828f8e7

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


