Return-Path: <stable+bounces-123143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4B5A5B859
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 06:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67EB916C61A
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 05:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281041EB9E5;
	Tue, 11 Mar 2025 05:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jgk/zcGc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5B01DEFF3;
	Tue, 11 Mar 2025 05:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741670670; cv=none; b=ki4+f1ZKetmNQSrkPC+HhiU/e95+ya+BD+GuAHE0GVwdlbyW8DCb60G4BIHdnW4ZbUMd0z+iE/PujAQr9S/OeGXvlpMGnXBFWv5W1+Wo4ZPf7Zlhlnm3CrdzwrK2znNAXP0At3EkbUqaO+LlRLW1Klaqsaw53MHo0r39jPLFvgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741670670; c=relaxed/simple;
	bh=NocB5wuDBrbQL54yJUFHfBU5Ez+dNvLHO9HRnBbTKoI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k+LPY6efgajDrlSU5VCE+Qg8AiZLBtkUjtRUzbL3HErzGLXGKHrWslFQwLp8yNilMQQWU7tEsQITD7LnRrXvpr3QS00TNnq6BoBi8D/yZxdlEJaDPib6dQIn+Qc+4lT+GcOxbGp6Wnf7yCnBkojSL88T10EEXFZvZbr46k4KAzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jgk/zcGc; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ff797f8f1bso6714500a91.3;
        Mon, 10 Mar 2025 22:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741670669; x=1742275469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cMarbxznOZSe6oqbRQcowEnKXzuGUexSuWNf9vfnQvo=;
        b=Jgk/zcGcvNkeA9c+CqGwUPc5F4MYaeiPagOeRacbmdv8sMePfZwGMeBZLUgrjHb8Sa
         tCdsmgFNOYTkbmD+YFWrBtfHhff8DgjlE987bf0LlLK+NgYlbFf92jTq/N/Nx8BqP3oq
         mFSxXY86vN+gTX7LL/1o8x0YoRWDOLtx4UvGSUXqoUybVSqXd/ZOeTB6WrmB5mNR11jS
         O31RE/R93pXvDVeKNn9NS9RHfuSxWT1Tq6HIywPVx5AmfRRjiDZsAPUxJcEe8iDHSe56
         gS/+uKHz9yNbITXghOfkS+OnIbAQ+Yy1vO50Xe9NKrBUUg/XuqMpr/HWuU/VAOkpCFZE
         bhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741670669; x=1742275469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cMarbxznOZSe6oqbRQcowEnKXzuGUexSuWNf9vfnQvo=;
        b=uFbs58O7JxDoGzc0mIR4uU2TKs7CWHwrW/rng8DlJveLydzdISmFeP1NGAfWwUSOkm
         8NadBLJKwkfa4RufMsZYT4z1LGjwsycUlb4ULoBZypzAdxjr06fIQAIjCsjFIKgE51yv
         NopsptUyc2UJsW0cygWShYHV+d1sN/5Waf0lFIXztTRdDBbSG+46YGvAeJBol/OaMDzV
         2emc8Oatq9fTqldHndzEn49BZtn1Jm0Du6JAD3wD6STd9qjRhaLY4Byxte2acXj3bduz
         gWT02KK8lNWpoat7pRLgT9NUgGM3Vlmmn++BcMD2ZHrCa3pbLnQU3KQ5/W4gQbV0I6Lr
         BvZw==
X-Forwarded-Encrypted: i=1; AJvYcCV5jtcId2CArYjMq0jExGF+Z17SNWrrXDo3qBbxiaAcSxkLjbHlHSX571So26UDAN+Z6bTS/4hT@vger.kernel.org, AJvYcCW6csOh/8TPPAMbk1rGcrNbv4u8FN65Mjr+kbPLG/qtyJNrSNOVLoMqxZJiWXzc0gwz4GFYBARR3S1044E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmdcQg193G9QCuAOCLxzFp1bHde1T0Woog+9rZz1E5zdPQLfT7
	wg5Z280LD4O8LINgPp1iDJCZBldmZUTw2vFjsMnnbmp/y9OTAoIRWb3qIQ==
X-Gm-Gg: ASbGnctX9vVgbuSIf4zLHQzFeCpfc+aViAkdQ7RdgUgHKWD1O7LjTH0AgDYFcYkKssF
	URtb0GZrEJCF0Mj9yD2mlSreuntje6l/Tj7ROQHmE6SFHtTAcndDs2ea+6DFwSOFsRMP10KTn5w
	joATpRfeWxgaN2X5hPyQLmea/wXRBPqZCNk5yNMeZRGKEnD4NN/6A3XzpERuT8oiv5MWBzu7IbV
	iD+SxTGhVq3DFIHpeOzyvNcqCM2qre3hpTCNAsYQL7Go0YRAZkJ73aBotDHkZkxQa2qhH09Gv9/
	uZ4I1G4bPZHvGaecebsRRLOi9Q8EDDhXJkfo2/iJa/6kX4na+lrsE0qQK7Ol69dWKNA=
X-Google-Smtp-Source: AGHT+IFpeymk1eZgvO7YbN3rUfelkvEk2uBGM5LaAhJUkze2V3KA7w/1a5qW98d/0OJAK8PyoMQ+gw==
X-Received: by 2002:a17:90b:1f8d:b0:2ee:6d08:7936 with SMTP id 98e67ed59e1d1-300ff10566amr3212686a91.20.1741670668587;
        Mon, 10 Mar 2025 22:24:28 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:eb9f:29c2:9ede:46d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693f7f0bsm9023649a91.46.2025.03.10.22.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 22:24:28 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-kernel@vger.kernel.org,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Dirk Behme <dirk.behme@de.bosch.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/3] Revert "drivers: core: synchronize really_probe() and dev_uevent()"
Date: Mon, 10 Mar 2025 22:24:14 -0700
Message-ID: <20250311052417.1846985-1-dmitry.torokhov@gmail.com>
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
 drivers/base/core.c | 3 ---
 1 file changed, 3 deletions(-)

v3: no changes.

v2: added Cc: stable, no code changes.

diff --git a/drivers/base/core.c b/drivers/base/core.c
index d2f9d3a59d6b..f9c1c623bca5 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2726,11 +2726,8 @@ static ssize_t uevent_show(struct device *dev, struct device_attribute *attr,
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


