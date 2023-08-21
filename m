Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD777783143
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 21:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjHUTu5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjHUTu5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:50:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAA310E
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:50:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97A0F643FD
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9DEC433C7;
        Mon, 21 Aug 2023 19:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647449;
        bh=ezPT2xcro5Lo8lNgQu93MlHviJYnG50lNA6t0wEv3oM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O7oxobbx8bRZZejf+gujTgDOSY1vuXJmJLha7ht2DdLZ/2l36oMg2xLm0gjpqrP60
         RdZPDvnTDYKL6UHcYfdfDrTSv7Z44A3h6lsup7zNRJxieuHYDv1t7UbNNr3OnNqocr
         FDGSh5l+tComQWDNneyTfk6YfOlt/Qcp8ytaoOvc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 018/194] ASoC: SOF: amd: Add pci revision id check
Date:   Mon, 21 Aug 2023 21:39:57 +0200
Message-ID: <20230821194123.580544295@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
References: <20230821194122.695845670@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>

[ Upstream commit 1d4a84632b90d88316986b05bcdfe715399a33db ]

Add pci revision id check for renoir and rembrandt platforms.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Link: https://lore.kernel.org/r/20230523072009.2379198-1-venkataprasad.potturu@amd.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/amd/acp.h     | 3 +++
 sound/soc/sof/amd/pci-rmb.c | 3 +++
 sound/soc/sof/amd/pci-rn.c  | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index dd3c072d01721..14148c311f504 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -54,6 +54,9 @@
 
 #define ACP_DSP_TO_HOST_IRQ			0x04
 
+#define ACP_RN_PCI_ID				0x01
+#define ACP_RMB_PCI_ID				0x6F
+
 #define HOST_BRIDGE_CZN				0x1630
 #define HOST_BRIDGE_RMB				0x14B5
 #define ACP_SHA_STAT				0x8000
diff --git a/sound/soc/sof/amd/pci-rmb.c b/sound/soc/sof/amd/pci-rmb.c
index 4e1de462b431b..5698d910b26f3 100644
--- a/sound/soc/sof/amd/pci-rmb.c
+++ b/sound/soc/sof/amd/pci-rmb.c
@@ -90,6 +90,9 @@ static int acp_pci_rmb_probe(struct pci_dev *pci, const struct pci_device_id *pc
 	unsigned int flag, i, addr;
 	int ret;
 
+	if (pci->revision != ACP_RMB_PCI_ID)
+		return -ENODEV;
+
 	flag = snd_amd_acp_find_config(pci);
 	if (flag != FLAG_AMD_SOF && flag != FLAG_AMD_SOF_ONLY_DMIC)
 		return -ENODEV;
diff --git a/sound/soc/sof/amd/pci-rn.c b/sound/soc/sof/amd/pci-rn.c
index fca40b261671b..9189f63632789 100644
--- a/sound/soc/sof/amd/pci-rn.c
+++ b/sound/soc/sof/amd/pci-rn.c
@@ -90,6 +90,9 @@ static int acp_pci_rn_probe(struct pci_dev *pci, const struct pci_device_id *pci
 	unsigned int flag, i, addr;
 	int ret;
 
+	if (pci->revision != ACP_RN_PCI_ID)
+		return -ENODEV;
+
 	flag = snd_amd_acp_find_config(pci);
 	if (flag != FLAG_AMD_SOF && flag != FLAG_AMD_SOF_ONLY_DMIC)
 		return -ENODEV;
-- 
2.40.1



