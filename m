Return-Path: <stable+bounces-209995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C457CD2D3B5
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 08:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFCDF3088863
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 07:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4702D94B4;
	Fri, 16 Jan 2026 07:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7sj79pE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EFB2DB7B5
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 07:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768548611; cv=none; b=GSP/i/IJvHyRoUoxuWPyJy8rZehIwiEqgsKh3OH+fskMvZv42dX3VJ8xuHkmKAwr5jQr7pgpHAM++l/4ZIs58EqV2qHsANag2SQKR8o1x+UWm13SYwd7lGHWEINgQK97HSRMtXKhQ1VqhGnMVGdUeo6d6GfNhAdk/75eNxW3MD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768548611; c=relaxed/simple;
	bh=kfc2gu+JDiA504aEuqqB2yOn1wTCL0D1jfoSwyCjLNg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d8pLIH22Rea4v6erV9tYcGg/I7qPQR9EcTzrs11xhikWudfliOAr3uqClYUpSNDpnGajjQlA7nBc3IaV5MV7EzzFs6hhx7Z2QyH6jAp9ZiOodWHe6zreaVumwpTeTpcLQJlu/bspYjIF/K5or0fAINIZgvLbLSF4Gqgruzo0i+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7sj79pE; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-81f42a49437so913818b3a.0
        for <stable@vger.kernel.org>; Thu, 15 Jan 2026 23:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768548609; x=1769153409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8z9dR9n/XbIPD+NwoXj4aiKTiL+BG3no3tdpgFPxOgg=;
        b=I7sj79pEEVb6YqTkpYa8ZQ7DkuAuYNUQ0F9DO11/w656RPFABpxnFUnD1EklZnk11H
         B+3vj5avKulXmgiLrNr2KqWsGoCNxQ1VXGwwX1mA6VlYBr7cpJkGN+LdswGzfQ0946Z5
         sF4BX6MfgIj0xF8FauYwX/2mGEhDuahzNt7zJ5Drd5R/FCzI7EPwvfd01uxocUyyeyJn
         upSqZ9YxibY+qlXTUcuziyjxdl0dCObch8AkJVyXxzqUwKX2arLfjtUE45eUJH/dVLgG
         DS5VICsYbCgI1irqvMD4f3OMo43008Dc/R/EDBDqHUF3vY0LTioTL/MKlemOU48HXtN3
         GJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768548609; x=1769153409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8z9dR9n/XbIPD+NwoXj4aiKTiL+BG3no3tdpgFPxOgg=;
        b=PJiTPLHXb6Hj1Qka1crunnQ9ZbrzhFLAdwgvah4+MS7LNLWmE3128LyWnF9Y3/bL29
         qQWMlf1FKEW4PhyENEwPjOm2U74EGsBhoAYf9Npry9FMgDBQqhL8PQZ9AOFOD7dXbRGV
         sXmlICMrNR87kC+ALakD1oGetpGZmfPmONVUIoacpsKunsmce/lOY+OUN6EM2PomFh85
         LV5H7UGNBdQzrIiRCFHT0M0uGVNSd5y5WZaANTzS9HIRI0EbkYo1RPVJ0bXPJanAYArC
         F9TMiqRjW3+OIvUcDKnGMGvYsFzIrpqYuT1EKjmT4Op27BfVIYsVKZEZrCxg/9eGwN67
         nwrg==
X-Forwarded-Encrypted: i=1; AJvYcCVo/Nw6aEurYkU6zE+X9UFvFVGaCyn0YfhB0Rc7h4BJRwmIk+n/Lwd11V9o5ERizh6O1PflHLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbORjja/3hTb6ZOagrr4eDEAJFj/gRNybp2BpoW/adtHnWNKwh
	DkjTPR2XvZh92+P5e1Nrwuj77a18VHpCEB5/oY9TYuCVO8pkMQlPIoAZ
X-Gm-Gg: AY/fxX7lr+8NNoseOlkiUpzCxSBuVf91R1y78Ax7vbGfO2TC/NPh+1xK2Ji7l68CqJ2
	p5F4IjIIwnsp0AMQhS8aY18QrQIUnezcmKqJd/apG8ZsCUIOyoBtFjS5PCOIaO9qT/BLoaqnXA0
	Fq12ni4iMNgOwnabxRYyF5M6O4AZk+X0Dgx39gG43ZeBkAJFt9TeOGG0HbE54bcXfmGCVT9XkS5
	2JT7dHJ4mjbJ87UQR83dXVmtu6lrby7gr4txnVLXVCoC6Llj1XwEC9i+fplVP1QowIHVijdsYne
	7dKbRIs56Qiq0NXEogYizW6gnUIpYPfXMtVgmfbzgls8eSjRV43Bg3OpAgkYZ9k9xif7Eyty3/Q
	3OVO61e3PoSwEY680yOmYyxRHGboJFq5Wm4Fk9GJCvgQPymDw8uPVsxbRToFjFrKdg98N/JTJds
	NO+Jia+T33k7uP0V26ueXzywwqD+aW37/mFtIA9vlCYEGEQJYpCybKfNdrkWCuUq7OhtNaanvuF
	hCOEcADk0Gut5cEBUPxigpwzsqbdwAC/hW4GA2XXiaYq2E=
X-Received: by 2002:a05:6a00:4008:b0:81e:6d2d:a121 with SMTP id d2e1a72fcca58-81fa03395bbmr2087675b3a.62.1768548608940;
        Thu, 15 Jan 2026 23:30:08 -0800 (PST)
Received: from c8971f1abf06.ap-southeast-2.compute.internal (ec2-54-252-206-51.ap-southeast-2.compute.amazonaws.com. [54.252.206.51])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa1291a48sm1261509b3a.50.2026.01.15.23.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 23:30:08 -0800 (PST)
From: Weigang He <geoffreyhe2@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Weigang He <geoffreyhe2@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] thermal/of: fix device node refcount leak in thermal_of_cm_lookup()
Date: Fri, 16 Jan 2026 07:30:02 +0000
Message-Id: <20260116073002.86597-1-geoffreyhe2@gmail.com>
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


