Return-Path: <stable+bounces-67242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B32094F486
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BEB01C20E9C
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2571E186E5F;
	Mon, 12 Aug 2024 16:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G5cZUD0b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93FD183CD4;
	Mon, 12 Aug 2024 16:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723480281; cv=none; b=MePq3blvTLbmM8c8FWWRxQ8FVvzBC/p/6jlHl7FcTfbOIlh9te7N+dbLTFQbhkZRITHOI9jJLdr8e/4pheUObwJgyrx5OIsPN66ZpwOfRcftC6P8C873OqmgaekTUnXoMqu9vVUdEOdSKg0xKoW7R93YtNiRJpRlY5lEYruUSV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723480281; c=relaxed/simple;
	bh=Co5i59Wyx0z/Cej37AXmm3R//CvNME1ig+q6UzHdeTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DcMTOJevu6z8HdKR4Qabiyyv4gdmvHZjjz8DgtJOie0YdISRLGBueLkmwPBgw5miIJ0nu5/UqI1/i6azWGDLoiScsOqKuPJNvuvIkcsPiJFIhPuGhAAYu6BH1c3TNH8HmTw2SJdlODrdcxocAT2n86wxZcV8c87V209lptRIDnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G5cZUD0b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA35AC32782;
	Mon, 12 Aug 2024 16:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723480281;
	bh=Co5i59Wyx0z/Cej37AXmm3R//CvNME1ig+q6UzHdeTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G5cZUD0bjStiqpp9EZWymvQlZVv3LhRmA2LILxO0E3nuznoV1lW3e4f73gsRZqSw6
	 XIc6sT9iMBz2RqdwPqtf2cJfIj4TlGZs63ypf2fOTZue8mnqylLMd/qmgINjzmw6uX
	 QO0sbGXXQ4oDskp6Rfn4TubvP78VWMbV4bxgw3W4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Curtis Malainey <cujomalainey@chromium.org>,
	Wojciech Macek <wmacek@google.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 148/263] ASoC: SOF: Remove libraries from topology lookups
Date: Mon, 12 Aug 2024 18:02:29 +0200
Message-ID: <20240812160152.213717208@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812160146.517184156@linuxfoundation.org>
References: <20240812160146.517184156@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Curtis Malainey <cujomalainey@chromium.org>

[ Upstream commit 7354eb7f1558466e92e926802d36e69e42938ea9 ]

Default firmware shipped in open source are not licensed for 3P
libraries, therefore topologies should not reference them.

If a OS wants to use 3P (that they have licensed) then they should use
the appropriate topology override mechanisms.

Fixes: 8a7d5d85ed2161 ("ASoC: SOF: mediatek: mt8195: Add devicetree support to select topologies")
Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
Cc: Wojciech Macek <wmacek@google.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://patch.msgid.link/20240731212153.921327-1-cujomalainey@chromium.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/mediatek/mt8195/mt8195.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/mediatek/mt8195/mt8195.c b/sound/soc/sof/mediatek/mt8195/mt8195.c
index 31dc98d1b1d8b..8d3fc167cd810 100644
--- a/sound/soc/sof/mediatek/mt8195/mt8195.c
+++ b/sound/soc/sof/mediatek/mt8195/mt8195.c
@@ -573,7 +573,7 @@ static const struct snd_sof_dsp_ops sof_mt8195_ops = {
 static struct snd_sof_of_mach sof_mt8195_machs[] = {
 	{
 		.compatible = "google,tomato",
-		.sof_tplg_filename = "sof-mt8195-mt6359-rt1019-rt5682-dts.tplg"
+		.sof_tplg_filename = "sof-mt8195-mt6359-rt1019-rt5682.tplg"
 	}, {
 		.compatible = "mediatek,mt8195",
 		.sof_tplg_filename = "sof-mt8195.tplg"
-- 
2.43.0




