Return-Path: <stable+bounces-17406-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F02098425A0
	for <lists+stable@lfdr.de>; Tue, 30 Jan 2024 13:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB9EE28E0E5
	for <lists+stable@lfdr.de>; Tue, 30 Jan 2024 12:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6227F6A03C;
	Tue, 30 Jan 2024 12:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hht35Kry"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4E36A32B
	for <stable@vger.kernel.org>; Tue, 30 Jan 2024 12:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706619540; cv=none; b=aU1cor4coo5TRWwhGcfR/WJRS/bgfW+bcaYIOYUSyoPz9fhP2GlJGk36Bf1WthumuOMrar/M57ySIIneTglhGmm9cqI/q1+XY/r9j1lQjBRw9tnNhlC8flFCj29cnfnrsmOsKHH5I1oIJFqxjEbThjEILxe15CBsH/639celCsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706619540; c=relaxed/simple;
	bh=Z7nWngggwpglJfKWNE0Jtfp5gEW4A7fjYyEZ6XZ9/ao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q6KnmTe+3P7htF9x5jRd12p/PqT1wleP2NdjH8vPRzlpIVoYKkP4eoM9+aRWg/4aqlt3ipriddmwOg6zPfsfVbVGCgiPCDKGWd0aSOzcyP4d0hHrBNeVB1iDxgy8J4tnuw9/PGGofKmqdiJWrC3St9aJlksBu4qahQFD3ez6Ljs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hht35Kry; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ddfb0dac4dso2801622b3a.1
        for <stable@vger.kernel.org>; Tue, 30 Jan 2024 04:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706619538; x=1707224338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37aGeH96pWC9GZDHk5Ico2Q6oDbjRXWzbN7Kq1txqCc=;
        b=Hht35Kryvule5Ge6yELR8CCuiFZZFgQyrkZ0GuKVMOhk6X3C0DD93UYeJY3nu6XkfH
         UqKZqUEtaaMw3b213pzQBXLpkcYMofu9+yMAV10vXF2LlFy1l74Fg7NvnEyv7c/sb74D
         FGghPVlkrXQRT6jIJTSxusDqVyinrY6+LbqzU2UcrnYozhCP49l2ETrn/xb424FeU1rT
         SJckat3/n68hlsJN0IXbbYYgGkIl7RuWBZ2cxDJklqQ7YyU5Ekum71K/reNRbU/iUNz9
         TVur1iU8nqA5wWoAOzsvMmMzn2du1ZIMnoRpxBlBRpQ21AvjYCLALtUUR6Z+/G9PEXZ7
         s5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706619538; x=1707224338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=37aGeH96pWC9GZDHk5Ico2Q6oDbjRXWzbN7Kq1txqCc=;
        b=cFKUMGtUJllCTlt0nouqJIMigCIAAhAWqjW9Q1rr8g6JBKT2TyzOlagvZ6zjrSCQV6
         wo9jaR/OBc86OVCS4z8MUeWeVO7PyIzVbVY7OQMjkOODtDvHM5lV/ZnHy26SUD/DC1EK
         kqGMMAMMgyEuppAi7yjkRgkMnpnRSLypKdsQ0xMLXzLoeXX8MDjJu58ICe0DzfN8w9qT
         7jnfU2WKe80iKi08ylw5//X+uOpwhdpHlEOL/tisbegvzEWftu7IXQBs7B20zosPqsgv
         K8qywBFO4cvGmkJoewTPFfcPmLdERrYrBqSFVCSVChM40u6Xz8EBK5HuCmb9AxsdTzVu
         answ==
X-Gm-Message-State: AOJu0YwON/IXoZ73+UnhyCwy8M7a8Cwk2xv5qratptJYHGmZI7LOCxLZ
	/Akjd1U8LF7l3oJ2mSQdZH8WjDQIdydTFaG6EwNkz0kVwcLbwBYqa244utgCUfI=
X-Google-Smtp-Source: AGHT+IFsnUeORdijcp6RPa3LLrBZqjE7Vl6ErxDZC8s0KmOLZYnWIObQ+dmnIrJDSaiEmLBY9Dmz7w==
X-Received: by 2002:a05:6a20:12ca:b0:19c:914b:782 with SMTP id v10-20020a056a2012ca00b0019c914b0782mr8220982pzg.54.1706619538139;
        Tue, 30 Jan 2024 04:58:58 -0800 (PST)
Received: from x-wing.lan ([106.51.161.37])
        by smtp.gmail.com with ESMTPSA id lw8-20020a1709032ac800b001d8f82f90ccsm2432029plb.199.2024.01.30.04.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 04:58:57 -0800 (PST)
From: Amit Pundir <amit.pundir@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Douglas Anderson <dianders@chromium.org>
Cc: Stable <stable@vger.kernel.org>
Subject: [PATCH for-v5.15.y 2/2] drm/msm/dsi: Enable runtime PM
Date: Tue, 30 Jan 2024 18:28:47 +0530
Message-Id: <20240130125847.3915432-3-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240130125847.3915432-1-amit.pundir@linaro.org>
References: <20240130125847.3915432-1-amit.pundir@linaro.org>
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

Change-Id: I70b04b7fbf75ccf508ab2dcbe393dbb2be6e4eaa
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
index 4b5b0a4b051b..6b9a9e56df37 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
@@ -752,6 +752,10 @@ static int dsi_phy_driver_probe(struct platform_device *pdev)
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


