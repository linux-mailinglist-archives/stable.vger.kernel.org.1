Return-Path: <stable+bounces-58834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F20E492C08A
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AAD61C20B62
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEBC1A08A3;
	Tue,  9 Jul 2024 16:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkSU4eCz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F3D1A08A0;
	Tue,  9 Jul 2024 16:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542218; cv=none; b=CBCe//PkVrFQA2uikkBy6KcdJ9377m6wOCeuumJqaZLeg6dfsXisEaVBf+lZ9L0VtwFH3szJvrElVSnAfINnepWJ9wihEezmyrVC587m7rmqDAhpAayPwHYYJCBM8mwfG4CL6hLSTZLpb+rVsGwdn1zwm72dnONNw63n7UmkK1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542218; c=relaxed/simple;
	bh=x4j+mPJIwJCDbaZ9DjFvkJ8ODGnYpHCdSfBKribIdbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aXgoOg96bdMpJoRDHKaBJnSSckLhTQ9soD4t0/RROrtAguH6J4IlkeruocP5cAxQfgWdlPqfk7Os5PgmFjykDfyxyoswkmiWK9xar1yv9XgKJBc7hh1p1bL1hFqTz+VQYlEjR8y/GpKJW9tChh6PQV/bBM875CYgU4KpsfKaZv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkSU4eCz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3470C32782;
	Tue,  9 Jul 2024 16:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542218;
	bh=x4j+mPJIwJCDbaZ9DjFvkJ8ODGnYpHCdSfBKribIdbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DkSU4eCz+JOqni5dLnwbmoAbW2WshL4vEDX9JIRNZof7fazVGVw+/PZ8PcJuq3gJj
	 mIn4wx5BwROfertfJkKK6DOyx/vGUEEWY4njXItu3/vtxZFJzX8o33vYtiEUKl6RUc
	 dI0iS3LUWZeY+U53o8Dgyk7xEA1bkeX4RpHcP3WePCfjtSR3qAvgp6VyVxh/7aIf8z
	 ezRjbBiV7ZVGs6uaIAYD5a7KaZLpGbzCfVWThC2QlsOo73eIPsIMtahgdJKrp+PY/b
	 L1yd9EGS8Hnb2tDQDZosj+T3//nGjUkW8JbPrnm4xkapYCRVZty+LJfjix0d8yQvN0
	 dsIO+ng2wo+Zg==
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
Subject: [PATCH AUTOSEL 6.6 32/33] ASoC: amd: yc: Fix non-functional mic on ASUS M5602RA
Date: Tue,  9 Jul 2024 12:21:58 -0400
Message-ID: <20240709162224.31148-32-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162224.31148-1-sashal@kernel.org>
References: <20240709162224.31148-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.38
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
index 1760b5d42460a..4e3a8ce690a45 100644
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


