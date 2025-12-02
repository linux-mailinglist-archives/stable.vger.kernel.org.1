Return-Path: <stable+bounces-198027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDF7C99BDF
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 02:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E89804E1579
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 01:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28FB1CDFD5;
	Tue,  2 Dec 2025 01:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfA6E5TT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8181D147C9B
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 01:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764638860; cv=none; b=S60sNj0ZKUejN1DFz3YSKUfANK3QR+DZjzlnHflkMwsy4dTBcFsYeq0vLlZa7/2xUG8dGpZ6+G23GfeY6NeaVs+3lmIYCSWDBnVW2dVfChiC+DjrQl43R098pPZv1wCwa01P4oBeFcjIE1SwbpaNHQJ0u0Bi24c/WdZkct0m4QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764638860; c=relaxed/simple;
	bh=blTiFA9DIzdACM4HHi/MkMACeu+xg6e67gBVQStkQGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owHF6bFmGb5CucTZQrdsJQK5YhzyFkX0T+pgN0YWI6lD5YUthmiLeh3tuZYveStZ7fIlIvyFMy/LiKOuaVDNLNwFX9c9e71S2hRYxvWF6029iQEWo8vTgnUz0y7/GUX7XVrITYQUl6grDtGSyBR9OdDiwQjH/ouJrD7ULtGtObA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfA6E5TT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2435AC4CEF1;
	Tue,  2 Dec 2025 01:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764638860;
	bh=blTiFA9DIzdACM4HHi/MkMACeu+xg6e67gBVQStkQGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZfA6E5TT8DKeqUKr/HSJUDUEXZRicPr+3DtAns1LUajn6YP6/4TEjExPwNPbx7n4j
	 b8eb/B7k9Wvj1PjwyUZcePUDkHNn/bCcTWS3UFyBe7F1BUW1a/Na9eZ604zLNBSPsX
	 pB2/w4FwC3uoFzY3PFheb1QIE0reC2bWoAb/6FWz85PlufKdPOjiqv+wt2QWRIMe9f
	 qas4OeTU9t+quW+dFjQXcI6RKPzFs0jPfrGanoiRVHRgs/mcthGhIyUHvPCBkP1b+o
	 AnnbcPuYNvneFhZmJMgqhXM9y0JD42Vhe3TUY7b+/RoioAxAUIR6ZUxRxlJyi9mbD/
	 /Ml3Lz7Feu2kg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] usb: renesas_usbhs: Fix synchronous external abort on unbind
Date: Mon,  1 Dec 2025 20:27:36 -0500
Message-ID: <20251202012736.1580110-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025120130-monopoly-untaken-5e9c@gregkh>
References: <2025120130-monopoly-untaken-5e9c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

[ Upstream commit eb9ac779830b2235847b72cb15cf07c7e3333c5e ]

A synchronous external abort occurs on the Renesas RZ/G3S SoC if unbind is
executed after the configuration sequence described above:

modprobe usb_f_ecm
modprobe libcomposite
modprobe configfs
cd /sys/kernel/config/usb_gadget
mkdir -p g1
cd g1
echo "0x1d6b" > idVendor
echo "0x0104" > idProduct
mkdir -p strings/0x409
echo "0123456789" > strings/0x409/serialnumber
echo "Renesas." > strings/0x409/manufacturer
echo "Ethernet Gadget" > strings/0x409/product
mkdir -p functions/ecm.usb0
mkdir -p configs/c.1
mkdir -p configs/c.1/strings/0x409
echo "ECM" > configs/c.1/strings/0x409/configuration

if [ ! -L configs/c.1/ecm.usb0 ]; then
        ln -s functions/ecm.usb0 configs/c.1
fi

echo 11e20000.usb > UDC
echo 11e20000.usb > /sys/bus/platform/drivers/renesas_usbhs/unbind

