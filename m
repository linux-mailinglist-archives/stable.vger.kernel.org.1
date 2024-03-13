Return-Path: <stable+bounces-27559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5326187A203
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 04:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05F4D282D4F
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 03:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526DA10A1F;
	Wed, 13 Mar 2024 03:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iOzrJosK"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DEC10953
	for <stable@vger.kernel.org>; Wed, 13 Mar 2024 03:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710302065; cv=none; b=CBN9nBDqYIjrGbq0SBH/ccgMH0+TSLyzpXNCkadvb5o0wwJOpUeCh9GgX+s/ONhfO3Cv8v1mSNz5ehdeBWqtzms0qODXm/L/6cYIDTgKbz0k/JPco/TAUkK66QhaKM6xDg8rV5mHlqpVlbjV2Svl47q0R2zR19c+p5zjReFwmmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710302065; c=relaxed/simple;
	bh=uuYeQvYvdPa6xmGP869tkZ5w3Kz9K6rlx7X6sdK7szI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Mrga1K1u4benoJCwH+lqvP4qxpIzpzkYfXzMcbhP6JAIv5x9JfIg4hfP27GX03qy5TENt/SrqOaI/bZF2o5mKdmeXSLzPp2J0l40/kcg5fSkVaV5G6X5ba5UOaCEAS68SA6OPBkKCjgRTYeOlttOkjTD7HPs6QFt3OsSDuktdLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iOzrJosK; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d23114b19dso10171161fa.3
        for <stable@vger.kernel.org>; Tue, 12 Mar 2024 20:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710302061; x=1710906861; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ul9kMS0dDijopmqealloW1ilUpaK8SpmQOuP6iZpG7o=;
        b=iOzrJosKf/4P2vfyFYxlGjdPDMnBaYb0pZNWChh6287FnZGgiVGyyqm3mnTcP9V8l+
         VMBB98sLzN8nYTTq3y/400VOfbHLiPxey4T32uw0Cjp2c7WWV0q9MPpyb0rDcvZ1S68N
         AD9JPRT3RaDVMtLAW2KH+7xbaHFNe680yh9bnuErvHm8w/a1Vdsd4ez5K5CRpm+fPO4j
         D5P2p78jTzqjkvbRjWGyORTiGoIa4YX1v4yClJArHEzwni8CmnWhmcSx83hqjydPnaas
         MFu8QtvPakQ0k/krM5rNZ2AFzsffXXnOvlqNf9idvx9d6JrEqHbuhNyJNW1G++rRFMH9
         ynSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710302061; x=1710906861;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ul9kMS0dDijopmqealloW1ilUpaK8SpmQOuP6iZpG7o=;
        b=rZBdG4aN77jfeLZnyyOXsp4Hscvk5UEEs/C6oTvQ2FmtC5SUz9qtcn55ETbZM3kNrR
         yyFuiC/1USi+6B7UULZIxLOqiLYZ4t5zAPB8uWEk0d9HmtVqUlMy+W4Xd/uDJoKlIbWx
         Llsp++iMYuFLBrq2vCeyMUxYpc9yJD9qDLlH0dXjZI7IB4wKCgVNd//BWXeP64xDhi38
         ittasByWaFhLd5nAqv3Yr/BFuv61plcegEQLDXGgb4Nk9uyN1fk3ejeRUlswXci02dM6
         zGyWwY1Mr+Jsjquf3sjaZ9B3BV8FyRH+pPmcbiXqP69u290IKXp1EA2shSJw1dqaHDv9
         d0IQ==
X-Forwarded-Encrypted: i=1; AJvYcCWevcKSatFG3Bx8Fl1sjr47dwSEu0TPECscngnmtJRCuNCyfWjIkgV9XzgZyV1Ajl5XR0msg81LQVrEAVuvU6HGDoJU3beG
X-Gm-Message-State: AOJu0YyCjWFN7gC6I9BSvyLWR8uy86ngDI1mPssdEreTdne1yuPi+uot
	DkzlvhBKInH2mYsi5z5I/89c4rL+J8s3qjsm2u4z+/CseLAFFSjvkt9WDe9SxiZ/1X98R6DcpBT
	m
