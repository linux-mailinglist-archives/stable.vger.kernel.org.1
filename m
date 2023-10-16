Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994777CAB52
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbjJPOYp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjJPOYo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:24:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73FB9C
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:24:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0154DC433C8;
        Mon, 16 Oct 2023 14:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697466282;
        bh=fXg2AvPP9TtMPnyzyVSvkvccHVpVDmqDkRwM9ez17L0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mc3k78vKihQrs4iRnFy2SQjj1KRRbsLdF/KQOhKUSz4Bwqbmr7UP6N/6HYqWfwUWi
         24Mws7dTF8lOKfb1kmHI3q/lm5Ce9zmBXZUT1pLBmcQl4LhnjC/47hUCMbGVCgwN1l
         cTAlbYci01lo1UzjaTXpbcmj2COsbfd9fVBNMLuw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Matthias Reichl <hias@horus.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.5 020/191] ASoC: hdmi-codec: Fix broken channel map reporting
Date:   Mon, 16 Oct 2023 10:40:05 +0200
Message-ID: <20231016084015.873958228@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Reichl <hias@horus.com>

commit b84b53149476b22cc3b8677b771fb4cf06d1d455 upstream.

Commit 4e0871333661 ("ASoC: hdmi-codec: fix channel info for
compressed formats") accidentally changed hcp->chmap_idx from
ca_id, the CEA channel allocation ID, to idx, the index to
the table of channel mappings ordered by preference.

This resulted in wrong channel maps being reported to userspace,
eg for 5.1 "FL,FR,LFE,FC" was reported instead of the expected
"FL,FR,LFE,FC,RL,RR":

~ # speaker-test -c 6 -t sine
...
 0 - Front Left
 3 - Front Center
 1 - Front Right
 2 - LFE
 4 - Unknown
 5 - Unknown

~ # amixer cget iface=PCM,name='Playback Channel Map' | grep ': values'
  : values=3,4,8,7,0,0,0,0

Switch this back to ca_id in case of PCM audio so the correct channel
map is reported again and set it to HDMI_CODEC_CHMAP_IDX_UNKNOWN in
case of non-PCM audio so the PCM channel map control returns "Unknown"
channels (value 0).

Fixes: 4e0871333661 ("ASoC: hdmi-codec: fix channel info for compressed formats")
Cc: stable@vger.kernel.org
Signed-off-by: Matthias Reichl <hias@horus.com>
Link: https://lore.kernel.org/r/20230929195027.97136-1-hias@horus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/hdmi-codec.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -531,7 +531,10 @@ static int hdmi_codec_fill_codec_params(
 	hp->sample_rate = sample_rate;
 	hp->channels = channels;
 
-	hcp->chmap_idx = idx;
+	if (pcm_audio)
+		hcp->chmap_idx = ca_id;
+	else
+		hcp->chmap_idx = HDMI_CODEC_CHMAP_IDX_UNKNOWN;
 
 	return 0;
 }


