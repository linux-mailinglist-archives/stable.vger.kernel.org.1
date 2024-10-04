Return-Path: <stable+bounces-80967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAABD990D56
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 972FD1F22CB2
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A22206E6F;
	Fri,  4 Oct 2024 18:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vo+GYqJs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0430D206E69;
	Fri,  4 Oct 2024 18:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066379; cv=none; b=rRS9e1QnWzc4xURZoTKNi8XncdItwsyK4HRonn/6W5Uu05YaspA3Y7yngWJJnMgr81I8qXVnpUtyVcrEtoulH739AJzgf+jiFOVrpgkXTofUEic4kXPVn+mNExACg2aEEfHTf6ueOKU0GY4JDVybNxePLTMjSLQBvVCsEfLjka0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066379; c=relaxed/simple;
	bh=oY4AkKK3cNYSXzwmeEH5JZe1WS6YZTk1cFuE/iN7Uhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lt6AWRYs/fwk+ne3KAoRkBzuQZOQe8AG6S/ufh9AN/G6kCuCyQTwoYWA1V2nH1sCPffwtfcoi8M1Icx+hOVrUQKdZ0X1qtNWAuEJkxv+cUOkCp2286YF7oV5be4pYXwwR55C+Q9wKnot6bXM4n6cYByRP21HPZiQdLlm4luUuYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vo+GYqJs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F780C4CEC6;
	Fri,  4 Oct 2024 18:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066378;
	bh=oY4AkKK3cNYSXzwmeEH5JZe1WS6YZTk1cFuE/iN7Uhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vo+GYqJsCH4P6R5sPM2A++jPr/Qhzgay0JNJlsfOFjyWEZgCKmBHOqfByIklaI18N
	 lybDHex/Bb1f1+uNCix/hDrYOvdZS8CmjvU0TqpsJzZ8gaiSjtI6ttV6tb/77sTKMP
	 ryTNssLh3oIizTgSMAoIouXy4D+4mfwABRROm+7xOekDhUpespQMEVydws9g9wm+jc
	 PdZAL0inArbaLTOrMbhxjzKN1pv2ePkp/tKDw6NvzaZAIRN/iq68H2qwf2pR0kqlV+
	 rcLf5jPRSlS/cVSigoWKmGkmWYHgpalBQ/JMp/t5mPi7Ng8xXDoOGj4FX9yQ9vcCC3
	 ZAYcRtImFA3mw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wadim Egorov <w.egorov@phytec.de>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	javier.carrasco@wolfvision.net,
	abdelalkuor@geotab.com,
	harshit.m.mogalapalli@oracle.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 41/58] usb: typec: tipd: Free IRQ only if it was requested before
Date: Fri,  4 Oct 2024 14:24:14 -0400
Message-ID: <20241004182503.3672477-41-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182503.3672477-1-sashal@kernel.org>
References: <20241004182503.3672477-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.54
Content-Transfer-Encoding: 8bit

From: Wadim Egorov <w.egorov@phytec.de>

[ Upstream commit db63d9868f7f310de44ba7bea584e2454f8b4ed0 ]

In polling mode, if no IRQ was requested there is no need to free it.
Call devm_free_irq() only if client->irq is set. This fixes the warning
caused by the tps6598x module removal:

WARNING: CPU: 2 PID: 333 at kernel/irq/devres.c:144 devm_free_irq+0x80/0x8c
...
...
Call trace:
  devm_free_irq+0x80/0x8c
  tps6598x_remove+0x28/0x88 [tps6598x]
  i2c_device_remove+0x2c/0x9c
  device_remove+0x4c/0x80
  device_release_driver_internal+0x1cc/0x228
  driver_detach+0x50/0x98
  bus_remove_driver+0x6c/0xbc
  driver_unregister+0x30/0x60
  i2c_del_driver+0x54/0x64
  tps6598x_i2c_driver_exit+0x18/0xc3c [tps6598x]
  __arm64_sys_delete_module+0x184/0x264
  invoke_syscall+0x48/0x110
  el0_svc_common.constprop.0+0xc8/0xe8
  do_el0_svc+0x20/0x2c
  el0_svc+0x28/0x98
  el0t_64_sync_handler+0x13c/0x158
  el0t_64_sync+0x190/0x194

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20240816124150.608125-1-w.egorov@phytec.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/tipd/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 125269f39f83a..01db27cbf1d10 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -907,6 +907,8 @@ static void tps6598x_remove(struct i2c_client *client)
 
 	if (!client->irq)
 		cancel_delayed_work_sync(&tps->wq_poll);
+	else
+		devm_free_irq(tps->dev, client->irq, tps);
 
 	tps6598x_disconnect(tps, 0);
 	typec_unregister_port(tps->port);
-- 
2.43.0


