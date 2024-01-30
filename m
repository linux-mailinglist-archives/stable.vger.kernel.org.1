Return-Path: <stable+bounces-17412-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0AF842662
	for <lists+stable@lfdr.de>; Tue, 30 Jan 2024 14:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D2BFB21C19
	for <lists+stable@lfdr.de>; Tue, 30 Jan 2024 13:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591326D1A0;
	Tue, 30 Jan 2024 13:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NvdNVU8W"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDA267E7E
	for <stable@vger.kernel.org>; Tue, 30 Jan 2024 13:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706622414; cv=none; b=BAMbUMzrmiDijIUrXBf5OGeN0zGA5nzYR9JrnPPtuDwRew+cB9qY3RcTmhwURK9jREo1bjBBcKRNUpkUYaxByFJXkvgjQ2oTG3jTgazFLqLmxjyOb7xYeZniWHG4ktnic9pdfWoUUGtU76xoyw+Bf9kAuMeTKDXdTpsuQuULaIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706622414; c=relaxed/simple;
	bh=ZuLTTgFIf5+iGBZWyZmE5mFU45E3RnYRYRQMQ27U7YE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XedmCjNqNxxD1gOhN2zN0bHXM4D2rWXSudrDZwAu2RtwmAUjquSIl1saeUMWQfDBWlWZbmUsuZsqB2L5kx0CSO04DhtvUvMq7dy8qpCAPBnTus6Q/AjzgstU7zl64pZw+uzUE+A8pdcyLrLu7iq7b32ePXx174hqlZhXnyDvV1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NvdNVU8W; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5d8b276979aso1654688a12.2
        for <stable@vger.kernel.org>; Tue, 30 Jan 2024 05:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706622412; x=1707227212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e38PpRHFwrCymOCw2tkq2NUVZlw0XHHcvxGW2aYg4YE=;
        b=NvdNVU8Wbb4gaGk77/EA4FYNkf0WUCFbBniqbRd1auN0mCZvdyqtw3zwCkYM2kAi66
         zOc4v5lFAobLM8PK8yZmWvZ5OuhcjFwAuYnJcpx0sykn3U13OhfhIa7QRMt0/MYUACYr
         nPghSbPsP2S9dU24NIc9doAAkayv4xSUMWtzgjgkYVqXmcbpPN7eV5bnBwE5spI7XK5+
         /35PaCP+WhMudocwSKMAWvDCTTs2I3FIhWQPxkkRv+jjTnVxz/U/J84k5qd3D2KU9muD
         EetjvInRWBkNnhNFHeZ1MxhGX8JIMNmEo7jrTdMXnFkJO2FKGEz96E0FIHDxoFtr/OyQ
         IeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706622412; x=1707227212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e38PpRHFwrCymOCw2tkq2NUVZlw0XHHcvxGW2aYg4YE=;
        b=B9lZRytdzpZHKsNojVfb+OGzpSOpWLArIkQCGpDd5BZp29bKZrLbug2/vDUB1W9CnW
         O1K0pkMv7FiLzftf/upJ0A8RRBnHEjfLyL/ehsy06rhMKbs79YE4dJsmsUFjLDtdZo2I
         M+pEJUNCNgtLdL5Op8dOAV+z63S8ASVS28ORdoZdTD1hrD0CynfQM5bLYKEUax6iCeB4
         fpQlOl89BeTv5DyLUYRc+YxY6HPXFlYWVB7Aj/LX2O9hswvAhpfx22fZEBNdyRUDQHlq
         sTy8JMBEId1HRNzDQhS5NVxgdwxk8YXeTxYnZTw5JQiy39q+Ib1xqU0kH062Di3hPCJe
         NQwg==
X-Gm-Message-State: AOJu0YzjeHMGW1vrnJtl7lJgteB/53RMI1vcWyDYpw9foYUubXycG+5x
	auOTvBFqWgecVuJhfXrhx91Umxq7tQqBwHogGfhp+z5fL8h/Nmb/tLPvJK5X6Tc=
X-Google-Smtp-Source: AGHT+IGw0J66ds12idcP+W/YayjJ6BXaiPDAA9XO34h0iCLL8kayxoPOOo2yV5Qp9k2GXKGBbe+XLA==
X-Received: by 2002:a05:6a20:4388:b0:19e:2e62:58df with SMTP id i8-20020a056a20438800b0019e2e6258dfmr540049pzl.34.1706622411959;
        Tue, 30 Jan 2024 05:46:51 -0800 (PST)
Received: from x-wing.lan ([106.51.161.37])
        by smtp.gmail.com with ESMTPSA id o194-20020a62cdcb000000b006dab0d72cd0sm8080435pfg.214.2024.01.30.05.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 05:46:51 -0800 (PST)
From: Amit Pundir <amit.pundir@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Stable <stable@vger.kernel.org>
Subject: [PATCH for-v6.1.y+] drm/msm/dsi: Enable runtime PM
Date: Tue, 30 Jan 2024 19:16:47 +0530
Message-Id: <20240130134647.58630-1-amit.pundir@linaro.org>
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
Fixes display regression on DB845c running v6.1.75, v6.6.14 and v6.7.2.

 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
index 62bc3756f2e2..c0bcf020ef66 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
@@ -673,6 +673,10 @@ static int dsi_phy_driver_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(phy->ahb_clk),
 				     "Unable to get ahb clk\n");
 
+	ret = devm_pm_runtime_enable(&pdev->dev);
+	if (ret)
+		return ret;
+
 	/* PLL init will call into clk_register which requires
 	 * register access, so we need to enable power and ahb clock.
 	 */
-- 
2.25.1


