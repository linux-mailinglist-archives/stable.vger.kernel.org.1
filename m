Return-Path: <stable+bounces-200508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A09CCB1CA2
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 04:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 557D13018D5B
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 03:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0393B2F9C37;
	Wed, 10 Dec 2025 03:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9sXRcJl"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701CC2F8BE6
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 03:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765336841; cv=none; b=RbWM0+56o9SCTsi2uMCVD2reJZM1q4+2z8m23DZLHGcQ4ZTB1wcnYHvE8+GZ8bBXAPp6vZ6CdLMMmHCs49tVYVR7EOv7PD9l8cIC3xQEDx+XCAF2Khb4qioRoK0eO73GME0FyTILzB61R0tvG3PjAooSMZ+dWjcuOL3h8SnEVlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765336841; c=relaxed/simple;
	bh=ZhvJoJg28WY8WddGDgYpoOtsuRlwXLVvWpwlSL6k1pQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qGwtWk3EAkEVKPZlisw6Dqw5pwb47qjVXMbc1Dwn2zJicKQjvzlZBr8ORMw3wxUC/gcah+HjHgMBIyIcTtStMWgSRaWG04pmpzKeTMe9ENJE9YJqaMEvW0Gvb0a0tz9SV40WOKcBm6C4Tu3smmUsqNrahAyVEANNndgh61q5WNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9sXRcJl; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-29ba9249e9dso88996635ad.3
        for <stable@vger.kernel.org>; Tue, 09 Dec 2025 19:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765336834; x=1765941634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vbN+EuPmocUOeBG82RSMhzZ2IRHbxuavHhm0ZQadrtM=;
        b=T9sXRcJl/S7GrTHmiXfaRS4/OWJNrXwvkQZZJWEWwrsW1Zyw7NClhym0Y8hvu7bZej
         yYO0EmKteKyFC7vLGeZegPNoz0z3mlboYeienDj2OXE32dFGJB8q3ro25H1bs5MH7owA
         Jtxh1AIQtfHA59QcOb4FarILHMOw/OOURZLQIoBACZMkB3xmWfKkqSPT/uuIqtSZXU3o
         iqVGhCoTl2LaM7TvAJzn6a+9o2Kmxp6+120LUhdILrJqyg9lXUIYKN0b5hcvcptefy5K
         375Vw9GERejiuqtK/Zj2zbHmaLx/AJB3eXIyL/tyDq5f1PyYtiHpNlPRATv/zidaEKCd
         HTMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765336834; x=1765941634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbN+EuPmocUOeBG82RSMhzZ2IRHbxuavHhm0ZQadrtM=;
        b=ESoqyASzm5bGM5EXknNvugJZrWtj0Oxv3eh7Qi04b3pWzxDc1SJoWVuTRTxa25PWpi
         PSzvMebn2u0AXc3AdE+PhIDzEXeLv2snXWnrkbQtbRRNxwE4t02EbffiBZsjWJhLIBUd
         3r3woLrnOACUXDxoQRTpHV7gVel/1eEQ5ywAW6O6N1+24MCPsA56ZJ5Nl53AlW7AdSUn
         2NW2wbgEFczpedvYuREQr7jumSGfDrWbWNJjYmtf62amZl2BMKFRzxP5kx9vg4SE8MXD
         ktdaZBuYwbU89v3TqnW2Ddz/2a2PhVTWJDR+VJv45kR77kZ8xfOacNtmYTllF/w8Xygj
         VVSg==
X-Forwarded-Encrypted: i=1; AJvYcCW5bG6RH+W+gyjet5nyVsOeBxxyvryd6LiZmSlYiwj735jhcfyeOyJHyaYFyjcr1MWLH2RrzuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEmJltJ9AZsLN+58VzSCyUe1HNhsX6WLIR4oP6OrWM0xcgQVUl
	kpk9echZxPEq54V23zjraR4b6fdumAeBPhC5C21lIPrlG94ZP0vObS6c
X-Gm-Gg: AY/fxX7NHxy6NCpjjO5pCwzPEUmpk4jMSlbBwUyYP5jeDv+fbeVlCeWjGkCaVzFzr55
	o5esNbZTY0LRkF7ip7ytJ+IaTlzMty16fObxWKwdaskeIrpzaxtzqreaebZGCygguf5sPQuLC2D
	EG5meY0nRC9ApGFunTtaXl1mGesVDnaUr0gwTfibhqsuNdSRGlXz7O771jwiuZnpCpLlH97h+p4
	TTHPTfOmi4r5sR/kF2ZVJGNhFgtGsiRVGUq1LVLxxWMfRQrnxz7RPYaA0HAH7TwP7Sfid3E1ZdM
	ogbTMRQuLrkNZ6K42uWJYMZF+RQQ5RGUf3AGY+zqLidEzkT94O2F20gJcYE+kEgwPBTHgfdNHU1
	bDkifIQtY+Ddlmh1S/KGa8Hway80Xi8jeGm6M059kyd0z1HGbPGZ9e+pBONfjJ3IPAv+DLahtgw
	4DFVtltMYEiF7eBQxzcZRKsh0TQquXOw==
X-Google-Smtp-Source: AGHT+IEMtGD+A/RMPic2C2F5xkyR72IvoSEeanxQ+MeKzBVevm0+/eQmMUxld8jyk73UQBIfukkjdg==
X-Received: by 2002:a17:902:fc86:b0:297:f09a:51cd with SMTP id d9443c01a7336-29ec22cac38mr11779605ad.14.1765336834147;
        Tue, 09 Dec 2025 19:20:34 -0800 (PST)
Received: from localhost.localdomain ([121.190.139.95])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29daeae6ad1sm169717995ad.90.2025.12.09.19.20.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 09 Dec 2025 19:20:33 -0800 (PST)
From: Minseong Kim <ii4gsp@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Minseong Kim <ii4gsp@gmail.com>
Subject: [PATCH] input: synaptics_i2c - cancel delayed work before freeing device
Date: Wed, 10 Dec 2025 12:20:27 +0900
Message-Id: <20251210032027.11700-1-ii4gsp@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

synaptics_i2c_irq() schedules touch->dwork via mod_delayed_work().
The delayed work performs I2C transactions and may still be running
(or get queued) when the device is removed.

synaptics_i2c_remove() currently frees 'touch' without canceling
touch->dwork. If removal happens while the work is pending/running,
the work handler may dereference freed memory, leading to a potential
use-after-free.

Cancel the delayed work synchronously before unregistering/freeing
the device.

Fixes: eef3e4cab72e Input: add driver for Synaptics I2C touchpad
Reported-by: Minseong Kim <ii4gsp@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Minseong Kim <ii4gsp@gmail.com>
---
 drivers/input/mouse/synaptics_i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
index a0d707e47d93..fe30bf9aea3a 100644
--- a/drivers/input/mouse/synaptics_i2c.c
+++ b/drivers/input/mouse/synaptics_i2c.c
@@ -593,6 +593,8 @@ static void synaptics_i2c_remove(struct i2c_client *client)
 	if (!polling_req)
 		free_irq(client->irq, touch);
 
+	cancel_delayed_work_sync(&touch->dwork);
+
 	input_unregister_device(touch->input);
 	kfree(touch);
 }
-- 
2.39.5


