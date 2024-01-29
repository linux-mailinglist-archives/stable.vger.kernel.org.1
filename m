Return-Path: <stable+bounces-16411-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4B88402EB
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 11:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F33FB21091
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 10:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86D756746;
	Mon, 29 Jan 2024 10:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PgpGNkxF"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA0B537ED
	for <stable@vger.kernel.org>; Mon, 29 Jan 2024 10:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706524757; cv=none; b=GfDbHoD8IjGxhZvaA2XYbnhQ+zcislzofNQQ5sfEfTFsMle0dc64OuDlY8IQLyTEcNvvkKz6xKKM36tRyVBTTbZKAjDq1gU3a36RKIESr0H+cTNsLJcv1kseq6l+3swlcpSiQAAxAm8/tHCC5axAt88de4a///mghR7SJuG+LZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706524757; c=relaxed/simple;
	bh=GSTUyEkaCw8+mf3aZAznWDsEv+k0bIINyaZ3D/jMk4Y=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ffghLtVd/uOp+2C1at7Yu3MAjI3H85PBYgGDoIx3Zo/8EfKowNJDG3WHcYgQWgsZtajhUH6oZenKX5hPD8ltPJLiXIkW78vktBsfS0bxd137aNAv/cNpmVxophFVJ4QKeKSdf2jnWUDhHcj/dXnu0aaZ3u7mU0WDPRqhRkL0TsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PgpGNkxF; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-28bec6ae0ffso985980a91.3
        for <stable@vger.kernel.org>; Mon, 29 Jan 2024 02:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706524755; x=1707129555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qnFUizzcm8RiL++uwJV/JPl5hCDIiuzhsrmyjBQdNrk=;
        b=PgpGNkxFGbAfcKBen3fYm7DEJEYDt8Th26toJHyLuC/PkDDuRfEJ+6WHdjVTYoicdg
         fytjmxQkCN2NOyVTn25991YVsx9ma9hVD9YiARlzFFYhlO4peCICtMjGE1e9o9ST/4+I
         JNKRVHg3EuJmMmYeEjBQuKkaYfJoCR86AwRsS8Dt7usXYMt6bm0CJt5bfEe3xyjmGlet
         cVZj7h+0HZaP3GOn+0ye7fhVvhmza+VJMFb2rirLaYtO7LUei4tIowccLVfVwcphG9iE
         xC7/Zu/48y2VqpQyT1XYO5hiSioDjte7qxHg4aKmlqerKeQG0SiyKOSKv0jQ8uawv4Er
         6xpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706524755; x=1707129555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qnFUizzcm8RiL++uwJV/JPl5hCDIiuzhsrmyjBQdNrk=;
        b=nZux/0xc2AE+MNF1Mxl7zEuOcYQGEf5I+7ZuHVqdL8SXa5xf5KTroCiDGBPDnmaCKR
         LRw/gRpWMSe6iugGgwC1qNfYgGN6kGwyMATUB9ZLuLRwb06CGdo1PprHsNxjzZXReWHL
         8v8QRAi4M/2DWU+so14xh/YDIxw9adHGJR2yWNMFV5GsS1xAmYrlXK70Ooq+ZngKiBn3
         a3tEeqzsKLfCFOaAxntyJ8jbl7D9wgdlAPTkfycqvxJAtCK1wR/7ZyulRxpBdILrtGLX
         oY9gHSPqPbeK+y6LNgO2Pl5xFUYRaSamOu9XPXPkf/fbJ6cvHu9uURVSDCbslDUGjIgr
         Hl7w==
X-Gm-Message-State: AOJu0YzqHgHMlVhjXdZizI76He/YsEWXjTqTZDgCjenBmQB2irweP25c
	SRJJPE3cAIIC8BFQw5jh0haiZvcNPGZQ8HpFstzrDSDWK5omBy2npzMPJlhWjXo=
X-Google-Smtp-Source: AGHT+IFkY5r/KXa1pzjBDtFh4ndI2q1WIfYnkgk6+heGmESB+pWyse+lc+2FTHEtgYsUZuEk9fvThg==
X-Received: by 2002:a17:90a:bb90:b0:292:65ad:d57d with SMTP id v16-20020a17090abb9000b0029265add57dmr1717672pjr.33.1706524755368;
        Mon, 29 Jan 2024 02:39:15 -0800 (PST)
Received: from x-wing.lan ([106.51.161.37])
        by smtp.gmail.com with ESMTPSA id fa13-20020a17090af0cd00b0029564dec437sm2285401pjb.6.2024.01.29.02.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 02:39:14 -0800 (PST)
From: Amit Pundir <amit.pundir@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>,
	Stable <stable@vger.kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Douglas Anderson <dianders@chromium.org>
Subject: [PATCH for-v5.4.y 3/3] drm/msm/dsi: Enable runtime PM
Date: Mon, 29 Jan 2024 16:09:02 +0530
Message-Id: <20240129103902.3239531-4-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240129103902.3239531-1-amit.pundir@linaro.org>
References: <20240129103902.3239531-1-amit.pundir@linaro.org>
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
index 1582386fe162..925262ea6f14 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
@@ -606,6 +606,10 @@ static int dsi_phy_driver_probe(struct platform_device *pdev)
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


