Return-Path: <stable+bounces-89130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9209B3DCD
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 23:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 470AF1F231F1
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 22:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142561F428D;
	Mon, 28 Oct 2024 22:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WokOkl2/"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E35192B81;
	Mon, 28 Oct 2024 22:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730154878; cv=none; b=UYvDgq0vqkYM2znH4U8n6OSEQq2+nc2Eoy5OX13064etFAizrezxz/5/OmCFivSM1dGN+lT+ESt8cVfhcoFTXYV68W237u3Nm3SdTlRQ4J6spBd+YgEqnHbsf1HXx+lG/fuYI4usP+5/SgeV8reb3CKv/WHQYg2hw2NpHgD87lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730154878; c=relaxed/simple;
	bh=ShLgN2bKe4JPnIwWKc8bL7okfKb596zokxGFYpN8MrY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r3RI5eVjV4Ezv38pGHtxwvHDWp7nbFsJdTKJ3dHiolcA1VlprMWucVOf4KlmXOQqU7yGvVu90PBbAym3WLXbI//Ny06SQo4CHeuzJ2K/H1OioqNWMPsr7yDKVJ3aUyoO9BjF81WEFx28bA0LtBTAaZrJgX30gKinJ+vX7/0X4ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WokOkl2/; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-431695fa98bso46953485e9.3;
        Mon, 28 Oct 2024 15:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730154875; x=1730759675; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Umbi077YGFKFtcJYYJqpH70S/3kQKJNrTf3ziqRBrzQ=;
        b=WokOkl2/MW6sKF4k87K+bbFXB66vYOAZ0XPiaZKAKRnQqMczR9HkrEsDqKdu8y1Ma9
         l/nDkWEOakLfKr54y2T3yNMDNI8QD0n0HZxVP6QNGUBTKmnPwdtHAJ0imVkR0isS+NeP
         NvQEAXkdQlJBpUJ0N43w/960OvfAU5WMHnLvWWLjVPNfGqTvvbRZwntO4+Lp9GMh9WWC
         Ua+cG+GKAkNyP1z6/vVWQ/q2e8ZyFI+48BEjJ8xH8IfxkzLrDqNrVaneo02TcOOU8r7k
         wHL1p7ZutlrXx20rs4QvMIBetgb/HXorNqCsKRdP56BNdbMtKcMz05E8RZAJhX5/Za4u
         AF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730154875; x=1730759675;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Umbi077YGFKFtcJYYJqpH70S/3kQKJNrTf3ziqRBrzQ=;
        b=jWnE/Y/2PexYJl1vkZDF47ZcFDzO4aL9yarUsRzpJaSNJgzsl1KmQcN9FEJGVU8MM6
         NHjXUG2XVxe1Dyvlw+zvT2GjoXWefbYnZDO2lpF6xdgribZykW9ydMkr9jRVim3PMPR1
         Pgstb2NWz+JJs6opIFFiYrk1x0jGag6v/nDrNIprj0xizIPFngrGIGG2+8GhIafov6Jr
         pptdSYcxGhZdv8snQAQrUTPEL65kaeOTj4uFeceRWpuXsgF5LHw0nrn9JH64sRe8Kdpr
         jQ03OVBX3rYNMa5i+6rgRXI9asDZfrY9pFYBG/G2HVmAYBuFXbb0I+l95ZJzcS/+x57N
         H4Cg==
X-Forwarded-Encrypted: i=1; AJvYcCU/9whu/ytz0QbWLuAh8PXJP7pGXGtW4dWnSpdc+TNsDGPnKnLmN7soTdBO5AzQnMrTmfHn51MS@vger.kernel.org, AJvYcCVVh31TqwaJj/pzMx/ECmuDE2O+ZeSLa/unRrckNdy4yBDPnxxVXG2/z3TdLdWZPADRFKR066zF5ZoOvkM=@vger.kernel.org, AJvYcCWmgDBf+2CyLqaEm+nCUH3ryOxMADlOY1Qzq/vybcwmHuGo7v3jcStQJIoY7Iq774+JCb1s1yKxKCJBNHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxMygfjq33rV9bMoGyI20Ynpb6nz5q2befSfKXmfCr088477gQ
	+fYKf/dmcRxAIaEvc77MtmhMkv34sIxtwu4gKx0Rx8vSnb/VxiapPIJZMsr3
X-Google-Smtp-Source: AGHT+IGCjkJZ9eJSF/Sc7bAu5q1bN/kYQ/lyfVC4BotHVNbJE1py9x0UYLnUH92QNn97PY9pFtQU8A==
X-Received: by 2002:a05:600c:4eca:b0:431:5c1c:71b6 with SMTP id 5b1f17b1804b1-4319acad842mr107185795e9.17.1730154874410;
        Mon, 28 Oct 2024 15:34:34 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-b273-88b2-f83b-5936.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b273:88b2:f83b:5936])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431935f7213sm123899495e9.32.2024.10.28.15.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 15:34:33 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 28 Oct 2024 23:33:58 +0100
Subject: [PATCH 1/2] phy: tegra: xusb: fix device release in
 tegra210_xusb_padctl_probe
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-phy-tegra-xusb-tegra210-put_device-v1-1-28f74368c9ba@gmail.com>
References: <20241028-phy-tegra-xusb-tegra210-put_device-v1-0-28f74368c9ba@gmail.com>
In-Reply-To: <20241028-phy-tegra-xusb-tegra210-put_device-v1-0-28f74368c9ba@gmail.com>
To: JC Kuo <jckuo@nvidia.com>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>, linux-phy@lists.infradead.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730154870; l=1220;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=ShLgN2bKe4JPnIwWKc8bL7okfKb596zokxGFYpN8MrY=;
 b=CkUGA0g9V9/hi4kz0/FdhdlF68Sq5yOTG7pgrsPGdhuQfPzIqy3K/JA1kPIs5LQiP9EYbaGmh
 QgBISNz3DEXD3rkLwdrhr9h2sixv9p9sG85wxwHzFrJ7fKGioXLJ/jB
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

A reference to a device acquired via of_find_device_by_node() needs
to be released when it is no longer required by decrementing its
refcount, which avoids leaking the resource.

Add the missing call to platform_device_put() as soon as 'pdev' is no
longer required.

Cc: stable@vger.kernel.org
Fixes: 2d1021487273 ("phy: tegra: xusb: Add wake/sleepwalk for Tegra210")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/phy/tegra/xusb-tegra210.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/tegra/xusb-tegra210.c b/drivers/phy/tegra/xusb-tegra210.c
index ebc8a7e21a31..9c7fdd29b7c4 100644
--- a/drivers/phy/tegra/xusb-tegra210.c
+++ b/drivers/phy/tegra/xusb-tegra210.c
@@ -3169,13 +3169,17 @@ tegra210_xusb_padctl_probe(struct device *dev,
 		goto out;
 	}
 
-	if (!platform_get_drvdata(pdev))
+	if (!platform_get_drvdata(pdev)) {
+		platform_device_put(pdev);
 		return ERR_PTR(-EPROBE_DEFER);
+	}
 
 	padctl->regmap = dev_get_regmap(&pdev->dev, "usb_sleepwalk");
 	if (!padctl->regmap)
 		dev_info(dev, "failed to find PMC regmap\n");
 
+	platform_device_put(pdev);
+
 out:
 	return &padctl->base;
 }

-- 
2.43.0


