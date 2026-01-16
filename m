Return-Path: <stable+bounces-209994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD64D2D22E
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 08:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD00A3032977
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 07:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3736C329E52;
	Fri, 16 Jan 2026 07:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enNfl9cv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C8E314A74
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 07:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768548241; cv=none; b=KQIJAIAqk9NeWFspvBI+Olo+WFAKg66sWCRuQqc4Cvex369hkhIyJ3UM+o7yrfKL5X0JFvuvfmcfmoDdNPJOHdwcMLdnuIkcsFCv+Ayr+n0a1McnpClWW9rocpVLh3d40DOahfVkpJxRtRYn8zbi0I26Q/xIoIcjLwFG65Hw0A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768548241; c=relaxed/simple;
	bh=kfc2gu+JDiA504aEuqqB2yOn1wTCL0D1jfoSwyCjLNg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KakdVulxlBXNYbejx1n3ZO1bHYBL1rNi5DtfbsLlLPwU9L/PKqOEMOpB1revxlMxgN0Eer6Qr/wPylvRULcBl+F7wljjAwRS1410oFXaugAP6TTGSC//jVsbj/s0x6WF6bQtu2hbXxJqTF7ZIoZgTlh5imBbEYuoQ3bNxkkb0rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enNfl9cv; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-81f4dfa82edso843406b3a.0
        for <stable@vger.kernel.org>; Thu, 15 Jan 2026 23:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768548239; x=1769153039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8z9dR9n/XbIPD+NwoXj4aiKTiL+BG3no3tdpgFPxOgg=;
        b=enNfl9cvw93AthJwICBVRdChm/y7WcERX+isdVO5YL7dSR/W3fQrVChQ65bTs4guTK
         LtGTWHMRTvG+RclLjB7J2XXcNwIIv1Y/sT2Xyq9p0MyE853uaqiOjPT2r2QikvAqRSJJ
         Z2Ylg8eKn/h3o9/FHfrKjPeQKL+sF9ZoxJ0NxbS9bQq+0toN+DO2Hk/KbEZ8Yr0C3uMU
         /N/jXQQJEb2zEGjaK8U/+dzdoorPLJ3pMXekJMDKVDEuELFpOYtZZ6Ro1iGiNMbH1x0a
         RbRJLDQrFqjUVlrUk8CfFLoNi0xj8+ttB6pxAEu4GL/nAwvn7HEdJexIZEo7643VQOBX
         yUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768548239; x=1769153039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8z9dR9n/XbIPD+NwoXj4aiKTiL+BG3no3tdpgFPxOgg=;
        b=ND0fki89ps+LyjMIMYnmyZOdxN5pOczPZRiZE2uc0q7XSVINEI3aaMiKU40qD6D0DQ
         jevaly/vrPOw1cP6Ds83VD1RD+P5b42015WzMcKv+d5dOPkW4mimqq6YUdy6dROaaTv3
         Db0GZVo1L7pex50GIQ+hWuVuRg37S1CWmoMd+ElIVZKaNTYDpcU27hDuXDB3tIHIBIcO
         kweWZRkqvarvkhXjNN01uDSfbUxyb8b0O2QZoG81Uqc8+V2PVjS1s08ObD6+LRW/1RR/
         I2gwAmQFBHBOFj0e6D1YLuD/3MFLrTAx7TuJs+PLCQMJ6GuErLF9u5iOHjpTI0Mq2qdR
         zl8g==
X-Gm-Message-State: AOJu0Yz3EvhY9C3FvjUlBYwWxYA23nygzqNMrtktevXRGllT62MASP89
	CBbRuWXP1V3dJCQDJ0djHVUbpj9at/i2PA53hmjfTsF0c9JrGIpwqlFA3oxMNQ==
