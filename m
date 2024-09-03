Return-Path: <stable+bounces-72863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E4E96A8B0
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 22:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25C361C233BA
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 20:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5051D88A1;
	Tue,  3 Sep 2024 20:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOysOP1U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363631D7E52;
	Tue,  3 Sep 2024 20:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396143; cv=none; b=DPhvsu0unyr6ep7QyL3bdHQBIOLAPIu7gI0l+sPRv7BOfaC0VBgp+DsjrH/e6OvCb0ukcz1FF9SrIdW9hS5lvqeZQn4Om/CC2Ug60B0KyzAkKX63dMBQ+kMowLsXoiQQ49LiZoQHsoUNCUseIaNttOd4ynrUhOI5E7QhvCThaKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396143; c=relaxed/simple;
	bh=kyD55pcvdZshzmUgl+aFx61u+SDqgwhE39cWxXRqySw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rx3DhwgdRfmGbTlTLXFjGehKiGrV2Bf7oyrqB2cW14jv384ega6ElfSjUGDlHw+o+sc9kwTrrAV0+lIdVeRnpW1cdme8SG/Nrio6HODrwhcPU+XGg7PIL3YriQslkg7/RnwYK3T5AyXeoxSBhbcAK7/z2rnMHkJi6ZP9BcS/OvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOysOP1U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173D0C4CEC8;
	Tue,  3 Sep 2024 20:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396143;
	bh=kyD55pcvdZshzmUgl+aFx61u+SDqgwhE39cWxXRqySw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EOysOP1UMulo2JqAifjp0ndteG+m35WcRxrCg0+rd8aUbLzzNPZnGUUa+m679WjBK
	 ry33P41ACfxQj130djkjUUYxgRZwQkDJ5fysY51FrygqsKGgRxszrs8+Pr17sLaElL
	 CW+Nm+oqh85klT1EU2r96vMQ3QB7h4sMUEs7mGPJPBzDAwRQRbHHdubiUAf26Shc9H
	 g5+/2WGcTuE2dZpxfKFSzD6UMV4fchE6IF9CCCaBBc7yLTj9MeyNd90mKB5KaDbmSV
	 VA5F6r52nTja5vK3KFaScj2DcZ4TZISeEWpCJKCpxKmo8U7r7F5yrd0QCpQ+KHp1SM
	 V9qvPJ68HroDA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ross Brown <true.robot.ross@gmail.com>,
	Eugene Shalygin <eugene.shalygin@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 09/22] hwmon: (asus-ec-sensors) remove VRM temp X570-E GAMING
Date: Tue,  3 Sep 2024 15:21:56 -0400
Message-ID: <20240903192243.1107016-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192243.1107016-1-sashal@kernel.org>
References: <20240903192243.1107016-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.7
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
index 36f9e38000d5e..3b3b8beed83a5 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -412,7 +412,7 @@ static const struct ec_board_info board_info_strix_b550_i_gaming = {
 
 static const struct ec_board_info board_info_strix_x570_e_gaming = {
 	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
-		SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
+		SENSOR_TEMP_T_SENSOR |
 		SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU |
 		SENSOR_IN_CPU_CORE,
 	.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
-- 
2.43.0


