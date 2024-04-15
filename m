Return-Path: <stable+bounces-39511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E78EB8A51EE
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 15:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4308285985
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 13:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A840C78C83;
	Mon, 15 Apr 2024 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7P1JN1r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690B87580D
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188337; cv=none; b=tcnDtjnLE/42qsY0VxwdO68AS9B3udo+n6dOKnBwGnCWm7Gs49fKT3shxAT3btzSWfywK5j1WgI+jEE+63lckKm3TQ/LxkdE54oG5bWCSNufpTSj9JohQDwvmPyJHLjZy0d32izdRc2dsqDVAmcaoE2kQsxAKrniu8pkuUkEU7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188337; c=relaxed/simple;
	bh=s4ZzsDVf+ymy+XTbUd0tXxyOR/Lnr9f52of9y/PyIs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ga1scV13NjzJlffbE4OSfbgN0XzL30DI+4iy8x3AvmGVRRguN1gO9DGdf6pV6Hs/4bHZrUtVTxlcD00T2PzCmuMixtVzs73URS8rYMx7R/ILpPHtKv7nlA581WFWsxLuU3LmB3vQ2eLYRO6EWnoWO0JAtO6PI2uEQ+Kkgbru9v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7P1JN1r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1601CC32783;
	Mon, 15 Apr 2024 13:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713188337;
	bh=s4ZzsDVf+ymy+XTbUd0tXxyOR/Lnr9f52of9y/PyIs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a7P1JN1rJzuIwdZ83g/XYmai1y4y1LuRitN/UsRYSUHypRJ0kKSdOJS+GWN/BzUau
	 Hmiro278NSNYe+rgq0Iw688xfHxxnuocRSy9N7dP93JtJNe3XMgVfNFLUDGsAcDuN5
	 +co6C9yjmKbaM8ld4sZX4995C51F1ZCmxzU94k+I8VpjYOUiq23tP+0O3HTHmVeAX5
	 ti2zo0PWa5Zau6XkUihu5SxLu6aBSdRanvLNn06IOue05rdZrkistUFRRziPz+J2xi
	 A42hIa+GA+rPle/EbuSGDHaRpPlnBNUbU0eHbGNyCXsLLVejVtqhwq328NS5kAusca
	 Ru2505iGksV5g==
From: Sasha Levin <sashal@kernel.org>
To: kernel-lts@openela.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	stable@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14-openela 034/190] ASoC: cs42l51: fix driver to properly autoload with automatic module loading
Date: Mon, 15 Apr 2024 06:49:24 -0400
Message-ID: <20240415105208.3137874-35-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415105208.3137874-1-sashal@kernel.org>
References: <20240415105208.3137874-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

[ Upstream commit e51df4f81b02bcdd828a04de7c1eb6a92988b61e ]

In commit 2cb1e0259f50 ("ASoC: cs42l51: re-hook of_match_table
pointer"), 9 years ago, some random guy fixed the cs42l51 after it was
split into a core part and an I2C part to properly match based on a
Device Tree compatible string.

However, the fix in this commit is wrong: the MODULE_DEVICE_TABLE(of,
....) is in the core part of the driver, not the I2C part. Therefore,
automatic module loading based on module.alias, based on matching with
the DT compatible string, loads the core part of the driver, but not
the I2C part. And threfore, the i2c_driver is not registered, and the
codec is not known to the system, nor matched with a DT node with the
corresponding compatible string.

In order to fix that, we move the MODULE_DEVICE_TABLE(of, ...) into
the I2C part of the driver. The cs42l51_of_match[] array is also moved
as well, as it is not possible to have this definition in one file,
and the MODULE_DEVICE_TABLE(of, ...) invocation in another file, due
to how MODULE_DEVICE_TABLE works.

Thanks to this commit, the I2C part of the driver now properly
autoloads, and thanks to its dependency on the core part, the core
part gets autoloaded as well, resulting in a functional sound card
without having to manually load kernel modules.

Fixes: 2cb1e0259f50 ("ASoC: cs42l51: re-hook of_match_table pointer")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Link: https://lore.kernel.org/r/20230713112112.778576-1-thomas.petazzoni@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs42l51-i2c.c | 6 ++++++
 sound/soc/codecs/cs42l51.c     | 7 -------
 sound/soc/codecs/cs42l51.h     | 1 -
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/cs42l51-i2c.c b/sound/soc/codecs/cs42l51-i2c.c
index 9bad478474fa3..5614378557d0c 100644
--- a/sound/soc/codecs/cs42l51-i2c.c
+++ b/sound/soc/codecs/cs42l51-i2c.c
@@ -23,6 +23,12 @@ static struct i2c_device_id cs42l51_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, cs42l51_i2c_id);
 
+const struct of_device_id cs42l51_of_match[] = {
+	{ .compatible = "cirrus,cs42l51", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, cs42l51_of_match);
+
 static int cs42l51_i2c_probe(struct i2c_client *i2c,
 			     const struct i2c_device_id *id)
 {
diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index f8072f1897d4c..b9de9836f2f4c 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -562,13 +562,6 @@ int cs42l51_probe(struct device *dev, struct regmap *regmap)
 }
 EXPORT_SYMBOL_GPL(cs42l51_probe);
 
-const struct of_device_id cs42l51_of_match[] = {
-	{ .compatible = "cirrus,cs42l51", },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, cs42l51_of_match);
-EXPORT_SYMBOL_GPL(cs42l51_of_match);
-
 MODULE_AUTHOR("Arnaud Patard <arnaud.patard@rtp-net.org>");
 MODULE_DESCRIPTION("Cirrus Logic CS42L51 ALSA SoC Codec Driver");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/cs42l51.h b/sound/soc/codecs/cs42l51.h
index 0ca805492ac4b..8c55bf384bc65 100644
--- a/sound/soc/codecs/cs42l51.h
+++ b/sound/soc/codecs/cs42l51.h
@@ -22,7 +22,6 @@ struct device;
 
 extern const struct regmap_config cs42l51_regmap;
 int cs42l51_probe(struct device *dev, struct regmap *regmap);
-extern const struct of_device_id cs42l51_of_match[];
 
 #define CS42L51_CHIP_ID			0x1B
 #define CS42L51_CHIP_REV_A		0x00
-- 
2.43.0


