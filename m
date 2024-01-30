Return-Path: <stable+bounces-17403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F57C842540
	for <lists+stable@lfdr.de>; Tue, 30 Jan 2024 13:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C44C281C23
	for <lists+stable@lfdr.de>; Tue, 30 Jan 2024 12:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263A26A032;
	Tue, 30 Jan 2024 12:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g+jb7tNl"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D316A028
	for <stable@vger.kernel.org>; Tue, 30 Jan 2024 12:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706618806; cv=none; b=DGIVy50zsDAJzdrsnljeEjvdaxm907LRZ9RhBlR6UeRVdRTPs5nuVqm4mBzStdNu2pNkwl6WKJttRe2wywRW0aJGhkDWavFFh0JS0b2VtswNM/ZApQkRUDRy1nR+7LPEA2kIbdkDS968XzyhPJhMW9r6zIIvhVpsDrSHFT19QUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706618806; c=relaxed/simple;
	bh=WbfEXzTwQbkeBN2xxo23js5kxyKtxCg/AlTuOB1AgbU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BeLbW2A4snsv29UqJN6s+C9C3feQxd3kM+ecMqJ00h4F8OQCyPy+VfFnB7KGkZIC+mwpkaveznQYlKnE+SvH8FPKJ2v5njvJ0Ls1JqGu7gHFyadpiX398QGHJq8hCqwRbqgwNu+sImst3EEkkNSImmEkLN0PpfkkuonxJY0oB8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g+jb7tNl; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so3057268a12.1
        for <stable@vger.kernel.org>; Tue, 30 Jan 2024 04:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706618805; x=1707223605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2b5Gy528ramUWbYepF6ZLLPBnRd/+Hvsfy1rHq6SfWQ=;
        b=g+jb7tNlV9JXuJel/7UDs8MAfIgd7TBNMtdkOp3rdJ7aoPUMLZxpAMJjkF41zqIkOk
         nsG+uIyOYgpCyvdO15w4/IRfpN2KrGSa7o+BTJLlCdutyTPeF+3/bvAhMB+8GQ64h7HD
         DB/Oo6EGi9+UpfhyuqgvtPkGH6EDqxtfz+F2Qtw5Cz/BStUmzrcrWY+VAy9ry+lu7nxd
         0w6UPrf0n6vbB8zclY7oOdxETSt9jX87c8HNKZRXOSHMZ4c+d95GTf3UFkN2DJkl1yHx
         1SuFXB9TZ8aq/RSQ+MNxWOzmBvXOONWepg+V7+aEAJZvWwexNm8/OeD5AvhpDIhGGmHo
         UiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706618805; x=1707223605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2b5Gy528ramUWbYepF6ZLLPBnRd/+Hvsfy1rHq6SfWQ=;
        b=mgB67ikRa3gkVLLnt3zgudQ+DuM4yMmbYQtcDWXbY3Cc53tuFvNSknUJxUaBuVgFFg
         nptHOnDBHhZ5vOZ9h8JmAZgaXwh/ypQpsOHMLNifJI4dUoqKQRZ0NeZGOwW/KsFFMy1K
         5l3Sjp0NPyFrUqz2CTBxRfQHCnNBOpVdo130AfzKXZMsN2Jnsapu/cO8zqIN/q32IjpD
         tDlnW0Z6dp4mjiRTOFx0qGoVM8e97yuwhQv1rrEcBPDfShL7uQNoBfp4yLz3uoPCMIpA
         pB4IEAYSvS4nQNtGERIrZz34MIkcKqeZ2dO2oD566pZels5jgpIIVb+dYctQJKPbfkET
         au2g==
X-Gm-Message-State: AOJu0YyfzhibdWx/k0XxrLXHtehefRvv2ogj6Qlkum76tW6T0Zx7cZAw
	9NB3ITBaM1f6EX3Meox7fri42uVlEYNwLQ4D9uS61iy+HY1NRUvlPM+H2Xrj70A=
X-Google-Smtp-Source: AGHT+IEEeqiERIe90+NOnON4eAR7oOmfxUx2ieSLJil05z3zxesKe4sx6o1GxAH8vdpcqiIlt2uCzQ==
X-Received: by 2002:a05:6a21:2d06:b0:19c:a8a8:5c7b with SMTP id tw6-20020a056a212d0600b0019ca8a85c7bmr6323941pzb.56.1706618804713;
        Tue, 30 Jan 2024 04:46:44 -0800 (PST)
Received: from x-wing.lan ([106.51.161.37])
        by smtp.gmail.com with ESMTPSA id p3-20020aa79e83000000b006dddd3e31a8sm7658788pfq.219.2024.01.30.04.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 04:46:44 -0800 (PST)
From: Amit Pundir <amit.pundir@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Douglas Anderson <dianders@chromium.org>
Cc: Stable <stable@vger.kernel.org>
Subject: [PATCH for-v5.10.y 3/3] drm/msm/dsi: Enable runtime PM
Date: Tue, 30 Jan 2024 18:16:30 +0530
Message-Id: <20240130124630.3867218-4-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240130124630.3867218-1-amit.pundir@linaro.org>
References: <20240130124630.3867218-1-amit.pundir@linaro.org>
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
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
index 10eacfd95fb1..b49135f38583 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
@@ -710,6 +710,10 @@ static int dsi_phy_driver_probe(struct platform_device *pdev)
 			goto fail;
 	}
 
+	ret = devm_pm_runtime_enable(&pdev->dev);
+	if (ret)
+		return ret;
+
 	/* PLL init will call into clk_register which requires
 	 * register access, so we need to enable power and ahb clock.
 	 */
-- 
2.25.1


