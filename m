Return-Path: <stable+bounces-124008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E8DA5C8AA
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 274E23A6089
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0071F25F961;
	Tue, 11 Mar 2025 15:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Iu9dd08O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28F725E83C;
	Tue, 11 Mar 2025 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741707601; cv=none; b=PdN7+z6rpM8NiU00OUCL7X06ESc5zxVivt0MyvYTOYH+nVTnNOA0PVlEw6xlqKMupAOxy+7pDGuJT8sNj5boqZ5wZORQGNY9/mCW4pRmjrie7BTnT6WImj7X/dznnugj8l3ZsYvmfE/xPLu0P70L/WiAbkAHjPVVuo5cs8Z+z9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741707601; c=relaxed/simple;
	bh=AtWURd/FCtKQN8I4RheJSNgkLoWNxI1+IlBuzIDFjnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=buKYpq25W4WM/qybjTnqt0lRONdGc6s5q8AJPSCWGNNk2KolvVtwJcx/ZxsDfnL/HwucIy345h7yqrFwW0HxXUXfDCjiVtIPDKpTJDp1NUrw/EiQt9mc/wQuAJ3HV7GpjFxCQkyMLxyyHHQjN8wJn6r/mM5d1vMgnIo3vEVB8Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Iu9dd08O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33298C4CEEF;
	Tue, 11 Mar 2025 15:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741707601;
	bh=AtWURd/FCtKQN8I4RheJSNgkLoWNxI1+IlBuzIDFjnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Iu9dd08OmUSvPtWmdo0aPio9PeA9eZhSGDuTFVL3o8MagYAb5v4Xr+nlbFu1IZhHo
	 vKmU/b1FivG14Upsm294DHGxOSrEgrIvTsfWogYJNubXqn9HteW7OVqgMVLTBfzEDG
	 DEaV0oXH/FUo+hD82UDQrpMJ9vRXvmPDIVOHnJXQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 5.10 443/462] eeprom: digsy_mtc: Make GPIO lookup table match the device
Date: Tue, 11 Mar 2025 16:01:49 +0100
Message-ID: <20250311145815.830110607@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311145758.343076290@linuxfoundation.org>
References: <20250311145758.343076290@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

commit 038ef0754aae76f79b147b8867f9250e6a976872 upstream.

The dev_id value in the GPIO lookup table must match to
the device instance name, which in this case is combined
of name and platform device ID, i.e. "spi_gpio.1". But
the table assumed that there was no platform device ID
defined, which is wrong. Fix the dev_id value accordingly.

Fixes: 9b00bc7b901f ("spi: spi-gpio: Rewrite to use GPIO descriptors")
Cc: stable <stable@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20250206220311.1554075-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/eeprom/digsy_mtc_eeprom.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/misc/eeprom/digsy_mtc_eeprom.c
+++ b/drivers/misc/eeprom/digsy_mtc_eeprom.c
@@ -60,7 +60,7 @@ static struct platform_device digsy_mtc_
 };
 
 static struct gpiod_lookup_table eeprom_spi_gpiod_table = {
-	.dev_id         = "spi_gpio",
+	.dev_id         = "spi_gpio.1",
 	.table          = {
 		GPIO_LOOKUP("gpio@b00", GPIO_EEPROM_CLK,
 			    "sck", GPIO_ACTIVE_HIGH),



