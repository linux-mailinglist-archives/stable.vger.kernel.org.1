Return-Path: <stable+bounces-81160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CD19915F4
	for <lists+stable@lfdr.de>; Sat,  5 Oct 2024 12:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B11952841D8
	for <lists+stable@lfdr.de>; Sat,  5 Oct 2024 10:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C19B148FFC;
	Sat,  5 Oct 2024 10:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="luA4lAtc"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8131E73176
	for <stable@vger.kernel.org>; Sat,  5 Oct 2024 10:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728124272; cv=none; b=WmJEpJ9xxUKqzVGArEQ/cGTJrmwHa3QfClXrT9x/ei/yrcZuBJt6vA5IZr6jd+k9/5nT7kI3aGA5UfckgJFLILv0GMBzAhe59z/JOwp+9G2eCa875zWQ9itF/4CYjgd0IUcddENZky4HyfjIntD5uIEwYcOoh3WaJ4WKbNMmZBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728124272; c=relaxed/simple;
	bh=Pij+6FhctUgT45PYcO9Wc7sOysLVBbXPyPt2wqIlGhA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gN9IODmLebRU4bUFo8/1r/AcYw/fkCfSpvkGLe0uguSINIJAlMW6YrdGlYxXL36kp4IdmovKyPbHEJi2Z4HZrZD3z9EK7I1j1OcGYd6lpfy3ngqDPJwOrHbwjWKkpHk0tW19c8L7ET15uFOezlvmRfeWoVi8Ktxp78RS5LbZpYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=luA4lAtc; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a99422929b2so17363366b.0
        for <stable@vger.kernel.org>; Sat, 05 Oct 2024 03:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728124268; x=1728729068; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p2Scx6qIga+XDSP8TrnSyjUo0WD/tL5TkvTo8bpNEJk=;
        b=luA4lAtcOtLI/jjNZFqGE04eeuOF2zCotJwNkej6DVZg3e/p7RUTJ6xIVkr23kukDM
         nmhS6tEpkdkAcJHSPyB46E1WppxcafBBO0DfkCxxvR9gVEwB4b5LKKIs5Yg8ddwFU9jM
         7MAOzAEwl2XS2aEjmZbZ2r73D4BOXkCLJtjrAMvZ08q3wO55TR1NBjWMrJ5UBvzfSUVZ
         A5NZJ2Y6IbhZeRUO8/4Cf2rxYT07Efi6gJnVzuhnLlWjglJYpiZRwFRW4yG5vEgQVlgO
         +OhJv4fE/q7sYZ0AWbsIXqIcK+vsGLMv9W/1ZK/uOTLFXexhIsuUssSNJpU0YYCuxsC8
         VzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728124268; x=1728729068;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p2Scx6qIga+XDSP8TrnSyjUo0WD/tL5TkvTo8bpNEJk=;
        b=Vdq3sw91haY1wsefxIPGY1zcDCtB+Qk0osS+k3Xf4bPZV2LNhWoSaP3Mebgd8m64xr
         2sgaSLk5190NiolxKtdeXHr3jns/2gE0eWXhsK2znQC4nZIXGiBbNcdgz7k64LooOiGM
         s9vNdgOreXwM038zucEPJaD6Gqct8riJQhTxPKpR2VnlytU6+zDYQQ2JGg3WHteZ1YoJ
         WoQsxuQIUlGV3qqruGNjWEqrs2WXLPN/mMsCLq/YQl/kQvI8w5DjKohOb68ISUeYzwX1
         A2uzsy3qXYQWxcN0NEvfPQ/PIEEHb2vAn7O883v/T8VE49K73NHvDsCIIBy1qlphOsKr
         F2yw==
