Return-Path: <stable+bounces-58772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA1492C019
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7ADDB2A64E
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6841A00FA;
	Tue,  9 Jul 2024 16:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgJx7xQ+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D127D1A00F1;
	Tue,  9 Jul 2024 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542032; cv=none; b=oYIuy4Zo2lw3HHRf7otc3pISNdx4z7sS928uuQ20AHDijU2d5G83dfMIjOgZMxWQqsekItygWh0j8bYTGW151+w/0HKW0Tefp0Jh+elEOaPGYmYA3VW6aCICVsDgd7xxoGgdxe0LydyTI403ODLx3QKCxMC+2XAIr3kY21P3Gzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542032; c=relaxed/simple;
	bh=V/ZRa9J/p3rqcdBHU99j6hDHjwssxO4dUcWX/EGiXLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mPJtUgJuW82QhMUiiE0QnlxggC4YT3+5INsXBZy4I+/PkRrwL9TXGqNXuDrsy0bAJ2tKw0rjYBRzjLAzKtxE+3Ns6g9oVRdscX041g5ArUWae65TMPMU8/+fGddKo1f7QG8clWvwJmHqD9VC0loNaPOSjzeeJ+x6QqWgjrBmp4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rgJx7xQ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957E7C32782;
	Tue,  9 Jul 2024 16:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542032;
	bh=V/ZRa9J/p3rqcdBHU99j6hDHjwssxO4dUcWX/EGiXLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rgJx7xQ+Gobhu9hTby8xjSv4mJa2DndVSbgSMvl2SJZsH1R5ja+O+WGOlFQ6cEU7k
	 VLCgeOEJOGP+tnfh4kMnJZ/OwL6tUa7qkVoVreXQZDD1aH5hNqJcVFJN82QnY5Z0n/
	 WIb0msyaa83yaCm7MLgn2SUuBGUoteh60JCdY7uEHOTRnvs+5P8J5eBZTay1k9lw1j
	 QIzKPeDCzcY4bj/u5HHo3WBZWgsc4uFsJa6d12ET+n+TatdZYwWMS7XQkXsA/8n/QG
	 7BApnhC1V6bN+NBtsl1DL+pwQyPqlN1MTAykNE3CcfHXLP3QQ3wjV6vEm2yuEgQOKp
	 CFnVYUtW0LPhA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 10/40] ASoC: topology: Clean up route loading
Date: Tue,  9 Jul 2024 12:18:50 -0400
Message-ID: <20240709162007.30160-10-sashal@kernel.org>
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

[ Upstream commit e0e7bc2cbee93778c4ad7d9a792d425ffb5af6f7 ]

Instead of using very long macro name, assign it to shorter variable
and use it instead. While doing that, we can reduce multiple if checks
using this define to one.

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Link: https://lore.kernel.org/r/20240603102818.36165-5-amadeuszx.slawinski@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-topology.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index ce22613bf9690..52752e0a5dc27 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1021,6 +1021,7 @@ static int soc_tplg_dapm_graph_elems_load(struct soc_tplg *tplg,
 	struct snd_soc_tplg_hdr *hdr)
 {
 	struct snd_soc_dapm_context *dapm = &tplg->comp->dapm;
+	const size_t maxlen = SNDRV_CTL_ELEM_ID_NAME_MAXLEN;
 	struct snd_soc_tplg_dapm_graph_elem *elem;
 	struct snd_soc_dapm_route *route;
 	int count, i;
@@ -1044,38 +1045,27 @@ static int soc_tplg_dapm_graph_elems_load(struct soc_tplg *tplg,
 		tplg->pos += sizeof(struct snd_soc_tplg_dapm_graph_elem);
 
 		/* validate routes */
-		if (strnlen(elem->source, SNDRV_CTL_ELEM_ID_NAME_MAXLEN) ==
-			    SNDRV_CTL_ELEM_ID_NAME_MAXLEN) {
-			ret = -EINVAL;
-			break;
-		}
-		if (strnlen(elem->sink, SNDRV_CTL_ELEM_ID_NAME_MAXLEN) ==
-			    SNDRV_CTL_ELEM_ID_NAME_MAXLEN) {
-			ret = -EINVAL;
-			break;
-		}
-		if (strnlen(elem->control, SNDRV_CTL_ELEM_ID_NAME_MAXLEN) ==
-			    SNDRV_CTL_ELEM_ID_NAME_MAXLEN) {
+		if ((strnlen(elem->source, maxlen) == maxlen) ||
+		    (strnlen(elem->sink, maxlen) == maxlen) ||
+		    (strnlen(elem->control, maxlen) == maxlen)) {
 			ret = -EINVAL;
 			break;
 		}
 
 		route->source = devm_kmemdup(tplg->dev, elem->source,
-					     min(strlen(elem->source),
-						 SNDRV_CTL_ELEM_ID_NAME_MAXLEN),
+					     min(strlen(elem->source), maxlen),
 					     GFP_KERNEL);
 		route->sink = devm_kmemdup(tplg->dev, elem->sink,
-					   min(strlen(elem->sink), SNDRV_CTL_ELEM_ID_NAME_MAXLEN),
+					   min(strlen(elem->sink), maxlen),
 					   GFP_KERNEL);
 		if (!route->source || !route->sink) {
 			ret = -ENOMEM;
 			break;
 		}
 
-		if (strnlen(elem->control, SNDRV_CTL_ELEM_ID_NAME_MAXLEN) != 0) {
+		if (strnlen(elem->control, maxlen) != 0) {
 			route->control = devm_kmemdup(tplg->dev, elem->control,
-						      min(strlen(elem->control),
-							  SNDRV_CTL_ELEM_ID_NAME_MAXLEN),
+						      min(strlen(elem->control), maxlen),
 						      GFP_KERNEL);
 			if (!route->control) {
 				ret = -ENOMEM;
-- 
2.43.0


