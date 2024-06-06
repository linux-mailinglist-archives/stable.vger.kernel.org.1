Return-Path: <stable+bounces-49489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 658F88FED76
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05E3D1F2132D
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FDF1BB68D;
	Thu,  6 Jun 2024 14:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TtEsBQ1f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C0C198E96;
	Thu,  6 Jun 2024 14:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683491; cv=none; b=WKVfBa/VjFgelx3+g4dcoSU7O29iC2zU6U/4zTas4Xqai/b6SSQAHNgnbkt7ryMl9BaH4Cc7yl3pExPDjCYRoD5zOEUAPScdOpon0IH3koztnMnRC0jhMDxVAlffWpHTGXKGBYS5HzMeQ1KG5+VZbOmmDgLDkEhHpK3Lb1s5n3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683491; c=relaxed/simple;
	bh=gjeDgqDcskU3NdtdCnAQbZqZhjNmNRMFCLLdqJ55x20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AaubnJmL7OM9ZohY+GVpamSr9kLbGjej3MXQ+QeeRtpc8Yb4JSnZtZLaFZNzoqAppbOJxZBgZm2LvIVeuD0qLR7parsQOiWmF68874Qd1oMtfv+E7nKa/TnaQiibspqyl6qOdLYSjw4eiyJWC6glVB5wYiSMr9kx0l6HIXhrQGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TtEsBQ1f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E4DC2BD10;
	Thu,  6 Jun 2024 14:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683490;
	bh=gjeDgqDcskU3NdtdCnAQbZqZhjNmNRMFCLLdqJ55x20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TtEsBQ1fKXT6IaCiDAlpSYeW9rVnxoPn4rcLpIJ+ymZ7zfIULhosZJu9ZhwtBZtcC
	 3cgyAmTo5Q2UYndkGo99qSDYOLHEDQmCkUyJyPxAs6OmcivX9bZIHYP5ESmeAPzisv
	 bNK3uTKrnxhvDVSqnIs6EgARRs5/eo+PwXskeYMU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 381/473] Input: cyapa - add missing input core locking to suspend/resume functions
Date: Thu,  6 Jun 2024 16:05:10 +0200
Message-ID: <20240606131712.453632564@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131659.786180261@linuxfoundation.org>
References: <20240606131659.786180261@linuxfoundation.org>
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

From: Marek Szyprowski <m.szyprowski@samsung.com>

[ Upstream commit 7b4e0b39182cf5e677c1fc092a3ec40e621c25b6 ]

Grab input->mutex during suspend/resume functions like it is done in
other input drivers. This fixes the following warning during system
suspend/resume cycle on Samsung Exynos5250-based Snow Chromebook:

------------[ cut here ]------------
WARNING: CPU: 1 PID: 1680 at drivers/input/input.c:2291 input_device_enabled+0x68/0x6c
Modules linked in: ...
CPU: 1 PID: 1680 Comm: kworker/u4:12 Tainted: G        W          6.6.0-rc5-next-20231009 #14109
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: events_unbound async_run_entry_fn
 unwind_backtrace from show_stack+0x10/0x14
 show_stack from dump_stack_lvl+0x58/0x70
 dump_stack_lvl from __warn+0x1a8/0x1cc
 __warn from warn_slowpath_fmt+0x18c/0x1b4
 warn_slowpath_fmt from input_device_enabled+0x68/0x6c
 input_device_enabled from cyapa_gen3_set_power_mode+0x13c/0x1dc
 cyapa_gen3_set_power_mode from cyapa_reinitialize+0x10c/0x15c
 cyapa_reinitialize from cyapa_resume+0x48/0x98
 cyapa_resume from dpm_run_callback+0x90/0x298
 dpm_run_callback from device_resume+0xb4/0x258
 device_resume from async_resume+0x20/0x64
 async_resume from async_run_entry_fn+0x40/0x15c
 async_run_entry_fn from process_scheduled_works+0xbc/0x6a8
 process_scheduled_works from worker_thread+0x188/0x454
 worker_thread from kthread+0x108/0x140
 kthread from ret_from_fork+0x14/0x28
