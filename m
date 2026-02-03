Return-Path: <stable+bounces-213210-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HKrCXLugWlAMwMAu9opvQ
	(envelope-from <stable+bounces-213210-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 13:47:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFD2D947F
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 13:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD286308C796
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 12:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A56345753;
	Tue,  3 Feb 2026 12:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dGJIm+jP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF98344DA7
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 12:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770122760; cv=none; b=Eehkpu8SP//g8x9yMwi0qpLXMdn+ziBzZ/Yvbk+7IlMxbHifckiBsjaygb2hTjjK7WdByeU6872/EDG1yYAiNRNZbKQy/IfBHQE7fmY1Isa39dKNKbt725WRCBoC5kF7fh00qDbwMFNfw8Jf6N2SIovGKYD15/qsNzCoLHkNGVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770122760; c=relaxed/simple;
	bh=DwpvwzjcirVEOjZ7XV2pnVv/Wx7joSm/oQ6nugjLe3g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QMW8LC+1I7S0cQlv7w2Lc6wGI/uoAxFyTSZdtBJCvtWvSXZnHDuXKzE3Tqyd1tsyOTEd828uJoA1HpOc8TF3j2RAlkqTDbWPEPTarlalfVYBDADiBfodVuKqKJzvamDJzpifEh5gU87QBBKM3R/5u33WmFcFrrMadPV9OCzuBwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dGJIm+jP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB49C116D0;
	Tue,  3 Feb 2026 12:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770122760;
	bh=DwpvwzjcirVEOjZ7XV2pnVv/Wx7joSm/oQ6nugjLe3g=;
	h=Subject:To:Cc:From:Date:From;
	b=dGJIm+jP5sZBAOyy0cPXLf283V8tiWaEEErxwh8f3O4ri0U8OPzcpbEnlUMhIJATW
	 hDbIobbBeI/LM3PjBbBb2eenySZ1zkiKb1eR9GplgsP9+o5TRYNVsYFxYycpVfpwQi
	 eyfZ4ORkKF3R4PZ/NPJpIL9p3c8LqqVHwp1186G4=
Subject: FAILED: patch "[PATCH] gpio: rockchip: Stop calling pinctrl for set_direction" failed to apply to 6.1-stable tree
To: robin.murphy@arm.com,bartosz.golaszewski@oss.qualcomm.com,heiko@sntech.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Feb 2026 13:45:49 +0100
Message-ID: <2026020349-sappy-astonish-f077@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213210-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,linuxfoundation.org:dkim,gregkh:email,sntech.de:email,arm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ACFD2D947F
X-Rspamd-Action: no action


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 7ca497be00163610afb663867db24ac408752f13
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026020349-sappy-astonish-f077@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7ca497be00163610afb663867db24ac408752f13 Mon Sep 17 00:00:00 2001
From: Robin Murphy <robin.murphy@arm.com>
Date: Mon, 26 Jan 2026 12:12:26 +0000
Subject: [PATCH] gpio: rockchip: Stop calling pinctrl for set_direction

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

diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index bae2061f15fc..0fff4a699f12 100644
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
@@ -164,12 +163,6 @@ static int rockchip_gpio_set_direction(struct gpio_chip *chip,
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
@@ -593,7 +586,6 @@ static int rockchip_gpiolib_register(struct rockchip_pin_bank *bank)
 	gc->ngpio = bank->nr_pins;
 	gc->label = bank->name;
 	gc->parent = bank->dev;
-	gc->can_sleep = true;
 
 	ret = gpiochip_add_data(gc, bank);
 	if (ret) {
diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index e44ef262beec..2fc67aeafdb3 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -3545,10 +3545,9 @@ static int rockchip_pmx_set(struct pinctrl_dev *pctldev, unsigned selector,
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
@@ -3562,7 +3561,7 @@ static const struct pinmux_ops rockchip_pmx_ops = {
 	.get_function_name	= rockchip_pmx_get_func_name,
 	.get_function_groups	= rockchip_pmx_get_groups,
 	.set_mux		= rockchip_pmx_set,
-	.gpio_set_direction	= rockchip_pmx_gpio_set_direction,
+	.gpio_request_enable	= rockchip_pmx_gpio_request_enable,
 };
 
 /*


