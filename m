Return-Path: <stable+bounces-93630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 709D99CFD63
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 09:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007241F231ED
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 08:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8B1191F92;
	Sat, 16 Nov 2024 08:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="W8yOUEL4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFE9190678
	for <stable@vger.kernel.org>; Sat, 16 Nov 2024 08:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731747095; cv=none; b=sVrrP6O6JuaYPdabDXDoZC2Ug6MG0ksYy6uyRF9Z44/ChOufsOZwYpQt/u6Qpw5MoKi3L+Rd8GYT9JUm+/gTA9GiL/oVtWzZssud/lwzs3BHf//qSoTmGEwVCSu9hncjTHE9VJTUzpQeYF6LMlPI2LZE5T5a7IocUuWIwJzMoYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731747095; c=relaxed/simple;
	bh=f6mHnkDPvOKbkgTDa/SxzETiajleiUT+YIc+lsKI6jI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ofI3LbuNafnF7it3k/wxsDtIXLy+BBTTl8tc3abKZg/AoWwe865XXiynJrOEbytNFJ3klURyNw2BYVP7m8a+uEUlnC4E0QY6LQcGusg2waf1z9j+WccAZUQn47rvDmwZYNqKL8LnkPCocZ9VT6WvrqOu3vXtJdIlohfFKKXlzF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=W8yOUEL4; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ea14c863c1so308221a91.0
        for <stable@vger.kernel.org>; Sat, 16 Nov 2024 00:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1731747092; x=1732351892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=El+mIE1puynndiHCyRWzcjoNn60mpCRnTuzxZYTOXRU=;
        b=W8yOUEL4wIDiyBJ9QBzQlA5Zc/r32nOcABKKclOUXFqHQKi0FWWTdJPtL+/epKSgG6
         q2i3KgKppnUOyuNfiyWgu+cGPM7AhESU1L7KREvoX/ax14kLrFaMv/9Guxrx5h1Edd7w
         rNcV/dobJ/RFHdQOAlskd++yoNx8RJeWEAPcL1eT5BMBlZSS3NN0KiIfvldBBZkSWB61
         cBg5NgqtqyNfLW+DauR6FcSjffBZ4iYsCtrVmx14Pj5qierm8UetK0ouMoY3o4TNcR6m
         sNtIzNvRpPfiDj4/hBiGGKc7xcj6hcvfs0IbWipIyEXHW4DfU+uaHrv11wusV3e8WgZc
         PATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731747092; x=1732351892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=El+mIE1puynndiHCyRWzcjoNn60mpCRnTuzxZYTOXRU=;
        b=mROKZYvNre1zRd02MhafhDn27m6KIh1zBcTWAJh01WZsId368Gp6769lCNiOrVwXAZ
         MqIIHmQ7chWbT9h6JAAUabaOgfQXsG5rzZB+Xmf4MjMGLh7AuZkobB0i6/DCJLPT4Kev
         bdD06wZJKAK+tY6hg4UeeF1mCOXvczTFF+gMPGIpd2dfykqIfqLrLruRW2JwDQlZ6pJq
         GNvrKfTBllvF1cY1wEW3WdXqiBLH5MXbahxRpUPXHtm/6q02j0M8XZ0dnQkDyxvORRT/
         oLt1SKVKeCDpR0VXp9KOQbMfo2fveFD5K0krCEgsZyP0XpI1qFpTbniRRZ5WaIAPwEOG
         lFWw==
X-Forwarded-Encrypted: i=1; AJvYcCXY+Y2M5f/0qIt9vpnrU8uyZq23M8Q3AVrmE7AT/Ct5VhzydrjDvXWqxvxkYeS5VyA9rBgEU9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5iNCMdMABzriAWSHnY+0FoW2daSHjwIXJNLdkqgQ5d+ptbAc8
	R818S8YcIaxqYtQmxaaNnABvhi+rKaqkIoQZrzP87nSIqgs8XaKarSOyXx8GpY8=
X-Google-Smtp-Source: AGHT+IHc63oodTjpxWpthwwhNXH88hivRIVdpBQX07Hchw+AjfD5u+lb06nqQJ1kDu8r0VMR3t7opg==
X-Received: by 2002:a17:90b:4c07:b0:2e2:d7db:41fa with SMTP id 98e67ed59e1d1-2ea15596d00mr7683908a91.33.1731747092280;
        Sat, 16 Nov 2024 00:51:32 -0800 (PST)
