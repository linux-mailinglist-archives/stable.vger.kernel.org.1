Return-Path: <stable+bounces-46478-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6B88D06A1
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 17:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E15CC288AA3
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 15:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3765373478;
	Mon, 27 May 2024 15:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zuol8982"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBACE17E8EC;
	Mon, 27 May 2024 15:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825107; cv=none; b=ufbOOyvsQNeYYg0gLzo78nwtZ4ChNLCh+Jubf2F0Yq0qCujT41bU+vaPQMLRmp4YY5OwJuYTWU0m2gC5rDl0jo347qrDI9KNBEQM7cy0hGgIeAJO0w/NEQjMGc+CSI58APYSKJ7KsyznM6uKwjLaXIqrIftPxPLfPnuWxWRw2lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825107; c=relaxed/simple;
	bh=mX5Apq4HueNKh2Lka3LyHKzCw9/ATmUlhhIHaGKdgUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bawEdpXduF8ZhvwsKcBmuUHh+lx1oEeFlgX1mTnA9WAiQ6QXddyLXB8oxO8YizyrJ5FZpVG5kwbkwNM8Tlb2gAxsH6upMzzA8cwTlg8vrJh8mh7bW0JioG1b1IuEIVlWGb5qG5bJV4t+jeN8DbVqTFTdHkgJkuYgxHu93exCug4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zuol8982; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8486C32781;
	Mon, 27 May 2024 15:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716825106;
	bh=mX5Apq4HueNKh2Lka3LyHKzCw9/ATmUlhhIHaGKdgUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zuol8982ekg+5COYR6QoZYsZPIxTKDI4Ur9tyAd8PbKFNCBWGRPlNCUHb3kitTRZ/
	 YP7I00HNLq+k/ZurEW1Oo5y9q1z9Wfwr+IzBbUQYacRHAieSf//7ywj7GqOWgDzfcs
	 +i9Ms+glxo1efTnTz+/ABYfpIhdslXyrqVD1Xz9dCuceCAmBTb+oR5ZlexmCKINS3B
	 fuak5PBEEZw9T8aQUbYZbEDm9EggSgOWdRPpdW9KmO7k7VuuWL8+YANg63oNYHjrrF
	 Y1jeR7L9G0Lss5leF0yrXmZ2tW13Rqx0yerQ9Bbo+XlTm9Wf22pm5bxWYhCUbtwDuV
	 dsY49MdVMnAaw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Brent Lu <brent.lu@intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	cezary.rojewski@intel.com,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com,
	kuninori.morimoto.gx@renesas.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 03/23] ASoC: Intel: sof_cs42l42: rename BT offload quirk
Date: Mon, 27 May 2024 11:50:04 -0400
Message-ID: <20240527155123.3863983-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527155123.3863983-1-sashal@kernel.org>
References: <20240527155123.3863983-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.2
Content-Transfer-Encoding: 8bit

From: Brent Lu <brent.lu@intel.com>

[ Upstream commit 109896246a5311aa05692ecf38c0d71e1837fe23 ]

Rename the quirk in preparation for future changes: common quriks will
be defined and handled in board helper module.

Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Brent Lu <brent.lu@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://msgid.link/r/20240325221059.206042-7-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_cs42l42.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/sof_cs42l42.c b/sound/soc/intel/boards/sof_cs42l42.c
index 323b86c42ef95..330d596b2eb6d 100644
--- a/sound/soc/intel/boards/sof_cs42l42.c
+++ b/sound/soc/intel/boards/sof_cs42l42.c
@@ -34,7 +34,7 @@
 #define SOF_CS42L42_NUM_HDMIDEV_MASK		(GENMASK(9, 7))
 #define SOF_CS42L42_NUM_HDMIDEV(quirk)	\
 	(((quirk) << SOF_CS42L42_NUM_HDMIDEV_SHIFT) & SOF_CS42L42_NUM_HDMIDEV_MASK)
-#define SOF_BT_OFFLOAD_PRESENT			BIT(25)
+#define SOF_CS42L42_BT_OFFLOAD_PRESENT		BIT(25)
 #define SOF_CS42L42_SSP_BT_SHIFT		26
 #define SOF_CS42L42_SSP_BT_MASK			(GENMASK(28, 26))
 #define SOF_CS42L42_SSP_BT(quirk)	\
@@ -268,7 +268,7 @@ static int sof_audio_probe(struct platform_device *pdev)
 
 	ctx->ssp_codec = sof_cs42l42_quirk & SOF_CS42L42_SSP_CODEC_MASK;
 
-	if (sof_cs42l42_quirk & SOF_BT_OFFLOAD_PRESENT)
+	if (sof_cs42l42_quirk & SOF_CS42L42_BT_OFFLOAD_PRESENT)
 		ctx->bt_offload_present = true;
 
 	/* update dai_link */
@@ -306,7 +306,7 @@ static const struct platform_device_id board_ids[] = {
 		.driver_data = (kernel_ulong_t)(SOF_CS42L42_SSP_CODEC(0) |
 				SOF_CS42L42_SSP_AMP(1) |
 				SOF_CS42L42_NUM_HDMIDEV(4) |
-				SOF_BT_OFFLOAD_PRESENT |
+				SOF_CS42L42_BT_OFFLOAD_PRESENT |
 				SOF_CS42L42_SSP_BT(2)),
 	},
 	{ }
-- 
2.43.0


