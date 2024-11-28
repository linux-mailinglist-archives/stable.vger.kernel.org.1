Return-Path: <stable+bounces-95712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD579DB83C
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 14:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33098281866
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 13:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81196194141;
	Thu, 28 Nov 2024 13:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iw/Oic6t"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05FC7C6E6;
	Thu, 28 Nov 2024 13:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732799217; cv=none; b=pyxek8odCZAsw6fc+7S4WIK2WOlnLBfmGFCz9dwDNgX0HJV/rLsBX4Wbi0BiUPvesTlr3QciTmIHigZcQ1xp1JU/VrPWW4SVTIJZDRV4Y1N+jqyBq0B0IP7/9PdgugL2ppJPH+MC0YM6cl+W1o+lfnNTy+v68LXbbPxbTVwyxTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732799217; c=relaxed/simple;
	bh=BuHu7HS5eQbJs0yyrvIPrMoFQvS5iXwjDgXC5Qla4ek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZDJLxzoUwYG4BXOaghk/CyunQlGSi5jHjBMPM6FM1LPdjqu2WmJBLnaVWCpWp4BuEOa5/L2HPPWElvHTulciE8abl00mFzDlRZMPQt/A9znPeqEXzd3Igun/uWfTn3j/FS+4BO+KStJAvS5u+XCVCuaMLtxk97Swl+bnNeT5+gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iw/Oic6t; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53df80eeeedso480803e87.2;
        Thu, 28 Nov 2024 05:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732799214; x=1733404014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4pecdx7iLRTMGA/YU3lk9AOC6tsB/PZQe/CXuIrAoic=;
        b=Iw/Oic6tR+kF8Dl5bs+d1w7EaxZnpfrhfHS47SbeXgqxN0iwqeyb2LKezhw5LKWpB6
         vQJoxIUgI1tSBO/UubaWMbHuxLjEtdK/0SuuhyLbuBlyUjwTm457P2xtTOlgLkvUuSbc
         dyDd+hP6aLNuLsQ2hLTde1KaXg0rF/rX8KWPrLrUAF7XFLR1yh+hguMe/b2R2YC5ON35
         f4SN74qTeqcNt1u8feOflMWIn/aYrch0ve6MQtsDx1NXxxKspwJdq03SI99EZ2R/OFmY
         2Ap/K1TCuZZyxemArs6awRTBaNkimIbO6HeoB8Owhwyky3hkbKYwCD38WzsJbMxbkkBN
         RfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732799214; x=1733404014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4pecdx7iLRTMGA/YU3lk9AOC6tsB/PZQe/CXuIrAoic=;
        b=tB/4WqIFhoJcZ93VXNZB+nTs/5LIEc0Uiqesh7PMUSHBlBivuIlnHRN/P9ra054DYe
         9rTXuyBq5rZNUFZZ7aQLMplrC0F0D1Dyqiz5T0f6BjAC1ZZSNnUTAsl0lO0EXihXA8V3
         KxQdORqXaMKk6TuC9n3mB3I3JaGzVA694OaHe6KoaOjLvNH2WpG2euD9o0h71elH9Mi9
         flxMviuJxnvoDLdiNWtSbfYRizheK9vOAvGMF8uqHhlCyOdJS5m2S5SOElmVLEVCug+E
         NXxDXQG82YREC+sUOuvAZzeXsshdw32Nw5syunbsD1yoF4jT+5DpXSdn1vMXXErNXvP7
         sCAg==
X-Forwarded-Encrypted: i=1; AJvYcCU1yUvWoud6JbtG3ts0FJFHy4RJnT4aPYsg2UtgN16gkbdn+eIAGVn3u7w9SvEt19gAeMiIy9n7mCy3QZM=@vger.kernel.org, AJvYcCW2YBggd6anqiLJGpM7bCeSmYrju/Obu3kUfIy/Lp3+/wxtmQL1pgWXmtAbBTFQnAYMgr8fI4vn@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmq+8cTqfcjkEWuSZWjFOBisk79zzQudD0IZSrswPfnIXJiZD6
	Trr6NuhP5cLiM1PS4kDsnnDaPL9/rpFyCL2Uk0M3TJ16YowlbbsDSKxYXg==
X-Gm-Gg: ASbGncvt1p8GoqkRb693lseQmvDYV5A3JqPuEKM1Aeqpg2Io5WVY8HMJv5mEDyB2nne
	8Jak/E7ws46mwjAuw6JLjnTTLm4Ujb0JXVhLwJZiLHpVY1U6XIA2FfF6AIvQpfiEE+x8ZIXX8ah
	evSXD+pDiiaE60+A0V6Ojodth/rZ0My746tH1/A04nQTyWJBYxUn6zOxGAsqHx6mojJV/F56UpW
	mW3tLUYjSNNCyZVAzKGpLgkYxpQTdBeLXfOsne4K0/OAUi51x1+CDi6dBf3F+I=
X-Google-Smtp-Source: AGHT+IG8Mt1z5relp2YwsWfZSIM1aJR+ASc//+cA67pyCuhas4mAr8sC3KWLybIbtOKHeOwavEikDA==
X-Received: by 2002:a05:6512:3b96:b0:539:ea49:d163 with SMTP id 2adb3069b0e04-53df00d2c4fmr3376081e87.21.1732799213418;
        Thu, 28 Nov 2024 05:06:53 -0800 (PST)
Received: from demon-pc.localdomain ([188.27.128.22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd370ebsm1631834f8f.43.2024.11.28.05.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 05:06:52 -0800 (PST)
From: Cosmin Tanislav <demonsingur@gmail.com>
To: 
Cc: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <demonsingur@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] regmap: detach regmap from dev on regmap_exit
Date: Thu, 28 Nov 2024 15:05:50 +0200
Message-ID: <20241128130554.362486-1-demonsingur@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At the end of __regmap_init(), if dev is not NULL, regmap_attach_dev()
is called, which adds a devres reference to the regmap, to be able to
retrieve a dev's regmap by name using dev_get_regmap().

When calling regmap_exit, the opposite does not happen, and the
reference is kept until the dev is detached.

Add a regmap_detach_dev() function, export it and call it in
regmap_exit(), to make sure that the devres reference is not kept.

Fixes: 72b39f6f2b5a ("regmap: Implement dev_get_regmap()")
Signed-off-by: Cosmin Tanislav <demonsingur@gmail.com>
---

V2:
 * switch to static function

V3:
 * move inter-version changelog after ---

 drivers/base/regmap/regmap.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 53131a7ede0a6..e3e2afc2c83c6 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -598,6 +598,17 @@ int regmap_attach_dev(struct device *dev, struct regmap *map,
 }
 EXPORT_SYMBOL_GPL(regmap_attach_dev);
 
+static int dev_get_regmap_match(struct device *dev, void *res, void *data);
+
+static int regmap_detach_dev(struct device *dev, struct regmap *map)
+{
+	if (!dev)
+		return 0;
+
+	return devres_release(dev, dev_get_regmap_release,
+			      dev_get_regmap_match, (void *)map->name);
+}
+
 static enum regmap_endian regmap_get_reg_endian(const struct regmap_bus *bus,
 					const struct regmap_config *config)
 {
@@ -1445,6 +1456,7 @@ void regmap_exit(struct regmap *map)
 {
 	struct regmap_async *async;
 
+	regmap_detach_dev(map->dev, map);
 	regcache_exit(map);
 
 	regmap_debugfs_exit(map);
-- 
2.47.0