X-Gm-Gg: AY/fxX6Z2b6IAyPP60gvGXoc6hkkXJLTZicsGaK21tehEDFTGZ2LlvFUe/PIrbkWf3A
	pBvflfeatqx+zRLBNCgjX6KyKYCSVlszFFl9y8Au8D8qomUCA+uyYeHSIEhLqIFTpc9kfJslrJu
	tE8EqxHnbJ9dhvCZcPPmNIV75UPJYk9+BVaL4EQQUD2j+Rix0TsPGuYIrvb9iAXR+/SBNmzzwu5
	0t8wCBWrJfDsvSCIUP0zHLBo9BNkr0jY0beGbmwZ4gQcsglACoFgF8Gpy0GGm+qIqr3dvj6yIsM
	0D0Lxzb+j5ttlL6uekSJsCo+DX7mh4dqfaXJbi4nlG+DgS445HnkNlVzZiB5v3rWduVX9wMa06W
	Jx8kodlswEELiztJVoA5stDAPUDdTlhbeyCvo4dQS/Sj/XBg3XM7RLlON3gwf261foK6rCczhzs
	fFDyJOkFvSMG3FDS01y8903Cw9E+OyubVw4+aJA5Dj/U4C/CmqYJi+EV+i/sZEJ5dRHvquwi2/A
	Nf+FTA4LI/xaolL9UdR7lTT2sRb5zQY68Uyyl+qgUtSYa4=
X-Received: by 2002:a05:6a20:2450:b0:38b:d93f:b467 with SMTP id adf61e73a8af0-38e00bbf859mr1973334637.6.1768548239220;
        Thu, 15 Jan 2026 23:23:59 -0800 (PST)
Received: from c8971f1abf06.ap-southeast-2.compute.internal (ec2-54-252-206-51.ap-southeast-2.compute.amazonaws.com. [54.252.206.51])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf249bdcsm1210146a12.8.2026.01.15.23.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 23:23:58 -0800 (PST)
From: Weigang He <geoffreyhe2@gmail.com>
To: geoffreyhe2@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH] thermal/of: fix device node refcount leak in thermal_of_cm_lookup()
Date: Fri, 16 Jan 2026 07:23:54 +0000
Message-Id: <20260116072354.80744-1-geoffreyhe2@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_parse_phandle() returns a device_node pointer with refcount
incremented. The caller must use of_node_put() when done.

thermal_of_cm_lookup() acquires a reference to tr_np via
of_parse_phandle() but fails to release it on multiple paths:
  - When tr_np != trip->priv (continue path)
  - When thermal_of_get_cooling_spec() returns true (early return)
  - At the end of each loop iteration

Add the missing of_node_put() calls on all paths to prevent the
reference count leak.

Fixes: 423de5b5bc5b ("thermal/of: Fix cdev lookup in thermal_of_should_bind()")
Cc: stable@vger.kernel.org
Signed-off-by: Weigang He <geoffreyhe2@gmail.com>
---
 drivers/thermal/thermal_of.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 1a51a4d240ff6..ef3e5d4e3b6e8 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -284,8 +284,10 @@ static bool thermal_of_cm_lookup(struct device_node *cm_np,
 		int count, i;
 
 		tr_np = of_parse_phandle(child, "trip", 0);
-		if (tr_np != trip->priv)
+		if (tr_np != trip->priv) {
+			of_node_put(tr_np);
 			continue;
+		}
 
 		/* The trip has been found, look up the cdev. */
 		count = of_count_phandle_with_args(child, "cooling-device",
@@ -294,9 +296,12 @@ static bool thermal_of_cm_lookup(struct device_node *cm_np,
 			pr_err("Add a cooling_device property with at least one device\n");
 
 		for (i = 0; i < count; i++) {
-			if (thermal_of_get_cooling_spec(child, i, cdev, c))
+			if (thermal_of_get_cooling_spec(child, i, cdev, c)) {
+				of_node_put(tr_np);
 				return true;
+			}
 		}
+		of_node_put(tr_np);
 	}
 
 	return false;
-- 
2.34.1


