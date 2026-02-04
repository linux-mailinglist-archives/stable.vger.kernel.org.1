Return-Path: <stable+bounces-214152-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHs8K2hsg2l+mgMAu9opvQ
	(envelope-from <stable+bounces-214152-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:57:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B02DE9A8B
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BBA1302801C
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35194219E2;
	Wed,  4 Feb 2026 15:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Eh/Gaa5R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7723241C309;
	Wed,  4 Feb 2026 15:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218737; cv=none; b=WfLi3h1FopTFRiQDDEwN11HQ81rzt2n6rmknrfA66iVR9e4KeHO7eeu7K5IDa/DD6zgpONh3HWAv/zZ78Kx2t6N4RYm0jR0KVoWKw4jPXeQ4nuGqolAf9Qa3JQZe0D99JmK4rz9hGnT6iu8xipGrv0AyiJ+7R0fNP70vzLD7b5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218737; c=relaxed/simple;
	bh=IbopASy/KkGpKHzXtlkKLg/cTtQEkEQSkAO4oETwdeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hp5LM0GRwBi3CjbKY8QK/MZnDh/85kkGELLCiKaiKTFaY20klNAyM6NqrgE3t8aArflzBMr06OY4j5nAsZJEDjdlNDMX1jt0ZuuH05/XKublaakGPI/wKzj1nJtqTY6Cvy/rjroKsXGivmu9ncRPF6QP2LkhM0QIiiF00QXbDgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Eh/Gaa5R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE3AC4CEF7;
	Wed,  4 Feb 2026 15:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770218737;
	bh=IbopASy/KkGpKHzXtlkKLg/cTtQEkEQSkAO4oETwdeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Eh/Gaa5R57b4o7TCCL4630cHF2bnG3ayYlBzP79jpBKDq+3tmX34R56fZfUNVQwvl
	 tSalG9ahgFKPCoN0nSjhUaO0wsvolyjH/VK/dK6J/tkXNvQwYbo+At2c9ywnOAoiwo
	 w6YaPUXXEB0MoNmlBvHX4hGCW5jrLxENrl5UqXcQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heiko Stuebner <heiko@sntech.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH 6.12 45/87] gpio: rockchip: Stop calling pinctrl for set_direction
Date: Wed,  4 Feb 2026 15:40:43 +0100
Message-ID: <20260204143848.536194801@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143846.906385641@linuxfoundation.org>
References: <20260204143846.906385641@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-214152-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sntech.de:email,qualcomm.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,arm.com:email]
X-Rspamd-Queue-Id: 0B02DE9A8B
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robin Murphy <robin.murphy@arm.com>

commit 7ca497be00163610afb663867db24ac408752f13 upstream.

Marking the whole controller as sleeping due to the pinctrl calls in the
.direction_{input,output} callbacks has the unfortunate side effect that
legitimate invocations of .get and .set, which cannot themselves sleep,
in atomic context now spew WARN()s from gpiolib.

However, as Heiko points out, the driver doing this is a bit silly to
begin with, as the pinctrl .gpio_set_direction hook doesn't even care
about the direction, the hook is only used to claim the mux. And sure
enough, the .gpio_request_enable hook exists to serve this very purpose,
so switch to that and remove the problematic business entirely.

Cc: stable@vger.kernel.org
Fixes: 20cf2aed89ac ("gpio: rockchip: mark the GPIO controller as sleeping")
Suggested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Link: https://lore.kernel.org/r/bddc0469f25843ca5ae0cf578ab3671435ae98a7.1769429546.git.robin.murphy@arm.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpio-rockchip.c       |    8 --------
 drivers/pinctrl/pinctrl-rockchip.c |    9 ++++-----
 2 files changed, 4 insertions(+), 13 deletions(-)

--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -18,7 +18,6 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/pinctrl/consumer.h>
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
@@ -157,12 +156,6 @@ static int rockchip_gpio_set_direction(s
 	unsigned long flags;
 	u32 data = input ? 0 : 1;
 
-
-	if (input)
-		pinctrl_gpio_direction_input(chip, offset);
-	else
-		pinctrl_gpio_direction_output(chip, offset);
-
 	raw_spin_lock_irqsave(&bank->slock, flags);
 	rockchip_gpio_writel_bit(bank, offset, data, bank->gpio_regs->port_ddr);
 	raw_spin_unlock_irqrestore(&bank->slock, flags);
@@ -584,7 +577,6 @@ static int rockchip_gpiolib_register(str
 	gc->ngpio = bank->nr_pins;
 	gc->label = bank->name;
 	gc->parent = bank->dev;
-	gc->can_sleep = true;
 
 	ret = gpiochip_add_data(gc, bank);
 	if (ret) {
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -2922,10 +2922,9 @@ static int rockchip_pmx_set(struct pinct
 	return 0;
 }
 
-static int rockchip_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
-					   struct pinctrl_gpio_range *range,
-					   unsigned offset,
-					   bool input)
+static int rockchip_pmx_gpio_request_enable(struct pinctrl_dev *pctldev,
+					    struct pinctrl_gpio_range *range,
+					    unsigned int offset)
 {
 	struct rockchip_pinctrl *info = pinctrl_dev_get_drvdata(pctldev);
 	struct rockchip_pin_bank *bank;
@@ -2939,7 +2938,7 @@ static const struct pinmux_ops rockchip_
 	.get_function_name	= rockchip_pmx_get_func_name,
 	.get_function_groups	= rockchip_pmx_get_groups,
 	.set_mux		= rockchip_pmx_set,
-	.gpio_set_direction	= rockchip_pmx_gpio_set_direction,
+	.gpio_request_enable	= rockchip_pmx_gpio_request_enable,
 };
 
 /*



