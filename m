Return-Path: <stable+bounces-58861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A59D692C0DC
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6D9F1C2074E
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A24189F30;
	Tue,  9 Jul 2024 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rG9ID+9B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19614189F27;
	Tue,  9 Jul 2024 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542299; cv=none; b=ORxlbUXe2YT/JFo1rHgtxE4p+ON+3OjMsbcmlX8kKwrifQqsUBsVIR65QiBi/dxAcvQbSLd0i/d0hXMNQB7ZQ7JxcZfBBpdevnD0z/+aHXz2IyrBwdyGzG2ekh0yGWD9/BDtphNldk6DzlE1muxgy/Vg3CDE/iILg0Fs20SNBZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542299; c=relaxed/simple;
	bh=4LLJj65qIZPZDmmfMmKa0K/tPmdu/Aq9vv0UpqaS7Es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D6yAg9B6HfFvMinzsxUfQz9pp+s+tcUvGyrY9Xbyt0x8ISmvUbwnrgNaDeNG6FHebCGUiJ2Q1z+IkYL5aRojlKRE+H5FLrBghSaL/h4oR9uAcSvGGqLUGPO78UuPa8er0yz8MCUegMkKt7f2pS++6jS7tQsh87maJkNI9rJRHTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rG9ID+9B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C371C32782;
	Tue,  9 Jul 2024 16:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542298;
	bh=4LLJj65qIZPZDmmfMmKa0K/tPmdu/Aq9vv0UpqaS7Es=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rG9ID+9B3OAu6EAqeDYSUywbQwau4UlDqucZW/W8SrI6ZMMn8+P4VGF56SbYHCcLI
	 rioUBCVE9CKl8Lu+iswxO4UjRewoYVlpNTHZafZXVVpKyhuvwT8eSUdd2Av1h+/kCr
	 r5pJR5tV6+U+YE0/qAv48KnMrNgWnSyVOfLX1g6EN09XfFntx6aEn3HF7whTj0ExAY
	 7khjhXp6bdE3cr7nhMx60XcO5gLv6sTA4IdkE1yt7zNH+5KjxgzaU9Vx5OGndnQK85
	 qOFHpdl9XRFZiMKpq9H+2j1XuIVbonePON6YwbuSYz1XFbcX5Lu0ZsmCV8N3uUcbNG
	 OP1c9qvHL7otw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vyacheslav Frantsishko <itmymaill@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	me@jwang.link,
	end.to.start@mail.ru,
	git@augustwikerfors.se,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 26/27] ASoC: amd: yc: Fix non-functional mic on ASUS M5602RA
Date: Tue,  9 Jul 2024 12:23:40 -0400
Message-ID: <20240709162401.31946-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162401.31946-1-sashal@kernel.org>
References: <20240709162401.31946-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.97
Content-Transfer-Encoding: 8bit

From: Vyacheslav Frantsishko <itmymaill@gmail.com>

[ Upstream commit 63b47f026cc841bd3d3438dd6fccbc394dfead87 ]

The Vivobook S 16X IPS needs a quirks-table entry for the internal microphone to function properly.

Signed-off-by: Vyacheslav Frantsishko <itmymaill@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://patch.msgid.link/20240626070334.45633-1-itmymaill@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 0568e64d10150..8e3eccb4faa72 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -283,6 +283,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "M5402RA"),
 		}
 	},
+        {
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "M5602RA"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.43.0


