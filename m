Return-Path: <stable+bounces-110744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AE9A1CC05
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 17:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3176B1888D8C
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E111F8927;
	Sun, 26 Jan 2025 15:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1SFjGl0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BCE1F8910;
	Sun, 26 Jan 2025 15:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737904070; cv=none; b=KMRigdeYfhwVZLOhLNpCyQzEBhoCkkH/5TMBUYue2ntlYc8QadEsLz7plx7Vumg/oO8qqEi5dfHfW9cWohqoiEAC/gurNXiwXqCHqQupEWDNS7x5fbJY5eStiw4vqkTWf/c2S+6kxfwRZj5PeaCk78Ate3OofuxM7P6YTuiDHaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737904070; c=relaxed/simple;
	bh=f3xZ6FhLbrKgQaL2x0BR2H9B19revhBm0ZNVlN1EYx0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l93iMxJ1AlAYugiyOPxj29yLq0zz+upZ8eeGQPbaqIySL3HlkniilO1LZr2KyO4E83sdQ6YYVQO4SmsHT4SP0Y6RyM09i46MV/ltT6pLgbHXjTM76mO56B8KztzXdIls/681O6t9yyauRZd3BwXnAhlFOHq+maA33MGM0IEYEEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1SFjGl0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1183C4CED3;
	Sun, 26 Jan 2025 15:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737904069;
	bh=f3xZ6FhLbrKgQaL2x0BR2H9B19revhBm0ZNVlN1EYx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R1SFjGl0EQdhRNLVj0Mj1d3CSJokc9EeQ6DZ1JOVI4m7iE3bGnyF3E/uGIUIn8ZTC
	 hnkudYesw8u2txVpfnLw22bgh5KsBJP50U35EmUDYRobiK3AafVxqjx5lbZxJr4zcX
	 rjVvvmlcHd/taSdULiwF0prHTFDmJ1ZQjWsqIDrOyKdR+J7PeW7M2TWrFucyD1En7M
	 K04GXj/2Qi4Y/GQltIvR9Q9dHlnostGQTpTDQ0VODEj613NDBxg1Zv5SWWpfb0DAuW
	 JBgOg6igUyCuec7er4RudOT+/oI6Fp7qq8Ur5JSSo4/G6Q/RAnS74xt9Z1D1oYwcdP
	 kwROS8Or1b5/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	Rayan Margham <rayanmargham4@gmail.com>,
	Kurt Borja <kuurtb@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	jlee@suse.com,
	hdegoede@redhat.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 09/16] platform/x86: acer-wmi: Add support for Acer PH14-51
Date: Sun, 26 Jan 2025 10:07:11 -0500
Message-Id: <20250126150720.961959-9-sashal@kernel.org>
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

[ Upstream commit 9741f9aa13f6dc3ff24e1d006b2ced5f460e6b6f ]

Add the Acer Predator PT14-51 to acer_quirks to provide support
for the turbo button and predator_v4 hwmon interface.

Reported-by: Rayan Margham <rayanmargham4@gmail.com>
Closes: https://lore.kernel.org/platform-driver-x86/CACzB==6tUsCnr5musVMz-EymjTUCJfNtKzhMFYqMRU_h=kydXA@mail.gmail.com
Tested-by: Rayan Margham <rayanmargham4@gmail.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Kurt Borja <kuurtb@gmail.com>
Link: https://lore.kernel.org/r/20241210001657.3362-2-W_Armin@gmx.de
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/acer-wmi.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index d09baa3d3d902..5cff538ee67fa 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -393,6 +393,13 @@ static struct quirk_entry quirk_acer_predator_ph315_53 = {
 	.gpu_fans = 1,
 };
 
+static struct quirk_entry quirk_acer_predator_pt14_51 = {
+	.turbo = 1,
+	.cpu_fans = 1,
+	.gpu_fans = 1,
+	.predator_v4 = 1,
+};
+
 static struct quirk_entry quirk_acer_predator_v4 = {
 	.predator_v4 = 1,
 };
@@ -600,6 +607,15 @@ static const struct dmi_system_id acer_quirks[] __initconst = {
 		},
 		.driver_data = &quirk_acer_predator_v4,
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "Acer Predator PT14-51",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Predator PT14-51"),
+		},
+		.driver_data = &quirk_acer_predator_pt14_51,
+	},
 	{
 		.callback = set_force_caps,
 		.ident = "Acer Aspire Switch 10E SW3-016",
-- 
2.39.5


