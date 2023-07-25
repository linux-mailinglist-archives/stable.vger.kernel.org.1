Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A03F76120C
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbjGYK66 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbjGYK6M (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:58:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A5219A1
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:55:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 377566165C
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:55:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ABEFC433C8;
        Tue, 25 Jul 2023 10:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282530;
        bh=tyVYMwMumKtaqlIMvtr5hfSYyjDLh+shq2qE6IxNkEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TAOwGifhQ3lMw4Kyv9XBdQecNDUBkYKaKJ7hIh6MeWHeLNC4STRdMb0HZbal0pEQ0
         R/y+t5q0FCaVMLq2Vm8XX7O4365//8gPDLuvVTUxklfp8utMXupZICxw13I0vFXeHk
         PMR9JVe9bInh3YRAo4re3eGPoKbjbfTqlnGgdJVk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 134/227] ASoC: amd: acp: fix for invalid dai id handling in acp_get_byte_count()
Date:   Tue, 25 Jul 2023 12:45:01 +0200
Message-ID: <20230725104520.400661628@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>

[ Upstream commit 85aeab362201cf52c34cd429e4f6c75a0b42f9a3 ]

For invalid dai id, instead of returning -EINVAL
return bytes count as zero in acp_get_byte_count() function.

Fixes: 623621a9f9e1 ("ASoC: amd: Add common framework to support I2S on ACP SOC")

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Link: https://lore.kernel.org/r/20230626105356.2580125-6-Vijendar.Mukunda@amd.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/acp/amd.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
index 5f2119f422715..12a176a50fd6e 100644
--- a/sound/soc/amd/acp/amd.h
+++ b/sound/soc/amd/acp/amd.h
@@ -173,7 +173,7 @@ int snd_amd_acp_find_config(struct pci_dev *pci);
 
 static inline u64 acp_get_byte_count(struct acp_dev_data *adata, int dai_id, int direction)
 {
-	u64 byte_count, low = 0, high = 0;
+	u64 byte_count = 0, low = 0, high = 0;
 
 	if (direction == SNDRV_PCM_STREAM_PLAYBACK) {
 		switch (dai_id) {
@@ -191,7 +191,7 @@ static inline u64 acp_get_byte_count(struct acp_dev_data *adata, int dai_id, int
 			break;
 		default:
 			dev_err(adata->dev, "Invalid dai id %x\n", dai_id);
-			return -EINVAL;
+			goto POINTER_RETURN_BYTES;
 		}
 	} else {
 		switch (dai_id) {
@@ -213,12 +213,13 @@ static inline u64 acp_get_byte_count(struct acp_dev_data *adata, int dai_id, int
 			break;
 		default:
 			dev_err(adata->dev, "Invalid dai id %x\n", dai_id);
-			return -EINVAL;
+			goto POINTER_RETURN_BYTES;
 		}
 	}
 	/* Get 64 bit value from two 32 bit registers */
 	byte_count = (high << 32) | low;
 
+POINTER_RETURN_BYTES:
 	return byte_count;
 }
 
-- 
2.39.2



