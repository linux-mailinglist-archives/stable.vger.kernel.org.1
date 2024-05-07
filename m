Return-Path: <stable+bounces-43311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF07F8BF19D
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0F241C2017F
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45ADD143891;
	Tue,  7 May 2024 23:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWT34EwK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6801350FE;
	Tue,  7 May 2024 23:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123342; cv=none; b=lS0cT2E7m9OuOfuP2l/cfQ3NsDaezCLd8tLSiNtnpGoUkqWnjDnPKXyOGCtLgYELvA82Z95fBgSHQelnSyvGq4tNOESzZZi8+uwJi28jb1zAeHhlRjyVF4s414ocNdRR6NrQNVJo1uV5b815ZwsGGzSJFNFVcfe5fyhg5YMBRNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123342; c=relaxed/simple;
	bh=pPFNJgP3ExZbYzaB6+JINPbSJcoMbjgUMEOefaHD+I4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YbxHERJdQvtCwYw+5KhE6XsymeuYZMv/qhELCSRnYGXU7UMO+7P030eCWopc+Hvg14U9sQzaOm3p80WNw4G1cp0/AZZ4IuozxA9HuytbYLq3OAmbOYOEEkd8Z6t60oVDPmcdW5/7ICCttA0L8lffG8TOeOrG38aXcaoWrvHkwvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWT34EwK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E47C4AF67;
	Tue,  7 May 2024 23:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123341;
	bh=pPFNJgP3ExZbYzaB6+JINPbSJcoMbjgUMEOefaHD+I4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bWT34EwKl5Byc5O8ZWi4tiAeMrq/FpFMfinQpQlgBPUkZymd7NgDOU/4kNFO0jgNS
	 aODF2YXynBnhn4Tl14FhQZX+AOS0FIIEEv87oxU95ktCm3oZ59OVvfZUj6lGxwnGBb
	 YeHgQXLBd9aSni8ridvUtoKzsIXwaf4JKLmJmysEEjsAa4rHTpm9X7lEjxVBGDVQ6X
	 KEqKzsmGORkzv3N3E6Z0B7tpoXj+DK7wfUktma/ggTUraqwVooVBEtRfiikBOHPh7Q
	 BLMAHuLheYRGdGkl3AbTFnAwj+0+IYsIhnXT8K3ugrV2FY2rRGxgqods3j1uOssAKX
	 JmLAGUa+N037Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.schulman@cirrus.com,
	david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 32/52] ASoC: cs35l56: fix usages of device_get_named_child_node()
Date: Tue,  7 May 2024 19:06:58 -0400
Message-ID: <20240507230800.392128-32-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230800.392128-1-sashal@kernel.org>
References: <20240507230800.392128-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit fbd741f0993203d07b2b6562d68d1e5e4745b59b ]

The documentation for device_get_named_child_node() mentions this
important point:

"
The caller is responsible for calling fwnode_handle_put() on the
returned fwnode pointer.
"

Add fwnode_handle_put() to avoid leaked references.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20240426152939.38471-1-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs35l56.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 6dd0319bc843c..ea72afe3f906f 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -1297,6 +1297,7 @@ static int cs35l56_try_get_broken_sdca_spkid_gpio(struct cs35l56_private *cs35l5
 				    "spk-id-gpios", ACPI_TYPE_PACKAGE, &obj);
 	if (ret) {
 		dev_dbg(cs35l56->base.dev, "Could not get spk-id-gpios package: %d\n", ret);
+		fwnode_handle_put(af01_fwnode);
 		return -ENOENT;
 	}
 
@@ -1304,6 +1305,7 @@ static int cs35l56_try_get_broken_sdca_spkid_gpio(struct cs35l56_private *cs35l5
 	if (obj->package.count != 4) {
 		dev_warn(cs35l56->base.dev, "Unexpected spk-id element count %d\n",
 			 obj->package.count);
+		fwnode_handle_put(af01_fwnode);
 		return -ENOENT;
 	}
 
@@ -1318,6 +1320,7 @@ static int cs35l56_try_get_broken_sdca_spkid_gpio(struct cs35l56_private *cs35l5
 		 */
 		ret = acpi_dev_add_driver_gpios(adev, cs35l56_af01_spkid_gpios_mapping);
 		if (ret) {
+			fwnode_handle_put(af01_fwnode);
 			return dev_err_probe(cs35l56->base.dev, ret,
 					     "Failed to add gpio mapping to AF01\n");
 		}
@@ -1325,14 +1328,17 @@ static int cs35l56_try_get_broken_sdca_spkid_gpio(struct cs35l56_private *cs35l5
 		ret = devm_add_action_or_reset(cs35l56->base.dev,
 					       cs35l56_acpi_dev_release_driver_gpios,
 					       adev);
-		if (ret)
+		if (ret) {
+			fwnode_handle_put(af01_fwnode);
 			return ret;
+		}
 
 		dev_dbg(cs35l56->base.dev, "Added spk-id-gpios mapping to AF01\n");
 	}
 
 	desc = fwnode_gpiod_get_index(af01_fwnode, "spk-id", 0, GPIOD_IN, NULL);
 	if (IS_ERR(desc)) {
+		fwnode_handle_put(af01_fwnode);
 		ret = PTR_ERR(desc);
 		return dev_err_probe(cs35l56->base.dev, ret, "Get GPIO from AF01 failed\n");
 	}
@@ -1341,9 +1347,12 @@ static int cs35l56_try_get_broken_sdca_spkid_gpio(struct cs35l56_private *cs35l5
 	gpiod_put(desc);
 
 	if (ret < 0) {
+		fwnode_handle_put(af01_fwnode);
 		dev_err_probe(cs35l56->base.dev, ret, "Error reading spk-id GPIO\n");
 		return ret;
-		}
+	}
+
+	fwnode_handle_put(af01_fwnode);
 
 	dev_info(cs35l56->base.dev, "Got spk-id from AF01\n");
 
-- 
2.43.0


