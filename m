Return-Path: <stable+bounces-113928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA85A2948C
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 16:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F1E73B272F
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C87A18BBBB;
	Wed,  5 Feb 2025 15:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0yIJoodr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA6C1A7AFD;
	Wed,  5 Feb 2025 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768644; cv=none; b=u/wVNe18jk08UJy2CZQ2FS6YoEwg6uP/Ls/Gi0Jg7HnvVHlfFgjp4njczf5HCwdwT8qx0rdSlmhnM71NELQSCpX8UcnZ89LBEG4KqJadC+eHXWnoXaAangfbNs/WLCv13gx65WsOdjbjW7leXz21g60j//amEvS8E3TIzWzdNmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768644; c=relaxed/simple;
	bh=JDnhgO/iKpIBbj54n6ny7j7MP1eD6yK8ip9/7oAc0yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qliMq9435E7SgPQhpnacfVth6dCRG3ltFXIDwmUzLEEBY135XJzFqud5jwVnvjTIKso7qqfis4HKZPUr8YGDah4e/Y5I6G27ieYozE4/ZMqqUvuLnO7iwiixyPu1QsThAPBrmCwcFyJom+7Bm4OF12L3mQevUAv2gQv74ktkgOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0yIJoodr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF12C4CED1;
	Wed,  5 Feb 2025 15:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738768643;
	bh=JDnhgO/iKpIBbj54n6ny7j7MP1eD6yK8ip9/7oAc0yg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0yIJoodrSaT/5TjzPYFDTIdZcZKIsCi+pf3xLICPLDD4J6p19NzsXR150kO8PJyLr
	 BT1TWVOtUQJYYAEWJb859LnYZAgLBU+AJDA4Od9MnAAyArAuIJVNd9nOiqTuwaR13C
	 JgRA/alZ5yOZC0tsVvQ7lOxjFxZODBhbDkuFdNIQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.13 615/623] ASoC: da7213: Initialize the mutex
Date: Wed,  5 Feb 2025 14:45:57 +0100
Message-ID: <20250205134519.744413189@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134456.221272033@linuxfoundation.org>
References: <20250205134456.221272033@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 4a32a38cb68f55ff9e100df348ddb3d4b3e50643 upstream.

Initialize the struct da7213_priv::ctrl_lock mutex. Without it the
following stack trace is displayed when rebooting and lockdep is enabled:

DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: CPU: 0 PID: 180 at kernel/locking/mutex.c:564 __mutex_lock+0x254/0x4e4
CPU: 0 UID: 0 PID: 180 Comm: alsactl Not tainted 6.13.0-next-20250123-arm64-renesas-00002-g132083a22d3d #30
Hardware name: Renesas SMARC EVK version 2 based on r9a08g045s33 (DT)
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __mutex_lock+0x254/0x4e4
lr : __mutex_lock+0x254/0x4e4
sp : ffff800082c13c00
x29: ffff800082c13c00 x28: ffff00001002b500 x27: 0000000000000000
x26: 0000000000000000 x25: ffff800080b30db4 x24: 0000000000000002
x23: ffff800082c13c70 x22: 0000ffffc2a68a70 x21: ffff000010348000
x20: 0000000000000000 x19: ffff00000be2e488 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 00000000000003c1 x13: 00000000000003c1 x12: 0000000000000000
x11: 0000000000000011 x10: 0000000000001420 x9 : ffff800082c13a70
x8 : 0000000000000001 x7 : ffff800082c13a50 x6 : ffff800082c139e0
x5 : ffff800082c14000 x4 : ffff800082c13a50 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff00001002b500
Call trace:
  __mutex_lock+0x254/0x4e4 (P)
  mutex_lock_nested+0x20/0x28
  da7213_volsw_locked_get+0x34/0x60
  snd_ctl_elem_read+0xbc/0x114
  snd_ctl_ioctl+0x878/0xa70
  __arm64_sys_ioctl+0x94/0xc8
  invoke_syscall+0x44/0x104
  el0_svc_common.constprop.0+0xb4/0xd4
  do_el0_svc+0x18/0x20
  el0_svc+0x3c/0xf0
  el0t_64_sync_handler+0xc0/0xc4
  el0t_64_sync+0x154/0x158
 irq event stamp: 7713
 hardirqs last  enabled at (7713): [<ffff800080170d94>] ktime_get_coarse_real_ts64+0xf0/0x10c
 hardirqs last disabled at (7712): [<ffff800080170d58>] ktime_get_coarse_real_ts64+0xb4/0x10c
 softirqs last  enabled at (7550): [<ffff8000800179d4>] fpsimd_restore_current_state+0x30/0xb8
 softirqs last disabled at (7548): [<ffff8000800179a8>] fpsimd_restore_current_state+0x4/0xb8
 ---[ end trace 0000000000000000 ]---

Fixes: 64c3259b5f86 ("ASoC: da7213: Add new kcontrol for tonegen")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20250123121036.70406-1-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/da7213.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -2203,6 +2203,8 @@ static int da7213_i2c_probe(struct i2c_c
 		return ret;
 	}
 
+	mutex_init(&da7213->ctrl_lock);
+
 	pm_runtime_set_autosuspend_delay(&i2c->dev, 100);
 	pm_runtime_use_autosuspend(&i2c->dev);
 	pm_runtime_set_active(&i2c->dev);



