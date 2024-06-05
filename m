Return-Path: <stable+bounces-47980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A94FF8FC714
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 10:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C58D1F218AD
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 08:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC7218FC65;
	Wed,  5 Jun 2024 08:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nEsET9M1"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B461946CF
	for <stable@vger.kernel.org>; Wed,  5 Jun 2024 08:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717577767; cv=none; b=K30NN/CmYBUvJWDZMNgRDbounluh3t06xWq2uXv6S1T40UHSR4U4obvbpl6Ne0uF+9YIQcMy9wFXF/+YSpryaGcc6LaqqSpYYXUolX/lxNC/edJIxaJXqVOq1tp8ZXs7/s54fp9SYj1CraNNgqjC0xJLlvvoFWx3HLBi7TE8FpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717577767; c=relaxed/simple;
	bh=xOYeUtw/UrZkiwEhcQuZluKYKEI9dexCcW4rGGwOeHc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=R5Q8yrtGhM7q5BkRe0VAG9VimPT+expBLevh/hEINX0IMUUqADmmEegmZxc5QuEZ7NeLv9QXOktjHZvYWbHvCk4h0puhQSoGK8W5V3G8ayF6D93h5Vh4uIyjIjhy8+J4x4fCKkXtBjMdLT70tCkzLOFmTAUlykFe6UJ//mbhHtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nEsET9M1; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52b9dda4906so3338322e87.2
        for <stable@vger.kernel.org>; Wed, 05 Jun 2024 01:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717577763; x=1718182563; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lHLl/hCHdDCG5NBFj737FnwNcxJ7NpWDQhOF9GIyiOU=;
        b=nEsET9M1JQtWU9yjdArPwN4rxULHKjCfJsFAlk1T2gbXpo6g8SPqAmK6gOD8XNhhOH
         vmGBJjda6ilMX5jfb8bvhzijQ7Hr9p6TQgG+a72MrhmUPtnAUY8zlNrOBC9wTJaaOWU3
         tzvKi2FECxwchGuS9AfXvdhSy3uP6UzFUV1o1lIgOvG7B4ekgBO7BlR1z53eiAX7aq3o
         CmqF/uqQmXrlwZOiGAIC0IAowkCA8uX9mpiCuY73lIvQahCywv3txpQN8btKsn6JXon6
         3oRDsEAUirkqAe8okDhHwSKgr1Fw6WZRo7QCCO+iCUxFstWyqfvMbegvrniPTrMAyFyF
         tqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717577763; x=1718182563;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lHLl/hCHdDCG5NBFj737FnwNcxJ7NpWDQhOF9GIyiOU=;
        b=UK7wC/xrDToFlBCBMxUDr3R6LVBjvPBN+Wfte/Gbgj9sHbBNeITnN4pcjrTBgkg4xj
         cHJrtxL9gkJZ0p+p33a8BA8aZ6baV0cwTyeQiQnxVj5w9ObX7wh3AfkN1PPoay4eEOUb
         4kDgqmN3kqlXL8mLIe55zzGiwc6/DmfC4d0yFwJIOhAPNNDswkh4XThWB68Jdkap0ucD
         47FXjXhMhhiIMKF/JNvI8j/ysYJP+HvFSGOijbNdXlPPf5YU+H0wbd3FqFTFelrtniVe
         UMlRsnMvnlLXGP8KWalPXC5fMEjKE6XM6+b657V8uF5tfOwMz3O4LrZBjbdsmOBBFztc
         0yFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXRTzGjexCs4SbQ1zozNYgF25dueT8K21CNSooskCXuX2egd8ZFpURFxMlQYXJYgEP0pZTbtqJvDCTPd2FqVJQAxRlW8sj
X-Gm-Message-State: AOJu0YzS4i2ELtwRBERSwV+g1UWL1Ii5nMqNKsXkC+v8kf3Df4bSP3hj
	CXovJacVY7HaFNJiV45Ua+jKGgcY6PxxEcZ/TMM5vP+f1tOQ/cZo7gqjEvJWSZ8pN57QAE632oh
	c
X-Google-Smtp-Source: AGHT+IE1f5FanRJ1v9H2+kc+wOL32amVvO+x7fFrCJfbkzPiFrWWTdUh3tLFQ9ZbmhFVgr9EQfgPOQ==
X-Received: by 2002:ac2:5227:0:b0:521:e967:4e77 with SMTP id 2adb3069b0e04-52bab4e8b99mr1318178e87.28.1717577763183;
        Wed, 05 Jun 2024 01:56:03 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d3f55dsm1715321e87.72.2024.06.05.01.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 01:56:02 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2 0/2] arm64: dts: qcom: switch RB1 and RB2 platforms to
 i2c2-gpio
Date: Wed, 05 Jun 2024 11:55:55 +0300
Message-Id: <20240605-rb12-i2c2g-pio-v2-0-946f5d6b6948@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABsoYGYC/3XMQQ6CMBCF4auQWTtmOiAIK+9hWCC0ZRJDydQ0G
 sLdrexd/i953wbRqtgIXbGB2iRRwpKDTwWM87B4izLlBiauqKYK9WEYhUf2uEpAV1N5ccPVEjP
 k06rWyfsA733uWeIr6Ofwk/mtf6lkkNCVXLbUmKad2ttTlkHDOaiHft/3Lyn4F/utAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, 
 Alexey Klimov <alexey.klimov@linaro.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1151;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=xOYeUtw/UrZkiwEhcQuZluKYKEI9dexCcW4rGGwOeHc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmYCgiB/VtaFHXC/qtLOr4Qw/YA9dgjSlyStAZl
 fsirDvhCFWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZmAoIgAKCRCLPIo+Aiko
 1SUbCAClRploP4ik86pltL/NkWfnLhFLBydG4je7rHAnCrj7FalYpiGDzOCGVUZ5NblS8jPCnDT
 QMW3qy9LwM3m38bf/ZiNKL7rvH6JqoBymyl1vl8We4zFJOhfto4S8zbLocIhlI8+Dm6bbfakAES
 7oF0CY7DV0WQD+0Oz/Cxg6qkfxEeSjn8+B4taXF7TY88QNU66WbH96+w4juBheovolOeHC/yR8v
 IW+JDB+1j/Rptvd1BhbHgF5XShrXpvL8JqSWrDGKyG6ryRuubRRobl0NQmh+xJHXnDpgXJ516r1
 mLFejs5CeviJaMvgrBU+E5IB2WATMpCxrbWipw86WLrkspVv
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

On the Qualcomm RB1 and RB2 platforms the I2C bus connected to the
LT9611UXC bridge under some circumstances can go into a state when all
transfers timeout. This causes both issues with fetching of EDID and
with updating of the bridge's firmware.

While we are debugging the issue, switch corresponding I2C bus to use
i2c-gpio driver. While using i2c-gpio no communication issues are
observed.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v2:
- Fixed i2c node names to fix DT validation issues (Rob)
- Link to v1: https://lore.kernel.org/r/20240604-rb12-i2c2g-pio-v1-0-f323907179d9@linaro.org

---
Dmitry Baryshkov (2):
      arm64: dts: qcom: qrb2210-rb1: switch I2C2 to i2c-gpio
      arm64: dts: qcom: qrb4210-rb2: switch I2C2 to i2c-gpio

 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 13 ++++++++++++-
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 13 ++++++++++++-
 2 files changed, 24 insertions(+), 2 deletions(-)
---
base-commit: 0e1980c40b6edfa68b6acf926bab22448a6e40c9
change-id: 20240604-rb12-i2c2g-pio-f6035fa8e022

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


