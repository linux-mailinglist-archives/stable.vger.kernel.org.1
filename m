Return-Path: <stable+bounces-14152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CE6837FB3
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12F31F2A32F
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AB264ABD;
	Tue, 23 Jan 2024 00:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CrlcUSqp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185E7627F3;
	Tue, 23 Jan 2024 00:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971303; cv=none; b=kVcWOpKKgi53UxRadwtoJef0EmD1Vfq2S6IB1iK2QirgDzWyuFpxnsv3w7OlJhXhVnGBKsLtEHL5LrnTzGMn1PA/gXbKRD348OnWIm4YQmwU/iArYgHgwxg2ibe8CCSMtnnNSsMvWQuEQo49x5A/aQCi2Fk4d+wdT2i1MVePB0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971303; c=relaxed/simple;
	bh=JsbUvqNyEFL/ykzO/5z8Z0rpUwsYUflPr81557GnZXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJxOrPWrJOhqUX6eg6eEfFPJOKmDiybb+ZuFPaErNb07XJqRA7yLpOL2G56LBMrF3zr5GqQn9SKhGEB9F4uSknRxljVRYpxQ2eq6Ke0wDSP9mQZi/ClH/6YhUxLOVYMIdKGYJl5kojUf5g140vfvTj2CPOgLz3aLCR36FzNLo7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CrlcUSqp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B32D2C433C7;
	Tue, 23 Jan 2024 00:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705971302;
	bh=JsbUvqNyEFL/ykzO/5z8Z0rpUwsYUflPr81557GnZXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CrlcUSqpaLALhryeKrs9F1eN4+Kt6fDu1I/9FmJgVRocFlGZFAyAkMsWsvQvAeZJE
	 Lk6TZXBjzFl0zTuIB1ZtPDT5eyOHsZvg/unEvovMzcAnk4SMAVGG9POcgYpeBDbKAj
	 hadkqPJAPORDRHnWh53uaYeJyilnEzrFmF87H33M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Curtis Klein <curtis.klein@hpe.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 220/417] watchdog: set cdev owner before adding
Date: Mon, 22 Jan 2024 15:56:28 -0800
Message-ID: <20240122235759.541138962@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235751.480367507@linuxfoundation.org>
References: <20240122235751.480367507@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Curtis Klein <curtis.klein@hpe.com>

[ Upstream commit 38d75297745f04206db9c29bdd75557f0344c7cc ]

When the new watchdog character device is registered, it becomes
available for opening. This creates a race where userspace may open the
device before the character device's owner is set. This results in an
imbalance in module_get calls as the cdev_get in cdev_open will not
increment the reference count on the watchdog driver module.

This causes problems when the watchdog character device is released as
the module loader's reference will also be released. This makes it
impossible to open the watchdog device later on as it now appears that
the module is being unloaded. The open will fail with -ENXIO from
chrdev_open.

The legacy watchdog device will fail with -EBUSY from the try_module_get
in watchdog_open because it's module owner is the watchdog core module
so it can still be opened but it will fail to get a refcount on the
underlying watchdog device driver.

Fixes: 72139dfa2464 ("watchdog: Fix the race between the release of watchdog_core_data and cdev")
Signed-off-by: Curtis Klein <curtis.klein@hpe.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20231205190522.55153-1-curtis.klein@hpe.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/watchdog_dev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index fdffa6859dde..81684d89dc98 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -1052,6 +1052,7 @@ static int watchdog_cdev_register(struct watchdog_device *wdd)
 
 	/* Fill in the data structures */
 	cdev_init(&wd_data->cdev, &watchdog_fops);
+	wd_data->cdev.owner = wdd->ops->owner;
 
 	/* Add the device */
 	err = cdev_device_add(&wd_data->cdev, &wd_data->dev);
@@ -1066,8 +1067,6 @@ static int watchdog_cdev_register(struct watchdog_device *wdd)
 		return err;
 	}
 
-	wd_data->cdev.owner = wdd->ops->owner;
-
 	/* Record time of most recent heartbeat as 'just before now'. */
 	wd_data->last_hw_keepalive = ktime_sub(ktime_get(), 1);
 	watchdog_set_open_deadline(wd_data);
-- 
2.43.0