Exception stack(0xf1625fb0 to 0xf1625ff8)
...
---[ end trace 0000000000000000 ]---
...
------------[ cut here ]------------
WARNING: CPU: 1 PID: 1680 at drivers/input/input.c:2291 input_device_enabled+0x68/0x6c
Modules linked in: ...
CPU: 1 PID: 1680 Comm: kworker/u4:12 Tainted: G        W          6.6.0-rc5-next-20231009 #14109
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: events_unbound async_run_entry_fn
 unwind_backtrace from show_stack+0x10/0x14
 show_stack from dump_stack_lvl+0x58/0x70
 dump_stack_lvl from __warn+0x1a8/0x1cc
 __warn from warn_slowpath_fmt+0x18c/0x1b4
 warn_slowpath_fmt from input_device_enabled+0x68/0x6c
 input_device_enabled from cyapa_gen3_set_power_mode+0x13c/0x1dc
 cyapa_gen3_set_power_mode from cyapa_reinitialize+0x10c/0x15c
 cyapa_reinitialize from cyapa_resume+0x48/0x98
 cyapa_resume from dpm_run_callback+0x90/0x298
 dpm_run_callback from device_resume+0xb4/0x258
 device_resume from async_resume+0x20/0x64
 async_resume from async_run_entry_fn+0x40/0x15c
 async_run_entry_fn from process_scheduled_works+0xbc/0x6a8
 process_scheduled_works from worker_thread+0x188/0x454
 worker_thread from kthread+0x108/0x140
 kthread from ret_from_fork+0x14/0x28
Exception stack(0xf1625fb0 to 0xf1625ff8)
...
---[ end trace 0000000000000000 ]---

Fixes: d69f0a43c677 ("Input: use input_device_enabled()")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Link: https://lore.kernel.org/r/20231009121018.1075318-1-m.szyprowski@samsung.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/mouse/cyapa.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
index 77cc653edca22..e401934df4642 100644
--- a/drivers/input/mouse/cyapa.c
+++ b/drivers/input/mouse/cyapa.c
@@ -1357,10 +1357,16 @@ static int __maybe_unused cyapa_suspend(struct device *dev)
 	u8 power_mode;
 	int error;
 
-	error = mutex_lock_interruptible(&cyapa->state_sync_lock);
+	error = mutex_lock_interruptible(&cyapa->input->mutex);
 	if (error)
 		return error;
 
+	error = mutex_lock_interruptible(&cyapa->state_sync_lock);
+	if (error) {
+		mutex_unlock(&cyapa->input->mutex);
+		return error;
+	}
+
 	/*
 	 * Runtime PM is enable only when device is in operational mode and
 	 * users in use, so need check it before disable it to
@@ -1395,6 +1401,8 @@ static int __maybe_unused cyapa_suspend(struct device *dev)
 		cyapa->irq_wake = (enable_irq_wake(client->irq) == 0);
 
 	mutex_unlock(&cyapa->state_sync_lock);
+	mutex_unlock(&cyapa->input->mutex);
+
 	return 0;
 }
 
@@ -1404,6 +1412,7 @@ static int __maybe_unused cyapa_resume(struct device *dev)
 	struct cyapa *cyapa = i2c_get_clientdata(client);
 	int error;
 
+	mutex_lock(&cyapa->input->mutex);
 	mutex_lock(&cyapa->state_sync_lock);
 
 	if (device_may_wakeup(dev) && cyapa->irq_wake) {
@@ -1422,6 +1431,7 @@ static int __maybe_unused cyapa_resume(struct device *dev)
 	enable_irq(client->irq);
 
 	mutex_unlock(&cyapa->state_sync_lock);
+	mutex_unlock(&cyapa->input->mutex);
 	return 0;
 }
 
-- 
2.43.0




