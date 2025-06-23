Return-Path: <stable+bounces-156250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 881F0AE4ECB
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24F57173167
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241261F582A;
	Mon, 23 Jun 2025 21:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dv0oCJHt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68D970838;
	Mon, 23 Jun 2025 21:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750712950; cv=none; b=EUhu+oLbEp5n4XAUhuxf6Q/T/V2FNJy+ImNV4xyI9cp+070ybBjGrnJF3bxDUJFn7+hUE5T1BbegF6STQE3Zhf9HgDVmn/NDMfhpaDvwSYGsk+3rFoQtmZdK3wp9OS0hfRY+VcBmZ6gw6g09x1wXpltx5IXXTnAosxjM/NPeaVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750712950; c=relaxed/simple;
	bh=7d96rNN7EYP/72DaBLl9FroGPqEwFxdenMgdhc58U5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gUZfEK2oyExyn56xXzR5/LxKo9/FLnADoswyTbGGoMy2OUYvRvHO6QyumpAQwx5VVMzJSjtscXGbplJbe06QzT1WfymkWhiLiyPDF5WKk9c/skFq+5Uy80AueceL6Kysu5GYfuQi9z5sp2qW2zzcL3BHdMw58QT4NiXQGGy8fmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dv0oCJHt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47576C4CEEA;
	Mon, 23 Jun 2025 21:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750712950;
	bh=7d96rNN7EYP/72DaBLl9FroGPqEwFxdenMgdhc58U5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dv0oCJHtS1L3ER2wFeLpnu9S878AuG/fzNHR2LqZ0Rg6g4PAiEIFLrZmOm3LQ/qye
	 w6eRrB6o5pI8BTCbvlsqS/yJmCOW8BHMCXSxoi/3yBw0cKPEo2BWJRGwhVnjEvfWop
	 Goz/Qw9N3qUVkJXj2Gzd4tJbjsNVKWoGEmEebxuw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.12 020/414] regulator: max20086: Change enable gpio to optional
Date: Mon, 23 Jun 2025 15:02:37 +0200
Message-ID: <20250623130642.530818080@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130642.015559452@linuxfoundation.org>
References: <20250623130642.015559452@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

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
@@ -264,7 +264,7 @@ static int max20086_i2c_probe(struct i2c
 	 * shutdown.
 	 */
 	flags = boot_on ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
-	chip->ena_gpiod = devm_gpiod_get(chip->dev, "enable", flags);
+	chip->ena_gpiod = devm_gpiod_get_optional(chip->dev, "enable", flags);
 	if (IS_ERR(chip->ena_gpiod)) {
 		ret = PTR_ERR(chip->ena_gpiod);
 		dev_err(chip->dev, "Failed to get enable GPIO: %d\n", ret);



