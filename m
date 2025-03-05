Return-Path: <stable+bounces-120422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9C1A4FD68
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 12:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C14B3A3A6E
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 11:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FD623717F;
	Wed,  5 Mar 2025 11:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R3QzpMd/"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EA1233701
	for <stable@vger.kernel.org>; Wed,  5 Mar 2025 11:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741173477; cv=none; b=n8dQH+sihjeFuwPwtiR+DVQN71xeSS+4IsOMfgx5pzb61qKOR+lPYKFMBSD2/m3hWfxzw+3PV51+CRWVuXXCR8n1uMKbAE0SnoAp+iZLcNwIoY8sN75CqKCtCLbpXiyPRVNeGjmqpGX8LinQ3aon9kK+UWgbLy8SXdNsEnJgW2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741173477; c=relaxed/simple;
	bh=yclqQDzQ3fuTbQrldeL31okzvYD3Yv7nodsLYHb0az8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bh0yM3YQeDohPIsUEw9YFuJgiTUlIW6HohkwZ0VMFu2FMipUUbkSMI6Vll0YPuGOQKIR2rYWsjgo1Vycqg3Sd15LZnQSZsdr14lLk8en6BRAVE72tHIX5P69adUlFF6l3LeGjRmkOwmn01AANJTWOGDabRD01JQFFF5X4FL9fLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=R3QzpMd/; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso1220691466b.3
        for <stable@vger.kernel.org>; Wed, 05 Mar 2025 03:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741173474; x=1741778274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5Za3WdMVvxWz3492jYv2JlXl0TBbBgskHE33VDHckU=;
        b=R3QzpMd/5dJUQ3p3m+46sCd0tmZ4H8OlYTmIa+43QaZUXJSSrVDAqhxEARnGWBLaph
         0XvflDIvrWIHiHBpeZjh2KNVFvtCIScuy1f8mb9YcLRdeZZ7PSMcDmtpQIgWgmloRwK1
         KdDYIIJU0aqMCQQAYHR3zdYhYhs4bwLdMVlvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741173474; x=1741778274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5Za3WdMVvxWz3492jYv2JlXl0TBbBgskHE33VDHckU=;
        b=Rg7WXA3pGjc+An1vC5MYp66JRUs5xkDXE9OwuLW1j0bIFNqmEa6wqCvQy6UqhUMA44
         0r9X1TfJwXHBuiHvhpWPDq0qe/Q/pSFRn/Xq1GfljswvXsf7slNeUz+MLeqBPz9Jkj2o
         guDz4tLgg9DIRGC3xjuWfjSAuftN859S8cSH3AxCsVAi0EmrmMtYiMcWiWuJu2WtC3Kd
         RcPF2RhrX/Xgqdg8j1yjeykTAhkMc7BLYgng98NckAsGcBVSnG4sy4l86gbHS1hx5wGx
         21ma44QmTbXjSQX5lieUk9BYtrSfmZMAMHtOFZ0Isy8Y87S9xOh/v/bvyQZk8uzrn9Cv
         ZUOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqUKTYW/zl+v4iGTHV42KtXcRHUfhmuhwbUk2MZlX/1noXg8DMuq3ue6/R0+b149t4jqHhjSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUl/ZgnpqBbH4fJUYELG9GQTiMFYrto6Zmkqe9T06TMwzDduy1
	8aUQA/wb3EGq5O//QT/khIb95GGXT8LXIhO+OB7X5JpF5SCED2gtXh3UfieKcQ==
X-Gm-Gg: ASbGnct8zdoj8rBDLa5nqrT1A30DqNyygrQG/B9nPNDURtP6OcqTRoFtq3yTxxjX7yH
	R7W85xi29C4p4v3qk5ZX/XEueCuv3os6mICYIsK0xaGyQRS3Zzcf1pP4WeFS6yA2HZ79+3cyY2W
	zWnjXqL5XcpC4Tszby7putNb7PP5zgSH7D8b+01jkdXzpgUCsuJ8n5HJ+eUNcRfPQzKG66Mf3H7
	q3CqrpHtqAeXY+Z9Dri3pHYLfBx5MocwOTCB7gjYKFIMw2f5UeqRS3W8PeNzovgWwjfURQaxhj9
	li8YSIZsphqLq8nnX6Tg2u5YVBNluOL7G7ODW7TC/qZH64jADTMYjbe+zWh+9nx9vB8Oyw0gcHh
	V3xjsMasDHu+InCXzZHE2dmJDXGLYZwKtVNI=
