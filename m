Return-Path: <stable+bounces-213274-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKkTHpQjgmnPPgMAu9opvQ
	(envelope-from <stable+bounces-213274-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 17:34:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C506DC09E
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 17:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F6BF310B4C8
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 16:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4463C198A;
	Tue,  3 Feb 2026 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="niScXbPg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F401318131
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770135859; cv=none; b=a0setxz4yp4BjKcMqzadNv03GxcbV0Io5P1ypFqitkTimYTL0oyNrVksn6eaPgk3NiLk7VDUkqRFm9M8F118fRQGs1vzKcalVhtR/jMvN7G6TjySbVx91GG6806hsUc4MmsoVUJ3xJu2St0wBtpIy9FRxNnyVLLkarBsTmXGZPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770135859; c=relaxed/simple;
	bh=upJ4K2Ydtsi7Wio3E1WizhRoh5XeQG2yPTmnly7vpTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cN5DTk7L/gsXAATMyrfT0ZD9/TyEL5axAkK4v10KdV042gGewVESxMJrpTJJSoH35mqwNe7gtoGWg5aolu2t7Nq39JHJijUiBwOwsYMg5CDnUPETS/rH8opEG24nG6+Zcx2sHb5gsXd1O3t7OXScVxQzCdFN8gpm34mZhMhtiRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=niScXbPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B90EC116D0;
	Tue,  3 Feb 2026 16:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770135858;
	bh=upJ4K2Ydtsi7Wio3E1WizhRoh5XeQG2yPTmnly7vpTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=niScXbPgp9IZ9hSTcKY1hfL6HAFLso6Wr/JTqgBqwKXhuu237NQEJ+6cf3qOAZfpr
	 uS2VSMQ6sGit8VXV+wNY5B+RVVpE/gQI0VDm9a4GziHyBUhnm/Hz4cb6bax8SAOSAW
	 3RgIyzPPlHdOMkiB2+X1tANeXk8eDgkb/GuMB02UtbOkgPi8tHNfU5HSsVzHhQHhFe
	 L+q4H96d3HnszdDVnX3fXGxFtVc5Ro3CwxJsq1u3WHezn02705d+vLDVQBtOaOWKXE
	 oQZ3a1w00a2hhqE9WEf6HyoBxXxr0+UlRa7ZSTp1evKPQ5l7ZiWcwM/KT3TZpyKs+M
	 2yvHnw2RuSi8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Linus Walleij <linusw@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] pinctrl: meson: mark the GPIO controller as sleeping
Date: Tue,  3 Feb 2026 11:24:15 -0500
Message-ID: <20260203162415.1307360-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026020331-attribute-willow-2cbe@gregkh>
References: <2026020331-attribute-willow-2cbe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,samsung.com,googlemail.com,linaro.org,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213274-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,samsung.com:email]
X-Rspamd-Queue-Id: 1C506DC09E
X-Rspamd-Action: no action

From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

[ Upstream commit 28f24068387169722b508bba6b5257cb68b86e74 ]

The GPIO controller is configured as non-sleeping but it uses generic
pinctrl helpers which use a mutex for synchronization.

This can cause the following lockdep splat with shared GPIOs enabled on
boards which have multiple devices using the same GPIO:

BUG: sleeping function called from invalid context at
kernel/locking/mutex.c:591
in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 142, name:
kworker/u25:3
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
INFO: lockdep is turned off.
irq event stamp: 46379
hardirqs last  enabled at (46379): [<ffff8000813acb24>]
_raw_spin_unlock_irqrestore+0x74/0x78
hardirqs last disabled at (46378): [<ffff8000813abf38>]
_raw_spin_lock_irqsave+0x84/0x88
softirqs last  enabled at (46330): [<ffff8000800c71b4>]
handle_softirqs+0x4c4/0x4dc
softirqs last disabled at (46295): [<ffff800080010674>]
__do_softirq+0x14/0x20
CPU: 1 UID: 0 PID: 142 Comm: kworker/u25:3 Tainted: G C
6.19.0-rc4-next-20260105+ #11963 PREEMPT
Tainted: [C]=CRAP
Hardware name: Khadas VIM3 (DT)
Workqueue: events_unbound deferred_probe_work_func
Call trace:
  show_stack+0x18/0x24 (C)
  dump_stack_lvl+0x90/0xd0
  dump_stack+0x18/0x24
  __might_resched+0x144/0x248
  __might_sleep+0x48/0x98
  __mutex_lock+0x5c/0x894
  mutex_lock_nested+0x24/0x30
  pinctrl_get_device_gpio_range+0x44/0x128
  pinctrl_gpio_set_config+0x40/0xdc
  gpiochip_generic_config+0x28/0x3c
  gpio_do_set_config+0xa8/0x194
  gpiod_set_config+0x34/0xfc
  gpio_shared_proxy_set_config+0x6c/0xfc [gpio_shared_proxy]
  gpio_do_set_config+0xa8/0x194
  gpiod_set_transitory+0x4c/0xf0
  gpiod_configure_flags+0xa4/0x480
  gpiod_find_and_request+0x1a0/0x574
  gpiod_get_index+0x58/0x84
  devm_gpiod_get_index+0x20/0xb4
  devm_gpiod_get+0x18/0x24
  mmc_pwrseq_emmc_probe+0x40/0xb8
  platform_probe+0x5c/0xac
  really_probe+0xbc/0x298
  __driver_probe_device+0x78/0x12c
  driver_probe_device+0xdc/0x164
  __device_attach_driver+0xb8/0x138
  bus_for_each_drv+0x80/0xdc
  __device_attach+0xa8/0x1b0

Fixes: 6ac730951104 ("pinctrl: add driver for Amlogic Meson SoCs")
Cc: stable@vger.kernel.org
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Closes: https://lore.kernel.org/all/00107523-7737-4b92-a785-14ce4e93b8cb@samsung.com/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Linus Walleij <linusw@kernel.org>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/meson/pinctrl-meson.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
index ae72edba8a1f0..292e44c20dc08 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -614,7 +614,7 @@ static int meson_gpiolib_register(struct meson_pinctrl *pc)
 	pc->chip.set = meson_gpio_set;
 	pc->chip.base = -1;
 	pc->chip.ngpio = pc->data->num_pins;
-	pc->chip.can_sleep = false;
+	pc->chip.can_sleep = true;
 	pc->chip.of_node = pc->of_node;
 	pc->chip.of_gpio_n_cells = 2;
 
-- 
2.51.0


