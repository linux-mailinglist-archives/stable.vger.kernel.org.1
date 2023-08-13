Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC4A77AC26
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjHMV3x (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbjHMV3x (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:29:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F8910DB
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:29:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D423F62AF2
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:29:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8C6C433C9;
        Sun, 13 Aug 2023 21:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962194;
        bh=BNpcSTeFlejTWiBgzBjgDBQ+4mfHzN5MMckoPZVmZxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AvHB3PciqoDj/KZFaExo+LW2uOzbjWlaLsxcEUTl57O4mevC5Dt2k0qVgNHlW7SBm
         2stbvN+XjzN0+JirH148BQ8Bj3ZxtWApucHFc8ODGVMuoik3PV6dWHCo2oEBtCwKYs
         rlDVTVsh9PQ+pZF5KM2ShokGv+sBAfuGhKxh3pIM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Petr Tesarik <petr.tesarik.ext@huawei.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 6.4 147/206] wifi: brcm80211: handle params_v1 allocation failure
Date:   Sun, 13 Aug 2023 23:18:37 +0200
Message-ID: <20230813211729.243430675@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Petr Tesarik <petr.tesarik.ext@huawei.com>

commit 07d698324110339b420deebab7a7805815340b4f upstream.

Return -ENOMEM from brcmf_run_escan() if kzalloc() fails for v1 params.

Fixes: 398ce273d6b1 ("wifi: brcmfmac: cfg80211: Add support for scan params v2")
Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
Link: https://lore.kernel.org/r/20230802163430.1656-1-petrtesarik@huaweicloud.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index de8a2e27f49c..2a90bb24ba77 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -1456,6 +1456,10 @@ brcmf_run_escan(struct brcmf_cfg80211_info *cfg, struct brcmf_if *ifp,
 		params_size -= BRCMF_SCAN_PARAMS_V2_FIXED_SIZE;
 		params_size += BRCMF_SCAN_PARAMS_FIXED_SIZE;
 		params_v1 = kzalloc(params_size, GFP_KERNEL);
+		if (!params_v1) {
+			err = -ENOMEM;
+			goto exit_params;
+		}
 		params_v1->version = cpu_to_le32(BRCMF_ESCAN_REQ_VERSION);
 		brcmf_scan_params_v2_to_v1(&params->params_v2_le, &params_v1->params_le);
 		kfree(params);
@@ -1473,6 +1477,7 @@ brcmf_run_escan(struct brcmf_cfg80211_info *cfg, struct brcmf_if *ifp,
 			bphy_err(drvr, "error (%d)\n", err);
 	}
 
+exit_params:
 	kfree(params);
 exit:
 	return err;
-- 
2.41.0



