Return-Path: <stable+bounces-13684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 438DC837D67
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF29B287D12
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8102F5B1F3;
	Tue, 23 Jan 2024 00:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ovrVYAIc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418C652F7C;
	Tue, 23 Jan 2024 00:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969927; cv=none; b=ZgN4RHPXz8V9bJ9/Szk7PURfxmXjMcig6PO9bu19MSu8CMC9m6+7GCmUYAGhglgWNlHs8Jc6VjYuHfsPO7l3i3EUeWFxrJSUnFG9K4FT8NBTDr3r0Prdpna8QP8EvgdI5eA9e7Sw18F7e2yVAxZZLRrmZKPghjYiwyX7hEjgD+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969927; c=relaxed/simple;
	bh=SoIUPcW8F7+2kLbv99gfVdxNE+eK+lOWJt3B4Lt8NN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQhgfcln1MWLNsHnvqftdPYsE3uMSoFQTeboTN3gtFg9cocclzOHb5o/CAj0vn+YplgH9YGZdE+QBAv05x0g+xGfnf9OfK2w8uj8WBJS1bbQnjXSVwGpMev1oLXJUmXFkm06wDspt1u3jj3zmUcJFenB2fZSHk4I6yIWQm8Yi4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ovrVYAIc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9EE6C43390;
	Tue, 23 Jan 2024 00:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969927;
	bh=SoIUPcW8F7+2kLbv99gfVdxNE+eK+lOWJt3B4Lt8NN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ovrVYAIcjl3Gki9/A17IyI8s6y+peanCZJDER5iEfoNKsDw3nP1ZLyM2gEB8Hz1Gb
	 Ukj6iMw3tmL2WO4KHmBVLg5hM8Cd9WRaLm4n4KvkQ9nMkHmwheiAgBVtOk2NVK4v2Q
	 0bgZ4VepVVqAQjtE1RB6+dZLOvdAohd66HnEuPp0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Su Hui <suhui@nfschina.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 503/641] power: supply: bq256xx: fix some problem in bq256xx_hw_init
Date: Mon, 22 Jan 2024 15:56:47 -0800
Message-ID: <20240122235833.807475704@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Su Hui <suhui@nfschina.com>

[ Upstream commit b55d073e6501dc6077edaa945a6dad8ac5c8bbab ]

smatch complains that there is a buffer overflow and clang complains
'ret' is never read.

Smatch error:
drivers/power/supply/bq256xx_charger.c:1578 bq256xx_hw_init() error:
buffer overflow 'bq256xx_watchdog_time' 4 <= 4

Clang static checker:
Value stored to 'ret' is never read.

Add check for buffer overflow and error code from regmap_update_bits().

Fixes: 32e4978bb920 ("power: supply: bq256xx: Introduce the BQ256XX charger driver")
Signed-off-by: Su Hui <suhui@nfschina.com>
Link: https://lore.kernel.org/r/20231116041822.1378758-1-suhui@nfschina.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/bq256xx_charger.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq256xx_charger.c b/drivers/power/supply/bq256xx_charger.c
index 789a31bd70c3..1a935bc88510 100644
--- a/drivers/power/supply/bq256xx_charger.c
+++ b/drivers/power/supply/bq256xx_charger.c
@@ -1574,13 +1574,16 @@ static int bq256xx_hw_init(struct bq256xx_device *bq)
 			wd_reg_val = i;
 			break;
 		}
-		if (bq->watchdog_timer > bq256xx_watchdog_time[i] &&
+		if (i + 1 < BQ256XX_NUM_WD_VAL &&
+		    bq->watchdog_timer > bq256xx_watchdog_time[i] &&
 		    bq->watchdog_timer < bq256xx_watchdog_time[i + 1])
 			wd_reg_val = i;
 	}
 	ret = regmap_update_bits(bq->regmap, BQ256XX_CHARGER_CONTROL_1,
 				 BQ256XX_WATCHDOG_MASK, wd_reg_val <<
 						BQ256XX_WDT_BIT_SHIFT);
+	if (ret)
+		return ret;
 
 	ret = power_supply_get_battery_info(bq->charger, &bat_info);
 	if (ret == -ENOMEM)
-- 
2.43.0




