Return-Path: <stable+bounces-13080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9713837A6D
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 090DB1C23F18
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 00:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4F012C558;
	Tue, 23 Jan 2024 00:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nUCUh0eq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA38A12BF3D;
	Tue, 23 Jan 2024 00:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705968946; cv=none; b=HTid+12Z9tYZTRjznp+WEvwFNQLV6m/BPzjM+qrdAI+7m2bgLTvE5iOkPuJ+FKOKdMsvRRlBJ0pHCdLqSkERQVc2l82CUBmvJWyTzTYONeq7fBEDLNQCit4rqavSbwluLRIPeeQEvRKJBJdXFlQaW8rwxnmusHYe+4SKqocevbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705968946; c=relaxed/simple;
	bh=wBmWvs3cVxVI27qJ3ghhygCnHn9+lO2MyLp5VR6uhx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pYComVl1ZuTj3V2S9pIWlhA5ynBKVf03xs8BLzXkdJN+tAAs/4zFMBT7W7EPpJk1EiRIY6qw+OzoQll1XQkFA7aizWEuoTHcq2vvIcXY+q/qTv9RVVTlYAEall+nCW8RSIIBHQ+hT8l0uPX/KjWOsptDagvk8lVn3yADVNJIhwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nUCUh0eq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BBCEC433F1;
	Tue, 23 Jan 2024 00:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705968946;
	bh=wBmWvs3cVxVI27qJ3ghhygCnHn9+lO2MyLp5VR6uhx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nUCUh0eq4tdEjG/Ffi+bXnr0N6GqbcYWz1nBcHguYk7vOxtylQ3ZKs7Pi4+G3zUNn
	 akdzzwKpS8YFad/IBfJbgfYHgImZ2sqi905zzacUr6ZNuusA0++xMftT0NIFSErIXM
	 3SZGSkjrVIfZwdCzK/pj+Z87IwnKIQvwAhoaOXpw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 116/194] ASoC: cs35l33: Fix GPIO name and drop legacy include
Date: Mon, 22 Jan 2024 15:57:26 -0800
Message-ID: <20240122235724.209681630@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235719.206965081@linuxfoundation.org>
References: <20240122235719.206965081@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit 50678d339d670a92658e5538ebee30447c88ccb3 ]

This driver includes the legacy GPIO APIs <linux/gpio.h> and
<linux/of_gpio.h> but does not use any symbols from any of
them.

Drop the includes.

Further the driver is requesting "reset-gpios" rather than
just "reset" from the GPIO framework. This is wrong because
the gpiolib core will add "-gpios" before processing the
request from e.g. device tree. Drop the suffix.

The last problem means that the optional RESET GPIO has
never been properly retrieved and used even if it existed,
but nobody noticed.

Fixes: 3333cb7187b9 ("ASoC: cs35l33: Initial commit of the cs35l33 CODEC driver.")
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20231201-descriptors-sound-cirrus-v2-2-ee9f9d4655eb@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs35l33.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs35l33.c b/sound/soc/codecs/cs35l33.c
index 8894369e329a..87b299d24bd8 100644
--- a/sound/soc/codecs/cs35l33.c
+++ b/sound/soc/codecs/cs35l33.c
@@ -22,13 +22,11 @@
 #include <sound/soc-dapm.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
-#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <sound/cs35l33.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regulator/machine.h>
-#include <linux/of_gpio.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
@@ -1168,7 +1166,7 @@ static int cs35l33_i2c_probe(struct i2c_client *i2c_client,
 
 	/* We could issue !RST or skip it based on AMP topology */
 	cs35l33->reset_gpio = devm_gpiod_get_optional(&i2c_client->dev,
-			"reset-gpios", GPIOD_OUT_HIGH);
+			"reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(cs35l33->reset_gpio)) {
 		dev_err(&i2c_client->dev, "%s ERROR: Can't get reset GPIO\n",
 			__func__);
-- 
2.43.0




