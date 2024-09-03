Return-Path: <stable+bounces-72885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF72196A8EF
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 22:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631F21F21510
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 20:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473FF1E1312;
	Tue,  3 Sep 2024 20:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3gL/Zym"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84441E1306;
	Tue,  3 Sep 2024 20:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396246; cv=none; b=q8l3tID+3qkr+qu25+J9N3vLBI9mmyclhH2XRL5moYFDTNDnT838VqZBOgPG438Cf/rx1CuAgRPWgenpxU8JUCStjnO4i5weUsDg+XTVWMh8yFqNQC57VrFoW3oS/Tn829N7r0t2wFS1oQaA3c29LzwSMKgLYaI0RJH3LXCsQes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396246; c=relaxed/simple;
	bh=GOz5CbR1/b4jhEreTAJZNQqDcREvsrbTV5Ozy4YE3Ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qwZ6v/TgHbIQiOE3or/GvhQqE7QFHNt0ZS3f//e/rpc1ToZsHcR3wwYo9cKIGLc9/eOOD+tH/ETsyWTVvydtGq0pXIIxC6qv5B0LoZgB6bNA4xx3BIiUYK+17kpRLpcgJDW/pSMVbZN9J8eFKruPM9mkIt5rJNEY85kuFU6YHEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3gL/Zym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89050C4CEC9;
	Tue,  3 Sep 2024 20:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396245;
	bh=GOz5CbR1/b4jhEreTAJZNQqDcREvsrbTV5Ozy4YE3Ak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L3gL/ZymSOJt+zzdOWDYVDu07hKcsFXBQS5rSX4Gg82IsxAjhzmt0y2QFk40wvdOa
	 n+qvPHkdmKthRmYoWMpGqdkX/9LUbldPh3aoXfvXvH3QhxelG0E5dB9Kaz6QwvObvt
	 JNnFwj3pmi5Byyi+c2amBX6hOUERFtv82+vTHIbeNBjT6nSuOSMGj1wJw6TvenpRXY
	 a3mhsdn2UL2F8xWRWZzT25zK7WUCtUiDF9I3a2joJl/N9CFAAd8d0cuMbO6zr+r/7B
	 8+5ZUzInTzZIFmWwGvaTn4Du7zSDtRBampeEz/fsGGdwwjac1z1lzV/fGcmRi3xuHv
	 BJqL/G41IdIRQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ross Brown <true.robot.ross@gmail.com>,
	Eugene Shalygin <eugene.shalygin@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 09/20] hwmon: (asus-ec-sensors) remove VRM temp X570-E GAMING
Date: Tue,  3 Sep 2024 15:23:41 -0400
Message-ID: <20240903192425.1107562-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192425.1107562-1-sashal@kernel.org>
References: <20240903192425.1107562-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.48
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
index 51f9c2db403e7..f20b864c1bb20 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -402,7 +402,7 @@ static const struct ec_board_info board_info_strix_b550_i_gaming = {
 
 static const struct ec_board_info board_info_strix_x570_e_gaming = {
 	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
-		SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
+		SENSOR_TEMP_T_SENSOR |
 		SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU |
 		SENSOR_IN_CPU_CORE,
 	.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
-- 
2.43.0


