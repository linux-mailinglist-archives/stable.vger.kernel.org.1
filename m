Return-Path: <stable+bounces-49179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B748FEC34
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15F761C250E9
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D0F1AED29;
	Thu,  6 Jun 2024 14:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="auKHAuDI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839A319AD5F;
	Thu,  6 Jun 2024 14:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683340; cv=none; b=TeiGhSlFHADJdSGFHlDlJyOPkBH7h1ymInjtwhM1ZvKvGiQ1L8SdnG+clXC0e/qJjg1aTWNaN4cRnlY5/3X7YYVOIf6xvd+AW10kPLzz9GknGmU3Nn4ZeEu/rUH2E6yqHX+YLb+wVAbnNzsQcZgvSEp85IpL6PQuHN8IO6Pbbds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683340; c=relaxed/simple;
	bh=f0xydeToaZa+Qu5v5+bBttuHFpSpKR7uZffrQpG0mUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bEK7P5nQn82hrI3RgucNYoqi5QmxjL9DV9U6V1rBC99yi/tHG0LeOIXXb0zZ9WfuR6AIuszhEer2RXdDMRGQ+Z2EhMW2R79hHj/rAwFD7qnxgG5FuVIUwBlPXG0SU/I+lfxPAvN2iMgzHNTSSxAq5sPKemxwCmHsgAZIMcgD8uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=auKHAuDI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E35C2BD10;
	Thu,  6 Jun 2024 14:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683340;
	bh=f0xydeToaZa+Qu5v5+bBttuHFpSpKR7uZffrQpG0mUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=auKHAuDIljKSUpaxCFpu2ZmsIG02+RhvoiWhY7Im2wyYs6uBefGvpUGT6qWSZLHOu
	 Ha/u36iI+BnOa/iEi6ArrgFV3T0viYsbj2fj6uRuXYeI+u3k2+TQxocVy1CfZTUuVR
	 lPbN4dQDluEVV766kuA51bUu6z/VUy1GpZNb89ow=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 281/744] ASoC: Intel: avs: ssm4567: Do not ignore route checks
Date: Thu,  6 Jun 2024 15:59:13 +0200
Message-ID: <20240606131741.421114063@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cezary Rojewski <cezary.rojewski@intel.com>

[ Upstream commit e6719d48ba6329536c459dcee5a571e535687094 ]

A copy-paste from intel/boards/skl_nau88l25_ssm4567.c made the avs's
equivalent disable route checks as well. Such behavior is not desired.

Fixes: 69ea14efe99b ("ASoC: Intel: avs: Add ssm4567 machine board")
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Link: https://msgid.link/r/20240308090502.2136760-4-cezary.rojewski@intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/avs/boards/ssm4567.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/intel/avs/boards/ssm4567.c b/sound/soc/intel/avs/boards/ssm4567.c
index 7324869d61327..7db1b89b0d9e9 100644
--- a/sound/soc/intel/avs/boards/ssm4567.c
+++ b/sound/soc/intel/avs/boards/ssm4567.c
@@ -166,7 +166,6 @@ static int avs_ssm4567_probe(struct platform_device *pdev)
 	card->dapm_routes = card_base_routes;
 	card->num_dapm_routes = ARRAY_SIZE(card_base_routes);
 	card->fully_routed = true;
-	card->disable_route_checks = true;
 
 	ret = snd_soc_fixup_dai_links_platform_name(card, pname);
 	if (ret)
-- 
2.43.0




