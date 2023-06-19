Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F04E735378
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjFSKqB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjFSKpj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:45:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB481BFC
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:45:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21C4A60B5E
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:45:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39CA1C433C8;
        Mon, 19 Jun 2023 10:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171506;
        bh=WMsEmoBN7Jqx8OgNmYtXkh6lIUqdZCMyiuLG4MgDS5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fW7BGgq1iqymTlZh+Wy9EMAgcVHt9lEwgW6G+YTKyYlW7G7zpXnnchVDK9zkaq/Hs
         jpa0IvrtKjj5n8ZKdgvOYD/rUfu+2PopeOtSW54If64tH8Zhlnwc5sQ4wcMtk334FY
         BrjFCevdDYCNAj7gtMfNg5xnkYD1ucS0Rz6G5cSw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 028/166] ASoC: Intel: avs: Account for UID of ACPI device
Date:   Mon, 19 Jun 2023 12:28:25 +0200
Message-ID: <20230619102156.144158930@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
References: <20230619102154.568541872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Cezary Rojewski <cezary.rojewski@intel.com>

[ Upstream commit 836855100b87b4dd7a82546131779dc255c18b67 ]

Configurations with multiple codecs attached to the platform are
supported but only if each from the set is different. Add new field
representing the 'Unique ID' so that codecs that share Vendor and Part
IDs can be differentiated and thus enabling support for such
configurations.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Link: https://lore.kernel.org/r/20230519201711.4073845-6-amadeuszx.slawinski@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/soc-acpi.h              | 1 +
 sound/soc/intel/avs/board_selection.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/sound/soc-acpi.h b/include/sound/soc-acpi.h
index b38fd25c57295..528279056b3ab 100644
--- a/include/sound/soc-acpi.h
+++ b/include/sound/soc-acpi.h
@@ -170,6 +170,7 @@ struct snd_soc_acpi_link_adr {
 /* Descriptor for SST ASoC machine driver */
 struct snd_soc_acpi_mach {
 	u8 id[ACPI_ID_LEN];
+	const char *uid;
 	const struct snd_soc_acpi_codecs *comp_ids;
 	const u32 link_mask;
 	const struct snd_soc_acpi_link_adr *links;
diff --git a/sound/soc/intel/avs/board_selection.c b/sound/soc/intel/avs/board_selection.c
index 87f9c18be238d..87353b4b0cd73 100644
--- a/sound/soc/intel/avs/board_selection.c
+++ b/sound/soc/intel/avs/board_selection.c
@@ -394,7 +394,7 @@ static int avs_register_i2s_boards(struct avs_dev *adev)
 	}
 
 	for (mach = boards->machs; mach->id[0]; mach++) {
-		if (!acpi_dev_present(mach->id, NULL, -1))
+		if (!acpi_dev_present(mach->id, mach->uid, -1))
 			continue;
 
 		if (mach->machine_quirk)
-- 
2.39.2



