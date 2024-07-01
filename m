Return-Path: <stable+bounces-56220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5997C91DFB9
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 14:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15CFD283C06
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 12:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9205E15AAD5;
	Mon,  1 Jul 2024 12:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uX7yYWn3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5151F15B0F2
	for <stable@vger.kernel.org>; Mon,  1 Jul 2024 12:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719837923; cv=none; b=PMJwiaK0rMtCGhVCxA+t2IkwZkp4WuzmxxPwEThaQoXFIVsp+TC/U/LaD7ZiFUWxaLdbcKF4mOkL4w991w5/8mXv/W+5e9vWDmX/8DxbatyIcMrhPvpqI2c4KCGQma3/TzSB5XH5MdkUDJ5po39h4y8VlbIGuFhggJ0qUn2NxRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719837923; c=relaxed/simple;
	bh=1Jj8oZg9lG/6R+eRp+h/untgSTf2b+2fQ3PQmHXxwtQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=k5wlylDspiCwgYaUMfJ8I2GGi+FCm88qhGFx9sdo7ZlXTjPaz3DmJj1TM4wtTnKEwTp2ZZRtRWYQeuYyi6gmxlDRQsM8IL+IuWN+wRG8sNt7OFktjUk2SKf6mSEs8B+vxOjFE4Yu7V2obg76cW1G80Cp0exQjFY1Cc5eT2si4IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uX7yYWn3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB26CC32786;
	Mon,  1 Jul 2024 12:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719837923;
	bh=1Jj8oZg9lG/6R+eRp+h/untgSTf2b+2fQ3PQmHXxwtQ=;
	h=Subject:To:Cc:From:Date:From;
	b=uX7yYWn3ChUJtwnPQLZdtUkV+B7Tvy1+02nvT16KBCsEm2BnXV7yK/g9RVV9jw/fC
	 kv2/kQCCkNe5zF/rW/0QOTV+xo7j5lqJ6uU03EMXmBvLoOr3rjwQHHHvS/9nYRx1Na
	 56auDR3ABPA461JR93ydP+1Tx5YU1BNIbL3HaIGI=
Subject: FAILED: patch "[PATCH] pinctrl: qcom: spmi-gpio: drop broken pm8008 support" failed to apply to 5.15-stable tree
To: johan+linaro@kernel.org,bryan.odonoghue@linaro.org,linus.walleij@linaro.org,swboyd@chromium.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 01 Jul 2024 14:28:04 +0200
Message-ID: <2024070103-sitter-headscarf-8dcb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 8da86499d4cd125a9561f9cd1de7fba99b0aecbf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024070103-sitter-headscarf-8dcb@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

8da86499d4cd ("pinctrl: qcom: spmi-gpio: drop broken pm8008 support")
f347438356e1 ("pinctrl: qcom-pmic-gpio: Add support for pm8019")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8da86499d4cd125a9561f9cd1de7fba99b0aecbf Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Wed, 29 May 2024 18:29:52 +0200
Subject: [PATCH] pinctrl: qcom: spmi-gpio: drop broken pm8008 support

The SPMI GPIO driver assumes that the parent device is an SPMI device
and accesses random data when backcasting the parent struct device
pointer for non-SPMI devices.

Fortunately this does not seem to cause any issues currently when the
parent device is an I2C client like the PM8008, but this could change if
the structures are reorganised (e.g. using structure randomisation).

Notably the interrupt implementation is also broken for non-SPMI devices.

Also note that the two GPIO pins on PM8008 are used for interrupts and
reset so their practical use should be limited.

Drop the broken GPIO support for PM8008 for now.

Fixes: ea119e5a482a ("pinctrl: qcom-pmic-gpio: Add support for pm8008")
Cc: stable@vger.kernel.org	# 5.13
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20240529162958.18081-9-johan+linaro@kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index 4e80c7204e5f..4abd6f18bbef 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -1207,7 +1207,6 @@ static const struct of_device_id pmic_gpio_of_match[] = {
 	{ .compatible = "qcom,pm7325-gpio", .data = (void *) 10 },
 	{ .compatible = "qcom,pm7550ba-gpio", .data = (void *) 8},
 	{ .compatible = "qcom,pm8005-gpio", .data = (void *) 4 },
-	{ .compatible = "qcom,pm8008-gpio", .data = (void *) 2 },
 	{ .compatible = "qcom,pm8019-gpio", .data = (void *) 6 },
 	/* pm8150 has 10 GPIOs with holes on 2, 5, 7 and 8 */
 	{ .compatible = "qcom,pm8150-gpio", .data = (void *) 10 },


