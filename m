Return-Path: <stable+bounces-94948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 142AE9D7238
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C863CB44210
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437D91DF972;
	Sun, 24 Nov 2024 13:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSFzJLN6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CC41AA1DF;
	Sun, 24 Nov 2024 13:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455355; cv=none; b=R9d2h8R0o/jknRyrRR7oWL0DVMpk5iRQXIp1H0gDoaTq3NkPCGsczo3iKLfWirM6N1xKSSosqPR24kpIhj9onJdyeIp5Xqz13sNE7GKQQaq3NdZriH3IEwd2NNg/rovfNBHGvBVk0ShsNOze2AjE1mvNi+au4CWdRpCR2OjABe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455355; c=relaxed/simple;
	bh=+id0chv1ppeWWZS+JhDxOJBJJvI7P9GnOUKfSzOMYzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LlQutEyta79pU6z544/T2p7kHQGA8QklwpqxN2/7rEoC1PMRF/VxdyztBn8HYuYt99gdXKB1oSavairEx5Jj2TzRyTnwcbkV+SKhdiFNVtgD3ka6Tw40pKNwrta7De3plvGTmbbKUOiDqkT3iwIkkj3GjIHwqFQjlCLIdJjVXBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSFzJLN6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0452FC4CECC;
	Sun, 24 Nov 2024 13:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455354;
	bh=+id0chv1ppeWWZS+JhDxOJBJJvI7P9GnOUKfSzOMYzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QSFzJLN6NwLLS3M1XGI4vJv6XCB0OUzgf625haUzzau/aTn4v7PhwVeQ6wKkkkXwR
	 Kn8DKk1GlhYrga9P90GsOMdoA/csEsVUkh5Fd2aMEFhzS58d4NKN2i+bFgAEm+qht6
	 7FSp/cJdEn4eMcJkcwdpciS219N2N6QNhq0GxF6eXnGuFtX0fe/T6/RkJqQT78tjS9
	 DqM1qN+VRq2Zl0GM67jIq/T+7KJXGABZxJPT8RdU4fZk/n7DLRtcTTEVFISqwV35JE
	 CnbgPhMM4vi5HI+6YOSWOcCD/SV7kXnzrVLgf4Y8srFeQNyG3yoHrMQ/sETvJM9W7k
	 /Me2Jn7MF5XLw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
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
	Vijendar.Mukunda@amd.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 052/107] ASoC: Intel: sof_sdw: Add quirk for cs42l43 system using host DMICs
Date: Sun, 24 Nov 2024 08:29:12 -0500
Message-ID: <20241124133301.3341829-52-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit ea657f6b24e11651a39292082be84ad81a89e525 ]

Add quirk to inform the machine driver to not bind in the cs42l43
microphone DAI link.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://patch.msgid.link/20241016030344.13535-4-yung-chuan.liao@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_sdw.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 4a0ab50d1e50d..fa937cc4d8cd1 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -580,6 +580,15 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 		},
 		.driver_data = (void *)(SOC_SDW_CODEC_SPKR),
 	},
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "233C")
+		},
+		/* Note this quirk excludes the CODEC mic */
+		.driver_data = (void *)(SOC_SDW_CODEC_MIC),
+	},
 
 	/* ArrowLake devices */
 	{
-- 
2.43.0


