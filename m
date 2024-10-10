Return-Path: <stable+bounces-83350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2895998612
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 14:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E35F31C21F85
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 12:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B15E1C463A;
	Thu, 10 Oct 2024 12:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UyGIy24A"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D7B1C1AD9
	for <stable@vger.kernel.org>; Thu, 10 Oct 2024 12:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728563602; cv=none; b=kAL34/PYFeVUeHB4mUcjANShtTZKFRLzKQ/BHO8jOHSX04ULXdPFluuOy3dWrX8oZVcZwf/Sz+6IO0/a0dAVMYFfw5Zk3tvSd/WyABNUjS2l+sN50UOIN0C3QJtnmMI7YfRFAFFcjsY+8MDJ4QVzy3DrZa1SvHFaEyfDAOgkmg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728563602; c=relaxed/simple;
	bh=cqUIEZnP0kL01BfU5rc437FLEoImXfFTjUHqR5eNwnc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aEDY7ybARYIDHNSo/QNL5Pqzt6r6KKqFLjmtloYhBFnoGmJEGwr0rEIoh4qsswbvn6JEMYxJhYu9o1s3Fm1JXMf3vC0qnf/DdkafhOtBoIo5IYCGghfW5P9pdato/32h9tD7u3QpdTgDzajwTSANAxaBA0jTv94i5mePRTgD2aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UyGIy24A; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9963e47b69so135974966b.1
        for <stable@vger.kernel.org>; Thu, 10 Oct 2024 05:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728563599; x=1729168399; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LHEYoeUaJm+TRJH4Wo52sajQiBiRG5cOqZEQNQXLqhE=;
        b=UyGIy24A3qQrFnMa8rC11b/fiAGz8l5i85X1jXxTeE7/zf/DBlThT7UOTqQr5M1DgS
         2ro3YZ2osGj2/qsuA1Uo7GFS7WGkOAXoPP8PZszCqGcL9TIrhB2QaXX4mdGU2uEJOvoF
         wwQZcO2K+oXjUdcoZNsX5Y/HXIWVL45jlE4nD9tnZQfsi9zVd+3xTWU97QpLNwagQ/Eu
         JjgF8bLj8ReD8ypboDtq5HUuJ5oEwHKkFdrox/Y9dZLqkB7zRpxGOzct73xDmzOnsKHa
         TU3WuJ77MpfyfU8x/QRfkUEILxd8ZoiwlFkcFCHB3fa8/6izVbi/gjR1cDEZG02mock2
         lyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728563599; x=1729168399;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LHEYoeUaJm+TRJH4Wo52sajQiBiRG5cOqZEQNQXLqhE=;
        b=bX5cyvjpk3Y0EimVMVwH8/8fvsq2hEJqXdcwK9wjlAjqeFvQPdbjk92T7nXK0hGnsj
         ddEVgccup9ZF35rSBLOx9I6n8Z2ncox4shWUnp7ctKdzrH1Eim17AA6vm7XGXkvfKlrZ
         llN47Hk36orpuDY/6uZje2PCKvVbqfVqSy6gUPVZ4a4hltdPsSZZ0X6MzYIW19wzWFAQ
         +sPHtDTOCrZzY5OvUDZFyE39ILCOqvPlRDakd6hb7RmrikKaVP5oKOZomuylb4AnERek
         aEPX/n7NRtMpdOG0YU25xfiMIbbp5VjnF46ucp0LITcJyPYmuq/6HmRtj34nhMQQfn/a
         tD+w==
X-Forwarded-Encrypted: i=1; AJvYcCU5Qhg81NnngIzQmgvUf3WFyYEfY5fK/EBG/07Hm7hb2+/h2Rrp15b/fYi6BOygyzC7MYcs6zo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuYcBJ/T2a2S/x1AyRd0FO/ban/vR80Va7g4rTHx4FLdgiBvwK
	TD7X349MRJt8PE9InU3jVx0bc1ee6z8ZqKOj4U2hPbLhhcHyJreGecVG+lI5t+k=
X-Google-Smtp-Source: AGHT+IE3EaoE2Q5bVEVX836O7f7bjOsfm+ZSuY6FRgsn43+zdF7F8MeYUKtUO4lxln2Fdct5qoME/g==
X-Received: by 2002:a17:907:94d5:b0:a99:6036:8d9 with SMTP id a640c23a62f3a-a999e693f75mr365791866b.15.1728563599332;
        Thu, 10 Oct 2024 05:33:19 -0700 (PDT)
Received: from [127.0.0.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80c0723sm82416666b.135.2024.10.10.05.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 05:33:18 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v6 0/4] ov08x40: Enable use of ov08x40 on Qualcomm X1E80100
 CRD
Date: Thu, 10 Oct 2024 13:33:16 +0100
Message-Id: <20241010-b4-master-24-11-25-ov08x40-v6-0-cf966e34e685@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIzJB2cC/43Oy2rDMBCF4VcJWldFGo0u6arvUbLQZZQIWqvIw
 SQEv3sVL4qLwXT5z+I782AjtUIjezs8WKOpjKUOPczLgcWLH87ES+rNQACKIxgekH/58UqNA3I
 pOWheJ+FuKHg0Ga313huPrAPfjXK5LfjHqfeljNfa7svWJJ/Xf7GT5IITJp1DUkE7//5ZBt/qa
 21n9nQn+LWkEHLXgsWy7mhNABHlxlJrC3Yt1S10KsQUs3PObCxcW2rXwm5ZIoioc4oubiy9tvS
 upbuls6QAJKVQf/+a5/kHZLWEf/UBAAA=
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
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev-dedf8

Changes in v6:
- As I was applying a suggested fix from V5 of this series to other yaml
  schema in media/i2c it seemed to me that there were a number of
  properties that would be affected by converting properites: endpoint:
  additionalProperties: false to unevaluatedProperites: false
  I pinged Laurent, Sakari, Rob and Krsysztof about that leading to:

  link-frequencies: true is considered a valid hardware description.
  
  We don't want everything in /schemas/media/video-interfaces.yaml
  to be valid for each of the port{} descriptions for sensors so:

  a) use additionalProperties: false listing valid properties directly.
  b) Fixup various schema to list the valid properties in line with above.

- Convert unevaluatedProperites: false to additionalProperties: false
  Laurent

- This isn't exactly what Krsysztof gave his RB for so, I've omitted that

- Add remote-endpoint: true to port{} - required as result of additionalProperties: false

- I'll still follow up this series with a more general fix in-line with the
  above as TBH I just copy/pasted from some upstream yaml so it looks like
  a more general remediation is warranted, saving someone else from
  repeating my mistake.

- Add remote-endpoint: true to port{} - required as result of additionalProperties: false

- Use schemas/media/video-interface-devices.yaml# with unevaluatedProperites: false
  So that rotation and orientation are valid - bod

- Link to v5: https://lore.kernel.org/r/20241005-b4-master-24-11-25-ov08x40-v5-0-5f1eb2e11036@linaro.org

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

 .../bindings/media/i2c/ovti,ov08x40.yaml           | 120 ++++++++++++++
 drivers/media/i2c/ov08x40.c                        | 181 ++++++++++++++++++---
 2 files changed, 277 insertions(+), 24 deletions(-)
---
base-commit: 2b7275670032a98cba266bd1b8905f755b3e650f
change-id: 20240926-b4-master-24-11-25-ov08x40-c6f477aaa6a4

Best regards,
-- 
Bryan O'Donoghue <bryan.odonoghue@linaro.org>


