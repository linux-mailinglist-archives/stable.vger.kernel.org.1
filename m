Return-Path: <stable+bounces-205860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BACCFA43E
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 19:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52C2534074ED
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 18:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D44A369238;
	Tue,  6 Jan 2026 17:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RrXFIJcK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A9336922C;
	Tue,  6 Jan 2026 17:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767722101; cv=none; b=cONv36khTEEyJqopK8zgOOm3MMkpRO3jM8SfID/PMr0yShmvKxRTw7c/3n4V+Ov3dTF1mvZJUw8vGHGiznbu5NYD7iA5BQVeAnGQ1hYKPWp7+vRNBkVssyR11eRdPRpLI+rrskAlBqjdHavnp2SKuh26DTejFVIdOUJbNuuyid4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767722101; c=relaxed/simple;
	bh=X3BO74iTV7aKEb4EvdobQYv2tyuqNry7rHFTw9gKy4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oBgH481HF54TLsEknhFJ1tejgLMEuoL5wcLk0zeLZHi+M4h/ZRti1/QF2Xv6TjUyd7K9l1VEX+tYV334NjLN3ipxGDUTlPGKA4TBP+2gAZPN8n6vfJ++WkVXhouX4kCeXvYkpubzSJMomvX1k8MkBYG4VjJAIkH1Y5zfwM7S8Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RrXFIJcK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C76C19424;
	Tue,  6 Jan 2026 17:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767722101;
	bh=X3BO74iTV7aKEb4EvdobQYv2tyuqNry7rHFTw9gKy4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RrXFIJcKnVyv8croRvUTueF1iKAjkaUUWyt5lfQD10rDXWrELLWIKdKE6yvlDPsNw
	 xSuLIdFmlOt6LMMhJEy6RrCAhft3uUESUT/EzqJE4BSjqyf1zrOLTRgcV26yrar8I+
	 KQFV9QVxRRvAr/xXGVH3Qgu8gftaMvHtAoUMLJlk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christian Hitz <christian.hitz@bbv.ch>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH 6.18 132/312] leds: leds-lp50xx: Allow LED 0 to be added to module bank
Date: Tue,  6 Jan 2026 18:03:26 +0100
Message-ID: <20260106170552.618459065@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106170547.832845344@linuxfoundation.org>
References: <20260106170547.832845344@linuxfoundation.org>
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

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Hitz <christian.hitz@bbv.ch>

commit 26fe74d598c32e7bc6f150edfc4aa43e1bee55db upstream.

led_banks contains LED module number(s) that should be grouped into the
module bank. led_banks is 0-initialized.
By checking the led_banks entries for 0, un-set entries are detected.
But a 0-entry also indicates that LED module 0 should be grouped into the
module bank.

By only iterating over the available entries no check for unused entries
is required and LED module 0 can be added to bank.

Cc: stable@vger.kernel.org
Fixes: 242b81170fb8 ("leds: lp50xx: Add the LP50XX family of the RGB LED driver")
Signed-off-by: Christian Hitz <christian.hitz@bbv.ch>
Reviewed-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Link: https://patch.msgid.link/20251008123222.1117331-1-christian@klarinett.li
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/leds/leds-lp50xx.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

--- a/drivers/leds/leds-lp50xx.c
+++ b/drivers/leds/leds-lp50xx.c
@@ -341,17 +341,15 @@ out:
 	return ret;
 }
 
-static int lp50xx_set_banks(struct lp50xx *priv, u32 led_banks[])
+static int lp50xx_set_banks(struct lp50xx *priv, u32 led_banks[], int num_leds)
 {
 	u8 led_config_lo, led_config_hi;
 	u32 bank_enable_mask = 0;
 	int ret;
 	int i;
 
-	for (i = 0; i < priv->chip_info->max_modules; i++) {
-		if (led_banks[i])
-			bank_enable_mask |= (1 << led_banks[i]);
-	}
+	for (i = 0; i < num_leds; i++)
+		bank_enable_mask |= (1 << led_banks[i]);
 
 	led_config_lo = bank_enable_mask;
 	led_config_hi = bank_enable_mask >> 8;
@@ -405,7 +403,7 @@ static int lp50xx_probe_leds(struct fwno
 			return ret;
 		}
 
-		ret = lp50xx_set_banks(priv, led_banks);
+		ret = lp50xx_set_banks(priv, led_banks, num_leds);
 		if (ret) {
 			dev_err(priv->dev, "Cannot setup banked LEDs\n");
 			return ret;



