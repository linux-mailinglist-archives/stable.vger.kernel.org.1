Return-Path: <stable+bounces-110761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 559B9A1CC36
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 17:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F574166425
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14BF234981;
	Sun, 26 Jan 2025 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InNVNefk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABF21F91ED;
	Sun, 26 Jan 2025 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737904110; cv=none; b=AWg0sTB0N9vA2el02S52Q0AA08SXkh17yuySDTE2h+XJm01+hJW0kE0yuEXGUa8MVpPXSvu3/hlaCB2G5oNeRoqSvrUsjuaWLUvabOmB5eHx7KEzvb7p3NHqvsefMkhFxxHNwOAWUpQEF3Y0MdiZ5oBFPiNTiHcpxG2L8f0HBY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737904110; c=relaxed/simple;
	bh=/ZpiW6b/tVfu7Ad3xX4q80EbA+HWOQd6Ao+l04QF8Lg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hgzsspXX6ZDYdV6z+mYcdrf1LoVvrZV0pxUcLil8gylGFMKsDneI+lG9bCyc8q3tpJWV2uKlwqg6pgO5wFLX0oqK89i0GKA+3DLcIecuaq1u6vex4bfrWTOJrPdQydjmF6o5q7qxw0QF0IuYDB0pI3nmnNPjIcLgK5ZUzwvga/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InNVNefk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30576C4CEE3;
	Sun, 26 Jan 2025 15:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737904110;
	bh=/ZpiW6b/tVfu7Ad3xX4q80EbA+HWOQd6Ao+l04QF8Lg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=InNVNefkiFPYgOotVQEAdoNdVnh6UnZThumo1D1pmDj0Ecdm3us94IWsqbqghkKXG
	 RF/NDk4tFvKLLaQIvqOKMtLEDxlOsTdZoab76dnjwrYM0NNUOxzw6yp88UB5jspFM6
	 DIxEF3iuGSN7v/03klNgPhK7d7i3yQKFN5B79FV0DLQf8hAjYa4R8YLpcTOZ6t2kFZ
	 rbeMlenaJxxvhemXpW7VjepjUrIbgUmrXj08AqMuRZLFYn/+ifQCAbHIQYDaJiOFMg
	 7Tnj5B1JpV+C4Hyw5YSCVt9L8DYY1S3gXTjbp3lmDyRkpoB7/pVczlAuIzOZm49Jjm
	 r+aZgUWif0DmQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	Eric Johnsten <ejohnsten@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	jlee@suse.com,
	hdegoede@redhat.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 10/14] platform/x86: acer-wmi: Add support for Acer Predator PH16-72
Date: Sun, 26 Jan 2025 10:07:57 -0500
Message-Id: <20250126150803.962459-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150803.962459-1-sashal@kernel.org>
References: <20250126150803.962459-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
Content-Transfer-Encoding: 8bit

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit c85b516b44d21e9cf751c4f73a6c235ed170d887 ]

Add the Acer Predator PT16-72 to acer_quirks to provide support
for the turbo button and predator_v4 interfaces.

Tested-by: Eric Johnsten <ejohnsten@gmail.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Link: https://lore.kernel.org/r/20250107175652.3171-1-W_Armin@gmx.de
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/acer-wmi.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 844e623ddeb30..f69916b2eea39 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -398,6 +398,13 @@ static struct quirk_entry quirk_acer_predator_ph315_53 = {
 	.gpu_fans = 1,
 };
 
+static struct quirk_entry quirk_acer_predator_ph16_72 = {
+	.turbo = 1,
+	.cpu_fans = 1,
+	.gpu_fans = 1,
+	.predator_v4 = 1,
+};
+
 static struct quirk_entry quirk_acer_predator_pt14_51 = {
 	.turbo = 1,
 	.cpu_fans = 1,
@@ -603,6 +610,15 @@ static const struct dmi_system_id acer_quirks[] __initconst = {
 		},
 		.driver_data = &quirk_acer_predator_v4,
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "Acer Predator PH16-72",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Predator PH16-72"),
+		},
+		.driver_data = &quirk_acer_predator_ph16_72,
+	},
 	{
 		.callback = dmi_matched,
 		.ident = "Acer Predator PH18-71",
-- 
2.39.5


