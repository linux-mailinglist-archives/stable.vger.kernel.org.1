Return-Path: <stable+bounces-3926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BB7803F90
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 21:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8931C20BFF
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 20:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD71533CC6;
	Mon,  4 Dec 2023 20:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CH8UioJ4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC5935EF8;
	Mon,  4 Dec 2023 20:34:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94956C433C7;
	Mon,  4 Dec 2023 20:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701722046;
	bh=W49vv/JqMjouqkjwibwavXXrMU6TnI5qndMQ4YxP1eY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CH8UioJ4A6yE1cqgx8BiAuX8ms2KbruZ4lJzvB1Klb985r1BxIzBjnUxVFW+GqSm8
	 lBZOkjCz1+DSPqy5LF76Xmup/nviQhlhg8xJifDnRt0H0oRCwZeyTQ2+IL27MK5xCK
	 wBUFHHrOe7A5+bGbJ4fCbMnsfc8p1+1U2NNkzBgiHou+yJ2jJTEydWQhNjoWTh+bvr
	 Pt+JRil7ZdliTifUbTIWEqkMvFzEolxi0DRv0/i2/qRsx4N19TSl2Jbn1Mb8Nf0LEv
	 Uj2RDnWGrbuOgyNL+w6Oek6B0BmXqLbH5XK+xnc4Wi/uTFCKrFzX7U3pg9cJ9Ga4DO
	 QAKJe7STGs00A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 19/32] ALSA: hda: intel-nhlt: Ignore vbps when looking for DMIC 32 bps format
Date: Mon,  4 Dec 2023 15:32:39 -0500
Message-ID: <20231204203317.2092321-19-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203317.2092321-1-sashal@kernel.org>
References: <20231204203317.2092321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.4
Content-Transfer-Encoding: 8bit

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit 7b4c93a50a2ebbbaf656cc4fa6aca74a6166d85b ]

When looking up DMIC blob from the NHLT table and the format is 32 bits,
ignore the vbps matching for 32 bps for DMIC since some NHLT table have
the vbps as 24, some have it as 32.
The DMIC hardware supports only one type of 32 bit sample size, which is
24 bit sampling on the MSB side and bits[1:0] is used for indicating the
channel number.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://lore.kernel.org/r/20231127111658.17275-1-peter.ujfalusi@linux.intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/intel-nhlt.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/sound/hda/intel-nhlt.c b/sound/hda/intel-nhlt.c
index 2c4dfc0b7e342..696a958d93e9c 100644
--- a/sound/hda/intel-nhlt.c
+++ b/sound/hda/intel-nhlt.c
@@ -238,7 +238,7 @@ EXPORT_SYMBOL(intel_nhlt_ssp_mclk_mask);
 
 static struct nhlt_specific_cfg *
 nhlt_get_specific_cfg(struct device *dev, struct nhlt_fmt *fmt, u8 num_ch,
-		      u32 rate, u8 vbps, u8 bps)
+		      u32 rate, u8 vbps, u8 bps, bool ignore_vbps)
 {
 	struct nhlt_fmt_cfg *cfg = fmt->fmt_config;
 	struct wav_fmt *wfmt;
@@ -255,8 +255,12 @@ nhlt_get_specific_cfg(struct device *dev, struct nhlt_fmt *fmt, u8 num_ch,
 		dev_dbg(dev, "Endpoint format: ch=%d fmt=%d/%d rate=%d\n",
 			wfmt->channels, _vbps, _bps, wfmt->samples_per_sec);
 
+		/*
+		 * When looking for exact match of configuration ignore the vbps
+		 * from NHLT table when ignore_vbps is true
+		 */
 		if (wfmt->channels == num_ch && wfmt->samples_per_sec == rate &&
-		    vbps == _vbps && bps == _bps)
+		    (ignore_vbps || vbps == _vbps) && bps == _bps)
 			return &cfg->config;
 
 		cfg = (struct nhlt_fmt_cfg *)(cfg->config.caps + cfg->config.size);
@@ -289,6 +293,7 @@ intel_nhlt_get_endpoint_blob(struct device *dev, struct nhlt_acpi_table *nhlt,
 {
 	struct nhlt_specific_cfg *cfg;
 	struct nhlt_endpoint *epnt;
+	bool ignore_vbps = false;
 	struct nhlt_fmt *fmt;
 	int i;
 
@@ -298,7 +303,26 @@ intel_nhlt_get_endpoint_blob(struct device *dev, struct nhlt_acpi_table *nhlt,
 	dev_dbg(dev, "Looking for configuration:\n");
 	dev_dbg(dev, "  vbus_id=%d link_type=%d dir=%d, dev_type=%d\n",
 		bus_id, link_type, dir, dev_type);
-	dev_dbg(dev, "  ch=%d fmt=%d/%d rate=%d\n", num_ch, vbps, bps, rate);
+	if (link_type == NHLT_LINK_DMIC && bps == 32 && (vbps == 24 || vbps == 32)) {
+		/*
+		 * The DMIC hardware supports only one type of 32 bits sample
+		 * size, which is 24 bit sampling on the MSB side and bits[1:0]
+		 * are used for indicating the channel number.
+		 * It has been observed that some NHLT tables have the vbps
+		 * specified as 32 while some uses 24.
+		 * The format these variations describe are identical, the
+		 * hardware is configured and behaves the same way.
+		 * Note: when the samples assumed to be vbps=32 then the 'noise'
+		 * introduced by the lower two bits (channel number) have no
+		 * real life implication on audio quality.
+		 */
+		dev_dbg(dev,
+			"  ch=%d fmt=%d rate=%d (vbps is ignored for DMIC 32bit format)\n",
+			num_ch, bps, rate);
+		ignore_vbps = true;
+	} else {
+		dev_dbg(dev, "  ch=%d fmt=%d/%d rate=%d\n", num_ch, vbps, bps, rate);
+	}
 	dev_dbg(dev, "Endpoint count=%d\n", nhlt->endpoint_count);
 
 	epnt = (struct nhlt_endpoint *)nhlt->desc;
@@ -307,7 +331,8 @@ intel_nhlt_get_endpoint_blob(struct device *dev, struct nhlt_acpi_table *nhlt,
 		if (nhlt_check_ep_match(dev, epnt, bus_id, link_type, dir, dev_type)) {
 			fmt = (struct nhlt_fmt *)(epnt->config.caps + epnt->config.size);
 
-			cfg = nhlt_get_specific_cfg(dev, fmt, num_ch, rate, vbps, bps);
+			cfg = nhlt_get_specific_cfg(dev, fmt, num_ch, rate,
+						    vbps, bps, ignore_vbps);
 			if (cfg)
 				return cfg;
 		}
-- 
2.42.0


