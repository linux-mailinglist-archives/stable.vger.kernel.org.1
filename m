Return-Path: <stable+bounces-94483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D75E89D45CB
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 03:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97B1D284356
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 02:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8932C54918;
	Thu, 21 Nov 2024 02:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="E3m6zsTI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB0D12FB1B
	for <stable@vger.kernel.org>; Thu, 21 Nov 2024 02:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732156768; cv=none; b=fwh1X8EHHBL0Kl91Bco7yPPMoNiKFsBXdlshTZBEieH5zpgq7dDtMUiVcRfLs/RZfA/NGbfYv3o6ylOd5PXjKvvdn7P2aWOSJZHG/3MZwqU/IKLweCnXmaBnkDOdPnHKOSW6LoGW70+8bs3oRB1/qKOgwNbhWlw3SpzAUnjGvJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732156768; c=relaxed/simple;
	bh=2H7mtQzYp0TLoyfuYgyWe2slyZ2FdqNj/Q1Q7UJc4vs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FrYRvUHXXUqQVnT9mi9WkwivRMhBjAWRgTHP33tJjO2uRFUmhcf2tzSWY5FjLPFSbWzOVh8ocS9FvvIwl8GTEClXZWGtvgOlr8jN+lFeIkac3399jDoLDxrn2F+sIwrwmC8BWuHdgh5tQeqCuA7nG1yZLOnlauH7TK1oV8rilxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=E3m6zsTI; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7f46d5d1ad5so369693a12.3
        for <stable@vger.kernel.org>; Wed, 20 Nov 2024 18:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1732156765; x=1732761565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mMEAUur1BpykWlac5weiHbatFHF9XI1zWsCYMdjHiJ4=;
        b=E3m6zsTIpMqDYghLB5yQBpcbwpGXP5NPDVGnuffn+glOpVji5f3GwlQwyzjn2issgK
         Tboa79tWlASEJhdvsGeq7XE1SSkzJoGn8UvbnZZZJSSWEJWUR7I9CSgb8jfaXGXPImJu
         Qo5AMJjHyYIs/1oJsa1TNMSI4iRzIR9gBCO4mGzyC/v41qVCgIgkxgZ32PY+9OejAfAH
         mYQIu77P6FD+bVy+xRLA9HXV+28bwcLPAVwwbl8Lw2LYApVyaFxOHMfGq/9QdBGGdv1+
         wNJFHs7bf0iBOFVfVUTCt8nktyGAkxRb62nQ/1h8aM8Co7612w0BNB4Pl4Qh0q1j8+df
         /IcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732156765; x=1732761565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mMEAUur1BpykWlac5weiHbatFHF9XI1zWsCYMdjHiJ4=;
        b=l+0YJYJt/rpMOw3JwidVD1xP2pO76jAyP71Xi5eJX3p4bQ9AQddDyf4/0wGZglpKNe
         zDh9R2W7e3WtDYdZYN1ERCwNyQq9tcnWyBN7K1VuqHczU+w49ERDXaei8PZX/yrpZvKa
         WS3TvyYXYFXyD6onPxkKBPp03cuiZ0BZSuwZEggy5cD66Vudd1at0Q4s6ZpPezFVXLUs
         +FdjHY8la8KlQA+hJHsiKxHX+j+hZGOycsN/chbJL6k9XiXp4Yrzo7hel7XswJalLnaA
         c3h+6kth7/cYpyM1JQDueOdxRFQjSaHjK0BJLIEdzKOx9iHERlb4F+T21EfcBCjlw5ut
         S2iQ==
X-Forwarded-Encrypted: i=1; AJvYcCXR4UMUkIfypDZUWhweqXUG/7tAXtkpB4sDLSVrTbUUF1C8b2pYvd4NILLDYQ4ZLauKRJeiLJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGFFe0OH2/O0iE44Jvadlz97fIvqdxOKpaRgAy4Pv0nL2gf96i
	1vmIYpfPTF3MCTSDoE1Vloq7rDZIokK8Q2Q6/HauPate3uks0/CPoSqVmR+XqYM=
X-Gm-Gg: ASbGncuJTBuJ69DyoOXmPpcZbjAFn1ngDgH1XN9FjAr4nZS2Qfa9MAZh8oETmuAr0Sr
	iP/61LvwZbc+lIzH5/Sm4byl+l75qd/qV1H1mFFyOnbMKW/3GTMeja8cBPZmitzxf+Vml3ekba3
	lppGElhsM9dCXY8CoDFkRRhtc6dalAA9xwtwBDKF40X8p1Gjrtrzt3gCMcXWLv2tbUzed5vApFP
	2KDw5JI2kBPBzKHcb1Ge2SyVZ0wCTMBke4FT90xCw6PTeTzd7Tc3TTC84EC1qoO2aXmWntSiw==
