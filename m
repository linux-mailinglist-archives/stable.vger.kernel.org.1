Return-Path: <stable+bounces-92513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E75629C54A3
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC0CF2894F0
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CA321EBAD;
	Tue, 12 Nov 2024 10:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNLEyjSX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3417121EB93;
	Tue, 12 Nov 2024 10:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407823; cv=none; b=ljz44aEuJQunQ4bvdH2HT5bKxGb074ljr41pa2wgAd35nDiXrI6GGyCVgUi3Z7EQ668nQk1N+DfqeDIz9z5FIpSsl4xKCz8RE+AP7A2Ko379krTfDA0XK0pcmLGMUeu1CMFpvWihFy0fottjVZZmQRTeUwCPA5sE8jvJdeHmoRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407823; c=relaxed/simple;
	bh=mH0Xx9pnQKbS/pmT69wEitT1nowdxH6DcNJvkhuFaFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HnCQMnlR9uKP+Cm/seGACPJziOrpU7kqSFoHBZtRzkvJZvyCObwcEjdjZtZHzn5x9OT82tVz6RKm6ANYnF5JXWfX50FD/JMqP6adXlLgt7rb1ClCYbl701JkBABMHoyAP+EVDqrfZbAJmT8RU6GZnE1R16EMj+167q/xQUBAq8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNLEyjSX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D44DC4CECD;
	Tue, 12 Nov 2024 10:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407823;
	bh=mH0Xx9pnQKbS/pmT69wEitT1nowdxH6DcNJvkhuFaFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DNLEyjSXDZrtRV+ev3con6HglcKKQp/AEA37VoQFI7YRmt+a1vcFucnfV6q10ST0j
	 58v9D42OQKSLbRv6BvBph3jcsAM+EnRe9Fp7/futZch6RtZ0HHLMPYqyGe57wFGw8v
	 VUUBiGO+fCfnrx1lxNm5Lzrb48aPZT/IBg0vrPE/Asmv8C2irm49fCQJ4asXZjLHRF
	 ts6lIb9m1xntL0wQIfoJpnJgQfAFXyITKrCkMdaPBWoGLD8rxmM6j6sykONgrzUVfs
	 19WQFfSgdBah/dWYAJthdO638Xy1Ce/JtZxvCF0nxWNBcqglUPKulr6sLj2j7qpTG5
	 3TkajAISCsxOw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mingcong Bai <jeffbai@aosc.io>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	mario.limonciello@amd.com,
	end.to.start@mail.ru,
	me@jwang.link,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 10/15] ASoC: amd: yc: fix internal mic on Xiaomi Book Pro 14 2022
Date: Tue, 12 Nov 2024 05:36:31 -0500
Message-ID: <20241112103643.1653381-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103643.1653381-1-sashal@kernel.org>
References: <20241112103643.1653381-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.60
Content-Transfer-Encoding: 8bit

From: Mingcong Bai <jeffbai@aosc.io>

[ Upstream commit de156f3cf70e17dc6ff4c3c364bb97a6db961ffd ]

Xiaomi Book Pro 14 2022 (MIA2210-AD) requires a quirk entry for its
internal microphone to be enabled.

This is likely due to similar reasons as seen previously on Redmi Book
14/15 Pro 2022 models (since they likely came with similar firmware):

- commit dcff8b7ca92d ("ASoC: amd: yc: Add Xiaomi Redmi Book Pro 15 2022
  into DMI table")
- commit c1dd6bf61997 ("ASoC: amd: yc: Add Xiaomi Redmi Book Pro 14 2022
  into DMI table")

A quirk would likely be needed for Xiaomi Book Pro 15 2022 models, too.
However, I do not have such device on hand so I will leave it for now.

Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
Link: https://patch.msgid.link/20241106024052.15748-1-jeffbai@aosc.io
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 76f5d926d1eac..e027bc1d35f4f 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -381,6 +381,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Redmi Book Pro 15 2022"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "TIMI"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Xiaomi Book Pro 14 2022"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.43.0


