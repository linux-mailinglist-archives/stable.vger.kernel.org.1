Return-Path: <stable+bounces-157637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E3CAE54EA
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83E3A4A02A9
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0A6221DA8;
	Mon, 23 Jun 2025 22:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sniDkF7o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC5B1E87B;
	Mon, 23 Jun 2025 22:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750716355; cv=none; b=N59vrnsrEXLrHNe7mMQnt3GC4Hjhg4L0/ILnTmnZYV2cP+q0m37L8+8KoOIWhwa8bsaorfq0+fO7R4owFE2r7K7gqwYmyb+MMf/W2kpW/kI4UE7rWy8WXUv0ekm0IyJhDHZmxBemJvMNeWwY/g8RJxRj0igYxGplY6pJUfCpPgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750716355; c=relaxed/simple;
	bh=8lqCfUSj7nVDlzM39vJfuetBrwh98O/7K76cPf5EPOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mHSEFlE8PU+UWpy4Su51dF89sJGgIBu1HdlMsayERXh8847BMA1KoAPFfTJ9aPxRRvc9lm36hzphuqlSj+QeMOo+RmG8gM5UmPffIbxJSelSTPSf0F9O/VJHGLtg7aVWilMXklRYSXAl5vF6BipoNMJqZO4fVEGXKZfT2eXw0TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sniDkF7o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C727AC4CEEA;
	Mon, 23 Jun 2025 22:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750716355;
	bh=8lqCfUSj7nVDlzM39vJfuetBrwh98O/7K76cPf5EPOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sniDkF7oUSEHXv6cvxALTq+/vgtRx9NUWwPdXBUEoHa8KsNT/GvRld92EsTOUHMlJ
	 o1iAUAbhk8Ihuq68NY+JTmmY3aSVh/cKHCB7xQ3tpUbzQ27PLyXPGw8+9fuiHJ4QgF
	 gD215QKYng7W7evRSbArlOgTAgTeF8O9CIcDlX6g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.1 297/508] regulator: max20086: Change enable gpio to optional
Date: Mon, 23 Jun 2025 15:05:42 +0200
Message-ID: <20250623130652.601212670@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130645.255320792@linuxfoundation.org>
References: <20250623130645.255320792@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>

commit e8ac7336dd62f0443a675ed80b17f0f0e6846e20 upstream.

The enable pin can be configured as always enabled by the hardware. Make
the enable gpio request optional so the driver doesn't fail to probe
when `enable-gpios` property is not present in the device tree.

Cc: stable@vger.kernel.org
Fixes: bfff546aae50 ("regulator: Add MAX20086-MAX20089 driver")
Signed-off-by: João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>
Link: https://patch.msgid.link/20250420-fix-max20086-v1-2-8cc9ee0d5a08@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/regulator/max20086-regulator.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/regulator/max20086-regulator.c
+++ b/drivers/regulator/max20086-regulator.c
@@ -265,7 +265,7 @@ static int max20086_i2c_probe(struct i2c
 	 * shutdown.
 	 */
 	flags = boot_on ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
-	chip->ena_gpiod = devm_gpiod_get(chip->dev, "enable", flags);
+	chip->ena_gpiod = devm_gpiod_get_optional(chip->dev, "enable", flags);
 	if (IS_ERR(chip->ena_gpiod)) {
 		ret = PTR_ERR(chip->ena_gpiod);
 		dev_err(chip->dev, "Failed to get enable GPIO: %d\n", ret);