X-Forwarded-Encrypted: i=1; AJvYcCVFH2vL6BSfzJVUFm6wXNZmuNcA9UaCXlLsCPqcnelAAYrB9OziROU1i4CoX6Doe/+ytPh+9Ic=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAsUEbDQ6CAN/V3OuvNKcofz2M5MCVL7J4Tcad3VaJ3RzF139w
	56SYBESduBf2AIBUeS5A8cxAZ+j5JiDFNgkdTzvLwXIX1qhESTcvtEVhobZ0Fa0=
X-Google-Smtp-Source: AGHT+IFbacpLSnc4rOMpY5+dmRRZziIlusw3JZmkgHzp0UUQlnip7OEkK3q13Utpc9eyONEmI4HwlQ==
X-Received: by 2002:a17:907:5cd:b0:a99:409a:370 with SMTP id a640c23a62f3a-a99409a04f1mr81222166b.49.1728124267726;
        Sat, 05 Oct 2024 03:31:07 -0700 (PDT)
Received: from [127.0.0.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e7856bfsm116315566b.138.2024.10.05.03.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 03:31:07 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v5 0/4] ov08x40: Enable use of ov08x40 on Qualcomm X1E80100
 CRD
Date: Sat, 05 Oct 2024 11:31:02 +0100
Message-Id: <20241005-b4-master-24-11-25-ov08x40-v5-0-5f1eb2e11036@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGYVAWcC/43Nu2oDMRCF4VcxqjNBGo0uTpX3CC50W1uQrIJkh
 I3Zd4+8RXAwLCn/U3znxlqqOTX2truxmnpuucwj1MuOhZObjwlyHM2QI/E9avAEX66dUwUkEAJ
 QQencXohD0BMZ45zTjtgAvmua8mXFPw6jT7mdS72uX13c13+xXQCHRFFNPkqvrHv/zLOr5bXUI
 7u7HX8twbnYtHC1jN0b7ZEH8WTJRws3LTksstKHGCZrrX6y6NGSmxYNy6SEgdQUgw1/rGVZfgB
 dZCArqQEAAA==
X-Change-ID: 20240926-b4-master-24-11-25-ov08x40-c6f477aaa6a4
To: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Jason Chen <jason.z.chen@intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 stable@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2997;
 i=bryan.odonoghue@linaro.org; h=from:subject:message-id;
 bh=Pij+6FhctUgT45PYcO9Wc7sOysLVBbXPyPt2wqIlGhA=;
 b=owEBbQKS/ZANAwAIASJxO7Ohjcg6AcsmYgBnARVoLEjcjm9TuL9OFReqpJEqft90VdK51doUk
 nmz3UXVx0iJAjMEAAEIAB0WIQTmk/sqq6Nt4Rerb7QicTuzoY3IOgUCZwEVaAAKCRAicTuzoY3I
 OvciD/4vEXfuM9u5+VapF5+ubkcJAfOstxrMLN1t4iIeawhT/7WfmWfO12wowCTkX1kVaUQcbXI
 YUbCdzI+3cS/WLwxuJyOKssB9jmNgUk4GuhFBJ1KCnhWlsxk19C6KLBwJgekWFuB6a0Es2Xm6rf
 ZbfGt3KNSpRukqdxIFT5QYr03i6PWX7MtT+PuQoKjIqFXH0jOMRDEc1aFdXGR7nPEcy7cZVcx6e
 jMd33jKYUGa+CJBKPPUa8Lx0T8dr8cg0QkYXJZNEVnuvN7LOwcCkSgYdShZpPPlBWbwuyuVfKho
 3OMnMqz7peEOJ8jSN24PN2HRz2+lUZKuNKGC0yMT2rKdhzyK1SGp6mx3OQGDWeq0S6VsgAsUfKN
 HWhfoWus2/Twc0f32iKwoLTabaT48N1IFmu3xFEIgj9QfhNp4mSo5NrNoxviDrejKo7yhNRCaCS
 zQc4q5LJfWjNY7vgDhIt457L4amGm6zYyhGsTGROxUgNb2tAZant9y36UWQzQBtulPFgjyCqiky
 6K5I2EyxIwJglqDIGAttC5ERRAhk9SAXscg6m+psC/KhUQAmFUuYINGe02zxo5EFhfrnHco2DK6
 xk0Q5vGv6Yj9eZy4NT+6dNZvsOQlkSF1P1I1/aQu8Gk2Xoo32uc6VnG5fLQT96YGkz5aMlhdcP7
 43FS1MTnX54y4Xg==
