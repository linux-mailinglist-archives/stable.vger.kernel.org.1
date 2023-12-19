Return-Path: <stable+bounces-7894-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E56818512
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 11:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DFD31C239E5
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 10:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E859A14286;
	Tue, 19 Dec 2023 10:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TV+BHioG"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5653A14281
	for <stable@vger.kernel.org>; Tue, 19 Dec 2023 10:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6d9d4193d94so3332576a34.3
        for <stable@vger.kernel.org>; Tue, 19 Dec 2023 02:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702980690; x=1703585490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QxrjSGjdVe4hzqaLk50QydqH8NsxG4Dqi4lPOq55wEA=;
        b=TV+BHioGCErETgfzqHPAu+xgXYJlArA12SZoXWtL7amIVm0tUOPoQ+mEtO/Tj7lb6i
         0nHxm1+r/3vpSGzAEbcYEoNExIPSXJ18KqN6sdGkINtw2creByF2ciD1QNvYIM4TjBhU
         5OyNy3jzKARv2iISdUD+Xmdejm355ul3qxu46oWBDC4tV0N5GBbePTFS1YohY+VoklKt
         47CfyXZi/cmHKNtfLR+Bgzl3rV9G65XCRm8tQhhukBXsmrLk2onL4Ynt/9qB0nO+FIw2
         FCoUBZnF2EZg+gjZsmWNt0RzPz/ggO0YZurUByyALyodj5pDIe50h2KQQzIh5qegZZGE
         GKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702980690; x=1703585490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QxrjSGjdVe4hzqaLk50QydqH8NsxG4Dqi4lPOq55wEA=;
        b=eVUdhIoX7vcMEC6u9m+bAmQTiHCB8M3M7+F7ohqSSTX0Qlp6aP8aIo+3r4jnCV+R+j
         UN6Mj8Nbh4MIMBaAybPod5UtJTOxSwHgYu+EuJfV12DR97qWnJ/HfjwEep7n2FoK8kua
         3hBOc+N2nwi7HoxCtsxNziv2/3qWQ3L3POtqfUw5yFEJEu/l6NQVcKsrkbPYZxWqp6ms
         UG5qjN+cJVoKhnorPY/aWppcr6QJWGcN5M8FhpiFO+b1NfYxDCC4K2N4UrcI5rZZGqTR
         gvkdcaE8XhHahiQ9c5PCrLHez3KRC1i7fuH48QYMKQQa1i+vFvrxfH0zYltxX5CUSc66
         s41A==
X-Gm-Message-State: AOJu0YwNyDYnGkqEQzQY4bcxuKd8yQ7HiZq2p4TPB7sRSJw3bhi6Q1VD
	TWivLQDbll/gAMDNyyHClsdr9Q==
X-Google-Smtp-Source: AGHT+IH9aOGHnRnZVMNYMb6/biPrkWwXZp5w6gkNirsxBgweTcIQ/+D39fK3EBZJ+DFZABkBHgmk3w==
X-Received: by 2002:a05:6830:1185:b0:6da:5218:46e8 with SMTP id u5-20020a056830118500b006da521846e8mr7681126otq.58.1702980690419;
        Tue, 19 Dec 2023 02:11:30 -0800 (PST)
Received: from x-wing.lan ([2406:7400:50:3c7b:ab4:a0e:d8f5:e647])
        by smtp.gmail.com with ESMTPSA id n31-20020a056a000d5f00b006d5723e9a0dsm4388989pfv.74.2023.12.19.02.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 02:11:29 -0800 (PST)
From: Amit Pundir <amit.pundir@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>,
	Stable <stable@vger.kernel.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Maxime Ripard <maxime@cerno.tech>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH for-5.15.y 2/3] Revert "drm/bridge: lt9611uxc: Register and attach our DSI device at probe"
Date: Tue, 19 Dec 2023 15:41:17 +0530
Message-Id: <20231219101118.965996-3-amit.pundir@linaro.org>
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

This reverts commit 29aba28ea195182f547cd8dac1b80eed51b6b73d.

This and the dependent fixes broke display on RB5.

Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 31 +++++++++-------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index 1e33b3150bdc..b58842f69fff 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -367,6 +367,18 @@ static int lt9611uxc_bridge_attach(struct drm_bridge *bridge,
 			return ret;
 	}
 
+	/* Attach primary DSI */
+	lt9611uxc->dsi0 = lt9611uxc_attach_dsi(lt9611uxc, lt9611uxc->dsi0_node);
+	if (IS_ERR(lt9611uxc->dsi0))
+		return PTR_ERR(lt9611uxc->dsi0);
+
+	/* Attach secondary DSI, if specified */
+	if (lt9611uxc->dsi1_node) {
+		lt9611uxc->dsi1 = lt9611uxc_attach_dsi(lt9611uxc, lt9611uxc->dsi1_node);
+		if (IS_ERR(lt9611uxc->dsi1))
+			return PTR_ERR(lt9611uxc->dsi1);
+	}
+
 	return 0;
 }
 
@@ -946,27 +958,8 @@ static int lt9611uxc_probe(struct i2c_client *client,
 
 	drm_bridge_add(&lt9611uxc->bridge);
 
-	/* Attach primary DSI */
-	lt9611uxc->dsi0 = lt9611uxc_attach_dsi(lt9611uxc, lt9611uxc->dsi0_node);
-	if (IS_ERR(lt9611uxc->dsi0)) {
-		ret = PTR_ERR(lt9611uxc->dsi0);
-		goto err_remove_bridge;
-	}
-
-	/* Attach secondary DSI, if specified */
-	if (lt9611uxc->dsi1_node) {
-		lt9611uxc->dsi1 = lt9611uxc_attach_dsi(lt9611uxc, lt9611uxc->dsi1_node);
-		if (IS_ERR(lt9611uxc->dsi1)) {
-			ret = PTR_ERR(lt9611uxc->dsi1);
-			goto err_remove_bridge;
-		}
-	}
-
 	return lt9611uxc_audio_init(dev, lt9611uxc);
 
-err_remove_bridge:
-	drm_bridge_remove(&lt9611uxc->bridge);
-
 err_disable_regulators:
 	regulator_bulk_disable(ARRAY_SIZE(lt9611uxc->supplies), lt9611uxc->supplies);
 
-- 
2.25.1