X-Google-Smtp-Source: AGHT+IHI5jcjo/SbYG3H3PQ9jXV+M8eqBfpICerWU4nqBvnHNPBnXqddR0amd9ZDq9cLAwlUHwyAZA==
X-Received: by 2002:a05:6a20:a110:b0:1db:f02d:dd49 with SMTP id adf61e73a8af0-1ddb10dfb56mr7310382637.40.1732156765193;
        Wed, 20 Nov 2024 18:39:25 -0800 (PST)
Received: from localhost.localdomain ([2001:f70:39c0:3a00:2973:c72c:77ad:fd3c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724bef8d94bsm2390701b3a.114.2024.11.20.18.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 18:39:24 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	stable@vger.kernel.org
Subject: [PATCH v3] usb: typec: anx7411: fix OF node reference leaks in anx7411_typec_switch_probe()
Date: Thu, 21 Nov 2024 11:39:14 +0900
Message-Id: <20241121023914.1194333-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The refcounts of the OF nodes obtained in by of_get_child_by_name()
calls in anx7411_typec_switch_probe() are not decremented. Add
additional device_node fields to anx7411_data, and call of_node_put() on
them in the error path and in the unregister functions.

Fixes: e45d7337dc0e ("usb: typec: anx7411: Use of_get_child_by_name() instead of of_find_node_by_name()")
Cc: stable@vger.kernel.org
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
Changes in v3:
- Add new fields to anx7411_data.
- Remove an unnecessary include.
---
 drivers/usb/typec/anx7411.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/typec/anx7411.c b/drivers/usb/typec/anx7411.c
index 95607efb9f7e..e714b04399fa 100644
--- a/drivers/usb/typec/anx7411.c
+++ b/drivers/usb/typec/anx7411.c
@@ -290,6 +290,8 @@ struct anx7411_data {
 	struct power_supply *psy;
 	struct power_supply_desc psy_desc;
 	struct device *dev;
+	struct device_node *switch_node;
+	struct device_node *mux_node;
 };
 
 static u8 snk_identity[] = {
@@ -1099,6 +1101,7 @@ static void anx7411_unregister_mux(struct anx7411_data *ctx)
 	if (ctx->typec.typec_mux) {
 		typec_mux_unregister(ctx->typec.typec_mux);
 		ctx->typec.typec_mux = NULL;
+		of_node_put(ctx->mux_node);
 	}
 }
 
@@ -1107,6 +1110,7 @@ static void anx7411_unregister_switch(struct anx7411_data *ctx)
 	if (ctx->typec.typec_switch) {
 		typec_switch_unregister(ctx->typec.typec_switch);
 		ctx->typec.typec_switch = NULL;
+		of_node_put(ctx->switch_node);
 	}
 }
 
@@ -1114,28 +1118,29 @@ static int anx7411_typec_switch_probe(struct anx7411_data *ctx,
 				      struct device *dev)
 {
 	int ret;
-	struct device_node *node;
 
-	node = of_get_child_by_name(dev->of_node, "orientation_switch");
-	if (!node)
+	ctx->switch_node = of_get_child_by_name(dev->of_node, "orientation_switch");
+	if (!ctx->switch_node)
 		return 0;
 
-	ret = anx7411_register_switch(ctx, dev, &node->fwnode);
+	ret = anx7411_register_switch(ctx, dev, &ctx->switch_node->fwnode);
 	if (ret) {
 		dev_err(dev, "failed register switch");
+		of_node_put(ctx->switch_node);
 		return ret;
 	}
 
-	node = of_get_child_by_name(dev->of_node, "mode_switch");
-	if (!node) {
+	ctx->mux_node = of_get_child_by_name(dev->of_node, "mode_switch");
+	if (!ctx->mux_node) {
 		dev_err(dev, "no typec mux exist");
 		ret = -ENODEV;
 		goto unregister_switch;
 	}
 
-	ret = anx7411_register_mux(ctx, dev, &node->fwnode);
+	ret = anx7411_register_mux(ctx, dev, &ctx->mux_node->fwnode);
 	if (ret) {
 		dev_err(dev, "failed register mode switch");
+		of_node_put(ctx->mux_node);
 		ret = -ENODEV;
 		goto unregister_switch;
 	}
-- 
2.34.1


