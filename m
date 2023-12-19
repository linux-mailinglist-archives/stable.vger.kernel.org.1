Return-Path: <stable+bounces-7893-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D474818511
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 11:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C79B1F22171
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 10:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A2D1428C;
	Tue, 19 Dec 2023 10:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ogVl3Xaw"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2EB14282
	for <stable@vger.kernel.org>; Tue, 19 Dec 2023 10:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-58a7d13b00bso2954756eaf.1
        for <stable@vger.kernel.org>; Tue, 19 Dec 2023 02:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702980687; x=1703585487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UUHViBn/A+dG5+Au6Vj2vhso9EKsp0t99ze/84htZs=;
        b=ogVl3Xawd/peJmIXcJseZOIg4OA+nzpq+1WNiux+IBVv0qTebPOYECwy/CNvbg4hQZ
         jENeRveMsMyS1GcT5lrtTrRx+1AShDmPEhhwDdGth+mJMYYyV6zmoqhGgFftM4utxeti
         mixqRAZDb4AKM7T/N7Zy5eh3Tp8gc2XVj1WyxxmUww4PpmnbgNPJ4jjKheMqZTodHes6
         Fz+rsZoCpqLcyO6F3ujKX8JbeO/Ij2UR2UzcHc+lNUm7pfDMQheFSzt1f0rEcgBv9NGX
         oTEDOlQXBHMsD/v/k2TYBpTqWcqnCjS8VwDzJubTR6gRiZ79PSrT36mtEyiZAUwW/cBO
         KI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702980687; x=1703585487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+UUHViBn/A+dG5+Au6Vj2vhso9EKsp0t99ze/84htZs=;
        b=sx1BbkDfe/soBgPedD3V755nlIHgg/Q1qSWbqCO0Nc7VRPqxhZjJd6GYpkVJtdxF7j
         JEdnSm52Q/NhhKF9UhR0YP7saINsXM/KQBRtXU8n0Wik8dyyRKfIffYpT8zSKv4TiZVn
         eB0b2+Xlw/KXyDDuuA56ecuJQ7R/j89WwREZEKkMx0SruoXvJ9MSmkLbxKEHk0llF2xZ
         J8LOlhOANszvl+apEO6vH97prsk5NZW6419wvi9T3wQzW0cXzNRrSWkpBSI3u75MKR2d
         rpEjd6BS3O+Q5QvWtKm5tg5BquBzro7gcdQOJqpEbALsacDfhAiDuQgTTGu1wjp559+r
         bTcw==
X-Gm-Message-State: AOJu0YwI7hOslOxhEfZD85Vi3YS9dc2cVQ3cYyeNuojM3k8IllgzYZ6T
	FNEHR3VFonIL0q/gDTNsOO6sSw==
X-Google-Smtp-Source: AGHT+IHm5tTK4W39AHHhzXd/KTUUGaj6nJpG6B52g0zfELBSzZ9lWkIH8ndtaN9LzhW4TfaUGd+qnQ==
X-Received: by 2002:a05:6359:458c:b0:172:d930:2d84 with SMTP id no12-20020a056359458c00b00172d9302d84mr3681282rwb.61.1702980687450;
        Tue, 19 Dec 2023 02:11:27 -0800 (PST)
Received: from x-wing.lan ([2406:7400:50:3c7b:ab4:a0e:d8f5:e647])
        by smtp.gmail.com with ESMTPSA id n31-20020a056a000d5f00b006d5723e9a0dsm4388989pfv.74.2023.12.19.02.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 02:11:26 -0800 (PST)
From: Amit Pundir <amit.pundir@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>,
	Stable <stable@vger.kernel.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Maxime Ripard <maxime@cerno.tech>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH for-5.15.y 1/3] Revert "drm/bridge: lt9611uxc: fix the race in the error path"
Date: Tue, 19 Dec 2023 15:41:16 +0530
Message-Id: <20231219101118.965996-2-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231219101118.965996-1-amit.pundir@linaro.org>
References: <20231219101118.965996-1-amit.pundir@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit d0d01bb4a56093fa214c0949e9e7ccb9fb437795.

This and the dependent fixes broke display on RB5.

Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index 2a848e14181b..1e33b3150bdc 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -927,9 +927,9 @@ static int lt9611uxc_probe(struct i2c_client *client,
 	init_waitqueue_head(&lt9611uxc->wq);
 	INIT_WORK(&lt9611uxc->work, lt9611uxc_hpd_work);
 
-	ret = request_threaded_irq(client->irq, NULL,
-				   lt9611uxc_irq_thread_handler,
-				   IRQF_ONESHOT, "lt9611uxc", lt9611uxc);
+	ret = devm_request_threaded_irq(dev, client->irq, NULL,
+					lt9611uxc_irq_thread_handler,
+					IRQF_ONESHOT, "lt9611uxc", lt9611uxc);
 	if (ret) {
 		dev_err(dev, "failed to request irq\n");
 		goto err_disable_regulators;
@@ -965,8 +965,6 @@ static int lt9611uxc_probe(struct i2c_client *client,
 	return lt9611uxc_audio_init(dev, lt9611uxc);
 
 err_remove_bridge:
-	free_irq(client->irq, lt9611uxc);
-	cancel_work_sync(&lt9611uxc->work);
 	drm_bridge_remove(&lt9611uxc->bridge);
 
 err_disable_regulators:
@@ -983,7 +981,7 @@ static int lt9611uxc_remove(struct i2c_client *client)
 {
 	struct lt9611uxc *lt9611uxc = i2c_get_clientdata(client);
 
-	free_irq(client->irq, lt9611uxc);
+	disable_irq(client->irq);
 	cancel_work_sync(&lt9611uxc->work);
 	lt9611uxc_audio_exit(lt9611uxc);
 	drm_bridge_remove(&lt9611uxc->bridge);
-- 
2.25.1


