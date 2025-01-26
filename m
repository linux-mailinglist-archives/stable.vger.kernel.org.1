Return-Path: <stable+bounces-110765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C26A1CC48
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 17:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96BC37A070B
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8BD236A64;
	Sun, 26 Jan 2025 15:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="toPTT7ua"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7582D236A7E;
	Sun, 26 Jan 2025 15:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737904117; cv=none; b=dHw7aW3eNukqR4HbqzuoR5nglw2fEHExqR9bOakvVEz+2MZhJKn4w0HRbuvL4wAufZzMZWg5j+e1+knJOYZWULDMOsG0YkEGbs6Am16hJrgDTXgTJxX0aXQq1GX4SY2PSm7yEyyDX4zAL3HQy5hc9FEVK0RN/qUxFgU16k3VkHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737904117; c=relaxed/simple;
	bh=t4fjBPJPZtgqsPOyZopycnLTjn8n2khOuZj3LSbSJzM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QtFtE591F1rIk8HUSywqUrxeE7hwprF7fNylHR7GXIsVpWRfJWeHkkbG6w2ZcXuBQTUQyb655IHSPr3td4NLfjizaJ8fyqjwauHsR2mE520Njlq75yfSeucpRTfm79HDboTIqbtcI9didFun8FxfbJs0r+uDdPUwt8qO8rpUafU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=toPTT7ua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F1CC4CEE4;
	Sun, 26 Jan 2025 15:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737904117;
	bh=t4fjBPJPZtgqsPOyZopycnLTjn8n2khOuZj3LSbSJzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=toPTT7uaMIJ5IF61gD67h36kNNBOLFCYTMXyhn5XGTsW6ZJHjhPJ63BNSW2oqzzks
	 ZNo7xRHLZYNKPIL23gUNr8jN4qFcX94sjNHe8VmNOFxAL+W3r0BJ2B9//TgVLygpVT
	 CYrjHGTe4Eavm3bps5Kqjawg4oJLdw0tU6xRVL7RgHO7KUr7HzvBTJhXcx2fe4BIaJ
	 mlOK44hf9BD164GcUdlR6z02DihiW7puwI9c9K7JRr3PqUiE2V7Xa8CkTCJr3oniRy
	 mwLxzhUyNcGNftVl6E+B4iLpWJ3Ng1J0kZwCO3YziYSdWlZ1HMhkZ0dCi6KDr21F8o
	 +n88hHBi6YeXQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	Farhan Anwar <farhan.anwar8@gmail.com>,
	Rayan Margham <rayanmargham4@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	jlee@suse.com,
	hdegoede@redhat.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 14/14] platform/x86: acer-wmi: Ignore AC events
Date: Sun, 26 Jan 2025 10:08:01 -0500
Message-Id: <20250126150803.962459-14-sashal@kernel.org>
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

[ Upstream commit f6bfa25c6665f8721421ea94fe506cc22f1d4b43 ]

On the Acer Swift SFG14-41, the events 8 - 1 and 8 - 0 are printed on
AC connect/disconnect. Ignore those events to avoid spamming the
kernel log with error messages.

Reported-by: Farhan Anwar <farhan.anwar8@gmail.com>
Closes: https://lore.kernel.org/platform-driver-x86/2ffb529d-e7c8-4026-a3b8-120c8e7afec8@gmail.com
Tested-by: Rayan Margham <rayanmargham4@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Link: https://lore.kernel.org/r/20250119201723.11102-2-W_Armin@gmx.de
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/acer-wmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 6534f0cdeb2bb..c5679e4a58a76 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -95,6 +95,7 @@ enum acer_wmi_event_ids {
 	WMID_HOTKEY_EVENT = 0x1,
 	WMID_ACCEL_OR_KBD_DOCK_EVENT = 0x5,
 	WMID_GAMING_TURBO_KEY_EVENT = 0x7,
+	WMID_AC_EVENT = 0x8,
 };
 
 enum acer_wmi_predator_v4_sys_info_command {
@@ -2326,6 +2327,9 @@ static void acer_wmi_notify(union acpi_object *obj, void *context)
 		if (return_value.key_num == 0x5 && has_cap(ACER_CAP_PLATFORM_PROFILE))
 			acer_thermal_profile_change();
 		break;
+	case WMID_AC_EVENT:
+		/* We ignore AC events here */
+		break;
 	default:
 		pr_warn("Unknown function number - %d - %d\n",
 			return_value.function, return_value.key_num);
-- 
2.39.5


