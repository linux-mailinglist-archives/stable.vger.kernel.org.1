Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626117A7F06
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235686AbjITMXI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235681AbjITMXH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:23:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9411CA
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:23:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E79C433C9;
        Wed, 20 Sep 2023 12:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212581;
        bh=jPNUywYirS1I2lr2XEvXpKjPcSimCaQUgMa0rLBJL/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NiTWxQfzgBfoRYOYPW4dmY1mWeuU4zvNZWHdGTofIiVmSf4mMZDLoVSR3cOef5PIS
         WB9AEliIdn130CzkSpcUHdQywE+p3UMyMAHCIHioutbiMRI9xD39QDYnitu0j4+riM
         Zo9UXIEQMPr9VHJCR9v6RCYNsoNXyKh15emkTsN4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 28/83] ALSA: hda: intel-dsp-cfg: add LunarLake support
Date:   Wed, 20 Sep 2023 13:31:18 +0200
Message-ID: <20230920112827.790355688@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112826.634178162@linuxfoundation.org>
References: <20230920112826.634178162@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit d2852b8c045ebd31d753b06f2810df5be30ed56a ]

One more PCI ID for the road.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://lore.kernel.org/r/20230802150105.24604-5-pierre-louis.bossart@linux.intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/intel-dsp-config.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index f96e70c85f84a..801c89a3a1b6f 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -368,6 +368,14 @@ static const struct config_entry config_table[] = {
 	},
 #endif
 
+/* Lunar Lake */
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_LUNARLAKE)
+	/* Lunarlake-P */
+	{
+		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
+		.device = PCI_DEVICE_ID_INTEL_HDA_LNL_P,
+	},
+#endif
 };
 
 static const struct config_entry *snd_intel_dsp_find_config
-- 
2.40.1



