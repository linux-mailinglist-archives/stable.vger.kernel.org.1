Return-Path: <stable+bounces-14434-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 501028380E7
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 840641C286A8
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CBC1350F0;
	Tue, 23 Jan 2024 01:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="04AC4e0j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFB61350E3;
	Tue, 23 Jan 2024 01:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971952; cv=none; b=PsuZsXA8uHbCvrvQdBULmZssRe6ak7LKd358KBKI1Hk0uZDnpa9aE8DUJzQNVjceMlsEF4s3vTiOer6QhTudxkJOa4nfWfep2ORaZJEzXVSFlR9vUenSg4tfo6rXu6eQjyP5ND3k5R0Z/t0IVh4OIvQYMLjFXG5EtApVgOjT5Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971952; c=relaxed/simple;
	bh=jHJWw2Z00JORjiWxUBIsKTPIq9PcqQZbDmK8/n3ZrxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0FA87lnJ7cWA5GolSViwAMv4Ol3AOifuB8hqtect2HIfnEMdOQg5no0T720gDpzLOsfQXdKuIQg69SyN+U5ct+cNDiiSUPjwK2MogbyMAZ605UduoRYUoIo6UWcKP8EKfom5H4MuA99SNJNBI/2WCT1J3RUVG34Y0ctIXr3WQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=04AC4e0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B522EC433C7;
	Tue, 23 Jan 2024 01:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705971951;
	bh=jHJWw2Z00JORjiWxUBIsKTPIq9PcqQZbDmK8/n3ZrxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=04AC4e0jpNf4L9DOB3WQu1a9kRW7x67Qyg2muU46DUjhjc5k0IjvUk/NKCUfI99yd
	 eYRG5g06A5KyXOTFHxxBb7AYfdGM/r+3b5SbD9je+1srdxGl9m85Rdzdj8fpnL3c37
	 GYxDA9AUenAmelfcaXedqoNk5onDY6RpKHlKja8Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Su Hui <suhui@nfschina.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 337/417] power: supply: bq256xx: fix some problem in bq256xx_hw_init
Date: Mon, 22 Jan 2024 15:58:25 -0800
Message-ID: <20240122235803.457692601@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235751.480367507@linuxfoundation.org>
References: <20240122235751.480367507@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 01ad84fd147c..686eb8d86e22 100644
--- a/drivers/power/supply/bq256xx_charger.c
+++ b/drivers/power/supply/bq256xx_charger.c
@@ -1514,13 +1514,16 @@ static int bq256xx_hw_init(struct bq256xx_device *bq)
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




