Return-Path: <stable+bounces-127234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACF2A76A5A
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 17:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E9DF188D25A
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 15:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFDE2475CE;
	Mon, 31 Mar 2025 14:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHVUyCIB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8730A221DB2;
	Mon, 31 Mar 2025 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743433003; cv=none; b=n93h4f+4siGW34B79Sdy72EXCWs+NwSBhp1LTu/ofWNRanGDEBY1154F1DPM0rHbHRHEqaui+sCWUAZxyX+HYcsCR08l8GgSM/H+74fqNdqWQJCMitDzLDGgayl5m/DuFtRSguJssM6ufMzOKMCze2UaJWl3n5+Qutb1K3pFFBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743433003; c=relaxed/simple;
	bh=gviPPoSfaGquxPgSySGC1fLXCD0LjXCDjq1UJ02+CeU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VwsC7GVBpqnPlrs3g3ZXGHUqigEzCn18SouvLIKJ1HXGz0/l2Rv3ROq1Xvz87yjiVy3RyiaaxD4JBf4g2DWXI83SniLjzagjwk+ufhdUpTZex6zO12y/gApkXvXHBtdthlGOk62R18WXYWwns1XCpYiUtXltuhes9e3KzexBkdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tHVUyCIB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ABFDC4CEE3;
	Mon, 31 Mar 2025 14:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743433002;
	bh=gviPPoSfaGquxPgSySGC1fLXCD0LjXCDjq1UJ02+CeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tHVUyCIBQQxqmIaWPhwoJCAd1pMAdTLbso++hlvIfXhVVLrS2YB+27x5JPV3eZOED
	 wlH3ZCSX0NWdsWKKp4Er/OB44XCel2LQdXV/bK79mkWIlX99fhsItzXwurqgl8v3l6
	 qRmY/cSBPOozXkkNDVo4FEwYMQ5kflabE6WpvHHO0ZpXrGE3cgEpSBvDcW5UX7/YX1
	 cHNc0p3Ogx1gX/HsgI0UH/Q1kQjJQ5z+kAb431YxxNl2xIh9Z+Dd4M8a9ugw9mds3n
	 LUxqc4uQRtPyOghow45djZ1nwmMIg9C2i92q4AsNYqIVFKxOJxgxCGUKMie277jnwe
	 fTYKPSPh+SC/w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Syed Saba kareem <syed.sabakareem@amd.com>,
	Reiner <Reiner.Proels@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	end.to.start@mail.ru,
	venkataprasad.potturu@amd.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 19/19] ASoC: amd: yc: update quirk data for new Lenovo model
Date: Mon, 31 Mar 2025 10:56:00 -0400
Message-Id: <20250331145601.1705784-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331145601.1705784-1-sashal@kernel.org>
References: <20250331145601.1705784-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.85
Content-Transfer-Encoding: 8bit

From: Syed Saba kareem <syed.sabakareem@amd.com>

[ Upstream commit 5a4dd520ef8a94ecf81ac77b90d6a03e91c100a9 ]

Update Quirk data for new Lenovo model 83J2 for YC platform.

Signed-off-by: Syed Saba kareem <syed.sabakareem@amd.com>
Link: https://patch.msgid.link/20250321122507.190193-1-syed.sabakareem@amd.com
Reported-by: Reiner <Reiner.Proels@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219887
Tested-by: Reiner <Reiner.Proels@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 2536bd3d59464..622df58a96942 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -339,6 +339,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "83Q3"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83J2"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.39.5


