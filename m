Return-Path: <stable+bounces-189996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D20BFC0E4C9
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 15:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFE2D188B63E
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 14:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966B8309F0C;
	Mon, 27 Oct 2025 14:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ft+xNKyn"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D4B3093CA
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 14:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761574071; cv=none; b=brUTSgHuQhNVzwKSsFaKFIVVML56xZ4/z5XFIBhWfpiU4+TjOHY2KP1m0lveSaNpz9XaTmg0/C4Uxgwg0AA40cBq2eVq/P2zXqopuD/Ygxd0jqxmYQPAvDyVb0iONdOhYumrTo/DxfMVxkYBLfNJY4lq5Q8egL9u7U0tued1hdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761574071; c=relaxed/simple;
	bh=wv56AV0Jq/flPSGpBjDi2WM9DEs3bXu/QVoUCBtBmA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZBYVya+ZxmTOFAtjIRoxguNxdzJJvT9vT374OpYxA2ogqWgtrWQ33Nf0q5JATqaIwsTsN2BcQG8zfXoJ/pNDZ80WE3yj272mHvAjDWniKSW7mD3MraTAW4cHgpw+U8BdXPFfxapWMC8GMO2Rz4JFI7sdoSK0tX0CRYgFAdkRL9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ft+xNKyn; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so47255645e9.1
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 07:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1761574066; x=1762178866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7wFJQSWthyk8WZ0UpuKCyAYtMl2GQqkDptp4e/pHYz0=;
        b=ft+xNKynT/FIwno4tHD9C8D9eJugH/CpTY8b6eAdYVVVplT52w/bvCM5KtTmOgiq9O
         z9jqv7Vu2kMMNNl1blCOG6hkv8KikO5zAz887mYJyw2i3bi2ILGE0or0c8UCmagBr4cz
         1SJZ+mnQ20qnXg5xvT7ZB+s+n3QVWFMAjlJ7btIRBCp3E2Sm314PbeHLznyUSRFLit+h
         XRQsNKyDvD0e0bbOoXb4HcN0/LFsUSj9Xmudd5HITII1ZrtKPHvurtXw5wIhnV4P069x
         ETiGScGKJG0E8kcNa/M+jp0LGLScEcyTy2Bcoou8Gd3Qz/GQyYwXyEX4GqD8EU3tQvJE
         GMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761574066; x=1762178866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7wFJQSWthyk8WZ0UpuKCyAYtMl2GQqkDptp4e/pHYz0=;
        b=R9MmjJXkKMwT+DiKM+cRH63E+p/CbbJWfUlaN5aYEqKI0/oqJ1QINVix9zLzhYsNnB
         ugYa5+EkyWe2VqwQzt5pnlSMWJpfQi7fBR4q1pfG1x4njRwOXM52pA2weW1bxAF/sjLG
         5qRk44a/eJM5TU/0TG7VeXW2sjCAEa/7oECTD7jLLFU5pp1ZsWhIBnDquxB3KfP1RmnY
         Qzqw/6Iq1/2VUYTA4zNtdXl/+h5OZJMRktSQo1t83M2R2UanZWKp2RlWj0Jrd+2XXDO2
         q87QAoVpeu5FaWxDUirdZMrUnGEm//+CfAoHWg4ZP18wSCMDvCB3SIeFkWcypQF+UFYo
         CfHw==
X-Forwarded-Encrypted: i=1; AJvYcCWiJvoMqsd5fqHiOtVrniOgKb+PQJLPWy0ACwMvaso502AazpCRbS2FxA6saDKMeAiWyEmVvU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY5Fwuc2JRW7UARJosMnew2QF/bZ+HmuzKUXI6rzfZkGLdy5HM
	m6nC30jEeNgKXQYi/eqzlW38eRCzyq9eJlYpmmbIjqdW9gpD4k/9CXm10k9XAIhxTe4=
X-Gm-Gg: ASbGncullabEHzfOhIKMFhVjuVIez3r+z2tZWKlOkjsZawBcfmAqJ9qyc5h7e016KDt
	Q7jYbK7aHOnnqzHq+8LOMbGlAomjSkc1vCW7V+v4QyBPJ7wsg/FXujvp63CX3i6xW9sBVl6utA2
	dxA6ap/BkS5yok2UpPY4ra5jUTPfzoFiP68WhA77Y+tEFA+t42hA/iptrgTMLnYuD0Z5bVIe1i+
	U043RDEHzsyUzAPb2CUEvNCsSRq0PS/FQ2Y+zQ2To0pflHr4VoASEoChPXBNvW6L6UPUKEZPHzj
	c5+UVaHbqI1drW7bgMX7iQ4aPYkVaZHpELK5I4fyHBC2VR45GIY8pyicv+XyPj1LqDCgJmFTRAZ
	w42KRcxlc9MYIEMu8S1Wra/upPfW3bSsFRNz6hLmolIBjdjIOb+2ev3/tpfQllsDkTzj0J82SUZ
	ioEDcIL9fzjNINqmloI3H8L9SZTFXBwWj9RTkznpU+xaahK0g0DMghxW8rkpg=
X-Google-Smtp-Source: AGHT+IHgCtEQDqJY442vEC9H6ASjUR0eM1wPzA5shUtEykOt8otJtXmTCbjUyDHjgtZGP2pIj3KyUg==
X-Received: by 2002:a05:600c:1f93:b0:46e:761b:e7ff with SMTP id 5b1f17b1804b1-4711791c66fmr327034745e9.28.1761574066376;
        Mon, 27 Oct 2025 07:07:46 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6302:7900:83af:5b2:a2ec:e92e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd4783b8sm139668425e9.15.2025.10.27.07.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 07:07:45 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: gregkh@linuxfoundation.org,
	yoshihiro.shimoda.uh@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	kuninori.morimoto.gx@renesas.com,
	geert+renesas@glider.be
Cc: claudiu.beznea@tuxon.dev,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] usb: renesas_usbhs: Fix synchronous external abort on unbind
Date: Mon, 27 Oct 2025 16:07:41 +0200
Message-ID: <20251027140741.557198-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

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

Cc: stable@vger.kernel.org
Fixes: f1407d5c6624 ("usb: renesas_usbhs: Add Renesas USBHS common code")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- moved usbhsc_clk_put() before pm_runtime_disable()

Patch was tested with continuous unbind/bind and the configuration
sequence described above on the boards with the following device trees:

- r8a774a1-hihope-rzg2m-ex.dts
- r8a774b1-hihope-rzg2n-ex.dts
- r8a774e1-hihope-rzg2h-ex.dts
- r9a07g043u11-smarc.dts
- r9a07g044c2-smarc.dts
- r9a07g044l2-smarc.dts
- r9a07g054l2-smarc.dts

 drivers/usb/renesas_usbhs/common.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index 8f536f2c500f..dc2fec9168b7 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -813,18 +813,18 @@ static void usbhs_remove(struct platform_device *pdev)
 
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
+
+	/* power off */
+	if (!usbhs_get_dparam(priv, runtime_pwctrl))
+		usbhsc_power_ctrl(priv, 0);
+
+	usbhsc_clk_put(priv);
+	pm_runtime_disable(&pdev->dev);
 }
 
 static int usbhsc_suspend(struct device *dev)
-- 
2.43.0


