Return-Path: <stable+bounces-95470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D57B09D9027
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 02:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B74F167022
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 01:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E353F14012;
	Tue, 26 Nov 2024 01:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="Bt0IoKvO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83637A41
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 01:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732585762; cv=none; b=dtATF2JKQ+SWplabcOG8CvOKd+Dvbz9JXgrgni653tIdbv0EbxpfAAjvzuHdTCR7Es1tC6nlPgARQvdVGs1BY05rZKGWMTFa1RsGFCkO1Ntsk53jB8ktZxgSamtCnFL/+bpmoojcJQDwnFcKqqmSPZ10ksluBoz3GAYW52FjxFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732585762; c=relaxed/simple;
	bh=V9n4MeRDPe+4fWZ9Q8OkwhxsH0flF2Ts41K5VQsP1XE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YIwz6cDSz7S0JN5Ct2WA4E4oP19mtw57YC/5GUs6yEhnIMw+oOngoPBgiRWWpWFWo+0xneKxlAk5JLGoBbCagUhhoiHtU5WxOj6RL252drlbrl09Rv0w6AfG+k6+yLg9nMn3p2hyUbmcgWjsYAkUvxx7PQYu4EobjxwXi1BlUVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=Bt0IoKvO; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-724d57a9f7cso4083269b3a.3
        for <stable@vger.kernel.org>; Mon, 25 Nov 2024 17:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1732585759; x=1733190559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vt7mGybW1iZZZE4YQwnh9I6d6z3VwlQXE58sGaFcvxE=;
        b=Bt0IoKvOnYvb7SnXbd/3mp/PBiwIesiwcKAEfrZnmhHfEQTV1MxvUTO5VHILNO5A9+
         3sqj3JXbCTmdFxk/8ADTbbEoBMxOfgDprzqJneLYSKEcs8BifuCPl0zzldQzZwo+Rw+7
         x48BG/JiY5cmKhnoG9oXiwMLfUL9rnDGAqMYIQhpo2KBcGX61Ta7wUn5m4T5IY+zIJIm
         bpw4dlS4YujuthTtNPMXSTym6pUmRfQVFbAbu0dhvon0pC6V8s96x/INraWBeBnEuZVE
         hU4js4wEGg11OHqY4oo1eBD61/PnDpVGY8753vG80ZNkDnmhHSgX82/1cOD1C22Ev/h3
         2Ajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732585759; x=1733190559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vt7mGybW1iZZZE4YQwnh9I6d6z3VwlQXE58sGaFcvxE=;
        b=vS+k7q4sLmzUpWPkhmoJAGswqwNogePAIQzS7d2flZCg8vZqDZER6QOAxU2oLoQ1qY
         v0Ia2tUUu9jdHq29lb72QZnerIlBzGYcm1vFatnjx8ilBULkwUlTbzWDzoJ/5pej3chD
         fGI+QJbvtZ31KPbbqi+BiItw2yVcc4UR3FQzrOIf8wA1OeXhjXFYmnXTTrz7CAX8QRDr
         wpViIZ32B8yfiqnUxfX/7wSO8i+bbHWgX/9L+XU0P91k/K7YVOrYl9qlHZvo324iDVCr
         14BlyIoDg+aLL+mX2oAzWrE75oto31OsEwzp7P7qrdbJDy7LkL7WEZjW/u2Jx1EopNd3
         By8w==
X-Forwarded-Encrypted: i=1; AJvYcCXHzQarU5cU4OOka0AiS55PTgmDA5Os9rcCfcJ9M/StX1qoZvLZvt1IANZ4h0vuPs6Ztvv55bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzudpcV2zOznaYfbbShmbVBe1bY0/uFVB9a0NW90PORtklrB6zu
	C5+Zjwa/SEoAio8NvojUYZvdO5Hd2CtVk6eoxvwQdCXidJl8qE3YWwy6zXE6AvM=
X-Gm-Gg: ASbGnctOvW2crK3my0Efve2QSOzBvYy0ry8QODqnUlhBY8MPG0l/1jzNQ1WELyQVpkX
	qXy6oGOltcvv2rh0H84MsoFTh3mMtipmZgVefuR4x99q4koD4exRaEHuzpMUY4ScEZhOTxDJz8R
	xQgLG7WtrsEMh5aRuEr9CTUrxcRnFr7Lr9FeyNUEnle3S4bQZoRYUMZsJJqB13ZXhua8InLlRpL
	Nh/rNqly1GuP0newMIjtWstRHmEWD73Yz9kBUZdlkdwYlpUzeyYadHh/9FhA8vPpdimpJkLJ840
	873B+w0Iuqwmsffo88YLXEcMr1e9IizQdzbp
