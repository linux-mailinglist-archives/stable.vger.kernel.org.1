Return-Path: <stable+bounces-121176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F90FA54318
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 07:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E74F16E70A
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 06:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2891A23BC;
	Thu,  6 Mar 2025 06:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOIjqL5f"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B2836D;
	Thu,  6 Mar 2025 06:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741243871; cv=none; b=GR2OH6ygZ5TbdgtaVAjRF3tSQwo+Lu6Ecyrva4U22+/AFfPpB4TP9tI2qRzJFaX4D6HLPr5RlHNzE+klllHxlvtRAHGa6WqWjKA/9xZEvAU4TAeu4e0oSaNu8ANACwkhi83QXfhOwFjy41cybPJuEFO2Ec6r22OX6yTaqd5Ypww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741243871; c=relaxed/simple;
	bh=ShRFRyPYqHcfD4H9np8lTzLfTLdnwjUN3/QchIGoZeg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cu341dFznQGDAzxBRUta0TUxckXtTdLTe/RkUYCZI4psxxjjWK/lQbwIW0tAfO2omdezboMvMRmAf5SdK6HhItsRlW1AXwYHQ76X8TzFbBjFZZhzcRNPJqSfYivPvhJzP1ZEc3TGssQb3p9DpHO4VB6YxNz7jdhJ9pP9KbbH+WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOIjqL5f; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-223378e2b0dso3707505ad.0;
        Wed, 05 Mar 2025 22:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741243869; x=1741848669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m1RJgBe7c5zywyoYEU3+GB2DIHhDBzVThMU9Jk0Pclo=;
        b=SOIjqL5f6SJ65QFLEbUTDGcPZpYGe3K3N4DayjWKCIU5ui+vjN8sLFMnqwR/bYGRky
         FDSyVC5E9DSdJ3ag9E5GEn1DWV//5IO0f4MKuRzygevlFRucL78Xse3RGDqM7WjCzi/o
         jpVRspM/8mdKDbgtriyJeA/AHoSKasYHTJubBahnaEGnk6aikFAqdH0r+fYU1PetXaVQ
         XFeO9ErR+d3at3XSicKiAvibTXKiZeGccEn+5fd3nAIY3VSlJslFchn82jLKZgVS4HUn
         /N46/Lon/qcMGRGKnhhtV9czOF+Wna3ei+0m/cAzScpDDgXj9+iFMR/Lyq1tK0Xt9gS3
         W5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741243869; x=1741848669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m1RJgBe7c5zywyoYEU3+GB2DIHhDBzVThMU9Jk0Pclo=;
        b=sfoA9pe8ZSQmcv9HrcHr5BfUOUyuP0Jmn2zlXM8gkDo1v6CjXEhCky8nfas16x5Exi
         m7Nb22hn9Qi73mzsooLSf+mAJA07R3nKh2PpXTeYkaUP166soUCebOfIpt57pXcSsdbR
         1ZLM8Al2dxzRst1TDrlc+ipEWcVGMp/lq8x7TDURMVr222t2UtlmG2GggKcJlEwDPgMP
         sZmcM+Jns3Q9jUcyVBcyeualWJhZ4960FC0yKTVm8z7ifM/HYp/WQ/2NfWtVRfPBsCVl
         lcFkkkkiC/SNaoAp3IxMq3zxKCJ9vzl092YOqvGPijmhOt/8Ib8MFexAdiVNutF8MXI4
         e3iA==
X-Forwarded-Encrypted: i=1; AJvYcCUlBN6Gi6WOQ4fCyEvHC4F2IVqCSxhUg6GE/IEkjl9bi48p3ldSiJejAkGgYKn4R6aazvuxvAHI@vger.kernel.org, AJvYcCVARWE+9iZtpoohUpYK5tsSqmjvRcFgCO1NL8bL8w9MQXKHAV2MMUDO522N3JNrvZmNSPC9O98P9BvUIDY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc0cP9Wabnpf/EhwDA+kC58ix5S0RLVTF1wjInd99EFJkDhgpB
	JgYLthdaoYE/gvqdwQkgZj+joTd6/PEhJwvI2QhINQk/41/v8L8N
X-Gm-Gg: ASbGncsPUHDggZnnCWh4csbhq00ftRs59gYpxuKLbe5Hpc8+6yKIwYetUm/VahWi8YB
	Kal+KTXjQ+EzncsMDE5JsYwccAUG5IHiEXudSRHLe9AZc88KfVvC6iMjAHtXt/silXTgI9p4os1
	gFKoH4kUwZqmAdPiT+kNOEXgNSUqaZq/mYzqOweV6N3Oaj2V1lSq4YCqcM28wEGCttUxYIzf6rh
	XbCFZ1JmHpykdkhAqeUbI7OhltlPWK4jQtk5S5AzvCj41Vm15uXKcv4Kv6+Q1SnAuTUW/e7r93D
	ZUvjwVHGRbMZFUw7Uj6UneF8z4WT2Uihx9TpnB17q7nNJF7Di4oSGJIdIASEcKM+lEgJ
X-Google-Smtp-Source: AGHT+IEq5Vnsk/Pr9k1/+2sPPH7usYMjsP8EK507H/hUo5RzbcIU/UMbl/obFxLkrz73GevK+fvlvg==
X-Received: by 2002:a17:903:19eb:b0:215:b1a3:4701 with SMTP id d9443c01a7336-223f1cd9503mr99343575ad.13.1741243869255;
        Wed, 05 Mar 2025 22:51:09 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:423c:abab:b1b0:64e8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e823b98sm2402982a91.46.2025.03.05.22.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 22:51:08 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-kernel@vger.kernel.org,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Dirk Behme <dirk.behme@de.bosch.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] Revert "drivers: core: synchronize really_probe() and dev_uevent()"
Date: Wed,  5 Mar 2025 22:50:51 -0800
Message-ID: <20250306065055.1220699-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit c0a40097f0bc81deafc15f9195d1fb54595cd6d0.

Probing a device can take arbitrary long time. In the field we observed
that, for example, probing a bad micro-SD cards in an external USB card
reader (or maybe cards were good but cables were flaky) sometimes takes
longer than 2 minutes due to multiple retries at various levels of the
stack. We can not block uevent_show() method for that long because udev
is reading that attribute very often and that blocks udev and interferes
with booting of the system.

The change that introduced locking was concerned with dev_uevent()
racing with unbinding the driver. However we can handle it without
locking (which will be done in subsequent patch).

There was also claim that synchronization with probe() is needed to
properly load USB drivers, however this is a red herring: the change
adding the lock was introduced in May of last year and USB loading and
probing worked properly for many years before that.

Revert the harmful locking.

Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

v2: added Cc: stable, no code changes.

 drivers/base/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 5a1f05198114..9f4d4868e3b4 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2725,11 +2725,8 @@ static ssize_t uevent_show(struct device *dev, struct device_attribute *attr,
 	if (!env)
 		return -ENOMEM;
 
-	/* Synchronize with really_probe() */
-	device_lock(dev);
 	/* let the kset specific function add its keys */
 	retval = kset->uevent_ops->uevent(&dev->kobj, env);
-	device_unlock(dev);
 	if (retval)
 		goto out;
 
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


