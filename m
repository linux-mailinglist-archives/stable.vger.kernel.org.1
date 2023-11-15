Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDB57ECEFB
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbjKOTpc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbjKOTpa (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:45:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B81B9
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:45:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DAFBC433C8;
        Wed, 15 Nov 2023 19:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077527;
        bh=MjJME/eE70tV1lCSpWJcPiY0JVWjG6Vdre3pHtlvur0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VAnv7uFQBiro08GR58dlncg3K4bJYcS9feZeYylQLPvppf3v/NP1fo0ibdGxdMak5
         3MC0+DjOkc9nBWqkqfVOppphY3J+BsFMTIyg5SZ2oNGEjFlIY4hSaScdh7tvyUamyP
         iAk98vTy98bNxfKQkv32680DTnhoW7oPtEegodvc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 358/603] ASoC: SOF: ipc4-topology: Use size_add() in call to struct_size()
Date:   Wed, 15 Nov 2023 14:15:03 -0500
Message-ID: <20231115191638.303364115@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <gustavoars@kernel.org>

[ Upstream commit 3746284c233d5cf5f456400e61cd4a46a69c6e8c ]

If, for any reason, the open-coded arithmetic causes a wraparound,
the protection that `struct_size()` adds against potential integer
overflows is defeated. Fix this by hardening call to `struct_size()`
with `size_add()`.

Fixes: f9efae954905 ("ASoC: SOF: ipc4-topology: Add support for base config extension")
Signed-off-by: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/ZQSr15AYJpDpipg6@work
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/ipc4-topology.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 7cb63e6b24dc9..c9c1d2ec7af25 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -895,7 +895,8 @@ static int sof_ipc4_widget_setup_comp_process(struct snd_sof_widget *swidget)
 	if (process->init_config == SOF_IPC4_MODULE_INIT_CONFIG_TYPE_BASE_CFG_WITH_EXT) {
 		struct sof_ipc4_base_module_cfg_ext *base_cfg_ext;
 		u32 ext_size = struct_size(base_cfg_ext, pin_formats,
-						swidget->num_input_pins + swidget->num_output_pins);
+					   size_add(swidget->num_input_pins,
+						    swidget->num_output_pins));
 
 		base_cfg_ext = kzalloc(ext_size, GFP_KERNEL);
 		if (!base_cfg_ext) {
-- 
2.42.0



