Return-Path: <stable+bounces-90355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A02039BE7E6
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 592311F24E89
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C28E1DF75A;
	Wed,  6 Nov 2024 12:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YTEx5g30"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486EF1DF27C;
	Wed,  6 Nov 2024 12:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730895526; cv=none; b=CGtPI+t4OsXDSfGSFOqDJUjPbMju6i2vS8E05oF3xnEEJ/QdfxFjIgU+xbl9zmw74LsH9HHYgb/KYc5S3whjyUyfbFxmXFyuW8TSP9io9pF84gMHVnFzehgqOUzbll8zXKFBuyAr6130ee6jUCVYA3R3iVQP2SLq5KgqQLY7Xus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730895526; c=relaxed/simple;
	bh=/vFXNICDyKzFLj9jQKUyuJp/VscH80P8VFXvSlVqNeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Owaacz2dffpDG05nUY02uPrPEgUJOAGZ72b4DyNrA3QBiFGNo/kKOSYme/HZ4oDCXySy0DuxwyAzcUz2ISnWhZN0dPzl72tt4LTQ5fiiJcl5QoarwWycD6hyUirpWjPA+jveMYFugyrXPko+0BmAWzKk7pU+V79X808vlRwNggY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YTEx5g30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABBAC4CECD;
	Wed,  6 Nov 2024 12:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730895526;
	bh=/vFXNICDyKzFLj9jQKUyuJp/VscH80P8VFXvSlVqNeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YTEx5g30hM8ikYlpX7Y2WsWtnnIhPjrOYetNR0+jBf7NZ8YGglb9cZlcjWmPEa9MT
	 v2n+6/5zNa4Clj3V3JTDq+Zk3bli//cTDqLKzqUxmmlhm9S3wLbvJEEWYtwtLFDUp9
	 JfrBut1dtYxlnQ7Pb1aEo69KV6dAypHz2RkKxa8w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nuno Sa <nuno.sa@analog.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.19 211/350] Input: adp5589-keys - fix adp5589_gpio_get_value()
Date: Wed,  6 Nov 2024 13:02:19 +0100
Message-ID: <20241106120326.204825960@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120320.865793091@linuxfoundation.org>
References: <20241106120320.865793091@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nuno Sa <nuno.sa@analog.com>

commit c684771630e64bc39bddffeb65dd8a6612a6b249 upstream.

The adp5589 seems to have the same behavior as similar devices as
explained in commit 910a9f5636f5 ("Input: adp5588-keys - get value from
data out when dir is out").

Basically, when the gpio is set as output we need to get the value from
ADP5589_GPO_DATA_OUT_A register instead of ADP5589_GPI_STATUS_A.

Fixes: 9d2e173644bb ("Input: ADP5589 - new driver for I2C Keypad Decoder and I/O Expander")
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Link: https://lore.kernel.org/r/20241001-b4-dev-adp5589-fw-conversion-v1-2-fca0149dfc47@analog.com
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/keyboard/adp5589-keys.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

--- a/drivers/input/keyboard/adp5589-keys.c
+++ b/drivers/input/keyboard/adp5589-keys.c
@@ -390,10 +390,17 @@ static int adp5589_gpio_get_value(struct
 	struct adp5589_kpad *kpad = gpiochip_get_data(chip);
 	unsigned int bank = kpad->var->bank(kpad->gpiomap[off]);
 	unsigned int bit = kpad->var->bit(kpad->gpiomap[off]);
+	int val;
 
-	return !!(adp5589_read(kpad->client,
-			       kpad->var->reg(ADP5589_GPI_STATUS_A) + bank) &
-			       bit);
+	mutex_lock(&kpad->gpio_lock);
+	if (kpad->dir[bank] & bit)
+		val = kpad->dat_out[bank];
+	else
+		val = adp5589_read(kpad->client,
+				   kpad->var->reg(ADP5589_GPI_STATUS_A) + bank);
+	mutex_unlock(&kpad->gpio_lock);
+
+	return !!(val & bit);
 }
 
 static void adp5589_gpio_set_value(struct gpio_chip *chip,



