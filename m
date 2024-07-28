Return-Path: <stable+bounces-62258-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B6B93E7AD
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 18:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DC1B28619A
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 16:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0611113A896;
	Sun, 28 Jul 2024 16:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKsGfflv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59BD13A405;
	Sun, 28 Jul 2024 16:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182779; cv=none; b=dk8t/3fpvBdoU43EQnkh66Tzr/fNdrEB9fAXgb4ibyDwMmZ5apasDXZHsY7MI4/lXL/0sXnx6C3t/HcSei9xOg8i9rA3bOah6y2HKELH/lG9GH1m+MbQnYzmp4kfI/mAUjKql24CGuJE/qlq8yyTyqwdou+O5Gw8uzYt0KaFdyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182779; c=relaxed/simple;
	bh=EtTQakw4m02zIxSMaQ7YLbjlLW5pHF9AEO1dzIMYgmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AU6aGCVYZTSbaieVR8GbYKgy4WBykMIWY11zKuxLDUR42iZiIdbJBZEq6pt9HAST+AJwGpwvrTVItlSGAWIkyuwtZFmFyisHiJGI5kOzv6DXg/ZAFWdZ5fDoYN4yW6iXjlHjbdDWoTw0hDnWS5hJGNkV83gEVYDLR5AVmYlXAw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKsGfflv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DCDAC116B1;
	Sun, 28 Jul 2024 16:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182779;
	bh=EtTQakw4m02zIxSMaQ7YLbjlLW5pHF9AEO1dzIMYgmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QKsGfflvTZNugby3u5AUiqd9kq3wJj4k169ZBv+x8Izfygk0D2CRj4IW/rG47t2ND
	 Puq0GsmPN0yCsMXgvXm7z8Gzxo0dWpxylKGeOHmjQgggLTBC7TTLoYIQKSV/OevQkK
	 UcBkUlBc5o0oznjUHrtADpoLQ8qv4qHMJytSObGUUzAkxMmseQpmeaujZnX5OtKbzh
	 7SRIXIhmX+TjkrS2cmY+4XYJXlfv0k8xkgMrF+1RyJI5gPJSUQx2KGGVF2DULqkydC
	 O057iu8M4x0hRdvDKlTjo2lRBo2RVGmYPJ9NGl3f1GbFteBrnmTv2nB3kK1GhhnHv0
	 tbpWqzO6hXlEQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	cezary.rojewski@intel.com,
	liam.r.girdwood@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com,
	ckeepax@opensource.cirrus.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 15/23] ASoC: Intel: sof_sdw: add quirk for Dell SKU 0B8C
Date: Sun, 28 Jul 2024 12:04:56 -0400
Message-ID: <20240728160538.2051879-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160538.2051879-1-sashal@kernel.org>
References: <20240728160538.2051879-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit 92d5b5930e7d55ca07b483490d6298eee828bbe4 ]

Jack detection needs to rely on JD2, as most other Dell
AlderLake-based devices.

Closes: https://github.com/thesofproject/linux/issues/5021
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://patch.msgid.link/20240624121119.91552-4-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_sdw.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 965d46968f95a..0b3b2c88d31ed 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -406,6 +406,15 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 		/* No Jack */
 		.driver_data = (void *)SOF_SDW_TGL_HDMI,
 	},
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "0B8C"),
+		},
+		.driver_data = (void *)(SOF_SDW_TGL_HDMI |
+					RT711_JD2),
+	},
 	{
 		.callback = sof_sdw_quirk_cb,
 		.matches = {
-- 
2.43.0


