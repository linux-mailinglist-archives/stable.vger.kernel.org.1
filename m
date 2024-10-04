Return-Path: <stable+bounces-80831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB2C990B94
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E969A1C227D8
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324FE1E32A7;
	Fri,  4 Oct 2024 18:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyhuJwOF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5341E048D;
	Fri,  4 Oct 2024 18:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066006; cv=none; b=SUgSYGjkUeN0kC/r/cVASBNIZRVUqLFq3S5ytoM3iNisIyf1sUsIJox4tqGGZzWOlVw8KsKr9TkCJJGI4YmcCX73ehXcphexhTEtxp4aN56eajdZQtHi4FcRMCpX5g+fYVAkBluokWRDdFVSlXHafSwBx6Xt6Xyy+CZrakz0o7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066006; c=relaxed/simple;
	bh=oS1uGqXfnmXPlpnneZZ4xz7G/bFx9yxxFcyIXw9vlaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qWN0GeDVzQtAjRzr9jYCtIdTduhODzrurb9sYuTdLQZBaxHxPt6u7lMTJ8r0cIG34JmJYd31k0m9BBY/imlOyXkwseCYouaGbKD64XnrvzcQkQz+IiPtaFa8KD4e+0Vx2EJFNUqsvX9v3eiYx/7awrjtBr6Imu6E+nS+7pg0W80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyhuJwOF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D381C4CECC;
	Fri,  4 Oct 2024 18:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066005;
	bh=oS1uGqXfnmXPlpnneZZ4xz7G/bFx9yxxFcyIXw9vlaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cyhuJwOF8LzQY1DzoeNOdL+S6SPC5gngIa4u1y3l3oyfUpE/241q7sDTQcywU4kf4
	 gTyhXO2W8UMkMgd7sEv7LSQHTq9d1nLykaBBz1DJrzrj7Ia4cKkfJf0/h/kjbjw8nm
	 E1yncpP4V1hzeKSNaZYGQUndO8A3tnGf63+qVMhpAH8yXEN7TxSssQGdgawm4qGsAP
	 wG437zcEd0jlhFEcfNY1PDKVvgUJ3c/hUwANTXmZ2cPBxa0axNNRRwX7tebxT/ZqyK
	 n3FoiDnMoVFMkwq/Q9o2iA0nO/q78Jxm/GjlzUJmOI4Uf3GmTssj9ZyXz+6OZb88Hf
	 DJxEXE8MqHXhg==
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
Subject: [PATCH AUTOSEL 6.11 51/76] usb: typec: tipd: Free IRQ only if it was requested before
Date: Fri,  4 Oct 2024 14:17:08 -0400
Message-ID: <20241004181828.3669209-51-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
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
 drivers/usb/typec/tipd/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index dd51a25480bfb..256b0c054e9a9 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -1465,8 +1465,9 @@ static void tps6598x_remove(struct i2c_client *client)
 
 	if (!client->irq)
 		cancel_delayed_work_sync(&tps->wq_poll);
+	else
+		devm_free_irq(tps->dev, client->irq, tps);
 
-	devm_free_irq(tps->dev, client->irq, tps);
 	tps6598x_disconnect(tps, 0);
 	typec_unregister_port(tps->port);
 	usb_role_switch_put(tps->role_sw);
-- 
2.43.0


