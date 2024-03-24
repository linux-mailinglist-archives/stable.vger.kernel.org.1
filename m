Return-Path: <stable+bounces-30022-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB8B8888FF
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 03:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 807D9B22322
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 02:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49F4157E62;
	Sun, 24 Mar 2024 23:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBj3r0RT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBE1208984;
	Sun, 24 Mar 2024 23:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321548; cv=none; b=ItYeGaOV2q4gkcCgm4IZZbwHFWBFq+bSLakGw109j1SboALlIXaWNRYuQX20TfKMnvFxbL0XtxO4KZ3JReOhSKF1jioicHF1JySUgP6c42uEXk28k9kz16iGqF6UEg6gytkuIwUv1tBvrAnyvlPVJtUJdbJc+4jPzEtCSPlGBaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321548; c=relaxed/simple;
	bh=vSXBLHwVf5dgt++K+6k96qdHTcUOWapdasyCUaiH4Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z6a119hdSmLrCF+Y/fzZwZGbXFW3j3w3xdBtugmRYDdooKeNWC7bq0dzqWmffr3PBz9syzmOWusmbe5Yxy2A2t4FyWo21sXZ95TBT9ivTJHOyr3fDzqD0dZ0PHliAMQlxj19DA7qEM+l1ycskFf3FzLzb/1J0hLYsHDqGbAIVRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBj3r0RT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5265BC43394;
	Sun, 24 Mar 2024 23:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321546;
	bh=vSXBLHwVf5dgt++K+6k96qdHTcUOWapdasyCUaiH4Eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hBj3r0RTClPapeNs/f9uL0524enuCO5Dgiuwc9vKlFdAQrYTtIwBbxefutJBFAZvc
	 BR1f/vNz6btXKC1Nxdcwv20tgHXtDdYL2UX7QMAoz1rGbZxAM7lfZ5TK29kSPfBgLh
	 wiBgnfuv9/oNxBMozx7+JdX+AqLN0dwWeBK4OUW7kGL1ngjyeY0S8EA4JH0twEjtF1
	 mmmJr3ONT40hxOkC9R+3wkZnjsEdSoUXjUgLxRXsvg24gManTCecSSkG6/7MG6kka4
	 CdGsZF7WPJcnfh1a6n6Q9vvOWhfNKP9J8c2AsE51YxKcKPDyGno4FOnDvTpn0TLXdW
	 XfG9iiaAHyF5w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Alexey I. Froloff" <raorn@raorn.name>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 275/638] ACPI: resource: Do IRQ override on Lunnen Ground laptops
Date: Sun, 24 Mar 2024 18:55:12 -0400
Message-ID: <20240324230116.1348576-276-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: "Alexey I. Froloff" <raorn@raorn.name>

[ Upstream commit e23ad54fef186aa66007895be1382c88f1ee2bf7 ]

The Lunnen Ground 15 and 16 needs IRQ overriding for the keyboard to
work.

Adding an entries for these laptops to the override_table makes the
internal keyboard functional.

Signed-off-by: Alexey I. Froloff <raorn@raorn.name>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Stable-dep-of: 021a67d09615 ("ACPI: resource: Add MAIBENBEN X577 to irq1_edge_low_force_override")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/resource.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index b8378033117d4..ab1865e22864b 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -562,6 +562,20 @@ static const struct dmi_system_id pcspecialist_laptop[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "GM5RGEE0016COM"),
 		},
 	},
+	{
+		/* Lunnen Ground 15 / AMD Ryzen 5 5500U */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Lunnen"),
+			DMI_MATCH(DMI_BOARD_NAME, "LLL5DAW"),
+		},
+	},
+	{
+		/* Lunnen Ground 16 / AMD Ryzen 7 5800U */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Lunnen"),
+			DMI_MATCH(DMI_BOARD_NAME, "LL6FA"),
+		},
+	},
 	{ }
 };
 
-- 
2.43.0


