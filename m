Return-Path: <stable+bounces-47918-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7D88FAFA7
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 12:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E358284AF6
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 10:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF289144D20;
	Tue,  4 Jun 2024 10:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="USF08XlP"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27A01448EF
	for <stable@vger.kernel.org>; Tue,  4 Jun 2024 10:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717496103; cv=none; b=XB3hhQIH3WsPDvwgN/vmr3zEecl/LKHL4md5LnscDb0yX/ioNCjon2aSAYP0MwWLia4Fr2n4hoKSmmVxZQ04gQcS0F18onV5ivm8t2MjV4qj30QxFRi+zbRAL+GxuU7uV9HNS79w3Jv9x2ZB98qMWbKpDOfcS4BYVtcsCmeY98Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717496103; c=relaxed/simple;
	bh=TBP3XAt8f/B0YWeLvutIYFpDXuJxcaTXCpNfxe+lG9k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AGYGvtLTvPKfueXqo8HaFTQAO6DXh3GyDQOrcxXkwT7iefNFcTRHi1EDifL4zqpUpvHGivFW6gbaYZjtJukijtrCyse0SrMVNhhPCLgCPRKtwtMUJnq/45duKIRI5EicBOi9rP5ltutypQvEPZl0WnV+ryRvSpvhaDU4+W/7M2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=USF08XlP; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2eaa5cd9f0bso24094051fa.1
        for <stable@vger.kernel.org>; Tue, 04 Jun 2024 03:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717496100; x=1718100900; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ht+EiAtrF4AVXMQ1X+eklfTvkAu69Zk/yp//UkEypI=;
        b=USF08XlPWRP9tX9u+dMfQJJvOn2xgvEd+k2IzpM+Cx3qatA1ol2q/Z5NWRO1ocJJWx
         YFq+X8FKqgMrNRuWEzjimU2HjPEApA8X8h3UPuVXkbkMsX1tTV+ijv3bLOLHiYiPZfsp
         tpSdrDhA/U6Cc1Ainuo2wfB5cjbk21KmDWpVz0tqr2gCekXySRn4Siq+XIMPJztCRny2
         SfG19EbLddG/EXooYr3gIfhghCB4Eu+T069B6qX2GUNkMjpYRM2nuEtHQHyqDb0RiJbg
         3QBygUR71FbUNZ7uoupjQnfjUoXCMj6IhgXLtJJNDmV7GMaZFtgce16b3cfEWMjhmUhI
         +/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717496100; x=1718100900;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Ht+EiAtrF4AVXMQ1X+eklfTvkAu69Zk/yp//UkEypI=;
        b=C+j8+dk77Ij2YLSMDZ5f/TSIeZG2oQ+sIVUlXwi2bR73vs+8wGm4HGjXTRRzGy14/U
         c5IqngGaBei8gzkr+xiMeFE0Fp2q9SRHGLhvRO7KJpMhLtTK5xf+I0QDFCa6/KZi++gM
         iq/VqpyX2l+UNBUe2i/zvV+ltdI0FJH6UVtV5lxQPiY7/PLpvSeuZ7OlSGJ/DzmgZXmZ
         WRa/4FGwMyCqPVwFZBLrNGkyt+zAKLnJwIn5sNwLhN4Of8qXgVrOpo88KUPG4YRkQg4S
         ZBvO7DqCkg09jJem3UdWcInYFZ8Ls0WqgkEq6y9WPAaXxl89hIyPpKXsli3eZ/ix6Dc0
         MQRw==
X-Forwarded-Encrypted: i=1; AJvYcCVMgx0WO/32COGStZGSpiwfZ5jA4k9H5yKPhtdN6ImDwSy1GJeahhH4ZaJbX70FwvtaJlljG0AGjqEpYWaZR1pSovaUIOB2
X-Gm-Message-State: AOJu0YzPb97n5JrxP5VEd0WbMIGa6XibaZiH0VDXQaGmtP3WdH0xNQHT
	TLv3h7x/XbXUvBkdstUt6965zJMYCVisfv91PcfOiHTyj2XU1ZV1Bvnx9Ku65sM=
X-Google-Smtp-Source: AGHT+IGBCXH3o1Yg7+NSAzsL+koqZAOTwLk8Voa9V910zTvhBi4NfFOd0eN4WpGsU3Rb1VYGQo/zzg==
X-Received: by 2002:a2e:9989:0:b0:2e6:a1c4:4328 with SMTP id 38308e7fff4ca-2eabb7cdca7mr5931601fa.22.1717496099855;
        Tue, 04 Jun 2024 03:14:59 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ea91cf0bcdsm14715451fa.120.2024.06.04.03.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 03:14:59 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 0/2] arm64: dts: qcom: switch RB1 and RB2 platforms to
 i2c2-gpio
Date: Tue, 04 Jun 2024 13:14:57 +0300
Message-Id: <20240604-rb12-i2c2g-pio-v1-0-f323907179d9@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACHpXmYC/x3MMQqAMAxA0auUzAZirCJeRRxqTTWLSgsilN7d4
 viG/zMkiSoJJpMhyqNJr7OibQz4w527oG7VwMSWBrIY15ZR2fOOt14YBur64EYhZqjRHSXo+w/
 npZQP8Ui/sGAAAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, 
 Alexey Klimov <alexey.klimov@linaro.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=976;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=TBP3XAt8f/B0YWeLvutIYFpDXuJxcaTXCpNfxe+lG9k=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmXukisXO3vbm0pfCpPJ61Mg2y6uzFMnI2pUjBW
 IJiswVMWIGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZl7pIgAKCRCLPIo+Aiko
 1UUECACQvw5fav6UuNnDUapKvkg1aEhaNCBbXyQePxk1nupXOy5RMtFlrDmbUEbCgp7zvdkQF4v
 t2x6wDaNlCW33c2uOlITq3ue2aAsGKmW55XICrvlrTvF9CdKGjFJ88zYyzRpDLNdi01dQwF/OG/
 Lx0fngDJF8kRR/6IjdGbV99MqxhQqw1id9RWYGFYCgk+c2RgvROMd1qVH18HkqgZR98pzG8Ie2P
 aj/hZEOVG3Jjrk8tZ2KCWu2qZjnq153P1Y4vwI3gXx0yYIueavaOQWK70kLH8jSzNcSKXtD2mHr
 7cOyUpbUtVe5xx9h7++cSuP/dQnYXU8RxwMuknAM6FjuOaHW
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


