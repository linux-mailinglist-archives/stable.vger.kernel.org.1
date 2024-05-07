Return-Path: <stable+bounces-43410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5198BF288
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C88E1C235A5
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF9A3DABFD;
	Tue,  7 May 2024 23:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLBV3IZC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997433DABF2;
	Tue,  7 May 2024 23:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123630; cv=none; b=dDZ0sVtUypIt4r9uElS8p83BR+HlizVKkTFtHVNrbrtM6lJqa3wma0Pdqwm9UCpcb4dYoCEYvdXkIB/v4iJeo5vlqFU27KlvToBqIEQ9q2MUmzDBQekkbaCaZBNFTKckY6vQE7MWhx7dKQkXTDFDJZw7Jrq7Ax46op1/1w8Ktag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123630; c=relaxed/simple;
	bh=4Y7M1xTEGQHbVyYlH9eP0GGf9X/mGQlRD9Mm9W1YTxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AAvqFhP2J6yOPnSMEQ/th+ytfd1ZETblJl/AloysKmNtDK/wvHNp00FYWcB28ghajjp4XhqSL9tDD61cEnTMSTH45eSInMpwImh/vuCjYcIyKR5wJbr1bh6h+3iSl+UfwuK5elv0xxvhgR0BQuY0crrpCggzo0YZ2oQR3aIXg3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLBV3IZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600AAC4AF63;
	Tue,  7 May 2024 23:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123630;
	bh=4Y7M1xTEGQHbVyYlH9eP0GGf9X/mGQlRD9Mm9W1YTxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nLBV3IZCpykgXAJ8CDMpBuU20dynOoha2nMGLTbSuTb0ZMuju8bsRc8nRAIaDBc6d
	 raUtMKs0P3j4TOkPb50QkI9IzpvD+7loRCCyXdB40+XYLItr0niweqx96+5cfzoEYH
	 5MGgopTbg91pb+ta+txW3L/MUj1OkbEa60el6u7lnZnDdvfpk799JM6K5gBxX9JAt0
	 tFJoxZqyWD4zz7oTTGXDa+GH/T1MKnnkiqfJLrOP1u4EBIfv0MTdGsxegU23yOSFt0
	 bmUYMTvhh6y7CjUpIgeMgdtF30JZb/EbbRqy/RH9M968qA1v/D3q0HKlqROhLefUAd
	 cvJuCKhnbBGog==
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
Subject: [PATCH AUTOSEL 5.15 10/15] ASoC: da7219-aad: fix usage of device_get_named_child_node()
Date: Tue,  7 May 2024 19:13:19 -0400
Message-ID: <20240507231333.394765-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231333.394765-1-sashal@kernel.org>
References: <20240507231333.394765-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.158
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
index 4dc6eed6c18aa..99676c426f781 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -629,8 +629,10 @@ static struct da7219_aad_pdata *da7219_aad_fw_to_pdata(struct device *dev)
 		return NULL;
 
 	aad_pdata = devm_kzalloc(dev, sizeof(*aad_pdata), GFP_KERNEL);
-	if (!aad_pdata)
+	if (!aad_pdata) {
+		fwnode_handle_put(aad_np);
 		return NULL;
+	}
 
 	aad_pdata->irq = i2c->irq;
 
@@ -705,6 +707,8 @@ static struct da7219_aad_pdata *da7219_aad_fw_to_pdata(struct device *dev)
 	else
 		aad_pdata->adc_1bit_rpt = DA7219_AAD_ADC_1BIT_RPT_1;
 
+	fwnode_handle_put(aad_np);
+
 	return aad_pdata;
 }
 
-- 
2.43.0


