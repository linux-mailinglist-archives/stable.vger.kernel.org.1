Return-Path: <stable+bounces-118884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE80A41D49
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F172A189434D
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1ADD233723;
	Mon, 24 Feb 2025 11:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttVIb1C0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2AA23371F;
	Mon, 24 Feb 2025 11:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396055; cv=none; b=f/zpRT21f1psAq892W7D8Ur7iO0jgS4PCdLim8lZdpgxDA+7RDBsv0bUyuyacJ4gJrLxVUCl1s8nMtWJ48zmNT+CBbm7bxUo0Qr7DnLH1MqxYQHISBb0vTUG8f/l3mehZVCB9qcb/96v/a40bLfnjlV2meQ1ek8l4a90dV3OaZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396055; c=relaxed/simple;
	bh=1OXLo0LAR1N71lfPQvkQ1ANITGql7CpTEjDaL8Dt48c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o6IZZJew9UM+7lj7qzPikvlLNRQ5A6dj3mycbFL6JD/f3MnluDKI1w54YRVW2srK7abJGNRQ8sP33co/rt4YTjMG9HfBqNIDYjSf17JjtFqZooK5zoR5LJQDQP0t1ksxeKvRW2tFm+qz8Dv5iTu5IgI7joUICP/aZQSlpwUMtbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttVIb1C0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407C3C4CED6;
	Mon, 24 Feb 2025 11:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740396055;
	bh=1OXLo0LAR1N71lfPQvkQ1ANITGql7CpTEjDaL8Dt48c=;
	h=From:To:Cc:Subject:Date:From;
	b=ttVIb1C0p8IQnCS3bjnu2dFjr6qtBZxQQ2DhQifMNbt2qQxup0N2lqvijb/Eg3fJR
	 uN7718vnPoEELqmRBbdwYDJieKI32kN/vh0uvtSMhEuLvx7jaxY2RY1/JZz3oiae5y
	 nEUOdyX9iMmjgVxiEvbe++V6/6AYO/Ukh/UrXuMXoL+sAFLkDJKFnDamfJTBK9h/J/
	 dseqZYKfug7+yJhBX/+uDzQr75yEixTKVxswaz3lVK8Ke35YrNxnkLXlyYcfKh7atp
	 2VJKaf3v5vJG6mke590u+nBoBOxp5TmmMOFeaK9rr7UFA2zfLsPUtUKbYd2c2SFLl7
	 D9lUXyzlaYK7w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Uday M Bhat <uday.m.bhat@intel.com>,
	Jairaj Arava <jairaj.arava@intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	cezary.rojewski@intel.com,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com,
	pierre-louis.bossart@linux.dev,
	ckeepax@opensource.cirrus.com,
	Vijendar.Mukunda@amd.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 1/7] ASoC: Intel: sof_sdw: Add support for Fatcat board with BT offload enabled in PTL platform
Date: Mon, 24 Feb 2025 06:20:44 -0500
Message-Id: <20250224112051.2215017-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.234
Content-Transfer-Encoding: 8bit

From: Uday M Bhat <uday.m.bhat@intel.com>

[ Upstream commit d8989106287d3735c7e7fc6acb3811d62ebb666c ]

    This change adds an entry for fatcat boards in soundwire quirk table
    and also, enables BT offload for PTL RVP.

Signed-off-by: Uday M Bhat <uday.m.bhat@intel.com>
Signed-off-by: Jairaj Arava <jairaj.arava@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://patch.msgid.link/20250204053943.93596-4-yung-chuan.liao@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_sdw.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 25bf73a7e7bfa..387d7f679d64c 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -234,6 +234,16 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 		},
 		.driver_data = (void *)(RT711_JD2_100K),
 	},
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Google"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Fatcat"),
+		},
+		.driver_data = (void *)(SOC_SDW_PCH_DMIC |
+					SOF_BT_OFFLOAD_SSP(2) |
+					SOF_SSP_BT_OFFLOAD_PRESENT),
+	},
 	{}
 };
 
-- 
2.39.5


