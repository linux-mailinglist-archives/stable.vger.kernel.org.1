Return-Path: <stable+bounces-110747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAEBA1CC0C
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 17:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BC1E18825D3
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB0B2309A4;
	Sun, 26 Jan 2025 15:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tftBQLef"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6826230999;
	Sun, 26 Jan 2025 15:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737904075; cv=none; b=LNhhNL3qaIidAUvL2WzNzYG6glJHtMEAhmlOq+1lj9cg6R6mhs/LBJIChvI4hgFUOo65NBk509hS9gjEDbCZw+olB1GP9E64HiyWc47pUItA4nEHgyx41mSSGvblXaIxSNEr7jzJal7JIqp8CDrhRS1EHbN+2zy/bhtQksmr/ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737904075; c=relaxed/simple;
	bh=Y/mqDBO9yXQYFtykR5TA+Ue9IMNZ9Vw3IH4GqzwFjaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Izo70Ved1bIpBo/b3fjEjTUgAfoiDLmYcYYVffl9bbNFhrclgeRgViLycA3raC4m/O7YreFHSSbvWuiEexNZvFUrh3BXe+64oWN2ihEf19Yp3GVBVIRcZarRjAVbBIiG6ELX1qhhR8Ig6qTqeFYfUArAGDczvwxF4KT90pu7EBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tftBQLef; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72AA5C4CEE2;
	Sun, 26 Jan 2025 15:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737904074;
	bh=Y/mqDBO9yXQYFtykR5TA+Ue9IMNZ9Vw3IH4GqzwFjaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tftBQLefpI4bJ3uF1pwddduY7hGTK5cdSloAc0BrJCMPXRi9DVAmpEXdKpKgzhjS7
	 ZfNvSMomYnAMafZ4q29vBaRPnbR56PcId7MwK+9EEkMYnMek1z8RajAFSPEpxknmMj
	 Uxk50XG5rnhRXeL1JgdPxJ5lrCU0+ct12HbEqBQzJl9aTYimPEVN0+TP/efucT3CiL
	 XncVud2T/xc9vHBWANmt1WCyEchwtBVmY+HBEHozhLqEpuIfo4ZDoE+K0W2rvYFx6u
	 UnemUkAi/IJcOtDHoqHpDcqG9WUgndqLq1y9BwDo23+F0qey5xwQHikdxLlh+B/eSE
	 EK0En5qHVdkGw==
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
Subject: [PATCH AUTOSEL 6.13 12/16] platform/x86: acer-wmi: Add support for Acer Predator PH16-72
Date: Sun, 26 Jan 2025 10:07:14 -0500
Message-Id: <20250126150720.961959-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150720.961959-1-sashal@kernel.org>
References: <20250126150720.961959-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
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
index 5cff538ee67fa..3c211eee95f42 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -393,6 +393,13 @@ static struct quirk_entry quirk_acer_predator_ph315_53 = {
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
@@ -598,6 +605,15 @@ static const struct dmi_system_id acer_quirks[] __initconst = {
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


