Return-Path: <stable+bounces-165507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4315BB15FA3
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 13:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64BE3547A58
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 11:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9431B28BA8C;
	Wed, 30 Jul 2025 11:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l8qQddoV"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94164221FA1
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 11:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753876029; cv=none; b=VdfBa3rdnKZ8rLzwgHhii9jE4Yff0W5SxSDpEWPC4XDHUAbFuNSPBX8BZH+W2Pmj1xmyTack7wPY+F4wby2kB7HFpgMtZml0okaHdKzyQ1/lW1ATU2yuTTZOxpPqQhYsLZDKkqJlak1bL7bxtnp2kSN0y+njc3G8aVXl+3CTfz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753876029; c=relaxed/simple;
	bh=PPzsEWxbNLwJQ4PFTPPmrbQv/VqLl1WNdraoffF/cFA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pqsZ67e7ZxOi77S74BCwFu/H1fRHRhUmfBEwcCggIet0o1P5/8F1LS6Dd+8MM0MCMgt4NGMD548Fg9rSwpadkPmafJAWOplHYcYWfzkbdzszshohA9pq3vca9H/YqoUx3xeUjulVTG0mbggq4We4DwI4Q/WGNmyW9/VVwBtrDmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l8qQddoV; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b791736d12so1349765f8f.1
        for <stable@vger.kernel.org>; Wed, 30 Jul 2025 04:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753876026; x=1754480826; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gDvSgqMNHa6pK6/sHq8aMUOcGLW4HtPHI+Zx0q18Mkg=;
        b=l8qQddoVkrH36y34qntdoGTcvcv00JBN4/x+GzKXkdE4yZ2FFaT3OKuy3QOO5Ulwh9
         Ft1rlutmSuLcDdiUPwsb0GC0z9p6oQrtJA5QavlUN4BsHmTOpXs7Qcsx2FQezIOlhgC6
         ED4isJxFwtDJ+RtLDoPVxmFO4cbRIQF+StXD6BLPVHWTCMncva2HBh6OwPhcMYY6uUvQ
         rcvYVgT4lEMPhhzG+owhNu/NOFa/Of9KIWpnZPwVT1uc0KVBj9EwSjKlHtdDzc3QoUVF
         XdII5B0PBOl20Jt1L3g1tuondWgu+GmpvtO3HDvf/5FgUUoevaskSo+nxD/qprRg/iuF
         Gbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753876026; x=1754480826;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gDvSgqMNHa6pK6/sHq8aMUOcGLW4HtPHI+Zx0q18Mkg=;
        b=PNvkL9z6E4/CcF3uyfu5ntUnrV7DkSgml6JVXfqkvyAuoansqx49Io2XD3+G3/AIql
         rZIzTZsV1qoLPBtAyeqACaCu13JOxcxjy6zOqFWGcABgsEPRU59EslbpHf3HqJcihoxS
         EVgMoMU6aKLskIq26rgJHdUsoG2XOJkD9ubU+X654JRjryKMSMt9KFquPhuy8hGhDtRk
         UpbsX1Skwk0XwD8JTM4KSse+/IUKGqzSYl/oovoloi+3UMeA9LtDZl6EtM8Xzyrz14qe
         FYGQSmEzXDb015ciJCBx8eWqnyVyc1DhgSkiE2a40wbSewsWE/XGjZn1g9TUEAehSZpX
         anZg==
X-Forwarded-Encrypted: i=1; AJvYcCWJrCYNBW9gjodRPd8ykFNXJJ+BQqn2UuCgPCMHS+TGIvFtWnI3eevBc0iozS4sFlYbaH/ypp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL9EqmJe/BIxziEWHtQRxlzx49ZIsUw1O7RDLyxaElqy7qgQKq
	BjMH/fKw9mCjQ1WFvRbJWKPIyMgcihgUP7BuIHXNTVMsDo7k8w7Imlf9/H0dUnj+e6I=
X-Gm-Gg: ASbGncutChbZ3M7VeZVFil3GOn9vGHa9Vy4YC+b6DsYgEopAhMI67cFNccuQHtTb8z9
	KKsZykLNCE//tcDrI9dshkYRNW9TY7PvmjjShw9F0xVLrMxK1c5hGHiFvYfsa+0PgStdlhiGtBk
	iqdQMhlQ/lAs/BnYd5CNAhGF4JD6epO41loHTfkET4unEJyAK3GVxj9fpbhmr0jFTCaWvX1UbRk
	OLyy3fZ3HChkdTE96ONgxf7N80Jt2l0l8QITd/D2OsMBPYQFIPGt0l71YWc3Z/ShUYP/Anpnhrn
	/xCKYXeUhactXOnjpywTZcCN553K/qc8bi11GfTkFQhSxrbX3MUirwq4Il6s2ubjhdoNi4zj9gp
	sWfvDm8KOATHHcGjS4Rz+
