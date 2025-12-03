Return-Path: <stable+bounces-198175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A85BBC9E501
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 09:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 44D13348AE6
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 08:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4B02D4B5F;
	Wed,  3 Dec 2025 08:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BczPEQLL"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AC9158535
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 08:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764752141; cv=none; b=A/aRRXwixu8yLnO7DPdGs1HzN3LkOAI5rjh2Jnys/T4QmfEExgNzswzBmnpTMWd96XgbLNVW6ffyeEusKQZIXfqT9W9emocFssML0w2eG3ZPU2CcETG5SuzntOaatIAssgXJsmbjtJKAl4Zhekd5Yba+PzmpWFBCclvBu2xf2GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764752141; c=relaxed/simple;
	bh=WZwTc3WGipU1rxTNrNT9q0JuopH580L2gUZ5qc9A4bM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HbSQYcQA/TnKPm9zBVaORz3GJoJZhX2Jxo9boMmaZynyi9AB8vs412aTpRNXIOimkSYXFG2KPNAJlU7Yy07allqostgCRUNQBe04HPMFpnTbY6R2xIpGQfWY0ecFpdL+ymJmXuhYqKxIeXkAoRSayncbUXwgBkqG1cT2teM4Jy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BczPEQLL; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5957c929a5eso9434097e87.1
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 00:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764752138; x=1765356938; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nLEuON7y1u9cDHc+MoWFTkLv0fcCZt0Zegqxsu+jQjM=;
        b=BczPEQLL7K9eG1OhP1XvbgvhWLu+ma8QxLl6c3Js09CIKt8o1hlW9zULnPOUF/QDc6
         qzaX97VtDkN7xqiGB/TUw/G70+fyedGpRyKHacjqJLxsS47yhvnx/OEahD3omBXhDXEl
         QE9a5Sjk8tCnh+5wer7eWih2tXxclpGYB+lkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764752138; x=1765356938;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLEuON7y1u9cDHc+MoWFTkLv0fcCZt0Zegqxsu+jQjM=;
        b=Gh9pm1YePwfJsR+JJP9nP3aWzBcKz6TonXJHJVlPT3jyh4RjSlG1yXxjhZOb/kHB9z
         aNkU72QUOG0LjSRxEKQQdQHehSi8ZPdW7dRBmTF3Ky2cNMD9Qcz71cwgS9PBaNFj0Y01
         K8At610x0X0b3Yfprn6xf6gnn6Ke1jjbyrdQpzaCrL+iMQ36ael0QaUWV71sOtWaYf1R
         HTJGcf9hoamUb8oyzWyJPdyE+RP9x11pYcBTgp72WRvwia4H9XcUC8MHH7dgoa39TYvi
         Aa/0saqUmLjbB+fToOzhnSyZjmXZSsCc99v3DweyvRfZweCkK6QUpFAjfftkipidXd6A
         mYCw==
X-Forwarded-Encrypted: i=1; AJvYcCVa+Jkjc3tL2slEsGxQd6OVk+RRVoTHcrWChkXipKEHEIWQdHRWEfE9imL3aS42ZGVy7Neaw8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTaSyf98sixq7Ugf3irdH06SzEmRozOW8T5dNmByCqryAd5gio
	WzfIAoCbiCd1ujCIjiuuZvaazCy2j1B3K7YALJrwuaAr8pl7OoXx44Z6MhpykKPzOQIEPAYOjzw
	ATj8=
X-Gm-Gg: ASbGnctG4QjICbplZuCzpuV1YIb+zwkJYt0OQNzajoSVfuUmzg+cuCxzm74H9ljFGtJ
	+dKBxdtic41HVSlHv4o8+4A/x9lZp1iCFO11XVCLlubCXITpbfMtdB0+H8geHCWexHDUh2+GbCB
	qstmdF+wehnRzMZ7O5CtK0hx9BPzyMB3sgfIer0OVugEwhR3YAtXqpLNK4sbLL4k31fTwbOb+8O
	dS360xp/GLiGCT6WP+ru5ZoM2Ri1cF9O+B377axKlbVPAhWSjtFIT6T0ZfKolqjFyeqRnRkAfNR
	h5VlDG7oxhi5W8L+CW8rf/d+pHWzDAYTg+/WT/LaiWraJ/V04ortng2KuPjVItfIVIn7BXJJzbw
	f6rU9ssmX0Q0+ffqoQfFJSGa0WMqPP3thQyF1NPb9KYjctDeIyCGTd8ONS3vNLnWHE7f3Bdwl3c
	YivI0tSJ2rVdukQRDe7Ocuo/V+gOlbmN2p41wpilGE2FRury28M6TDyXzMpFQL/c48UtAh+Q==
X-Google-Smtp-Source: AGHT+IFJK3gmRvM23rF/5dH2NkTCVXsct0rPtygHdd/7NJo5i6wrVlVL9QhzHou3oQOeS0kXE48mpw==
X-Received: by 2002:a05:6512:10c6:b0:595:8200:9f87 with SMTP id 2adb3069b0e04-597d3f63d64mr733419e87.17.1764752137618;
        Wed, 03 Dec 2025 00:55:37 -0800 (PST)
Received: from ribalda.c.googlers.com (165.173.228.35.bc.googleusercontent.com. [35.228.173.165])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-596bfa43f3esm5315377e87.47.2025.12.03.00.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 00:55:37 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 0/3] media: Fix CI warnings for 6.19
Date: Wed, 03 Dec 2025 08:55:33 +0000
Message-Id: <20251203-warnings-6-19-v1-0-25308e136bca@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAX7L2kC/x2MQQqAIBAAvxJ7bkGFJPtKdDBdbS8WChWIf0+6D
 MxhpkKhzFRgGSpkurnwmbrIcQB32BQJ2XcHJdQkO/CxOXGKBTVKg0YLb3Y9axcC9ObKFPj9f+v
 W2gf9dPQ/XwAAAA==
X-Change-ID: 20251202-warnings-6-19-960d9b686cff
To: Keke Li <keke.li@amlogic.com>, 
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Hans Verkuil <hverkuil+cisco@kernel.org>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Bryan O'Donoghue <bod@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>, 
 Stephen Rothwell <sfr@canb.auug.org.au>, stable@vger.kernel.org
X-Mailer: b4 0.14.2

New kernel version, new warnings.

This series only introduces a new patch:
media: iris: Document difference in size during allocation

The other two have been already sent to linux-media or linux-next ML,
but they have not found their way into the tree.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Jacopo Mondi (1):
      media: uapi: c3-isp: Fix documentation warning

Ricardo Ribalda (2):
      media: iris: Document difference in size during allocation
      media: iris: Fix fps calculation

 drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c | 10 +++++++++-
 drivers/media/platform/qcom/iris/iris_venc.c             |  5 ++---
 include/uapi/linux/media/amlogic/c3-isp-config.h         |  2 +-
 3 files changed, 12 insertions(+), 5 deletions(-)
---
base-commit: 47b7b5e32bb7264b51b89186043e1ada4090b558
change-id: 20251202-warnings-6-19-960d9b686cff

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


