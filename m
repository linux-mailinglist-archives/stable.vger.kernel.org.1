Return-Path: <stable+bounces-159062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E2BAEE919
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 23:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D9BC3AE06C
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 21:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06D8221F12;
	Mon, 30 Jun 2025 21:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LU9oVOLK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC916242D76;
	Mon, 30 Jun 2025 21:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751317285; cv=none; b=Ou3lUGu+3Kj2ETIzSCdzKFLWMOkCHtd1Std9u5bwToBHoOR4g+K3WjKvg4nEe/IlW8zLMj3LT+mEGy3Q1MsytvpPDdT2O8Bflf1xntd5YTlRKTNebZZUGvUJPvGymnj8y907yCq3dzWYoTpz0J5A75Q3KJKAM4rf5E+mR0Jwff4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751317285; c=relaxed/simple;
	bh=/kqnLAksja1ck+EqcOAHF5gIeaUjEIKoLyCsblAZAGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I5fpwcCw4apYSAXSnmDbUcTOejvhfLK6AR87XYLopREYCSk3GOCzcsnTUKRkDg/8nnsr6r+tRg3K3Bp2wFJmMQsYiB0uXslue4QpJxGFbmQwcVnvteGGxhQ6FrU8WRtHh21wrWzg8zXnx9FPUnMJbYKSeF8CibdRFolF48mJ/Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LU9oVOLK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9BBC4CEE3;
	Mon, 30 Jun 2025 21:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751317285;
	bh=/kqnLAksja1ck+EqcOAHF5gIeaUjEIKoLyCsblAZAGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LU9oVOLK2qg71JcpkiILtEqzKU4nk7zLt1GYg53drYUaA/ftaPgIdhjbSCO+ni7fR
	 O4ff+PyvKQjGje0fkdYTKpWPi+hBCNx4PUiAKjwvy9w4Rwjg6FTFl4PWy0RO3XeKnB
	 QKsdULELTlKp0Ziqt9Jb2hiXLyLI+G8arLNwDvFCnByoKIcPDm1JOwhGy1b1kVGvDJ
	 L9y+6DEWnSVgbyAORW349yTzrA1wnBNo+/MMm6y+dJXTaGgBDAsSDbJU2c6x8OBaZa
	 EpAffeaeY8KFGY9k0ZK63f9LkAAWSK7lhbY7VIkM+W9Age5kiuYh6a73I6YcUOwUh6
	 QQXbNIK3QiHug==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Yuzuru10 <yuzuru_10@proton.me>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	mario.limonciello@amd.com,
	venkataprasad.potturu@amd.com,
	tiwai@suse.de,
	talhah.peerbhai@gmail.com
Subject: [PATCH AUTOSEL 6.1 03/10] ASoC: amd: yc: add quirk for Acer Nitro ANV15-41 internal mic
Date: Mon, 30 Jun 2025 16:47:10 -0400
Message-Id: <20250630204718.1359222-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250630204718.1359222-1-sashal@kernel.org>
References: <20250630204718.1359222-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.142
Content-Transfer-Encoding: 8bit

From: Yuzuru10 <yuzuru_10@proton.me>

[ Upstream commit 7186b81807b4a08f8bf834b6bdc72d6ed8ba1587 ]

This patch adds DMI-based quirk for the Acer Nitro ANV15-41,
allowing the internal microphone to be detected correctly on
machines with "RB" as board vendor.

Signed-off-by: Yuzuru <yuzuru_10@proton.me>
Link: https://patch.msgid.link/20250622225754.20856-1-yuzuru_10@proton.me
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES**

This commit should be backported to stable kernel trees. Here's my
extensive analysis:

## Key Points Supporting Backporting:

1. **Device ID Addition**: According to the stable kernel rules in
   Documentation/process/stable-kernel-rules.rst:15, patches that "add a
   device ID" are explicitly acceptable for stable backporting. This
   commit adds a DMI quirk entry which is functionally equivalent to
   adding a device ID.

2. **Hardware Enablement Fix**: The commit fixes a real hardware issue -
   the internal microphone on the Acer Nitro ANV15-41 laptop doesn't
   work without this quirk. This is a concrete bug that affects real
   users.

3. **Minimal and Safe Change**: The patch adds only 7 lines to the
   `yc_acp_quirk_table[]` array:
  ```c
  +       {
  +               .driver_data = &acp6x_card,
  +               .matches = {
  +                       DMI_MATCH(DMI_BOARD_VENDOR, "RB"),
  +                       DMI_MATCH(DMI_PRODUCT_NAME, "Nitro ANV15-41"),
  +               }
  +       },
  ```

4. **Follows Established Pattern**: The change follows the exact same
   pattern as numerous other entries in the DMI quirk table. It's a
   simple addition to an existing table with no algorithmic changes or
   risk of regression.

5. **Precedent from Similar Commits**: Looking at the historical commits
   with similar characteristics:
   - commit 610010737f74 ("ASoC: amd: yc: Add DMI quirk for Lenovo
     Ideapad Pro 5 16ARP8") - Backported with Cc: stable
   - commit c6dce23ec993 ("ASoC: amd: yc: Add DMI quirk for MSI Bravo 15
     C7VF") - Backported with Cc: stable
   - Multiple other similar commits were backported to stable

6. **No Risk of Regression**: The DMI matching is specific to the exact
   board vendor "RB" and product name "Nitro ANV15-41". This cannot
   affect any other hardware models.

## Analysis of the Code:

The change is in `sound/soc/amd/yc/acp6x-mach.c`, which is the machine
driver for AMD Yellow Carp platform using DMIC (Digital Microphone). The
`yc_acp_quirk_table[]` is a DMI (Desktop Management Interface) matching
table that identifies specific laptop models that need special handling
to enable their internal microphones.

Without this quirk, the AMD audio driver doesn't properly detect or
initialize the internal microphone on the affected laptop model, leaving
users without functioning audio input.

## Conclusion:

This is a textbook example of a commit suitable for stable backporting -
it's a hardware enablement fix that adds a device-specific quirk with
zero risk to other systems. The absence of an explicit "Cc:
stable@vger.kernel.org" tag in the commit message doesn't disqualify it
from backporting; it simply means the author didn't explicitly request
it at submission time.

 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index d5dc1d48fca94..5be4e620eeba1 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -339,6 +339,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "83Q3"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "RB"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Nitro ANV15-41"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.39.5


