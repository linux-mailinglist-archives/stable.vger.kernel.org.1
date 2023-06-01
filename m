Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67204719DE3
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbjFAN1V (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbjFAN1B (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:27:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878CFE61
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:26:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E158644AF
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:26:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6792BC4339B;
        Thu,  1 Jun 2023 13:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685626004;
        bh=LG7B1oCO9Dn7mgKIGuvh3TbyNKHDZlffefSauQdt7Nk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bp+2hQzhVAOp/VfACk07xBrwDf56kooUXIAxXqSrgmYBTkgqCdSP90BGLu/TWeTKo
         4DFuzG2uaxvw/iYwSXDNDkfpwvR2/XQxktHO1zv4t4wa9OL/9M5HfVVVatfW6/Weqb
         IihwW+9IUqdELw9qZ2ShV58ggm/kbFx3pOIHgMLQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 20/45] ASoC: Intel: avs: Fix module lookup
Date:   Thu,  1 Jun 2023 14:21:16 +0100
Message-Id: <20230601131939.636481325@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131938.702671708@linuxfoundation.org>
References: <20230601131938.702671708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

[ Upstream commit ff04437f6dcd138b50483afc7b313f016020ce8f ]

When changing value of kcontrol, FW module to which data should be send
needs to be found. Currently it is done in improper way, fix it. Change
function name to indicate that it looks only for volume module.

This allows to change volume during runtime, instead of only changing
init value.

Fixes: be2b81b519d7 ("ASoC: Intel: avs: Parse control tuples")
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Link: https://lore.kernel.org/r/20230519201711.4073845-2-amadeuszx.slawinski@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/avs/control.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/avs/control.c b/sound/soc/intel/avs/control.c
index a8b14b784f8a5..3dfa2e9816db0 100644
--- a/sound/soc/intel/avs/control.c
+++ b/sound/soc/intel/avs/control.c
@@ -21,17 +21,25 @@ static struct avs_dev *avs_get_kcontrol_adev(struct snd_kcontrol *kcontrol)
 	return to_avs_dev(w->dapm->component->dev);
 }
 
-static struct avs_path_module *avs_get_kcontrol_module(struct avs_dev *adev, u32 id)
+static struct avs_path_module *avs_get_volume_module(struct avs_dev *adev, u32 id)
 {
 	struct avs_path *path;
 	struct avs_path_pipeline *ppl;
 	struct avs_path_module *mod;
 
-	list_for_each_entry(path, &adev->path_list, node)
-		list_for_each_entry(ppl, &path->ppl_list, node)
-			list_for_each_entry(mod, &ppl->mod_list, node)
-				if (mod->template->ctl_id && mod->template->ctl_id == id)
+	spin_lock(&adev->path_list_lock);
+	list_for_each_entry(path, &adev->path_list, node) {
+		list_for_each_entry(ppl, &path->ppl_list, node) {
+			list_for_each_entry(mod, &ppl->mod_list, node) {
+				if (guid_equal(&mod->template->cfg_ext->type, &AVS_PEAKVOL_MOD_UUID)
+				    && mod->template->ctl_id == id) {
+					spin_unlock(&adev->path_list_lock);
 					return mod;
+				}
+			}
+		}
+	}
+	spin_unlock(&adev->path_list_lock);
 
 	return NULL;
 }
@@ -49,7 +57,7 @@ int avs_control_volume_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_va
 	/* prevent access to modules while path is being constructed */
 	mutex_lock(&adev->path_mutex);
 
-	active_module = avs_get_kcontrol_module(adev, ctl_data->id);
+	active_module = avs_get_volume_module(adev, ctl_data->id);
 	if (active_module) {
 		ret = avs_ipc_peakvol_get_volume(adev, active_module->module_id,
 						 active_module->instance_id, &dspvols,
@@ -89,7 +97,7 @@ int avs_control_volume_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_va
 		changed = 1;
 	}
 
-	active_module = avs_get_kcontrol_module(adev, ctl_data->id);
+	active_module = avs_get_volume_module(adev, ctl_data->id);
 	if (active_module) {
 		dspvol.channel_id = AVS_ALL_CHANNELS_MASK;
 		dspvol.target_volume = *volume;
-- 
2.39.2



