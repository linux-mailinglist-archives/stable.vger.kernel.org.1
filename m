Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7FC787304
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 16:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241951AbjHXO71 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 10:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241972AbjHXO7E (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 10:59:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5074EFD
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 07:59:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D972B67074
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 14:59:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7AFC433C8;
        Thu, 24 Aug 2023 14:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692889142;
        bh=/95trgNLD5oEzUw45aIgqB1VwvbzV0/9NRMutgUNXTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jw07bMEdMDan6NDbBlXfBA0bMhwVwY+TmXR+3ekBz679lBM9liS1quMDe+jYCavMC
         Jm3jLZEfQ0STYt6uTqQze9RnuzcqH7yK+wY3kNtreTKgXYfTwgccB8WCQzgi1hwqd+
         yWP+ol1ujwiVlErdxeKu5XiiqnjL5f8bgGX2K7LI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 009/135] ASoC: Intel: sof_sdw: add quirk for MTL RVP
Date:   Thu, 24 Aug 2023 16:49:12 +0200
Message-ID: <20230824145027.391534339@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145027.008282920@linuxfoundation.org>
References: <20230824145027.008282920@linuxfoundation.org>
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

From: Bard Liao <yung-chuan.liao@linux.intel.com>

[ Upstream commit 289e1df00e49a229a1c924c059242e759a552f01 ]

We should use RT711_JD2_100K for on board rt711.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com
Link: https://lore.kernel.org/r/20230512173305.65399-4-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_sdw.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index f5d8f7951cfc3..91a7cb33042d8 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -199,6 +199,14 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 					SOF_RT715_DAI_ID_FIX |
 					SOF_SDW_PCH_DMIC),
 	},
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Meteor Lake Client Platform"),
+		},
+		.driver_data = (void *)(RT711_JD2_100K),
+	},
 	{}
 };
 
-- 
2.40.1



