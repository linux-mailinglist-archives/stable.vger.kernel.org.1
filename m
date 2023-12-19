Return-Path: <stable+bounces-7892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 185B5818510
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 11:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17D001C2179B
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 10:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D258914275;
	Tue, 19 Dec 2023 10:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iBiE905M"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402931427F
	for <stable@vger.kernel.org>; Tue, 19 Dec 2023 10:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-58d06bfadf8so3091354eaf.1
        for <stable@vger.kernel.org>; Tue, 19 Dec 2023 02:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702980684; x=1703585484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wNyFmRioYXKnM9fziETwiQigI7sumDYBQoRPC0s7cZE=;
        b=iBiE905MQ22wjEpRufWBVzb01fsLny+bMOWlqox3VFslSD/mkK5zNJBfLRtfrcjdK2
         RhwRsyJaEkVa6gPNv4izLl5sT2W4FGvq6AMAtU8H6nrCiX2MglupC2AfsJiwxXhdKHVa
         O2rl4+MNsoyOvSQreC1h2VLd7XhW/VtwRtXKUaYZCixWtRI5LR0oYFbJyZsAEmeeXem/
         RWEghVEMAz9NEJhyE9X7FT77bhpWn6cM4pWH1hW5IREC6pER+vYAVS6en1uSfBARV/Jg
         fjjm5epctuyjlUm0XDOyiegl8zkKnzCNb3hYuOKWQhkckRSvNSH0IE4JpmvLAPMuZ7kA
         CY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702980684; x=1703585484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wNyFmRioYXKnM9fziETwiQigI7sumDYBQoRPC0s7cZE=;
        b=Sik3zKcmRBLKMl5s5szXdbt97e1NHNoMKGQ7bDLxrtXCHiea5Q+RnugHUIv0rX/KZE
         od+w+9E+7vblMxTXxyT6xW2/jSxnlf+wfL/bdk1mMnM1jbwyh4KOP3w5Fj7ZA0LQ3q3H
         O+nk7ywKE5/cwnn9ul0I65LwRMc5Vks90XxuuAO8AZ2N8NVJRFGk2c7k+u2VdrtjtzK4
         g8DoUnpOYhxfuWNwrxRMzp9Bmn1foNcWllxHPC3c61G0Tyn8lv5U1NGUKJ7ebLI8KS3S
         odmd3tFWSV3WCPoxRg9Y67UYMZNIQGlr8uiAZJ31BoTmk3K55Xmt09/11/S524V3gLq2
         UJ3A==
X-Gm-Message-State: AOJu0YwvQvFcIx6Kkq9WAEQFUfxpHZPl1A5ImQ7ve4tqrIZe+JgE9Hpn
	yWJuZ9I/yfhYKxT2RovHX3Ssy8F1yxGoWQ24jko=
X-Google-Smtp-Source: AGHT+IHfgzthjCBPCX1w0AwOcAigVBapbNOBpjGw9roewZocdHf2alu7DxNUQ/ew3V/9zQfrHYuuZw==
X-Received: by 2002:a05:6358:99a0:b0:16b:fe18:27fc with SMTP id j32-20020a05635899a000b0016bfe1827fcmr19167610rwb.31.1702980684197;
        Tue, 19 Dec 2023 02:11:24 -0800 (PST)
Received: from x-wing.lan ([2406:7400:50:3c7b:ab4:a0e:d8f5:e647])
        by smtp.gmail.com with ESMTPSA id n31-20020a056a000d5f00b006d5723e9a0dsm4388989pfv.74.2023.12.19.02.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 02:11:23 -0800 (PST)
From: Amit Pundir <amit.pundir@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>,
	Stable <stable@vger.kernel.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Maxime Ripard <maxime@cerno.tech>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH for-5.15.y 0/3] Revert lt9611uxc fixes which broke
Date: Tue, 19 Dec 2023 15:41:15 +0530
Message-Id: <20231219101118.965996-1-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent lt9611uxc fixes in v5.15.139 broke display on RB5
devboard with following errors:

  lt9611uxc 5-002b: LT9611 revision: 0x17.04.93
  lt9611uxc 5-002b: LT9611 version: 0x43
  lt9611uxc 5-002b: failed to find dsi host
  msm ae00000.mdss: bound ae01000.mdp (ops dpu_ops [msm])
  msm_dsi_manager_register: failed to register mipi dsi host for DSI 0: -517

Reverting these fixes get the display working again.

Amit Pundir (3):
  Revert "drm/bridge: lt9611uxc: fix the race in the error path"
  Revert "drm/bridge: lt9611uxc: Register and attach our DSI device at
    probe"
  Revert "drm/bridge: lt9611uxc: Switch to devm MIPI-DSI helpers"

 drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 75 +++++++++++++---------
 1 file changed, 44 insertions(+), 31 deletions(-)

-- 
2.25.1


