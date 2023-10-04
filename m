Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505CE7B895A
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244166AbjJDSZJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244167AbjJDSZI (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:25:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793F0BF
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:25:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9818C433C7;
        Wed,  4 Oct 2023 18:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443905;
        bh=4CGfpQ+jXTF9xdAgEY6BsPJ1AOdPG3hlE2oq30dxhbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FrdI3pODwcsKXMunxGaWK6NIZKNvO6YAiNz2d1HEDnLy/FBwYytId7y4wBRlWBJ1t
         Bar5p5M7F30OCpKiE0gzeVgNnCzWiy2n2xC7d9nCm6MmcXMzxsF9l0vQ5+LpRrDKRA
         0T4vAtSrU4DMPm6b1l8sH3Kz/l1p8XDr+TBX/PEA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 054/321] ALSA: seq: ump: Fix -Wformat-truncation warning
Date:   Wed,  4 Oct 2023 19:53:19 +0200
Message-ID: <20231004175231.669029989@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 0d42260867f9ff3e3a5bcfa8750fa06a658e0b1c ]

The filling of a port name string got a warning with W=1 due to the
potentially too long group name.  Add the string precision to limit
the size.

Fixes: 81fd444aa371 ("ALSA: seq: Bind UMP device")
Link: https://lore.kernel.org/r/20230915082802.28684-2-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/seq/seq_ump_client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/seq/seq_ump_client.c b/sound/core/seq/seq_ump_client.c
index a60e3f069a80f..2db371d79930d 100644
--- a/sound/core/seq/seq_ump_client.c
+++ b/sound/core/seq/seq_ump_client.c
@@ -207,7 +207,7 @@ static void fill_port_info(struct snd_seq_port_info *port,
 		SNDRV_SEQ_PORT_TYPE_PORT;
 	port->midi_channels = 16;
 	if (*group->name)
-		snprintf(port->name, sizeof(port->name), "Group %d (%s)",
+		snprintf(port->name, sizeof(port->name), "Group %d (%.53s)",
 			 group->group + 1, group->name);
 	else
 		sprintf(port->name, "Group %d", group->group + 1);
-- 
2.40.1



