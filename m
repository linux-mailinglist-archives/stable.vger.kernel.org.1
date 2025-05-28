Return-Path: <stable+bounces-147964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C27AC6A68
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 15:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D14B81BC7361
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 13:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D5228751E;
	Wed, 28 May 2025 13:29:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACD4286D63;
	Wed, 28 May 2025 13:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.239.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748438943; cv=none; b=kiBwELeOhtTpkCwu4w2xgD76dIvvH0kWBjAbKzFkCDi82LBxa7+K+Hal+M0B4tYjTUx9SU01xpT5rgSppHtjGNPMju8XZqPB1JA/d7T6r/yLgUR9HhkW0myyobC37gGRDgNVMxJKySauHHrMkD0CrYyb+grINlNLric3oUHKSg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748438943; c=relaxed/simple;
	bh=G9JqeHpPW6gvOfEzKz4n2RVCy66x2CW3mDkGusy5R6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CXRxy1z5SeycSFnl+ovPl3Fmw2jP11AVsD+8AGpr/NiemXbVoaKSa3C0JkdgCXESIQnhgkZ4xu0E30+T84CKe/oISvHZ4y+FzJaAOlbCeaBPp+P0Wc9RVKa1d4NJ5tT3kmReJVRWqIClbiYUeDwy2coFUIALm6swjp+vn0Fngec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org; spf=pass smtp.mailfrom=enpas.org; arc=none smtp.client-ip=46.38.239.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id 814C510392F;
	Wed, 28 May 2025 13:28:50 +0000 (UTC)
From: Max Staudt <max@enpas.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Johan Hovold <johan@kernel.org>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Max Staudt <max@enpas.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] tty: Fix race against tty_open() in tty_register_device_attr()
Date: Wed, 28 May 2025 22:28:16 +0900
Message-Id: <20250528132816.11433-2-max@enpas.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250528132816.11433-1-max@enpas.org>
References: <20250528132816.11433-1-max@enpas.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the chardev is now created before the class device is registered,
an attempt to tty_[k]open() the chardev between these two steps will
lead to tty->dev being assigned NULL by alloc_tty_struct().

alloc_tty_struct() is called via tty_init_dev() when the tty is firstly
opened, and is entered with tty_mutex held, so let's lock the critical
section in tty_register_device_attr() with the same global mutex.
This guarantees that tty->dev can be assigned a sane value.

Fixes: 6a7e6f78c235 ("tty: close race between device register and open")
Signed-off-by: Max Staudt <max@enpas.org>
Cc: <stable@vger.kernel.org>
---
 drivers/tty/tty_io.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index e922b84524d2..94768509e2d2 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3258,6 +3258,8 @@ struct device *tty_register_device_attr(struct tty_driver *driver,
 	else
 		tty_line_name(driver, index, name);
 
+	mutex_lock(&tty_mutex);
+
 	if (!(driver->flags & TTY_DRIVER_DYNAMIC_ALLOC)) {
 		/*
 		 * Free any saved termios data so that the termios state is
@@ -3271,7 +3273,7 @@ struct device *tty_register_device_attr(struct tty_driver *driver,
 
 		retval = tty_cdev_add(driver, devt, index, 1);
 		if (retval)
-			return ERR_PTR(retval);
+			goto err_unlock;
 
 		cdev_added = true;
 	}
@@ -3294,6 +3296,8 @@ struct device *tty_register_device_attr(struct tty_driver *driver,
 	if (retval)
 		goto err_put;
 
+	mutex_unlock(&tty_mutex);
+
 	return dev;
 
 err_put:
@@ -3309,6 +3313,9 @@ struct device *tty_register_device_attr(struct tty_driver *driver,
 		driver->cdevs[index] = NULL;
 	}
 
+err_unlock:
+	mutex_unlock(&tty_mutex);
+
 	return ERR_PTR(retval);
 }
 EXPORT_SYMBOL_GPL(tty_register_device_attr);
-- 
2.39.5


