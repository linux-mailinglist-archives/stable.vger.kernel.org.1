Return-Path: <stable+bounces-190386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A2ACDC104B5
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 19:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 321A04F8209
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 18:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C6A32A3C0;
	Mon, 27 Oct 2025 18:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GzAMIgNY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91407313546;
	Mon, 27 Oct 2025 18:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761591166; cv=none; b=njceYeNp67TV4NR74o/eCAcXCL0QE7chML+ImMFdqp/z9O7il4fGZGvAu0iLShh1HX/R2vP10Jr96hGhAbCY5FazAZyoS8V1DOueYUfjxu+0nU1qp/JqjPlTkiVKAhSgjF5lCMd79+Z30gI/viSMybC7VHmNE7fpGEDpg3W/5HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761591166; c=relaxed/simple;
	bh=wBuioW48iQplw+cYj1k2wFo5Pi6n3fTNcnhyNGzL7kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fuUTaLPpqvpkHyKdiYVzi/W/ZR1DnlAXfYIN6B1eIIfSmdnp6e0txwIbIe3yv9fL05sFL6o9tEvfvSPNelGHXA2S0ImkSnrjQYaWXVjRLCahdv78hZ9m2jw4ZaWicglK7TGZZOKPDtiWYchiFTiM7t6RXv3K+9Q3VyPXOM51/AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GzAMIgNY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBF2C4CEF1;
	Mon, 27 Oct 2025 18:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761591166;
	bh=wBuioW48iQplw+cYj1k2wFo5Pi6n3fTNcnhyNGzL7kU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GzAMIgNYhiuSXiuQjF3WXyoF9SJhgBj21k1y4ndgDvf7vgk19F0ZuCPkQlPeAww5l
	 f36mlqpP8UY9XjBx8niI2Cgq17VEHFo3cqfX+qvocsilGxtyip8nQAfqk5fLGK/jIe
	 uEV6ms8a6GZy/aX/w02v4vt8U8Y4Sl6AxGdFxQbk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marek Vasut <marek.vasut@mailbox.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5.10 092/332] Input: atmel_mxt_ts - allow reset GPIO to sleep
Date: Mon, 27 Oct 2025 19:32:25 +0100
Message-ID: <20251027183527.050937487@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251027183524.611456697@linuxfoundation.org>
References: <20251027183524.611456697@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Vasut <marek.vasut@mailbox.org>

commit c7866ee0a9ddd9789faadf58cdac6abd7aabf045 upstream.

The reset GPIO is not toggled in any critical section where it couldn't
sleep, allow the reset GPIO to sleep. This allows the driver to operate
reset GPIOs connected to I2C GPIO expanders.

Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
Link: https://lore.kernel.org/r/20251005023335.166483-1-marek.vasut@mailbox.org
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -3156,7 +3156,7 @@ static int mxt_probe(struct i2c_client *
 	if (data->reset_gpio) {
 		/* Wait a while and then de-assert the RESET GPIO line */
 		msleep(MXT_RESET_GPIO_TIME);
-		gpiod_set_value(data->reset_gpio, 0);
+		gpiod_set_value_cansleep(data->reset_gpio, 0);
 		msleep(MXT_RESET_INVALID_CHG);
 	}
 



