Return-Path: <stable+bounces-91971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3148F9C288C
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 01:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA942285B60
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 00:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1F34C62;
	Sat,  9 Nov 2024 00:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nwSuc63W"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95EB2F42
	for <stable@vger.kernel.org>; Sat,  9 Nov 2024 00:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731110664; cv=none; b=mFw927nIDdR3dYK3Lnn0B9493s0RfYZwmXPQYmXFs+1ilhOeYoO61mQACCXq3ASuiTpQMa+ozgiKQhZjrxgWcMVkT/HwCI+235ZpwNDC5fEVZSXjLEMMhkhw2Jqm5UmZH4NBOXdjwlMr1Hyr+EXA66l9vIqkV4yZKvBTyjg37uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731110664; c=relaxed/simple;
	bh=3V2nbDJYpptGWjzVHtq/pkL46D3rJH/ZxerBXx7L1ek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G6J+qTdXOoktEPcbQJFXL2tI4nOKy6Eqg1kQg2qWnC+ti5ijQHsSOhxYa0SEaouxsgBPVb04lhB37jem4H7S5X1TFHjOZcliTIsU4DsJbEOtnf89Ngo+S5mtNv0HIKfSYkm58pqj8ooyAii8BaFoLglIaOOVYpfaQ7SpLmWJzac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nwSuc63W; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb4fa17044so26691881fa.3
        for <stable@vger.kernel.org>; Fri, 08 Nov 2024 16:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731110661; x=1731715461; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3s5+t9Fz8C3WI9SbcTcnEleY6fD4F078kSD55sW9Rqo=;
        b=nwSuc63WXXMCd+uvf1DztDco+fJZ5r30CNpzKrwPUwSzGyK5tEcJDcGNt69YgMBWg5
         UpK9UxIMsXwc0Ntdcz+Z/mDpqXAH+PAry7k+napx2U3mdgy865xR5yhZqa35bGprat3E
         xlXfZxJiOqaWDwdqaffX1ze6egKnJp4/DFxeAUD5ZULJsDLYUsWA7nukrEM/0IfifI3y
         SGBVjglJ/10XNXm7YmEriBbFIPrBs9YCgyjJJ5G4cv280vFsm98c/gE8Jh+Uz9cl80fC
         vg2kZ7N6+NKI9ILB+mytmMx4Oc4bfsTVLF7OKl5B8W/xMT7tD2Y2akqxJ++wg0HcJy7q
         I7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731110661; x=1731715461;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3s5+t9Fz8C3WI9SbcTcnEleY6fD4F078kSD55sW9Rqo=;
        b=eSZG5PqXjn42PoxCjCQjjjUifUKiuqrh1jZquRjtURJC1Mqiml6o1XTDhaEM7tgXTL
         33iOMehOg9xYEFHpWVPQVm25A7Wr8valmFH0/tY9U266HLIdw/8wMh9vD4Lj+0w96USH
         2MoqbyreXwjrKXjJQMSnIA8eWNLl3nIYM9iH4brmLwy63GNKR2Wy7uW6BUVcgcdZyuVr
         EwXIsHUR1FA/+1XzNdzJwdArCagWLZqV8DEVliLML6Wd6aFarGqLxfeC86zf3MtgswKA
         a1bBRJ8NKH+OoA3aT/mmCJa2JYK9vg2UyOsuo16dU4sPVrlGPC6r7wN3DWEBmUhtjc+M
         NI5Q==
X-Forwarded-Encrypted: i=1; AJvYcCU904ZnvtnJo8cpqXXOKfsQkP1bjGPYrPy6Q2Tv+3lEkTe3S1KWWldjed8wiYI8S+FUirMa8JM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDtMoOrJejReDbuEDvF0mKfbxO7P78FufrRcDFHckPM58CpU18
	jzM4AALd0tQmc7K175gjBFY129iSUtCqoFTs5mde6KXdhDmBGQ6IqRdxpTOLBnU=
X-Google-Smtp-Source: AGHT+IGSMmGdQuupUVqY9d2iFzKEZntKmWoUY0L+QAr8gmtjlKLNeXFZizvFw9XedM2SCOaMM9LMnQ==
X-Received: by 2002:a2e:be20:0:b0:2fa:cac0:2a14 with SMTP id 38308e7fff4ca-2ff20185b17mr28584861fa.11.1731110660983;
        Fri, 08 Nov 2024 16:04:20 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff17902152sm8221431fa.57.2024.11.08.16.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 16:04:19 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 09 Nov 2024 02:04:14 +0200
Subject: [PATCH v2 1/2] usb: typec: ucsi: glink: fix off-by-one in
 connector_status
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241109-ucsi-glue-fixes-v2-1-8b21ff4f9fbe@linaro.org>
References: <20241109-ucsi-glue-fixes-v2-0-8b21ff4f9fbe@linaro.org>
In-Reply-To: <20241109-ucsi-glue-fixes-v2-0-8b21ff4f9fbe@linaro.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogeurs@linux.intel.com>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1326;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=3V2nbDJYpptGWjzVHtq/pkL46D3rJH/ZxerBXx7L1ek=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnLqb/RrUpLWMzqz3Z50ZKx/wbVyesK9kxjZEAY
 RQM0ENGhVeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZy6m/wAKCRCLPIo+Aiko
 1S5sB/9SKnz2iqzGhPdnAXBwJ6/U0QudJSc9xvuqb78wO25ZQ7KYAjSI6hvHXzp9ls2+5S8SBeL
 WDMGlFiew5Oja0bwxBt/MAjdWkSTGYRTQw2Y2svetrKXKlK4+m1OQpnj8VuQqiLUainPpArGLOb
 eqOIsSgkffIYS2gYP54NtWvH4Ub0EY8D/plW4vAMAdEAYIsHUOJ74LIVcyHUUV+2Axs3DKHNDFN
 XDjWLiMMX7JbTfgYCHdqKRhYe/xWDsGK5VYQU3xW10vkVm04wGyXH6ukNpSsmYa/ZzdQGWmLCF7
 Mk56gvQwu2JwBan6mB1G4zXLobHEnX4D7VcWBWZ7tL/Z/rVK
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

UCSI connector's indices start from 1 up to 3, PMIC_GLINK_MAX_PORTS.
Correct the condition in the pmic_glink_ucsi_connector_status()
callback, fixing Type-C orientation reporting for the third USB-C
connector.

Fixes: 76716fd5bf09 ("usb: typec: ucsi: glink: move GPIO reading into connector_status callback")
Cc: stable@vger.kernel.org
Reported-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/usb/typec/ucsi/ucsi_glink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index 3e4d88ab338e50d4265df15fc960907c36675282..2e12758000a7d2d62f6e0b273cb29eafa631122c 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -185,7 +185,7 @@ static void pmic_glink_ucsi_connector_status(struct ucsi_connector *con)
 	struct pmic_glink_ucsi *ucsi = ucsi_get_drvdata(con->ucsi);
 	int orientation;
 
-	if (con->num >= PMIC_GLINK_MAX_PORTS ||
+	if (con->num > PMIC_GLINK_MAX_PORTS ||
 	    !ucsi->port_orientation[con->num - 1])
 		return;
 

-- 
2.39.5