X-Google-Smtp-Source: AGHT+IEqyW5X4ASwkw6LFXhgxDPUVU1GXyMLlS7feXUfmf2zFsVab6nnqWKmqGmgg4CjQS89d0mm5g==
X-Received: by 2002:a17:907:3da7:b0:ac0:4364:4091 with SMTP id a640c23a62f3a-ac20d844166mr259084666b.9.1741173474306;
        Wed, 05 Mar 2025 03:17:54 -0800 (PST)
Received: from akuchynski.c.googlers.com.com (140.20.91.34.bc.googleusercontent.com. [34.91.20.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac21e902cddsm35907966b.113.2025.03.05.03.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 03:17:52 -0800 (PST)
From: Andrei Kuchynski <akuchynski@chromium.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	Jameson Thies <jthies@google.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andrei Kuchynski <akuchynski@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/1] usb: typec: ucsi: Fix NULL pointer access
Date: Wed,  5 Mar 2025 11:17:39 +0000
Message-ID: <20250305111739.1489003-2-akuchynski@chromium.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
In-Reply-To: <20250305111739.1489003-1-akuchynski@chromium.org>
References: <20250305111739.1489003-1-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resources should be released only after all threads that utilize them
have been destroyed.
This commit ensures that resources are not released prematurely by waiting
for the associated workqueue to complete before deallocating them.

Cc: stable@vger.kernel.org
Fixes: b9aa02ca39a4 ("usb: typec: ucsi: Add polling mechanism for partner tasks like alt mode checking")
Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
---
 drivers/usb/typec/ucsi/ucsi.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index fcf499cc9458..43b4f8207bb3 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1825,11 +1825,11 @@ static int ucsi_init(struct ucsi *ucsi)
 
 err_unregister:
 	for (con = connector; con->port; con++) {
+		if (con->wq)
+			destroy_workqueue(con->wq);
 		ucsi_unregister_partner(con);
 		ucsi_unregister_altmodes(con, UCSI_RECIPIENT_CON);
 		ucsi_unregister_port_psy(con);
-		if (con->wq)
-			destroy_workqueue(con->wq);
 
 		usb_power_delivery_unregister_capabilities(con->port_sink_caps);
 		con->port_sink_caps = NULL;
@@ -2013,10 +2013,6 @@ void ucsi_unregister(struct ucsi *ucsi)
 
 	for (i = 0; i < ucsi->cap.num_connectors; i++) {
 		cancel_work_sync(&ucsi->connector[i].work);
-		ucsi_unregister_partner(&ucsi->connector[i]);
-		ucsi_unregister_altmodes(&ucsi->connector[i],
-					 UCSI_RECIPIENT_CON);
-		ucsi_unregister_port_psy(&ucsi->connector[i]);
 
 		if (ucsi->connector[i].wq) {
 			struct ucsi_work *uwork;
@@ -2032,6 +2028,11 @@ void ucsi_unregister(struct ucsi *ucsi)
 			destroy_workqueue(ucsi->connector[i].wq);
 		}
 
+		ucsi_unregister_partner(&ucsi->connector[i]);
+		ucsi_unregister_altmodes(&ucsi->connector[i],
+					 UCSI_RECIPIENT_CON);
+		ucsi_unregister_port_psy(&ucsi->connector[i]);
+
 		usb_power_delivery_unregister_capabilities(ucsi->connector[i].port_sink_caps);
 		ucsi->connector[i].port_sink_caps = NULL;
 		usb_power_delivery_unregister_capabilities(ucsi->connector[i].port_source_caps);
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


