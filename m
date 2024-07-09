Return-Path: <stable+bounces-58770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A0492BFA7
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD4C1F25DE4
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8C619FA91;
	Tue,  9 Jul 2024 16:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5tTULeu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B8A19FA8D;
	Tue,  9 Jul 2024 16:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542029; cv=none; b=hlIrFOK2MZZ23NlNDZIcjFHULjHO+B/eJWP9XD2hvLqZO0M4mTDUgIDrrLHO+wgkQ1Ih9Gx9xA2vKqVVgd9Bj50ygRDy/2ZohA7PHgIGNLVPmgiA1ms00eHrK7RXFjy6cjFlDv9JviogmrwqAyt8rRXGMMNzAjtZ8VttDDs7MA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542029; c=relaxed/simple;
	bh=Xs7KqgNnRre63IGaFjAAQd7xd6ANQBVKXDlQIX5cul8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z91Z8hPVO/RwbLPWbmee6fbXGFf4kr5sPxK040bpNtsBGfmooQPHt/X4HNzfH2Bwn3lwY0tKCNwyBBWH4GHK6jPVI1NvjluHBgh5VAPBfKLyDrQCHXZkCSzXqUH/FYEvdaeOgipR1dUSb26TvdtYK+hQ/591x5DBXMkSE373RKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5tTULeu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14026C32786;
	Tue,  9 Jul 2024 16:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542028;
	bh=Xs7KqgNnRre63IGaFjAAQd7xd6ANQBVKXDlQIX5cul8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d5tTULeuhc8DySIX492MCnFOEFBe74HI0D3wrgNkkvsypnbjGBHtzV+wzZmnX/w5i
	 RxXVdEvJqIZT5ponaZKNs7kdd1vYb+HCwpQesPgvlwTo7/FlRa+srP3hUj6N5PQyNM
	 J2XGz7x6+mXVXfc4ne7FJxb/PXroviOoS6eo4ENpuq1YOp7as15gatCbQlRxwJmD6z
	 PRQA4tMIUgt3FgVKvAS3o/yUsXkj7H92R1peEy2iLsuYf6IItDRK8uaPPvHXTb3Bqp
	 m8Dqa/d0yVdXUvy93oVk6svbB9Q111FRqYy3ifiWFbHFExjlCXyrhA2AU+C8n+6ZHg
	 vY/XwcI+P5S/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
	Jason Montleon <jmontleo@redhat.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	pierre-louis.bossart@linux.intel.com,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com,
	justinstitt@google.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 08/40] ASoC: Intel: avs: Fix route override
Date: Tue,  9 Jul 2024 12:18:48 -0400
Message-ID: <20240709162007.30160-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162007.30160-1-sashal@kernel.org>
References: <20240709162007.30160-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.8
Content-Transfer-Encoding: 8bit

From: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

[ Upstream commit fd660b1bd015e5aa9a558ee04088f2431010548d ]

Instead of overriding existing memory strings that may be too short,
just allocate needed memory and point the route at it.

Reported-by: Jason Montleon <jmontleo@redhat.com>
Link: https://github.com/thesofproject/avs-topology-xml/issues/22#issuecomment-2127892605
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Link: https://lore.kernel.org/r/20240603102818.36165-3-amadeuszx.slawinski@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/avs/topology.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/avs/topology.c b/sound/soc/intel/avs/topology.c
index 42b42903ae9de..691d16ce95a0f 100644
--- a/sound/soc/intel/avs/topology.c
+++ b/sound/soc/intel/avs/topology.c
@@ -1545,8 +1545,8 @@ static int avs_route_load(struct snd_soc_component *comp, int index,
 {
 	struct snd_soc_acpi_mach *mach = dev_get_platdata(comp->card->dev);
 	size_t len = SNDRV_CTL_ELEM_ID_NAME_MAXLEN;
-	char buf[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
 	int ssp_port, tdm_slot;
+	char *buf;
 
 	/* See parse_link_formatted_string() for dynamic naming when(s). */
 	if (!avs_mach_singular_ssp(mach))
@@ -1557,13 +1557,24 @@ static int avs_route_load(struct snd_soc_component *comp, int index,
 		return 0;
 	tdm_slot = avs_mach_ssp_tdm(mach, ssp_port);
 
+	buf = devm_kzalloc(comp->card->dev, len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
 	avs_ssp_sprint(buf, len, route->source, ssp_port, tdm_slot);
-	strscpy((char *)route->source, buf, len);
+	route->source = buf;
+
+	buf = devm_kzalloc(comp->card->dev, len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
 	avs_ssp_sprint(buf, len, route->sink, ssp_port, tdm_slot);
-	strscpy((char *)route->sink, buf, len);
+	route->sink = buf;
+
 	if (route->control) {
+		buf = devm_kzalloc(comp->card->dev, len, GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
 		avs_ssp_sprint(buf, len, route->control, ssp_port, tdm_slot);
-		strscpy((char *)route->control, buf, len);
+		route->control = buf;
 	}
 
 	return 0;
-- 
2.43.0