The displayed trace is as follows:

 Internal error: synchronous external abort: 0000000096000010 [#1] SMP
 CPU: 0 UID: 0 PID: 188 Comm: sh Tainted: G M 6.17.0-rc7-next-20250922-00010-g41050493b2bd #55 PREEMPT
 Tainted: [M]=MACHINE_CHECK
 Hardware name: Renesas SMARC EVK version 2 based on r9a08g045s33 (DT)
 pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : usbhs_sys_function_pullup+0x10/0x40 [renesas_usbhs]
 lr : usbhsg_update_pullup+0x3c/0x68 [renesas_usbhs]
 sp : ffff8000838b3920
 x29: ffff8000838b3920 x28: ffff00000d585780 x27: 0000000000000000
 x26: 0000000000000000 x25: 0000000000000000 x24: ffff00000c3e3810
 x23: ffff00000d5e5c80 x22: ffff00000d5e5d40 x21: 0000000000000000
 x20: 0000000000000000 x19: ffff00000d5e5c80 x18: 0000000000000020
 x17: 2e30303230316531 x16: 312d7968703a7968 x15: 3d454d414e5f4344
 x14: 000000000000002c x13: 0000000000000000 x12: 0000000000000000
 x11: ffff00000f358f38 x10: ffff00000f358db0 x9 : ffff00000b41f418
 x8 : 0101010101010101 x7 : 7f7f7f7f7f7f7f7f x6 : fefefeff6364626d
 x5 : 8080808000000000 x4 : 000000004b5ccb9d x3 : 0000000000000000
 x2 : 0000000000000000 x1 : ffff800083790000 x0 : ffff00000d5e5c80
 Call trace:
 usbhs_sys_function_pullup+0x10/0x40 [renesas_usbhs] (P)
 usbhsg_pullup+0x4c/0x7c [renesas_usbhs]
 usb_gadget_disconnect_locked+0x48/0xd4
 gadget_unbind_driver+0x44/0x114
 device_remove+0x4c/0x80
 device_release_driver_internal+0x1c8/0x224
 device_release_driver+0x18/0x24
 bus_remove_device+0xcc/0x10c
 device_del+0x14c/0x404
 usb_del_gadget+0x88/0xc0
 usb_del_gadget_udc+0x18/0x30
 usbhs_mod_gadget_remove+0x24/0x44 [renesas_usbhs]
 usbhs_mod_remove+0x20/0x30 [renesas_usbhs]
 usbhs_remove+0x98/0xdc [renesas_usbhs]
 platform_remove+0x20/0x30
 device_remove+0x4c/0x80
 device_release_driver_internal+0x1c8/0x224
 device_driver_detach+0x18/0x24
 unbind_store+0xb4/0xb8
 drv_attr_store+0x24/0x38
 sysfs_kf_write+0x7c/0x94
 kernfs_fop_write_iter+0x128/0x1b8
 vfs_write+0x2ac/0x350
 ksys_write+0x68/0xfc
 __arm64_sys_write+0x1c/0x28
 invoke_syscall+0x48/0x110
 el0_svc_common.constprop.0+0xc0/0xe0
 do_el0_svc+0x1c/0x28
 el0_svc+0x34/0xf0
 el0t_64_sync_handler+0xa0/0xe4
 el0t_64_sync+0x198/0x19c
 Code: 7100003f 1a9f07e1 531c6c22 f9400001 (79400021)
 ---[ end trace 0000000000000000 ]---
 note: sh[188] exited with irqs disabled
 note: sh[188] exited with preempt_count 1

The issue occurs because usbhs_sys_function_pullup(), which accesses the IP
registers, is executed after the USBHS clocks have been disabled. The
problem is reproducible on the Renesas RZ/G3S SoC starting with the
addition of module stop in the clock enable/disable APIs. With module stop
functionality enabled, a bus error is expected if a master accesses a
module whose clock has been stopped and module stop activated.

Disable the IP clocks at the end of remove.

Cc: stable <stable@kernel.org>
Fixes: f1407d5c6624 ("usb: renesas_usbhs: Add Renesas USBHS common code")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20251027140741.557198-1-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/renesas_usbhs/common.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index 23d160ef4cd22..50e6a01cb633e 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -802,19 +802,19 @@ static int usbhs_remove(struct platform_device *pdev)
 
 	flush_delayed_work(&priv->notify_hotplug_work);
 
-	/* power off */
-	if (!usbhs_get_dparam(priv, runtime_pwctrl))
-		usbhsc_power_ctrl(priv, 0);
-
-	pm_runtime_disable(&pdev->dev);
-
 	usbhs_platform_call(priv, hardware_exit, pdev);
-	usbhsc_clk_put(priv);
 	reset_control_assert(priv->rsts);
 	usbhs_mod_remove(priv);
 	usbhs_fifo_remove(priv);
 	usbhs_pipe_remove(priv);
 
+	/* power off */
+	if (!usbhs_get_dparam(priv, runtime_pwctrl))
+		usbhsc_power_ctrl(priv, 0);
+
+	usbhsc_clk_put(priv);
+	pm_runtime_disable(&pdev->dev);
+
 	return 0;
 }
 
-- 
2.51.0


