Return-Path: <stable+bounces-16390-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D5083FDCF
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 06:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0845B22A4F
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 05:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38055433D0;
	Mon, 29 Jan 2024 05:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZH9cEY8U"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D664C3A9
	for <stable@vger.kernel.org>; Mon, 29 Jan 2024 05:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706507190; cv=none; b=OdlApZsPPZ9gXnmPCutZCsF2lsOsQZNrPywBRMD5Y/RbatOqYywbnUu4x+edW0K2QtkC+YAuv2GT6kZVSH35bAQL/U7JWTYbYryraxUSAenko5/SUSFfO3qPZj69W9BqUWuIYJraHjs2NrsWw5cbzNnuFs1EsSPwNMl8136LAm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706507190; c=relaxed/simple;
	bh=JQjkZ3gP0XjDUpUvaCoN+F4/IRB7oKd7AWUlBBnxp7w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FSg/AhIOoc43H2ecbylvjVzoW3K2ccmISov34kFVeHkkfedsgSMoaPagg8AvF8EgWtQx2jSHOL9fPTjatHgis2VG1etg74G7Fh/N4V/7zBbKByH4DgLOtV8nithm55D8wMEJ12nXeb/znDixHsU3nXIf8HWl+TFbHFmPQH0TDTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZH9cEY8U; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5c65ca2e1eeso1040333a12.2
        for <stable@vger.kernel.org>; Sun, 28 Jan 2024 21:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706507188; x=1707111988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GuUdnmgvw6SJ6vQm7Y8iC2P6J3wX3eujuggx0jwG1nY=;
        b=ZH9cEY8UtX43hLT1uA01sFfUVLHbOAxuuzHGkiBo96pJYQ6EA3MctQaUKm8fDi3f+p
         SoO0b6a9TvRK80Hb7SP4niAIhUQNNincgkYkm1sCswPifzrxXuN+BnOSUyp8iyehpyBi
         NilCpD0JY2s/kXgiBMPpULw+4b1LQ2gsrL/Z+AtOscTXOwqp+ixXReBDPOlydNSuOb8H
         Vg1yWTCsHk6KPli3nYSvoJJfnt5iIy1Mu2tkD03pEG+7nVOEQxkDG08rrUZl71QHMniz
         WTHhRCV6ZP8Kbn3K5elc66jYtVyYgBaq+KXPZtG1/4k9+4vdjYFEpRhzD6Ek2q+9uQeO
         GanQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706507188; x=1707111988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GuUdnmgvw6SJ6vQm7Y8iC2P6J3wX3eujuggx0jwG1nY=;
        b=s66rC4ig+vWxUpo/HorvarqxBnJFB4wzgQjGl4ZeYewk38BRDoUJRIqzGwb0PWeqx3
         ctqNlMtpgPC2ioQr5YYe2v4j+BBbSO00e0jlFuKUnrpRao8bBMqBHoK/MypVeV0id//C
         6hdju+bEgLeLAiF++Ow4xxdvAvwPCrIsNZcTpWQybZk4Wsj2k4M9DaCJL/oUH1Nno/rK
         19bxFU6y7MU2zlxYONoGsOPYIXlLxi/z0wKkgzFNJjMpSpEzl+CzHTU9QFRejX/JKL/9
         79GaXCLsnmpSPW6rtfps0tILt3Dt+kup8oaPStx5/BJexl5E0w++AJ8o0ZLRpZJa5M5y
         m9sQ==
X-Gm-Message-State: AOJu0YxwrKMsel16AUSGbVosIvcmGN+3SxggIvnwEj7Rq62nu8axoTTW
	4+ojIIU+i6FiViLs8oTcLanOik4d43pXFN/urg+ZWzrtavQny9O58D0cjkbIfps=
X-Google-Smtp-Source: AGHT+IHjNvX5YBY5yCFm9llMlMnYGbRHx+wVZhmbYPeeCo326wOpb/7BlNonrqLeNp22AjPQy93TmQ==
X-Received: by 2002:a17:90a:ab92:b0:28c:9093:b0c4 with SMTP id n18-20020a17090aab9200b0028c9093b0c4mr1429201pjq.43.1706507187586;
        Sun, 28 Jan 2024 21:46:27 -0800 (PST)
Received: from x-wing.lan ([106.51.161.37])
        by smtp.gmail.com with ESMTPSA id y19-20020a170902ed5300b001d8b0750940sm3264642plb.175.2024.01.28.21.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 21:46:27 -0800 (PST)
From: Amit Pundir <amit.pundir@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Stable <stable@vger.kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH for-5.4.y] drm/msm/dsi: Enable runtime PM
Date: Mon, 29 Jan 2024 11:16:23 +0530
Message-Id: <20240129054623.3169507-1-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit 6ab502bc1cf3147ea1d8540d04b83a7a4cb6d1f1 ]

Some devices power the DSI PHY/PLL through a power rail that we model
as a GENPD. Enable runtime PM to make it suspendable.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/543352/
Link: https://lore.kernel.org/r/20230620-topic-dsiphy_rpm-v2-2-a11a751f34f0@linaro.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Stable-dep-of: 3d07a411b4fa ("drm/msm/dsi: Use pm_runtime_resume_and_get to prevent refcnt leaks")
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
Rebased to v5.4.y: s/devm_pm_runtime_enable/pm_runtime_enable

Alternate solution maybe to revert the problematic commit 31b169a8bed7
("drm/msm/dsi: Use pm_runtime_resume_and_get to prevent refcnt leaks")
from v5.4.y which broke display on DB845c.

 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
index 1582386fe162..30f07b8a5421 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
@@ -606,6 +606,8 @@ static int dsi_phy_driver_probe(struct platform_device *pdev)
 			goto fail;
 	}
 
+	pm_runtime_enable(&pdev->dev);
+
 	/* PLL init will call into clk_register which requires
 	 * register access, so we need to enable power and ahb clock.
 	 */
-- 
2.25.1