X-Google-Smtp-Source: AGHT+IFFWO0p1YoK78R5xGmkweZHTNPWCkFoHXOWekR/ioaaF/xOmbY+3EHSZ9Lmr/mIoMKmse9siQ==
X-Received: by 2002:a2e:9cd4:0:b0:2d4:54dc:28e3 with SMTP id g20-20020a2e9cd4000000b002d454dc28e3mr2747237ljj.28.1710302060670;
        Tue, 12 Mar 2024 20:54:20 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id f25-20020a05651c02d900b002d0acb57c89sm1854319ljo.64.2024.03.12.20.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 20:54:20 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 0/7] usb: typec: ucsi: fix several issues manifesting on
 Qualcomm platforms
Date: Wed, 13 Mar 2024 05:54:10 +0200
Message-Id: <20240313-qcom-ucsi-fixes-v1-0-74d90cb48a00@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGIj8WUC/x3LQQ5AMBBA0avIrE1SRYmriIXWYBaUTohEeneN5
 cvPf0EoMAl02QuBbhb2e0KRZ+DWcV8IeUoGrXSlykLj6fyGlxPGmR8SNHXTTro01igL6ToC/SF
 N/RDjByyx2sNhAAAA
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Guenter Roeck <linux@roeck-us.net>, Bjorn Andersson <andersson@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, linux-usb@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1153;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=uuYeQvYvdPa6xmGP869tkZ5w3Kz9K6rlx7X6sdK7szI=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ+pH5azXzEv/mU/YY+XI72Umr/rxs/apdoM7X0MX5ZaJ5
 Ypxs1h0MhqzMDByMciKKbL4FLRMjdmUHPZhx9R6mEGsTCBTGLg4BWAije0cDDM+yrCzKq48cYHp
 1IP1QT+EHQR5wxh+3NTr39h6Z43ulx8TV2x51u8rK6AgeNW7irNLblcKz3reBZvjeHdYtUtP18n
 WXdzVu9Ln1CdVxy3ppvJJHUvX2Sxct2Z/+sw9xRmZ75tOSsaoi6lY8LuKPPmimbZB/Pr+NBmLqA
 Mz5aNP7PJbd0zmmMtbvmAlrbVHE6teepWpOHRN27fIWUaT1yc2M2tyIf+i6c/vNxlOTrS7MLMyz
 JBvmzffURf77w9bXzgsusqX8Lvf9kWj5BHPkutnzDY2n5CsF/S5Ybw0wluDN0Dkepr9pSw17cBf
 pUYz9gnZi066UuLGdnqtjcPuyPd9M64YWJW3bJX/d+YlAA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Fix several issues discovered while debugging UCSI implementation on
Qualcomm platforms (ucsi_glink). With these patches I was able to
get a working Type-C port managament implementation. Tested on SC8280XP
(Lenovo X13s laptop) and SM8350-HDK.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (7):
      usb: typec: ucsi: fix race condition in connection change ACK'ing
      usb: typec: ucsi: acknowledge the UCSI_CCI_NOT_SUPPORTED
      usb: typec: ucsi: make ACK_CC_CI rules more obvious
      usb: typec: ucsi: allow non-partner GET_PDOS for Qualcomm devices
      usb: typec: ucsi: limit the UCSI_NO_PARTNER_PDOS even further
      usb: typec: ucsi: properly register partner's PD device
      soc: qcom: pmic_glink: reenable UCSI on sc8280xp

 drivers/soc/qcom/pmic_glink.c |  1 -
 drivers/usb/typec/ucsi/ucsi.c | 51 +++++++++++++++++++++++++++++++++----------
 2 files changed, 39 insertions(+), 13 deletions(-)
---
base-commit: ea86f16f605361af3779af0e0b4be18614282091
change-id: 20240312-qcom-ucsi-fixes-6578d236b60b

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


