Return-Path: <stable+bounces-67567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D96B9511E8
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 04:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC9291C221A1
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 02:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397571864C;
	Wed, 14 Aug 2024 02:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtJweBx/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAEC849C;
	Wed, 14 Aug 2024 02:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723601695; cv=none; b=UobwWVwNo+KgCLqVFU47Qi0rfC0s8Iz6kVPkfVpeQ3vTa6lul1ZByx0ESBaQF2EFDMtFqRaO8MaiubiCnyNzGs3tkelJ4ABq5QJfClo0oHznUh2T2Z8X5HA1wgeEij02+yTN+bgEkHp9220mbRluFiwWmLc2GHIyIzu6fbyJlCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723601695; c=relaxed/simple;
	bh=5zU34EoM6DMvuAuNmuBJXg4JRuV8D3pyQIgORZB1PRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J3Erx6tKZyO5ab8xITm0EcgCiGNxS/stR5gCcX0ULGu0xZ4JnEHc8ghsvFFfFE3D2QlfsVkWyN2/jLSkSX10Mu8RW3YxaiCfygsssHbsSZx7G05UDLtgImpPW5WXElX1XfehFtNFREepvw0k4uqGk+SiFTJoii+f59nlCy8fX4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtJweBx/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10ED6C32782;
	Wed, 14 Aug 2024 02:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723601694;
	bh=5zU34EoM6DMvuAuNmuBJXg4JRuV8D3pyQIgORZB1PRs=;
	h=From:To:Cc:Subject:Date:From;
	b=gtJweBx/k4b/Lm+iZaSP4SV/cHBYXdg7IXZzetMA71VbUz/wzl38TyO4H7SvRSeQS
	 ZCTOulEN6C0eOo3QDwqGk28Aonx1sHBcjkNrTwrClrr+S0OwyaaiIsQcuOEYWxiQPn
	 pXS/zAwQtOiDKhWPNemVk5FfHk7fZqofh0P/WbtGm7UWK8baqbBst3SGJt9sTqowqa
	 B3fQAYwo5ic8ORUdVZ+cYZZatT7DloIZ7DIckVRGNwfY2Mpo526kBKzOVgugqd1c9Q
	 AjUynThHiLMGq6mR2624bu2Ra7uU6epqHFysm5/D0v/C57dptXbTSQNzXtUtyBLl8K
	 KI+6jSORLoRIA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bruno Ancona <brunoanconasala@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	mario.limonciello@amd.com,
	me@jwang.link,
	end.to.start@mail.ru,
	git@augustwikerfors.se,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 01/13] ASoC: amd: yc: Support mic on HP 14-em0002la
Date: Tue, 13 Aug 2024 22:14:32 -0400
Message-ID: <20240814021451.4129952-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.4
Content-Transfer-Encoding: 8bit

From: Bruno Ancona <brunoanconasala@gmail.com>

[ Upstream commit c118478665f467e57d06b2354de65974b246b82b ]

Add support for the internal microphone for HP 14-em0002la laptop using
a quirk entry.

Signed-off-by: Bruno Ancona <brunoanconasala@gmail.com>
Link: https://patch.msgid.link/20240729045032.223230-1-brunoanconasala@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 36dddf230c2c4..fa0096f2de224 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -423,6 +423,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "8A3E"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8B27"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.43.0