X-Google-Smtp-Source: AGHT+IElq9tbI3ZPZB29F9PY1kq+FkSz+Yb9bfk4fnWSGxSiJzRUcjYurxObxoXlEWLdMonH6RcAYA==
X-Received: by 2002:a05:6a21:6d93:b0:1db:e10b:8a9a with SMTP id adf61e73a8af0-1e09e3bd688mr19822830637.6.1732585758657;
        Mon, 25 Nov 2024 17:49:18 -0800 (PST)
Received: from localhost.localdomain (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de55ae00sm7160408b3a.163.2024.11.25.17.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 17:49:18 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	stable@vger.kernel.org
Subject: [PATCH v3] usb: typec: anx7411: fix OF node reference leaks in anx7411_typec_switch_probe()
Date: Tue, 26 Nov 2024 10:49:09 +0900
Message-Id: <20241126014909.3687917-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The refcounts of the OF nodes obtained by of_get_child_by_name() calls
in anx7411_typec_switch_probe() are not decremented. Replace them with
device_get_named_child_node() calls and store the return values to the
newly created fwnode_handle fields in anx7411_data, and call
fwnode_handle_put() on them in the error path and in the unregister
functions.

Fixes: e45d7337dc0e ("usb: typec: anx7411: Use of_get_child_by_name() instead of of_find_node_by_name()")
Cc: stable@vger.kernel.org
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
 drivers/usb/typec/anx7411.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/typec/anx7411.c b/drivers/usb/typec/anx7411.c
index 95607efb9f7e..0ae0a5ee3fae 100644
--- a/drivers/usb/typec/anx7411.c
+++ b/drivers/usb/typec/anx7411.c
@@ -290,6 +290,8 @@ struct anx7411_data {
 	struct power_supply *psy;
 	struct power_supply_desc psy_desc;
 	struct device *dev;
+	struct fwnode_handle *switch_node;
+	struct fwnode_handle *mux_node;
 };
 
 static u8 snk_identity[] = {
@@ -1099,6 +1101,7 @@ static void anx7411_unregister_mux(struct anx7411_data *ctx)
 	if (ctx->typec.typec_mux) {
 		typec_mux_unregister(ctx->typec.typec_mux);
 		ctx->typec.typec_mux = NULL;
+		fwnode_handle_put(ctx->mux_node);
 	}
 }
 
@@ -1107,6 +1110,7 @@ static void anx7411_unregister_switch(struct anx7411_data *ctx)
 	if (ctx->typec.typec_switch) {
 		typec_switch_unregister(ctx->typec.typec_switch);
 		ctx->typec.typec_switch = NULL;
+		fwnode_handle_put(ctx->switch_node);
 	}
 }
 
@@ -1114,28 +1118,29 @@ static int anx7411_typec_switch_probe(struct anx7411_data *ctx,
 				      struct device *dev)
 {
 	int ret;
-	struct device_node *node;
 
-	node = of_get_child_by_name(dev->of_node, "orientation_switch");
-	if (!node)
+	ctx->switch_node = device_get_named_child_node(dev, "orientation_switch");
+	if (!ctx->switch_node)
 		return 0;
 
-	ret = anx7411_register_switch(ctx, dev, &node->fwnode);
+	ret = anx7411_register_switch(ctx, dev, ctx->switch_node);
 	if (ret) {
 		dev_err(dev, "failed register switch");
+		fwnode_handle_put(ctx->switch_node);
 		return ret;
 	}
 
-	node = of_get_child_by_name(dev->of_node, "mode_switch");
-	if (!node) {
+	ctx->mux_node = device_get_named_child_node(dev, "mode_switch");
+	if (!ctx->mux_node) {
 		dev_err(dev, "no typec mux exist");
 		ret = -ENODEV;
 		goto unregister_switch;
 	}
 
-	ret = anx7411_register_mux(ctx, dev, &node->fwnode);
+	ret = anx7411_register_mux(ctx, dev, ctx->mux_node);
 	if (ret) {
 		dev_err(dev, "failed register mode switch");
+		fwnode_handle_put(ctx->mux_node);
 		ret = -ENODEV;
 		goto unregister_switch;
 	}
-- 
2.34.1


