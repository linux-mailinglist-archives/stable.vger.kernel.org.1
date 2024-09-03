Return-Path: <stable+bounces-72904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E78A996A924
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 22:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26BE91C24646
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 20:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110D61E4109;
	Tue,  3 Sep 2024 20:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cm8+P0uU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04191E4125;
	Tue,  3 Sep 2024 20:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396336; cv=none; b=M12H9CzUCB0lYWqT5DnI6AszdRzSovMv4YzzaTToGF/znYthqwy06dXA6JmKT+LIragd0ftmd8rZLU6wuMwSUnxxJ5Hh8/7rHzzCAcnaXhUcOO9JU2SNN0TGS1MHtXUDAfRRgGlIgA2a6tnWQM391XvlrPC8WuUN111jlU3dmY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396336; c=relaxed/simple;
	bh=NakiwtTYinhxeOjkF47hrXF4IPqcNM1LMougrhOEANk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOsBi8TvzIodfAgB3AjhfjZu3F6oXVY9txCw79U5Fxtlsu0kql748Gm/U+blQX+H+EEcRFKQP85Rf8lOMmeM3yeUBwHAzMFS7vw/CkjvvLOxUmSU9bUgOhGUCZqV26DW9tr0AjD5W9xvDWnyNZu9OPkf+frenEW4YF+8RYWex1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cm8+P0uU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98F1C4CEC5;
	Tue,  3 Sep 2024 20:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396336;
	bh=NakiwtTYinhxeOjkF47hrXF4IPqcNM1LMougrhOEANk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cm8+P0uUbw93dCMUrsCtG8i0Tg/V8XT7CL2sn8PUOUJG/I9kkENqHOjtMC0DmBsR9
	 2UdtYouYNd1DA8VfayRiiYA9WpXlliaL5xY2EZ9IOIQf0Gl8urAs32xb9QwJ9xb58d
	 mU95amSLL7jTN7wihPiAKk7Hz/wEa8c3T0wB0Z7x90fJCB9Wt10asq1KkZ0oXW1y16
	 r6vRAucCY4Khaw4ytt9DdsLoOBlPedGBPPjIrjEmB1LpzG1TYrnqY1+KSOEz/VBTmU
	 AhJpQfjAJNDaD+Z8ukMf+zR2Z2hlggOuULrlDKGT8lUx2bLVAZj89MkzQGbVDpv/wa
	 MMUoDwOcOQIQQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ross Brown <true.robot.ross@gmail.com>,
	Eugene Shalygin <eugene.shalygin@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 08/17] hwmon: (asus-ec-sensors) remove VRM temp X570-E GAMING
Date: Tue,  3 Sep 2024 15:25:22 -0400
Message-ID: <20240903192600.1108046-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192600.1108046-1-sashal@kernel.org>
References: <20240903192600.1108046-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.107
Content-Transfer-Encoding: 8bit

From: Ross Brown <true.robot.ross@gmail.com>

[ Upstream commit 9efaebc0072b8e95505544bf385c20ee8a29d799 ]

X570-E GAMING does not have VRM temperature sensor.

Signed-off-by: Ross Brown <true.robot.ross@gmail.com>
Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
Link: https://lore.kernel.org/r/20240730062320.5188-2-eugene.shalygin@gmail.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/asus-ec-sensors.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index b4d65916b3c00..d893cfd1cb829 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -369,7 +369,7 @@ static const struct ec_board_info board_info_strix_b550_i_gaming = {
 
 static const struct ec_board_info board_info_strix_x570_e_gaming = {
 	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
-		SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
+		SENSOR_TEMP_T_SENSOR |
 		SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU |
 		SENSOR_IN_CPU_CORE,
 	.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
-- 
2.43.0


