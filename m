Return-Path: <stable+bounces-43358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D637A8BF20B
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BD021F210E6
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212EC16EC12;
	Tue,  7 May 2024 23:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McY5wBn9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC7216EBF5;
	Tue,  7 May 2024 23:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123482; cv=none; b=cxidTRWZvxm9d57srWtCf7xbXkUF6UJIW25OAhTYiKQq2UcgoH8EtBMzH009Ivfqr/Mos9XK/l84iYVVyioYQPtCHW0hqkhOvZuyaaz3j3XKrRdudOv1bJlm59EgPGkoHUKq66vrSIis7ETGJz4zc44mcXURRTz5Ls8QcQLwbMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123482; c=relaxed/simple;
	bh=J1X4zuAtY0+5rFPUi5kT3JJvSZcfd582Gxlh8pfClnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kr6nNrh4+q3xEzJ+faTBzWEW0q1yVotRud954FfRJ9TiFZ/fPjy+aP76MI9lLsJUcSz0jQpNXiYuI3aZ0UXbOxlH/bsXSJrMWOJh5J5paXOB+rrOeHWudIhrKYJUVKniSbeg5rnaznG/eFA4YX5cbMXuv8l7LUudQJ+Iv35u91o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McY5wBn9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3CAC4AF17;
	Tue,  7 May 2024 23:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123482;
	bh=J1X4zuAtY0+5rFPUi5kT3JJvSZcfd582Gxlh8pfClnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=McY5wBn9HW8tMT6BXaXpVFeGdgzx9mJXdRwCXQq6pA3XfPvogpIH7EhsEvpFrZtSH
	 xwGmLgQaYIIlxX2X71GruleQhWP8nzfbb/qUU9/0+0a7dUJjYCf0Qx1/aJrAcrdCvC
	 daWSkyNybKi37NOyHQtweNvYPlkw52cVQVhAbqnlvwm1gq7iZt1gU7JtAGIWrtTwgL
	 w/BsPftjcvOA4rYQDQAJEpBD3OZeJ1xJ7Zr//hPJ3nXsMJrdz00LA8KwFfjL36/zie
	 626vsqT/smHy7VDbaBNflYEt4s3uhe31V2CXggSVDNeKHgiRNuZUxL23I5lW4eo3ws
	 Neegf+7PAFPIg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	support.opensource@diasemi.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 26/43] ASoC: da7219-aad: fix usage of device_get_named_child_node()
Date: Tue,  7 May 2024 19:09:47 -0400
Message-ID: <20240507231033.393285-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231033.393285-1-sashal@kernel.org>
References: <20240507231033.393285-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit e8a6a5ad73acbafd98e8fd3f0cbf6e379771bb76 ]

The documentation for device_get_named_child_node() mentions this
important point:

"
The caller is responsible for calling fwnode_handle_put() on the
returned fwnode pointer.
"

Add fwnode_handle_put() to avoid a leaked reference.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20240426153033.38500-1-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/da7219-aad.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index 8537c96307a97..9b0c470181706 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -671,8 +671,10 @@ static struct da7219_aad_pdata *da7219_aad_fw_to_pdata(struct device *dev)
 		return NULL;
 
 	aad_pdata = devm_kzalloc(dev, sizeof(*aad_pdata), GFP_KERNEL);
-	if (!aad_pdata)
+	if (!aad_pdata) {
+		fwnode_handle_put(aad_np);
 		return NULL;
+	}
 
 	aad_pdata->irq = i2c->irq;
 
@@ -753,6 +755,8 @@ static struct da7219_aad_pdata *da7219_aad_fw_to_pdata(struct device *dev)
 	else
 		aad_pdata->adc_1bit_rpt = DA7219_AAD_ADC_1BIT_RPT_1;
 
+	fwnode_handle_put(aad_np);
+
 	return aad_pdata;
 }
 
-- 
2.43.0


