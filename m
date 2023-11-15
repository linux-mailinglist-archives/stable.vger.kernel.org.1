Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2247E7ECF16
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235222AbjKOTqR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235221AbjKOTqQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:46:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBEEAB
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:46:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD8AC433C9;
        Wed, 15 Nov 2023 19:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077572;
        bh=C9UF4rlKc0PHbJIMlEzVgixzeVXEgq0qA40f8K6pwHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k1DT/WijVu+7FbezZzsucdUE7p8uuKmzuFPNimR6BZDQEbHEs5VRnnoLGCNbWMfzm
         A7SzjCs/6o+PUleGOOr6r+eJHsyTcs8/39RaIQ2zvgVIjXRgM68ZMydHpgfKqkvm9G
         mpfeprMFCwDDT9s7Yiq3OmaYO+MmExQUhkEDA2VI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 385/603] ASoC: intel: sof_sdw: Stop processing CODECs when enough are found
Date:   Wed, 15 Nov 2023 14:15:30 -0500
Message-ID: <20231115191639.917837419@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit 28809aaeabdf2c01ffe597553146527d1fba3589 ]

When adding CODECs to a DAI link, the code should stop processing more
CODECs when the expected number of CODECs are discovered. This fixes a
small corner case issue introduced when support for different devices
on the same SoundWire link was added. In the case of aggregated
devices everything is fine, as all devices intended for the DAI link
will be marked with the same group and any not intended for that DAI
are skipped by the group check. However for non-aggregated devices the
group check is bypassed and the current code does not stop after it
has found the first device. Meaning if additional non-aggregated devices
are present on the same SoundWire link they will be erroneously added
into the DAI link.

Fix this issue, and provide a small optimisation by ceasing to process
devices once we have reached the required number of devices for the
current DAI link.

Fixes: 317dcdecaf7a ("ASoC: intel: sof_sdw: Allow different devices on the same link")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20231019173411.166759-2-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_sdw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 842649501e303..47d22cab5af62 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -1374,7 +1374,7 @@ static int create_sdw_dailink(struct snd_soc_card *card, int *link_index,
 			continue;
 
 		/* j reset after loop, adr_index only applies to first link */
-		for (; j < adr_link_next->num_adr; j++) {
+		for (; j < adr_link_next->num_adr && codec_dlc_index < codec_num; j++) {
 			const struct snd_soc_acpi_endpoint *endpoints;
 
 			endpoints = adr_link_next->adr_d[j].endpoints;
-- 
2.42.0