Received: from localhost.localdomain (133-32-133-31.east.xps.vectant.ne.jp. [133.32.133.31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f45fa4sm23863285ad.185.2024.11.16.00.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 00:51:31 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	stable@vger.kernel.org
Subject: [PATCH] usb: typec: anx7411: fix fwnode_handle reference leak
Date: Sat, 16 Nov 2024 17:51:24 +0900
Message-Id: <20241116085124.3832328-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An fwnode_handle is obtained with an incremented refcount in
anx7411_typec_port_probe(), however the refcount is not decremented in
the error path or in the .remove() function. Therefore call
fwnode_handle_put() accordingly.

Fixes: fe6d8a9c8e64 ("usb: typec: anx7411: Add Analogix PD ANX7411 support")
Cc: stable@vger.kernel.org
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
 drivers/usb/typec/anx7411.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/typec/anx7411.c b/drivers/usb/typec/anx7411.c
index 7e61c3ac8777..d3c5d8f410ca 100644
--- a/drivers/usb/typec/anx7411.c
+++ b/drivers/usb/typec/anx7411.c
@@ -1023,6 +1023,12 @@ static void anx7411_port_unregister_altmodes(struct typec_altmode **adev)
 		}
 }
 
+static void anx7411_port_unregister(struct typec_params *typecp)
+{
+	fwnode_handle_put(typecp->caps.fwnode);
+	anx7411_port_unregister_altmodes(typecp->port_amode);
+}
+
 static int anx7411_usb_mux_set(struct typec_mux_dev *mux,
 			       struct typec_mux_state *state)
 {
@@ -1158,34 +1164,34 @@ static int anx7411_typec_port_probe(struct anx7411_data *ctx,
 	ret = fwnode_property_read_string(fwnode, "power-role", &buf);
 	if (ret) {
 		dev_err(dev, "power-role not found: %d\n", ret);
-		return ret;
+		goto put_fwnode;
 	}
 
 	ret = typec_find_port_power_role(buf);
 	if (ret < 0)
-		return ret;
+		goto put_fwnode;
 	cap->type = ret;
 
 	ret = fwnode_property_read_string(fwnode, "data-role", &buf);
 	if (ret) {
 		dev_err(dev, "data-role not found: %d\n", ret);
-		return ret;
+		goto put_fwnode;
 	}
 
 	ret = typec_find_port_data_role(buf);
 	if (ret < 0)
-		return ret;
+		goto put_fwnode;
 	cap->data = ret;
 
 	ret = fwnode_property_read_string(fwnode, "try-power-role", &buf);
 	if (ret) {
 		dev_err(dev, "try-power-role not found: %d\n", ret);
-		return ret;
+		goto put_fwnode;
 	}
 
 	ret = typec_find_power_role(buf);
 	if (ret < 0)
-		return ret;
+		goto put_fwnode;
 	cap->prefer_role = ret;
 
 	/* Get source pdos */
@@ -1197,7 +1203,7 @@ static int anx7411_typec_port_probe(struct anx7411_data *ctx,
 						     typecp->src_pdo_nr);
 		if (ret < 0) {
 			dev_err(dev, "source cap validate failed: %d\n", ret);
-			return -EINVAL;
+			goto put_fwnode;
 		}
 
 		typecp->caps_flags |= HAS_SOURCE_CAP;
@@ -1211,7 +1217,7 @@ static int anx7411_typec_port_probe(struct anx7411_data *ctx,
 						     typecp->sink_pdo_nr);
 		if (ret < 0) {
 			dev_err(dev, "sink cap validate failed: %d\n", ret);
-			return -EINVAL;
+			goto put_fwnode;
 		}
 
 		for (i = 0; i < typecp->sink_pdo_nr; i++) {
@@ -1255,13 +1261,18 @@ static int anx7411_typec_port_probe(struct anx7411_data *ctx,
 		ret = PTR_ERR(ctx->typec.port);
 		ctx->typec.port = NULL;
 		dev_err(dev, "Failed to register type c port %d\n", ret);
-		return ret;
+		goto put_fwnode;
 	}
 
 	typec_port_register_altmodes(ctx->typec.port, NULL, ctx,
 				     ctx->typec.port_amode,
 				     MAX_ALTMODE);
 	return 0;
+
+put_fwnode:
+	fwnode_handle_put(fwnode);
+
+	return ret;
 }
 
 static int anx7411_typec_check_connection(struct anx7411_data *ctx)
@@ -1528,7 +1539,7 @@ static int anx7411_i2c_probe(struct i2c_client *client)
 
 free_typec_port:
 	typec_unregister_port(plat->typec.port);
-	anx7411_port_unregister_altmodes(plat->typec.port_amode);
+	anx7411_port_unregister(&plat->typec);
 
 free_typec_switch:
 	anx7411_unregister_switch(plat);
@@ -1562,7 +1573,7 @@ static void anx7411_i2c_remove(struct i2c_client *client)
 	if (plat->typec.port)
 		typec_unregister_port(plat->typec.port);
 
-	anx7411_port_unregister_altmodes(plat->typec.port_amode);
+	anx7411_port_unregister(&plat->typec);
 }
 
 static const struct i2c_device_id anx7411_id[] = {
-- 
2.34.1