X-Developer-Key: i=bryan.odonoghue@linaro.org; a=openpgp;
 fpr=E693FB2AABA36DE117AB6FB422713BB3A18DC83A

Changes in v5:
- Fixes smatch CI splat
- Link to v4: https://lore.kernel.org/r/20241003-b4-master-24-11-25-ov08x40-v4-0-7ee2c45fdc8c@linaro.org

Changes in v4:
- Drops link-frequencies from properties: as discussed here:
  https://lore.kernel.org/r/Zv6STSKeNNlT83ux@kekkonen.localdomain
- Link to v3: https://lore.kernel.org/r/20241002-b4-master-24-11-25-ov08x40-v3-0-483bcdcf8886@linaro.org

Changes in v3:
- Drops assigned-clock-* from description retains in example - Sakari,
  Krzysztof
- Updates example fake clock names to ov08x40_* instead of copy/paste
  ov9282_clk -> ov08x40_clk, ov9282_clk_parent -> ov08x40_clk_parent - bod
- Link to v2: https://lore.kernel.org/r/20241001-b4-master-24-11-25-ov08x40-v2-0-e478976b20c1@linaro.org

Changes in v2:
- Drops "-" in ovti,ov08x40.yaml after description: - Rob
- Adds ":" after first line of description text - Rob
- dts -> DT in commit log - Rob
- Removes dependency on 'xvclk' as a name in yaml
  and driver - Sakari
- Uses assigned-clock, assigned-clock-parents and assigned-clock-rates -
  Sakari
- Drops clock-frequency - Sakarai, Krzysztof
- Drops dovdd-supply, avdd-supply, dvdd-supply and reset-gpios
  as required, its perfectly possible not to have the reset GPIO or the
  power rails under control of the SoC. - bod

- Link to v1: https://lore.kernel.org/r/20240926-b4-master-24-11-25-ov08x40-v1-0-e4d5fbd3b58a@linaro.org

V1:
This series brings fixes and updates to ov08x40 which allows for use of
this sensor on the Qualcomm x1e80100 CRD but also on any other dts based
system.

Firstly there's a fix for the pseudo burst mode code that was added in
8f667d202384 ("media: ov08x40: Reduce start streaming time"). Not every I2C
controller can handle an arbitrary sized write, this is the case on
Qualcomm CAMSS/CCI I2C sensor interfaces which limit the transaction size
and communicate this limit via I2C quirks. A simple fix to optionally break
up the large submitted burst into chunks not exceeding adapter->quirk size
fixes.

Secondly then is addition of a yaml description for the ov08x40 and
extension of the driver to support OF probe and powering on of the power
rails from the driver instead of from ACPI.

Once done the sensor works without further modification on the Qualcomm
x1e80100 CRD.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
Bryan O'Donoghue (4):
      media: ov08x40: Fix burst write sequence
      media: dt-bindings: Add OmniVision OV08X40
      media: ov08x40: Rename ext_clk to xvclk
      media: ov08x40: Add OF probe support

 .../bindings/media/i2c/ovti,ov08x40.yaml           | 114 +++++++++++++
 drivers/media/i2c/ov08x40.c                        | 181 ++++++++++++++++++---
 2 files changed, 271 insertions(+), 24 deletions(-)
---
base-commit: 2b7275670032a98cba266bd1b8905f755b3e650f
change-id: 20240926-b4-master-24-11-25-ov08x40-c6f477aaa6a4

Best regards,
-- 
Bryan O'Donoghue <bryan.odonoghue@linaro.org>


