Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A672735243
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjFSKdE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjFSKcx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:32:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF28CA
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:32:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B26860B62
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:32:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42571C433C8;
        Mon, 19 Jun 2023 10:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687170771;
        bh=T+b1Mld9xi7m8dULwPfvheiEogr8e/MnWZp9YePKVo0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MaC/K1TK4hJQoTU301DyvllZULnXWMZDtJcWIQC7oHf4+oAOrOloHS9/xMmuqdj6J
         AYfhSCks5l/ry7LuCBEB0vquPFiuRByDJNlCPtYpHhqCE2bkh5JJvvQYSM6pIsQ0FF
         WXMj2ixcN6lfVqIlY5ND1/Dm3H4vsuJHTyhLTUNA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 029/187] ASoC: Intel: avs: Fix avs_path_module::instance_id size
Date:   Mon, 19 Jun 2023 12:27:27 +0200
Message-ID: <20230619102159.050962655@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

[ Upstream commit 320f4d868b83a804e3a4bd61a5b7d0f1db66380e ]

All IPCs using instance_id use 8 bit value. Original commit used 16 bit
value because FW reports possible max value in 16 bit field, but in
practice FW limits the value to 8 bits.

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Link: https://lore.kernel.org/r/20230519201711.4073845-7-amadeuszx.slawinski@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/avs/avs.h    | 4 ++--
 sound/soc/intel/avs/dsp.c    | 4 ++--
 sound/soc/intel/avs/path.h   | 2 +-
 sound/soc/intel/avs/probes.c | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/avs/avs.h b/sound/soc/intel/avs/avs.h
index d7fccdcb9c167..0cf38c9e768e7 100644
--- a/sound/soc/intel/avs/avs.h
+++ b/sound/soc/intel/avs/avs.h
@@ -283,8 +283,8 @@ void avs_release_firmwares(struct avs_dev *adev);
 
 int avs_dsp_init_module(struct avs_dev *adev, u16 module_id, u8 ppl_instance_id,
 			u8 core_id, u8 domain, void *param, u32 param_size,
-			u16 *instance_id);
-void avs_dsp_delete_module(struct avs_dev *adev, u16 module_id, u16 instance_id,
+			u8 *instance_id);
+void avs_dsp_delete_module(struct avs_dev *adev, u16 module_id, u8 instance_id,
 			   u8 ppl_instance_id, u8 core_id);
 int avs_dsp_create_pipeline(struct avs_dev *adev, u16 req_size, u8 priority,
 			    bool lp, u16 attributes, u8 *instance_id);
diff --git a/sound/soc/intel/avs/dsp.c b/sound/soc/intel/avs/dsp.c
index b881100d3e02a..aa03af4473e94 100644
--- a/sound/soc/intel/avs/dsp.c
+++ b/sound/soc/intel/avs/dsp.c
@@ -225,7 +225,7 @@ static int avs_dsp_put_core(struct avs_dev *adev, u32 core_id)
 
 int avs_dsp_init_module(struct avs_dev *adev, u16 module_id, u8 ppl_instance_id,
 			u8 core_id, u8 domain, void *param, u32 param_size,
-			u16 *instance_id)
+			u8 *instance_id)
 {
 	struct avs_module_entry mentry;
 	bool was_loaded = false;
@@ -272,7 +272,7 @@ int avs_dsp_init_module(struct avs_dev *adev, u16 module_id, u8 ppl_instance_id,
 	return ret;
 }
 
-void avs_dsp_delete_module(struct avs_dev *adev, u16 module_id, u16 instance_id,
+void avs_dsp_delete_module(struct avs_dev *adev, u16 module_id, u8 instance_id,
 			   u8 ppl_instance_id, u8 core_id)
 {
 	struct avs_module_entry mentry;
diff --git a/sound/soc/intel/avs/path.h b/sound/soc/intel/avs/path.h
index 197222c5e008e..657f7b093e805 100644
--- a/sound/soc/intel/avs/path.h
+++ b/sound/soc/intel/avs/path.h
@@ -37,7 +37,7 @@ struct avs_path_pipeline {
 
 struct avs_path_module {
 	u16 module_id;
-	u16 instance_id;
+	u8 instance_id;
 	union avs_gtw_attributes gtw_attrs;
 
 	struct avs_tplg_module *template;
diff --git a/sound/soc/intel/avs/probes.c b/sound/soc/intel/avs/probes.c
index 70a94201d6a56..275928281c6c6 100644
--- a/sound/soc/intel/avs/probes.c
+++ b/sound/soc/intel/avs/probes.c
@@ -18,7 +18,7 @@ static int avs_dsp_init_probe(struct avs_dev *adev, union avs_connector_node_id
 {
 	struct avs_probe_cfg cfg = {{0}};
 	struct avs_module_entry mentry;
-	u16 dummy;
+	u8 dummy;
 
 	avs_get_module_entry(adev, &AVS_PROBE_MOD_UUID, &mentry);
 
-- 
2.39.2



