Return-Path: <stable+bounces-118789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A59E6A41C4D
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29B191894F9A
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F7E25B675;
	Mon, 24 Feb 2025 11:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNDfYMg/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62A924BC05;
	Mon, 24 Feb 2025 11:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395814; cv=none; b=MoXd9UVcpAARShiYOIs7Qp7z8gN9S9IDl5YNTulbpDFUwX17N4vVRr2oYR8fpnM5Rt8TYHWI/uToitp+0qWGnYf3p6/i4+AqNNmTGN7a4y29bbByX6COCRDmt7xC2KlGWkbWYfB6Nys2U+RZsIHxuGz1eqp9x582CujHiT8Qinc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395814; c=relaxed/simple;
	bh=UVkbI5i8lc5+DaTSrtxRJGsoOHi6QMHZGKskMyYWI6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o17qErLBKSwfAgvhE+ByW8S/2mZ0WPa9pW9DjLPGWdY10t4du5PbwgZYvrcQaoIN/haKcyuADVIIfpMXMcj6E5/+grXxpY3TFKj5jPnCsXVGth7VAGrJvVnVdS4F3N5tbkdLh/0rpkjo+DyOYo1VVLHHHdgr3B18qhTIASCROb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNDfYMg/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5D4C4CED6;
	Mon, 24 Feb 2025 11:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395814;
	bh=UVkbI5i8lc5+DaTSrtxRJGsoOHi6QMHZGKskMyYWI6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BNDfYMg/Qyph5EhFcfbOR2kG/f0W8213rIBIKHjH08s9RyA/NbWE6lFlu2C6EwybB
	 5FLiNnlduF+mI0MREhqCOL/X201gzG600BDpwv0Bx3FfQQco8ygYO+faZuHTcLMFE/
	 ysvl0I2K3WhNqyD0hn1LDnbIhQ/fsd2BwD6PsE5GUXeY0Bj+0JdMjEM9ZLZO8zYJI4
	 /L6jCObRINJ11OE5caXv75nAGDk5zMnqUUYtcIFQoFc3SroHAHky1FxnUXT1uNyv5k
	 usw7kJtmFwpxHlpRrhsX4laON8MFi19cVl8Fvz7kB+HZ6FVoD5MVQ5fNE2OtyP8fFb
	 nRwHbgdn5rzfg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>,
	Liam Girdwood <liam.r.girdwood@intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	cezary.rojewski@intel.com,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com,
	pierre-louis.bossart@linux.dev,
	ckeepax@opensource.cirrus.com,
	Vijendar.Mukunda@amd.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 05/32] ASoC: Intel: sof_sdw: Add quirk for Asus Zenbook S14
Date: Mon, 24 Feb 2025 06:16:11 -0500
Message-Id: <20250224111638.2212832-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111638.2212832-1-sashal@kernel.org>
References: <20250224111638.2212832-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.4
Content-Transfer-Encoding: 8bit

From: Richard Fitzgerald <rf@opensource.cirrus.com>

[ Upstream commit 0843449708085c4fb45a3c325c2fbced556f6abf ]

Asus laptops with sound PCI subsystem ID 1043:1e13 have the DMICs
connected to the host instead of the CS42L43 so need the
SOC_SDW_CODEC_MIC quirk.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://patch.msgid.link/20250204053943.93596-3-yung-chuan.liao@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_sdw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 62e71f56269d8..352c7a84cc2e8 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -751,6 +751,7 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 };
 
 static const struct snd_pci_quirk sof_sdw_ssid_quirk_table[] = {
+	SND_PCI_QUIRK(0x1043, 0x1e13, "ASUS Zenbook S14", SOC_SDW_CODEC_MIC),
 	{}
 };
 
-- 
2.39.5


