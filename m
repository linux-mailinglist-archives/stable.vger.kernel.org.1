Return-Path: <stable+bounces-25381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA3286B28A
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 16:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1775B1C258AE
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 15:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE2B15B10B;
	Wed, 28 Feb 2024 15:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQ2T9Nn2"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294DB15B105
	for <stable@vger.kernel.org>; Wed, 28 Feb 2024 15:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709132404; cv=none; b=fEIiiLi7pGyodW2N2Cc4STUR0roAeAjG/WIg8Zx7ja7XiAo7SYFw8OISC2m2UpMbHrvpEBy9uwOQzGb+j886RFqA4gBxVdtdo5O+tqe4ZR5Hj4rbRrM+YK4QrwOGekFcwTN48LbqTyibkNV9tifviB91YXRG4Qrg7C7wG+NDwW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709132404; c=relaxed/simple;
	bh=xo7+i3tQwamD6ZgV3iu1PBh2FtyscE3JQaKNL87ZXKA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ACJft6t9oOoMuAg5pT/bzcgjqtNBLFYPA+X4pSSTKEl89F2o00dGUrRtsthKBB2hIhILWURSzMx68swIU+GrrAfEqL8u3Q9mJG6BCVrOp7oN5zOdwoCJIqQ32IS8SoZKTKIoeVgffOfLSqJEh/C+FOW3b7JxVitT/RGE+DotJa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQ2T9Nn2; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55a035669d5so9905206a12.2
        for <stable@vger.kernel.org>; Wed, 28 Feb 2024 07:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709132401; x=1709737201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RXm3blkfK5l9J9HjHCUIRWJ9avBSfSyn6f+olGRLMhE=;
        b=aQ2T9Nn25WxYSH30guXAMvUj3Nm1rEfg9gyNa28D9YB/J681FvRdkyji6A3C6LdDYK
         /Sz6BA26SAGbJeEuz6D5ouXdAjqvSgXItk+ZnVIAJF7bYstWjxdC2BUDjTd2KCUQ8c3x
         Tql37ncuk7fD9FiJ/oiU1h9J2yxNdzGocTXQ4ExBUqirgjdJciOgRANsI7zEyYiRZUiG
         7MhJXsdmvWaoeyypi9abUXumlUzf6wqeS9eqT0XoE3mBy3hECG/1RN5V77H81nU4ftSq
         7qFhHSTXQ5kQ0gQCTmZ8nWWKkEyTsOSMiDtxB6Kw41noC7ACAMhKv4tqsQd9coRsMboq
         0DTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709132401; x=1709737201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RXm3blkfK5l9J9HjHCUIRWJ9avBSfSyn6f+olGRLMhE=;
        b=YVTjoYJwiTKYRprYVE+KzsZf76hWgj0KFaLDZRDW/xMogSsS50i6k/rI6i1ErownQb
         p3iWfkPJrb29Xzl+5g67nkHgdpp0iEW7Sa/5TJCKsxdD/RZocfsfK34VsIeBBZaUgPML
         L9leUBxFFNhiQPX8iYJ+6su4mD5d+KXlCQU7TLilpD6kb4zUIjcXdFzMm+lByZZR2Ksa
         oCBgR/XKCcvG57AFuhXOK3Qh6yvAkLnKlf10pvSylCceF0A1mWSg2uYv+Tq6kH0zlhxK
         eJ15Y6pJSj9ZO1fRLxm+y9LKINR9t2o5yMto+Rk5O/KcW9cWifdA8wGyFdmjlLO9c/e9
         F4DA==
X-Gm-Message-State: AOJu0YyS328hwv98UYEviY0wgG9F5YeJt/F/I9KK/U1yPxtUFaviPUam
	3WPa75QQdJSXx72iejn/7GoMEgFaz3G+Vfkuc/POPlXXIIijLdJbpmDEK713
X-Google-Smtp-Source: AGHT+IEicPyuJlt9eZw4U8ZUBN2D8SA16t86/4h1p2C+cJXp0+fbuaR5WWsi2QQbtiTqtcEcCrxKhg==
X-Received: by 2002:a05:6402:35c2:b0:566:4ba7:157e with SMTP id z2-20020a05640235c200b005664ba7157emr3624529edc.14.1709132401080;
        Wed, 28 Feb 2024 07:00:01 -0800 (PST)
Received: from toolbox.int.toradex.com (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id bn21-20020a056000061500b0033e033898c5sm1537610wrb.20.2024.02.28.07.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 07:00:00 -0800 (PST)
From: max.oss.09@gmail.com
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev,
	gregkh@linuxfoundation.org,
	sam@ravnborg.org,
	maxime@cerno.tech,
	sashal@kernel.org,
	Max Krummenacher <max.krummenacher@toradex.com>
Subject: [REGRESSION][PATCH 5.15 v1] Revert "drm/bridge: lt8912b: Register and attach our DSI device at probe"
Date: Wed, 28 Feb 2024 15:59:45 +0100
Message-ID: <20240228145945.2499754-1-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Max Krummenacher <max.krummenacher@toradex.com>

This reverts commit ef4a40953c8076626875ff91c41e210fcee7a6fd.

The commit was applied to make further commits apply cleanly, but the
commit depends on other commits in the same patchset. I.e. the
controlling DSI host would need a change too. Thus one would need to
backport the full patchset changing the DSI hosts and all downstream
DSI device drivers.

Revert the commit and fix up the conflicts with the backported fixes
to the lt8912b driver.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

Conflicts:
	drivers/gpu/drm/bridge/lontium-lt8912b.c
---
 drivers/gpu/drm/bridge/lontium-lt8912b.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/bridge/lontium-lt8912b.c
index 6891863ed5104..e16b0fc0cda0f 100644
--- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
+++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
@@ -571,6 +571,10 @@ static int lt8912_bridge_attach(struct drm_bridge *bridge,
 	if (ret)
 		goto error;
 
+	ret = lt8912_attach_dsi(lt);
+	if (ret)
+		goto error;
+
 	return 0;
 
 error:
@@ -726,15 +730,8 @@ static int lt8912_probe(struct i2c_client *client,
 
 	drm_bridge_add(&lt->bridge);
 
-	ret = lt8912_attach_dsi(lt);
-	if (ret)
-		goto err_attach;
-
 	return 0;
 
-err_attach:
-	drm_bridge_remove(&lt->bridge);
-	lt8912_free_i2c(lt);
 err_i2c:
 	lt8912_put_dt(lt);
 err_dt_parse:
-- 
2.42.0


