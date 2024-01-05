Return-Path: <stable+bounces-9809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAB0825586
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 15:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 568401F23C5D
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 14:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6482C692;
	Fri,  5 Jan 2024 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eoJUkANj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA212D051;
	Fri,  5 Jan 2024 14:39:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C530DC433C7;
	Fri,  5 Jan 2024 14:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704465585;
	bh=SO30nGvxqJwXkpOSYQZNbT6ocwbyojX8bK66nRrlnCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eoJUkANj2dZ2Jt2XRVN00lxXaySy92WmUFNO2Mik7520Ff+GGOpiFHdV0YmREaQIT
	 gQybdAQvUgtcjrq0mHiYqDNMPzG7nEm6+p4odVvWE2khY2BEu0UxEF5Y0WQ+WGcJ8R
	 naM/QQshyeIzWGyCKPsereVT2N0mMj9ffZPXsWWc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rouven Czerwinski <r.czerwinski@pengutronix.de>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.14 19/21] net: rfkill: gpio: set GPIO direction
Date: Fri,  5 Jan 2024 15:39:06 +0100
Message-ID: <20240105143812.394635143@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240105143811.536282337@linuxfoundation.org>
References: <20240105143811.536282337@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rouven Czerwinski <r.czerwinski@pengutronix.de>

commit 23484d817082c3005252d8edfc8292c8a1006b5b upstream.

Fix the undefined usage of the GPIO consumer API after retrieving the
GPIO description with GPIO_ASIS. The API documentation mentions that
GPIO_ASIS won't set a GPIO direction and requires the user to set a
direction before using the GPIO.

This can be confirmed on i.MX6 hardware, where rfkill-gpio is no longer
able to enabled/disable a device, presumably because the GPIO controller
was never configured for the output direction.

Fixes: b2f750c3a80b ("net: rfkill: gpio: prevent value glitch during probe")
Cc: stable@vger.kernel.org
Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>
Link: https://msgid.link/20231207075835.3091694-1-r.czerwinski@pengutronix.de
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rfkill/rfkill-gpio.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -129,6 +129,14 @@ static int rfkill_gpio_probe(struct plat
 		return -EINVAL;
 	}
 
+	ret = gpiod_direction_output(rfkill->reset_gpio, true);
+	if (ret)
+		return ret;
+
+	ret = gpiod_direction_output(rfkill->shutdown_gpio, true);
+	if (ret)
+		return ret;
+
 	rfkill->rfkill_dev = rfkill_alloc(rfkill->name, &pdev->dev,
 					  rfkill->type, &rfkill_gpio_ops,
 					  rfkill);



