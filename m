Return-Path: <stable+bounces-58846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A71AC92C0AC
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E5971F22294
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED992101B8;
	Tue,  9 Jul 2024 16:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+qWdHYN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B56721018F;
	Tue,  9 Jul 2024 16:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542264; cv=none; b=fDuBZi9RbYsUoqlDXfRqm7ao6+joS1ayj559OFSBco24N0VHo7h9jdeV96/GFFGtySPMee+vOoDVC3Dt3d2htdcbqd1j26Q95IqTibt7wMVWKXe3IcLaTcVvlz2G5ku15B8Cpk09T4XPdtAeFOhsEtgo9MWVopUUTjXQC7/0NqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542264; c=relaxed/simple;
	bh=a6At4Js4R/IMnqMtV0xD484JF8aA8JO64IkabqMQpsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=soD1Y+isN6e1ipGuv3T25J+Loi7qrt7th/xXNPVmK/xUSAwRBc/gcAJM1vZUwThw38wVLrPRV7KYTr3SLqWwmSlNi0X6/ZcB2E/HV9PCYWbxP2z48TOTWlBdA8rBc86DOKropJVlPrgKDCXH1/YnZ1BXIghhl7g/zIiU5xPI2qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+qWdHYN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D08C3277B;
	Tue,  9 Jul 2024 16:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542264;
	bh=a6At4Js4R/IMnqMtV0xD484JF8aA8JO64IkabqMQpsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m+qWdHYNPai3wzyKUnbKLp7eEOdspYO0EM+kyZ97KZP+2vBnvL1V1jO38X0SxnsGj
	 If5FBZ2padLMQdL50my1UjDSLTHETyQG+Fl6qZ/idqONRoOc7P4wgoY60LyMx9ARRX
	 Lffp0fs2g9om3/g5i9+S9tv3c2nA91GN/qLyLyhBQbEG/kApaQBvWGfpviP4MTLsst
	 iE/Bft1fSYto3AfRITHevR4xmW2+zky+7mNMkQOYo4arnuCLuji3RP6wB+B8au8vCs
	 l356jN9xvi87IbhDeYHPITl0aBHeWQcQ64BSc216c9rkO+pPyCoU7NFW+mPvJ36+8G
	 dQxVBd/S2gsmw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 11/27] ASoC: topology: Fix route memory corruption
Date: Tue,  9 Jul 2024 12:23:25 -0400
Message-ID: <20240709162401.31946-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162401.31946-1-sashal@kernel.org>
References: <20240709162401.31946-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.97
Content-Transfer-Encoding: 8bit

From: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

[ Upstream commit 0298f51652be47b79780833e0b63194e1231fa34 ]

It was reported that recent fix for memory corruption during topology
load, causes corruption in other cases. Instead of being overeager with
checking topology, assume that it is properly formatted and just
duplicate strings.

Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Closes: https://lore.kernel.org/linux-sound/171812236450.201359.3019210915105428447.b4-ty@kernel.org/T/#m8c4bd5abf453960fde6f826c4b7f84881da63e9d
Suggested-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Link: https://lore.kernel.org/r/20240613090126.841189-1-amadeuszx.slawinski@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-topology.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index e84fbb56ebf11..fcb8a36d4a06c 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1093,21 +1093,15 @@ static int soc_tplg_dapm_graph_elems_load(struct soc_tplg *tplg,
 			break;
 		}
 
-		route->source = devm_kmemdup(tplg->dev, elem->source,
-					     min(strlen(elem->source), maxlen),
-					     GFP_KERNEL);
-		route->sink = devm_kmemdup(tplg->dev, elem->sink,
-					   min(strlen(elem->sink), maxlen),
-					   GFP_KERNEL);
+		route->source = devm_kstrdup(tplg->dev, elem->source, GFP_KERNEL);
+		route->sink = devm_kstrdup(tplg->dev, elem->sink, GFP_KERNEL);
 		if (!route->source || !route->sink) {
 			ret = -ENOMEM;
 			break;
 		}
 
 		if (strnlen(elem->control, maxlen) != 0) {
-			route->control = devm_kmemdup(tplg->dev, elem->control,
-						      min(strlen(elem->control), maxlen),
-						      GFP_KERNEL);
+			route->control = devm_kstrdup(tplg->dev, elem->control, GFP_KERNEL);
 			if (!route->control) {
 				ret = -ENOMEM;
 				break;
-- 
2.43.0