X-Google-Smtp-Source: AGHT+IEB+YwR+DpUWl96VRVfJqnHrx70aTbCoi7WlBph+Pjdsqm+59fGnyFfLtjJThrUZcQTfhLunA==
X-Received: by 2002:a05:6000:2c0b:b0:3a5:57b7:cd7b with SMTP id ffacd0b85a97d-3b794fd735emr2401593f8f.22.1753876025818;
        Wed, 30 Jul 2025 04:47:05 -0700 (PDT)
Received: from [127.0.1.1] ([82.79.186.23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953eaeeesm24503235e9.25.2025.07.30.04.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 04:47:04 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH 0/3] phy: qcom: edp: Add missing refclk clock to x1e80100
Date: Wed, 30 Jul 2025 14:46:47 +0300
Message-Id: <20250730-phy-qcom-edp-add-missing-refclk-v1-0-6f78afeadbcf@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACgGimgC/x2NQQqDMBBFryKzdiBNEcWrSBdpMiZDa4wZkBbx7
 g7yVu8t/j9AqDIJjM0BlXYWXrPKo23AJ5cjIQd1sMZ2pn8aLOmPm18XpFDQhYALi3COWGn23w9
 27j1YZR6oB10p2vl3P0yv87wABPjbrXEAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=976; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=PPzsEWxbNLwJQ4PFTPPmrbQv/VqLl1WNdraoffF/cFA=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBoigYqr3oqVDq6QF5yX7prai0WCXSHnoIt642Xl
 k2knTASat+JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaIoGKgAKCRAbX0TJAJUV
 VhFtD/90XNK6iKLj9l8tp9cBMZHm8XpbvrPknsAXmIwTAN0bf7mbmn0O8abBJS6Zz53LoIBwsYW
 zbuIkOlJUgce7OBnWaKSXy9//hp7O7lqqstqXvl1sxx8w4fn+e2fPhCJpsmgvUkiz0msPEWTxVR
 5AhEeYO+nFuc+4qg0dwGxuM6Sh2o7tHEa3AHW/5ZiLtp/33NgrpJAu/5a0nCP2CsZDSkqqXsGMS
 FbDoEvLhsMvxOO5B/bd1Fo0etapeXDHoiVdJV3qpz9b5wWh4xcOcxwGdVoUr+6RQ2oNWKKsoANA
 e3f1XD8DMT8DzwzLuHpZO4Njrj1XSnq6fPP2xwY2T6RDczym+Z9iSn0cuUSHH+eFGXb+HuzI+hN
 AfW+hFJkA5CNLAzgc0BmkC1ubNNYJbFt0JlNikfFE5sEbJtl0ny+fEXaVS9NkNZ5yN1or03P7Gb
 5Ffmngi6F1knLNx/9PgpjghBNwD6RIKaMAPQmo1ETO2k27FlSohORP+BiYpwuKKLKdh1UMKXf8J
 y73HqxdrSrJp1bGmuY9p7xJilZiLbP8kQbSukUv4Mi0dxcOxEdN/YTRZzQjjESN2w6uou39FdtS
 5tgrktrmYUHURLI0sESp6kXhlUsLzupQQlic4ePtbIvhG+v69bQie0ZWvcbueUtk8hauJAsYMQY
 bWi6i1nKftduGUQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

According to documentation, the eDP PHY on x1e80100 has another clock
called refclk. Rework the driver to allow different number of clocks
based on match data and add this refclk to the x1e80100. Fix the
dt-bindings schema and add the clock to the DT node as well.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Abel Vesa (3):
      dt-bindings: phy: qcom-edp: Add missing clock for X Elite
      phy: qcom: edp: Add missing refclk for X1E80100
      arm64: dts: qcom: Add missing TCSR refclk to the eDP PHY

 .../devicetree/bindings/phy/qcom,edp-phy.yaml      | 23 +++++++++++-
 arch/arm64/boot/dts/qcom/x1e80100.dtsi             |  6 ++-
 drivers/phy/qualcomm/phy-qcom-edp.c                | 43 ++++++++++++++++++----
 3 files changed, 62 insertions(+), 10 deletions(-)
---
base-commit: 79fb37f39b77bbf9a56304e9af843cd93a7a1916
change-id: 20250730-phy-qcom-edp-add-missing-refclk-5ab82828f8e7

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


