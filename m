Return-Path: <stable+bounces-131489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB67AA80AE2
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 15:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91BC5501A72
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF7526F477;
	Tue,  8 Apr 2025 12:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hvP+ezuj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC8C27CCCC;
	Tue,  8 Apr 2025 12:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116538; cv=none; b=Wu+HlR+CtH25gnl4PYSkqWnkIHFqTxsm2M8n3gAoaf+0oUdX5cnVbM3gbrE6c44zdvBFu2KwmkIUjc2SIJWasHEqlW3djOK391GX0b9WAqezjZEAhSyEAX3Nio8Ar1F3u44LrOSWiNAmeX2Jm9JPuwl4JQvKTNiQrJdAlQTSUZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116538; c=relaxed/simple;
	bh=KOHqlIkzrJ/VKtscOdUBOSxSZHJ37zGobkBq390GNc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OBrwgDPDgVOPTHMT2W2GCxQWbXBWrjW8G4rBMHKdZN45UKaduGZajCMlJeb58wkXxdn0gOd6qZs64WO+O0jmq5shBfi4/MAbB6vI9wcUPV0ya1d5hI5wpbIIxY/uAI/ltI8sNO/+7R+wVF+4yih+hJHcS3eOM9lthO36A3t/DTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hvP+ezuj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79EE2C4CEEA;
	Tue,  8 Apr 2025 12:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744116537;
	bh=KOHqlIkzrJ/VKtscOdUBOSxSZHJ37zGobkBq390GNc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hvP+ezuj/K2OGBIJHrI9iG78prvc30k1gz7rOYLgMIZDv5x/rGaN4gO4aDgM3jrH/
	 HFc7kbJQ5KEEVSEch+td4Zg47z/UmkGCJGTjMsgpOVwmOt/g3f5LB5Wj6LaICZbHrn
	 CRp+6UmYoQanf8R7lyKDXQqWFn86IW4BmKZ5Kr+w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Sicelo A. Mhlongo" <absicsz@gmail.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 136/423] power: supply: bq27xxx_battery: do not update cached flags prematurely
Date: Tue,  8 Apr 2025 12:47:42 +0200
Message-ID: <20250408104848.894647456@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104845.675475678@linuxfoundation.org>
References: <20250408104845.675475678@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sicelo A. Mhlongo <absicsz@gmail.com>

[ Upstream commit 45291874a762dbb12a619dc2efaf84598859007a ]

Commit 243f8ffc883a1 ("power: supply: bq27xxx_battery: Notify also about
status changes") intended to notify userspace when the status changes,
based on the flags register. However, the cached state is updated too
early, before the flags are tested for any changes. Remove the premature
update.

Fixes: 243f8ffc883a1 ("power: supply: bq27xxx_battery: Notify also about status changes")
Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
Link: https://lore.kernel.org/r/20241125152945.47937-1-absicsz@gmail.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/bq27xxx_battery.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 51fb88aca0f9f..1a20c775489c7 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1913,7 +1913,6 @@ static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
 		cache.flags = -1; /* read error */
 	if (cache.flags >= 0) {
 		cache.capacity = bq27xxx_battery_read_soc(di);
-		di->cache.flags = cache.flags;
 
 		/*
 		 * On gauges with signed current reporting the current must be
-- 
2.39.5




